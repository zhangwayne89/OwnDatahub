CREATE OR REPLACE VIEW VW_RATING_RULE_FACTOR AS
WITH tmp_creditrating_cmb AS --行内评级
 (SELECT company_id, final_rating, updt_dt
    FROM (SELECT company_id,
                 final_rating,
                 nvl(updt_dt, SYSDATE - 365) AS updt_dt,
                 row_number() over(PARTITION BY company_id ORDER BY effect_end_dt DESC, rating_no DESC) AS rn
            FROM compy_creditrating_cmb
           WHERE isdel = 0)
   WHERE rn = 1),
tmp_creditrating AS --行外评级
 (SELECT company_id, rating, nvl(updt_dt, SYSDATE - 365) AS updt_dt
    FROM (SELECT company_id,
                 rating,
                 updt_dt,
                 row_number() over(PARTITION BY company_id ORDER BY rating_dt DESC, notice_dt DESC, compy_creditrating_sid DESC) AS rn
            FROM compy_creditrating
           WHERE nvl(credit_org_id, 0) NOT IN
                 (SELECT company_id
                    FROM compy_basicinfo
                   WHERE company_nm IN ('中债资信评估有限责任公司', '中国证监会')))
   WHERE rn = 1),
tmp_constant AS
 (SELECT constant_cd, constant_nm, constant_type
    FROM lkp_constant
   WHERE isdel = 0
   GROUP BY constant_cd, constant_nm, constant_type),
tmp_rating_record AS
 (SELECT company_id,
         scaled_rating,
         nvl(updt_dt, SYSDATE - 365) AS updt_dt,
         row_number() over(PARTITION BY company_id ORDER BY updt_dt DESC) AS rnk
    FROM rating_record
   WHERE rating_type = 0),
tmp_rulefactor AS
 (SELECT company_id,
         nvl(updt_dt, SYSDATE - 365) AS updt_dt,
         rulerating_factor6,
         rulerating_factor7,
         rulerating_factor8,
         rulerating_factor9,
         rulerating_factor10,
         rulerating_factor11,
         rulerating_factor12
    FROM (SELECT company_id,
                 factor_cd,
                 factor_value,
                 MAX(updt_dt) over(PARTITION BY company_id) AS updt_dt
            FROM compy_rulefactor_cmb
           WHERE isdel = 0)
  pivot(MAX(factor_value)
     FOR factor_cd IN('RULERATING_FACTOR6' AS rulerating_factor6,
                     'RULERATING_FACTOR7' AS rulerating_factor7,
                     'RULERATING_FACTOR8' AS rulerating_factor8,
                     'RULERATING_FACTOR9' AS rulerating_factor9,
                     'RULERATING_FACTOR10' AS rulerating_factor10,
                     'RULERATING_FACTOR11' AS rulerating_factor11,
                     'RULERATING_FACTOR12' AS rulerating_factor12)))
SELECT cust.company_id          AS company_id, --企业标识符
       cust.risk_status_cd      AS rulerating_factor1, --客户风险分层
       cust.class_grade_cd      AS rulerating_factor2, --最低十级分类
       cust.group_warnstatus_cd AS rulerating_factor3, --所属集团客户风险分层
       --tmp_creditrating_cmb.final_rating AS rulerating_factor4, --客户评级结果代码
       kp.constant_nm AS rulerating_factor4, --客户评级结果代码
       CASE
         WHEN cust.is_high_risk = 1 THEN
          '是'
         WHEN cust.is_high_risk = 0 THEN
          '否'
         ELSE
          NULL
       END AS rulerating_factor5, --是否高风险类名单
       tmp_rulefactor.rulerating_factor6 AS rulerating_factor6, --额度敞口金额/所有者权益
       CASE
         WHEN tmp_rulefactor.rulerating_factor7 = 1 THEN
          '是'
         WHEN tmp_rulefactor.rulerating_factor7 = 0 THEN
          '否'
         ELSE
          NULL
       END AS rulerating_factor7, --授信额度连续三个月下降
       CASE
         WHEN tmp_rulefactor.rulerating_factor8 = 1 THEN
          '是'
         WHEN tmp_rulefactor.rulerating_factor8 = 0 THEN
          '否'
         ELSE
          NULL
       END AS rulerating_factor8, --过去六个月内是否有授信审批被否决
       tmp_rulefactor.rulerating_factor9 AS rulerating_factor9, --对外担保额度/所有者权益
       tmp_rulefactor.rulerating_factor10 AS rulerating_factor10, --非正常类对外担保额度/所有者权益
       CASE
         WHEN tmp_rulefactor.rulerating_factor11 = 1 THEN
          '是'
         WHEN tmp_rulefactor.rulerating_factor11 = 0 THEN
          '否'
         ELSE
          NULL
       END AS rulerating_factor11, --过去1年是否有央行征信中的不良记录
       CASE
         WHEN tmp_rulefactor.rulerating_factor12 = 1 THEN
          '是'
         WHEN tmp_rulefactor.rulerating_factor12 = 0 THEN
          '否'
         ELSE
          NULL
       END AS rulerating_factor12, --过去1年是否有央行征信中的关注类记录
       ortb.loan_deposit_ratio AS rulerating_factor13, --存贷比
       ortb.gur_group AS rulerating_factor14, --担保圈
       ortb.balance_sixmon AS rulerating_factor15, --结算账户近6个月月均余额
       ortb.bal_1y_uptimes AS rulerating_factor16, --客户过去一年月末存款余额发生大额增加的次数
       ortb.bal_1y_uptimes_group AS rulerating_factor17, --客户过去一年月末存款余额发生大额增加的次数分组
       decode(ortb.overdue_12m, 'Y', '是', 'N', '否', NULL) AS rulerating_factor18, --过去一年有无逾期记录Y有逾期N无逾期
       tmp_creditrating.rating AS rulerating_factor19, --外部评级
       rtr.scaled_rating AS rulerating_factor20, --基础评级
       greatest(nvl(cust.updt_dt, SYSDATE - 365),
                tmp_creditrating_cmb.updt_dt,
                tmp_creditrating.updt_dt,
                nvl(rtr.updt_dt, SYSDATE - 365),
                nvl(ortb.updt_dt, SYSDATE - 365),
                tmp_rulefactor.updt_dt) AS updt_dt --所有指标的最新更新时间 max(updt_dt)
  FROM customer_cmb cust
  LEFT JOIN tmp_creditrating_cmb
    ON (cust.company_id = tmp_creditrating_cmb.company_id)
  LEFT JOIN tmp_creditrating
    ON (cust.company_id = tmp_creditrating.company_id)
  LEFT JOIN tmp_rating_record rtr
    ON (cust.company_id = rtr.company_id AND rtr.rnk = 1)
  LEFT JOIN compy_operationclear_cmb ortb
    ON (cust.company_id = ortb.company_id AND ortb.isdel = 0)
  LEFT JOIN tmp_constant kp
    ON (to_char(tmp_creditrating_cmb.final_rating) = kp.constant_cd AND
       kp.constant_type = 28)
  LEFT JOIN tmp_rulefactor
    ON (cust.company_id = tmp_rulefactor.company_id)
    ORDER BY cust.company_id
