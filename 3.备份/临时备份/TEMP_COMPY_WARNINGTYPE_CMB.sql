-- Create table
create global temporary table TEMP_COMPY_WARNINGTYPE_CMB
(
  data_dt         VARCHAR2(100),
  warning_type_cd VARCHAR2(10),
  warning_type    VARCHAR2(100),
  warning_cd      VARCHAR2(100),
  warning_nm      VARCHAR2(1000),
  is_single       VARCHAR2(100),
  is_emergent     VARCHAR2(100),
  score1          VARCHAR2(100),
  valid_flag1     VARCHAR2(100),
  score2          VARCHAR2(100),
  valid_flag2     VARCHAR2(100),
  index_type_cd   VARCHAR2(100),
  signal_type_cd  VARCHAR2(100),
  record_sid      NUMBER(16),
  loadlog_sid     INTEGER,
  updt_dt         TIMESTAMP(6),
  rnk             NUMBER
)
on commit delete rows;
