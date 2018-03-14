CREATE OR REPLACE VIEW vw_zmd_cmp_yuancailiaozz AS
SELECT key,
       company_id,
       company_nm,
       rpt_date,
       modelscore,
       qnmodelscore,
       qlmodelscore,
       qlmodelscoreorig,
       
       profitability6_val,
       structure2_val,
       leverage07_val,
       leverage18_val,
       operation5_val,
       size2_val,
       profitability6_score,
       structure2_score,
       leverage07_score,
       leverage18_score,
       operation5_score,
       size2_score,
       factor_071_val,
       factor_074_val,
       factor_067_val,
       factor_012_val,
       factor_582_val,
       factor_001_val,
       factor_008_val,
       
       factor_071_score,
       factor_074_score,
       factor_067_score,
       factor_012_score,
       factor_582_score,
       factor_001_score,
       factor_008_score

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
                                    FOR ft_code IN('Profitability6' AS
                                                  profitability6,
                                                  'Structure2' AS structure2,
                                                  'Leverage07' AS leverage07,
                                                  'Leverage18' AS leverage18,
                                                  'Operation5' AS operation5,
                                                  'Size2' AS size2,
                                                  'factor_071' AS factor_071,
                                                  'factor_074' AS factor_074,
                                                  'factor_067' AS factor_067,
                                                  'factor_012' AS factor_012,
                                                  'factor_582' AS factor_582,
                                                  'factor_001' AS factor_001,
                                                  'factor_008' AS factor_008))), model_score AS (SELECT rating_record_id,
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
                
                profitability6_val,
                structure2_val,
                leverage07_val,
                leverage18_val,
                operation5_val,
                size2_val,
                profitability6_score,
                structure2_score,
                leverage07_score,
                leverage18_score,
                operation5_score,
                size2_score,
                factor_071_val,
                factor_074_val,
                factor_067_val,
                factor_012_val,
                factor_582_val,
                factor_001_val,
                factor_008_val,
                
                factor_071_score,
                factor_074_score,
                factor_067_score,
                factor_012_score,
                factor_582_score,
                factor_001_score,
                factor_008_score,
                
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
            AND e.exposure = '原材料制造'
           JOIN factor_score_val
             ON r.rating_record_id = factor_score_val.rating_record_id
           JOIN model_score
             ON r.rating_record_id = model_score.rating_record_id)
          WHERE rn = 1;
