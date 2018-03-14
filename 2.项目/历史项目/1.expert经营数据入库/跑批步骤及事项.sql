--跑批数据准备
--step1:清除主体和债券评级信息
truncate table bond_rating_record;
truncate table bond_rating_detail;
truncate table bond_rating_factor;
truncate table bond_rating_xw;
truncate table bond_rating_approv;
truncate table bond_rating_display;

truncate table rating_record;
truncate table rating_detail;
truncate table rating_display;
truncate table rating_factor;
truncate table rating_approv;
truncate table rating_adjustment_reason;
truncate table rating_record_log;


--step2：插入有经营数据+敞口信息的主体清单
truncate table compy_rating_list;
insert into 
compy_rating_list
select seq_compy_rating_list.nextval,
a.company_id,
b.company_nm,
c.exposure_sid,
null,
c.rpt_dt
from compy_exposure a 
left join compy_basicinfo b on a.company_id = b.company_id 
join (select distinct company_id,rpt_dt,exposure_sid from compy_factor_operation) c on a.exposure_sid = c.exposure_sid and a.company_id = c.company_id;

--step3:启用PostMan
-- http://10.100.199.100:3030/v2/ratings/compyratinglist?refreshFactors=1&ratingType=2
--(视环境修改API地址)
	--1、参数 refreshFactors =1 表示重新计算所有入模指标并更新数据库；refreshFactors =0 表示跳过指标计算，直接从数据库中已有的指标获取数据；
	--2、ratingType=2 表示 对主体进行基础评级和机器认定评级；ratingType=0 表示 对主体进行基础评级.
--rating type= 012,基础评级参考评级认定评级（user_id -1为机评，else为人工评级）
--step4:创建需人工更改的评级记录表
create table nicky_rating_record_update
as
select a.*,b.rating_record_id
from rating_record_manual a 
join rating_record b on a.company_id = b.company_id 
and a.exposure_sid = b.exposure_sid 
and to_date(cast(a.factor_dt as varchar(200)),'YYYYMMDD') = b.factor_dt
where b.rating_type=2;

--step5:更新需人工更改的评级记录的adjustment_comment
update rating_record a set adjustment_comment= (select b.adjustment_comment from nicky_rating_record_update b where a.rating_record_id = b.rating_record_id)
where a.rating_record_id in (select rating_record_id from nicky_rating_record_update);

--step6:更新需人工更改的评级记录的final_rating
update rating_record a set final_rating= (select b.final_rating from nicky_rating_record_update b where a.rating_record_id = b.rating_record_id)
where a.rating_record_id in (select rating_record_id from nicky_rating_record_update);

--step7:机器认定更新为人工认定状态
update rating_record set user_id = 0 where rating_type=2;

--step8：清除债项基础评级和认定评级，二次刷新评级信息和报告
truncate table bond_rating_record;
truncate table bond_rating_detail;
truncate table bond_rating_factor;
truncate table bond_rating_xw;
truncate table bond_rating_approv;
truncate table bond_rating_display;

--step9:将债券机器认定改为人工认定评级
update bond_rating_record set updt_by = 0 where rating_type=2;











