--查询子模型对应的有问题的指标
SELECT * FROM (
SELECT ep.exposure_sid,
       ep.exposure,
       rms.name AS sub_model_nm,
       rmf.ft_code,
       fo.option_num,
       rmf.calc_param_1,
       rmf.calc_param_2,
       CASE
         when efx.factor_cd is null then
           'exposure_factor_xw中缺失指标'
         when f.factor_cd  is null then
           'factor表缺失指标'
         WHEN fo.option_num IS NULL THEN
          'factor_option缺失档位'
       END AS error_msg,
     f.factor_nm
  FROM rating_model_factor rmf
  JOIN rating_model_sub_model rms
    ON (rmf.sub_model_id = rms.id)
  JOIN rating_model rm
    ON (rms.parent_rm_id = rm.id AND rm.is_active = 1 AND rm.isdel = 0)
  JOIN rating_model_exposure_xw rmxw
    ON (rm.id = rmxw.model_id)
  JOIN exposure ep
    ON (rmxw.exposure_sid = ep.exposure_sid AND ep.isdel = 0 AND
       ep.exposure = '一般工商通用')
  LEFT JOIN exposure_factor_xw efx
    ON (ep.exposure_sid = efx.exposure_sid AND rmf.ft_code = efx.factor_cd AND
       efx.isdel = 0)
  LEFT JOIN factor f
    ON (rmf.ft_code = f.factor_cd AND f.isdel = 0)
  LEFT JOIN factor_option fo
    ON (ep.exposure_sid = fo.exposure_sid AND rmf.ft_code = fo.factor_cd AND
       fo.isdel = 0)
 ORDER BY ep.exposure, rm.name, rms.name, rmf.ft_code, fo.option_num
)
WHERE error_msg IS NOT NULL
