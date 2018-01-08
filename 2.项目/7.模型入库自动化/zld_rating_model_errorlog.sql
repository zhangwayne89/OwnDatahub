-- Create table
create table ZLD_RATING_MODEL_ERRORLOG
(
  task_name     VARCHAR2(200),
  error_type    VARCHAR2(50),
  model_name    VARCHAR2(200),
  error_msg     VARCHAR2(4000)
)
tablespace CS_MASTER_TGT
  pctfree 10
  initrans 1
  maxtrans 255;
