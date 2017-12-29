-- Create table
create global temporary table TEMP_COMPY_PBCCREDIT_CMB
(
  data_dt           VARCHAR2(100),
  cust_no           VARCHAR2(30),
  company_id        NUMBER(16),
  rpt_dt            VARCHAR2(100),
  normal_no         VARCHAR2(100),
  normal_balance    VARCHAR2(100),
  concerned_no      VARCHAR2(100),
  concerned_balance VARCHAR2(100),
  bad_no            VARCHAR2(100),
  bad_balance       VARCHAR2(100),
  total_no          VARCHAR2(100),
  total_balance     VARCHAR2(100),
  record_sid        NUMBER(16),
  loadlog_sid       INTEGER,
  updt_dt           TIMESTAMP(6),
  rnk               NUMBER
)
on commit delete rows;
