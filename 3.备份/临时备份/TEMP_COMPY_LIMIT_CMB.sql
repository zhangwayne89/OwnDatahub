-- Create table
create global temporary table TEMP_COMPY_LIMIT_CMB
(
  data_dt            VARCHAR2(100),
  cust_no            VARCHAR2(30),
  company_id         NUMBER(16),
  limit_type_cd      VARCHAR2(30),
  limit_status_cd    VARCHAR2(30),
  is_frozen          VARCHAR2(30),
  org_id             VARCHAR2(100),
  org_nm             VARCHAR2(300),
  currency           VARCHAR2(100),
  apply_limit        VARCHAR2(100),
  apply_valid_months VARCHAR2(100),
  apply_detail       VARCHAR2(4000),
  cust_limit         VARCHAR2(100),
  limit_usageratio   VARCHAR2(100),
  limit_used         VARCHAR2(100),
  limit_notused      VARCHAR2(100),
  limit_tmpover_amt  VARCHAR2(100),
  limit_tmpover_dt   VARCHAR2(100),
  eff_dt             VARCHAR2(100),
  due_dt             VARCHAR2(100),
  record_sid         NUMBER(16),
  loadlog_sid        INTEGER,
  updt_dt            TIMESTAMP(6),
  rnk                NUMBER
)
on commit delete rows;
