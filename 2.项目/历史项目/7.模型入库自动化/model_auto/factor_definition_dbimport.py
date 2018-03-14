# -*- coding: utf-8
#@version time  :
#v0.1: 2017/7/6 inital version
#@Author: xielinping
import xlrd
import codecs
import sys
import cx_Oracle
import os
import os.path

filepath="/data/dev/income/expert/"

def file_import(filename):
    workbook = xlrd.open_workbook(filename)
    for sheet_name in workbook.sheet_names():
        sheet = workbook.sheet_by_name(sheet_name)
        rowcnt = sheet.nrows
        if sheet_name != '说明(入库时此tab无需提供）':
            print('processing table tmp_' + sheet_name + ', start inserting')
            cnt = 0
            for i in range(rowcnt):
                if i >= 1:
                    row = sheet.row_values(i)
                    s = ''
                    for value in row[0:]:
                        s = s + '\'' + str(value) + '\'' + ','
                    s = s.rstrip(',')
                    sql = 'insert into tmp_' + sheet_name + ' select ' + s + ' from dual'
                    cursor.execute(sql)
                    cnt = cnt + 1
            print('table tmp_' + sheet_name + ' insert completed, total insert cnt is ' + str(cnt))

if __name__ == "__main__":
    sys.stdout = codecs.getwriter("utf-8")(sys.stdout.detach())
    db=cx_Oracle.connect('expert_v2/abc123@10.100.47.10:1521/ORCL')
    print ('EXPERT PROD DB connected'+db.version)
    cursor=db.cursor()
    filetype=('xlsx','xls')
	
    for parent, dirnames, filenames in os.walk(filepath):
        if parent==filepath:
                for filename in filenames:		     
                    if filename.endswith(filetype):
                        print("Processing: "+filename)
                        file_import(filepath+filename)
    
    db.commit()
    cursor.close()