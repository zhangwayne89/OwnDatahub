SELECT ex.exposure, COUNT(t.company_id), COUNT(DISTINCT s.rating_record_id)
  FROM compy_rating_list t
  LEFT JOIN rating_record s
    ON t.company_id = s.company_id
  JOIN (SELECT DISTINCT a.company_id, a.exposure_sid, b.exposure
          FROM compy_exposure a
          JOIN exposure b
            ON a.exposure_sid = b.exposure_sid
         WHERE a.is_new = 1
           AND a.isdel = 0) ex
    ON (t.company_id = ex.company_id)
 GROUP BY exposure
 ORDER BY exposure
