create table ZLD_RATING_MODEL
(
  code            VARCHAR2(20) not null,
  name            VARCHAR2(50) not null,
  client_name     VARCHAR2(20) not null,
  valid_from_date DATE,
  valid_to_date   DATE,
  ms_type         VARCHAR2(50),
  type            VARCHAR2(20) not null,
  version         INTEGER not NULL
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
