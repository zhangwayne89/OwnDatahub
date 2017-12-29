-- Create table
create global temporary table TEMP_COMPY_CREDITAPPLY_CMB
(
  data_dt            VARCHAR2(100),
  creditapply_id     VARCHAR2(30),
  cust_no            VARCHAR2(30),
  company_id         NUMBER(16),
  submit_dt          VARCHAR2(100),
  operate_orgid      VARCHAR2(100),
  operate_orgnm      VARCHAR2(300),
  term_month         VARCHAR2(100),
  exposure_amt       VARCHAR2(100),
  nominal_amt        VARCHAR2(100),
  is_lowrisk         VARCHAR2(100),
  apply_status       VARCHAR2(100),
  apply_comment      VARCHAR2(4000),
  apply_final_cd     VARCHAR2(100),
  creditline_type_cd VARCHAR2(30),
  business_cd        VARCHAR2(100),
  sub_business_cd    VARCHAR2(100),
  final_exposure_amt VARCHAR2(100),
  final_nominal_amt  VARCHAR2(100),
  record_sid         NUMBER(16),
  loadlog_sid        INTEGER,
  updt_dt            TIMESTAMP(6),
  rnk                NUMBER
)
on commit delete rows;
