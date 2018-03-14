CREATE OR REPLACE VIEW vw_zmd_cmp_guquantouzi AS
SELECT key,
       company_id,
       company_nm,
       rpt_date,
       modelscore,

       factor_125_val,
       factor_134_val,
       factor_127_val,
       factor_128_val,
       factor_129_val,
       factor_130_val,
       factor_120_val,
       factor_108_val,
       factor_004_val,
       factor_113_val,
       factor_132_val,
       factor_094_val,
       factor_133_val,
       factor_122_val,
       factor_125_score,
       factor_134_score,
       factor_127_score,
       factor_128_score,
       factor_129_score,
       factor_130_score,
       factor_120_score,
       factor_108_score,
       factor_004_score,
       factor_113_score,
       factor_132_score,
       factor_094_score,
       factor_133_score,
       factor_122_score

  FROM (

       WITH factor_score_val AS (SELECT *
                                   FROM (SELECT t.rating_record_id,
                                                rmf.ft_code,
                                                t.score,
                                                CASE
                                                  WHEN f.factor_type = '规模'
                                                   AND f.factor_property_cd=0 
                                                   AND lower(f.factor_cd) like'%size%'   
                                                   THEN
                                                   exp(t.factor_val)
                                                  ELSE
                                                   t.factor_val
                                                END AS factor_val
                                           FROM rating_factor t
                                           JOIN rating_model_factor rmf
                                             ON t.rm_factor_id = rmf.id
                                           JOIN factor f
                                             ON rmf.ft_code = f.factor_cd) mid
                                 pivot(MAX(factor_val) AS val, MAX(score) AS score
                                    FOR ft_code IN('factor_125' AS factor_125,
                                                  'factor_134' AS factor_134,
                                                  'factor_127' AS factor_127,
                                                  'factor_128' AS factor_128,
                                                  'factor_129' AS factor_129,
                                                  'factor_130' AS factor_130,
                                                  'factor_120' AS factor_120,
                                                  'factor_108' AS factor_108,
                                                  'factor_004' AS factor_004,
                                                  'factor_113' AS factor_113,
                                                  'factor_132' AS factor_132,
                                                  'factor_094' AS factor_094,
                                                  'factor_133' AS factor_133,
                                                  'factor_122' AS factor_122

                                                  ))), model_score AS (SELECT rating_record_id,
                                                                              qn_score,
                                                                              qn_orig_score,
                                                                              qi_score,
                                                                              qi_orig_score
                                                                         FROM (SELECT t.rating_record_id,
                                                                                      NAME,
                                                                                      score,
                                                                                      new_score
                                                                                 FROM rating_detail t
                                                                                 JOIN rating_model_sub_model rms
                                                                                   ON t.rating_model_sub_model_id =
                                                                                      rms.id) mid
                                                                       pivot(MAX(score) AS orig_score, MAX(new_score) AS score
                                                                          FOR NAME IN('财务分析' AS qn,
                                                                                     '非财务分析' AS qi)))
         SELECT cbf.company_nm AS key,
                r.company_id,
                cbf.company_nm,
                r.factor_dt    AS rpt_date,
                --r.rating_record_id,
                r.total_score             AS modelscore,
                model_score.qn_score      AS qnmodelscore,
                model_score.qi_score      AS qlmodelscore,
                model_score.qi_orig_score AS qlmodelscoreorig,

                factor_125_val,
                factor_134_val,
                factor_127_val,
                factor_128_val,
                factor_129_val,
                factor_130_val,
                factor_120_val,
                factor_108_val,
                factor_004_val,
                factor_113_val,
                factor_132_val,
                factor_094_val,
                factor_133_val,
                factor_122_val,
                factor_125_score,
                factor_134_score,
                factor_127_score,
                factor_128_score,
                factor_129_score,
                factor_130_score,
                factor_120_score,
                factor_108_score,
                factor_004_score,
                factor_113_score,
                factor_132_score,
                factor_094_score,
                factor_133_score,
                factor_122_score,

                row_number() over(PARTITION BY cbf.company_id ORDER BY r.updt_dt DESC) AS rn
           FROM rating_record r
           JOIN compy_basicinfo cbf
             ON r.company_id = cbf.company_id
            AND cbf.is_del = 0
         --AND cbf.company_nm = '中国石油天然气股份有限公司'
           JOIN compy_exposure ce
             ON cbf.company_id = ce.company_id
            AND ce.is_new = 1
            AND ce.isdel = 0
           JOIN exposure e
             ON ce.exposure_sid = e.exposure_sid
            AND e.isdel = 0
            AND e.exposure = '股权投资'
           JOIN factor_score_val
             ON r.rating_record_id = factor_score_val.rating_record_id
           JOIN model_score
             ON r.rating_record_id = model_score.rating_record_id)
          WHERE rn = 1
;
