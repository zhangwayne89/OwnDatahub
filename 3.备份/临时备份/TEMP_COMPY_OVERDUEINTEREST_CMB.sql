-- Create table
create global temporary table TEMP_COMPY_OVERDUEINTEREST_CMB
(
  data_dt              VARCHAR2(100),
  cust_no              VARCHAR2(30),
  company_id           NUMBER(16),
  overdue_amt          VARCHAR2(100),
  innerdebt_amt        VARCHAR2(100),
  outerdebt_amt        VARCHAR2(100),
  earliest_overdue_dt  VARCHAR2(100),
  longest_overdue_days VARCHAR2(100),
  record_sid           NUMBER(16),
  loadlog_sid          INTEGER,
  updt_dt              TIMESTAMP(6),
  rnk                  NUMBER
)
on commit delete rows;
