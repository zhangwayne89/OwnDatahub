-- Create table
create global temporary table TEMP_COMPY_CREDITINFO_CMB
(
  data_dt            VARCHAR2(100),
  creditinfo_id      VARCHAR2(30),
  cust_no            VARCHAR2(30),
  company_id         NUMBER(16),
  exposure_amt       VARCHAR2(100),
  nominal_amt        VARCHAR2(100),
  exposure_balance   VARCHAR2(100),
  exposure_remain    VARCHAR2(100),
  start_dt           VARCHAR2(100),
  end_dt             VARCHAR2(100),
  is_cmbrelatecust   VARCHAR2(100),
  creditline_type_cd VARCHAR2(30),
  is_lowrisk         VARCHAR2(100),
  use_org_id         VARCHAR2(100),
  use_org_nm         VARCHAR2(300),
  loan_mode_cd       VARCHAR2(30),
  credit_status_cd   VARCHAR2(30),
  is_exposure        VARCHAR2(100),
  currency           VARCHAR2(30),
  total_loan_amt     VARCHAR2(100),
  business_balance   VARCHAR2(100),
  term_month         VARCHAR2(100),
  guaranty_type_cd   VARCHAR2(30),
  record_sid         NUMBER(16),
  loadlog_sid        INTEGER,
  updt_dt            TIMESTAMP(6),
  rnk                NUMBER
)
on commit delete rows;
