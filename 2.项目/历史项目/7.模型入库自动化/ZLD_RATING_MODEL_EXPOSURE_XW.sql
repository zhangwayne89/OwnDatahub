create table ZLD_RATING_MODEL_EXPOSURE_XW
(
  model_name                  VARCHAR2(100),
  exposure_name              VARCHAR2(100)
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
