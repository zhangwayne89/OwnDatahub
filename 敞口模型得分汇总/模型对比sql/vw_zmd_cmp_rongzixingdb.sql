CREATE OR REPLACE VIEW vw_zmd_cmp_rongzixingdb AS
SELECT key,
       company_id,
       company_nm,
       rpt_date,
       modelscore,

       factor_001_val,
       factor_135_val,
       factor_004_val,
       factor_096_val,
       factor_095_val,
       factor_136_val,
       factor_094_val,
       factor_098_val,
       factor_099_val,
       factor_100_val,
       factor_102_val,
       factor_103_val,

       factor_001_score,
       factor_135_score,
       factor_004_score,
       factor_096_score,
       factor_095_score,
       factor_136_score,
       factor_094_score,
       factor_098_score,
       factor_099_score,
       factor_100_score,
       factor_102_score,
       factor_103_score

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
                                    FOR ft_code IN('factor_001' AS factor_001,
                                                  'factor_135' AS factor_135,
                                                  'factor_004' AS factor_004,
                                                  'factor_096' AS factor_096,
                                                  'factor_095' AS factor_095,
                                                  'factor_136' AS factor_136,
                                                  'factor_094' AS factor_094,
                                                  'factor_098' AS factor_098,
                                                  'factor_099' AS factor_099,
                                                  'factor_100' AS factor_100,
                                                  'factor_102' AS factor_102,
                                                  'factor_103' AS factor_103

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

                factor_001_val,
                factor_135_val,
                factor_004_val,
                factor_096_val,
                factor_095_val,
                factor_136_val,
                factor_094_val,
                factor_098_val,
                factor_099_val,
                factor_100_val,
                factor_102_val,
                factor_103_val,

                factor_001_score,
                factor_135_score,
                factor_004_score,
                factor_096_score,
                factor_095_score,
                factor_136_score,
                factor_094_score,
                factor_098_score,
                factor_099_score,
                factor_100_score,
                factor_102_score,
                factor_103_score,

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
            AND e.exposure = '融资性担保'
           JOIN factor_score_val
             ON r.rating_record_id = factor_score_val.rating_record_id
           JOIN model_score
             ON r.rating_record_id = model_score.rating_record_id)
          WHERE rn = 1
;
