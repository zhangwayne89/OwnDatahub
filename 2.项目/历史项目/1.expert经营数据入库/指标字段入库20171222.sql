------------------------------------------指标字段定义入库
--先更新exposure, client_exposure
select * from client_exposure;

truncate table TMP_ELEMENT;
truncate table TMP_FACTOR;
truncate table TMP_FACTOR_ELEMENT;
truncate table TMP_FACTOR_OPTION;

call SP_FACTOR_ELEMENT_DEFINITION();

select * from FACTOR where to_char(updt_dt,'yyyymmdd')='20171222'; 
select * from client_factor where client_id=2 and to_char(updt_dt,'yyyymmdd')='20171222'; 
select * from ELEMENT  where to_char(updt_dt,'yyyymmdd')='20171222'; 
select * from client_element where client_id=2 and to_char(updt_dt,'yyyymmdd')='20171222'; 

select * from EXPOSURE_FACTOR_XW where to_char(updt_dt,'yyyymmdd')='20171222'; 
select * from client_exposure_factor where client_id=2 and to_char(updt_dt,'yyyymmdd')='20171222'; 

select * from FACTOR_ELEMENT_XW where to_char(updt_dt,'yyyymmdd')='20171222'; 
select * from client_factor_element where client_id=2 and to_char(updt_dt,'yyyymmdd')='20171222';  

select * from FACTOR_OPTION where client_id=2 and to_char(updt_dt,'yyyymmdd')='20171222'; 
select * from client_factor_option where client_id=2 and to_char(client_factor_option.updt_dt,'yyyymmdd')='20171222';
--select * from client_factor where client_id=2 and factor_cd in ('factor_516','factor_527','factor_533');  
--UPDATE FACTOR_OPTION SET ISDEL=1 ,updt_dt=sysdate where client_id=2 and factor_cd in ('factor_516','factor_527','factor_533'); 逻辑删除的updt_dt也要更新成最新的，不然同步不到MDS
select * from FACTOR_OPTION where client_id=2 and factor_cd in ('factor_516','factor_527','factor_533'); 
select a.* from client_factor_option a join factor_option b on a.factor_option_sid=b.factor_option_sid where b.client_id=2 and b.factor_cd in ('factor_516','factor_527','factor_533');

-------------------------------------指标字段数据入库
--生产不需要清空临时表
select * from client_basicinfo;
truncate table   temp_compy_factor_gather;
truncate table   temp_compy_element;
truncate table   temp_compy_gather_record; 

select * from compy_factor_gather where client_id=2 and to_char(updt_dt,'yyyymmdd')='20171222' and factor_cd in ('factor_516','factor_527','factor_533'); 
select * from compy_element where client_id=2 and to_char(updt_dt,'yyyymmdd')='20171222'; 
select * from compy_gather_record where client_id=2 and to_char(updt_dt,'yyyymmdd')='20171222';  