DECLARE

BEGIN
  FOR i IN (SELECT t.name AS model_name, t.id
              FROM rating_model t
             WHERE t.name NOT IN ('房地产', '融资平台')) LOOP
    --根据模型找到子模型ID，然后删除对应的模型指标
    DELETE FROM rating_model_factor rmf
     WHERE rmf.sub_model_id IN (SELECT rms.id
                                  FROM rating_model_sub_model rms, rating_model rm
                                 WHERE rm.id = rms.parent_rm_id
                                   AND rm.name = i.model_name);
    --根据模型删除对应子模型
    DELETE FROM rating_model_sub_model rms
     WHERE rms.parent_rm_id IN
           (SELECT rm.id FROM rating_model rm WHERE rm.name = i.model_name);
  
    --根据模型删除对应主标尺
    DELETE FROM rating_calc_pd_ref rpf
     WHERE rpf.rm_id IN (SELECT id FROM rating_model WHERE NAME = i.model_name);
  
    --根据敞口删除对应敞口模型映射
    DELETE FROM rating_model_exposure_xw xw WHERE xw.model_id = i.id;
  
    --根据模型删除对应模型表
    DELETE FROM rating_model rm WHERE rm.name = i.model_name;
  END LOOP;
  
  DELETE FROM rating_model t WHERE t.name NOT IN ('房地产', '融资平台');
  DELETE FROM rating_model_sub_model t WHERE t.parent_rm_id NOT IN (SELECT ID FROM rating_model);
  DELETE FROM rating_model_factor t WHERE t.sub_model_id NOT IN (SELECT ID FROM rating_model_sub_model);
  DELETE FROM rating_model_exposure_xw t WHERE t.model_id NOT IN (SELECT ID FROM rating_model);
  DELETE FROM rating_calc_pd_ref t WHERE t.rm_id NOT IN (SELECT ID FROM rating_model);
  
END;
/

SELECT * from rating_model b ORDER BY creation_time DESC;
SELECT * from rating_model_sub_model c ORDER BY creation_time DESC;
SELECT * from rating_model_exposure_xw a ORDER BY updt_dt DESC;
SELECT * from rating_calc_pd_ref d ORDER BY creation_time DESC;
SELECT * from rating_model_factor e ORDER BY creation_time DESC;
