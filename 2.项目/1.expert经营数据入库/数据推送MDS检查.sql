select subscribe_table,stg_table,subscribe_filter from vw_subscribe_table where subscribe_id=2;
select * from client_exposure ;--vw_client_basicinfo_gzs;
select * from vw_exposure where  client_id=2 and to_char(updt_dt,'yyyymmdd')='20171205'; 
select * from vw_exposure_factor_xw where client_id=2 and to_char(updt_dt,'yyyymmdd')='20171205'; 
select * from vw_factor  where  client_id=2 and to_char(updt_dt,'yyyymmdd')='20171205'; 
select * from vw_factor_option where client_id=2 and factor_cd in ('factor_516','factor_527','factor_533'); 
---逻辑删除的updt_dt也要更新成最新的，不然同步不到MDS
---先同步那些要删除的数据，再新增数据，然后再同步一次
select * from vw_element where  client_id=2 and to_char(updt_dt,'yyyymmdd')='20171205';   
select * from vw_factor_element_xw where  client_id=2 and to_char(updt_dt,'yyyymmdd')='20171205';  

select * from vw_compy_element where client_id=2 and to_char(updt_dt,'yyyymmdd')='20171205'; 
select * from vw_compy_exposure where client_id=2 and to_char(updt_dt,'yyyymmdd')='20171205'; 
select * from vw_compy_factor_operation where client_id=2 and to_char(updt_dt,'yyyymmdd')='20171205'; 

select b.exposure,a.* from vw_exposure_factor_xw a join client_exposure b on a.exposure_sid=b.exposure_sid 
where a.client_id=2 and to_char(a.updt_dt,'yyyymmdd')='20171205';
select b.exposure,count(distinct a.factor_cd)  from vw_factor_option a join client_exposure b on a.exposure_sid=b.exposure_sid 
where a.client_id=2 and to_char(a.updt_dt,'yyyymmdd')='20171205' group by b.exposure; 
select b.exposure,count(distinct a.company_id) from vw_compy_factor_operation a join client_exposure b on a.exposure_sid=b.exposure_sid 
where a.client_id=2 and to_char(a.updt_dt,'yyyymmdd')='20171205' group by b.exposure; 
