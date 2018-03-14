create table ZLD_RATING_MODEL_SUB_MODEL
(
  name          VARCHAR2(50) not null,
  type          VARCHAR2(20) not null,
  parent_rm_name  VARCHAR2(200) not null,
  ratio         NUMBER(10,6) not null,
  intercept     NUMBER(24,18),
  parameter1    VARCHAR2(200),
  parameter2    VARCHAR2(200),
  parameter3    VARCHAR2(200),
  parameter4    VARCHAR2(200),
  parameter5    VARCHAR2(200),
  parameter6    VARCHAR2(200),
  parameter7    VARCHAR2(200),
  parameter8    VARCHAR2(200),
  parameter9    VARCHAR2(200),
  parameter10   VARCHAR2(200),
  is_base       INTEGER,
  mean_value    NUMBER(38,18),
  sd_value      NUMBER(38,18),
  priority      INTEGER not null
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
