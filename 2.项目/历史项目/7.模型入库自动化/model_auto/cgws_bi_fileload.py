# -*- coding: utf-8
# @version time  :
# v0.1: 2017/9/13 inital version
# v0.2: 2017/10/20
# v0.3: 2017/11/20 improve script performance
# @Author: yf
import xlrd
import codecs
import sys
import cx_Oracle
import os
from datetime import date,datetime

filepath = "/data/dev/"
#abs_path=os.path.abspath("..")
#filepath=abs_path+'/data/'
#logfile=abs_path+'/scriptlog/PY_'+datetime.now().strftime('%Y%m%d')+'.dat'
#logwriter=open(logfile, "w")

def file_import(filename):
    table_sheet = {'债券': 'STG_GWS_BOND_PORTFOLIO',
                   '两融': 'STG_GWS_MARGIN_TRADING',
                   '股票质押及交易对手': 'STG_GWS_STOCK_PLEDGE',
                   '担保品': 'STG_GWS_COLLATERAL',
                   '非标和ABS': 'STG_GWS_NONSTANDARD_ABS'}
    table_SEQENCE = {'债券': 'SEQ_STG_GWS_BOND_PORTFOLIO',
                     '两融': 'SEQ_STG_GWS_MARGIN_TRADING',
                     '股票质押及交易对手': 'SEQ_STG_GWS_STOCK_PLEDGE',
                     '担保品': 'SEQ_STG_GWS_COLLATERAL',
                     '非标和ABS': 'SEQ_STG_GWS_NONSTANDARD_ABS'}
    workbook = xlrd.open_workbook(filename)
    now = datetime.now()
    updt_dt = now.strftime("%Y-%m-%d %H:%M:%S")
    sql = '''INSERT INTO {table_name}  SELECT {seq_table_name}.nextval, {value_format} ,{null_str},to_date('{updt_dt}','yyyy-mm-dd hh24:mi:ss'), null from dual'''
    for sheet_name in workbook.sheet_names():
        cnt = 0
        print("---处理 {sheet_name}---".format(sheet_name=sheet_name))
        sheet = workbook.sheet_by_name(sheet_name)
        rows = sheet.nrows#行数
        cols = sheet.ncols#列数
        value_format = ",".join([":"+str(elem) for elem in range(1,cols+1)])#某一行的值
        table_content = []
        #tmp_filename = os.path.basename(filename)
        s1 = filename.split('_')[1]#从文件名中取持仓日期
        s2 = s1[0:4] + '-' + s1[4:6] + '-' + s1[6:8]#时间串
        if sheet_name.strip() == '净资本':
            row = sheet.row_values(0)
            net_value = ''
            for value in row[0:]:
                net_value = net_value + '\'' + str(value) + '\'' + ','
                net_value = net_value.rstrip(',')
            now = datetime.now()
            load_dt = now.strftime("%Y-%m-%d %H:%M:%S")
            sql_a = 'insert into NETCAPITAL select ' + net_value + ','+'to_date('+'\''+s2+'\''+','+'\''+'yyyy-mm-dd'+'\''+')'+','+'0,'+'0,'+'to_date('+'\''+load_dt+'\''+','+'\''+'yyyy-mm-dd hh24:mi:ss'+'\''+')' + ' from dual'
            cursor.execute(sql_a)
        else:
            print('processing table ' + table_sheet[sheet_name] + ' start inserting')
            for i in range(rows):
                if i > 0:
                    #continue
                    table_content.append(tuple([cell_value_format(sheet.cell(i, j), workbook.datemode) for j in range(cols)]))
                    cnt = cnt + 1
            try:
                cursor.executemany(sql.format(value_format=value_format,table_name = table_sheet[sheet_name],seq_table_name = table_SEQENCE[sheet_name],updt_dt=updt_dt,null_str = ",".join(["''" for elem in range(10)])), table_content)
            except Exception as e:
                print(e)
                logwriter.close()
                sys.exit(-1)
            print(table_sheet[sheet_name] + ' insert completed, total insert cnt is ' + str(cnt))
            sql_upd = 'update  ' + table_sheet[sheet_name] + ' set loadlog_sid = (select max(nvl(loadlog_sid,0)) from etl_stg_loadlog where process_nm='+'\''+sheet_name+'\''+') where position_dt = \''+ s2 + '\' AND LOADLOG_SID IS NULL'
            #sql_upd = 'update  ' + table_sheet[sheet_name] + ' set loadlog_sid = 1223 where position_dt = \'' + s2 + '\' AND LOADLOG_SID IS NULL'
            print(sql_upd)
            cursor.execute(sql_upd)

            now=datetime.now()
            end_dt=now.strftime("%Y-%m-%d %H:%M:%S")
            sql1 = 'insert into etl_stg_loadlog select seq_etl_stg_loadlog.nextval,'+'\''+sheet_name+'\''+','+'\''+sheet_name+'\''+',null'+','+'\''+str(cnt)+'\''+','+'\''+str(cnt)+'\''+','+'to_date('+'\''+start_dt+'\''+','+'\''+'yyyy-mm-dd hh24:mi:ss'+'\''+')'+','+'to_date('+'\''+end_dt+'\''+','+'\''+'yyyy-mm-dd hh24:mi:ss'+'\''+')'+' from dual '
            cursor.execute(sql1)

def cell_value_format(cell,work_book_datemode):
    if cell.ctype == 3:
        date_value = xlrd.xldate.xldate_as_datetime(cell.value, 0)
        date_tmp = date_value.strftime("%Y-%m-%d")
        return date_tmp
    if cell.ctype == 2:
        return str(int(cell.value))
    else:
        return cell.value


# def is_run_status():
#     try:
#         sys.exit(0)
#     except:
#         sys.exit(1)


if __name__ == "__main__":

        os.environ['PGCLIENTENCODING'] = "utf8"
        sys.stdout = codecs.getwriter("utf-8")(sys.stdout.detach())
        now = datetime.now()
        start_dt = now.strftime("%Y-%m-%d %H:%M:%S")

        db = cx_Oracle.connect('cs_master_cgws_bi1/abc123@10.100.47.10:1521/orcl', encoding="UTF-8", nencoding="UTF-8")
        print('EXPERT PROD DB connected' + db.version)
        cursor = db.cursor()
        filetype = ('xlsx', 'xls')
        for parent, dirnames, filenames in os.walk(filepath):
            if parent == filepath:
                for filename in filenames:
                    if filename.endswith(filetype):
                        print("Processing " + filename)
                        file_import(filepath + filename)

        db.commit()
        cursor.close()