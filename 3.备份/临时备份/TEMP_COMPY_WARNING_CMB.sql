-- Create table
create global temporary table TEMP_COMPY_WARNING_CMB
(
  data_dt          VARCHAR2(100),
  warning_id       VARCHAR2(100),
  warning_cd       VARCHAR2(100),
  warn_title       VARCHAR2(1000),
  warn_content     CLOB,
  infosrc_dt       VARCHAR2(100),
  warnsrc          VARCHAR2(100),
  warn_outer_src   VARCHAR2(100),
  attachment       VARCHAR2(4000),
  status           VARCHAR2(30),
  filter_status_cd VARCHAR2(30),
  is_true          VARCHAR2(10),
  cust_no          VARCHAR2(30),
  company_id       NUMBER(16),
  org_id           VARCHAR2(100),
  org_nm           VARCHAR2(300),
  lastmodify_dt    VARCHAR2(100),
  record_sid       NUMBER(16),
  loadlog_sid      INTEGER,
  updt_dt          TIMESTAMP(6),
  rnk              NUMBER
)
on commit delete rows;
