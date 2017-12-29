-- Create table
create global temporary table TEMP_COMPY_CREDITRATING_CMB
(
  data_dt              VARCHAR2(100),
  rating_no            VARCHAR2(100),
  cust_no              VARCHAR2(30),
  company_id           NUMBER(16),
  auto_rating          VARCHAR2(10),
  final_rating         VARCHAR2(10),
  rating_period        VARCHAR2(100),
  rating_start_dt      VARCHAR2(100),
  effect_end_dt        VARCHAR2(100),
  autorating_avgpd     VARCHAR2(100),
  finalrating_avgpd    VARCHAR2(100),
  adjust_reasontype_cd VARCHAR2(100),
  adjust_reason        VARCHAR2(4000),
  record_sid           NUMBER(16),
  loadlog_sid          INTEGER,
  updt_dt              TIMESTAMP(6),
  rnk                  NUMBER
)
on commit delete rows;
