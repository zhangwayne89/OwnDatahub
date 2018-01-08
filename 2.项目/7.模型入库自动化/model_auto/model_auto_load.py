# -*- coding: utf-8 -*-
# Author: ZhangCong
# Date: 2017-01-05
# Desc: 招银资管模型自动化入库
# Args: 1.是否真实执行模型数据入库 'Y' or 'N'
# Run: python3  model_auto_load.py  'N'
# dir desc：
# newfiles  --存放模型数据Excel文件
# hisfiles  --存放执行成功的历史Excel文件
# model_auto_load.py --脚本
# condition: Excel模板中字段与数据库临时表字段顺序一致


import codecs
import datetime
import os
import shutil
import sys
import cx_Oracle
import xlrd

# 定义打开Excel的函数
def open_excel(file='file.xls'):
    try:
        data = xlrd.open_workbook(file)
        return data
    except Exception as e:
        print(str(e))


# 定义格式处理函数，处理日期
def cell_value_format(cell, work_book_datemode):
    if cell.ctype == 3:
        date_value = xlrd.xldate.xldate_as_datetime(cell.value, 0)
        #date_tmp = date_value.strftime('%Y/%m/%d')
        return date_value
    elif cell.ctype == 2:
        return str(int(cell.value))
    else:
        return cell.value


# 读取Excel数据插入数据库相应表中
# 参数：db-数据库连接 cursor-连接 file-文件名  by_sheet_name-当前sheet页名称   by_table_name-对应数据库表名
def excel_byname(db='', cursor='', file='file.xls', by_sheet_name=u'Sheet1', by_table_name=''):
    workbook = open_excel(file)  # 打开excel文件
    sheet = workbook.sheet_by_name(by_sheet_name)  # 打开当前sheet
    rows = sheet.nrows  # 统计当前sheet的总行数
    cols = sheet.ncols  # 统计当前sheet的总列数
    value_format = ",".join([":" + str(elem) for elem in range(1, cols + 1)])  # 标记当前每一列数据
    table_content = []  # 定义一个列表记录每一行数据
    cnt = 0  # 自增加变量

    # 读取每一行一列的数据，把每行数据插入table_content列表中
    for i in range(rows):
        if i > 0:
            table_content.append(tuple([cell_value_format(sheet.cell(i, j), workbook.datemode) for j in range(cols)]))
            cnt = cnt + 1

    # 定义插入sql
    sql = 'INSERT INTO {table_name} values( {value_format} )'

    # 批量插入所有行记录
    #print(sql.format(value_format=value_format, table_name=by_table_name),table_content)
    cursor.executemany(
        sql.format(value_format=value_format, table_name=by_table_name),
        table_content)

    print("成功插入的记录数: %d" % cursor.rowcount)

    # 每次插入完成后进行提交
    db.commit()


def main():
    os.environ['PGCLIENTENCODING'] = "utf8"
    sys.stdout = codecs.getwriter("utf-8")(sys.stdout.detach())
    if len(sys.argv) == 2:
        v_running = sys.argv[1]  # 定义是否执行插入操作
    error_msg_num = 0  # 定义数据检查返回的错误记录数
    work_path = os.path.dirname(os.path.realpath(__file__))  # 从当前文件路径中获取目录
    newfile_dir = os.path.join(work_path, 'newfiles')  # 定义待执行清单路径
    hisfile_dir = os.path.join(work_path, 'hisfiles')  # 定义历史清单路径
    filetype = ('xlsx', 'xls')  # 定义文件格式
    files_num = 0  # 定义文件个数

    if not os.path.exists(newfile_dir):
        os.makedirs(newfile_dir)
    if not os.path.exists(hisfile_dir):
        os.makedirs(hisfile_dir)

    dict_sheet = {'模型(rating_model)': 'ZLD_RATING_MODEL',
                  '子模型(rating_model_sub_model)': 'ZLD_RATING_MODEL_SUB_MODEL',
                  '模型敞口(rating_model_exposure_xw)': 'ZLD_RATING_MODEL_EXPOSURE_XW',
                  '校准参数(rating_calc_pd_ref)': 'ZLD_RATING_CALC_PD_REF',
                  '模型指标(rating_model_factor)': 'ZLD_RATING_MODEL_FACTOR'}

    # 连接数据库
    with cx_Oracle.connect('cs_master_tgt', 'abc123', '10.100.45.10:1521/orcl', encoding='utf8',nencoding='utf8') as db:
        try:
            cursor = db.cursor()
            print('Current DB connected' + db.version)

            # 清空临时表
            print('----------------------------------------------')
            print('正在清空临时表')
            for del_table_name in dict_sheet.values():
                cursor.execute('TRUNCATE TABLE ' + del_table_name)
            print('清空临时表已完成')

            # 遍历目录下的Excel文件并入库
            for parent, dirnames, filenames in os.walk(newfile_dir):
                if parent == newfile_dir:
                    for file_name in filenames:
                        if file_name.endswith(filetype) and not file_name.startswith('~$'):
                            print('----------------------------------------------')
                            print("正在处理的Excel文件为: " + file_name)
                            files_num += 1
                            model_file = os.path.join(newfile_dir, file_name)
                            for sheet_name in dict_sheet:
                                print('正在处理的sheet页为:' + sheet_name)
                                excel_byname(db, cursor, model_file, sheet_name, dict_sheet[sheet_name])
                            print('\n----------------------------------------------')

            if files_num > 0:
                v_call_dt = datetime.datetime.now()
                if v_running != 'Y':
                    v_running = 'N'
                v_error_msg = cursor.var(cx_Oracle.CURSOR)  # 出参
                print('是否插入正式表：', v_running)
                l_result = cursor.callproc('sp_zld_rating_model_import',[v_call_dt, v_running, v_error_msg])

                for err_msg in l_result[-1]:
                    if error_msg_num == 0:
						print('\n错误数据为:')
                    print(err_msg)
                    error_msg_num += 1
                if error_msg_num > 0 and v_running == 'Y':
                    print('\n结果：存在错误，拒绝插入正式表，请修复！')
                elif error_msg_num == 0 and v_running == 'Y':
                    print('\n结果：数据已导入临时表,插入正式表成功！')
                else:
                    print('\n结果：数据已导入临时表,不插入正式表！')

                if error_msg_num == 0 and v_running == 'Y':
                    for parent, dirnames, filenames in os.walk(newfile_dir):
                        if parent == newfile_dir:
                            for file_name in filenames:
                                if file_name.endswith(filetype) and not file_name.startswith('~$'):
                                    model_file = os.path.join(newfile_dir, file_name)
                                    hisfile = os.path.join(hisfile_dir, file_name)
                                    if os.path.exists(hisfile):
                                        os.remove(hisfile)
                                    shutil.move(model_file, hisfile_dir)

            else:
                print('----------------------------------------------')
                print('newfiles下没有excel文件！')

        except Exception as e:
            print(str(e))
        finally:
            cursor.close()


if __name__ == "__main__":
    main()
