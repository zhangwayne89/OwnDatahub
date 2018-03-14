CREATE OR REPLACE VIEW vw_zmd_cmp_gongyongshiye AS
SELECT key,
       company_id,
       company_nm,
       rpt_date,
       modelscore,
       qnmodelscore,
       qlmodelscore,
       qlmodelscoreorig,

       profitability3_val,
       structure019_val,
       operation13_val,
       size2_val,
       profitability3_score,
       structure019_score,
       operation13_score,
       size2_score,
       factor_004_val,
       factor_001_val,
       factor_079_val,
       factor_003_val,
       factor_004_score,
       factor_001_score,
       factor_079_score,
       factor_003_score

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
       FOR ft_code IN('Profitability3' AS Profitability3,
                     'Structure019' AS Structure019,
                     'Operation13' AS Operation13,
                     'Size2' AS Size2,
                     'factor_004' AS factor_004,
                     'factor_001' AS factor_001,
                     'factor_079' AS factor_079,
                     'factor_003' AS factor_003
                     ))),
  model_score AS
   (SELECT rating_record_id, qn_score, qn_orig_score, qi_score, qi_orig_score
      FROM (SELECT t.rating_record_id, NAME, score, new_score
              FROM rating_detail t
              JOIN rating_model_sub_model rms
                ON t.rating_model_sub_model_id = rms.id) mid
    pivot(MAX(score) AS orig_score, MAX(new_score) AS score
       FOR NAME IN('财务分析' AS qn, '非财务分析' AS qi)))
  SELECT cbf.company_nm AS key,
         r.company_id,
         cbf.company_nm,
         r.factor_dt    AS rpt_date,
         --r.rating_record_id,
         r.total_score AS modelscore,
         model_score.qn_score AS qnmodelscore,
         model_score.qi_score AS qlmodelscore,
         model_score.qi_orig_score AS qlmodelscoreorig,
         profitability3_val,
         structure019_val,
         operation13_val,
         size2_val,
         profitability3_score,
         structure019_score,
         operation13_score,
         size2_score,
         factor_004_val,
         factor_001_val,
         factor_079_val,
         factor_003_val,
         factor_004_score,
         factor_001_score,
         factor_079_score,
         factor_003_score,
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
     AND e.exposure = '公用事业'
    JOIN factor_score_val
      ON r.rating_record_id = factor_score_val.rating_record_id
    JOIN model_score
      ON r.rating_record_id = model_score.rating_record_id

             )
          WHERE rn = 1
;
