--查一个公司的指标
SELECT a.company_id,
       a.company_nm,
       b.exposure_sid,
       c.exposure,
       d.factor_cd,
       e.factor_type,
       e.formula_en
--ele.element_cd
  FROM compy_basicinfo a
  JOIN compy_exposure b
    ON (a.company_id = b.company_id AND b.isdel = 0 AND b.is_new = 1)
  JOIN exposure c
    ON (b.exposure_sid = c.exposure_sid AND c.isdel = 0)
  JOIN exposure_factor_xw d
    ON (b.exposure_sid = d.exposure_sid AND d.isdel = 0)
  JOIN factor e
    ON (d.factor_cd = e.factor_cd AND e.isdel = 0 AND e.factor_property_cd = 0 --0:财务 ; 1: 经营
       AND e.factor_cd = 'Profitability6')
 WHERE a.company_id IN (SELECT company_id FROM compy_rating_list);

SELECT *
  FROM factor_element_xw t
 WHERE t.factor_cd = 'factor_181'
   AND t.isdel = 0;

  SELECT * FROM factor t WHERE t.factor_cd = 'factor_181';


SELECT s.element_nm, s.element_type, t.*
  FROM element s
  LEFT JOIN compy_element t
    ON t.element_cd = s.element_cd
   AND t.isdel = 0
   AND t.company_id = 207623
 WHERE s.isdel = 0
   AND s.element_cd IN ('element_0320', 'element_0340', 'element_1040');

SELECT *
  FROM element t
 WHERE t.element_cd IN ('element_0340', 'element_1040', 'element_0320');

SELECT *
  FROM compy_element t
 WHERE t.company_id = 207623
   AND t.element_cd = 'element_0320';

--查指标对应的结果
WITH records AS
 (SELECT cb.company_id,
         cb.company_nm,
         zs.exposure,
         to_char(cf.rpt_dt, 'yyyymmdd') AS rpt_dt,
         cf.factor_cd,
         cf.factor_value
    FROM (SELECT b.exposure, a.*
            FROM compy_exposure a
            JOIN exposure b
              ON a.exposure_sid = b.exposure_sid
           WHERE a.client_id = 5) zs
    JOIN compy_basicinfo cb
      ON cb.company_id = zs.company_id
     AND cb.is_del = 0
     AND zs.exposure NOT IN ('证券公司', '银行')
    JOIN compy_factor_finance cf
      ON cb.company_id = cf.company_id
     AND cf.rpt_timetype_cd = 1
     AND factor_value IS NOT NULL
     AND to_char(cf.rpt_dt, 'yyyymmdd') = '20161231'
     AND zs.company_id IN (14796, 63578, 424825, 429421, 452919))
SELECT *
  FROM (SELECT exposure, company_id, company_nm, rpt_dt, factor_cd, factor_value
          FROM records)
pivot (SUM(factor_value) FOR factor_cd IN('Growth1',
                                     'Growth2',
                                     'Growth3',
                                     'Growth4',
                                     'Growth5',
                                     'Growth6',
                                     'Growth7',
                                     'Growth8',
                                     'Growth9',
                                     'Leverage1',
                                     'Leverage010',
                                     'Leverage011',
                                     'Leverage012',
                                     'Leverage13',
                                     'Leverage14',
                                     'Leverage15',
                                     'Leverage16',
                                     'Leverage17',
                                     'Leverage18',
                                     'Leverage19',
                                     'Leverage2',
                                     'Leverage20',
                                     'Leverage21',
                                     'Leverage22',
                                     'Leverage23',
                                     'Leverage24',
                                     'Leverage3',
                                     'Leverage4',
                                     'Leverage5',
                                     'Leverage6',
                                     'Leverage07',
                                     'Leverage8',
                                     'Leverage09',
                                     'Operation1',
                                     'Operation10',
                                     'Operation11',
                                     'Operation12',
                                     'Operation13',
                                     'Operation14',
                                     'Operation15',
                                     'Operation2',
                                     'Operation3',
                                     'Operation4',
                                     'Operation5',
                                     'Operation6',
                                     'Operation7',
                                     'Operation8',
                                     'Operation9',
                                     'Profitability1',
                                     'Profitability10',
                                     'Profitability11',
                                     'Profitability12',
                                     'Profitability13',
                                     'Profitability14',
                                     'Profitability15',
                                     'Profitability16',
                                     'Profitability17',
                                     'Profitability18',
                                     'Profitability2',
                                     'Profitability3',
                                     'Profitability4',
                                     'Profitability5',
                                     'Profitability6',
                                     'Profitability7',
                                     'Profitability8',
                                     'Profitability9',
                                     'Size1',
                                     'Size10',
                                     'Size2',
                                     'Size3',
                                     'Size4',
                                     'Size5',
                                     'Size6',
                                     'Size7',
                                     'Size8',
                                     'Size9',
                                     'Specific1',
                                     'Specific2',
                                     'Specific3',
                                     'Specific4',
                                     'Specific5',
                                     'Specific6',
                                     'Specific7',
                                     'Specific8',
                                     'Specific9',
                                     'Structure1',
                                     'Structure10',
                                     'Structure11',
                                     'Structure12',
                                     'Structure13',
                                     'Structure14',
                                     'Structure15',
                                     'Structure16',
                                     'Structure17',
                                     'Structure18',
                                     'Structure019',
                                     'Structure2',
                                     'Structure3',
                                     'Structure4',
                                     'Structure5',
                                     'Structure6',
                                     'Structure7',
                                     'Structure8',
                                     'Structure9',
                                     'zs_factor_01',
                                     'zs_factor_02',
                                     'zs_factor_03',
                                     'zs_factor_04',
                                     'zs_factor_05',
                                     'zs_factor_06',
                                     'zs_factor_07',
                                     'zs_factor_08',
                                     'zs_factor_09',
                                     'zs_factor_10',
                                     'zs_factor_11',
                                     'zs_factor_12',
                                     'zs_factor_13',
                                     'zs_factor_14',
                                     'zs_factor_15',
                                     'zs_factor_16',
                                     'zs_factor_17',
                                     'zs_factor_18',
                                     'zs_factor_19',
                                     'zs_factor_20',
                                     'zs_factor_21',
                                     'zs_factor_22',
                                     'zs_factor_23',
                                     'zs_factor_24',
                                     'zs_factor_25',
                                     'zs_factor_26',
                                     'zs_factor_27',
                                     'zs_factor_28',
                                     'zs_factor_29',
                                     'zs_factor_30',
                                     'zs_factor_31',
                                     'zs_factor_32',
                                     'zs_factor_33',
                                     'zs_factor_34',
                                     'zs_factor_35',
                                     'zs_factor_36',
                                     'zs_factor_37'));
