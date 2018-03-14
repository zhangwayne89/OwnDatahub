WITH tmp AS
 (SELECT t.company_nm, t.company_id, t.modelscore, v.modelscore
    FROM zmd_cmp_yiyaozhizao t
    JOIN vw_zmd_cmp_yiyaozhizao v
      ON (t.company_id = v.company_id )),
sysex AS
 (SELECT *
    FROM (SELECT 'execel' AS src, a.*
            FROM zmd_cmp_yiyaozhizao a, tmp
           WHERE a.company_id = tmp.company_id
          UNION ALL
          SELECT 'system' AS src, b.*
            FROM vw_zmd_cmp_yiyaozhizao b, tmp
           WHERE b.company_id = tmp.company_id)
   ORDER BY company_id, src)
SELECT f.company_id,
       f.factor_value AS finance_value,
       x.src,
       x.profitability3_val
  FROM compy_factor_finance f
  JOIN sysex x
    ON (f.company_id = x.company_id)
 WHERE f.rpt_dt = DATE '2016-12-31'
   AND f.rpt_timetype_cd = 1
   AND f.factor_cd = 'Profitability3'
   AND f.isdel = 0
   AND f.company_id = 358964
;
