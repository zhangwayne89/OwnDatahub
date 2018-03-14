CREATE OR REPLACE VIEW vw_zmd_cmp_pifalingshou AS 
SELECT key,
       company_id,
       company_nm,
       rpt_date,
       modelscore,
       qnmodelscore,
       qlmodelscore,
       qlmodelscoreorig,
       profitability3_val,
       structure2_val,
       leverage5_val,
       operation6_val,
       size1_val,
       
       profitability3_score,
       structure2_score,
       leverage5_score,
       operation6_score,
       size1_score,
       
       factor_001_val,
       factor_071_val,
       factor_089_val,
       factor_009_val,
       factor_008_val,
       factor_001_score,
       factor_071_score,
       factor_089_score,
       factor_009_score,
       factor_008_score

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
                                    FOR ft_code IN('Profitability3' AS
                                                  profitability3,
                                                  'Structure2' AS structure2,
                                                  'Leverage5' AS leverage5,
                                                  'Operation6' AS operation6,
                                                  'Size1' AS size1,
                                                  'factor_001' AS factor_001,
                                                  'factor_071' AS factor_071,
                                                  'factor_089' AS factor_089,
                                                  'factor_009' AS factor_009,
                                                  'factor_008' AS factor_008
                                                  
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
                
                profitability3_val,
                structure2_val,
                leverage5_val,
                operation6_val,
                size1_val,
                
                profitability3_score,
                structure2_score,
                leverage5_score,
                operation6_score,
                size1_score,
                
                factor_001_val,
                factor_071_val,
                factor_089_val,
                factor_009_val,
                factor_008_val,
                factor_001_score,
                factor_071_score,
                factor_089_score,
                factor_009_score,
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
            AND e.exposure = '批发零售'
           JOIN factor_score_val
             ON r.rating_record_id = factor_score_val.rating_record_id
           JOIN model_score
             ON r.rating_record_id = model_score.rating_record_id)
          WHERE rn = 1;
