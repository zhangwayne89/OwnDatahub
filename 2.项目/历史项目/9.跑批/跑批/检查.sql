--1.指标定义
SELECT * FROM factor t WHERE t.factor_cd LIKE '%&factor_cd%';
SELECT es.exposure,
       cep.exposure_sid,
       cep.company_id,
       f.factor_cd,
       f.factor_nm,
       t.option_num,
       t.formula_en,
       f.formula_en AS cal_formula,
       f.factor_type,
       f.unit,
       f.factor_category_cd,
       f.factor_property_cd
  FROM factor f
  JOIN factor_option t
    ON f.factor_cd = t.factor_cd
   AND f.isdel = 0
  JOIN compy_exposure cep
    ON (t.exposure_sid = cep.exposure_sid AND
       cep.company_id LIKE '%&company_id%')
  JOIN exposure es
    ON (t.exposure_sid = es.exposure_sid)
 WHERE t.factor_cd LIKE '%&factor_cd%'
   AND t.isdel = 0
 ORDER BY es.exposure_sid, t.factor_cd, t.option_num;

--2.如果是财务类的公式，则查看底层科目值是否存在，不存在自然无法计算
SELECT a.company_id, accept_deposit, loan_advances
  FROM compy_finance a
  LEFT JOIN compy_finance_last_y b
    ON a.company_id = b.company_id_last_y
   AND a.rpt_dt = b.rpt_dt_last_y
   AND a.rpt_timetype_cd = b.rpt_timetype_cd_last_y
  LEFT JOIN compy_finance_bf_last_y c
    ON a.company_id = c.company_id_bf_last_y
   AND a.rpt_dt = c.rpt_dt_bf_last_y
   AND a.rpt_timetype_cd = c.rpt_timetype_cd_bf_last_y
 WHERE a.rpt_dt = to_date('20161231', 'yyyymmdd')
   AND a.company_id IN (SELECT company_id FROM compy_rating_list);

--3.如果是element公式，则查看对应的公式及字段值

SELECT * FROM exposure_factor_xw t WHERE t.factor_cd = 'Profitability6';
SELECT t.factor_cd,
       t.factor_nm,
       t.factor_type,
       t.formula_en,
       t.updt_by,
       t.updt_dt,
       t.factor_property_cd
  FROM factor t
 WHERE t.factor_cd = 'Profitability3';

SELECT e.element_nm, t.*
  FROM compy_element t
  JOIN element e
    ON t.element_cd = e.element_cd
 WHERE t.rpt_dt = to_date('20161231', 'yyyymmdd')
   AND t.element_cd IN ('element_1040', 'element_0340')
   AND t.company_id = '39770';
