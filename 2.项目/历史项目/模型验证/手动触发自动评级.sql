--452919, 429421, 424825, 63578, 14796
SELECT *
  FROM compy_factor_operation o
 WHERE o.company_id IN (452919)
   AND o.rpt_dt = DATE'2016-12-31';

SELECT *
  FROM compy_factor_finance f
 WHERE f.rpt_dt = DATE'2016-12-31'
   AND f.company_id IN (452919)
   AND f.factor_cd = 'Finance_004';

UPDATE compy_factor_operation o
   SET o.updt_dt = SYSDATE
 WHERE o.rpt_dt = DATE'2016-12-31';

UPDATE compy_factor_finance f
   SET f.updt_dt = SYSDATE
 WHERE f.rpt_dt = DATE'2016-12-31';
