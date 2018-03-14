SELECT *
  FROM (SELECT company_id, exposure_sid, rpt_dt, client_id, updt_dt, factor_cd
          FROM compy_factor_operation
         WHERE rpt_timetype_cd = 1
           AND updt_dt >= to_date('20180115', 'yyyymmdd')
           AND updt_dt <= to_date('20180116', 'yyyymmdd')
           AND updt_by IN (0, -1)
           AND isdel = 0
           AND client_id = 5
        UNION
        SELECT company_id, exposure_sid, rpt_dt, client_id, updt_dt, factor_cd
          FROM compy_factor_finance
         WHERE rpt_timetype_cd = 1
           AND updt_dt >= to_date('20180115', 'yyyymmdd')
           AND updt_dt <= to_date('20180116', 'yyyymmdd')
           AND updt_by IN (0, -1)
           AND isdel = 0
           AND client_id = 5) a
 INNER JOIN rating_model_exposure_xw b
    ON a.exposure_sid = b.exposure_sid
 INNER JOIN rating_model c
    ON b.model_id = c.id
   AND c.name = '½¨Öþ'
 INNER JOIN rating_model_sub_model d
    ON c.id = d.parent_rm_id
 INNER JOIN rating_model_factor e
    ON d.id = e.sub_model_id
   AND a.factor_cd = e.ft_code
 WHERE c.is_active = 1
   AND c.isdel = 0
   AND c.client_id = 5
 ORDER BY a.updt_dt
