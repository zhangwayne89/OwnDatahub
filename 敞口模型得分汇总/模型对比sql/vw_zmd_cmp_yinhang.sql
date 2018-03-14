CREATE OR REPLACE VIEW vw_zmd_cmp_yinhang AS
SELECT key,
       company_id,
       company_nm,
       rpt_date,
       modelscore,
       qnmodelscore,
       qlmodelscore,
       qlmodelscoreorig,
       
       zs_bank_leverage3_val,
       zs_bank_liquidity4_val,
       zs_bank_profitability2_val,
       zs_bank_profitability4_val,
       zs_bank_profitability8_val,
       zs_bank_size1_val,
       
       zs_bank_leverage3_score,
       zs_bank_liquidity4_score,
       zs_bank_profitability2_score,
       zs_bank_profitability4_score,
       zs_bank_profitability8_score,
       zs_bank_size1_score,
       
       factor_001_val,
       factor_614_val,
       factor_619_val,
       factor_623_val,
       factor_426_val,
       factor_634_val,
       factor_112_val,
       factor_450_val,
       factor_617_val,
       factor_001_score,
       factor_614_score,
       factor_619_score,
       factor_623_score,
       factor_426_score,
       factor_634_score,
       factor_112_score,
       factor_450_score,
       factor_617_score

  FROM (
       
       WITH factor_score_val AS
        (SELECT *
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
            FOR ft_code IN('zs_Bank_Leverage3' AS zs_bank_leverage3,
                          'zs_Bank_Liquidity4' AS zs_bank_liquidity4,
                          'zs_Bank_Profitability2' AS zs_bank_profitability2,
                          'zs_Bank_Profitability4' AS zs_bank_profitability4,
                          'zs_Bank_Profitability8' AS zs_bank_profitability8,
                          'zs_Bank_Size1' AS zs_bank_size1,
                          'factor_001' AS factor_001,
                          'factor_614' AS factor_614,
                          'factor_619' AS factor_619,
                          'factor_623' AS factor_623,
                          'factor_426' AS factor_426,
                          'factor_634' AS factor_634,
                          'factor_112' AS factor_112,
                          'factor_450' AS factor_450,
                          'factor_617' AS factor_617))),
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
              
              zs_bank_leverage3_val,
              zs_bank_liquidity4_val,
              zs_bank_profitability2_val,
              zs_bank_profitability4_val,
              zs_bank_profitability8_val,
              zs_bank_size1_val,
              
              zs_bank_leverage3_score,
              zs_bank_liquidity4_score,
              zs_bank_profitability2_score,
              zs_bank_profitability4_score,
              zs_bank_profitability8_score,
              zs_bank_size1_score,
              
              factor_001_val,
              factor_614_val,
              factor_619_val,
              factor_623_val,
              factor_426_val,
              factor_634_val,
              factor_112_val,
              factor_450_val,
              factor_617_val,
              factor_001_score,
              factor_614_score,
              factor_619_score,
              factor_623_score,
              factor_426_score,
              factor_634_score,
              factor_112_score,
              factor_450_score,
              factor_617_score,
              
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
          AND e.exposure = '银行'
         JOIN factor_score_val
           ON r.rating_record_id = factor_score_val.rating_record_id
         JOIN model_score
           ON r.rating_record_id = model_score.rating_record_id)
        WHERE rn = 1;
