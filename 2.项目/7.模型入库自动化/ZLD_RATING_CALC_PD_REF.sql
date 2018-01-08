create table ZLD_RATING_CALC_PD_REF
(
  rm_name       VARCHAR2(200) not null,
  formular      VARCHAR2(100),
  parameter_a   NUMBER,
  parameter_b   NUMBER,
  row_num       NUMBER(6),
  rms_id        NUMBER(20)
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
