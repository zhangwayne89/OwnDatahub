CREATE OR REPLACE VIEW vw_zmd_cmp_zhengquangongsi AS
SELECT key,
       company_id,
       company_nm,
       rpt_date,
       modelscore,
       qnmodelscore,
       qlmodelscore,
       qlmodelscoreorig,
       
       secu_growth7_val,
       secu_leverage3_val,
       secu_profitability8_val,
       secu_regulatory03_val,
       secu_size010_val,
       factor_039_val,
       factor_044_val,
       factor_047_val,
       factor_050_val,
       factor_054_val,
       factor_056_val,
       factor_004_val,
       secu_growth7_score,
       secu_leverage3_score,
       secu_profitability8_score,
       secu_regulatory03_score,
       secu_size010_score,
       factor_039_score,
       factor_044_score,
       factor_047_score,
       factor_050_score,
       factor_054_score,
       factor_056_score,
       factor_004_score

  FROM (
       
       WITH factor_score_val AS
        (SELECT *
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
            FOR ft_code IN('Secu_Growth7' AS secu_growth7,
                          'Secu_Leverage3' AS secu_leverage3,
                          'Secu_Profitability8' AS secu_profitability8,
                          'Secu_Regulatory03' AS secu_regulatory03,
                          'Secu_Size010' AS secu_size010,
                          'factor_039' AS factor_039,
                          'factor_044' AS factor_044,
                          'factor_047' AS factor_047,
                          'factor_050' AS factor_050,
                          'factor_054' AS factor_054,
                          'factor_056' AS factor_056,
                          'factor_004' AS factor_004))),
       model_score AS
        (SELECT rating_record_id,
                qn_score,
                qn_orig_score,
                qi_score,
                qi_orig_score
           FROM (SELECT t.rating_record_id, NAME, score, new_score
                   FROM rating_detail t
                   JOIN rating_model_sub_model rms
                     ON t.rating_model_sub_model_id = rms.id) mid
         pivot(MAX(score) AS orig_score, MAX(new_score) AS score
            FOR NAME IN('财务分析' AS qn, '非财务分析' AS qi)))
       SELECT cbf.company_nm            AS key,
              r.company_id,
              cbf.company_nm,
              r.factor_dt               AS rpt_date,
              r.total_score             AS modelscore,
              model_score.qn_score      AS qnmodelscore,
              model_score.qi_score      AS qlmodelscore,
              model_score.qi_orig_score AS qlmodelscoreorig,
              
              secu_growth7_val,
              secu_leverage3_val,
              secu_profitability8_val,
              secu_regulatory03_val,
              secu_size010_val,
              factor_039_val,
              factor_044_val,
              factor_047_val,
              factor_050_val,
              factor_054_val,
              factor_056_val,
              factor_004_val,
              secu_growth7_score,
              secu_leverage3_score,
              secu_profitability8_score,
              secu_regulatory03_score,
              secu_size010_score,
              factor_039_score,
              factor_044_score,
              factor_047_score,
              factor_050_score,
              factor_054_score,
              factor_056_score,
              factor_004_score,
              
              row_number() over(PARTITION BY cbf.company_id ORDER BY r.updt_dt DESC) AS rn
         FROM rating_record r
         JOIN compy_basicinfo cbf
           ON r.company_id = cbf.company_id
          AND cbf.is_del = 0
         JOIN compy_exposure ce
           ON cbf.company_id = ce.company_id
          AND ce.is_new = 1
          AND ce.isdel = 0
         JOIN exposure e
           ON ce.exposure_sid = e.exposure_sid
          AND e.isdel = 0
          AND e.exposure = '证券公司'
         JOIN factor_score_val
           ON r.rating_record_id = factor_score_val.rating_record_id
         JOIN model_score
           ON r.rating_record_id = model_score.rating_record_id)
        WHERE rn = 1;
