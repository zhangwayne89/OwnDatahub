--指标档位检查
--1.打分卡模型对应的入模指标都必须有档位
SELECT *
  FROM (SELECT DISTINCT e.exposure_cd,
                        d.exposure_sid,
                        c.name               AS model_name,
                        b.name               AS sub_name,
                        a.ft_code,
                        c.type               AS model_type,
                        b.type               AS sub_type,
                        a.method_type,
                        f.factor_type,
                        f.factor_category_cd,
                        f.factor_property_cd,
                        f.factor_appl_cd
        
          FROM rating_model_factor a
          JOIN rating_model_sub_model b
            ON a.sub_model_id = b.id
          JOIN factor f
            ON a.ft_code = f.factor_cd
          JOIN rating_model c
            ON b.parent_rm_id = c.id
           AND c.type = 'SCORECARD'
          JOIN rating_model_exposure_xw d
            ON c.id = d.model_id
          JOIN exposure e
            ON d.exposure_sid = e.exposure_sid
           AND e.exposure_sid > 0) mid
 WHERE NOT EXISTS (SELECT 1
          FROM factor_option fo
         WHERE mid.ft_code = fo.factor_cd
           AND mid.exposure_sid = fo.exposure_sid);
           
--2.统计模型对应的非财务分析的入模指标都必须有档位
SELECT *
  FROM (SELECT DISTINCT e.exposure_cd,
                        d.exposure_sid,
                        c.name               AS model_name,
                        b.name               AS sub_name,
                        a.ft_code,
                        c.type               AS model_type,
                        b.type               AS sub_type,
                        a.method_type,
                        f.factor_type,
                        f.factor_category_cd,
                        f.factor_property_cd,
                        f.factor_appl_cd
        
          FROM rating_model_factor a
          JOIN rating_model_sub_model b
            ON a.sub_model_id = b.id
            AND b.type = 'DISCRETE'
          JOIN factor f
            ON a.ft_code = f.factor_cd
          JOIN rating_model c
            ON b.parent_rm_id = c.id
           AND c.type = 'STATISTICS'
          JOIN rating_model_exposure_xw d
            ON c.id = d.model_id
          JOIN exposure e
            ON d.exposure_sid = e.exposure_sid
           AND e.exposure_sid > 0) mid
 WHERE NOT EXISTS (SELECT 1
          FROM factor_option fo
         WHERE mid.ft_code = fo.factor_cd
           AND mid.exposure_sid = fo.exposure_sid);

--3.统计模型对应的财务分析的入模指标不应该有档位
SELECT *
  FROM (SELECT DISTINCT e.exposure_cd,
                        d.exposure_sid,
                        c.name               AS model_name,
                        b.name               AS sub_name,
                        a.ft_code,
                        c.type               AS model_type,
                        b.type               AS sub_type,
                        a.method_type,
                        f.factor_type,
                        f.factor_category_cd,
                        f.factor_property_cd,
                        f.factor_appl_cd
          FROM rating_model_factor a
          JOIN rating_model_sub_model b
            ON a.sub_model_id = b.id
            AND b.type = 'CONTINUOUS'
          JOIN factor f
            ON a.ft_code = f.factor_cd
          JOIN rating_model c
            ON b.parent_rm_id = c.id
           AND c.type = 'STATISTICS'
          JOIN rating_model_exposure_xw d
            ON c.id = d.model_id
          JOIN exposure e
            ON d.exposure_sid = e.exposure_sid
           AND e.exposure_sid > 0) mid
 WHERE EXISTS (SELECT 1
          FROM factor_option fo
         WHERE mid.ft_code = fo.factor_cd
           AND mid.exposure_sid = fo.exposure_sid);
