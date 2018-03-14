--1.整体分析
SELECT l.company_id,
        l.company_nm,
        s.exposure,
        rms.name,
        t.factor_cd,
        fo.factor_nm,
        fo.formula_en,
        CASE WHEN rms.type = 'DISCRETE' AND fp.option_num IS NULL THEN 'factor_option档位缺失' END AS op_err,
        CASE
          WHEN fo.factor_category_cd = 0 THEN
           '0:定量'
          WHEN fo.factor_category_cd = 1 THEN
           '1:定性'
        END AS factor_category_cd, --0:定量 1：定性
        CASE
          WHEN fo.factor_appl_cd = 0 THEN
           '0:非平台'
          WHEN fo.factor_appl_cd = 1 THEN
           '1:平台相关政府等'
        END AS factor_appl_cd, --0：非平台  1：平台相关
        CASE
          WHEN fo.factor_property_cd = 0 THEN
           '0:东财'
          WHEN fo.factor_property_cd = 1 THEN
           '1:收数'
        END AS factor_property_cd, --1：收数 0：东财
        t.isdel,
        t.updt_by,
        t.updt_dt,
        t.factor_format_cd
   FROM compy_rating_list l
   JOIN compy_exposure e
     ON l.company_id = e.company_id
    AND e.is_new = 1
    AND e.isdel = 0
   JOIN exposure s
     ON e.exposure_sid = s.exposure_sid
    AND s.isdel = 0
    JOIN exposure_factor_xw t
     ON e.exposure_sid = t.exposure_sid
    AND t.isdel = 0
    JOIN factor fo
     ON t.factor_cd = fo.factor_cd AND fo.isdel = 0
    JOIN rating_model_exposure_xw rx
     ON t.exposure_sid = rx.exposure_sid
    JOIN rating_model_sub_model rms
     ON rx.model_id = rms.parent_rm_id
    JOIN rating_model_factor rf
     ON rms.id = rf.sub_model_id
    AND t.factor_cd = rf.ft_code
    LEFT JOIN factor_option fp
     ON fo.factor_cd = fp.factor_cd AND fp.isdel = 0
  WHERE NOT EXISTS (SELECT 1
           FROM (SELECT company_id, factor_cd
                   FROM compy_factor_finance
                   WHERE rpt_dt = to_date('20161231','yyyymmdd')
                     AND isdel = 0
                     AND updt_dt > SYSDATE -3
                 UNION ALL
                 SELECT company_id, factor_cd
                   FROM compy_factor_operation
                   WHERE rpt_dt = to_date('20161231','yyyymmdd')
                   AND isdel = 0
                   AND updt_dt > SYSDATE -3) f
          WHERE f.company_id = l.company_id
            AND f.factor_cd = t.factor_cd)
  ORDER BY l.company_id, rms.name, t.factor_cd;

--2.如果是财务类的公式，则查看底层科目值是否存在，不存在自然无法计算
SELECT a.company_id,accept_deposit,loan_advances
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
