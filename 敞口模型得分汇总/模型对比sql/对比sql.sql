WITH tmp AS
 (SELECT t.company_nm, t.company_id, t.modelscore, v.modelscore
    FROM zmd_cmp_rongzipingtai t
    JOIN vw_zmd_cmp_rongzipingtai v
      ON (t.company_id = v.company_id AND
         abs(nvl(v.modelscore, 0) - t.modelscore) > 0.000001))
SELECT *
  FROM (SELECT 'execel' AS src, a.*
          FROM zmd_cmp_rongzipingtai a, tmp
         WHERE a.company_id = tmp.company_id
        UNION ALL
        SELECT 'system' AS src, b.*
          FROM vw_zmd_cmp_rongzipingtai b, tmp
         WHERE b.company_id = tmp.company_id)
 ORDER BY company_id, src;

SELECT *
  FROM (SELECT 'execel' AS src, a.*
          FROM zmd_cmp_rongzipingtai a
        UNION ALL
        SELECT 'system' AS src, b.*
          FROM vw_zmd_cmp_rongzipingtai b)
 WHERE company_id IN (3560);
