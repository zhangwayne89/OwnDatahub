CREATE OR REPLACE PROCEDURE sp_zld_rating_model_import(iv_date      IN DATE DEFAULT SYSDATE,
                                                       iv_running   IN VARCHAR2 DEFAULT 'N',
                                                       ov_error_msg OUT SYS_REFCURSOR) IS
  /*************************************
  存储过程：sp_zld_rating_model_import
  创建时间：2017/11/28
  创 建 人：ZhangCong
  源    表：
  目 标 表：
  功    能：将导入的模型数据,插入到对应的模型表
  
  ************************************/

  --------------------------------设置日志变量--------------------------------------
  v_task_name     VARCHAR2(2000);
  v_error_cd      NUMBER;
  v_error_message VARCHAR2(1000);

  --------------------------------设置业务变量-------------------------------------
  --v_creation_by   VARCHAR2(200) := 0; --更新人
  v_creation_time TIMESTAMP := iv_date; --更新时间
  v_isdel         NUMBER := 0; --是否删除
  v_isactive      NUMBER := 1; --是否有效
  v_model_name    VARCHAR2(200);
  v_error_cnt     NUMBER := 0; --错误行数

BEGIN

  --流程名称
  v_task_name := 'SP_ZLD_RATING_MODEL_IMPORT';

  --插入错误信息到LOG表中

  --模型重复问题
  INSERT INTO zld_rating_model_errorlog
    (task_name, error_type, model_name, error_msg, create_time)
    SELECT v_task_name,
           '数据重复',
           NAME,
           CASE
             WHEN COUNT(*) > 1 THEN
              '模型页中 ' || NAME || ' 存在重复,不导入 ' || NAME || ' 模型'
           END AS error_msg,
           v_creation_time
      FROM zld_rating_model
     GROUP BY NAME
    HAVING COUNT(*) > 1;

  --子模型重复问题
  INSERT INTO zld_rating_model_errorlog
    (task_name, error_type, model_name, error_msg, create_time)
    SELECT v_task_name,
           '数据重复',
           parent_rm_name,
           CASE
             WHEN COUNT(*) > 1 THEN
              '子模型页中 ' || parent_rm_name || '-' || NAME || ' 存在重复,不导入' || parent_rm_name || '模型'
           END AS error_msg,
           v_creation_time
      FROM zld_rating_model_sub_model
     GROUP BY parent_rm_name, NAME
    HAVING COUNT(*) > 1;

  --敞口对应多模型问题
  INSERT INTO zld_rating_model_errorlog
    (task_name, error_type, exposure_name, error_msg, create_time)
    SELECT v_task_name,
           '数据重复',
           exposure_name,
           CASE
             WHEN COUNT(*) > 1 THEN
              '模型敞口页中 ' || exposure_name || '敞口不应该存在多条记录,不导入' || exposure_name || '敞口及其模型'
           END AS error_msg,
           v_creation_time
      FROM zld_rating_model_exposure_xw
     GROUP BY exposure_name
    HAVING COUNT(*) > 1;

  --校准参数重复问题
  INSERT INTO zld_rating_model_errorlog
    (task_name, error_type, model_name, error_msg, create_time)
    SELECT v_task_name,
           '数据重复',
           d.rm_name,
           CASE
             WHEN COUNT(*) > 1 THEN
              '校准参数页 ' || rm_name || '(formular=''' || formular || ''')' || '存在重复，不导入' ||
              rm_name || '模型'
           END AS error_msg,
           v_creation_time
      FROM zld_rating_calc_pd_ref d
     GROUP BY d.rm_name, d.formular
    HAVING COUNT(*) > 1;

  --模型指标重复问题
  INSERT INTO zld_rating_model_errorlog
    (task_name, error_type, model_name, error_msg, create_time)
    SELECT v_task_name,
           '数据重复',
           model_name,
           CASE
             WHEN COUNT(*) > 1 THEN
              '模型指标页中 模型:' || model_name || ' 子模型:' || sub_model_name || ' 指标:' || ft_code ||
              '，存在重复，不导入' || model_name || '模型'
           END AS error_msg,
           v_creation_time
      FROM zld_rating_model_factor
     GROUP BY model_name, sub_model_name, ft_code
    HAVING COUNT(*) > 1;

  --数据缺失问题
  INSERT INTO zld_rating_model_errorlog
    (task_name, error_type, model_name, error_msg, create_time)
    SELECT v_task_name, '数据缺失', model_name, error_msg, v_creation_time
      FROM (SELECT model_name,
                   CASE
                     WHEN exposure_cnt = 0 THEN
                      '模型：' || model_name || ' 在exposure表中找不到对应敞口'
                     WHEN model_cnt = 0 THEN
                      '模型：' || model_name || ' 在模型页中找不到对应模型定义'
                     WHEN client_cnt = 0 THEN
                      '模型:' || model_name || ' client_basicinfo中找不到客户id'
                     WHEN sub_model_cnt = 0 THEN
                      '模型：' || model_name || ' 在子模型页中找不到对应子模型定义'
                     WHEN ref_cnt = 0 THEN
                      '模型：' || model_name || ' 在校准参数页中找不到对应的校准参数'
                     WHEN factor_cnt = 0 THEN
                      '模型：' || model_name || ' 在模型指标页中找不到对应指标定义'
                     ELSE
                      NULL
                   END AS error_msg
              FROM (SELECT a.model_name,
                           COUNT(DISTINCT t.exposure) AS exposure_cnt,
                           COUNT(DISTINCT b.name) AS model_cnt,
                           COUNT(DISTINCT ct.client_id) AS client_cnt,
                           COUNT(DISTINCT c.name) AS sub_model_cnt,
                           COUNT(DISTINCT d.rm_name) AS ref_cnt,
                           COUNT(DISTINCT e.sub_model_name) AS factor_cnt
                      FROM zld_rating_model_exposure_xw a
                      LEFT JOIN exposure t
                        ON (t.exposure = a.exposure_name)
                      LEFT JOIN zld_rating_model b
                        ON (a.model_name = b.name)
                      LEFT JOIN client_basicinfo ct
                        ON (b.client_name = ct.client_nm)
                      LEFT JOIN zld_rating_model_sub_model c
                        ON (b.name = c.parent_rm_name)
                      LEFT JOIN zld_rating_calc_pd_ref d
                        ON (b.name = d.rm_name)
                      LEFT JOIN zld_rating_model_factor e
                        ON (c.parent_rm_name = e.model_name AND c.name = e.sub_model_name)
                     GROUP BY a.model_name) mid)
     WHERE error_msg IS NOT NULL;

  COMMIT;

  SELECT COUNT(*)
    INTO v_error_cnt
    FROM zld_rating_model_errorlog el
   WHERE el.create_time >= v_creation_time;

  IF iv_running = 'Y' AND v_error_cnt = 0
  THEN
    --插入主模型
    FOR i IN (SELECT DISTINCT b.name AS model_name, t.exposure_sid, ct.client_id
                FROM zld_rating_model_exposure_xw a
                JOIN exposure t
                  ON (t.exposure = a.exposure_name)
                JOIN zld_rating_model b
                  ON (a.model_name = b.name)
                JOIN client_basicinfo ct
                  ON (b.client_name = ct.client_nm)
                JOIN zld_rating_model_sub_model c
                  ON (b.name = c.parent_rm_name)
                JOIN zld_rating_calc_pd_ref d
                  ON (b.name = d.rm_name)
                JOIN zld_rating_model_factor e
                  ON (c.parent_rm_name = e.model_name AND c.name = e.sub_model_name)
               WHERE NOT EXISTS (SELECT 1
                        FROM zld_rating_model_errorlog lg --过滤本次有错误信息的模型
                       WHERE (a.model_name = lg.model_name OR
                             a.exposure_name = lg.exposure_name)
                         AND lg.create_time >= v_creation_time)) LOOP
    
      v_model_name := i.model_name;
    
      --根据模型找到子模型ID，然后删除对应的模型指标
      DELETE FROM rating_model_factor rmf
       WHERE rmf.sub_model_id IN (SELECT rms.id
                                    FROM rating_model_sub_model rms, rating_model rm
                                   WHERE rm.id = rms.parent_rm_id
                                     AND rm.name = i.model_name);
      --根据模型删除对应子模型
      DELETE FROM rating_model_sub_model rms
       WHERE rms.parent_rm_id =
             (SELECT rm.id FROM rating_model rm WHERE rm.name = i.model_name);
    
      --根据模型删除对应主标尺
      DELETE FROM rating_calc_pd_ref rpf
       WHERE rpf.rm_id = (SELECT id FROM rating_model WHERE NAME = i.model_name);
    
      --根据敞口删除对应敞口模型映射
      DELETE FROM rating_model_exposure_xw xw
       WHERE xw.exposure_sid = i.exposure_sid;
    
      --根据模型删除对应模型表
      DELETE FROM rating_model rm WHERE rm.name = i.model_name;
    
      --插入模型定义
      INSERT INTO rating_model
        (id,
         code,
         NAME,
         client_id,
         valid_from_date,
         valid_to_date,
         ms_type,
         TYPE,
         version,
         is_active,
         isdel,
         creation_time)
        SELECT seq_rating_model.nextval,
               code,
               NAME,
               i.client_id, --招银资管
               valid_from_date,
               valid_to_date,
               ms_type,
               TYPE,
               version,
               v_isactive,
               v_isdel,
               v_creation_time
          FROM zld_rating_model a
          JOIN client_basicinfo b
            ON (a.client_name = b.client_nm)
         WHERE a.name = i.model_name;
    
      --插入子模型
      INSERT INTO rating_model_sub_model
        (id,
         NAME,
         TYPE,
         parent_rm_id,
         ratio,
         intercept,
         parameter1,
         parameter2,
         parameter3,
         parameter4,
         parameter5,
         parameter6,
         parameter7,
         parameter8,
         parameter9,
         parameter10,
         is_base,
         mean_value,
         sd_value,
         creation_time,
         priority)
        SELECT seq_rating_model_sub_model.nextval,
               a.name,
               a.type,
               b.id,
               a.ratio,
               a.intercept,
               a.parameter1,
               a.parameter2,
               a.parameter3,
               a.parameter4,
               a.parameter5,
               a.parameter6,
               a.parameter7,
               a.parameter8,
               a.parameter9,
               a.parameter10,
               a.is_base,
               a.mean_value,
               a.sd_value,
               v_creation_time,
               a.priority
          FROM zld_rating_model_sub_model a
          JOIN rating_model b
            ON (a.parent_rm_name = b.name AND b.name = i.model_name);
    
      --插入模型敞口映射关系
      INSERT INTO rating_model_exposure_xw
        (rating_model_exposure_sid, model_id, exposure_sid, updt_dt)
        SELECT seq_rating_model_exposure_xw.nextval,
               c.id,
               b.exposure_sid,
               v_creation_time
          FROM zld_rating_model_exposure_xw a
          JOIN exposure b
            ON (a.exposure_name = b.exposure)
          JOIN rating_model c
            ON (a.model_name = c.name AND c.name = i.model_name);
    
      --插入模型校准参数
      INSERT INTO rating_calc_pd_ref
        (id, rm_id, formular, parameter_a, parameter_b, row_num, rms_id, creation_time)
        SELECT seq_rating_calc_pd_ref.nextval,
               b.id,
               a.formular,
               a.parameter_a,
               a.parameter_b,
               a.row_num,
               a.rms_id,
               v_creation_time
          FROM zld_rating_calc_pd_ref a
          JOIN rating_model b
            ON (a.rm_name = b.name AND b.name = i.model_name);
    
      --插入模型指标
      INSERT INTO rating_model_factor
        (id,
         sub_model_id,
         ft_code,
         ratio,
         calc_param_1,
         calc_param_2,
         calc_param_3,
         calc_param_4,
         calc_param_5,
         calc_param_6,
         calc_param_7,
         calc_param_8,
         calc_param_9,
         calc_param_10,
         method_type,
         creation_time)
        SELECT seq_rating_model_factor.nextval,
               c.id,
               a.ft_code,
               a.ratio,
               a.calc_param_1,
               a.calc_param_2,
               a.calc_param_3,
               a.calc_param_4,
               a.calc_param_5,
               a.calc_param_6,
               a.calc_param_7,
               a.calc_param_8,
               a.calc_param_9,
               a.calc_param_10,
               a.method_type,
               v_creation_time
          FROM zld_rating_model_factor a
          JOIN rating_model b
            ON (a.model_name = b.name AND b.name = i.model_name)
          JOIN rating_model_sub_model c
            ON (a.sub_model_name = c.name AND c.parent_rm_id = b.id);
    
      COMMIT;
    
    END LOOP;
  END IF;

  COMMIT;

  OPEN ov_error_msg FOR
    SELECT t.error_type, t.error_msg
      FROM zld_rating_model_errorlog t
     WHERE t.create_time >= iv_date;

  --报错处理
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    v_error_cd      := SQLCODE;
    v_error_message := substr(SQLERRM, 1, 1000);
    dbms_output.put_line('failed! ERROR:' || v_error_cd || ' ,' || v_error_message);
  
    INSERT INTO zld_rating_model_errorlog
      (task_name, error_type, model_name, error_msg, create_time)
    VALUES
      (v_task_name,
       'Exception',
       v_model_name,
       'ERROR:' || v_error_cd || ' ,' || v_error_message,
       SYSDATE);
  
    COMMIT;
  
    raise_application_error(-20021, v_error_message);
    RETURN;
  
    COMMIT;
  
END sp_zld_rating_model_import;
/
