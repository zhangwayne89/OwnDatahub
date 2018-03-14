CREATE OR REPLACE VIEW vw_zmd_cmp_rongzipingtai AS
SELECT key,
       company_id,
       company_nm,
       rpt_date,
       modelscore,
       
       factor_514_val,
       zs_factor_14_val,
       factor_522_val,
       factor_520_val,
       factor_528_val,
       factor_181_val,
       zs_factor_22_val,
       zs_factor_34_val,
       zs_factor_08_val,
       factor_183_val,
       factor_514_score,
       zs_factor_14_score,
       factor_522_score,
       factor_520_score,
       factor_528_score,
       factor_181_score,
       zs_factor_22_score,
       zs_factor_34_score,
       zs_factor_08_score,
       factor_183_score

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
                                    FOR ft_code IN('factor_514' AS factor_514,
                                                  'zs_factor_14' AS zs_factor_14,
                                                  'factor_522' AS factor_522,
                                                  'factor_520' AS factor_520,
                                                  'factor_528' AS factor_528,
                                                  'factor_181' AS factor_181,
                                                  'zs_factor_22' AS zs_factor_22,
                                                  'zs_factor_34' AS zs_factor_34,
                                                  'zs_factor_08' AS zs_factor_08,
                                                  'factor_183' AS factor_183))), model_score AS (SELECT rating_record_id,
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
                
                factor_514_val,
                zs_factor_14_val,
                factor_522_val,
                factor_520_val,
                factor_528_val,
                factor_181_val,
                zs_factor_22_val,
                zs_factor_34_val,
                zs_factor_08_val,
                factor_183_val,
                factor_514_score,
                zs_factor_14_score,
                factor_522_score,
                factor_520_score,
                factor_528_score,
                factor_181_score,
                zs_factor_22_score,
                zs_factor_34_score,
                zs_factor_08_score,
                factor_183_score,
                
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
            AND e.exposure = '融资平台'
           JOIN factor_score_val
             ON r.rating_record_id = factor_score_val.rating_record_id
           JOIN model_score
             ON r.rating_record_id = model_score.rating_record_id)
          WHERE rn = 1;
