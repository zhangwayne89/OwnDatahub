create table ZLD_RATING_MODEL_FACTOR
( model_name  VARCHAR2(200) NOT NULL,
  sub_model_name  VARCHAR2(200) not null,
  ft_code       VARCHAR2(50) not null,
  ratio         NUMBER(10,6),
  calc_param_1  VARCHAR2(50),
  calc_param_2  VARCHAR2(50),
  calc_param_3  VARCHAR2(50),
  calc_param_4  VARCHAR2(50),
  calc_param_5  VARCHAR2(50),
  calc_param_6  VARCHAR2(50),
  calc_param_7  VARCHAR2(50),
  calc_param_8  VARCHAR2(50),
  calc_param_9  VARCHAR2(50),
  calc_param_10 VARCHAR2(50),
  method_type   VARCHAR2(20)
)
tablespace CS_MASTER_TGT
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 80K
    next 1M
    minextents 1
    maxextents unlimited
  );
