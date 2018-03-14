CREATE OR REPLACE VIEW VW_ZHC_FACTOR AS
WITH tmp_constant AS
 (SELECT constant_cd, constant_nm, constant_type
    FROM lkp_constant
   WHERE isdel = 0
   GROUP BY constant_cd, constant_nm, constant_type)
SELECT c.company_id AS company_id, --企业标识符
       --t.l AS rulerating_factor1, --客户风险分层
       rf1.constant_nm AS rulerating_factor1, --客户风险分层
       --t.m AS rulerating_factor2, --最低十级分类
       rf2.constant_nm AS rulerating_factor2, --最低十级分类
       --t.y
       rf3.constant_nm AS rulerating_factor3, --所属集团客户风险分层
       rf4.constant_nm AS rulerating_factor4, --客户评级结果代码
       CASE
         WHEN t.j = 1 THEN
          '是'
         WHEN t.j = 0 THEN
          '否'
         ELSE
          to_char(t.j)
       END AS rulerating_factor5, --是否高风险类名单
       t.t AS rulerating_factor6, --额度敞口金额
       CASE
         WHEN t.k = 1 THEN
          '是'
         WHEN t.k = 0 THEN
          '否'
         ELSE
          to_char(t.k)
       END AS rulerating_factor7, --授信额度连续三个月下降
       CASE
         WHEN t.p = 1 THEN
          '是'
         WHEN t.p = 0 THEN
          '否'
         ELSE
          to_char(t.p)
       END AS rulerating_factor8, --过去六个月内是否有授信审批被否决
       t.x AS rulerating_factor9, --对外担保额度/所有者权益
       t.y AS rulerating_factor10, --非正常类对外担保额度/所有者权益
       CASE
         WHEN t.q = 1 THEN
          '是'
         WHEN t.q = 0 THEN
          '否'
         ELSE
          to_char(t.q)
       END AS rulerating_factor11, --过去1年是否有央行征信中的不良记录
       CASE
         WHEN t.r = 1 THEN
          '是'
         WHEN t.r = 0 THEN
          '否'
         ELSE
          to_char(t.r)
       END AS rulerating_factor12, --过去1年是否有央行征信中的关注类记录
       t.u AS rulerating_factor13, --存贷比
       t.m AS rulerating_factor14, --担保圈
       t.v AS rulerating_factor15, --结算账户近6个月月均余额
       t.w AS rulerating_factor16, --客户过去一年月末存款余额发生大额增加的次数
       t.n AS rulerating_factor17, --客户过去一年月末存款余额发生大额增加的次数分组
       decode(t.o, 'Y', '是', 'N', '否', t.o) AS rulerating_factor18, --过去一年有无逾期记录Y有逾期N无逾期
       t.f AS rulerating_factor19, --外部评级
       t.d AS rulerating_factor20, --基础评级
       t.s AS rulerating_factor21,  --最低交易价格面值比
       t.updt_dt AS updt_dt --所有指标的最新更新时间 max(updt_dt)
  FROM zhc_rule_factor t
  JOIN customer_cmb c
    ON t.a = c.cust_no
  LEFT JOIN tmp_constant rf4
    ON (to_char(t.g) = rf4.constant_cd AND
       rf4.constant_type = 28)
  LEFT JOIN tmp_constant rf1
    ON (t.h  = rf1.constant_cd AND rf1.constant_type = 7)
  LEFT JOIN tmp_constant rf2
    ON (t.i = rf2.constant_cd AND rf2.constant_type = 8)
  LEFT JOIN tmp_constant rf3
    ON (t.l = rf3.constant_cd AND rf3.constant_type = 8)
;
