-- Create table
create global temporary table TEMP_CUSTOMER_CMB
(
  data_dt              VARCHAR2(100),
  cust_no              VARCHAR2(30),
  company_id           NUMBER(16),
  customer_nm          VARCHAR2(300),
  org_num              VARCHAR2(30),
  risk_status_cd       VARCHAR2(100),
  class_grade_cd       VARCHAR2(100),
  is_yjhplatform       VARCHAR2(10),
  is_loan              VARCHAR2(10),
  is_cmbrelatecust     VARCHAR2(10),
  customer_grade_cd    VARCHAR2(10),
  is_high_risk         VARCHAR2(10),
  group_cust_no        VARCHAR2(30),
  group_nm             VARCHAR2(300),
  group_warnstatus_cd  VARCHAR2(10),
  is_guar              VARCHAR2(10),
  guargrp_risklevel_cd VARCHAR2(100),
  rating_cd            VARCHAR2(30),
  bl_numb              VARCHAR2(30),
  record_sid           NUMBER(16),
  loadlog_sid          INTEGER,
  updt_dt              TIMESTAMP(6),
  rnk                  NUMBER
)
on commit delete rows;
