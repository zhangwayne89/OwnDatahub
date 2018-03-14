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
 
SELECT e.exposure,e.exposure_sid,c.name,c.ms_type,c.type,
b.name,b.type,
a.ft_code,a.method_type,
f.factor_nm,f.factor_type,
f.factor_category_cd,--0:定量 1：定性
f.factor_property_cd,--1：收数 0：东财
f.factor_appl_cd --0：非平台  1：平台相关
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
   --AND e.exposure IN ('银行','股权投资')
  JOIN (SELECT ROWNUM AS rn FROM dual CONNECT BY LEVEL < 2)
    ON 1 = 1
    WHERE a.ft_code = 'factor_119'
 ORDER BY rn,a.id;

--continuous 连续的，必须有档位
--discrete   分离的，财务指标必须有档位
--模型
--STATISTICS 统计模型
--SCORECARD打分卡模型


--1.模型类型为STATISTICS(统计模型),子模型名称为财务分析且类型为CONTINUOUS(连续的)，无档位
SELECT * FROM factor_option t WHERE t.factor_cd IN ('zs_Bank_Size1','zs_Bank_Leverage3','zs_Bank_Liquidity4');
--2.模型类型为STATISTICS(统计模型),子模型名称为非财务分析且类型为DISCRETE(分离的)，有档位
SELECT * FROM factor_option t WHERE t.factor_cd IN ('factor_617','factor_634','zs_Bank_Liquidity4');
--2.模型类型为STATISTICS(打分卡模型),子模型名称只能为模型分析且类型为DISCRETE(分离的)，有档位
SELECT * FROM factor_option t WHERE t.factor_cd IN ('factor_119');



SELECT * FROM factor t WHERE t.factor_cd = 'factor_001';
SELECT * FROM compy_factor_finance t WHERE t.factor_cd = 'factor_001';
SELECT * FROM compy_factor_operation t WHERE t.factor_cd = 'factor_001';
SELECT * FROM factor_option t WHERE t.factor_cd = 'factor_001' AND t.exposure_sid = 6380;
