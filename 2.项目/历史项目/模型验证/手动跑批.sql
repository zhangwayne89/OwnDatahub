--备份
CREATE TABLE zhc2_bond_rating_record AS 
SELECT * from bond_rating_record;
CREATE TABLE zhc2_bond_rating_detail AS 
SELECT * from bond_rating_detail;
CREATE TABLE zhc2_bond_rating_factor AS 
SELECT * from bond_rating_factor;
CREATE TABLE zhc2_bond_rating_xw AS 
SELECT * from bond_rating_xw;
CREATE TABLE zhc2_bond_rating_approv AS 
SELECT * from bond_rating_approv;
CREATE TABLE zhc2_bond_rating_display AS 
SELECT * from bond_rating_display;
CREATE TABLE zhc2_rating_record AS 
SELECT * from rating_record;
CREATE TABLE zhc2_rating_detail AS 
SELECT * from rating_detail;
CREATE TABLE zhc2_rating_display AS 
SELECT * from rating_display;
CREATE TABLE zhc2_rating_factor AS 
SELECT * from rating_factor;
CREATE TABLE zhc2_rating_approv AS 
SELECT * from rating_approv;
CREATE TABLE zhc2_rating_adjustment_reason AS 
SELECT * from rating_adjustment_reason;
CREATE TABLE zhc2_rating_record_log AS 
SELECT * from rating_record_log;
--清空系统所有评级的表
DELETE FROM bond_rating_record;
DELETE FROM bond_rating_detail;
DELETE FROM bond_rating_factor;
DELETE FROM bond_rating_xw;
DELETE FROM bond_rating_approv;
DELETE FROM bond_rating_display;
DELETE FROM rating_record;
DELETE FROM rating_detail;
DELETE FROM rating_display;
DELETE FROM rating_factor;
DELETE FROM rating_approv;
DELETE FROM rating_adjustment_reason;
DELETE FROM rating_record_log;

--1.备份list表
CREATE TABLE zhc_compy_rating_list AS
SELECT * FROM compy_rating_list t WHERE t.compy_rating_list_sid > 36574;
-----------------------------------------------------

SELECT a.company_id,
       b.company_nm,
       c.exposure_sid,
       NULL,
       c.rpt_dt
  FROM (SELECT DISTINCT a.company_id, a.exposure_sid
          FROM compy_exposure a
          JOIN exposure b
            ON a.exposure_sid = b.exposure_sid
           AND b.exposure IN ('融资平台')
         WHERE a.is_new = 1
           AND a.isdel = 0) a
  JOIN compy_basicinfo b
    ON (a.company_id = b.company_id)
  JOIN (SELECT DISTINCT company_id, rpt_dt, exposure_sid
          FROM compy_factor_operation) c
    ON (a.exposure_sid = c.exposure_sid AND a.company_id = c.company_id)
  JOIN compy_rating_list l ON a.company_id = l.company_id
 WHERE c.rpt_dt = DATE '2016-12-31'
   AND NOT EXISTS (SELECT 1
          FROM rating_record rd
         WHERE a.company_id = rd.company_id
           AND a.exposure_sid = rd.exposure_sid);


--3.插入可以跑批的company和exposure
--2.清空初始表
SELECT * FROM exposure;
TRUNCATE TABLE compy_rating_list;

INSERT INTO compy_rating_list
SELECT seq_compy_rating_list.nextval,
       a.company_id,
       b.company_nm,
       c.exposure_sid,
       NULL,
       c.rpt_dt
  FROM (SELECT DISTINCT a.company_id, a.exposure_sid
          FROM compy_exposure a
          JOIN exposure b
            ON a.exposure_sid = b.exposure_sid
           AND b.exposure IN ('房地产')
         WHERE a.is_new = 1
           AND a.isdel = 0) a
  JOIN compy_basicinfo b
    ON (a.company_id = b.company_id)
  JOIN (SELECT DISTINCT company_id, rpt_dt, exposure_sid
          FROM compy_factor_operation) c
    ON (a.exposure_sid = c.exposure_sid AND a.company_id = c.company_id)
 WHERE c.rpt_dt = DATE '2016-12-31'
   AND NOT EXISTS (SELECT 1
          FROM rating_record rd
         WHERE a.company_id = rd.company_id
           AND a.exposure_sid = rd.exposure_sid);
 

SELECT COUNT(*)
  FROM compy_rating_list t;

--1.查看记录
SELECT * FROM compy_rating_list;
DELETE FROM compy_rating_list t WHERE t.compy_rating_list_sid = -1;

--2.查是否有过评级
SELECT t.company_nm,s.*
  FROM compy_rating_list t
  JOIN rating_record s
    ON t.company_id = s.company_id
    AND t.company_id <> 0
    AND s.updt_dt > TRUNC(SYSDATE);
    
SELECT * FROM rating_record t;
DELETE FROM rating_record t WHERE t.company_id = 0;

--3.查看评级报错的日志
SELECT s.exposure, t.error_desc, t.*
  FROM rating_record_log t
  LEFT JOIN compy_exposure ce
    ON t.company_id = ce.company_id
    AND ce.is_new = 1 AND ce.isdel = 0 
  JOIN exposure s
    ON ce.exposure_sid = s.exposure_sid
 WHERE t.isfailed = 1
   AND t.updt_dt > SYSDATE - 1
   AND t.company_id IN (SELECT company_id FROM compy_rating_list )
 ORDER BY t.updt_dt DESC;
 
--4.是否重新计算出来了指标记录
--经营数据;

SELECT t.*
  FROM compy_factor_operation t
  JOIN compy_rating_list r
    ON t.company_id = r.company_id
 WHERE t.updt_dt > SYSDATE - 1/24;
--财务数据
SELECT t.*
  FROM compy_factor_finance t
  JOIN compy_rating_list r
    ON t.company_id = r.company_id
   WHERE t.updt_dt > SYSDATE - 1/24
   AND t.factor_cd = 'Profitability3';
