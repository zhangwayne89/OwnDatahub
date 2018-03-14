CREATE OR REPLACE VIEW vw_zmd_cmp_shouxiqiye AS
SELECT key,
       company_id,
       company_nm,
       rpt_date,
       modelscore,

       factor_125_val,
       factor_106_val,
       factor_107_val,
       factor_108_val,
       factor_126_val,
       factor_109_val,
       factor_110_val,
       factor_005_val,
       factor_111_val,
       factor_112_val,
       factor_113_val,
       factor_114_val,
       factor_094_val,
       factor_116_val,
       factor_117_val,
       factor_115_val,
       factor_125_score,
       factor_106_score,
       factor_107_score,
       factor_108_score,
       factor_126_score,
       factor_109_score,
       factor_110_score,
       factor_005_score,
       factor_111_score,
       factor_112_score,
       factor_113_score,
       factor_114_score,
       factor_094_score,
       factor_116_score,
       factor_117_score,
       factor_115_score

  FROM (

       WITH factor_score_val AS (SELECT *
                                   FROM (SELECT t.rating_record_id,
                                                rmf.ft_code,
                                                t.score,
                                                CASE
                                                  WHEN f.factor_type = '规模'
                                                  AND f.factor_property_cd=0 
                                                   AND lower(f.factor_cd) LIKE '%size%'  
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
                                                  'factor_106' AS factor_106,
                                                  'factor_107' AS factor_107,
                                                  'factor_108' AS factor_108,
                                                  'factor_126' AS factor_126,
                                                  'factor_109' AS factor_109,
                                                  'factor_110' AS factor_110,
                                                  'factor_005' AS factor_005,
                                                  'factor_111' AS factor_111,
                                                  'factor_112' AS factor_112,
                                                  'factor_113' AS factor_113,
                                                  'factor_114' AS factor_114,
                                                  'factor_094' AS factor_094,
                                                  'factor_116' AS factor_116,
                                                  'factor_117' AS factor_117,
                                                  'factor_115' AS factor_115))), model_score AS (SELECT rating_record_id,
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
                factor_106_val,
                factor_107_val,
                factor_108_val,
                factor_126_val,
                factor_109_val,
                factor_110_val,
                factor_005_val,
                factor_111_val,
                factor_112_val,
                factor_113_val,
                factor_114_val,
                factor_094_val,
                factor_116_val,
                factor_117_val,
                factor_115_val,
                factor_125_score,
                factor_106_score,
                factor_107_score,
                factor_108_score,
                factor_126_score,
                factor_109_score,
                factor_110_score,
                factor_005_score,
                factor_111_score,
                factor_112_score,
                factor_113_score,
                factor_114_score,
                factor_094_score,
                factor_116_score,
                factor_117_score,
                factor_115_score,

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
            AND e.exposure = '收息企业'
           JOIN factor_score_val
             ON r.rating_record_id = factor_score_val.rating_record_id
           JOIN model_score
             ON r.rating_record_id = model_score.rating_record_id)
          WHERE rn = 1
;
