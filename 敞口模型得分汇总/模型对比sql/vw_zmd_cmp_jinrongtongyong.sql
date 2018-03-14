CREATE OR REPLACE VIEW vw_zmd_cmp_jinrongtongyong AS
SELECT key,
       company_id,
       company_nm,
       rpt_date,
       modelscore,

       factor_125_val,
       factor_118_val,
       factor_119_val,
       factor_108_val,
       factor_005_val,
       factor_120_val,
       factor_121_val,
       factor_113_val,
       factor_123_val,
       factor_114_val,
       factor_124_val,
       factor_122_val,
       factor_125_score,
       factor_118_score,
       factor_119_score,
       factor_108_score,
       factor_005_score,
       factor_120_score,
       factor_121_score,
       factor_113_score,
       factor_123_score,
       factor_114_score,
       factor_124_score,
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
                                                  'factor_118' AS factor_118,
                                                  'factor_119' AS factor_119,
                                                  'factor_108' AS factor_108,
                                                  'factor_005' AS factor_005,
                                                  'factor_120' AS factor_120,
                                                  'factor_121' AS factor_121,
                                                  'factor_113' AS factor_113,
                                                  'factor_123' AS factor_123,
                                                  'factor_114' AS factor_114,
                                                  'factor_124' AS factor_124,
                                                  'factor_122' AS factor_122

                                                  ))), model_score AS (SELECT rating_record_id,
                                                                              qn_score,
                                                                              qn_orig_score,
                                                                              ql_score,
                                                                              ql_orig_score
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
                                                                                     '非财务分析' AS ql)))
         SELECT cbf.company_nm AS key,
                r.company_id,
                cbf.company_nm,
                r.factor_dt    AS rpt_date,
                --r.rating_record_id,
                r.total_score             AS modelscore,
                model_score.qn_score      AS qnmodelscore,
                model_score.ql_score      AS qlmodelscore,
                model_score.ql_orig_score AS qlmodelscoreorig,

                factor_125_val,
                factor_118_val,
                factor_119_val,
                factor_108_val,
                factor_005_val,
                factor_120_val,
                factor_121_val,
                factor_113_val,
                factor_123_val,
                factor_114_val,
                factor_124_val,
                factor_122_val,
                factor_125_score,
                factor_118_score,
                factor_119_score,
                factor_108_score,
                factor_005_score,
                factor_120_score,
                factor_121_score,
                factor_113_score,
                factor_123_score,
                factor_114_score,
                factor_124_score,
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
            AND e.exposure = '金融通用'
           JOIN factor_score_val
             ON r.rating_record_id = factor_score_val.rating_record_id
           JOIN model_score
             ON r.rating_record_id = model_score.rating_record_id)
          WHERE rn = 1
;
