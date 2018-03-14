SELECT f.factor_nm,
       a.ft_code,
       a.id,
       chr(39) || a.ft_code || chr(39) || ' AS ' || a.ft_code || ',' AS ft_cd2
  FROM rating_model_factor a
  JOIN rating_model_sub_model b
    ON a.sub_model_id = b.id
  JOIN factor f
    ON a.ft_code = f.factor_cd
  JOIN rating_model c
    ON b.parent_rm_id = c.id
  JOIN rating_model_exposure_xw d
    ON c.id = d.model_id
  JOIN exposure e
    ON d.exposure_sid = e.exposure_sid
   AND e.exposure = '融资平台'
 ORDER BY a.id;
 
SELECT f.factor_nm, a.ft_code, CASE WHEN rn = 1 THEN a.ft_code || '_val,'
ELSE a.ft_code || '_score,'  END AS ft_cd
  FROM rating_model_factor a
  JOIN rating_model_sub_model b
    ON a.sub_model_id = b.id
  JOIN factor f
    ON a.ft_code = f.factor_cd
  JOIN rating_model c
    ON b.parent_rm_id = c.id
  JOIN rating_model_exposure_xw d
    ON c.id = d.model_id
  JOIN exposure e
    ON d.exposure_sid = e.exposure_sid
   AND e.exposure = '融资平台'
  JOIN (SELECT ROWNUM AS rn FROM dual CONNECT BY LEVEL < 3)
    ON 1 = 1
 ORDER BY rn,a.id;
