# -*- coding: UTF-8 -*-
import codecs
import decimal
import os.path
import sys

import cx_Oracle
import win32com.client
import xlrd
import xlsxwriter


class operate_oracle:
    def NumbersAsDecimal(cursor, name, defaultType, size, precision, scale):
        if defaultType == cx_Oracle.NUMBER:
            return cursor.var(str, 100, cursor.arraysize, outconverter=decimal.Decimal)

    def NumbersAsString(cursor, name, defaultType, size, precision, scale):
        if defaultType == cx_Oracle.NUMBER:
            return cursor.var(str, 100, cursor.arraysize)
        if defaultType == cx_Oracle.DATETIME:
            return cursor.var(str, 100, cursor.arraysize)

    def get_ora_sql_res(in_cursor, in_sql, in_type=None):
        v_cursor = in_cursor
        v_sql = in_sql
        v_type = in_type
        if v_type is None:
            v_type = ''
        if v_type.lower() == 'number':
            v_cursor.outputtypehandler = operate_oracle.NumbersAsDecimal
        else:
            v_cursor.outputtypehandler = operate_oracle.NumbersAsString
        v_cursor.execute(v_sql)
        v_data_list = v_cursor.fetchall()
        v_data_col_name = [i[0] for i in v_cursor.description]
        v_data_col_type = [i[1] for i in v_cursor.description]
        return v_data_col_name, v_data_list, v_data_col_type

    # 读取Excel数据插入数据库相应表中
    # 参数：db-数据库连接 cursor-连接 file-文件名  by_sheet_name-当前sheet页名称   by_table_name-对应数据库表名
    def load_full_data_to_oracle(db='',cursor='',in_data = [], by_table_name=''):
        cols = len(in_data[0])
        value_format = ",".join([":" + str(elem) for elem in range(1, cols + 1)])  # 标记当前每一列数据
        table_content = in_data
        cnt = 0  # 自增加变量
        # 定义插入sql
        sql = 'INSERT INTO {table_name} values( {value_format} )'
        # 批量插入所有行记录
        #print(sql.format(value_format=value_format, table_name=by_table_name), table_content)
        cursor.executemany(sql.format(value_format=value_format, table_name=by_table_name),table_content)
        print("成功插入数据库的记录数为: %d" % cursor.rowcount)
        # 每次插入完成后进行提交
        db.commit()


class operate_file:
    # 定义打开Excel的函数
    def open_excel(in_excel_name='file.xlsx'):
        try:
            v_workbook_data = xlrd.open_workbook(in_excel_name)
            return v_workbook_data
        except Exception as e:
            print(str(e))

    # 定义格式处理函数，处理日期
    def cell_value_format(cell):
        if cell.ctype == 0:  # 空0
            return ''
        elif cell.ctype == 1:  # 字符串1
            return cell.value
        elif cell.ctype == 2 and cell.value % 1 == 0:  # 如果是整形
            return str(int(cell.value))
        elif cell.ctype == 2:
            return str(cell.value)
        elif cell.ctype == 3:  # 日期格式就读取日期
            return xlrd.xldate.xldate_as_datetime(cell.value, 0)
        else:
            return str(cell.value)

    def read_excel_by_name(in_excel_name='file.xlsx', in_sheet_name=u'Sheet1'):
        workbook = operate_file.open_excel(in_excel_name)  # 打开excel文件
        worksheet = workbook.sheet_by_name(in_sheet_name)  # 打开当前sheet
        v_nrows = worksheet.nrows  # 获取table工作表总行数
        v_ncols = worksheet.ncols  # 获取table工作表总列数
        v_excel_data = []  # 定义一个列表记录每一行数据
        # 读取每一行一列的数据，把每行数据插入table_content列表中
        for i in range(v_nrows):
            if i > 0:
                v_excel_data.append(
                    tuple([operate_file.cell_value_format(worksheet.cell(i, j)) for j in range(v_ncols)]))
        return v_excel_data

    def read_excel_by_index(in_excel_name='file.xlsx', in_sheet_nunber=0):
        workbook = operate_file.open_excel(in_excel_name)  # 打开excel文件
        worksheet = workbook.sheet_by_index(in_sheet_nunber)  # 打开当前sheet
        v_nrows = worksheet.nrows  # 获取table工作表总行数
        v_ncols = worksheet.ncols  # 获取table工作表总列数
        v_excel_data = []  # 定义一个列表记录每一行数据
        # 读取每一行一列的数据，把每行数据插入table_content列表中
        for i in range(v_nrows):
            if i > 0:
                v_excel_data.append(
                    tuple([operate_file.cell_value_format(worksheet.cell(i, j)) for j in range(v_ncols)]))
        return v_excel_data

    # python调用excel宏
    def excel_macro(in_excel_file, in_vba_name):
        try:
            xlApp = win32com.client.DispatchEx('Excel.Application')
            xlsPath = os.path.expanduser(in_excel_file)
            wb = xlApp.Workbooks.Open(Filename=xlsPath)
            xlApp.Run(in_vba_name)
            wb.Save()
            xlApp.Quit()
            print("Macro run successfully!")
        except:
            print("Error found while running the excel macro!")
            xlApp.Quit()

    def oracle_write_to_excel_vba(in_cursor, in_sql, in_filename, in_sheet_name='sheet1', in_number_string='string',in_vba_file=None, in_vba_name=None):
        # 读取sql结果
        v_data_col_name, v_data_list, v_data_col_type = operate_oracle.get_ora_sql_res(in_cursor, in_sql,in_number_string)
        # 定义excel属性
        if in_vba_file is not None:
            in_filename = in_filename.split('.')[0] + '.xlsm'
        else:
            in_filename = in_filename.split('.')[0] + '.xlsx'
        workbook = xlsxwriter.Workbook(in_filename, {'constant_memory': True})
        worksheet = workbook.add_worksheet(in_sheet_name)
        # Add the VBA project binary.
        if in_vba_file is not None:
            workbook.add_vba_project(in_vba_file)
        # 定义数据格式
        date_format = workbook.add_format({'num_format': 'yyyy/mm/dd'})
        datetime_format = workbook.add_format({'num_format': 'yyyy/mm/dd hh:mm:ss'})
        int_format = workbook.add_format({'num_format': '#####################0'})
        number_format = workbook.add_format({'num_format': '#####################0.####################'})
        center_format = workbook.add_format()
        center_format.set_align('center')
        center_format.set_align('vcenter')
        # 设置列格式
        v_coltype = []
        if len(v_data_list)  > 0:
            v_colnum = max(len(v_data_col_name), len(v_data_col_type), len(v_data_list[0]))
            for i in range(v_colnum):
                v_coltype.append(None)
                if v_data_col_type[i] == cx_Oracle.NUMBER:
                    v_coltype[i] = number_format
                elif v_data_col_type[i] == cx_Oracle.DATETIME:
                    v_coltype[i] = datetime_format
                elif v_data_col_type[i] == cx_Oracle.TIMESTAMP:
                    v_coltype[i] = datetime_format
        # 如果无标题头则正文从excel第一行开始写，有标题头则写标题头，正文从第二行开始写
        v_data_start_row = 0
        if len(v_data_col_name) > 0:
            v_data_start_row = 1
            worksheet.write_row(0, 0, v_data_col_name, center_format)
        # 写excel内容
        for v_row, v_rowdata in enumerate(v_data_list):
            if v_row >= 0:
                for v_col, v_val in enumerate(v_rowdata):
                    worksheet.write(v_row + v_data_start_row, v_col, v_val, v_coltype[v_col])
        print(in_filename, '已保存！')
        workbook.close()
        if in_vba_file is not None and in_vba_name is not None:
            operate_file.excel_macro(in_filename, in_vba_name)

def model_compare(db,v_cursor,excel_name = None,work_path=None):
    try:
        result_file_dir = os.path.join(work_path, 'result_files')  # 定义待执行清单路径
        if not os.path.exists(result_file_dir):
            os.makedirs(result_file_dir)
        exposure_list = operate_oracle.get_ora_sql_res(v_cursor, 'select exposure from exposure')[1]
        for expos in exposure_list:
            if expos[0] in excel_name:
                v_exposure_name = expos[0]
        exc_res = operate_file.read_excel_by_index(excel_name, 0)  # 列表(元组)
        v_exc_data = exc_res[1:]
        l_gd_col = ['key', 'company_id', 'company_nm', 'rpt_dt', 'modelscore', 'qnmodelscore', 'qlmodelscore','qlmodelscore_orig']
        l_col_name = []
        v_pivot_sql = ''
        v_sqlpar_1 = ''
        v_sqlpar_2 = ''
        v_vba_file = os.path.join(work_path, 'flag_diff_data.bin')
        v_vba_name = 'flag_diff_data'
        cur_model_file = '%s_模型验证结果.xlsm' % v_exposure_name
        v_model_file = os.path.join(result_file_dir, cur_model_file)

        for i in range(0, len(exc_res[0])):
            if exc_res[0][i] not in l_col_name:
                l_col_name.append(exc_res[0][i])
                if exc_res[0][i].lower() in l_gd_col:
                    v_sqlpar_1 = v_sqlpar_1 + exc_res[0][i] + ','
                else:
                    v_sqlpar_1 = v_sqlpar_1 + exc_res[0][i] + '_val,'
                    v_sqlpar_2 = v_sqlpar_2 + exc_res[0][i] + '_val,'
                    v_pivot_sql = v_pivot_sql + "'%s' as %s," % (exc_res[0][i], exc_res[0][i])
            else:
                v_sqlpar_1 = v_sqlpar_1 + exc_res[0][i] + '_sco,'
                v_sqlpar_2 = v_sqlpar_2 + exc_res[0][i] + '_sco,'

        v_sqlpar_1 = v_sqlpar_1.strip(',')
        v_pivot_sql = v_pivot_sql.strip(',')
        v_create_view_sql = '''create or replace view vw_zmd_cmp_model_test AS 
                  SELECT %s
                    FROM (
                    WITH factor_score_val AS
                     (SELECT *
                        FROM (SELECT t.rating_record_id,
                                     rmf.ft_code,
                                     t.score,
                                     CASE
                                       WHEN f.factor_type = '规模' AND f.factor_property_cd = 0 AND
                                            instr(lower(f.factor_cd),'size') > 0 THEN
                                        exp(t.factor_val)
                                       ELSE
                                        t.factor_val
                                     END AS factor_val
                                FROM rating_factor t
                                JOIN rating_model_factor rmf
                                  ON t.rm_factor_id = rmf.id
                                JOIN factor f
                                  ON rmf.ft_code = f.factor_cd) mid
                      pivot(MAX(factor_val) AS val, MAX(score) AS sco
                         FOR ft_code IN(%s))),
                         model_score AS
                     (SELECT rating_record_id, qn_score, qn_orig_score, qi_score, qi_orig_score
                        FROM (SELECT t.rating_record_id, NAME, score, new_score
                                FROM rating_detail t
                                JOIN rating_model_sub_model rms
                                  ON t.rating_model_sub_model_id = rms.id) mid
                      pivot(MAX(score) AS orig_score, MAX(new_score) AS score
                         FOR NAME IN('财务分析' AS qn, '非财务分析' AS qi)))
                    SELECT cbf.company_nm AS key,
                           r.company_id,
                           cbf.company_nm,
                           r.factor_dt    AS rpt_dt,
                           r.total_score             AS modelscore,
                           model_score.qn_score      AS qnmodelscore,
                           model_score.qi_score      AS qlmodelscore,
                           model_score.qi_orig_score AS qlmodelscore_orig,
                           %s
                           row_number() over(PARTITION BY cbf.company_id ORDER BY r.updt_dt DESC) AS rn
                      FROM rating_record r
                      JOIN compy_basicinfo cbf
                        ON r.company_id = cbf.company_id
                       AND cbf.is_del = 0
                      JOIN compy_exposure ce
                        ON cbf.company_id = ce.company_id
                       AND ce.is_new = 1
                       AND ce.isdel = 0
                      JOIN exposure e
                        ON ce.exposure_sid = e.exposure_sid
                       AND e.exposure = '%s'
                       AND e.isdel = 0
                      JOIN factor_score_val
                        ON r.rating_record_id = factor_score_val.rating_record_id
                      JOIN model_score
                        ON r.rating_record_id = model_score.rating_record_id)
                WHERE rn = 1''' % (v_sqlpar_1, v_pivot_sql, v_sqlpar_2, v_exposure_name)
        v_cursor.execute(v_create_view_sql)
        v_create_table_sql = 'create table zmd_cmp_model_test as select * from vw_zmd_cmp_model_test where 1=2'
        v_cursor.execute(v_create_table_sql)
        operate_oracle.load_full_data_to_oracle(db, v_cursor, v_exc_data, 'zmd_cmp_model_test')

        v_compare_sql = """ WITH tmp AS
                         (SELECT t.company_nm, t.company_id, t.modelscore, v.modelscore
                            FROM zmd_cmp_model_test t
                            JOIN vw_zmd_cmp_model_test v
                              ON (t.company_id = v.company_id AND
                                 abs(nvl(v.modelscore, 0) - t.modelscore) > 0.0001))
                        SELECT *
                          FROM (SELECT 'execel' AS src, a.*
                                  FROM zmd_cmp_model_test a, tmp
                                 WHERE a.company_id = tmp.company_id
                                UNION ALL
                                SELECT 'system' AS src, b.*
                                  FROM vw_zmd_cmp_model_test b, tmp
                                 WHERE b.company_id = tmp.company_id)
                         ORDER BY company_id, src"""


        operate_file.oracle_write_to_excel_vba(v_cursor, v_compare_sql, v_model_file, "sheet1", 'string', v_vba_file,v_vba_name)
        total_num = int(operate_oracle.get_ora_sql_res(v_cursor,'select count(*) from zmd_cmp_model_test')[1][0][0])
        failed_num = int(operate_oracle.get_ora_sql_res(v_cursor, 'select count(*) from (%s)' % v_compare_sql)[1][0][0])
    except Exception as e:
        print(str(e))
    finally:
        v_cursor.execute('drop table zmd_cmp_model_test')
        v_cursor.execute('drop view vw_zmd_cmp_model_test')
    return v_exposure_name,total_num,failed_num


if __name__ == '__main__':
    os.environ['PGCLIENTENCODING'] = "utf8"
    sys.stdout = codecs.getwriter("utf-8")(sys.stdout.detach())
    work_path = os.path.dirname(os.path.realpath(__file__))  # 从当前文件路径中获取目录
    model_file_dir = os.path.join(work_path, 'model_files')  # 定义待执行清单路径
    cal_file_name = os.path.join(work_path, '模型验证结果统计.xlsx')  # 定义待执行清单路径

    print(model_file_dir)
    if os.path.exists(model_file_dir):
        filetype = ('xlsx', 'xls')  # 定义文件格式
        files_num = 0  # 定义文件个数
        row_data = []
        with cx_Oracle.connect('cmap_app/abc123@10.100.45.29:1521/orcl', encoding='utf8', nencoding='utf8') as db:
            try:
                v_cursor = db.cursor()
                # 遍历目录下的Excel文件并入库
                for parent, dirnames, filenames in os.walk(model_file_dir):
                    if parent == model_file_dir:
                        for file_name in filenames:
                            if file_name.endswith(filetype) and not file_name.startswith('~$'):
                                print('----------------------------------------------')
                                print("正在处理的Excel文件为: " + file_name)
                                files_num += 1
                                model_file = os.path.join(model_file_dir, file_name)
                                v_exposure_name,v_total_num,v_failed_num = model_compare(db, v_cursor, model_file, work_path)
                                row_data.append((v_exposure_name,str(v_total_num),str(v_failed_num),str(round(100*(v_total_num-v_failed_num)/v_total_num,2))+'%'))

                if row_data[0] is not None:
                    workbook = xlsxwriter.Workbook(cal_file_name, {'constant_memory': True})
                    worksheet = workbook.add_worksheet('sheet1')
                    row_name = ['敞口名称', '验证总数', '失败数量', '通过率']
                    worksheet.write_row(0, 0, row_name)
                    for i in range(len(row_data)):
                        worksheet.write_row(i+1, 0, row_data[i])
                    workbook.close()

            except Exception as e:
                print(str(e))
            finally:
                v_cursor.close()
    else:
        os.makedirs(model_file_dir)
        print('模型文件目录不存在，已重新创建！', model_file_dir)
