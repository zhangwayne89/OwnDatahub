SELECT COUNT(*)
  FROM zmd_cmp_&敞口 t
  JOIN vw_zmd_cmp_&敞口 v
    ON (t.company_id = v.company_id);

WITH tmp AS
 (SELECT t.company_nm, t.company_id, t.modelscore, v.modelscore
    FROM zmd_cmp_&敞口 t
    JOIN vw_zmd_cmp_&敞口 v
      ON (t.company_id = v.company_id AND
         abs(nvl(v.modelscore, 0) - t.modelscore) > 0.00001))
SELECT *
  FROM (SELECT 'execel' AS src, a.*
          FROM zmd_cmp_&敞口 a, tmp
         WHERE a.company_id = tmp.company_id
        UNION ALL
        SELECT 'system' AS src, b.*
          FROM vw_zmd_cmp_&敞口 b, tmp
         WHERE b.company_id = tmp.company_id)
 ORDER BY company_id, src;
 
 
SELECT * FROM factor_option t WHERE lower(t.factor_cd) = 'zs_factor_14';
SELECT * FROM factor t WHERE t.factor_cd = 'zs_factor_14';


SELECT * FROM rating_model_factor t WHERE lower(t.ft_code) LIKE 'zs_factor%';

SELECT * FROM exposure t WHERE t.exposure = '收息企业';


SELECT DISTINCT a.*, d.factor_cd, d.factor_nm
  FROM rating_model a
  JOIN rating_model_sub_model b
    ON a.id = b.parent_rm_id
  JOIN rating_model_factor c
    ON b.id = c.sub_model_id
    AND c.ft_code LIKE 'zs_factor%'
  JOIN factor d
    ON c.ft_code = d.factor_cd
 WHERE a.is_active = 1;



SELECT * FROM factor_option t WHERE lower(t.factor_cd) like 'factor_113%';
SELECT * FROM factor t WHERE t.factor_cd = 'factor_113';
