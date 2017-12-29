prompt
prompt Creating table ACT_EVT_LOG
prompt ==========================
prompt
create table ACT_EVT_LOG
(
  log_nr_       NUMBER(19) not null,
  type_         VARCHAR2(64),
  proc_def_id_  VARCHAR2(64),
  proc_inst_id_ VARCHAR2(64),
  execution_id_ VARCHAR2(64),
  task_id_      VARCHAR2(64),
  time_stamp_   TIMESTAMP(6) not null,
  user_id_      VARCHAR2(255),
  data_         BLOB,
  lock_owner_   VARCHAR2(255),
  lock_time_    TIMESTAMP(6),
  is_processed_ NUMBER(3) default 0
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
alter table ACT_EVT_LOG
  add primary key (LOG_NR_)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table ACT_RE_DEPLOYMENT
prompt ================================
prompt
create table ACT_RE_DEPLOYMENT
(
  id_          VARCHAR2(64) not null,
  name_        VARCHAR2(255),
  category_    VARCHAR2(255),
  tenant_id_   VARCHAR2(255) default '',
  deploy_time_ TIMESTAMP(6)
)
tablespace USERS
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
alter table ACT_RE_DEPLOYMENT
  add primary key (ID_)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 80K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table ACT_GE_BYTEARRAY
prompt ===============================
prompt
create table ACT_GE_BYTEARRAY
(
  id_            VARCHAR2(64) not null,
  rev_           INTEGER,
  name_          VARCHAR2(255),
  deployment_id_ VARCHAR2(64),
  bytes_         BLOB,
  generated_     NUMBER(1)
)
tablespace USERS
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
create index ACT_IDX_BYTEAR_DEPL on ACT_GE_BYTEARRAY (DEPLOYMENT_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 80K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table ACT_GE_BYTEARRAY
  add primary key (ID_)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 80K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table ACT_GE_BYTEARRAY
  add constraint ACT_FK_BYTEARR_DEPL foreign key (DEPLOYMENT_ID_)
  references ACT_RE_DEPLOYMENT (ID_);
alter table ACT_GE_BYTEARRAY
  add check (GENERATED_ in (1, 0));

prompt
prompt Creating table ACT_GE_PROPERTY
prompt ==============================
prompt
create table ACT_GE_PROPERTY
(
  name_  VARCHAR2(64) not null,
  value_ VARCHAR2(300),
  rev_   INTEGER
)
tablespace USERS
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
alter table ACT_GE_PROPERTY
  add primary key (NAME_)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 80K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table ACT_HI_ACTINST
prompt =============================
prompt
create table ACT_HI_ACTINST
(
  id_                VARCHAR2(64) not null,
  proc_def_id_       VARCHAR2(64) not null,
  proc_inst_id_      VARCHAR2(64) not null,
  execution_id_      VARCHAR2(64) not null,
  act_id_            VARCHAR2(255) not null,
  task_id_           VARCHAR2(64),
  call_proc_inst_id_ VARCHAR2(64),
  act_name_          VARCHAR2(255),
  act_type_          VARCHAR2(255) not null,
  assignee_          VARCHAR2(255),
  start_time_        TIMESTAMP(6) not null,
  end_time_          TIMESTAMP(6),
  duration_          NUMBER(19),
  tenant_id_         VARCHAR2(255) default ''
)
tablespace USERS
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
create index ACT_IDX_HI_ACT_INST_END on ACT_HI_ACTINST (END_TIME_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 80K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index ACT_IDX_HI_ACT_INST_EXEC on ACT_HI_ACTINST (EXECUTION_ID_, ACT_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 80K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index ACT_IDX_HI_ACT_INST_PROCINST on ACT_HI_ACTINST (PROC_INST_ID_, ACT_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 80K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index ACT_IDX_HI_ACT_INST_START on ACT_HI_ACTINST (START_TIME_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 80K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table ACT_HI_ACTINST
  add primary key (ID_)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 80K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table ACT_HI_ATTACHMENT
prompt ================================
prompt
create table ACT_HI_ATTACHMENT
(
  id_           VARCHAR2(64) not null,
  rev_          INTEGER,
  user_id_      VARCHAR2(255),
  name_         VARCHAR2(255),
  description_  VARCHAR2(2000),
  type_         VARCHAR2(255),
  task_id_      VARCHAR2(64),
  proc_inst_id_ VARCHAR2(64),
  url_          VARCHAR2(2000),
  content_id_   VARCHAR2(64),
  time_         TIMESTAMP(6)
)
tablespace USERS
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
alter table ACT_HI_ATTACHMENT
  add primary key (ID_)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 80K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table ACT_HI_COMMENT
prompt =============================
prompt
create table ACT_HI_COMMENT
(
  id_           VARCHAR2(64) not null,
  type_         VARCHAR2(255),
  time_         TIMESTAMP(6) not null,
  user_id_      VARCHAR2(255),
  task_id_      VARCHAR2(64),
  proc_inst_id_ VARCHAR2(64),
  action_       VARCHAR2(255),
  message_      VARCHAR2(2000),
  full_msg_     BLOB
)
tablespace USERS
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
alter table ACT_HI_COMMENT
  add primary key (ID_)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 80K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table ACT_HI_DETAIL
prompt ============================
prompt
create table ACT_HI_DETAIL
(
  id_           VARCHAR2(64) not null,
  type_         VARCHAR2(255) not null,
  proc_inst_id_ VARCHAR2(64),
  execution_id_ VARCHAR2(64),
  task_id_      VARCHAR2(64),
  act_inst_id_  VARCHAR2(64),
  name_         VARCHAR2(255) not null,
  var_type_     VARCHAR2(64),
  rev_          INTEGER,
  time_         TIMESTAMP(6) not null,
  bytearray_id_ VARCHAR2(64),
  double_       NUMBER(*,10),
  long_         NUMBER(19),
  text_         VARCHAR2(2000),
  text2_        VARCHAR2(2000)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
create index ACT_IDX_HI_DETAIL_ACT_INST on ACT_HI_DETAIL (ACT_INST_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
create index ACT_IDX_HI_DETAIL_NAME on ACT_HI_DETAIL (NAME_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
create index ACT_IDX_HI_DETAIL_PROC_INST on ACT_HI_DETAIL (PROC_INST_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
create index ACT_IDX_HI_DETAIL_TASK_ID on ACT_HI_DETAIL (TASK_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
create index ACT_IDX_HI_DETAIL_TIME on ACT_HI_DETAIL (TIME_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table ACT_HI_DETAIL
  add primary key (ID_)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table ACT_HI_IDENTITYLINK
prompt ==================================
prompt
create table ACT_HI_IDENTITYLINK
(
  id_           VARCHAR2(64) not null,
  group_id_     VARCHAR2(255),
  type_         VARCHAR2(255),
  user_id_      VARCHAR2(255),
  task_id_      VARCHAR2(64),
  proc_inst_id_ VARCHAR2(64)
)
tablespace USERS
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
create index ACT_IDX_HI_IDENT_LNK_PROCINST on ACT_HI_IDENTITYLINK (PROC_INST_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 80K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index ACT_IDX_HI_IDENT_LNK_TASK on ACT_HI_IDENTITYLINK (TASK_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 80K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index ACT_IDX_HI_IDENT_LNK_USER on ACT_HI_IDENTITYLINK (USER_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 80K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table ACT_HI_IDENTITYLINK
  add primary key (ID_)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 80K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table ACT_HI_PROCINST
prompt ==============================
prompt
create table ACT_HI_PROCINST
(
  id_                        VARCHAR2(64) not null,
  proc_inst_id_              VARCHAR2(64) not null,
  business_key_              VARCHAR2(255),
  proc_def_id_               VARCHAR2(64) not null,
  start_time_                TIMESTAMP(6) not null,
  end_time_                  TIMESTAMP(6),
  duration_                  NUMBER(19),
  start_user_id_             VARCHAR2(255),
  start_act_id_              VARCHAR2(255),
  end_act_id_                VARCHAR2(255),
  super_process_instance_id_ VARCHAR2(64),
  delete_reason_             VARCHAR2(2000),
  tenant_id_                 VARCHAR2(255) default '',
  name_                      VARCHAR2(255)
)
tablespace USERS
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
create index ACT_IDX_HI_PRO_INST_END on ACT_HI_PROCINST (END_TIME_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 80K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index ACT_IDX_HI_PRO_I_BUSKEY on ACT_HI_PROCINST (BUSINESS_KEY_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 80K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table ACT_HI_PROCINST
  add primary key (ID_)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 80K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table ACT_HI_PROCINST
  add unique (PROC_INST_ID_)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 80K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table ACT_HI_TASKINST
prompt ==============================
prompt
create table ACT_HI_TASKINST
(
  id_             VARCHAR2(64) not null,
  proc_def_id_    VARCHAR2(64),
  task_def_key_   VARCHAR2(255),
  proc_inst_id_   VARCHAR2(64),
  execution_id_   VARCHAR2(64),
  parent_task_id_ VARCHAR2(64),
  name_           VARCHAR2(255),
  description_    VARCHAR2(2000),
  owner_          VARCHAR2(255),
  assignee_       VARCHAR2(255),
  start_time_     TIMESTAMP(6) not null,
  claim_time_     TIMESTAMP(6),
  end_time_       TIMESTAMP(6),
  duration_       NUMBER(19),
  delete_reason_  VARCHAR2(2000),
  priority_       INTEGER,
  due_date_       TIMESTAMP(6),
  form_key_       VARCHAR2(255),
  category_       VARCHAR2(255),
  tenant_id_      VARCHAR2(255) default ''
)
tablespace USERS
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
create index ACT_IDX_HI_TASK_INST_PROCINST on ACT_HI_TASKINST (PROC_INST_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 80K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table ACT_HI_TASKINST
  add primary key (ID_)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 80K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table ACT_HI_VARINST
prompt =============================
prompt
create table ACT_HI_VARINST
(
  id_                VARCHAR2(64) not null,
  proc_inst_id_      VARCHAR2(64),
  execution_id_      VARCHAR2(64),
  task_id_           VARCHAR2(64),
  name_              VARCHAR2(255) not null,
  var_type_          VARCHAR2(100),
  rev_               INTEGER,
  bytearray_id_      VARCHAR2(64),
  double_            NUMBER(*,10),
  long_              NUMBER(19),
  text_              VARCHAR2(2000),
  text2_             VARCHAR2(2000),
  create_time_       TIMESTAMP(6),
  last_updated_time_ TIMESTAMP(6)
)
tablespace USERS
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
create index ACT_IDX_HI_PROCVAR_NAME_TYPE on ACT_HI_VARINST (NAME_, VAR_TYPE_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 80K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index ACT_IDX_HI_PROCVAR_PROC_INST on ACT_HI_VARINST (PROC_INST_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 80K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index ACT_IDX_HI_PROCVAR_TASK_ID on ACT_HI_VARINST (TASK_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 80K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table ACT_HI_VARINST
  add primary key (ID_)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 80K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table ACT_ID_GROUP
prompt ===========================
prompt
create table ACT_ID_GROUP
(
  id_   VARCHAR2(64) not null,
  rev_  INTEGER,
  name_ VARCHAR2(255),
  type_ VARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
alter table ACT_ID_GROUP
  add primary key (ID_)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table ACT_ID_INFO
prompt ==========================
prompt
create table ACT_ID_INFO
(
  id_        VARCHAR2(64) not null,
  rev_       INTEGER,
  user_id_   VARCHAR2(64),
  type_      VARCHAR2(64),
  key_       VARCHAR2(255),
  value_     VARCHAR2(255),
  password_  BLOB,
  parent_id_ VARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
alter table ACT_ID_INFO
  add primary key (ID_)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table ACT_ID_USER
prompt ==========================
prompt
create table ACT_ID_USER
(
  id_         VARCHAR2(64) not null,
  rev_        INTEGER,
  first_      VARCHAR2(255),
  last_       VARCHAR2(255),
  email_      VARCHAR2(255),
  pwd_        VARCHAR2(255),
  picture_id_ VARCHAR2(64)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
alter table ACT_ID_USER
  add primary key (ID_)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table ACT_ID_MEMBERSHIP
prompt ================================
prompt
create table ACT_ID_MEMBERSHIP
(
  user_id_  VARCHAR2(64) not null,
  group_id_ VARCHAR2(64) not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
create index ACT_IDX_MEMB_GROUP on ACT_ID_MEMBERSHIP (GROUP_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
create index ACT_IDX_MEMB_USER on ACT_ID_MEMBERSHIP (USER_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table ACT_ID_MEMBERSHIP
  add primary key (USER_ID_, GROUP_ID_)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table ACT_ID_MEMBERSHIP
  add constraint ACT_FK_MEMB_GROUP foreign key (GROUP_ID_)
  references ACT_ID_GROUP (ID_);
alter table ACT_ID_MEMBERSHIP
  add constraint ACT_FK_MEMB_USER foreign key (USER_ID_)
  references ACT_ID_USER (ID_);

prompt
prompt Creating table ACT_RE_PROCDEF
prompt =============================
prompt
create table ACT_RE_PROCDEF
(
  id_                     VARCHAR2(64) not null,
  rev_                    INTEGER,
  category_               VARCHAR2(255),
  name_                   VARCHAR2(255),
  key_                    VARCHAR2(255) not null,
  version_                INTEGER not null,
  deployment_id_          VARCHAR2(64),
  resource_name_          VARCHAR2(2000),
  dgrm_resource_name_     VARCHAR2(4000),
  description_            VARCHAR2(2000),
  has_start_form_key_     NUMBER(1),
  has_graphical_notation_ NUMBER(1),
  suspension_state_       INTEGER,
  tenant_id_              VARCHAR2(255) default ''
)
tablespace USERS
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
alter table ACT_RE_PROCDEF
  add primary key (ID_)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 80K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table ACT_RE_PROCDEF
  add constraint ACT_UNIQ_PROCDEF unique (KEY_, VERSION_, TENANT_ID_)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 80K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table ACT_RE_PROCDEF
  add check (HAS_START_FORM_KEY_ in (1, 0));
alter table ACT_RE_PROCDEF
  add check (HAS_GRAPHICAL_NOTATION_ in (1, 0));

prompt
prompt Creating table ACT_PROCDEF_INFO
prompt ===============================
prompt
create table ACT_PROCDEF_INFO
(
  id_           VARCHAR2(64) not null,
  proc_def_id_  VARCHAR2(64) not null,
  rev_          INTEGER,
  info_json_id_ VARCHAR2(64)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
create index ACT_IDX_PROCDEF_INFO_JSON on ACT_PROCDEF_INFO (INFO_JSON_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
create index ACT_IDX_PROCDEF_INFO_PROC on ACT_PROCDEF_INFO (PROC_DEF_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table ACT_PROCDEF_INFO
  add primary key (ID_)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table ACT_PROCDEF_INFO
  add constraint ACT_UNIQ_INFO_PROCDEF unique (PROC_DEF_ID_);
alter table ACT_PROCDEF_INFO
  add constraint ACT_FK_INFO_JSON_BA foreign key (INFO_JSON_ID_)
  references ACT_GE_BYTEARRAY (ID_);
alter table ACT_PROCDEF_INFO
  add constraint ACT_FK_INFO_PROCDEF foreign key (PROC_DEF_ID_)
  references ACT_RE_PROCDEF (ID_);

prompt
prompt Creating table ACT_RE_MODEL
prompt ===========================
prompt
create table ACT_RE_MODEL
(
  id_                           VARCHAR2(64) not null,
  rev_                          INTEGER,
  name_                         VARCHAR2(255),
  key_                          VARCHAR2(255),
  category_                     VARCHAR2(255),
  create_time_                  TIMESTAMP(6),
  last_update_time_             TIMESTAMP(6),
  version_                      INTEGER,
  meta_info_                    VARCHAR2(2000),
  deployment_id_                VARCHAR2(64),
  editor_source_value_id_       VARCHAR2(64),
  editor_source_extra_value_id_ VARCHAR2(64),
  tenant_id_                    VARCHAR2(255) default ''
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
create index ACT_IDX_MODEL_DEPLOYMENT on ACT_RE_MODEL (DEPLOYMENT_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
create index ACT_IDX_MODEL_SOURCE on ACT_RE_MODEL (EDITOR_SOURCE_VALUE_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
create index ACT_IDX_MODEL_SOURCE_EXTRA on ACT_RE_MODEL (EDITOR_SOURCE_EXTRA_VALUE_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table ACT_RE_MODEL
  add primary key (ID_)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table ACT_RE_MODEL
  add constraint ACT_FK_MODEL_DEPLOYMENT foreign key (DEPLOYMENT_ID_)
  references ACT_RE_DEPLOYMENT (ID_);
alter table ACT_RE_MODEL
  add constraint ACT_FK_MODEL_SOURCE foreign key (EDITOR_SOURCE_VALUE_ID_)
  references ACT_GE_BYTEARRAY (ID_);
alter table ACT_RE_MODEL
  add constraint ACT_FK_MODEL_SOURCE_EXTRA foreign key (EDITOR_SOURCE_EXTRA_VALUE_ID_)
  references ACT_GE_BYTEARRAY (ID_);

prompt
prompt Creating table ACT_RU_EXECUTION
prompt ===============================
prompt
create table ACT_RU_EXECUTION
(
  id_               VARCHAR2(64) not null,
  rev_              INTEGER,
  proc_inst_id_     VARCHAR2(64),
  business_key_     VARCHAR2(255),
  parent_id_        VARCHAR2(64),
  proc_def_id_      VARCHAR2(64),
  super_exec_       VARCHAR2(64),
  act_id_           VARCHAR2(255),
  is_active_        NUMBER(1),
  is_concurrent_    NUMBER(1),
  is_scope_         NUMBER(1),
  is_event_scope_   NUMBER(1),
  suspension_state_ INTEGER,
  cached_ent_state_ INTEGER,
  tenant_id_        VARCHAR2(255) default '',
  name_             VARCHAR2(255),
  lock_time_        TIMESTAMP(6)
)
tablespace USERS
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
create index ACT_IDX_EXEC_BUSKEY on ACT_RU_EXECUTION (BUSINESS_KEY_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 80K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index ACT_IDX_EXE_PARENT on ACT_RU_EXECUTION (PARENT_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 80K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index ACT_IDX_EXE_PROCDEF on ACT_RU_EXECUTION (PROC_DEF_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 80K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index ACT_IDX_EXE_PROCINST on ACT_RU_EXECUTION (PROC_INST_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 80K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index ACT_IDX_EXE_SUPER on ACT_RU_EXECUTION (SUPER_EXEC_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 80K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table ACT_RU_EXECUTION
  add primary key (ID_)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 80K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table ACT_RU_EXECUTION
  add constraint ACT_FK_EXE_PARENT foreign key (PARENT_ID_)
  references ACT_RU_EXECUTION (ID_);
alter table ACT_RU_EXECUTION
  add constraint ACT_FK_EXE_PROCDEF foreign key (PROC_DEF_ID_)
  references ACT_RE_PROCDEF (ID_);
alter table ACT_RU_EXECUTION
  add constraint ACT_FK_EXE_PROCINST foreign key (PROC_INST_ID_)
  references ACT_RU_EXECUTION (ID_);
alter table ACT_RU_EXECUTION
  add constraint ACT_FK_EXE_SUPER foreign key (SUPER_EXEC_)
  references ACT_RU_EXECUTION (ID_);
alter table ACT_RU_EXECUTION
  add check (IS_ACTIVE_ in (1, 0));
alter table ACT_RU_EXECUTION
  add check (IS_CONCURRENT_ in (1, 0));
alter table ACT_RU_EXECUTION
  add check (IS_SCOPE_ in (1, 0));
alter table ACT_RU_EXECUTION
  add check (IS_EVENT_SCOPE_ in (1, 0));

prompt
prompt Creating table ACT_RU_EVENT_SUBSCR
prompt ==================================
prompt
create table ACT_RU_EVENT_SUBSCR
(
  id_            VARCHAR2(64) not null,
  rev_           INTEGER,
  event_type_    VARCHAR2(255) not null,
  event_name_    VARCHAR2(255),
  execution_id_  VARCHAR2(64),
  proc_inst_id_  VARCHAR2(64),
  activity_id_   VARCHAR2(64),
  configuration_ VARCHAR2(255),
  created_       TIMESTAMP(6) not null,
  proc_def_id_   VARCHAR2(64),
  tenant_id_     VARCHAR2(255) default ''
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
create index ACT_IDX_EVENT_SUBSCR on ACT_RU_EVENT_SUBSCR (EXECUTION_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
create index ACT_IDX_EVENT_SUBSCR_CONFIG_ on ACT_RU_EVENT_SUBSCR (CONFIGURATION_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table ACT_RU_EVENT_SUBSCR
  add primary key (ID_)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table ACT_RU_EVENT_SUBSCR
  add constraint ACT_FK_EVENT_EXEC foreign key (EXECUTION_ID_)
  references ACT_RU_EXECUTION (ID_);

prompt
prompt Creating table ACT_RU_TASK
prompt ==========================
prompt
create table ACT_RU_TASK
(
  id_               VARCHAR2(64) not null,
  rev_              INTEGER,
  execution_id_     VARCHAR2(64),
  proc_inst_id_     VARCHAR2(64),
  proc_def_id_      VARCHAR2(64),
  name_             VARCHAR2(255),
  parent_task_id_   VARCHAR2(64),
  description_      VARCHAR2(2000),
  task_def_key_     VARCHAR2(255),
  owner_            VARCHAR2(255),
  assignee_         VARCHAR2(255),
  delegation_       VARCHAR2(64),
  priority_         INTEGER,
  create_time_      TIMESTAMP(6),
  due_date_         TIMESTAMP(6),
  category_         VARCHAR2(255),
  suspension_state_ INTEGER,
  tenant_id_        VARCHAR2(255) default '',
  form_key_         VARCHAR2(255)
)
tablespace USERS
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
create index ACT_IDX_TASK_CREATE on ACT_RU_TASK (CREATE_TIME_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 80K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index ACT_IDX_TASK_EXEC on ACT_RU_TASK (EXECUTION_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 80K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index ACT_IDX_TASK_PROCDEF on ACT_RU_TASK (PROC_DEF_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 80K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index ACT_IDX_TASK_PROCINST on ACT_RU_TASK (PROC_INST_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 80K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table ACT_RU_TASK
  add primary key (ID_)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 80K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table ACT_RU_TASK
  add constraint ACT_FK_TASK_EXE foreign key (EXECUTION_ID_)
  references ACT_RU_EXECUTION (ID_);
alter table ACT_RU_TASK
  add constraint ACT_FK_TASK_PROCDEF foreign key (PROC_DEF_ID_)
  references ACT_RE_PROCDEF (ID_);
alter table ACT_RU_TASK
  add constraint ACT_FK_TASK_PROCINST foreign key (PROC_INST_ID_)
  references ACT_RU_EXECUTION (ID_);

prompt
prompt Creating table ACT_RU_IDENTITYLINK
prompt ==================================
prompt
create table ACT_RU_IDENTITYLINK
(
  id_           VARCHAR2(64) not null,
  rev_          INTEGER,
  group_id_     VARCHAR2(255),
  type_         VARCHAR2(255),
  user_id_      VARCHAR2(255),
  task_id_      VARCHAR2(64),
  proc_inst_id_ VARCHAR2(64),
  proc_def_id_  VARCHAR2(64)
)
tablespace USERS
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
create index ACT_IDX_ATHRZ_PROCEDEF on ACT_RU_IDENTITYLINK (PROC_DEF_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 80K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index ACT_IDX_IDENT_LNK_GROUP on ACT_RU_IDENTITYLINK (GROUP_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 80K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index ACT_IDX_IDENT_LNK_USER on ACT_RU_IDENTITYLINK (USER_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 80K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index ACT_IDX_IDL_PROCINST on ACT_RU_IDENTITYLINK (PROC_INST_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 80K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index ACT_IDX_TSKASS_TASK on ACT_RU_IDENTITYLINK (TASK_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 80K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table ACT_RU_IDENTITYLINK
  add primary key (ID_)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 80K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table ACT_RU_IDENTITYLINK
  add constraint ACT_FK_ATHRZ_PROCEDEF foreign key (PROC_DEF_ID_)
  references ACT_RE_PROCDEF (ID_);
alter table ACT_RU_IDENTITYLINK
  add constraint ACT_FK_IDL_PROCINST foreign key (PROC_INST_ID_)
  references ACT_RU_EXECUTION (ID_);
alter table ACT_RU_IDENTITYLINK
  add constraint ACT_FK_TSKASS_TASK foreign key (TASK_ID_)
  references ACT_RU_TASK (ID_);

prompt
prompt Creating table ACT_RU_JOB
prompt =========================
prompt
create table ACT_RU_JOB
(
  id_                  VARCHAR2(64) not null,
  rev_                 INTEGER,
  type_                VARCHAR2(255) not null,
  lock_exp_time_       TIMESTAMP(6),
  lock_owner_          VARCHAR2(255),
  exclusive_           NUMBER(1),
  execution_id_        VARCHAR2(64),
  process_instance_id_ VARCHAR2(64),
  proc_def_id_         VARCHAR2(64),
  retries_             INTEGER,
  exception_stack_id_  VARCHAR2(64),
  exception_msg_       VARCHAR2(2000),
  duedate_             TIMESTAMP(6),
  repeat_              VARCHAR2(255),
  handler_type_        VARCHAR2(255),
  handler_cfg_         VARCHAR2(2000),
  tenant_id_           VARCHAR2(255) default ''
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
create index ACT_IDX_JOB_EXCEPTION on ACT_RU_JOB (EXCEPTION_STACK_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table ACT_RU_JOB
  add primary key (ID_)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table ACT_RU_JOB
  add constraint ACT_FK_JOB_EXCEPTION foreign key (EXCEPTION_STACK_ID_)
  references ACT_GE_BYTEARRAY (ID_);
alter table ACT_RU_JOB
  add check (EXCLUSIVE_ in (1, 0));

prompt
prompt Creating table ACT_RU_VARIABLE
prompt ==============================
prompt
create table ACT_RU_VARIABLE
(
  id_           VARCHAR2(64) not null,
  rev_          INTEGER,
  type_         VARCHAR2(255) not null,
  name_         VARCHAR2(255) not null,
  execution_id_ VARCHAR2(64),
  proc_inst_id_ VARCHAR2(64),
  task_id_      VARCHAR2(64),
  bytearray_id_ VARCHAR2(64),
  double_       NUMBER(*,10),
  long_         NUMBER(19),
  text_         VARCHAR2(2000),
  text2_        VARCHAR2(2000)
)
tablespace USERS
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
create index ACT_IDX_VARIABLE_TASK_ID on ACT_RU_VARIABLE (TASK_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 80K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index ACT_IDX_VAR_BYTEARRAY on ACT_RU_VARIABLE (BYTEARRAY_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 80K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index ACT_IDX_VAR_EXE on ACT_RU_VARIABLE (EXECUTION_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 80K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index ACT_IDX_VAR_PROCINST on ACT_RU_VARIABLE (PROC_INST_ID_)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 80K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table ACT_RU_VARIABLE
  add primary key (ID_)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 80K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table ACT_RU_VARIABLE
  add constraint ACT_FK_VAR_BYTEARRAY foreign key (BYTEARRAY_ID_)
  references ACT_GE_BYTEARRAY (ID_);
alter table ACT_RU_VARIABLE
  add constraint ACT_FK_VAR_EXE foreign key (EXECUTION_ID_)
  references ACT_RU_EXECUTION (ID_);
alter table ACT_RU_VARIABLE
  add constraint ACT_FK_VAR_PROCINST foreign key (PROC_INST_ID_)
  references ACT_RU_EXECUTION (ID_);

prompt
prompt Creating table ATTACHMENT
prompt =========================
prompt
create table ATTACHMENT
(
  attachment_sid  NUMBER(16) not null,
  fk_sid          NUMBER(16) not null,
  attachment_nm   VARCHAR2(100) not null,
  attachment_desc VARCHAR2(1000),
  attachment_type INTEGER not null,
  content         BLOB,
  sizein_mb       NUMBER(20,4),
  updt_by         NUMBER(16) not null,
  updt_dt         TIMESTAMP(6) not null
)
tablespace CS_MASTER_TEST
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
alter table ATTACHMENT
  add constraint PK_ATTACHMENT primary key (ATTACHMENT_SID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table BOND_ABSINFO
prompt ===========================
prompt
create table BOND_ABSINFO
(
  bond_absinfo_sid  NUMBER(16) not null,
  secinner_id       NUMBER(16) not null,
  abs_cd            VARCHAR2(30) not null,
  abs_snm           VARCHAR2(200),
  abs_nm            VARCHAR2(400),
  found_dt          DATE,
  base_asset_id     NUMBER(16),
  base_asset2_id    NUMBER(16),
  base_asset_desc   VARCHAR2(1000),
  priority_level_id NUMBER(16),
  credit_typein_id  NUMBER(16),
  remark            VARCHAR2(2000),
  isdel             INTEGER not null,
  src_portfolio_cd  VARCHAR2(30) not null,
  srcid             VARCHAR2(100),
  src_cd            VARCHAR2(10) not null,
  updt_dt           TIMESTAMP(6) not null
)
tablespace USERS
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

prompt
prompt Creating table BOND_BASICINFO
prompt =============================
prompt
create table BOND_BASICINFO
(
  secinner_id        NUMBER(16) not null,
  security_cd        VARCHAR2(20),
  security_nm        VARCHAR2(300) not null,
  security_snm       VARCHAR2(200),
  spell              VARCHAR2(60),
  security_type_id   NUMBER(16),
  issue_year         INTEGER,
  issue_num          INTEGER,
  currency           VARCHAR2(6),
  trade_market_id    NUMBER(16),
  notice_dt          DATE,
  create_dt          DATE,
  public_dt          DATE,
  public_announce_dt DATE,
  issue_dt           DATE,
  frst_value_dt      DATE,
  last_value_dt      DATE,
  puttable_dt        DATE,
  mrty_dt            DATE,
  payment_dt         DATE,
  redem_dt           DATE,
  delist_dt          DATE,
  pay_day            VARCHAR2(100),
  bond_type1_id      NUMBER(16),
  bond_type2_id      NUMBER(16),
  bond_form_id       NUMBER(16),
  other_nature       VARCHAR2(200),
  credit_rating      VARCHAR2(30),
  issue_vol          NUMBER(20,4),
  listvolsz          NUMBER(20,4),
  listvolsh          NUMBER(20,4),
  bond_period        INTEGER,
  par_value          NUMBER(20,4),
  issue_price        NUMBER(20,4),
  coupon_type_cd     INTEGER,
  pay_type_cd        INTEGER,
  pay_desc           VARCHAR2(1000),
  coupon_rule_cd     INTEGER,
  payment_type_cd    INTEGER,
  coupon_rate        NUMBER(20,4),
  floor_rate         NUMBER(20,4),
  bnchmk_spread      NUMBER(20,4),
  bnchmk_id          NUMBER(16),
  rate_desc          VARCHAR2(1600),
  pay_peryear        INTEGER,
  add_rate           NUMBER(20,4),
  puttable_price     NUMBER(20,4),
  expect_rate        VARCHAR2(30),
  issue_type_cd      INTEGER,
  refe_rate          NUMBER(20,4),
  add_issue_num      INTEGER,
  is_cross           INTEGER,
  is_floor_rate      INTEGER,
  is_adjust_type     INTEGER,
  is_redem           INTEGER,
  is_plit_debt       INTEGER,
  is_puttable        INTEGER,
  is_change          INTEGER,
  fwd_rate           NUMBER(20,4),
  redem_price        NUMBER(20,4),
  swaps_cd           VARCHAR2(20),
  tax_rate           NUMBER(20,4),
  coupon_style_cd    INTEGER,
  option_termdes     VARCHAR2(200),
  base_asset         VARCHAR2(1000),
  coupon_method_cd   INTEGER,
  bond_option        VARCHAR2(80),
  credit_typein_id   NUMBER(16),
  credit_typeout_id  NUMBER(16),
  remark             VARCHAR2(2000),
  src_portfolio_cd   VARCHAR2(30),
  isdel              INTEGER not null,
  src_cd             VARCHAR2(10) not null,
  updt_by            NUMBER(16) not null,
  updt_dt            TIMESTAMP(6) not null
)
tablespace CS_MASTER_TEST
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
alter table BOND_BASICINFO
  add constraint PK_BOND_BASICINFO primary key (SECINNER_ID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table BOND_CREDITCHG
prompt =============================
prompt
create table BOND_CREDITCHG
(
  bond_creditchg_sid NUMBER(16) not null,
  secinner_id        NUMBER(16) not null,
  change_dt          DATE,
  rating             VARCHAR2(30) not null,
  credit_id          NUMBER(16) not null,
  credit_nm          VARCHAR2(300) not null,
  reason             VARCHAR2(800),
  notice_dt          DATE,
  rating_type_cd     INTEGER,
  rating_style_cd    INTEGER,
  change_way_cd      INTEGER,
  rating_fwd_cd      INTEGER,
  remark             VARCHAR2(1000),
  isdel              INTEGER not null,
  src_portfolio_cd   VARCHAR2(30) not null,
  srcid              VARCHAR2(100),
  src_cd             VARCHAR2(10) not null,
  updt_dt            TIMESTAMP(6) not null
)
tablespace CS_MASTER_TEST
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
alter table BOND_CREDITCHG
  add constraint PK_BOND_CREDITCHG primary key (BOND_CREDITCHG_SID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table BOND_DAILYTRADE
prompt ==============================
prompt
create table BOND_DAILYTRADE
(
  bond_dailytrade_sid  NUMBER(16) not null,
  secinner_id          NUMBER(16) not null,
  trade_dt             DATE,
  open_netprice        NUMBER(24,4),
  close_netprice       NUMBER(24,4),
  high_netprice        NUMBER(24,4),
  low_netprice         NUMBER(24,4),
  avg_netprice         NUMBER(24,4),
  last_close_netprice  NUMBER(24,4),
  last_avg_netprice    NUMBER(24,4),
  open_fullprice       NUMBER(24,4),
  close_fullprice      NUMBER(24,4),
  high_fullprice       NUMBER(24,4),
  low_fullprice        NUMBER(24,4),
  avg_fullprice        NUMBER(24,4),
  last_close_fullprice NUMBER(24,4),
  last_avg_fullprice   NUMBER(24,4),
  total_vol            NUMBER(24,4),
  total_value          NUMBER(24,4),
  total_amount         INTEGER,
  chg                  NUMBER(24,4),
  open_ytm             NUMBER(24,4),
  close_ytm            NUMBER(24,4),
  high_ytm             NUMBER(24,4),
  low_ytm              NUMBER(24,4),
  avg_ytm              NUMBER(24,4),
  last_close_ytm       NUMBER(24,4),
  last_avg_ytm         NUMBER(24,4),
  chg_ytm              NUMBER(24,4),
  chg_netprice         NUMBER(24,4),
  isdel                INTEGER not null,
  src_secinner_cd      VARCHAR2(30) not null,
  srcid                VARCHAR2(100),
  src_cd               VARCHAR2(10) not null,
  updt_dt              TIMESTAMP(6) not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table BOND_DAILYTRADE
  is 'TGT-债券日行情';
comment on column BOND_DAILYTRADE.bond_dailytrade_sid
  is '标识符';
comment on column BOND_DAILYTRADE.secinner_id
  is '证券内码标识符';
comment on column BOND_DAILYTRADE.trade_dt
  is '交易日期';
comment on column BOND_DAILYTRADE.open_netprice
  is '开盘净价';
comment on column BOND_DAILYTRADE.close_netprice
  is '收盘净价';
comment on column BOND_DAILYTRADE.high_netprice
  is '最高净价';
comment on column BOND_DAILYTRADE.low_netprice
  is '最低净价';
comment on column BOND_DAILYTRADE.avg_netprice
  is '净价加权价';
comment on column BOND_DAILYTRADE.last_close_netprice
  is '前收盘净价';
comment on column BOND_DAILYTRADE.last_avg_netprice
  is '前净价加权价';
comment on column BOND_DAILYTRADE.open_fullprice
  is '开盘全价';
comment on column BOND_DAILYTRADE.close_fullprice
  is '收盘全价';
comment on column BOND_DAILYTRADE.high_fullprice
  is '最高全价';
comment on column BOND_DAILYTRADE.low_fullprice
  is '最低全价';
comment on column BOND_DAILYTRADE.avg_fullprice
  is '全价加权价';
comment on column BOND_DAILYTRADE.last_close_fullprice
  is '前收盘全价';
comment on column BOND_DAILYTRADE.last_avg_fullprice
  is '前全价加权价';
comment on column BOND_DAILYTRADE.total_vol
  is '成交量(元)';
comment on column BOND_DAILYTRADE.total_value
  is '成交金额(元)';
comment on column BOND_DAILYTRADE.total_amount
  is '成交笔数';
comment on column BOND_DAILYTRADE.chg
  is '涨跌';
comment on column BOND_DAILYTRADE.open_ytm
  is '开盘收益率';
comment on column BOND_DAILYTRADE.close_ytm
  is '收盘收益率';
comment on column BOND_DAILYTRADE.high_ytm
  is '最高收益率';
comment on column BOND_DAILYTRADE.low_ytm
  is '最低收益率';
comment on column BOND_DAILYTRADE.avg_ytm
  is '加权收益率';
comment on column BOND_DAILYTRADE.last_close_ytm
  is '前收盘收益率';
comment on column BOND_DAILYTRADE.last_avg_ytm
  is '前加权收益率';
comment on column BOND_DAILYTRADE.chg_ytm
  is '收益率涨跌(BP)';
comment on column BOND_DAILYTRADE.chg_netprice
  is '净价涨跌幅';
comment on column BOND_DAILYTRADE.isdel
  is '是否删除';
comment on column BOND_DAILYTRADE.src_secinner_cd
  is '源债券唯一编码';
comment on column BOND_DAILYTRADE.srcid
  is '源系统主键';
comment on column BOND_DAILYTRADE.src_cd
  is '源系统';
comment on column BOND_DAILYTRADE.updt_dt
  is '更新时间';

prompt
prompt Creating table BOND_DANALYSIS
prompt =============================
prompt
create table BOND_DANALYSIS
(
  bond_danalysis_sid   NUMBER(16) not null,
  secinner_id          NUMBER(16) not null,
  trade_dt             DATE,
  open_netprice        NUMBER(24,4),
  close_netprice       NUMBER(24,4),
  high_netprice        NUMBER(24,4),
  low_netprice         NUMBER(24,4),
  avg_netprice         NUMBER(24,4),
  last_close_netprice  NUMBER(24,4),
  last_avg_netprice    NUMBER(24,4),
  open_fullprice       NUMBER(24,4),
  close_fullprice      NUMBER(24,4),
  high_fullprice       NUMBER(24,4),
  low_fullprice        NUMBER(24,4),
  avg_fullprice        NUMBER(24,4),
  last_close_fullprice NUMBER(24,4),
  last_avg_fullprice   NUMBER(24,4),
  total_vol            NUMBER(24,4),
  total_value          NUMBER(24,4),
  total_amount         INTEGER,
  open_ytm             NUMBER(24,8),
  close_ytm            NUMBER(24,8),
  high_ytm             NUMBER(24,8),
  low_ytm              NUMBER(24,8),
  avg_ytm              NUMBER(24,8),
  last_close_ytm       NUMBER(24,8),
  last_avg_ytm         NUMBER(24,8),
  chg_netprice         NUMBER(24,8),
  ai                   NUMBER(24,8),
  full_chgrate         NUMBER(24,8),
  redem_ytm            NUMBER(24,8),
  ai_days              INTEGER,
  basis_value          NUMBER(24,8),
  eff_convexity        NUMBER(24,8),
  tomrty_day           INTEGER,
  tomrty_year          NUMBER(24,8),
  convexity            NUMBER(24,8),
  margin_convexity     NUMBER(24,8),
  margin_duration      NUMBER(24,8),
  duration             NUMBER(24,8),
  basic_duration       NUMBER(24,8),
  modified_duration    NUMBER(24,8),
  short_duration       NUMBER(24,8),
  long_duration        NUMBER(24,8),
  eff_duration         NUMBER(24,8),
  duration_1m          NUMBER(24,8),
  duration_3m          NUMBER(24,8),
  duration_6m          NUMBER(24,8),
  duration_year        NUMBER(24,8),
  duration_1y          NUMBER(24,8),
  duration_2y          NUMBER(24,8),
  duration_3y          NUMBER(24,8),
  duration_4y          NUMBER(24,8),
  duration_5y          NUMBER(24,8),
  duration_7y          NUMBER(24,8),
  duration_9y          NUMBER(24,8),
  duration_10y         NUMBER(24,8),
  duration_15y         NUMBER(24,8),
  duration_20y         NUMBER(24,8),
  duration_30y         NUMBER(24,8),
  isdel                INTEGER not null,
  src_secinner_cd      VARCHAR2(30) not null,
  srcid                VARCHAR2(100),
  src_cd               VARCHAR2(10) not null,
  updt_dt              TIMESTAMP(6) not null
)
tablespace USERS
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
comment on table BOND_DANALYSIS
  is 'TGT-债券日行情分析指标';
comment on column BOND_DANALYSIS.bond_danalysis_sid
  is '标识符';
comment on column BOND_DANALYSIS.secinner_id
  is '证券内码';
comment on column BOND_DANALYSIS.trade_dt
  is '交易日期';
comment on column BOND_DANALYSIS.open_netprice
  is '开盘净价';
comment on column BOND_DANALYSIS.close_netprice
  is '收盘净价';
comment on column BOND_DANALYSIS.high_netprice
  is '最高净价';
comment on column BOND_DANALYSIS.low_netprice
  is '最低净价';
comment on column BOND_DANALYSIS.avg_netprice
  is '净价加权价';
comment on column BOND_DANALYSIS.last_close_netprice
  is '前收盘净价';
comment on column BOND_DANALYSIS.last_avg_netprice
  is '前净价加权价';
comment on column BOND_DANALYSIS.open_fullprice
  is '开盘全价';
comment on column BOND_DANALYSIS.close_fullprice
  is '收盘全价';
comment on column BOND_DANALYSIS.high_fullprice
  is '最高全价';
comment on column BOND_DANALYSIS.low_fullprice
  is '最低全价';
comment on column BOND_DANALYSIS.avg_fullprice
  is '全价加权价';
comment on column BOND_DANALYSIS.last_close_fullprice
  is '前收盘全价';
comment on column BOND_DANALYSIS.last_avg_fullprice
  is '前全价加权价';
comment on column BOND_DANALYSIS.total_vol
  is '成交量(元)';
comment on column BOND_DANALYSIS.total_value
  is '成交金额(元)';
comment on column BOND_DANALYSIS.total_amount
  is '成交笔数';
comment on column BOND_DANALYSIS.open_ytm
  is '开盘收益率';
comment on column BOND_DANALYSIS.close_ytm
  is '收盘收益率';
comment on column BOND_DANALYSIS.high_ytm
  is '最高收益率';
comment on column BOND_DANALYSIS.low_ytm
  is '最低收益率';
comment on column BOND_DANALYSIS.avg_ytm
  is '加权收益率';
comment on column BOND_DANALYSIS.last_close_ytm
  is '前收盘收益率';
comment on column BOND_DANALYSIS.last_avg_ytm
  is '前加权收益率';
comment on column BOND_DANALYSIS.chg_netprice
  is '净价涨跌幅';
comment on column BOND_DANALYSIS.ai
  is '当日每百元应计利息';
comment on column BOND_DANALYSIS.full_chgrate
  is '全价涨跌幅(%)';
comment on column BOND_DANALYSIS.redem_ytm
  is '赎回/回售收益率(%)';
comment on column BOND_DANALYSIS.ai_days
  is '已计息天数';
comment on column BOND_DANALYSIS.basis_value
  is '基点价值';
comment on column BOND_DANALYSIS.eff_convexity
  is '有效凸性';
comment on column BOND_DANALYSIS.tomrty_day
  is '剩余期限(天)';
comment on column BOND_DANALYSIS.tomrty_year
  is '剩余期限(年)';
comment on column BOND_DANALYSIS.convexity
  is '凸性';
comment on column BOND_DANALYSIS.margin_convexity
  is '利差凸性';
comment on column BOND_DANALYSIS.margin_duration
  is '利差久期';
comment on column BOND_DANALYSIS.duration
  is '久期';
comment on column BOND_DANALYSIS.basic_duration
  is '基础久期';
comment on column BOND_DANALYSIS.modified_duration
  is '修正久期';
comment on column BOND_DANALYSIS.short_duration
  is '短边久期';
comment on column BOND_DANALYSIS.long_duration
  is '长边久期';
comment on column BOND_DANALYSIS.eff_duration
  is '有效久期';
comment on column BOND_DANALYSIS.duration_1m
  is '1月久期';
comment on column BOND_DANALYSIS.duration_3m
  is '3月久期';
comment on column BOND_DANALYSIS.duration_6m
  is '6月久期';
comment on column BOND_DANALYSIS.duration_year
  is '一年内久期';
comment on column BOND_DANALYSIS.duration_1y
  is '1年久期';
comment on column BOND_DANALYSIS.duration_2y
  is '2年久期';
comment on column BOND_DANALYSIS.duration_3y
  is '3年久期';
comment on column BOND_DANALYSIS.duration_4y
  is '4年久期';
comment on column BOND_DANALYSIS.duration_5y
  is '5年久期';
comment on column BOND_DANALYSIS.duration_7y
  is '7年久期';
comment on column BOND_DANALYSIS.duration_9y
  is '9年久期';
comment on column BOND_DANALYSIS.duration_10y
  is '10年久期';
comment on column BOND_DANALYSIS.duration_15y
  is '15年久期';
comment on column BOND_DANALYSIS.duration_20y
  is '20年久期';
comment on column BOND_DANALYSIS.duration_30y
  is '30年久期';
comment on column BOND_DANALYSIS.isdel
  is '是否删除';
comment on column BOND_DANALYSIS.src_secinner_cd
  is '源债券唯一编码';
comment on column BOND_DANALYSIS.srcid
  is '源系统主键';
comment on column BOND_DANALYSIS.src_cd
  is '源系统';
comment on column BOND_DANALYSIS.updt_dt
  is '更新时间';
alter table BOND_DANALYSIS
  add constraint PK_BOND_DANALYSIS primary key (BOND_DANALYSIS_SID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 80K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table BOND_EXPECTCASH
prompt ==============================
prompt
create table BOND_EXPECTCASH
(
  bond_expectcash_sid NUMBER(16) not null,
  secinner_id         NUMBER(16) not null,
  start_dt            DATE,
  end_dt              DATE,
  cash_dt             DATE not null,
  pay_startdt         DATE,
  pay_enddt           DATE,
  pay_otherdt         VARCHAR2(1000),
  right_dt            DATE,
  register_dt         DATE,
  pay_object          VARCHAR2(2000),
  coupon_rate         NUMBER(20,4),
  cash_ai             NUMBER(20,4),
  cash_prin           NUMBER(20,4),
  cash_prinai         NUMBER(20,4),
  prin_vol            NUMBER(20,8),
  payment_vol         NUMBER(20,8),
  cash_vol            NUMBER(20,8),
  pay_vol             NUMBER(20,8),
  isdel               INTEGER not null,
  src_secinner_cd     VARCHAR2(30) not null,
  srcid               VARCHAR2(100),
  src_cd              VARCHAR2(10) not null,
  updt_dt             TIMESTAMP(6) not null
)
tablespace USERS
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

prompt
prompt Creating table BOND_FACTOR
prompt ==========================
prompt
create table BOND_FACTOR
(
  factor_cd        VARCHAR2(30) not null,
  factor_nm        VARCHAR2(200) not null,
  factor_type      VARCHAR2(60) not null,
  parent_factor_cd VARCHAR2(30),
  factor_level     INTEGER not null,
  description      VARCHAR2(1000),
  formula_ch       VARCHAR2(2000),
  formula_en       VARCHAR2(2000),
  remark           VARCHAR2(1000),
  isdel            INTEGER,
  client_id        NUMBER(16) not null,
  updt_by          NUMBER(16) not null,
  updt_dt          TIMESTAMP(6) not null
)
tablespace CS_MASTER_TEST
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

prompt
prompt Creating table BOND_FACTOR_DATA
prompt ===============================
prompt
create table BOND_FACTOR_DATA
(
  bond_factor_data_sid NUMBER(16) not null,
  secinner_id          NUMBER(16) not null,
  factor_cd            VARCHAR2(30) not null,
  factor_value         VARCHAR2(600) not null,
  option_num           INTEGER,
  ratio                NUMBER(10,4),
  rpt_dt               DATE,
  client_id            NUMBER(16) not null,
  updt_by              NUMBER(16) not null,
  updt_dt              TIMESTAMP(6) not null
)
tablespace CS_MASTER_TEST
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
alter table BOND_FACTOR_DATA
  add constraint PK_BOND_FACTOR_DATA primary key (BOND_FACTOR_DATA_SID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 80K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table BOND_FACTOR_OPTION
prompt =================================
prompt
create table BOND_FACTOR_OPTION
(
  bond_factor_option_sid NUMBER(16) not null,
  factor_cd              VARCHAR2(30) not null,
  option_type            VARCHAR2(300),
  option                 VARCHAR2(300),
  option_num             INTEGER not null,
  ratio                  NUMBER(10,4) not null,
  low_bound              NUMBER(10,4),
  remark                 VARCHAR2(1000),
  isdel                  INTEGER,
  client_id              NUMBER(16) not null,
  updt_by                NUMBER(16) not null,
  updt_dt                TIMESTAMP(6) not null
)
tablespace CS_MASTER_TEST
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
alter table BOND_FACTOR_OPTION
  add constraint PK_BOND_FACTOR_OPTION primary key (BOND_FACTOR_OPTION_SID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table BOND_ISSUE
prompt =========================
prompt
create table BOND_ISSUE
(
  bond_issue_sid   NUMBER(16) not null,
  secinner_id      NUMBER(16) not null,
  notice_dt        DATE,
  first_notice_dt  DATE,
  latest_updt_dt   DATE,
  issue_startdt    DATE,
  issue_enddt      DATE,
  issue_fee        NUMBER(20,4),
  issue_object     VARCHAR2(2000),
  par_value        NUMBER(20,4),
  refe_rate        NUMBER(20,4),
  issue_price      NUMBER(20,4),
  issue_state_id   NUMBER(16),
  issue_method_id  NUMBER(16),
  issue_feerate    NUMBER(20,4),
  pay_feerate      NUMBER(20,4),
  issue_type_cd    INTEGER,
  avg_period       NUMBER(20,4),
  plan_mrtydt      DATE,
  plan_issuevol    NUMBER(20,4),
  act_issuevol     NUMBER(20,4),
  act_onlinevol    NUMBER(20,4),
  act_offlinevol   NUMBER(20,4),
  act_collectval   NUMBER(20,4),
  total_issuevol   NUMBER(20,4),
  agree_issuevol   NUMBER(20,4),
  udwrt_method_id  NUMBER(16),
  udwrt_value      NUMBER(20,8),
  udwrt_fee        NUMBER(20,4),
  udwrt_vol        INTEGER,
  alluudwrt_vol    INTEGER,
  low_buywal       NUMBER(20,4),
  add_buywal       NUMBER(20,4),
  bid_mark_id      NUMBER(16),
  bid_method_id    NUMBER(16),
  bid_date         DATE,
  bid_floor        NUMBER(20,4),
  bid_limit        NUMBER(20,4),
  pay_dt           DATE,
  addissue_num     INTEGER,
  state_desc       VARCHAR2(2000),
  bfin_cd          VARCHAR2(100),
  addb_cd          VARCHAR2(100),
  register_id      VARCHAR2(200),
  remark           VARCHAR2(4000),
  isdel            INTEGER not null,
  src_portfolio_cd VARCHAR2(30) not null,
  srcid            VARCHAR2(100),
  src_cd           VARCHAR2(10) not null,
  updt_dt          TIMESTAMP(6) not null
)
tablespace USERS
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

prompt
prompt Creating table BOND_NCCONVRATE
prompt ==============================
prompt
create table BOND_NCCONVRATE
(
  bond_ncconvrate_sid NUMBER(16) not null,
  secinner_id         NUMBER(16) not null,
  start_dt            DATE,
  end_dt              DATE,
  conv_rate           NUMBER(24,8),
  isdel               INTEGER not null,
  src_secinner_cd     VARCHAR2(30) not null,
  srcid               VARCHAR2(100),
  src_cd              VARCHAR2(10) not null,
  updt_dt             TIMESTAMP(6) not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
alter table BOND_NCCONVRATE
  add constraint PK_BOND_NCCONVRATE primary key (BOND_NCCONVRATE_SID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table BOND_OPVOLCHG
prompt ============================
prompt
create table BOND_OPVOLCHG
(
  bond_opvolchg_sid NUMBER(16) not null,
  secinner_id       NUMBER(16) not null,
  latest_updt_dt    DATE,
  notice_dt         DATE,
  change_dt         DATE,
  chg_type_id       NUMBER(16) not null,
  chg_vol           NUMBER(24,8),
  remain_vol        NUMBER(24,8),
  data_src          VARCHAR2(2000),
  remark            VARCHAR2(2000),
  isdel             INTEGER not null,
  src_portfolio_cd  VARCHAR2(30) not null,
  srcid             VARCHAR2(100),
  src_cd            VARCHAR2(10) not null,
  updt_dt           TIMESTAMP(6) not null
)
tablespace CS_MASTER_TEST
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
alter table BOND_OPVOLCHG
  add constraint PK_BOND_OPVOLCHG primary key (BOND_OPVOLCHG_SID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table BOND_PARTY
prompt =========================
prompt
create table BOND_PARTY
(
  bond_party_sid NUMBER(16) not null,
  secinner_id    NUMBER(16) not null,
  notice_dt      DATE,
  party_id       NUMBER(16),
  party_nm       VARCHAR2(300) not null,
  party_type_id  NUMBER(16) not null,
  start_dt       DATE,
  end_dt         DATE,
  isdel          INTEGER not null,
  srcid          VARCHAR2(100),
  src_cd         VARCHAR2(10) not null,
  updt_by        NUMBER(16) not null,
  updt_dt        TIMESTAMP(6) not null
)
tablespace CS_MASTER_TEST
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
alter table BOND_PARTY
  add constraint PK_BOND_PARTY primary key (BOND_PARTY_SID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table BOND_PLEDGE
prompt ==========================
prompt
create table BOND_PLEDGE
(
  bond_pledge_sid   NUMBER(16) not null,
  secinner_id       NUMBER(16) not null,
  notice_dt         DATE,
  pledge_nm         VARCHAR2(300) not null,
  pledge_type_id    NUMBER(16),
  pledge_desc       VARCHAR2(2000),
  pledge_owner_id   NUMBER(16),
  pledge_owner      VARCHAR2(300),
  pledge_value      NUMBER(20,4),
  priority_value    NUMBER(20,4),
  pledge_depend_id  NUMBER(16),
  pledge_control_id NUMBER(16),
  region            INTEGER,
  mitigation_value  NUMBER(20,4),
  isdel             INTEGER not null,
  srcid             VARCHAR2(100),
  src_cd            VARCHAR2(10) not null,
  updt_by           NUMBER(16) not null,
  updt_dt           TIMESTAMP(6) not null
)
tablespace CS_MASTER_TEST
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
alter table BOND_PLEDGE
  add constraint PK_BOND_PLEDGE primary key (BOND_PLEDGE_SID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table BOND_POOL
prompt ========================
prompt
create table BOND_POOL
(
  bond_pool_id  NUMBER(16) not null,
  pool_nm       VARCHAR2(300) not null,
  group_type    INTEGER not null,
  type          INTEGER not null,
  is_default    INTEGER not null,
  regulation_id NUMBER(16),
  description   VARCHAR2(1000),
  remark        VARCHAR2(1000),
  isdel         INTEGER,
  create_by     NUMBER(16) not null,
  create_dt     TIMESTAMP(6) not null,
  updt_by       NUMBER(16) not null,
  updt_dt       TIMESTAMP(6) not null
)
tablespace USERS
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
alter table BOND_POOL
  add constraint PK_BOND_POOL primary key (BOND_POOL_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 80K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table BOND_POOL_ITEM
prompt =============================
prompt
create table BOND_POOL_ITEM
(
  bond_pool_item_sid NUMBER(16) not null,
  bond_pool_id       NUMBER(16) not null,
  item_id            INTEGER not null,
  isdel              INTEGER not null,
  updt_by            NUMBER(16) not null,
  updt_dt            TIMESTAMP(6) not null
)
tablespace USERS
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
alter table BOND_POOL_ITEM
  add constraint PK_BOND_POOL_ITEM primary key (BOND_POOL_ITEM_SID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 80K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table BOND_POSITION_OUT
prompt ================================
prompt
create table BOND_POSITION_OUT
(
  bond_position_out_sid NUMBER(16) not null,
  secinner_id           NUMBER(16),
  security_cd           VARCHAR2(100),
  security_nm           VARCHAR2(300),
  trade_market_id       NUMBER(16),
  trustee_nm            VARCHAR2(300),
  porfolio_cd           VARCHAR2(50),
  portfolio_nm          VARCHAR2(300),
  end_dt                DATE not null,
  currency              VARCHAR2(10),
  amt_cost              NUMBER(38,10),
  amt_marketvalue       NUMBER(38,10),
  position_num          NUMBER(38,10),
  strategy_l1           VARCHAR2(100),
  strategy_l2           VARCHAR2(100),
  strategy_l3           VARCHAR2(100),
  is_valid              INTEGER,
  tsid                  VARCHAR2(100) not null,
  src_updt_dt           TIMESTAMP(6),
  isdel                 INTEGER not null,
  updt_by               NUMBER(16) not null,
  updt_dt               TIMESTAMP(6) not null
)
tablespace USERS
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
comment on table BOND_POSITION_OUT
  is 'TGT-委外持仓';
comment on column BOND_POSITION_OUT.bond_position_out_sid
  is '自主持仓流水号';
comment on column BOND_POSITION_OUT.secinner_id
  is '债券标识符';
comment on column BOND_POSITION_OUT.security_cd
  is '债券代码';
comment on column BOND_POSITION_OUT.security_nm
  is '债券全称';
comment on column BOND_POSITION_OUT.trade_market_id
  is '交易市场';
comment on column BOND_POSITION_OUT.trustee_nm
  is '委外机构名称';
comment on column BOND_POSITION_OUT.porfolio_cd
  is '组合代码';
comment on column BOND_POSITION_OUT.portfolio_nm
  is '组合名称';
comment on column BOND_POSITION_OUT.end_dt
  is '持仓日期';
comment on column BOND_POSITION_OUT.currency
  is '币种';
comment on column BOND_POSITION_OUT.amt_cost
  is '持仓余额-成本法';
comment on column BOND_POSITION_OUT.amt_marketvalue
  is '持仓余额-市值法';
comment on column BOND_POSITION_OUT.position_num
  is '持仓数量';
comment on column BOND_POSITION_OUT.strategy_l1
  is '策略1级分类';
comment on column BOND_POSITION_OUT.strategy_l2
  is '策略2级分类';
comment on column BOND_POSITION_OUT.strategy_l3
  is '策略3级分类';
comment on column BOND_POSITION_OUT.is_valid
  is '是否有效';
comment on column BOND_POSITION_OUT.tsid
  is '唯一标识';
comment on column BOND_POSITION_OUT.src_updt_dt
  is '源更新时间';
comment on column BOND_POSITION_OUT.isdel
  is '是否删除';
comment on column BOND_POSITION_OUT.updt_by
  is '更新人';
comment on column BOND_POSITION_OUT.updt_dt
  is '更新时间';
alter table BOND_POSITION_OUT
  add constraint PK_BOND_POSITION_OUT primary key (TSID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 80K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table BOND_POSITION_OWN
prompt ================================
prompt
create table BOND_POSITION_OWN
(
  bond_position_own_sid NUMBER(16) not null,
  secinner_id           NUMBER(16) not null,
  security_cd           VARCHAR2(100),
  security_nm           VARCHAR2(300),
  trade_market_id       NUMBER(16),
  security_snm          VARCHAR2(300),
  portfolio_cd          VARCHAR2(50),
  portfolio_nm          VARCHAR2(300),
  end_dt                DATE not null,
  currency              VARCHAR2(10),
  amt_cost              NUMBER(38,10),
  amt_marketvalue       NUMBER(38,10),
  position_num          NUMBER(38,10),
  src_updt_dt           TIMESTAMP(6),
  isdel                 INTEGER not null,
  updt_by               NUMBER(16) not null,
  updt_dt               TIMESTAMP(6) not null
)
tablespace USERS
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

prompt
prompt Creating table BOND_POSITION_STRUCTURED
prompt =======================================
prompt
create table BOND_POSITION_STRUCTURED
(
  bond_position_structured_sid NUMBER(16) not null,
  secinner_id                  NUMBER(16) not null,
  security_cd                  VARCHAR2(100),
  security_nm                  VARCHAR2(300),
  trade_market_id              NUMBER(16),
  portfolio_cd                 VARCHAR2(50),
  portfolio_nm                 VARCHAR2(300),
  end_dt                       DATE not null,
  currency                     VARCHAR2(10),
  amt_cost                     NUMBER(38,10),
  amt_marketvalue              NUMBER(38,10),
  position_num                 NUMBER(38,10),
  strategy_l1                  VARCHAR2(100),
  strategy_l2                  VARCHAR2(100),
  strategy_l3                  VARCHAR2(100),
  is_valid                     INTEGER,
  tsid                         VARCHAR2(100),
  src_updt_dt                  TIMESTAMP(6),
  isdel                        INTEGER not null,
  updt_by                      NUMBER(16) not null,
  updt_dt                      TIMESTAMP(6) not null
)
tablespace USERS
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
comment on column BOND_POSITION_STRUCTURED.bond_position_structured_sid
  is '自主持仓流水号';
comment on column BOND_POSITION_STRUCTURED.secinner_id
  is '债券标识符';
comment on column BOND_POSITION_STRUCTURED.security_cd
  is '债券代码';
comment on column BOND_POSITION_STRUCTURED.security_nm
  is '债券全称';
comment on column BOND_POSITION_STRUCTURED.trade_market_id
  is '交易市场';
comment on column BOND_POSITION_STRUCTURED.portfolio_cd
  is '组合代码';
comment on column BOND_POSITION_STRUCTURED.portfolio_nm
  is '组合名称';
comment on column BOND_POSITION_STRUCTURED.end_dt
  is '持仓日期';
comment on column BOND_POSITION_STRUCTURED.currency
  is '币种';
comment on column BOND_POSITION_STRUCTURED.amt_cost
  is '持仓余额-成本法';
comment on column BOND_POSITION_STRUCTURED.amt_marketvalue
  is '持仓余额-市值法';
comment on column BOND_POSITION_STRUCTURED.position_num
  is '持仓数量';
comment on column BOND_POSITION_STRUCTURED.strategy_l1
  is '策略1级分类';
comment on column BOND_POSITION_STRUCTURED.strategy_l2
  is '策略2级分类';
comment on column BOND_POSITION_STRUCTURED.strategy_l3
  is '策略3级分类';
comment on column BOND_POSITION_STRUCTURED.is_valid
  is '是否有效';
comment on column BOND_POSITION_STRUCTURED.tsid
  is '唯一标识';
comment on column BOND_POSITION_STRUCTURED.src_updt_dt
  is '源更新时间';
comment on column BOND_POSITION_STRUCTURED.isdel
  is '是否删除';
comment on column BOND_POSITION_STRUCTURED.updt_by
  is '更新人';
comment on column BOND_POSITION_STRUCTURED.updt_dt
  is '更新时间';
alter table BOND_POSITION_STRUCTURED
  add constraint PK_BOND_POSITION_STRUCTURED primary key (BOND_POSITION_STRUCTURED_SID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 80K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table BOND_RATING_APPROV
prompt =================================
prompt
create table BOND_RATING_APPROV
(
  bond_rating_approv_sid NUMBER(16) not null,
  bond_rating_record_sid NUMBER(16) not null,
  approval_st            INTEGER not null,
  approval_view          VARCHAR2(2000),
  approvor_id            NUMBER(16) not null,
  approval_dt            DATE,
  updt_by                NUMBER(16) not null,
  updt_dt                TIMESTAMP(6) not null
)
tablespace CS_MASTER_TEST
  pctfree 10
  initrans 1
  maxtrans 255;
alter table BOND_RATING_APPROV
  add constraint PK_BOND_RATING_APPROV primary key (BOND_RATING_APPROV_SID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table BOND_RATING_DETAIL
prompt =================================
prompt
create table BOND_RATING_DETAIL
(
  bond_rating_detail_sid NUMBER(16) not null,
  bond_rating_record_sid NUMBER(16) not null,
  submodel_id            NUMBER(16) not null,
  score                  NUMBER(20,4) not null
)
tablespace CS_MASTER_TEST
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
alter table BOND_RATING_DETAIL
  add constraint PK_BOND_RATING_DETAIL primary key (BOND_RATING_DETAIL_SID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table BOND_RATING_DISPLAY
prompt ==================================
prompt
create table BOND_RATING_DISPLAY
(
  bond_rating_display_sid NUMBER(16) not null,
  secinner_id             NUMBER(16) not null,
  raw_rating              VARCHAR2(50),
  adjust_rating           VARCHAR2(50),
  bond_rating_record_id   NUMBER(16) not null,
  client_id               NUMBER(16) not null,
  updt_by                 NUMBER(16) not null,
  updt_dt                 TIMESTAMP(6) not null
)
tablespace CS_MASTER_TEST
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
alter table BOND_RATING_DISPLAY
  add constraint PK_BOND_RATING_DISPLAY primary key (BOND_RATING_DISPLAY_SID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table BOND_RATING_FACTOR
prompt =================================
prompt
create table BOND_RATING_FACTOR
(
  bond_rating_factor_sid NUMBER(16) not null,
  bond_rating_record_sid NUMBER(16) not null,
  factor_cd              VARCHAR2(30) not null,
  factor_nm              VARCHAR2(200) not null,
  factor_type            VARCHAR2(60) not null,
  factor_value           VARCHAR2(600) not null,
  option_num             INTEGER,
  ratio                  NUMBER(10,4),
  factor_val_revised     VARCHAR2(600),
  option_num_revised     INTEGER,
  ratio_revised          NUMBER(10,4),
  adjustment_comment     VARCHAR2(600),
  client_id              NUMBER(16) not null,
  updt_by                NUMBER(16) not null,
  updt_dt                TIMESTAMP(6) not null
)
tablespace USERS
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
alter table BOND_RATING_FACTOR
  add constraint PK_BOND_RATING_FACTOR primary key (BOND_RATING_FACTOR_SID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 80K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table BOND_RATING_FACTOR_BKP
prompt =====================================
prompt
create table BOND_RATING_FACTOR_BKP
(
  bond_rating_factor_sid NUMBER(16) not null,
  bond_rating_record_sid NUMBER(16) not null,
  factor_cd              VARCHAR2(30) not null,
  factor_nm              VARCHAR2(200) not null,
  factor_type            VARCHAR2(60) not null,
  factor_value           VARCHAR2(600) not null,
  option_num             INTEGER,
  ratio                  NUMBER(10,4),
  client_id              NUMBER(16) not null,
  updt_by                NUMBER(16) not null,
  updt_dt                TIMESTAMP(6) not null
)
tablespace USERS
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

prompt
prompt Creating table BOND_RATING_MODEL
prompt ================================
prompt
create table BOND_RATING_MODEL
(
  model_id   NUMBER(16) not null,
  model_cd   VARCHAR2(30) not null,
  model_nm   VARCHAR2(100) not null,
  model_desc VARCHAR2(1000),
  formula_ch VARCHAR2(2000),
  formula_en VARCHAR2(2000),
  version    NUMBER(10,4),
  isdel      INTEGER,
  client_id  NUMBER(16) not null,
  updt_by    NUMBER(16) not null,
  updt_dt    TIMESTAMP(6) not null
)
tablespace CS_MASTER_TEST
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
alter table BOND_RATING_MODEL
  add constraint PK_BOND_RATING_MODEL primary key (MODEL_ID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table BOND_RATING_RECORD
prompt =================================
prompt
create table BOND_RATING_RECORD
(
  bond_rating_record_sid NUMBER(16) not null,
  secinner_id            NUMBER(16) not null,
  model_id               NUMBER(16) not null,
  factor_dt              DATE,
  rating_dt              DATE not null,
  rating_type            INTEGER not null,
  raw_lgd_score          NUMBER(10,4),
  raw_lgd_grade          VARCHAR2(30),
  adjust_lgd_score       NUMBER(10,4),
  adjust_lgd_grade       VARCHAR2(30),
  adjust_lgd_reason      VARCHAR2(300),
  raw_rating             VARCHAR2(40),
  adjust_rating          VARCHAR2(40),
  adjust_rating_reason   VARCHAR2(300),
  rating_st              INTEGER,
  effect_start_dt        DATE,
  effect_end_dt          DATE,
  updt_by                NUMBER(16) not null,
  updt_dt                TIMESTAMP(6) not null
)
tablespace CS_MASTER_TEST
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
alter table BOND_RATING_RECORD
  add constraint PK_BOND_RATING_RECORD primary key (BOND_RATING_RECORD_SID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table BOND_RATING_SCALE_LGD
prompt ====================================
prompt
create table BOND_RATING_SCALE_LGD
(
  scale_id      NUMBER(16) not null,
  scale_grade   VARCHAR2(30) not null,
  scale_desc    VARCHAR2(300),
  model_id      NUMBER(16) not null,
  mid_point     NUMBER(10,4),
  low_bound     NUMBER(10,4),
  upper_bound   NUMBER(10,4),
  rating_change INTEGER,
  isdel         INTEGER,
  updt_by       NUMBER(16) not null,
  updt_dt       TIMESTAMP(6) not null
)
tablespace CS_MASTER_TEST
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
alter table BOND_RATING_SCALE_LGD
  add constraint PK_BOND_RATING_SCALE_LGD primary key (SCALE_ID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table BOND_RATING_SUBMODEL
prompt ===================================
prompt
create table BOND_RATING_SUBMODEL
(
  submodel_id    NUMBER(19) not null,
  submodel_cd    VARCHAR2(30) not null,
  submodel_nm    VARCHAR2(100) not null,
  model_desc     VARCHAR2(1000),
  model_id       NUMBER(19) not null,
  formula_ch     VARCHAR2(2000),
  formula_en     VARCHAR2(2000),
  calculate_mode VARCHAR2(100),
  isdel          NUMBER(10),
  updt_by        NUMBER(19) not null,
  updt_dt        TIMESTAMP(6) not null
)
tablespace CS_MASTER_TEST
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
alter table BOND_RATING_SUBMODEL
  add constraint PK_BOND_RATING_SUBMODEL primary key (SUBMODEL_ID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table BOND_RATING_SUBMODEL_SUPP
prompt ========================================
prompt
create table BOND_RATING_SUBMODEL_SUPP
(
  submodel_id NUMBER(19) not null,
  updt_table  VARCHAR2(60),
  updt_field  VARCHAR2(60),
  table_pk    VARCHAR2(60),
  updt_by     NUMBER(19) not null,
  updt_dt     TIMESTAMP(6) not null
)
tablespace CS_MASTER_TEST
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
alter table BOND_RATING_SUBMODEL_SUPP
  add constraint PK_BOND_RATING_SUBMODEL_SUPP primary key (SUBMODEL_ID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table BOND_RATING_XW
prompt =============================
prompt
create table BOND_RATING_XW
(
  bond_rating_record_sid NUMBER(16) not null,
  rating_record_id       NUMBER(16) not null,
  updt_by                NUMBER(16) not null,
  updt_dt                TIMESTAMP(6) not null
)
tablespace CS_MASTER_TEST
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
alter table BOND_RATING_XW
  add constraint PK_BOND_RATING_XW primary key (BOND_RATING_RECORD_SID, RATING_RECORD_ID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table BOND_TERMS
prompt =========================
prompt
create table BOND_TERMS
(
  bond_terms_sid   NUMBER(16) not null,
  secinner_id      NUMBER(16) not null,
  notice_dt        DATE,
  latest_notice_dt DATE,
  terms_type_id    NUMBER(16),
  terms            VARCHAR2(4000),
  data_src         VARCHAR2(100),
  remark           VARCHAR2(4000),
  isdel            INTEGER not null,
  src_portfolio_cd VARCHAR2(30) not null,
  srcid            VARCHAR2(100),
  src_cd           VARCHAR2(10) not null,
  updt_dt          TIMESTAMP(6) not null
)
tablespace USERS
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

prompt
prompt Creating table BOND_VALUATIONS
prompt ==============================
prompt
create table BOND_VALUATIONS
(
  bond_valuations_sid  NUMBER(16) not null,
  secinner_id          NUMBER(16) not null,
  trade_dt             DATE,
  val_full             NUMBER(24,8),
  ai                   NUMBER(24,8),
  val_net              NUMBER(24,8),
  val_ytm              NUMBER(24,8),
  val_mduration        NUMBER(24,8),
  val_convexity        NUMBER(24,8),
  val_bpvalue          NUMBER(24,8),
  val_spreadduration   NUMBER(24,8),
  val_spreadconvexity  NUMBER(24,8),
  val_rateduration     NUMBER(24,8),
  val_rateconvexity    NUMBER(24,8),
  real_full            NUMBER(24,8),
  real_net             NUMBER(24,8),
  real_ytm             NUMBER(24,8),
  real_mduration       NUMBER(24,8),
  real_convexity       NUMBER(24,8),
  real_bpvalue         NUMBER(24,8),
  real_spreadduration  NUMBER(24,8),
  real_spreadconvexity NUMBER(24,8),
  real_rateduration    NUMBER(24,8),
  real_rateconvexity   NUMBER(24,8),
  remain_value         NUMBER(24,8),
  point_ytm            NUMBER(24,8),
  val_fullfinal        NUMBER(24,8),
  ai_finval            NUMBER(24,8),
  is_calculateoption   VARCHAR2(30),
  datasrc_companyid    NUMBER(16),
  to_maturity          NUMBER(24,8),
  corres_yieldcurve    VARCHAR2(200),
  coupon_rate          NUMBER(24,8),
  isdel                INTEGER not null,
  src_secinner_cd      VARCHAR2(30) not null,
  datasrc_companycd    VARCHAR2(100),
  srcid                VARCHAR2(100),
  src_cd               VARCHAR2(10) not null,
  updt_dt              TIMESTAMP(6) not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table BOND_VALUATIONS
  is 'TGT-债券估值';
comment on column BOND_VALUATIONS.bond_valuations_sid
  is '标识符';
comment on column BOND_VALUATIONS.secinner_id
  is '证券内码';
comment on column BOND_VALUATIONS.trade_dt
  is '日期';
comment on column BOND_VALUATIONS.val_full
  is '日间估价全价(元)';
comment on column BOND_VALUATIONS.ai
  is '日间应计利息(元)';
comment on column BOND_VALUATIONS.val_net
  is '估价净价(元)';
comment on column BOND_VALUATIONS.val_ytm
  is '估价收益率(％)';
comment on column BOND_VALUATIONS.val_mduration
  is '估价修正久期';
comment on column BOND_VALUATIONS.val_convexity
  is '估价凸性';
comment on column BOND_VALUATIONS.val_bpvalue
  is '估价基点价值';
comment on column BOND_VALUATIONS.val_spreadduration
  is '估价利差久期';
comment on column BOND_VALUATIONS.val_spreadconvexity
  is '估价利差凸性';
comment on column BOND_VALUATIONS.val_rateduration
  is '估价利率久期';
comment on column BOND_VALUATIONS.val_rateconvexity
  is '估价利率凸性';
comment on column BOND_VALUATIONS.real_full
  is '真实结算全价(元)';
comment on column BOND_VALUATIONS.real_net
  is '真实结算净价(元)';
comment on column BOND_VALUATIONS.real_ytm
  is '真实收益率(%)';
comment on column BOND_VALUATIONS.real_mduration
  is '真实修正久期';
comment on column BOND_VALUATIONS.real_convexity
  is '真实凸性';
comment on column BOND_VALUATIONS.real_bpvalue
  is '真实基点价值';
comment on column BOND_VALUATIONS.real_spreadduration
  is '真实利差久期';
comment on column BOND_VALUATIONS.real_spreadconvexity
  is '真实利差凸性';
comment on column BOND_VALUATIONS.real_rateduration
  is '真实利率久期';
comment on column BOND_VALUATIONS.real_rateconvexity
  is '真实利率凸性';
comment on column BOND_VALUATIONS.remain_value
  is '剩余本金(元)';
comment on column BOND_VALUATIONS.point_ytm
  is '点差收益率(%)';
comment on column BOND_VALUATIONS.val_fullfinal
  is '日终估价全价(元)';
comment on column BOND_VALUATIONS.ai_finval
  is '日终应计利息(元)';
comment on column BOND_VALUATIONS.is_calculateoption
  is '可信度';
comment on column BOND_VALUATIONS.datasrc_companyid
  is '数据源公司代码';
comment on column BOND_VALUATIONS.to_maturity
  is '待偿期(年)';
comment on column BOND_VALUATIONS.corres_yieldcurve
  is '对应收益率曲线';
comment on column BOND_VALUATIONS.coupon_rate
  is '流通场所债券代码';
comment on column BOND_VALUATIONS.isdel
  is '估算的行权后票面利率(%)';
comment on column BOND_VALUATIONS.src_secinner_cd
  is '源债券唯一编码';
comment on column BOND_VALUATIONS.datasrc_companycd
  is '数据源公司代码';
comment on column BOND_VALUATIONS.srcid
  is '源系统主键';
comment on column BOND_VALUATIONS.src_cd
  is '源系统';
comment on column BOND_VALUATIONS.updt_dt
  is '更新时间';

prompt
prompt Creating table BOND_WARRANTOR
prompt =============================
prompt
create table BOND_WARRANTOR
(
  bond_warrantor_sid   NUMBER(16) not null,
  secinner_id          NUMBER(16) not null,
  notice_dt            DATE,
  warranty_rate        NUMBER(10,4),
  guarantee_type_id    NUMBER(16),
  warranty_period      VARCHAR2(60),
  warrantor_id         NUMBER(16),
  warrantor_nm         VARCHAR2(300) not null,
  warrantor_type_id    NUMBER(16),
  start_dt             DATE,
  end_dt               DATE,
  warranty_amt         NUMBER(24,8),
  warrantor_resume     CLOB,
  warranty_contract    CLOB,
  warranty_benef       VARCHAR2(300),
  warranty_content     CLOB,
  warranty_type_id     NUMBER(16) not null,
  warranty_claim       VARCHAR2(200),
  warranty_strength_id NUMBER(16),
  pay_step             CLOB,
  warranty_fee         NUMBER(24,8),
  exempt_set           CLOB,
  warranty_obj         VARCHAR2(1000),
  isser_credit         CLOB,
  src_updt_dt          DATE,
  mitigation_value     NUMBER(20,4),
  isdel                INTEGER not null,
  srcid                VARCHAR2(100),
  src_cd               VARCHAR2(10) not null,
  updt_by              NUMBER(16) not null,
  updt_dt              TIMESTAMP(6) not null
)
tablespace CS_MASTER_TEST
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
alter table BOND_WARRANTOR
  add constraint PK_BOND_WARRANTOR primary key (BOND_WARRANTOR_SID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table BOND_WORKFLOW_ABS
prompt ================================
prompt
create table BOND_WORKFLOW_ABS
(
  bond_workflow_abs_sid  NUMBER(16) not null,
  abs_cd                 VARCHAR2(30),
  bond_rating_record_sid NUMBER(16) not null,
  workflow_id            NUMBER(16) not null,
  isdel                  INTEGER not null,
  updt_by                NUMBER(16) not null,
  updt_dt                TIMESTAMP(6) not null
)
tablespace USERS
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
alter table BOND_WORKFLOW_ABS
  add constraint PK_BOND_WORKFLOW_ABS primary key (BOND_WORKFLOW_ABS_SID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 80K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table CLIENT_BASICINFO
prompt ===============================
prompt
create table CLIENT_BASICINFO
(
  client_id   NUMBER(16) not null,
  client_nm   VARCHAR2(300) not null,
  client_snm  VARCHAR2(100) not null,
  client_addr VARCHAR2(300),
  contact     VARCHAR2(80),
  phone       VARCHAR2(30),
  email       VARCHAR2(60),
  purchase_dt DATE,
  updt_dt     TIMESTAMP(6) not null
)
tablespace CS_MASTER_TEST
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
alter table CLIENT_BASICINFO
  add constraint CLIENT_BASICINFO_PKEY primary key (CLIENT_ID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table COMPY_AFFILPARTY
prompt ===============================
prompt
create table COMPY_AFFILPARTY
(
  compy_affilparty_sid NUMBER(16) not null,
  company_id           NUMBER(16) not null,
  notice_dt            DATE,
  rpt_dt               DATE not null,
  affil_party_id       NUMBER(16),
  affil_party          VARCHAR2(300) not null,
  ohd_sha_ratio        NUMBER(20,4),
  ino_sha_ratio        NUMBER(20,4),
  relation_type_id     NUMBER(16) not null,
  affil_party_type     INTEGER,
  is_combined          INTEGER,
  remark               VARCHAR2(4000),
  isdel                INTEGER,
  src_company_cd       VARCHAR2(60),
  srcid                VARCHAR2(100) not null,
  src_cd               VARCHAR2(10) not null,
  updt_by              NUMBER(16),
  updt_dt              TIMESTAMP(6) not null
)
tablespace CS_MASTER_TEST
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
alter table COMPY_AFFILPARTY
  add constraint PK_COMPY_AFFILPARTY primary key (COMPY_AFFILPARTY_SID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table COMPY_BALANCESHEET
prompt =================================
prompt
create table COMPY_BALANCESHEET
(
  compy_balancesheet_sid NUMBER(16) not null,
  fst_notice_dt          DATE,
  latest_notice_dt       DATE,
  company_id             NUMBER(16) not null,
  rpt_dt                 INTEGER not null,
  start_dt               INTEGER,
  end_dt                 INTEGER,
  rpt_timetype_cd        INTEGER,
  combine_type_cd        INTEGER not null,
  rpt_srctype_id         INTEGER,
  data_ajust_type        NUMBER(16),
  data_type              INTEGER,
  is_public_rpt          INTEGER,
  company_type           INTEGER not null,
  currency               VARCHAR2(6),
  monetary_fund          NUMBER(24,4),
  tradef_asset           NUMBER(24,4),
  bill_rec               NUMBER(24,4),
  account_rec            NUMBER(24,4),
  other_rec              NUMBER(24,4),
  advance_pay            NUMBER(24,4),
  dividend_rec           NUMBER(24,4),
  interest_rec           NUMBER(24,4),
  inventory              NUMBER(24,4),
  nonl_asset_oneyear     NUMBER(24,4),
  defer_expense          NUMBER(24,4),
  other_lasset           NUMBER(24,4),
  lasset_other           NUMBER(24,4),
  lasset_balance         NUMBER(24,4),
  sum_lasset             NUMBER(24,4),
  saleable_fasset        NUMBER(24,4),
  held_maturity_inv      NUMBER(24,4),
  estate_invest          NUMBER(24,4),
  lte_quity_inv          NUMBER(24,4),
  ltrec                  NUMBER(24,4),
  fixed_asset            NUMBER(24,4),
  construction_material  NUMBER(24,4),
  construction_progress  NUMBER(24,4),
  liquidate_fixed_asset  NUMBER(24,4),
  product_biology_asset  NUMBER(24,4),
  oilgas_asset           NUMBER(24,4),
  intangible_asset       NUMBER(24,4),
  develop_exp            NUMBER(24,4),
  good_will              NUMBER(24,4),
  ltdefer_asset          NUMBER(24,4),
  defer_incometax_asset  NUMBER(24,4),
  other_nonl_asset       NUMBER(24,4),
  nonlasset_other        NUMBER(24,4),
  nonlasset_balance      NUMBER(24,4),
  sum_nonl_asset         NUMBER(24,4),
  cash_and_depositcbank  NUMBER(24,4),
  deposit_infi           NUMBER(24,4),
  fi_deposit             NUMBER(24,4),
  precious_metal         NUMBER(24,4),
  lend_fund              NUMBER(24,4),
  derive_fasset          NUMBER(24,4),
  buy_sellback_fasset    NUMBER(24,4),
  loan_advances          NUMBER(24,4),
  agency_assets          NUMBER(24,4),
  premium_rec            NUMBER(24,4),
  subrogation_rec        NUMBER(24,4),
  ri_rec                 NUMBER(24,4),
  undue_rireserve_rec    NUMBER(24,4),
  claim_rireserve_rec    NUMBER(24,4),
  life_rireserve_rec     NUMBER(24,4),
  lthealth_rireserve_rec NUMBER(24,4),
  gdeposit_pay           NUMBER(24,4),
  insured_pledge_loan    NUMBER(24,4),
  capitalg_deposit_pay   NUMBER(24,4),
  independent_asset      NUMBER(24,4),
  client_fund            NUMBER(24,4),
  settlement_provision   NUMBER(24,4),
  client_provision       NUMBER(24,4),
  seat_fee               NUMBER(24,4),
  other_asset            NUMBER(24,4),
  asset_other            NUMBER(24,4),
  asset_balance          NUMBER(24,4),
  sum_asset              NUMBER(24,4),
  st_borrow              NUMBER(24,4),
  trade_fliab            NUMBER(24,4),
  bill_pay               NUMBER(24,4),
  account_pay            NUMBER(24,4),
  advance_receive        NUMBER(24,4),
  salary_pay             NUMBER(24,4),
  tax_pay                NUMBER(24,4),
  interest_pay           NUMBER(24,4),
  dividend_pay           NUMBER(24,4),
  other_pay              NUMBER(24,4),
  accrue_expense         NUMBER(24,4),
  anticipate_liab        NUMBER(24,4),
  defer_income           NUMBER(24,4),
  nonl_liab_oneyear      NUMBER(24,4),
  other_lliab            NUMBER(24,4),
  lliab_other            NUMBER(24,4),
  lliab_balance          NUMBER(24,4),
  sum_lliab              NUMBER(24,4),
  lt_borrow              NUMBER(24,4),
  bond_pay               NUMBER(24,4),
  lt_account_pay         NUMBER(24,4),
  special_pay            NUMBER(24,4),
  defer_incometax_liab   NUMBER(24,4),
  other_nonl_liab        NUMBER(24,4),
  nonl_liab_other        NUMBER(24,4),
  nonl_liab_balance      NUMBER(24,4),
  sum_nonl_liab          NUMBER(24,4),
  borrow_from_cbank      NUMBER(24,4),
  borrow_fund            NUMBER(24,4),
  derive_financedebt     NUMBER(24,4),
  sell_buyback_fasset    NUMBER(24,4),
  accept_deposit         NUMBER(24,4),
  agency_liab            NUMBER(24,4),
  other_liab             NUMBER(24,4),
  premium_advance        NUMBER(24,4),
  comm_pay               NUMBER(24,4),
  ri_pay                 NUMBER(24,4),
  gdeposit_rec           NUMBER(24,4),
  insured_deposit_inv    NUMBER(24,4),
  undue_reserve          NUMBER(24,4),
  claim_reserve          NUMBER(24,4),
  life_reserve           NUMBER(24,4),
  lt_health_reserve      NUMBER(24,4),
  independent_liab       NUMBER(24,4),
  pledge_borrow          NUMBER(24,4),
  agent_trade_security   NUMBER(24,4),
  agent_uw_security      NUMBER(24,4),
  liab_other             NUMBER(24,4),
  liab_balance           NUMBER(24,4),
  sum_liab               NUMBER(24,4),
  share_capital          NUMBER(24,4),
  capital_reserve        NUMBER(24,4),
  surplus_reserve        NUMBER(24,4),
  retained_earning       NUMBER(24,4),
  inventory_share        NUMBER(24,4),
  general_risk_prepare   NUMBER(24,4),
  diff_conversion_fc     NUMBER(24,4),
  minority_equity        NUMBER(24,4),
  sh_equity_other        NUMBER(24,4),
  sh_equity_balance      NUMBER(24,4),
  sum_parent_equity      NUMBER(24,4),
  sum_sh_equity          NUMBER(24,4),
  liabsh_equity_other    NUMBER(24,4),
  liabsh_equity_balance  NUMBER(24,4),
  sum_liabsh_equity      NUMBER(24,4),
  td_eposit              NUMBER(24,4),
  st_bond_rec            NUMBER(24,4),
  claim_pay              NUMBER(24,4),
  policy_divi_pay        NUMBER(24,4),
  unconfirm_inv_loss     NUMBER(24,4),
  ricontact_reserve_rec  NUMBER(24,4),
  deposit                NUMBER(24,4),
  contact_reserve        NUMBER(24,4),
  invest_rec             NUMBER(24,4),
  specia_lreserve        NUMBER(24,4),
  subsidy_rec            NUMBER(24,4),
  marginout_fund         NUMBER(24,4),
  export_rebate_rec      NUMBER(24,4),
  defer_income_oneyear   NUMBER(24,4),
  lt_salary_pay          NUMBER(24,4),
  fvalue_fasset          NUMBER(24,4),
  define_fvalue_fasset   NUMBER(24,4),
  internal_rec           NUMBER(24,4),
  clheld_sale_ass        NUMBER(24,4),
  fvalue_fliab           NUMBER(24,4),
  define_fvalue_fliab    NUMBER(24,4),
  internal_pay           NUMBER(24,4),
  clheld_sale_liab       NUMBER(24,4),
  anticipate_lliab       NUMBER(24,4),
  other_equity           NUMBER(24,4),
  other_cincome          NUMBER(24,4),
  plan_cash_divi         NUMBER(24,4),
  parent_equity_other    NUMBER(24,4),
  parent_equity_balance  NUMBER(24,4),
  preferred_stock        NUMBER(24,4),
  prefer_stoc_bond       NUMBER(24,4),
  cons_biolo_asset       NUMBER(24,4),
  stock_num_end          NUMBER(24,4),
  net_mas_set            NUMBER(24,4),
  outward_remittance     NUMBER(24,4),
  cdandbill_rec          NUMBER(24,4),
  hedge_reserve          NUMBER(24,4),
  suggest_assign_divi    NUMBER(24,4),
  marginout_security     NUMBER(24,4),
  cagent_trade_security  NUMBER(24,4),
  trade_risk_prepare     NUMBER(24,4),
  creditor_planinv       NUMBER(24,4),
  short_financing        NUMBER(24,4),
  receivables            NUMBER(24,4),
  remark                 VARCHAR2(1000),
  chk_status             VARCHAR2(200),
  isdel                  INTEGER not null,
  src_company_cd         VARCHAR2(60),
  srcid                  VARCHAR2(100),
  src_cd                 VARCHAR2(10) not null,
  updt_by                NUMBER(16) not null,
  updt_dt                TIMESTAMP(6) not null
)
tablespace CS_MASTER_TEST
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
alter table COMPY_BALANCESHEET
  add constraint PK_COMPY_BALANCESHEET primary key (COMPY_BALANCESHEET_SID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table COMPY_BANKADDFIN
prompt ===============================
prompt
create table COMPY_BANKADDFIN
(
  compy_bankaddfin_sid NUMBER(16) not null,
  notice_dt            DATE,
  company_id           NUMBER(16) not null,
  rpt_dt               INTEGER,
  end_dt               INTEGER,
  combine_type_cd      INTEGER,
  unit                 INTEGER,
  currency             VARCHAR2(6),
  item_typecd          NUMBER(16),
  item_cd              NUMBER(16) not null,
  amt_end              NUMBER(24,4),
  amt_avg              NUMBER(24,4),
  isdel                INTEGER not null,
  src_company_cd       VARCHAR2(60),
  srcid                VARCHAR2(100),
  src_cd               VARCHAR2(10) not null,
  updt_by              NUMBER(16) not null,
  updt_dt              TIMESTAMP(6) not null
)
tablespace CS_MASTER_TEST
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
alter table COMPY_BANKADDFIN
  add constraint PK_COMPY_BANKADDFIN primary key (COMPY_BANKADDFIN_SID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table COMPY_BASICINFO
prompt ==============================
prompt
create table COMPY_BASICINFO
(
  company_id       NUMBER(16) not null,
  company_cd       VARCHAR2(30),
  company_nm       VARCHAR2(300) not null,
  company_snm      VARCHAR2(100),
  clens_company_nm VARCHAR2(300),
  fen_nm           VARCHAR2(200),
  leg_represent    VARCHAR2(500),
  chairman         VARCHAR2(80),
  gmanager         VARCHAR2(80),
  bsecretary       VARCHAR2(80),
  org_form_id      NUMBER(16),
  found_dt         DATE,
  currency         VARCHAR2(20),
  reg_capital      NUMBER(20,4),
  country          VARCHAR2(6),
  region           INTEGER,
  city             INTEGER,
  reg_addr         VARCHAR2(300),
  office_addr      VARCHAR2(300),
  office_post_cd   VARCHAR2(10),
  company_ph       VARCHAR2(60),
  company_fax      VARCHAR2(30),
  company_em       VARCHAR2(100),
  company_web      VARCHAR2(500),
  busin_scope      VARCHAR2(4000),
  main_busin       VARCHAR2(4000),
  employ_num       NUMBER(16),
  blnumb           VARCHAR2(60),
  ntrnum           VARCHAR2(60),
  ltrnum           VARCHAR2(60),
  orgnum           VARCHAR2(30),
  reg_dt           VARCHAR2(50),
  info_url         VARCHAR2(100),
  info_news        VARCHAR2(100),
  accounting_firm  VARCHAR2(300),
  legal_advisor    VARCHAR2(300),
  company_st       INTEGER,
  company_profile  CLOB,
  is_del           INTEGER,
  src_updt_dt      DATE,
  src_company_cd   VARCHAR2(60),
  src_cd           VARCHAR2(10) not null,
  updt_by          NUMBER(16) not null,
  updt_dt          TIMESTAMP(6) not null
)
tablespace CS_MASTER_TEST
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
alter table COMPY_BASICINFO
  add constraint PK_COMPY_BASICINFO primary key (COMPANY_ID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table COMPY_BONDISSUER
prompt ===============================
prompt
create table COMPY_BONDISSUER
(
  company_id            NUMBER(16) not null,
  region                INTEGER not null,
  org_nature_id         NUMBER(16),
  actctrl_sharehd_ratio NUMBER(20,4),
  org_nature_orig       VARCHAR2(4000),
  data_src              VARCHAR2(1000),
  isdel                 INTEGER not null,
  srcid                 VARCHAR2(100) not null,
  src_cd                VARCHAR2(10) not null,
  updt_dt               TIMESTAMP(6) not null
)
tablespace CS_MASTER_TEST
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

prompt
prompt Creating table COMPY_BREAKCONTRACT
prompt ==================================
prompt
create table COMPY_BREAKCONTRACT
(
  compy_breakcontract_sid NUMBER(19) not null,
  company_id              NUMBER(16),
  company_nm              VARCHAR2(300) not null,
  notice_dt               TIMESTAMP(6) not null,
  notice_title            VARCHAR2(800) not null,
  detail                  VARCHAR2(18),
  url                     VARCHAR2(1261),
  region                  NUMBER,
  region_nm               VARCHAR2(200),
  exposure_sid            NUMBER(16) not null,
  exposure                VARCHAR2(100) not null,
  updt_dt                 TIMESTAMP(6) default systimestamp
)
tablespace CS_MASTER_TEST
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
alter table COMPY_BREAKCONTRACT
  add constraint PK_COMPY_BREAKCONTRACT primary key (COMPY_BREAKCONTRACT_SID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table COMPY_CASHFLOW
prompt =============================
prompt
create table COMPY_CASHFLOW
(
  compy_cashflow_sid        NUMBER(16) not null,
  first_notice_dt           DATE,
  latest_notice_dt          DATE,
  company_id                NUMBER(16) not null,
  rpt_dt                    INTEGER not null,
  start_dt                  INTEGER,
  end_dt                    INTEGER,
  rpt_timetype_cd           INTEGER,
  combine_type_cd           INTEGER not null,
  rpt_srctype_id            NUMBER(16),
  data_ajust_type           INTEGER,
  data_type                 INTEGER,
  is_public_rpt             INTEGER,
  company_type              INTEGER not null,
  currency                  VARCHAR2(6),
  salegoods_service_rec     NUMBER(24,4),
  tax_return_rec            NUMBER(24,4),
  other_operate_rec         NUMBER(24,4),
  ni_deposit                NUMBER(24,4),
  niborrow_from_cbank       NUMBER(24,4),
  niborrow_from_fi          NUMBER(24,4),
  premium_rec               NUMBER(24,4),
  nidisp_trade_fasset       NUMBER(24,4),
  nidisp_saleable_fasset    NUMBER(24,4),
  niborrow_fund             NUMBER(24,4),
  nibuyback_fund            NUMBER(24,4),
  operate_flowin_other      NUMBER(24,4),
  operate_flowin_balance    NUMBER(24,4),
  sum_operate_flowin        NUMBER(24,4),
  buygoods_service_pay      NUMBER(24,4),
  employee_pay              NUMBER(24,4),
  tax_pay                   NUMBER(24,4),
  other_operat_epay         NUMBER(24,4),
  niloan_advances           NUMBER(24,4),
  nideposit_incbankfi       NUMBER(24,4),
  indemnity_pay             NUMBER(24,4),
  intandcomm_pay            NUMBER(24,4),
  operate_flowout_other     NUMBER(24,4),
  operate_flowout_balance   NUMBER(24,4),
  sum_operate_flowout       NUMBER(24,4),
  operate_flow_other        NUMBER(24,4),
  operate_flow_balance      NUMBER(24,4),
  net_operate_cashflow      NUMBER(24,4),
  disposal_inv_rec          NUMBER(24,4),
  inv_income_rec            NUMBER(24,4),
  disp_filasset_rec         NUMBER(24,4),
  disp_subsidiary_rec       NUMBER(24,4),
  other_invrec              NUMBER(24,4),
  inv_flowin_other          NUMBER(24,4),
  inv_flowin_balance        NUMBER(24,4),
  sum_inv_flowin            NUMBER(24,4),
  buy_filasset_pay          NUMBER(24,4),
  inv_pay                   NUMBER(24,4),
  get_subsidiary_pay        NUMBER(24,4),
  other_inv_pay             NUMBER(24,4),
  nipledge_loan             NUMBER(24,4),
  inv_flowout_other         NUMBER(24,4),
  inv_flowout_balance       NUMBER(24,4),
  sum_inv_flowout           NUMBER(24,4),
  inv_flow_other            NUMBER(24,4),
  inv_cashflow_balance      NUMBER(24,4),
  net_inv_cashflow          NUMBER(24,4),
  accept_inv_rec            NUMBER(24,4),
  loan_rec                  NUMBER(24,4),
  other_fina_rec            NUMBER(24,4),
  issue_bond_rec            NUMBER(24,4),
  niinsured_deposit_inv     NUMBER(24,4),
  fina_flowin_other         NUMBER(24,4),
  fina_flowin_balance       NUMBER(24,4),
  sum_fina_flowin           NUMBER(24,4),
  repay_debt_pay            NUMBER(24,4),
  divi_profitorint_pay      NUMBER(24,4),
  other_fina_pay            NUMBER(24,4),
  fina_flowout_other        NUMBER(24,4),
  fina_flowout_balance      NUMBER(24,4),
  sum_fina_flowout          NUMBER(24,4),
  fina_flow_other           NUMBER(24,4),
  fina_flow_balance         NUMBER(24,4),
  net_fina_cashflow         NUMBER(24,4),
  effect_exchange_rate      NUMBER(24,4),
  nicash_equi_other         NUMBER(24,4),
  nicash_equi_balance       NUMBER(24,4),
  nicash_equi               NUMBER(24,4),
  cash_equi_beginning       NUMBER(24,4),
  cash_equi_ending          NUMBER(24,4),
  net_profit                NUMBER(24,4),
  asset_devalue             NUMBER(24,4),
  fixed_asset_etcdepr       NUMBER(24,4),
  intangible_asset_amor     NUMBER(24,4),
  ltdefer_exp_amor          NUMBER(24,4),
  defer_exp_reduce          NUMBER(24,4),
  drawing_exp_add           NUMBER(24,4),
  disp_filasset_loss        NUMBER(24,4),
  fixed_asset_loss          NUMBER(24,4),
  fvalue_loss               NUMBER(24,4),
  finance_exp               NUMBER(24,4),
  inv_loss                  NUMBER(24,4),
  defer_taxasset_reduce     NUMBER(24,4),
  defer_taxliab_add         NUMBER(24,4),
  inventory_reduce          NUMBER(24,4),
  operate_rec_reduce        NUMBER(24,4),
  operate_pay_add           NUMBER(24,4),
  inoperate_flow_other      NUMBER(24,4),
  inoperate_flow_balance    NUMBER(24,4),
  innet_operate_cashflow    NUMBER(24,4),
  debt_to_capital           NUMBER(24,4),
  cb_oneyear                NUMBER(24,4),
  finalease_fixed_asset     NUMBER(24,4),
  cash_end                  NUMBER(24,4),
  cash_begin                NUMBER(24,4),
  equi_end                  NUMBER(24,4),
  equi_begin                NUMBER(24,4),
  innicash_equi_other       NUMBER(24,4),
  innicash_equi_balance     NUMBER(24,4),
  innicash_equi             NUMBER(24,4),
  other                     NUMBER(24,4),
  subsidiary_accept         NUMBER(24,4),
  subsidiary_pay            NUMBER(24,4),
  divi_pay                  NUMBER(24,4),
  intandcomm_rec            NUMBER(24,4),
  net_rirec                 NUMBER(24,4),
  nilend_fund               NUMBER(24,4),
  defer_tax                 NUMBER(24,4),
  defer_income_amor         NUMBER(24,4),
  exchange_loss             NUMBER(24,4),
  fixandestate_depr         NUMBER(24,4),
  fixed_asset_depr          NUMBER(24,4),
  tradef_asset_reduce       NUMBER(24,4),
  ndloan_advances           NUMBER(24,4),
  reduce_pledget_deposit    NUMBER(24,4),
  add_pledget_deposit       NUMBER(24,4),
  buy_subsidiary_pay        NUMBER(24,4),
  cash_equiending_other     NUMBER(24,4),
  cash_equiending_balance   NUMBER(24,4),
  nd_depositinc_bankfi      NUMBER(24,4),
  niborrow_sell_buyback     NUMBER(24,4),
  ndlend_buy_sellback       NUMBER(24,4),
  net_cd                    NUMBER(24,4),
  nitrade_fliab             NUMBER(24,4),
  ndtrade_fasset            NUMBER(24,4),
  disp_masset_rec           NUMBER(24,4),
  cancel_loan_rec           NUMBER(24,4),
  ndborrow_from_cbank       NUMBER(24,4),
  ndfide_posit              NUMBER(24,4),
  ndissue_cd                NUMBER(24,4),
  nilend_sell_buyback       NUMBER(24,4),
  ndborrow_sell_buyback     NUMBER(24,4),
  nitrade_fasset            NUMBER(24,4),
  ndtrade_fliab             NUMBER(24,4),
  buy_finaleaseasset_pay    NUMBER(24,4),
  niaccount_rec             NUMBER(24,4),
  issue_cd                  NUMBER(24,4),
  addshare_capital_rec      NUMBER(24,4),
  issue_share_rec           NUMBER(24,4),
  bond_intpay               NUMBER(24,4),
  niother_finainstru        NUMBER(24,4),
  agent_trade_securityrec   NUMBER(24,4),
  uwsecurity_rec            NUMBER(24,4),
  buysellback_fasset_rec    NUMBER(24,4),
  agent_uwsecurity_rec      NUMBER(24,4),
  nidirect_inv              NUMBER(24,4),
  nitrade_settlement        NUMBER(24,4),
  buysellback_fasset_pay    NUMBER(24,4),
  nddisp_trade_fasset       NUMBER(24,4),
  ndother_fina_instr        NUMBER(24,4),
  ndborrow_fund             NUMBER(24,4),
  nddirect_inv              NUMBER(24,4),
  ndtrade_settlement        NUMBER(24,4),
  ndbuyback_fund            NUMBER(24,4),
  agenttrade_security_pay   NUMBER(24,4),
  nddisp_saleable_fasset    NUMBER(24,4),
  nisell_buyback            NUMBER(24,4),
  ndbuy_sellback            NUMBER(24,4),
  nettrade_fasset_rec       NUMBER(24,4),
  net_ripay                 NUMBER(24,4),
  ndlend_fund               NUMBER(24,4),
  nibuy_sellback            NUMBER(24,4),
  ndsell_buyback            NUMBER(24,4),
  ndinsured_deposit_inv     NUMBER(24,4),
  nettrade_fasset_pay       NUMBER(24,4),
  niinsured_pledge_loan     NUMBER(24,4),
  disp_subsidiary_pay       NUMBER(24,4),
  netsell_buyback_fassetrec NUMBER(24,4),
  netsell_buyback_fassetpay NUMBER(24,4),
  remark                    VARCHAR2(1000),
  chk_status                VARCHAR2(200),
  isdel                     INTEGER not null,
  src_company_cd            VARCHAR2(60),
  srcid                     VARCHAR2(100),
  src_cd                    VARCHAR2(10) not null,
  updt_by                   NUMBER(16) not null,
  updt_dt                   TIMESTAMP(6) not null
)
tablespace CS_MASTER_TEST
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
alter table COMPY_CASHFLOW
  add constraint COMPY_CASHFLOW_PKEY1 primary key (COMPY_CASHFLOW_SID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table COMPY_CREDITAPPLY_CMB
prompt ====================================
prompt
create table COMPY_CREDITAPPLY_CMB
(
  creditapply_id     VARCHAR2(30) not null,
  company_id         NUMBER(16) not null,
  submit_dt          DATE,
  operate_orgid      INTEGER,
  operate_orgnm      VARCHAR2(300),
  term_month         INTEGER,
  exposure_amt       NUMBER(38,9),
  nominal_amt        NUMBER(38,9),
  is_lowrisk         INTEGER,
  apply_status       VARCHAR2(30),
  apply_comment      VARCHAR2(4000),
  apply_final_cd     VARCHAR2(30),
  creditline_type_cd VARCHAR2(30),
  business_cd        VARCHAR2(30),
  sub_business_cd    VARCHAR2(30),
  final_exposure_amt NUMBER(38,9),
  final_nominal_amt  NUMBER(38,9),
  isdel              INTEGER not null,
  src_company_cd     VARCHAR2(60),
  src_cd             VARCHAR2(10) not null,
  updt_by            NUMBER(16) not null,
  updt_dt            TIMESTAMP(6) not null
)
tablespace USERS
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
comment on table COMPY_CREDITAPPLY_CMB
  is '授信申请';
comment on column COMPY_CREDITAPPLY_CMB.creditapply_id
  is '授信申请编号';
comment on column COMPY_CREDITAPPLY_CMB.company_id
  is '企业标识符';
comment on column COMPY_CREDITAPPLY_CMB.submit_dt
  is '提交时间';
comment on column COMPY_CREDITAPPLY_CMB.operate_orgid
  is '申请机构ID';
comment on column COMPY_CREDITAPPLY_CMB.operate_orgnm
  is '申请机构名称';
comment on column COMPY_CREDITAPPLY_CMB.term_month
  is '期限（月）';
comment on column COMPY_CREDITAPPLY_CMB.exposure_amt
  is '申请敞口金额';
comment on column COMPY_CREDITAPPLY_CMB.nominal_amt
  is '申请名义金额';
comment on column COMPY_CREDITAPPLY_CMB.is_lowrisk
  is '是否低风险';
comment on column COMPY_CREDITAPPLY_CMB.apply_status
  is '申请状态';
comment on column COMPY_CREDITAPPLY_CMB.apply_comment
  is '意见详情';
comment on column COMPY_CREDITAPPLY_CMB.apply_final_cd
  is '终批意见';
comment on column COMPY_CREDITAPPLY_CMB.creditline_type_cd
  is '授信类型';
comment on column COMPY_CREDITAPPLY_CMB.business_cd
  is '授信业务品种';
comment on column COMPY_CREDITAPPLY_CMB.sub_business_cd
  is '授信业务子品种';
comment on column COMPY_CREDITAPPLY_CMB.final_exposure_amt
  is '终批敞口金额';
comment on column COMPY_CREDITAPPLY_CMB.final_nominal_amt
  is '终批名义金额';
comment on column COMPY_CREDITAPPLY_CMB.isdel
  is '是否删除';
comment on column COMPY_CREDITAPPLY_CMB.src_company_cd
  is '源企业代码';
comment on column COMPY_CREDITAPPLY_CMB.src_cd
  is '源系统';
comment on column COMPY_CREDITAPPLY_CMB.updt_by
  is '更新人';
comment on column COMPY_CREDITAPPLY_CMB.updt_dt
  is '更新时间';
alter table COMPY_CREDITAPPLY_CMB
  add constraint PK_COMPY_CREDITAPPLY_CMB primary key (CREDITAPPLY_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 80K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table COMPY_CREDITINFO_CMB
prompt ===================================
prompt
create table COMPY_CREDITINFO_CMB
(
  creditinfo_id      VARCHAR2(30) not null,
  company_id         NUMBER(16) not null,
  exposure_amt       NUMBER(24,4),
  nominal_amt        NUMBER(24,4),
  exposure_balance   NUMBER(24,4),
  exposure_remain    NUMBER(24,4),
  start_dt           DATE,
  end_dt             DATE,
  is_cmbrelatecust   INTEGER,
  creditline_type_cd VARCHAR2(30),
  is_lowrisk         INTEGER,
  use_org_id         INTEGER,
  use_org_nm         VARCHAR2(300),
  loan_mode_cd       VARCHAR2(30),
  credit_status_cd   VARCHAR2(30),
  is_exposure        INTEGER,
  currency           VARCHAR2(30),
  total_loan_amt     NUMBER(24,4),
  business_balance   NUMBER(24,4),
  term_month         INTEGER,
  guaranty_type_cd   VARCHAR2(30),
  isdel              INTEGER not null,
  src_company_cd     VARCHAR2(60),
  src_cd             VARCHAR2(10) not null,
  updt_by            NUMBER(16) not null,
  updt_dt            TIMESTAMP(6) not null
)
tablespace USERS
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
comment on table COMPY_CREDITINFO_CMB
  is '授信情况';
comment on column COMPY_CREDITINFO_CMB.creditinfo_id
  is '额度编号';
comment on column COMPY_CREDITINFO_CMB.company_id
  is '企业标识符';
comment on column COMPY_CREDITINFO_CMB.exposure_amt
  is '额度敞口金额';
comment on column COMPY_CREDITINFO_CMB.nominal_amt
  is '额度名义金额';
comment on column COMPY_CREDITINFO_CMB.exposure_balance
  is '已用敞口额度';
comment on column COMPY_CREDITINFO_CMB.exposure_remain
  is '可用敞口额度';
comment on column COMPY_CREDITINFO_CMB.start_dt
  is '额度起始日';
comment on column COMPY_CREDITINFO_CMB.end_dt
  is '额度到期日';
comment on column COMPY_CREDITINFO_CMB.is_cmbrelatecust
  is '是否我行关联客户';
comment on column COMPY_CREDITINFO_CMB.creditline_type_cd
  is '授信类型';
comment on column COMPY_CREDITINFO_CMB.is_lowrisk
  is '是否低风险';
comment on column COMPY_CREDITINFO_CMB.use_org_id
  is '使用机构ID';
comment on column COMPY_CREDITINFO_CMB.use_org_nm
  is '使用机构';
comment on column COMPY_CREDITINFO_CMB.loan_mode_cd
  is '贷款组织方式';
comment on column COMPY_CREDITINFO_CMB.credit_status_cd
  is '额度状态';
comment on column COMPY_CREDITINFO_CMB.is_exposure
  is '是否敞口额度T`1';
comment on column COMPY_CREDITINFO_CMB.currency
  is '币种T1';
comment on column COMPY_CREDITINFO_CMB.total_loan_amt
  is '累计放款金额T1';
comment on column COMPY_CREDITINFO_CMB.business_balance
  is '业务余额T1';
comment on column COMPY_CREDITINFO_CMB.term_month
  is '期限（月）';
comment on column COMPY_CREDITINFO_CMB.guaranty_type_cd
  is '主要担保方式';
comment on column COMPY_CREDITINFO_CMB.isdel
  is '是否删除';
comment on column COMPY_CREDITINFO_CMB.src_company_cd
  is '源企业代码';
comment on column COMPY_CREDITINFO_CMB.src_cd
  is '源系统';
comment on column COMPY_CREDITINFO_CMB.updt_by
  is '更新人';
comment on column COMPY_CREDITINFO_CMB.updt_dt
  is '更新时间';
alter table COMPY_CREDITINFO_CMB
  add constraint PK_COMPY_CREDITINFO_CMB primary key (CREDITINFO_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 80K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table COMPY_CREDITRATING
prompt =================================
prompt
create table COMPY_CREDITRATING
(
  compy_creditrating_sid NUMBER(16) not null,
  company_id             NUMBER(16) not null,
  notice_dt              DATE,
  itype_cd               NUMBER(16),
  rating_dt              DATE not null,
  rate_typeid            NUMBER(16),
  rating                 VARCHAR2(30) not null,
  rate_fwd_cd            NUMBER(16),
  credit_org_id          NUMBER(16),
  datasrc_type           INTEGER,
  data_src               VARCHAR2(500),
  remark                 VARCHAR2(2000),
  isdel                  INTEGER not null,
  src_company_cd         VARCHAR2(60),
  srcid                  VARCHAR2(100),
  src_cd                 VARCHAR2(10) not null,
  updt_dt                TIMESTAMP(6) not null
)
tablespace CS_MASTER_TEST
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
comment on column COMPY_CREDITRATING.compy_creditrating_sid
  is '流水号';
comment on column COMPY_CREDITRATING.company_id
  is '企业标识符';
comment on column COMPY_CREDITRATING.notice_dt
  is '公告日期';
comment on column COMPY_CREDITRATING.itype_cd
  is '机构当事人属性';
comment on column COMPY_CREDITRATING.rating_dt
  is '评级日期';
comment on column COMPY_CREDITRATING.rate_typeid
  is '信用评级类型';
comment on column COMPY_CREDITRATING.rating
  is '信用评级';
comment on column COMPY_CREDITRATING.rate_fwd_cd
  is '评级展望';
comment on column COMPY_CREDITRATING.credit_org_id
  is '评级机构标识符';
comment on column COMPY_CREDITRATING.datasrc_type
  is '评级信息来源类别';
comment on column COMPY_CREDITRATING.data_src
  is '资料来源';
comment on column COMPY_CREDITRATING.remark
  is '备注';
comment on column COMPY_CREDITRATING.isdel
  is '是否删除';
comment on column COMPY_CREDITRATING.src_company_cd
  is '源企业代码';
comment on column COMPY_CREDITRATING.srcid
  is '源系统主键';
comment on column COMPY_CREDITRATING.src_cd
  is '源系统';
comment on column COMPY_CREDITRATING.updt_dt
  is '更新时间';
alter table COMPY_CREDITRATING
  add constraint COMPY_CREDITRATING_PKEY primary key (COMPY_CREDITRATING_SID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table COMPY_CREDITRATING_CMB
prompt =====================================
prompt
create table COMPY_CREDITRATING_CMB
(
  rating_no            VARCHAR2(30) not null,
  company_id           NUMBER(16) not null,
  auto_rating          INTEGER,
  final_rating         INTEGER,
  rating_period        DATE,
  rating_start_dt      TIMESTAMP(6),
  effect_end_dt        TIMESTAMP(6),
  autorating_avgpd     NUMBER(24,4),
  finalrating_avgpd    NUMBER(24,4),
  adjust_reasontype_cd VARCHAR2(30),
  adjust_reason        VARCHAR2(2000),
  isdel                INTEGER not null,
  src_company_cd       VARCHAR2(60),
  src_cd               VARCHAR2(10) not null,
  updt_by              NUMBER(16) not null,
  updt_dt              TIMESTAMP(6) not null
)
tablespace USERS
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
comment on table COMPY_CREDITRATING_CMB
  is '行内评级';
comment on column COMPY_CREDITRATING_CMB.rating_no
  is '评级业务编号';
comment on column COMPY_CREDITRATING_CMB.company_id
  is '企业标识符';
comment on column COMPY_CREDITRATING_CMB.auto_rating
  is '自动评级';
comment on column COMPY_CREDITRATING_CMB.final_rating
  is '终审评级';
comment on column COMPY_CREDITRATING_CMB.rating_period
  is '评级期次';
comment on column COMPY_CREDITRATING_CMB.rating_start_dt
  is '评级发起日期';
comment on column COMPY_CREDITRATING_CMB.effect_end_dt
  is '评级有效到期日';
comment on column COMPY_CREDITRATING_CMB.autorating_avgpd
  is '自动评级平均PD';
comment on column COMPY_CREDITRATING_CMB.finalrating_avgpd
  is '终审评级平均PD';
comment on column COMPY_CREDITRATING_CMB.adjust_reasontype_cd
  is '调整等级理由级别';
comment on column COMPY_CREDITRATING_CMB.adjust_reason
  is '调整等级理由';
comment on column COMPY_CREDITRATING_CMB.isdel
  is '是否删除';
comment on column COMPY_CREDITRATING_CMB.src_company_cd
  is '源企业代码';
comment on column COMPY_CREDITRATING_CMB.src_cd
  is '源系统';
comment on column COMPY_CREDITRATING_CMB.updt_by
  is '更新人';
comment on column COMPY_CREDITRATING_CMB.updt_dt
  is '更新时间';
alter table COMPY_CREDITRATING_CMB
  add constraint PK_COMPY_CREDITRATING_CMB primary key (RATING_NO)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 80K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table COMPY_CREDITRATING_INFO
prompt ======================================
prompt
create table COMPY_CREDITRATING_INFO
(
  compy_creditrating_info_sid NUMBER(20) not null,
  company_id                  NUMBER(20) not null,
  company_nm                  VARCHAR2(300) not null,
  credit_org_nm               VARCHAR2(200),
  rating_current              VARCHAR2(30) not null,
  rating_prev                 VARCHAR2(30) not null,
  rate_fwd_current            VARCHAR2(80),
  rate_fwd_prev               VARCHAR2(80),
  creditrating                CHAR(16),
  rating_dt_current           DATE not null,
  rating_dt_prev              DATE not null,
  data_src                    VARCHAR2(500),
  datasrc_content             CLOB,
  updt_dt                     DATE
)
tablespace CS_MASTER_TEST
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

prompt
prompt Creating table COMPY_ELEMENT
prompt ============================
prompt
create table COMPY_ELEMENT
(
  compy_element_sid NUMBER(16) not null,
  company_id        NUMBER(16) not null,
  element_cd        VARCHAR2(30) not null,
  element_value     CLOB,
  element_src       VARCHAR2(200),
  element_desc      VARCHAR2(2000),
  rpt_dt            DATE,
  isdel             INTEGER,
  client_id         NUMBER(16) not null,
  updt_by           NUMBER(16) not null,
  updt_dt           TIMESTAMP(6) not null
)
tablespace CS_MASTER_TEST
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
alter table COMPY_ELEMENT
  add constraint PK_COMPY_ELEMENT primary key (COMPY_ELEMENT_SID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table COMPY_EVENT_TYPE
prompt ===============================
prompt
create table COMPY_EVENT_TYPE
(
  id            NUMBER(16) not null,
  type_name     VARCHAR2(50) not null,
  importance    INTEGER not null,
  creation_time TIMESTAMP(6) not null,
  update_time   TIMESTAMP(6)
)
tablespace CS_MASTER_TEST
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
alter table COMPY_EVENT_TYPE
  add constraint COMPY_EVENT_TYPE_PKEY primary key (ID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table COMPY_EXPOSURE
prompt =============================
prompt
create table COMPY_EXPOSURE
(
  compy_exposure_sid NUMBER(16) not null,
  company_id         NUMBER(16) not null,
  exposure_sid       NUMBER(16) not null,
  rpt_dt             DATE not null,
  start_dt           DATE,
  end_dt             DATE,
  is_new             INTEGER,
  isdel              INTEGER not null,
  client_id          NUMBER(16),
  updt_by            NUMBER(16),
  updt_dt            TIMESTAMP(6) not null
)
tablespace CS_MASTER_TEST
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
alter table COMPY_EXPOSURE
  add constraint PK_COMPY_EXPOSURE primary key (COMPY_EXPOSURE_SID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table COMPY_FACTOR_FINANCE
prompt ===================================
prompt
create table COMPY_FACTOR_FINANCE
(
  compy_factor_finance_sid NUMBER(16) not null,
  company_id               NUMBER(16) not null,
  exposure_sid             NUMBER(16) not null,
  factor_cd                VARCHAR2(30) not null,
  factor_value             NUMBER(32,16),
  selected_option          INTEGER,
  rpt_dt                   DATE,
  rpt_timetype_cd          INTEGER,
  remark                   VARCHAR2(1000),
  isdel                    INTEGER,
  client_id                NUMBER(16) not null,
  updt_by                  NUMBER(16) not null,
  updt_dt                  TIMESTAMP(6) not null
)
tablespace CS_MASTER_TEST
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
alter table COMPY_FACTOR_FINANCE
  add constraint PK_COMPY_FACTOR_FINANCE primary key (COMPY_FACTOR_FINANCE_SID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table COMPY_FACTOR_OPERATION
prompt =====================================
prompt
create table COMPY_FACTOR_OPERATION
(
  compy_factor_operation_sid NUMBER(16) not null,
  company_id                 NUMBER(16) not null,
  exposure_sid               NUMBER(16) not null,
  factor_cd                  VARCHAR2(30) not null,
  factor_value               VARCHAR2(1000),
  selected_option            INTEGER,
  rpt_dt                     DATE,
  rpt_timetype_cd            INTEGER,
  notice_dt                  DATE,
  remark                     VARCHAR2(1000),
  isdel                      INTEGER,
  client_id                  NUMBER(16) not null,
  updt_by                    NUMBER(16) not null,
  updt_dt                    TIMESTAMP(6) not null
)
tablespace CS_MASTER_TEST
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
alter table COMPY_FACTOR_OPERATION
  add constraint PK_COMPY_FACTOR_OPERATION primary key (COMPY_FACTOR_OPERATION_SID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table COMPY_FINANAUDIT
prompt ===============================
prompt
create table COMPY_FINANAUDIT
(
  compy_finanaudit_sid NUMBER(16) not null,
  company_id           NUMBER(16) not null,
  rpt_dt               INTEGER not null,
  start_dt             INTEGER,
  accting_strd_typecd  INTEGER not null,
  audit_view_typeid    NUMBER(16),
  audit_view           CLOB,
  cpa                  VARCHAR2(80),
  audit_org            VARCHAR2(300),
  audit_dt             DATE,
  isdel                INTEGER,
  srcid                VARCHAR2(100),
  src_cd               VARCHAR2(10),
  updt_by              NUMBER(16) not null,
  updt_dt              TIMESTAMP(6)
)
tablespace CS_MASTER_TEST
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
alter table COMPY_FINANAUDIT
  add constraint PK_COMPY_FINANAUDIT primary key (COMPY_FINANAUDIT_SID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table COMPY_FINANCE
prompt ============================
prompt
create table COMPY_FINANCE
(
  company_id                NUMBER(20) not null,
  rpt_dt                    DATE not null,
  fst_notice_dt             DATE,
  latest_notice_dt          DATE,
  start_dt                  NUMBER,
  end_dt                    NUMBER,
  rpt_timetype_cd           NUMBER(11) not null,
  combine_type_cd           NUMBER,
  rpt_srctype_id            NUMBER,
  data_ajust_type           NUMBER,
  data_type                 NUMBER,
  is_public_rpt             NUMBER,
  company_type              NUMBER,
  currency                  VARCHAR2(6),
  monetary_fund             NUMBER,
  tradef_asset              NUMBER,
  bill_rec                  NUMBER,
  account_rec               NUMBER,
  other_rec                 NUMBER,
  advance_pay               NUMBER,
  dividend_rec              NUMBER,
  interest_rec              NUMBER,
  inventory                 NUMBER,
  nonl_asset_oneyear        NUMBER,
  defer_expense             NUMBER,
  other_lasset              NUMBER,
  lasset_other              NUMBER,
  lasset_balance            NUMBER,
  sum_lasset                NUMBER,
  saleable_fasset           NUMBER,
  held_maturity_inv         NUMBER,
  estate_invest             NUMBER,
  lte_quity_inv             NUMBER,
  ltrec                     NUMBER,
  fixed_asset               NUMBER,
  construction_material     NUMBER,
  construction_progress     NUMBER,
  liquidate_fixed_asset     NUMBER,
  product_biology_asset     NUMBER,
  oilgas_asset              NUMBER,
  intangible_asset          NUMBER,
  develop_exp               NUMBER,
  good_will                 NUMBER,
  ltdefer_asset             NUMBER,
  defer_incometax_asset     NUMBER,
  other_nonl_asset          NUMBER,
  nonlasset_other           NUMBER,
  nonlasset_balance         NUMBER,
  sum_nonl_asset            NUMBER,
  cash_and_depositcbank     NUMBER,
  deposit_infi              NUMBER,
  fi_deposit                NUMBER,
  precious_metal            NUMBER,
  lend_fund                 NUMBER,
  derive_fasset             NUMBER,
  buy_sellback_fasset       NUMBER,
  loan_advances             NUMBER,
  agency_assets             NUMBER,
  premium_rec               NUMBER,
  subrogation_rec           NUMBER,
  ri_rec                    NUMBER,
  undue_rireserve_rec       NUMBER,
  claim_rireserve_rec       NUMBER,
  life_rireserve_rec        NUMBER,
  lthealth_rireserve_rec    NUMBER,
  gdeposit_pay              NUMBER,
  insured_pledge_loan       NUMBER,
  capitalg_deposit_pay      NUMBER,
  independent_asset         NUMBER,
  client_fund               NUMBER,
  settlement_provision      NUMBER,
  client_provision          NUMBER,
  seat_fee                  NUMBER,
  other_asset               NUMBER,
  asset_other               NUMBER,
  asset_balance             NUMBER,
  sum_asset                 NUMBER,
  st_borrow                 NUMBER,
  trade_fliab               NUMBER,
  bill_pay                  NUMBER,
  account_pay               NUMBER,
  advance_receive           NUMBER,
  salary_pay                NUMBER,
  tax_pay                   NUMBER,
  interest_pay              NUMBER,
  dividend_pay              NUMBER,
  other_pay                 NUMBER,
  accrue_expense            NUMBER,
  anticipate_liab           NUMBER,
  defer_income              NUMBER,
  nonl_liab_oneyear         NUMBER,
  other_lliab               NUMBER,
  lliab_other               NUMBER,
  lliab_balance             NUMBER,
  sum_lliab                 NUMBER,
  lt_borrow                 NUMBER,
  bond_pay                  NUMBER,
  lt_account_pay            NUMBER,
  special_pay               NUMBER,
  defer_incometax_liab      NUMBER,
  other_nonl_liab           NUMBER,
  nonl_liab_other           NUMBER,
  nonl_liab_balance         NUMBER,
  sum_nonl_liab             NUMBER,
  borrow_from_cbank         NUMBER,
  borrow_fund               NUMBER,
  derive_financedebt        NUMBER,
  sell_buyback_fasset       NUMBER,
  accept_deposit            NUMBER,
  agency_liab               NUMBER,
  other_liab                NUMBER,
  premium_advance           NUMBER,
  comm_pay                  NUMBER,
  ri_pay                    NUMBER,
  gdeposit_rec              NUMBER,
  insured_deposit_inv       NUMBER,
  undue_reserve             NUMBER,
  claim_reserve             NUMBER,
  life_reserve              NUMBER,
  lt_health_reserve         NUMBER,
  independent_liab          NUMBER,
  pledge_borrow             NUMBER,
  agent_trade_security      NUMBER,
  agent_uw_security         NUMBER,
  liab_other                NUMBER,
  liab_balance              NUMBER,
  sum_liab                  NUMBER,
  share_capital             NUMBER,
  capital_reserve           NUMBER,
  surplus_reserve           NUMBER,
  retained_earning          NUMBER,
  inventory_share           NUMBER,
  general_risk_prepare      NUMBER,
  diff_conversion_fc        NUMBER,
  minority_equity           NUMBER,
  sh_equity_other           NUMBER,
  sh_equity_balance         NUMBER,
  sum_parent_equity         NUMBER,
  sum_sh_equity             NUMBER,
  liabsh_equity_other       NUMBER,
  liabsh_equity_balance     NUMBER,
  sum_liabsh_equity         NUMBER,
  td_eposit                 NUMBER,
  st_bond_rec               NUMBER,
  claim_pay                 NUMBER,
  policy_divi_pay           NUMBER,
  unconfirm_inv_loss        NUMBER,
  ricontact_reserve_rec     NUMBER,
  deposit                   NUMBER,
  contact_reserve           NUMBER,
  invest_rec                NUMBER,
  specia_lreserve           NUMBER,
  subsidy_rec               NUMBER,
  marginout_fund            NUMBER,
  export_rebate_rec         NUMBER,
  defer_income_oneyear      NUMBER,
  lt_salary_pay             NUMBER,
  fvalue_fasset             NUMBER,
  define_fvalue_fasset      NUMBER,
  internal_rec              NUMBER,
  clheld_sale_ass           NUMBER,
  fvalue_fliab              NUMBER,
  define_fvalue_fliab       NUMBER,
  internal_pay              NUMBER,
  clheld_sale_liab          NUMBER,
  anticipate_lliab          NUMBER,
  other_equity              NUMBER,
  other_cincome             NUMBER,
  plan_cash_divi            NUMBER,
  parent_equity_other       NUMBER,
  parent_equity_balance     NUMBER,
  preferred_stock           NUMBER,
  prefer_stoc_bond          NUMBER,
  cons_biolo_asset          NUMBER,
  stock_num_end             NUMBER,
  net_mas_set               NUMBER,
  outward_remittance        NUMBER,
  cdandbill_rec             NUMBER,
  hedge_reserve             NUMBER,
  suggest_assign_divi       NUMBER,
  marginout_security        NUMBER,
  cagent_trade_security     NUMBER,
  trade_risk_prepare        NUMBER,
  creditor_planinv          NUMBER,
  short_financing           NUMBER,
  receivables               NUMBER,
  operate_reve              NUMBER,
  operate_exp               NUMBER,
  operate_tax               NUMBER,
  sale_exp                  NUMBER,
  manage_exp                NUMBER,
  finance_exp               NUMBER,
  asset_devalue_loss        NUMBER,
  fvalue_income             NUMBER,
  invest_income             NUMBER,
  intn_reve                 NUMBER,
  int_reve                  NUMBER,
  int_exp                   NUMBER,
  commn_reve                NUMBER,
  comm_reve                 NUMBER,
  comm_exp                  NUMBER,
  exchange_income           NUMBER,
  premium_earned            NUMBER,
  premium_income            NUMBER,
  ripremium                 NUMBER,
  premium_exp               NUMBER,
  indemnity_exp             NUMBER,
  amortise_indemnity_exp    NUMBER,
  duty_reserve              NUMBER,
  amortise_duty_reserve     NUMBER,
  rireve                    NUMBER,
  riexp                     NUMBER,
  surrender_premium         NUMBER,
  policy_divi_exp           NUMBER,
  amortise_riexp            NUMBER,
  security_uw               NUMBER,
  client_asset_manage       NUMBER,
  operate_profit_other      NUMBER,
  operate_profit_balance    NUMBER,
  operate_profit            NUMBER,
  nonoperate_reve           NUMBER,
  nonoperate_exp            NUMBER,
  nonlasset_net_loss        NUMBER,
  sum_profit_other          NUMBER,
  sum_profit_balance        NUMBER,
  sum_profit                NUMBER,
  income_tax                NUMBER,
  net_profit_other2         NUMBER,
  net_profit_balance1       NUMBER,
  net_profit_balance2       NUMBER,
  net_profit                NUMBER,
  parent_net_profit         NUMBER,
  minority_income           NUMBER,
  undistribute_profit       NUMBER,
  basic_eps                 NUMBER,
  diluted_eps               NUMBER,
  invest_joint_income       NUMBER,
  total_operate_reve        NUMBER,
  total_operate_exp         NUMBER,
  other_reve                NUMBER,
  other_exp                 NUMBER,
  unconfirm_invloss         NUMBER,
  sum_cincome               NUMBER,
  parent_cincome            NUMBER,
  minority_cincome          NUMBER,
  net_contact_reserve       NUMBER,
  rdexp                     NUMBER,
  operate_manage_exp        NUMBER,
  insur_reve                NUMBER,
  nonlasset_reve            NUMBER,
  total_operatereve_other   NUMBER,
  net_indemnity_exp         NUMBER,
  total_operateexp_other    NUMBER,
  net_profit_other1         NUMBER,
  cincome_balance1          NUMBER,
  cincome_balance2          NUMBER,
  other_net_income          NUMBER,
  reve_other                NUMBER,
  reve_balance              NUMBER,
  operate_exp_other         NUMBER,
  operate_exp_balance       NUMBER,
  bank_intnreve             NUMBER,
  bank_intreve              NUMBER,
  ninsur_commn_reve         NUMBER,
  ninsur_comm_reve          NUMBER,
  ninsur_comm_exp           NUMBER,
  salegoods_service_rec     NUMBER,
  tax_return_rec            NUMBER,
  other_operate_rec         NUMBER,
  ni_deposit                NUMBER,
  niborrow_from_cbank       NUMBER,
  niborrow_from_fi          NUMBER,
  nidisp_trade_fasset       NUMBER,
  nidisp_saleable_fasset    NUMBER,
  niborrow_fund             NUMBER,
  nibuyback_fund            NUMBER,
  operate_flowin_other      NUMBER,
  operate_flowin_balance    NUMBER,
  sum_operate_flowin        NUMBER,
  buygoods_service_pay      NUMBER,
  employee_pay              NUMBER,
  other_operat_epay         NUMBER,
  niloan_advances           NUMBER,
  nideposit_incbankfi       NUMBER,
  indemnity_pay             NUMBER,
  intandcomm_pay            NUMBER,
  operate_flowout_other     NUMBER,
  operate_flowout_balance   NUMBER,
  sum_operate_flowout       NUMBER,
  operate_flow_other        NUMBER,
  operate_flow_balance      NUMBER,
  net_operate_cashflow      NUMBER,
  disposal_inv_rec          NUMBER,
  inv_income_rec            NUMBER,
  disp_filasset_rec         NUMBER,
  disp_subsidiary_rec       NUMBER,
  other_invrec              NUMBER,
  inv_flowin_other          NUMBER,
  inv_flowin_balance        NUMBER,
  sum_inv_flowin            NUMBER,
  buy_filasset_pay          NUMBER,
  inv_pay                   NUMBER,
  get_subsidiary_pay        NUMBER,
  other_inv_pay             NUMBER,
  nipledge_loan             NUMBER,
  inv_flowout_other         NUMBER,
  inv_flowout_balance       NUMBER,
  sum_inv_flowout           NUMBER,
  inv_flow_other            NUMBER,
  inv_cashflow_balance      NUMBER,
  net_inv_cashflow          NUMBER,
  accept_inv_rec            NUMBER,
  loan_rec                  NUMBER,
  other_fina_rec            NUMBER,
  issue_bond_rec            NUMBER,
  niinsured_deposit_inv     NUMBER,
  fina_flowin_other         NUMBER,
  fina_flowin_balance       NUMBER,
  sum_fina_flowin           NUMBER,
  repay_debt_pay            NUMBER,
  divi_profitorint_pay      NUMBER,
  other_fina_pay            NUMBER,
  fina_flowout_other        NUMBER,
  fina_flowout_balance      NUMBER,
  sum_fina_flowout          NUMBER,
  fina_flow_other           NUMBER,
  fina_flow_balance         NUMBER,
  net_fina_cashflow         NUMBER,
  effect_exchange_rate      NUMBER,
  nicash_equi_other         NUMBER,
  nicash_equi_balance       NUMBER,
  nicash_equi               NUMBER,
  cash_equi_beginning       NUMBER,
  cash_equi_ending          NUMBER,
  asset_devalue             NUMBER,
  fixed_asset_etcdepr       NUMBER,
  intangible_asset_amor     NUMBER,
  ltdefer_exp_amor          NUMBER,
  defer_exp_reduce          NUMBER,
  drawing_exp_add           NUMBER,
  disp_filasset_loss        NUMBER,
  fixed_asset_loss          NUMBER,
  fvalue_loss               NUMBER,
  inv_loss                  NUMBER,
  defer_taxasset_reduce     NUMBER,
  defer_taxliab_add         NUMBER,
  inventory_reduce          NUMBER,
  operate_rec_reduce        NUMBER,
  operate_pay_add           NUMBER,
  inoperate_flow_other      NUMBER,
  inoperate_flow_balance    NUMBER,
  innet_operate_cashflow    NUMBER,
  debt_to_capital           NUMBER,
  cb_oneyear                NUMBER,
  finalease_fixed_asset     NUMBER,
  cash_end                  NUMBER,
  cash_begin                NUMBER,
  equi_end                  NUMBER,
  equi_begin                NUMBER,
  innicash_equi_other       NUMBER,
  innicash_equi_balance     NUMBER,
  innicash_equi             NUMBER,
  other                     NUMBER,
  subsidiary_accept         NUMBER,
  subsidiary_pay            NUMBER,
  divi_pay                  NUMBER,
  intandcomm_rec            NUMBER,
  net_rirec                 NUMBER,
  nilend_fund               NUMBER,
  defer_tax                 NUMBER,
  defer_income_amor         NUMBER,
  exchange_loss             NUMBER,
  fixandestate_depr         NUMBER,
  fixed_asset_depr          NUMBER,
  tradef_asset_reduce       NUMBER,
  ndloan_advances           NUMBER,
  reduce_pledget_deposit    NUMBER,
  add_pledget_deposit       NUMBER,
  buy_subsidiary_pay        NUMBER,
  cash_equiending_other     NUMBER,
  cash_equiending_balance   NUMBER,
  nd_depositinc_bankfi      NUMBER,
  niborrow_sell_buyback     NUMBER,
  ndlend_buy_sellback       NUMBER,
  net_cd                    NUMBER,
  nitrade_fliab             NUMBER,
  ndtrade_fasset            NUMBER,
  disp_masset_rec           NUMBER,
  cancel_loan_rec           NUMBER,
  ndborrow_from_cbank       NUMBER,
  ndfide_posit              NUMBER,
  ndissue_cd                NUMBER,
  nilend_sell_buyback       NUMBER,
  ndborrow_sell_buyback     NUMBER,
  nitrade_fasset            NUMBER,
  ndtrade_fliab             NUMBER,
  buy_finaleaseasset_pay    NUMBER,
  niaccount_rec             NUMBER,
  issue_cd                  NUMBER,
  addshare_capital_rec      NUMBER,
  issue_share_rec           NUMBER,
  bond_intpay               NUMBER,
  niother_finainstru        NUMBER,
  uwsecurity_rec            NUMBER,
  buysellback_fasset_rec    NUMBER,
  agent_uwsecurity_rec      NUMBER,
  nidirect_inv              NUMBER,
  nitrade_settlement        NUMBER,
  buysellback_fasset_pay    NUMBER,
  nddisp_trade_fasset       NUMBER,
  ndother_fina_instr        NUMBER,
  ndborrow_fund             NUMBER,
  nddirect_inv              NUMBER,
  ndtrade_settlement        NUMBER,
  ndbuyback_fund            NUMBER,
  agenttrade_security_pay   NUMBER,
  nddisp_saleable_fasset    NUMBER,
  nisell_buyback            NUMBER,
  ndbuy_sellback            NUMBER,
  nettrade_fasset_rec       NUMBER,
  net_ripay                 NUMBER,
  ndlend_fund               NUMBER,
  nibuy_sellback            NUMBER,
  ndsell_buyback            NUMBER,
  ndinsured_deposit_inv     NUMBER,
  nettrade_fasset_pay       NUMBER,
  niinsured_pledge_loan     NUMBER,
  disp_subsidiary_pay       NUMBER,
  netsell_buyback_fassetrec NUMBER,
  netsell_buyback_fassetpay NUMBER,
  ebit                      NUMBER,
  ebitda                    NUMBER,
  bank_sub_001              NUMBER,
  bank_sub_002              NUMBER,
  bank_sub_003              NUMBER,
  bank_sub_004              NUMBER,
  bank_sub_005              NUMBER,
  bank_sub_006              NUMBER,
  bank_sub_007              NUMBER,
  bank_sub_008              NUMBER,
  bank_sub_009              NUMBER,
  bank_sub_010              NUMBER,
  bank_sub_011              NUMBER,
  bank_sub_012              NUMBER,
  bank_sub_013              NUMBER,
  bank_sub_014              NUMBER,
  bank_sub_015              NUMBER,
  bank_sub_016              NUMBER,
  bank_sub_017              NUMBER,
  bank_sub_018              NUMBER,
  bank_sub_019              NUMBER,
  bank_sub_020              NUMBER,
  bank_sub_021              NUMBER,
  bank_sub_022              NUMBER,
  bank_sub_023              NUMBER,
  bank_sub_024              NUMBER,
  bank_sub_025              NUMBER,
  bank_sub_026              NUMBER,
  bank_sub_027              NUMBER,
  bank_sub_028              NUMBER,
  bank_sub_029              NUMBER,
  bank_sub_030              NUMBER,
  bank_sub_031              NUMBER,
  bank_sub_032              NUMBER,
  bank_sub_033              NUMBER,
  bank_sub_034              NUMBER,
  bank_sub_035              NUMBER,
  bank_sub_036              NUMBER,
  bank_sub_037              NUMBER,
  bank_sub_038              NUMBER,
  bank_sub_039              NUMBER,
  bank_sub_040              NUMBER,
  bank_sub_041              NUMBER,
  bank_sub_042              NUMBER,
  bank_sub_043              NUMBER,
  bank_sub_044              NUMBER,
  bank_sub_045              NUMBER,
  bank_sub_046              NUMBER,
  bank_sub_047              NUMBER,
  bank_sub_048              NUMBER,
  bank_sub_049              NUMBER,
  bank_sub_050              NUMBER,
  bank_sub_051              NUMBER,
  bank_sub_052              NUMBER,
  bank_sub_053              NUMBER,
  bank_sub_054              NUMBER,
  bank_sub_055              NUMBER,
  bank_sub_056              NUMBER,
  bank_sub_057              NUMBER,
  bank_sub_058              NUMBER,
  bank_sub_059              NUMBER,
  bank_sub_060              NUMBER,
  bank_sub_061              NUMBER,
  bank_sub_062              NUMBER,
  bank_sub_063              NUMBER,
  bank_sub_064              NUMBER,
  bank_sub_065              NUMBER,
  bank_sub_066              NUMBER,
  bank_sub_067              NUMBER,
  bank_sub_068              NUMBER,
  bank_sub_069              NUMBER,
  bank_sub_070              NUMBER,
  bank_sub_071              NUMBER,
  bank_sub_072              NUMBER,
  bank_sub_073              NUMBER,
  bank_sub_074              NUMBER,
  bank_sub_075              NUMBER,
  bank_sub_076              NUMBER,
  bank_sub_077              NUMBER,
  bank_sub_078              NUMBER,
  bank_sub_079              NUMBER,
  bank_sub_080              NUMBER,
  bank_sub_081              NUMBER,
  bank_sub_082              NUMBER,
  bank_sub_083              NUMBER,
  bank_sub_084              NUMBER,
  bank_sub_085              NUMBER,
  bank_sub_086              NUMBER,
  bank_sub_087              NUMBER,
  bank_sub_088              NUMBER,
  bank_sub_089              NUMBER,
  bank_sub_090              NUMBER,
  bank_sub_091              NUMBER,
  bank_sub_092              NUMBER,
  bank_sub_093              NUMBER,
  bank_sub_094              NUMBER,
  bank_sub_095              NUMBER,
  bank_sub_096              NUMBER,
  bank_sub_097              NUMBER,
  bank_sub_098              NUMBER,
  bank_sub_099              NUMBER,
  bank_sub_100              NUMBER,
  bank_sub_101              NUMBER,
  bank_sub_102              NUMBER,
  bank_sub_103              NUMBER,
  bank_sub_104              NUMBER,
  bank_sub_105              NUMBER,
  bank_sub_106              NUMBER,
  bank_sub_107              NUMBER,
  bank_sub_108              NUMBER,
  bank_sub_109              NUMBER,
  bank_sub_110              NUMBER,
  bank_sub_111              NUMBER,
  bank_sub_112              NUMBER,
  bank_sub_113              NUMBER,
  bank_sub_114              NUMBER,
  bank_sub_115              NUMBER,
  bank_sub_116              NUMBER,
  bank_sub_117              NUMBER,
  bank_sub_118              NUMBER,
  bank_sub_119              NUMBER,
  bank_sub_120              NUMBER,
  bank_sub_121              NUMBER,
  bank_sub_122              NUMBER,
  bank_sub_123              NUMBER,
  bank_sub_124              NUMBER,
  bank_sub_125              NUMBER,
  com_expend                NUMBER,
  act_capit_sx              NUMBER,
  act_capit_cx              NUMBER,
  inv_asset_cx              NUMBER,
  udr_reserve_sx            NUMBER,
  min_capit_sx              NUMBER,
  udr_reserve_cx            NUMBER,
  comexpend_cx              NUMBER,
  earnprem_sx               NUMBER,
  min_capit                 NUMBER,
  act_capit                 NUMBER,
  inv_asset_sx              NUMBER,
  ostlr_cx                  NUMBER,
  ror_cx                    NUMBER,
  inv_asset                 NUMBER,
  ostlr_sx                  NUMBER,
  min_capit_cx              NUMBER,
  earnprem_cx               NUMBER,
  earnprem                  NUMBER,
  com_expend_sx             NUMBER,
  com_compensate_cx         NUMBER,
  solven_ratio_sx           NUMBER,
  com_cost_cx               NUMBER,
  earnprem_gr_cx            NUMBER,
  nrorsx                    NUMBER,
  nror                      NUMBER,
  tror                      NUMBER,
  solven_ratio_cx           NUMBER,
  earnprem_gr_sx            NUMBER,
  solven_ratio              NUMBER,
  nror_cx                   NUMBER,
  earnprem_gr               NUMBER,
  sur_rate                  NUMBER,
  ror_sx                    NUMBER,
  secu_sub_001              NUMBER,
  secu_sub_002              NUMBER,
  secu_sub_003              NUMBER,
  secu_sub_004              NUMBER,
  secu_sub_005              NUMBER,
  secu_sub_006              NUMBER,
  secu_sub_007              NUMBER,
  secu_sub_008              NUMBER,
  secu_sub_009              NUMBER,
  secu_sub_010              NUMBER,
  secu_sub_011              NUMBER,
  secu_sub_012              NUMBER,
  secu_sub_013              NUMBER,
  secu_sub_014              NUMBER,
  secu_sub_015              NUMBER,
  secu_sub_016              NUMBER,
  secu_sub_017              NUMBER,
  secu_sub_018              NUMBER,
  top10_frbm                NUMBER,
  spec_ment_loan            NUMBER,
  sum_last3_loan            NUMBER,
  trust_industry_amt        NUMBER,
  owner_industry_amt        NUMBER,
  operate_reve_amt          NUMBER,
  owner_asset               NUMBER,
  new_prod_amt              NUMBER,
  trust_loan_amt            NUMBER,
  trust_quity_inv           NUMBER,
  comp_reserve_fund         NUMBER,
  collect_trust_size        NUMBER,
  client_id                 NUMBER(20),
  updt_by                   NUMBER(20),
  updt_dt                   DATE
)
tablespace CS_MASTER_TEST
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
alter table COMPY_FINANCE
  add primary key (COMPANY_ID, RPT_DT, RPT_TIMETYPE_CD)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table COMPY_FINANCE_BF_LAST_Y
prompt ======================================
prompt
create table COMPY_FINANCE_BF_LAST_Y
(
  company_id_bf_last_y           NUMBER(16) not null,
  rpt_dt_bf_last_y               DATE not null,
  rpt_timetype_cd_bf_last_y      INTEGER not null,
  monetary_fund_bf_last_y        NUMBER(24,4),
  tradef_asset_bf_last_y         NUMBER(24,4),
  bill_rec_bf_last_y             NUMBER(24,4),
  account_rec_bf_last_y          NUMBER(24,4),
  other_rec_bf_last_y            NUMBER(24,4),
  advance_pay_bf_last_y          NUMBER(24,4),
  dividend_rec_bf_last_y         NUMBER(24,4),
  interest_rec_bf_last_y         NUMBER(24,4),
  inventory_bf_last_y            NUMBER(24,4),
  nonl_asset_oneyear_bf_last_y   NUMBER(24,4),
  defer_expense_bf_last_y        NUMBER(24,4),
  other_lasset_bf_last_y         NUMBER(24,4),
  lasset_other_bf_last_y         NUMBER(24,4),
  lasset_balance_bf_last_y       NUMBER(24,4),
  sum_lasset_bf_last_y           NUMBER(24,4),
  saleable_fasset_bf_last_y      NUMBER(24,4),
  held_maturity_inv_bf_last_y    NUMBER(24,4),
  estate_invest_bf_last_y        NUMBER(24,4),
  lte_quity_inv_bf_last_y        NUMBER(24,4),
  ltrec_bf_last_y                NUMBER(24,4),
  fixed_asset_bf_last_y          NUMBER(24,4),
  construct_material_bf_last_y   NUMBER(24,4),
  construct_pro_bf_last_y        NUMBER(24,4),
  liquidate_f_asset_bf_last_y    NUMBER(24,4),
  prod_biology_asset_bf_last_y   NUMBER(24,4),
  oilgas_asset_bf_last_y         NUMBER(24,4),
  intangible_asset_bf_last_y     NUMBER(24,4),
  develop_exp_bf_last_y          NUMBER(24,4),
  good_will_bf_last_y            NUMBER(24,4),
  ltdefer_asset_bf_last_y        NUMBER(24,4),
  defer_intax_asset_bf_last_y    NUMBER(24,4),
  other_nonl_asset_bf_last_y     NUMBER(24,4),
  nonlasset_other_bf_last_y      NUMBER(24,4),
  nonlasset_balance_bf_last_y    NUMBER(24,4),
  sum_nonl_asset_bf_last_y       NUMBER(24,4),
  cash_depositcbank_bf_last_y    NUMBER(24,4),
  deposit_infi_bf_last_y         NUMBER(24,4),
  fi_deposit_bf_last_y           NUMBER(24,4),
  precious_metal_bf_last_y       NUMBER(24,4),
  lend_fund_bf_last_y            NUMBER(24,4),
  derive_fasset_bf_last_y        NUMBER(24,4),
  buy_sellback_fasset_bf_last_y  NUMBER(24,4),
  loan_advances_bf_last_y        NUMBER(24,4),
  agency_assets_bf_last_y        NUMBER(24,4),
  premium_rec_bf_last_y          NUMBER(24,4),
  subrogation_rec_bf_last_y      NUMBER(24,4),
  ri_rec_bf_last_y               NUMBER(24,4),
  undue_rireserve_rec_bf_last_y  NUMBER(24,4),
  claim_rireserve_rec_bf_last_y  NUMBER(24,4),
  life_rireserve_rec_bf_last_y   NUMBER(24,4),
  lthealth_rirese_rec_bf_last_y  NUMBER(24,4),
  gdeposit_pay_bf_last_y         NUMBER(24,4),
  insured_pledge_loan_bf_last_y  NUMBER(24,4),
  capitalg_deposit_pay_bf_last_y NUMBER(24,4),
  independent_asset_bf_last_y    NUMBER(24,4),
  client_fund_bf_last_y          NUMBER(24,4),
  settlement_provision_bf_last_y NUMBER(24,4),
  client_provision_bf_last_y     NUMBER(24,4),
  seat_fee_bf_last_y             NUMBER(24,4),
  other_asset_bf_last_y          NUMBER(24,4),
  asset_other_bf_last_y          NUMBER(24,4),
  asset_balance_bf_last_y        NUMBER(24,4),
  sum_asset_bf_last_y            NUMBER(24,4),
  st_borrow_bf_last_y            NUMBER(24,4),
  trade_fliab_bf_last_y          NUMBER(24,4),
  bill_pay_bf_last_y             NUMBER(24,4),
  account_pay_bf_last_y          NUMBER(24,4),
  advance_receive_bf_last_y      NUMBER(24,4),
  salary_pay_bf_last_y           NUMBER(24,4),
  tax_pay_bf_last_y              NUMBER(24,4),
  interest_pay_bf_last_y         NUMBER(24,4),
  dividend_pay_bf_last_y         NUMBER(24,4),
  other_pay_bf_last_y            NUMBER(24,4),
  accrue_expense_bf_last_y       NUMBER(24,4),
  anticipate_liab_bf_last_y      NUMBER(24,4),
  defer_income_bf_last_y         NUMBER(24,4),
  nonl_liab_oneyear_bf_last_y    NUMBER(24,4),
  other_lliab_bf_last_y          NUMBER(24,4),
  lliab_other_bf_last_y          NUMBER(24,4),
  lliab_balance_bf_last_y        NUMBER(24,4),
  sum_lliab_bf_last_y            NUMBER(24,4),
  lt_borrow_bf_last_y            NUMBER(24,4),
  bond_pay_bf_last_y             NUMBER(24,4),
  lt_account_pay_bf_last_y       NUMBER(24,4),
  special_pay_bf_last_y          NUMBER(24,4),
  defer_incometax_liab_bf_last_y NUMBER(24,4),
  other_nonl_liab_bf_last_y      NUMBER(24,4),
  nonl_liab_other_bf_last_y      NUMBER(24,4),
  nonl_liab_balance_bf_last_y    NUMBER(24,4),
  sum_nonl_liab_bf_last_y        NUMBER(24,4),
  borrow_from_cbank_bf_last_y    NUMBER(24,4),
  borrow_fund_bf_last_y          NUMBER(24,4),
  derive_financedebt_bf_last_y   NUMBER(24,4),
  sell_buyback_fasset_bf_last_y  NUMBER(24,4),
  accept_deposit_bf_last_y       NUMBER(24,4),
  agency_liab_bf_last_y          NUMBER(24,4),
  other_liab_bf_last_y           NUMBER(24,4),
  premium_advance_bf_last_y      NUMBER(24,4),
  comm_pay_bf_last_y             NUMBER(24,4),
  ri_pay_bf_last_y               NUMBER(24,4),
  gdeposit_rec_bf_last_y         NUMBER(24,4),
  insured_deposit_inv_bf_last_y  NUMBER(24,4),
  undue_reserve_bf_last_y        NUMBER(24,4),
  claim_reserve_bf_last_y        NUMBER(24,4),
  life_reserve_bf_last_y         NUMBER(24,4),
  lt_health_reserve_bf_last_y    NUMBER(24,4),
  independent_liab_bf_last_y     NUMBER(24,4),
  pledge_borrow_bf_last_y        NUMBER(24,4),
  agent_trade_security_bf_last_y NUMBER(24,4),
  agent_uw_security_bf_last_y    NUMBER(24,4),
  liab_other_bf_last_y           NUMBER(24,4),
  liab_balance_bf_last_y         NUMBER(24,4),
  sum_liab_bf_last_y             NUMBER(24,4),
  share_capital_bf_last_y        NUMBER(24,4),
  capital_reserve_bf_last_y      NUMBER(24,4),
  surplus_reserve_bf_last_y      NUMBER(24,4),
  retained_earning_bf_last_y     NUMBER(24,4),
  inventory_share_bf_last_y      NUMBER(24,4),
  general_risk_prepare_bf_last_y NUMBER(24,4),
  diff_conversion_fc_bf_last_y   NUMBER(24,4),
  minority_equity_bf_last_y      NUMBER(24,4),
  sh_equity_other_bf_last_y      NUMBER(24,4),
  sh_equity_balance_bf_last_y    NUMBER(24,4),
  sum_parent_equity_bf_last_y    NUMBER(24,4),
  sum_sh_equity_bf_last_y        NUMBER(24,4),
  liabsh_equity_other_bf_last_y  NUMBER(24,4),
  liabsh_equ_balan_bf_last_y     NUMBER(24,4),
  sum_liabsh_equity_bf_last_y    NUMBER(24,4),
  td_eposit_bf_last_y            NUMBER(24,4),
  st_bond_rec_bf_last_y          NUMBER(24,4),
  claim_pay_bf_last_y            NUMBER(24,4),
  policy_divi_pay_bf_last_y      NUMBER(24,4),
  unconfirm_inv_loss_bf_last_y   NUMBER(24,4),
  ricont_res_rec_bf_last_y       NUMBER(24,4),
  deposit_bf_last_y              NUMBER(24,4),
  contact_reserve_bf_last_y      NUMBER(24,4),
  invest_rec_bf_last_y           NUMBER(24,4),
  specia_lreserve_bf_last_y      NUMBER(24,4),
  subsidy_rec_bf_last_y          NUMBER(24,4),
  marginout_fund_bf_last_y       NUMBER(24,4),
  export_rebate_rec_bf_last_y    NUMBER(24,4),
  defer_income_oneyear_bf_last_y NUMBER(24,4),
  lt_salary_pay_bf_last_y        NUMBER(24,4),
  fvalue_fasset_bf_last_y        NUMBER(24,4),
  define_fvalue_fasset_bf_last_y NUMBER(24,4),
  internal_rec_bf_last_y         NUMBER(24,4),
  clheld_sale_ass_bf_last_y      NUMBER(24,4),
  fvalue_fliab_bf_last_y         NUMBER(24,4),
  define_fvalue_fliab_bf_last_y  NUMBER(24,4),
  internal_pay_bf_last_y         NUMBER(24,4),
  clheld_sale_liab_bf_last_y     NUMBER(24,4),
  anticipate_lliab_bf_last_y     NUMBER(24,4),
  other_equity_bf_last_y         NUMBER(24,4),
  other_cincome_bf_last_y        NUMBER(24,4),
  plan_cash_divi_bf_last_y       NUMBER(24,4),
  parent_equity_other_bf_last_y  NUMBER(24,4),
  parent_equ_balan_bf_last_y     NUMBER(24,4),
  preferred_stock_bf_last_y      NUMBER(24,4),
  prefer_stoc_bond_bf_last_y     NUMBER(24,4),
  cons_biolo_asset_bf_last_y     NUMBER(24,4),
  stock_num_end_bf_last_y        NUMBER(24,4),
  net_mas_set_bf_last_y          NUMBER(24,4),
  outward_remittance_bf_last_y   NUMBER(24,4),
  cdandbill_rec_bf_last_y        NUMBER(24,4),
  hedge_reserve_bf_last_y        NUMBER(24,4),
  suggest_assign_divi_bf_last_y  NUMBER(24,4),
  marginout_security_bf_last_y   NUMBER(24,4),
  cagent_trade_secu_bf_last_y    NUMBER(24,4),
  trade_risk_prepare_bf_last_y   NUMBER(24,4),
  creditor_planinv_bf_last_y     NUMBER(24,4),
  short_financing_bf_last_y      NUMBER(24,4),
  receivables_bf_last_y          NUMBER(24,4),
  operate_reve_bf_last_y         NUMBER(24,4),
  operate_exp_bf_last_y          NUMBER(24,4),
  operate_tax_bf_last_y          NUMBER(24,4),
  sale_exp_bf_last_y             NUMBER(24,4),
  manage_exp_bf_last_y           NUMBER(24,4),
  finance_exp_bf_last_y          NUMBER(24,4),
  asset_devalue_loss_bf_last_y   NUMBER(24,4),
  fvalue_income_bf_last_y        NUMBER(24,4),
  invest_income_bf_last_y        NUMBER(24,4),
  intn_reve_bf_last_y            NUMBER(24,4),
  int_reve_bf_last_y             NUMBER(24,4),
  int_exp_bf_last_y              NUMBER(24,4),
  commn_reve_bf_last_y           NUMBER(24,4),
  comm_reve_bf_last_y            NUMBER(24,4),
  comm_exp_bf_last_y             NUMBER(24,4),
  exchange_income_bf_last_y      NUMBER(24,4),
  premium_earned_bf_last_y       NUMBER(24,4),
  premium_income_bf_last_y       NUMBER(24,4),
  ripremium_bf_last_y            NUMBER(24,4),
  premium_exp_bf_last_y          NUMBER(24,4),
  indemnity_exp_bf_last_y        NUMBER(24,4),
  amortise_inde_exp_bf_last_y    NUMBER(24,4),
  duty_reserve_bf_last_y         NUMBER(24,4),
  amortise_duty_rese_bf_last_y   NUMBER(24,4),
  rireve_bf_last_y               NUMBER(24,4),
  riexp_bf_last_y                NUMBER(24,4),
  surrender_premium_bf_last_y    NUMBER(24,4),
  policy_divi_exp_bf_last_y      NUMBER(24,4),
  amortise_riexp_bf_last_y       NUMBER(24,4),
  security_uw_bf_last_y          NUMBER(24,4),
  client_asset_manage_bf_last_y  NUMBER(24,4),
  operate_profit_other_bf_last_y NUMBER(24,4),
  operate_profit_balan_bf_last_y NUMBER(24,4),
  operate_profit_bf_last_y       NUMBER(24,4),
  nonoperate_reve_bf_last_y      NUMBER(24,4),
  nonoperate_exp_bf_last_y       NUMBER(24,4),
  nonlasset_net_loss_bf_last_y   NUMBER(24,4),
  sum_profit_other_bf_last_y     NUMBER(24,4),
  sum_profit_balance_bf_last_y   NUMBER(24,4),
  sum_profit_bf_last_y           NUMBER(24,4),
  income_tax_bf_last_y           NUMBER(24,4),
  net_profit_other2_bf_last_y    NUMBER(24,4),
  net_profit_balance1_bf_last_y  NUMBER(24,4),
  net_profit_balance2_bf_last_y  NUMBER(24,4),
  net_profit_bf_last_y           NUMBER(24,4),
  parent_net_profit_bf_last_y    NUMBER(24,4),
  minority_income_bf_last_y      NUMBER(24,4),
  undistribute_profit_bf_last_y  NUMBER(24,4),
  basic_eps_bf_last_y            NUMBER(24,4),
  diluted_eps_bf_last_y          NUMBER(24,4),
  invest_joint_income_bf_last_y  NUMBER(24,4),
  total_operate_reve_bf_last_y   NUMBER(24,4),
  total_operate_exp_bf_last_y    NUMBER(24,4),
  other_reve_bf_last_y           NUMBER(24,4),
  other_exp_bf_last_y            NUMBER(24,4),
  unconfirm_invloss_bf_last_y    NUMBER(24,4),
  sum_cincome_bf_last_y          NUMBER(24,4),
  parent_cincome_bf_last_y       NUMBER(24,4),
  minority_cincome_bf_last_y     NUMBER(24,4),
  net_contact_reserve_bf_last_y  NUMBER(24,4),
  rdexp_bf_last_y                NUMBER(24,4),
  operate_manage_exp_bf_last_y   NUMBER(24,4),
  insur_reve_bf_last_y           NUMBER(24,4),
  nonlasset_reve_bf_last_y       NUMBER(24,4),
  total_reve_other_bf_last_y     NUMBER(24,4),
  net_indemnity_exp_bf_last_y    NUMBER(24,4),
  total_exp_other_bf_last_y      NUMBER(24,4),
  net_profit_other1_bf_last_y    NUMBER(24,4),
  cincome_balance1_bf_last_y     NUMBER(24,4),
  cincome_balance2_bf_last_y     NUMBER(24,4),
  other_net_income_bf_last_y     NUMBER(24,4),
  reve_other_bf_last_y           NUMBER(24,4),
  reve_balance_bf_last_y         NUMBER(24,4),
  operate_exp_other_bf_last_y    NUMBER(24,4),
  operate_exp_balance_bf_last_y  NUMBER(24,4),
  bank_intnreve_bf_last_y        NUMBER(24,4),
  bank_intreve_bf_last_y         NUMBER(24,4),
  ninsur_commn_reve_bf_last_y    NUMBER(24,4),
  ninsur_comm_reve_bf_last_y     NUMBER(24,4),
  ninsur_comm_exp_bf_last_y      NUMBER(24,4),
  salegoods_serv_rec_bf_last_y   NUMBER(24,4),
  tax_return_rec_bf_last_y       NUMBER(24,4),
  other_operate_rec_bf_last_y    NUMBER(24,4),
  ni_deposit_bf_last_y           NUMBER(24,4),
  niborrow_from_cbank_bf_last_y  NUMBER(24,4),
  niborrow_from_fi_bf_last_y     NUMBER(24,4),
  nidisp_trade_fasset_bf_last_y  NUMBER(24,4),
  nidisp_sale_fasset_bf_last_y   NUMBER(24,4),
  niborrow_fund_bf_last_y        NUMBER(24,4),
  nibuyback_fund_bf_last_y       NUMBER(24,4),
  operate_flowin_other_bf_last_y NUMBER(24,4),
  oper_flowin_balan_bf_last_y    NUMBER(24,4),
  sum_operate_flowin_bf_last_y   NUMBER(24,4),
  buygoods_service_pay_bf_last_y NUMBER(24,4),
  employee_pay_bf_last_y         NUMBER(24,4),
  other_operat_epay_bf_last_y    NUMBER(24,4),
  niloan_advances_bf_last_y      NUMBER(24,4),
  nideposit_incbankfi_bf_last_y  NUMBER(24,4),
  indemnity_pay_bf_last_y        NUMBER(24,4),
  intandcomm_pay_bf_last_y       NUMBER(24,4),
  oper_flowout_other_bf_last_y   NUMBER(24,4),
  oper_flowout_balan_bf_last_y   NUMBER(24,4),
  sum_operate_flowout_bf_last_y  NUMBER(24,4),
  operate_flow_other_bf_last_y   NUMBER(24,4),
  operate_flow_balance_bf_last_y NUMBER(24,4),
  net_operate_cashflow_bf_last_y NUMBER(24,4),
  disposal_inv_rec_bf_last_y     NUMBER(24,4),
  inv_income_rec_bf_last_y       NUMBER(24,4),
  disp_filasset_rec_bf_last_y    NUMBER(24,4),
  disp_subsidiary_rec_bf_last_y  NUMBER(24,4),
  other_invrec_bf_last_y         NUMBER(24,4),
  inv_flowin_other_bf_last_y     NUMBER(24,4),
  inv_flowin_balance_bf_last_y   NUMBER(24,4),
  sum_inv_flowin_bf_last_y       NUMBER(24,4),
  buy_filasset_pay_bf_last_y     NUMBER(24,4),
  inv_pay_bf_last_y              NUMBER(24,4),
  get_subsidiary_pay_bf_last_y   NUMBER(24,4),
  other_inv_pay_bf_last_y        NUMBER(24,4),
  nipledge_loan_bf_last_y        NUMBER(24,4),
  inv_flowout_other_bf_last_y    NUMBER(24,4),
  inv_flowout_balance_bf_last_y  NUMBER(24,4),
  sum_inv_flowout_bf_last_y      NUMBER(24,4),
  inv_flow_other_bf_last_y       NUMBER(24,4),
  inv_cashflow_balance_bf_last_y NUMBER(24,4),
  net_inv_cashflow_bf_last_y     NUMBER(24,4),
  accept_inv_rec_bf_last_y       NUMBER(24,4),
  loan_rec_bf_last_y             NUMBER(24,4),
  other_fina_rec_bf_last_y       NUMBER(24,4),
  issue_bond_rec_bf_last_y       NUMBER(24,4),
  niinsur_deposit_inv_bf_last_y  NUMBER(24,4),
  fina_flowin_other_bf_last_y    NUMBER(24,4),
  fina_flowin_balance_bf_last_y  NUMBER(24,4),
  sum_fina_flowin_bf_last_y      NUMBER(24,4),
  repay_debt_pay_bf_last_y       NUMBER(24,4),
  divi_profitorint_pay_bf_last_y NUMBER(24,4),
  other_fina_pay_bf_last_y       NUMBER(24,4),
  fina_flowout_other_bf_last_y   NUMBER(24,4),
  fina_flowout_balance_bf_last_y NUMBER(24,4),
  sum_fina_flowout_bf_last_y     NUMBER(24,4),
  fina_flow_other_bf_last_y      NUMBER(24,4),
  fina_flow_balance_bf_last_y    NUMBER(24,4),
  net_fina_cashflow_bf_last_y    NUMBER(24,4),
  effect_exchange_rate_bf_last_y NUMBER(24,4),
  nicash_equi_other_bf_last_y    NUMBER(24,4),
  nicash_equi_balance_bf_last_y  NUMBER(24,4),
  nicash_equi_bf_last_y          NUMBER(24,4),
  cash_equi_beginning_bf_last_y  NUMBER(24,4),
  cash_equi_ending_bf_last_y     NUMBER(24,4),
  asset_devalue_bf_last_y        NUMBER(24,4),
  fixed_asset_etcdepr_bf_last_y  NUMBER(24,4),
  intang_asset_amor_bf_last_y    NUMBER(24,4),
  ltdefer_exp_amor_bf_last_y     NUMBER(24,4),
  defer_exp_reduce_bf_last_y     NUMBER(24,4),
  drawing_exp_add_bf_last_y      NUMBER(24,4),
  disp_filasset_loss_bf_last_y   NUMBER(24,4),
  fixed_asset_loss_bf_last_y     NUMBER(24,4),
  fvalue_loss_bf_last_y          NUMBER(24,4),
  inv_loss_bf_last_y             NUMBER(24,4),
  defer_taxasset_redu_bf_last_y  NUMBER(24,4),
  defer_taxliab_add_bf_last_y    NUMBER(24,4),
  inventory_reduce_bf_last_y     NUMBER(24,4),
  operate_rec_reduce_bf_last_y   NUMBER(24,4),
  operate_pay_add_bf_last_y      NUMBER(24,4),
  inoperate_flow_other_bf_last_y NUMBER(24,4),
  inoperate_flow_balan_bf_last_y NUMBER(24,4),
  innet_operate_cash_bf_last_y   NUMBER(24,4),
  debt_to_capital_bf_last_y      NUMBER(24,4),
  cb_oneyear_bf_last_y           NUMBER(24,4),
  finalease_fix_asset_bf_last_y  NUMBER(24,4),
  cash_end_bf_last_y             NUMBER(24,4),
  cash_begin_bf_last_y           NUMBER(24,4),
  equi_end_bf_last_y             NUMBER(24,4),
  equi_begin_bf_last_y           NUMBER(24,4),
  innicash_equi_other_bf_last_y  NUMBER(24,4),
  innicash_equi_balan_bf_last_y  NUMBER(24,4),
  innicash_equi_bf_last_y        NUMBER(24,4),
  other_bf_last_y                NUMBER(24,4),
  subsidiary_accept_bf_last_y    NUMBER(24,4),
  subsidiary_pay_bf_last_y       NUMBER(24,4),
  divi_pay_bf_last_y             NUMBER(24,4),
  intandcomm_rec_bf_last_y       NUMBER(24,4),
  net_rirec_bf_last_y            NUMBER(24,4),
  nilend_fund_bf_last_y          NUMBER(24,4),
  defer_tax_bf_last_y            NUMBER(24,4),
  defer_income_amor_bf_last_y    NUMBER(24,4),
  exchange_loss_bf_last_y        NUMBER(24,4),
  fixandestate_depr_bf_last_y    NUMBER(24,4),
  fixed_asset_depr_bf_last_y     NUMBER(24,4),
  tradef_asset_reduce_bf_last_y  NUMBER(24,4),
  ndloan_advances_bf_last_y      NUMBER(24,4),
  reduce_pled_depo_bf_last_y     NUMBER(24,4),
  add_pledget_deposit_bf_last_y  NUMBER(24,4),
  buy_subsidiary_pay_bf_last_y   NUMBER(24,4),
  cash_equie_other_bf_last_y     NUMBER(24,4),
  cash_equie_balan_bf_last_y     NUMBER(24,4),
  nd_depositinc_bankfi_bf_last_y NUMBER(24,4),
  niborr_sell_buyback_bf_last_y  NUMBER(24,4),
  ndlend_buy_sellback_bf_last_y  NUMBER(24,4),
  net_cd_bf_last_y               NUMBER(24,4),
  nitrade_fliab_bf_last_y        NUMBER(24,4),
  ndtrade_fasset_bf_last_y       NUMBER(24,4),
  disp_masset_rec_bf_last_y      NUMBER(24,4),
  cancel_loan_rec_bf_last_y      NUMBER(24,4),
  ndborrow_from_cbank_bf_last_y  NUMBER(24,4),
  ndfide_posit_bf_last_y         NUMBER(24,4),
  ndissue_cd_bf_last_y           NUMBER(24,4),
  nilend_sell_buyback_bf_last_y  NUMBER(24,4),
  ndborr_sell_buyback_bf_last_y  NUMBER(24,4),
  nitrade_fasset_bf_last_y       NUMBER(24,4),
  ndtrade_fliab_bf_last_y        NUMBER(24,4),
  buy_finalasset_pay_bf_last_y   NUMBER(24,4),
  niaccount_rec_bf_last_y        NUMBER(24,4),
  issue_cd_bf_last_y             NUMBER(24,4),
  addshare_capital_rec_bf_last_y NUMBER(24,4),
  issue_share_rec_bf_last_y      NUMBER(24,4),
  bond_intpay_bf_last_y          NUMBER(24,4),
  niother_finainstru_bf_last_y   NUMBER(24,4),
  uwsecurity_rec_bf_last_y       NUMBER(24,4),
  buysback_fasset_rec_bf_last_y  NUMBER(24,4),
  agent_uwsecurity_rec_bf_last_y NUMBER(24,4),
  nidirect_inv_bf_last_y         NUMBER(24,4),
  nitrade_settlement_bf_last_y   NUMBER(24,4),
  buysback_fasset_pay_bf_last_y  NUMBER(24,4),
  nddisp_trade_fasset_bf_last_y  NUMBER(24,4),
  ndother_fina_instr_bf_last_y   NUMBER(24,4),
  ndborrow_fund_bf_last_y        NUMBER(24,4),
  nddirect_inv_bf_last_y         NUMBER(24,4),
  ndtrade_settlement_bf_last_y   NUMBER(24,4),
  ndbuyback_fund_bf_last_y       NUMBER(24,4),
  agenttrade_secu_pay_bf_last_y  NUMBER(24,4),
  nddisp_sale_fasset_bf_last_y   NUMBER(24,4),
  nisell_buyback_bf_last_y       NUMBER(24,4),
  ndbuy_sellback_bf_last_y       NUMBER(24,4),
  nettrade_fasset_rec_bf_last_y  NUMBER(24,4),
  net_ripay_bf_last_y            NUMBER(24,4),
  ndlend_fund_bf_last_y          NUMBER(24,4),
  nibuy_sellback_bf_last_y       NUMBER(24,4),
  ndsell_buyback_bf_last_y       NUMBER(24,4),
  ndinsu_dep_inv_bf_last_y       NUMBER(24,4),
  nettrade_fasset_pay_bf_last_y  NUMBER(24,4),
  niinsu_pled_loan_bf_last_y     NUMBER(24,4),
  disp_subsidiary_pay_bf_last_y  NUMBER(24,4),
  netsell_bback_frec_bf_last_y   NUMBER(24,4),
  netsell_bback_fpay_bf_last_y   NUMBER(24,4),
  ebit_bf_last_y                 NUMBER(24,4),
  ebitda_bf_last_y               NUMBER(24,4),
  bank_sub_001_bf_last_y         NUMBER(24,4),
  bank_sub_002_bf_last_y         NUMBER(24,4),
  bank_sub_003_bf_last_y         NUMBER(24,4),
  bank_sub_004_bf_last_y         NUMBER(24,4),
  bank_sub_005_bf_last_y         NUMBER(24,4),
  bank_sub_006_bf_last_y         NUMBER(24,4),
  bank_sub_007_bf_last_y         NUMBER(24,4),
  bank_sub_008_bf_last_y         NUMBER(24,4),
  bank_sub_009_bf_last_y         NUMBER(24,4),
  bank_sub_010_bf_last_y         NUMBER(24,4),
  bank_sub_011_bf_last_y         NUMBER(24,4),
  bank_sub_012_bf_last_y         NUMBER(24,4),
  bank_sub_013_bf_last_y         NUMBER(24,4),
  bank_sub_014_bf_last_y         NUMBER(24,4),
  bank_sub_015_bf_last_y         NUMBER(24,4),
  bank_sub_016_bf_last_y         NUMBER(24,4),
  bank_sub_017_bf_last_y         NUMBER(24,4),
  bank_sub_018_bf_last_y         NUMBER(24,4),
  bank_sub_019_bf_last_y         NUMBER(24,4),
  bank_sub_020_bf_last_y         NUMBER(24,4),
  bank_sub_021_bf_last_y         NUMBER(24,4),
  bank_sub_022_bf_last_y         NUMBER(24,4),
  bank_sub_023_bf_last_y         NUMBER(24,4),
  bank_sub_024_bf_last_y         NUMBER(24,4),
  bank_sub_025_bf_last_y         NUMBER(24,4),
  bank_sub_026_bf_last_y         NUMBER(24,4),
  bank_sub_027_bf_last_y         NUMBER(24,4),
  bank_sub_028_bf_last_y         NUMBER(24,4),
  bank_sub_029_bf_last_y         NUMBER(24,4),
  bank_sub_030_bf_last_y         NUMBER(24,4),
  bank_sub_031_bf_last_y         NUMBER(24,4),
  bank_sub_032_bf_last_y         NUMBER(24,4),
  bank_sub_033_bf_last_y         NUMBER(24,4),
  bank_sub_034_bf_last_y         NUMBER(24,4),
  bank_sub_035_bf_last_y         NUMBER(24,4),
  bank_sub_036_bf_last_y         NUMBER(24,4),
  bank_sub_037_bf_last_y         NUMBER(24,4),
  bank_sub_038_bf_last_y         NUMBER(24,4),
  bank_sub_039_bf_last_y         NUMBER(24,4),
  bank_sub_040_bf_last_y         NUMBER(24,4),
  bank_sub_041_bf_last_y         NUMBER(24,4),
  bank_sub_042_bf_last_y         NUMBER(24,4),
  bank_sub_043_bf_last_y         NUMBER(24,4),
  bank_sub_044_bf_last_y         NUMBER(24,4),
  bank_sub_045_bf_last_y         NUMBER(24,4),
  bank_sub_046_bf_last_y         NUMBER(24,4),
  bank_sub_047_bf_last_y         NUMBER(24,4),
  bank_sub_048_bf_last_y         NUMBER(24,4),
  bank_sub_049_bf_last_y         NUMBER(24,4),
  bank_sub_050_bf_last_y         NUMBER(24,4),
  bank_sub_051_bf_last_y         NUMBER(24,4),
  bank_sub_052_bf_last_y         NUMBER(24,4),
  bank_sub_053_bf_last_y         NUMBER(24,4),
  bank_sub_054_bf_last_y         NUMBER(24,4),
  bank_sub_055_bf_last_y         NUMBER(24,4),
  bank_sub_056_bf_last_y         NUMBER(24,4),
  bank_sub_057_bf_last_y         NUMBER(24,4),
  bank_sub_058_bf_last_y         NUMBER(24,4),
  bank_sub_059_bf_last_y         NUMBER(24,4),
  bank_sub_060_bf_last_y         NUMBER(24,4),
  bank_sub_061_bf_last_y         NUMBER(24,4),
  bank_sub_062_bf_last_y         NUMBER(24,4),
  bank_sub_063_bf_last_y         NUMBER(24,4),
  bank_sub_064_bf_last_y         NUMBER(24,4),
  bank_sub_065_bf_last_y         NUMBER(24,4),
  bank_sub_066_bf_last_y         NUMBER(24,4),
  bank_sub_067_bf_last_y         NUMBER(24,4),
  bank_sub_068_bf_last_y         NUMBER(24,4),
  bank_sub_069_bf_last_y         NUMBER(24,4),
  bank_sub_070_bf_last_y         NUMBER(24,4),
  bank_sub_071_bf_last_y         NUMBER(24,4),
  bank_sub_072_bf_last_y         NUMBER(24,4),
  bank_sub_073_bf_last_y         NUMBER(24,4),
  bank_sub_074_bf_last_y         NUMBER(24,4),
  bank_sub_075_bf_last_y         NUMBER(24,4),
  bank_sub_076_bf_last_y         NUMBER(24,4),
  bank_sub_077_bf_last_y         NUMBER(24,4),
  bank_sub_078_bf_last_y         NUMBER(24,4),
  bank_sub_079_bf_last_y         NUMBER(24,4),
  bank_sub_080_bf_last_y         NUMBER(24,4),
  bank_sub_081_bf_last_y         NUMBER(24,4),
  bank_sub_082_bf_last_y         NUMBER(24,4),
  bank_sub_083_bf_last_y         NUMBER(24,4),
  bank_sub_084_bf_last_y         NUMBER(24,4),
  bank_sub_085_bf_last_y         NUMBER(24,4),
  bank_sub_086_bf_last_y         NUMBER(24,4),
  bank_sub_087_bf_last_y         NUMBER(24,4),
  bank_sub_088_bf_last_y         NUMBER(24,4),
  bank_sub_089_bf_last_y         NUMBER(24,4),
  bank_sub_090_bf_last_y         NUMBER(24,4),
  bank_sub_091_bf_last_y         NUMBER(24,4),
  bank_sub_092_bf_last_y         NUMBER(24,4),
  bank_sub_093_bf_last_y         NUMBER(24,4),
  bank_sub_094_bf_last_y         NUMBER(24,4),
  bank_sub_095_bf_last_y         NUMBER(24,4),
  bank_sub_096_bf_last_y         NUMBER(24,4),
  bank_sub_097_bf_last_y         NUMBER(24,4),
  bank_sub_098_bf_last_y         NUMBER(24,4),
  bank_sub_099_bf_last_y         NUMBER(24,4),
  bank_sub_100_bf_last_y         NUMBER(24,4),
  bank_sub_101_bf_last_y         NUMBER(24,4),
  bank_sub_102_bf_last_y         NUMBER(24,4),
  bank_sub_103_bf_last_y         NUMBER(24,4),
  bank_sub_104_bf_last_y         NUMBER(24,4),
  bank_sub_105_bf_last_y         NUMBER(24,4),
  bank_sub_106_bf_last_y         NUMBER(24,4),
  bank_sub_107_bf_last_y         NUMBER(24,4),
  bank_sub_108_bf_last_y         NUMBER(24,4),
  bank_sub_109_bf_last_y         NUMBER(24,4),
  bank_sub_110_bf_last_y         NUMBER(24,4),
  bank_sub_111_bf_last_y         NUMBER(24,4),
  bank_sub_112_bf_last_y         NUMBER(24,4),
  bank_sub_113_bf_last_y         NUMBER(24,4),
  bank_sub_114_bf_last_y         NUMBER(24,4),
  bank_sub_115_bf_last_y         NUMBER(24,4),
  bank_sub_116_bf_last_y         NUMBER(24,4),
  bank_sub_117_bf_last_y         NUMBER(24,4),
  bank_sub_118_bf_last_y         NUMBER(24,4),
  bank_sub_119_bf_last_y         NUMBER(24,4),
  bank_sub_120_bf_last_y         NUMBER(24,4),
  bank_sub_121_bf_last_y         NUMBER(24,4),
  bank_sub_122_bf_last_y         NUMBER(24,4),
  bank_sub_123_bf_last_y         NUMBER(24,4),
  bank_sub_124_bf_last_y         NUMBER(24,4),
  bank_sub_125_bf_last_y         NUMBER(24,4),
  com_expend_bf_last_y           NUMBER(24,4),
  act_capit_sx_bf_last_y         NUMBER(24,4),
  act_capit_cx_bf_last_y         NUMBER(24,4),
  inv_asset_cx_bf_last_y         NUMBER(24,4),
  udr_reserve_sx_bf_last_y       NUMBER(24,4),
  min_capit_sx_bf_last_y         NUMBER(24,4),
  udr_reserve_cx_bf_last_y       NUMBER(24,4),
  comexpend_cx_bf_last_y         NUMBER(24,4),
  earnprem_sx_bf_last_y          NUMBER(24,4),
  min_capit_bf_last_y            NUMBER(24,4),
  act_capit_bf_last_y            NUMBER(24,4),
  inv_asset_sx_bf_last_y         NUMBER(24,4),
  ostlr_cx_bf_last_y             NUMBER(24,4),
  ror_cx_bf_last_y               NUMBER(24,4),
  inv_asset_bf_last_y            NUMBER(24,4),
  ostlr_sx_bf_last_y             NUMBER(24,4),
  min_capit_cx_bf_last_y         NUMBER(24,4),
  earnprem_cx_bf_last_y          NUMBER(24,4),
  earnprem_bf_last_y             NUMBER(24,4),
  com_expend_sx_bf_last_y        NUMBER(24,4),
  com_compensate_cx_bf_last_y    NUMBER(24,4),
  solven_ratio_sx_bf_last_y      NUMBER(24,4),
  com_cost_cx_bf_last_y          NUMBER(24,4),
  earnprem_gr_cx_bf_last_y       NUMBER(24,4),
  nrorsx_bf_last_y               NUMBER(24,4),
  nror_bf_last_y                 NUMBER(24,4),
  tror_bf_last_y                 NUMBER(24,4),
  solven_ratio_cx_bf_last_y      NUMBER(24,4),
  earnprem_gr_sx_bf_last_y       NUMBER(24,4),
  solven_ratio_bf_last_y         NUMBER(24,4),
  nror_cx_bf_last_y              NUMBER(24,4),
  earnprem_gr_bf_last_y          NUMBER(24,4),
  sur_rate_bf_last_y             NUMBER(24,4),
  ror_sx_bf_last_y               NUMBER(24,4),
  secu_sub_001_bf_last_y         NUMBER(24,4),
  secu_sub_002_bf_last_y         NUMBER(24,4),
  secu_sub_003_bf_last_y         NUMBER(24,4),
  secu_sub_004_bf_last_y         NUMBER(24,4),
  secu_sub_005_bf_last_y         NUMBER(24,4),
  secu_sub_006_bf_last_y         NUMBER(24,4),
  secu_sub_007_bf_last_y         NUMBER(24,4),
  secu_sub_008_bf_last_y         NUMBER(24,4),
  secu_sub_009_bf_last_y         NUMBER(24,4),
  secu_sub_010_bf_last_y         NUMBER(24,4),
  secu_sub_011_bf_last_y         NUMBER(24,4),
  secu_sub_012_bf_last_y         NUMBER(24,4),
  secu_sub_013_bf_last_y         NUMBER(24,4),
  secu_sub_014_bf_last_y         NUMBER(24,4),
  secu_sub_015_bf_last_y         NUMBER(24,4),
  secu_sub_016_bf_last_y         NUMBER(24,4),
  secu_sub_017_bf_last_y         NUMBER(24,4),
  secu_sub_018_bf_last_y         NUMBER(24,4),
  top10_frbm_bf_last_y           NUMBER(24,4),
  spec_ment_loan_bf_last_y       NUMBER(24,4),
  sum_last3_loan_bf_last_y       NUMBER(24,4),
  trust_industry_amt_bf_last_y   NUMBER(24,4),
  owner_industry_amt_bf_last_y   NUMBER(24,4),
  operate_reve_amt_bf_last_y     NUMBER(24,4),
  owner_asset_bf_last_y          NUMBER(24,4),
  new_prod_amt_bf_last_y         NUMBER(24,4),
  trust_loan_amt_bf_last_y       NUMBER(24,4),
  trust_quity_inv_bf_last_y      NUMBER(24,4),
  comp_reserve_fund_bf_last_y    NUMBER(24,4),
  collect_trust_size_bf_last_y   NUMBER(24,4),
  client_id_bf_last_y            NUMBER(16),
  updt_by_bf_last_y              NUMBER(16),
  updt_dt_bf_last_y              TIMESTAMP(6)
)
tablespace CS_MASTER_TEST
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
alter table COMPY_FINANCE_BF_LAST_Y
  add constraint PK_COMPY_FINANCE_BF_LAST_Y primary key (COMPANY_ID_BF_LAST_Y, RPT_DT_BF_LAST_Y, RPT_TIMETYPE_CD_BF_LAST_Y)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table COMPY_FINANCE_LAST_Y
prompt ===================================
prompt
create table COMPY_FINANCE_LAST_Y
(
  company_id_last_y              NUMBER(16) not null,
  rpt_dt_last_y                  DATE not null,
  rpt_timetype_cd_last_y         INTEGER not null,
  monetary_fund_last_y           NUMBER(24,4),
  tradef_asset_last_y            NUMBER(24,4),
  bill_rec_last_y                NUMBER(24,4),
  account_rec_last_y             NUMBER(24,4),
  other_rec_last_y               NUMBER(24,4),
  advance_pay_last_y             NUMBER(24,4),
  dividend_rec_last_y            NUMBER(24,4),
  interest_rec_last_y            NUMBER(24,4),
  inventory_last_y               NUMBER(24,4),
  nonl_asset_oneyear_last_y      NUMBER(24,4),
  defer_expense_last_y           NUMBER(24,4),
  other_lasset_last_y            NUMBER(24,4),
  lasset_other_last_y            NUMBER(24,4),
  lasset_balance_last_y          NUMBER(24,4),
  sum_lasset_last_y              NUMBER(24,4),
  saleable_fasset_last_y         NUMBER(24,4),
  held_maturity_inv_last_y       NUMBER(24,4),
  estate_invest_last_y           NUMBER(24,4),
  lte_quity_inv_last_y           NUMBER(24,4),
  ltrec_last_y                   NUMBER(24,4),
  fixed_asset_last_y             NUMBER(24,4),
  construction_material_last_y   NUMBER(24,4),
  construction_progress_last_y   NUMBER(24,4),
  liquidate_fixed_asset_last_y   NUMBER(24,4),
  product_biology_asset_last_y   NUMBER(24,4),
  oilgas_asset_last_y            NUMBER(24,4),
  intangible_asset_last_y        NUMBER(24,4),
  develop_exp_last_y             NUMBER(24,4),
  good_will_last_y               NUMBER(24,4),
  ltdefer_asset_last_y           NUMBER(24,4),
  defer_incometax_asset_last_y   NUMBER(24,4),
  other_nonl_asset_last_y        NUMBER(24,4),
  nonlasset_other_last_y         NUMBER(24,4),
  nonlasset_balance_last_y       NUMBER(24,4),
  sum_nonl_asset_last_y          NUMBER(24,4),
  cash_and_depositcbank_last_y   NUMBER(24,4),
  deposit_infi_last_y            NUMBER(24,4),
  fi_deposit_last_y              NUMBER(24,4),
  precious_metal_last_y          NUMBER(24,4),
  lend_fund_last_y               NUMBER(24,4),
  derive_fasset_last_y           NUMBER(24,4),
  buy_sellback_fasset_last_y     NUMBER(24,4),
  loan_advances_last_y           NUMBER(24,4),
  agency_assets_last_y           NUMBER(24,4),
  premium_rec_last_y             NUMBER(24,4),
  subrogation_rec_last_y         NUMBER(24,4),
  ri_rec_last_y                  NUMBER(24,4),
  undue_rireserve_rec_last_y     NUMBER(24,4),
  claim_rireserve_rec_last_y     NUMBER(24,4),
  life_rireserve_rec_last_y      NUMBER(24,4),
  lthealth_rireserve_rec_last_y  NUMBER(24,4),
  gdeposit_pay_last_y            NUMBER(24,4),
  insured_pledge_loan_last_y     NUMBER(24,4),
  capitalg_deposit_pay_last_y    NUMBER(24,4),
  independent_asset_last_y       NUMBER(24,4),
  client_fund_last_y             NUMBER(24,4),
  settlement_provision_last_y    NUMBER(24,4),
  client_provision_last_y        NUMBER(24,4),
  seat_fee_last_y                NUMBER(24,4),
  other_asset_last_y             NUMBER(24,4),
  asset_other_last_y             NUMBER(24,4),
  asset_balance_last_y           NUMBER(24,4),
  sum_asset_last_y               NUMBER(24,4),
  st_borrow_last_y               NUMBER(24,4),
  trade_fliab_last_y             NUMBER(24,4),
  bill_pay_last_y                NUMBER(24,4),
  account_pay_last_y             NUMBER(24,4),
  advance_receive_last_y         NUMBER(24,4),
  salary_pay_last_y              NUMBER(24,4),
  tax_pay_last_y                 NUMBER(24,4),
  interest_pay_last_y            NUMBER(24,4),
  dividend_pay_last_y            NUMBER(24,4),
  other_pay_last_y               NUMBER(24,4),
  accrue_expense_last_y          NUMBER(24,4),
  anticipate_liab_last_y         NUMBER(24,4),
  defer_income_last_y            NUMBER(24,4),
  nonl_liab_oneyear_last_y       NUMBER(24,4),
  other_lliab_last_y             NUMBER(24,4),
  lliab_other_last_y             NUMBER(24,4),
  lliab_balance_last_y           NUMBER(24,4),
  sum_lliab_last_y               NUMBER(24,4),
  lt_borrow_last_y               NUMBER(24,4),
  bond_pay_last_y                NUMBER(24,4),
  lt_account_pay_last_y          NUMBER(24,4),
  special_pay_last_y             NUMBER(24,4),
  defer_incometax_liab_last_y    NUMBER(24,4),
  other_nonl_liab_last_y         NUMBER(24,4),
  nonl_liab_other_last_y         NUMBER(24,4),
  nonl_liab_balance_last_y       NUMBER(24,4),
  sum_nonl_liab_last_y           NUMBER(24,4),
  borrow_from_cbank_last_y       NUMBER(24,4),
  borrow_fund_last_y             NUMBER(24,4),
  derive_financedebt_last_y      NUMBER(24,4),
  sell_buyback_fasset_last_y     NUMBER(24,4),
  accept_deposit_last_y          NUMBER(24,4),
  agency_liab_last_y             NUMBER(24,4),
  other_liab_last_y              NUMBER(24,4),
  premium_advance_last_y         NUMBER(24,4),
  comm_pay_last_y                NUMBER(24,4),
  ri_pay_last_y                  NUMBER(24,4),
  gdeposit_rec_last_y            NUMBER(24,4),
  insured_deposit_inv_last_y     NUMBER(24,4),
  undue_reserve_last_y           NUMBER(24,4),
  claim_reserve_last_y           NUMBER(24,4),
  life_reserve_last_y            NUMBER(24,4),
  lt_health_reserve_last_y       NUMBER(24,4),
  independent_liab_last_y        NUMBER(24,4),
  pledge_borrow_last_y           NUMBER(24,4),
  agent_trade_security_last_y    NUMBER(24,4),
  agent_uw_security_last_y       NUMBER(24,4),
  liab_other_last_y              NUMBER(24,4),
  liab_balance_last_y            NUMBER(24,4),
  sum_liab_last_y                NUMBER(24,4),
  share_capital_last_y           NUMBER(24,4),
  capital_reserve_last_y         NUMBER(24,4),
  surplus_reserve_last_y         NUMBER(24,4),
  retained_earning_last_y        NUMBER(24,4),
  inventory_share_last_y         NUMBER(24,4),
  general_risk_prepare_last_y    NUMBER(24,4),
  diff_conversion_fc_last_y      NUMBER(24,4),
  minority_equity_last_y         NUMBER(24,4),
  sh_equity_other_last_y         NUMBER(24,4),
  sh_equity_balance_last_y       NUMBER(24,4),
  sum_parent_equity_last_y       NUMBER(24,4),
  sum_sh_equity_last_y           NUMBER(24,4),
  liabsh_equity_other_last_y     NUMBER(24,4),
  liabsh_equity_balance_last_y   NUMBER(24,4),
  sum_liabsh_equity_last_y       NUMBER(24,4),
  td_eposit_last_y               NUMBER(24,4),
  st_bond_rec_last_y             NUMBER(24,4),
  claim_pay_last_y               NUMBER(24,4),
  policy_divi_pay_last_y         NUMBER(24,4),
  unconfirm_inv_loss_last_y      NUMBER(24,4),
  ricontact_reserve_rec_last_y   NUMBER(24,4),
  deposit_last_y                 NUMBER(24,4),
  contact_reserve_last_y         NUMBER(24,4),
  invest_rec_last_y              NUMBER(24,4),
  specia_lreserve_last_y         NUMBER(24,4),
  subsidy_rec_last_y             NUMBER(24,4),
  marginout_fund_last_y          NUMBER(24,4),
  export_rebate_rec_last_y       NUMBER(24,4),
  defer_income_oneyear_last_y    NUMBER(24,4),
  lt_salary_pay_last_y           NUMBER(24,4),
  fvalue_fasset_last_y           NUMBER(24,4),
  define_fvalue_fasset_last_y    NUMBER(24,4),
  internal_rec_last_y            NUMBER(24,4),
  clheld_sale_ass_last_y         NUMBER(24,4),
  fvalue_fliab_last_y            NUMBER(24,4),
  define_fvalue_fliab_last_y     NUMBER(24,4),
  internal_pay_last_y            NUMBER(24,4),
  clheld_sale_liab_last_y        NUMBER(24,4),
  anticipate_lliab_last_y        NUMBER(24,4),
  other_equity_last_y            NUMBER(24,4),
  other_cincome_last_y           NUMBER(24,4),
  plan_cash_divi_last_y          NUMBER(24,4),
  parent_equity_other_last_y     NUMBER(24,4),
  parent_equity_balance_last_y   NUMBER(24,4),
  preferred_stock_last_y         NUMBER(24,4),
  prefer_stoc_bond_last_y        NUMBER(24,4),
  cons_biolo_asset_last_y        NUMBER(24,4),
  stock_num_end_last_y           NUMBER(24,4),
  net_mas_set_last_y             NUMBER(24,4),
  outward_remittance_last_y      NUMBER(24,4),
  cdandbill_rec_last_y           NUMBER(24,4),
  hedge_reserve_last_y           NUMBER(24,4),
  suggest_assign_divi_last_y     NUMBER(24,4),
  marginout_security_last_y      NUMBER(24,4),
  cagent_trade_security_last_y   NUMBER(24,4),
  trade_risk_prepare_last_y      NUMBER(24,4),
  creditor_planinv_last_y        NUMBER(24,4),
  short_financing_last_y         NUMBER(24,4),
  receivables_last_y             NUMBER(24,4),
  operate_reve_last_y            NUMBER(24,4),
  operate_exp_last_y             NUMBER(24,4),
  operate_tax_last_y             NUMBER(24,4),
  sale_exp_last_y                NUMBER(24,4),
  manage_exp_last_y              NUMBER(24,4),
  finance_exp_last_y             NUMBER(24,4),
  asset_devalue_loss_last_y      NUMBER(24,4),
  fvalue_income_last_y           NUMBER(24,4),
  invest_income_last_y           NUMBER(24,4),
  intn_reve_last_y               NUMBER(24,4),
  int_reve_last_y                NUMBER(24,4),
  int_exp_last_y                 NUMBER(24,4),
  commn_reve_last_y              NUMBER(24,4),
  comm_reve_last_y               NUMBER(24,4),
  comm_exp_last_y                NUMBER(24,4),
  exchange_income_last_y         NUMBER(24,4),
  premium_earned_last_y          NUMBER(24,4),
  premium_income_last_y          NUMBER(24,4),
  ripremium_last_y               NUMBER(24,4),
  premium_exp_last_y             NUMBER(24,4),
  indemnity_exp_last_y           NUMBER(24,4),
  amortise_indemnity_exp_last_y  NUMBER(24,4),
  duty_reserve_last_y            NUMBER(24,4),
  amortise_duty_reserve_last_y   NUMBER(24,4),
  rireve_last_y                  NUMBER(24,4),
  riexp_last_y                   NUMBER(24,4),
  surrender_premium_last_y       NUMBER(24,4),
  policy_divi_exp_last_y         NUMBER(24,4),
  amortise_riexp_last_y          NUMBER(24,4),
  security_uw_last_y             NUMBER(24,4),
  client_asset_manage_last_y     NUMBER(24,4),
  operate_profit_other_last_y    NUMBER(24,4),
  operate_profit_balance_last_y  NUMBER(24,4),
  operate_profit_last_y          NUMBER(24,4),
  nonoperate_reve_last_y         NUMBER(24,4),
  nonoperate_exp_last_y          NUMBER(24,4),
  nonlasset_net_loss_last_y      NUMBER(24,4),
  sum_profit_other_last_y        NUMBER(24,4),
  sum_profit_balance_last_y      NUMBER(24,4),
  sum_profit_last_y              NUMBER(24,4),
  income_tax_last_y              NUMBER(24,4),
  net_profit_other2_last_y       NUMBER(24,4),
  net_profit_balance1_last_y     NUMBER(24,4),
  net_profit_balance2_last_y     NUMBER(24,4),
  net_profit_last_y              NUMBER(24,4),
  parent_net_profit_last_y       NUMBER(24,4),
  minority_income_last_y         NUMBER(24,4),
  undistribute_profit_last_y     NUMBER(24,4),
  basic_eps_last_y               NUMBER(24,4),
  diluted_eps_last_y             NUMBER(24,4),
  invest_joint_income_last_y     NUMBER(24,4),
  total_operate_reve_last_y      NUMBER(24,4),
  total_operate_exp_last_y       NUMBER(24,4),
  other_reve_last_y              NUMBER(24,4),
  other_exp_last_y               NUMBER(24,4),
  unconfirm_invloss_last_y       NUMBER(24,4),
  sum_cincome_last_y             NUMBER(24,4),
  parent_cincome_last_y          NUMBER(24,4),
  minority_cincome_last_y        NUMBER(24,4),
  net_contact_reserve_last_y     NUMBER(24,4),
  rdexp_last_y                   NUMBER(24,4),
  operate_manage_exp_last_y      NUMBER(24,4),
  insur_reve_last_y              NUMBER(24,4),
  nonlasset_reve_last_y          NUMBER(24,4),
  total_operatereve_other_last_y NUMBER(24,4),
  net_indemnity_exp_last_y       NUMBER(24,4),
  total_operateexp_other_last_y  NUMBER(24,4),
  net_profit_other1_last_y       NUMBER(24,4),
  cincome_balance1_last_y        NUMBER(24,4),
  cincome_balance2_last_y        NUMBER(24,4),
  other_net_income_last_y        NUMBER(24,4),
  reve_other_last_y              NUMBER(24,4),
  reve_balance_last_y            NUMBER(24,4),
  operate_exp_other_last_y       NUMBER(24,4),
  operate_exp_balance_last_y     NUMBER(24,4),
  bank_intnreve_last_y           NUMBER(24,4),
  bank_intreve_last_y            NUMBER(24,4),
  ninsur_commn_reve_last_y       NUMBER(24,4),
  ninsur_comm_reve_last_y        NUMBER(24,4),
  ninsur_comm_exp_last_y         NUMBER(24,4),
  salegoods_service_rec_last_y   NUMBER(24,4),
  tax_return_rec_last_y          NUMBER(24,4),
  other_operate_rec_last_y       NUMBER(24,4),
  ni_deposit_last_y              NUMBER(24,4),
  niborrow_from_cbank_last_y     NUMBER(24,4),
  niborrow_from_fi_last_y        NUMBER(24,4),
  nidisp_trade_fasset_last_y     NUMBER(24,4),
  nidisp_saleable_fasset_last_y  NUMBER(24,4),
  niborrow_fund_last_y           NUMBER(24,4),
  nibuyback_fund_last_y          NUMBER(24,4),
  operate_flowin_other_last_y    NUMBER(24,4),
  operate_flowin_balance_last_y  NUMBER(24,4),
  sum_operate_flowin_last_y      NUMBER(24,4),
  buygoods_service_pay_last_y    NUMBER(24,4),
  employee_pay_last_y            NUMBER(24,4),
  other_operat_epay_last_y       NUMBER(24,4),
  niloan_advances_last_y         NUMBER(24,4),
  nideposit_incbankfi_last_y     NUMBER(24,4),
  indemnity_pay_last_y           NUMBER(24,4),
  intandcomm_pay_last_y          NUMBER(24,4),
  operate_flowout_other_last_y   NUMBER(24,4),
  operate_flowout_balance_last_y NUMBER(24,4),
  sum_operate_flowout_last_y     NUMBER(24,4),
  operate_flow_other_last_y      NUMBER(24,4),
  operate_flow_balance_last_y    NUMBER(24,4),
  net_operate_cashflow_last_y    NUMBER(24,4),
  disposal_inv_rec_last_y        NUMBER(24,4),
  inv_income_rec_last_y          NUMBER(24,4),
  disp_filasset_rec_last_y       NUMBER(24,4),
  disp_subsidiary_rec_last_y     NUMBER(24,4),
  other_invrec_last_y            NUMBER(24,4),
  inv_flowin_other_last_y        NUMBER(24,4),
  inv_flowin_balance_last_y      NUMBER(24,4),
  sum_inv_flowin_last_y          NUMBER(24,4),
  buy_filasset_pay_last_y        NUMBER(24,4),
  inv_pay_last_y                 NUMBER(24,4),
  get_subsidiary_pay_last_y      NUMBER(24,4),
  other_inv_pay_last_y           NUMBER(24,4),
  nipledge_loan_last_y           NUMBER(24,4),
  inv_flowout_other_last_y       NUMBER(24,4),
  inv_flowout_balance_last_y     NUMBER(24,4),
  sum_inv_flowout_last_y         NUMBER(24,4),
  inv_flow_other_last_y          NUMBER(24,4),
  inv_cashflow_balance_last_y    NUMBER(24,4),
  net_inv_cashflow_last_y        NUMBER(24,4),
  accept_inv_rec_last_y          NUMBER(24,4),
  loan_rec_last_y                NUMBER(24,4),
  other_fina_rec_last_y          NUMBER(24,4),
  issue_bond_rec_last_y          NUMBER(24,4),
  niinsured_deposit_inv_last_y   NUMBER(24,4),
  fina_flowin_other_last_y       NUMBER(24,4),
  fina_flowin_balance_last_y     NUMBER(24,4),
  sum_fina_flowin_last_y         NUMBER(24,4),
  repay_debt_pay_last_y          NUMBER(24,4),
  divi_profitorint_pay_last_y    NUMBER(24,4),
  other_fina_pay_last_y          NUMBER(24,4),
  fina_flowout_other_last_y      NUMBER(24,4),
  fina_flowout_balance_last_y    NUMBER(24,4),
  sum_fina_flowout_last_y        NUMBER(24,4),
  fina_flow_other_last_y         NUMBER(24,4),
  fina_flow_balance_last_y       NUMBER(24,4),
  net_fina_cashflow_last_y       NUMBER(24,4),
  effect_exchange_rate_last_y    NUMBER(24,4),
  nicash_equi_other_last_y       NUMBER(24,4),
  nicash_equi_balance_last_y     NUMBER(24,4),
  nicash_equi_last_y             NUMBER(24,4),
  cash_equi_beginning_last_y     NUMBER(24,4),
  cash_equi_ending_last_y        NUMBER(24,4),
  asset_devalue_last_y           NUMBER(24,4),
  fixed_asset_etcdepr_last_y     NUMBER(24,4),
  intangible_asset_amor_last_y   NUMBER(24,4),
  ltdefer_exp_amor_last_y        NUMBER(24,4),
  defer_exp_reduce_last_y        NUMBER(24,4),
  drawing_exp_add_last_y         NUMBER(24,4),
  disp_filasset_loss_last_y      NUMBER(24,4),
  fixed_asset_loss_last_y        NUMBER(24,4),
  fvalue_loss_last_y             NUMBER(24,4),
  inv_loss_last_y                NUMBER(24,4),
  defer_taxasset_reduce_last_y   NUMBER(24,4),
  defer_taxliab_add_last_y       NUMBER(24,4),
  inventory_reduce_last_y        NUMBER(24,4),
  operate_rec_reduce_last_y      NUMBER(24,4),
  operate_pay_add_last_y         NUMBER(24,4),
  inoperate_flow_other_last_y    NUMBER(24,4),
  inoperate_flow_balance_last_y  NUMBER(24,4),
  innet_operate_cashflow_last_y  NUMBER(24,4),
  debt_to_capital_last_y         NUMBER(24,4),
  cb_oneyear_last_y              NUMBER(24,4),
  finalease_fixed_asset_last_y   NUMBER(24,4),
  cash_end_last_y                NUMBER(24,4),
  cash_begin_last_y              NUMBER(24,4),
  equi_end_last_y                NUMBER(24,4),
  equi_begin_last_y              NUMBER(24,4),
  innicash_equi_other_last_y     NUMBER(24,4),
  innicash_equi_balance_last_y   NUMBER(24,4),
  innicash_equi_last_y           NUMBER(24,4),
  other_last_y                   NUMBER(24,4),
  subsidiary_accept_last_y       NUMBER(24,4),
  subsidiary_pay_last_y          NUMBER(24,4),
  divi_pay_last_y                NUMBER(24,4),
  intandcomm_rec_last_y          NUMBER(24,4),
  net_rirec_last_y               NUMBER(24,4),
  nilend_fund_last_y             NUMBER(24,4),
  defer_tax_last_y               NUMBER(24,4),
  defer_income_amor_last_y       NUMBER(24,4),
  exchange_loss_last_y           NUMBER(24,4),
  fixandestate_depr_last_y       NUMBER(24,4),
  fixed_asset_depr_last_y        NUMBER(24,4),
  tradef_asset_reduce_last_y     NUMBER(24,4),
  ndloan_advances_last_y         NUMBER(24,4),
  reduce_pledget_deposit_last_y  NUMBER(24,4),
  add_pledget_deposit_last_y     NUMBER(24,4),
  buy_subsidiary_pay_last_y      NUMBER(24,4),
  cash_equiending_other_last_y   NUMBER(24,4),
  cash_equiending_balance_last_y NUMBER(24,4),
  nd_depositinc_bankfi_last_y    NUMBER(24,4),
  niborrow_sell_buyback_last_y   NUMBER(24,4),
  ndlend_buy_sellback_last_y     NUMBER(24,4),
  net_cd_last_y                  NUMBER(24,4),
  nitrade_fliab_last_y           NUMBER(24,4),
  ndtrade_fasset_last_y          NUMBER(24,4),
  disp_masset_rec_last_y         NUMBER(24,4),
  cancel_loan_rec_last_y         NUMBER(24,4),
  ndborrow_from_cbank_last_y     NUMBER(24,4),
  ndfide_posit_last_y            NUMBER(24,4),
  ndissue_cd_last_y              NUMBER(24,4),
  nilend_sell_buyback_last_y     NUMBER(24,4),
  ndborrow_sell_buyback_last_y   NUMBER(24,4),
  nitrade_fasset_last_y          NUMBER(24,4),
  ndtrade_fliab_last_y           NUMBER(24,4),
  buy_finaleaseasset_pay_last_y  NUMBER(24,4),
  niaccount_rec_last_y           NUMBER(24,4),
  issue_cd_last_y                NUMBER(24,4),
  addshare_capital_rec_last_y    NUMBER(24,4),
  issue_share_rec_last_y         NUMBER(24,4),
  bond_intpay_last_y             NUMBER(24,4),
  niother_finainstru_last_y      NUMBER(24,4),
  uwsecurity_rec_last_y          NUMBER(24,4),
  buysellback_fasset_rec_last_y  NUMBER(24,4),
  agent_uwsecurity_rec_last_y    NUMBER(24,4),
  nidirect_inv_last_y            NUMBER(24,4),
  nitrade_settlement_last_y      NUMBER(24,4),
  buysellback_fasset_pay_last_y  NUMBER(24,4),
  nddisp_trade_fasset_last_y     NUMBER(24,4),
  ndother_fina_instr_last_y      NUMBER(24,4),
  ndborrow_fund_last_y           NUMBER(24,4),
  nddirect_inv_last_y            NUMBER(24,4),
  ndtrade_settlement_last_y      NUMBER(24,4),
  ndbuyback_fund_last_y          NUMBER(24,4),
  agenttrade_security_pay_last_y NUMBER(24,4),
  nddisp_saleable_fasset_last_y  NUMBER(24,4),
  nisell_buyback_last_y          NUMBER(24,4),
  ndbuy_sellback_last_y          NUMBER(24,4),
  nettrade_fasset_rec_last_y     NUMBER(24,4),
  net_ripay_last_y               NUMBER(24,4),
  ndlend_fund_last_y             NUMBER(24,4),
  nibuy_sellback_last_y          NUMBER(24,4),
  ndsell_buyback_last_y          NUMBER(24,4),
  ndinsured_deposit_inv_last_y   NUMBER(24,4),
  nettrade_fasset_pay_last_y     NUMBER(24,4),
  niinsured_pledge_loan_last_y   NUMBER(24,4),
  disp_subsidiary_pay_last_y     NUMBER(24,4),
  netsell_bback_frec_last_y      NUMBER(24,4),
  netsell_bback_fpay_last_y      NUMBER(24,4),
  ebit_last_y                    NUMBER(24,4),
  ebitda_last_y                  NUMBER(24,4),
  bank_sub_001_last_y            NUMBER(24,4),
  bank_sub_002_last_y            NUMBER(24,4),
  bank_sub_003_last_y            NUMBER(24,4),
  bank_sub_004_last_y            NUMBER(24,4),
  bank_sub_005_last_y            NUMBER(24,4),
  bank_sub_006_last_y            NUMBER(24,4),
  bank_sub_007_last_y            NUMBER(24,4),
  bank_sub_008_last_y            NUMBER(24,4),
  bank_sub_009_last_y            NUMBER(24,4),
  bank_sub_010_last_y            NUMBER(24,4),
  bank_sub_011_last_y            NUMBER(24,4),
  bank_sub_012_last_y            NUMBER(24,4),
  bank_sub_013_last_y            NUMBER(24,4),
  bank_sub_014_last_y            NUMBER(24,4),
  bank_sub_015_last_y            NUMBER(24,4),
  bank_sub_016_last_y            NUMBER(24,4),
  bank_sub_017_last_y            NUMBER(24,4),
  bank_sub_018_last_y            NUMBER(24,4),
  bank_sub_019_last_y            NUMBER(24,4),
  bank_sub_020_last_y            NUMBER(24,4),
  bank_sub_021_last_y            NUMBER(24,4),
  bank_sub_022_last_y            NUMBER(24,4),
  bank_sub_023_last_y            NUMBER(24,4),
  bank_sub_024_last_y            NUMBER(24,4),
  bank_sub_025_last_y            NUMBER(24,4),
  bank_sub_026_last_y            NUMBER(24,4),
  bank_sub_027_last_y            NUMBER(24,4),
  bank_sub_028_last_y            NUMBER(24,4),
  bank_sub_029_last_y            NUMBER(24,4),
  bank_sub_030_last_y            NUMBER(24,4),
  bank_sub_031_last_y            NUMBER(24,4),
  bank_sub_032_last_y            NUMBER(24,4),
  bank_sub_033_last_y            NUMBER(24,4),
  bank_sub_034_last_y            NUMBER(24,4),
  bank_sub_035_last_y            NUMBER(24,4),
  bank_sub_036_last_y            NUMBER(24,4),
  bank_sub_037_last_y            NUMBER(24,4),
  bank_sub_038_last_y            NUMBER(24,4),
  bank_sub_039_last_y            NUMBER(24,4),
  bank_sub_040_last_y            NUMBER(24,4),
  bank_sub_041_last_y            NUMBER(24,4),
  bank_sub_042_last_y            NUMBER(24,4),
  bank_sub_043_last_y            NUMBER(24,4),
  bank_sub_044_last_y            NUMBER(24,4),
  bank_sub_045_last_y            NUMBER(24,4),
  bank_sub_046_last_y            NUMBER(24,4),
  bank_sub_047_last_y            NUMBER(24,4),
  bank_sub_048_last_y            NUMBER(24,4),
  bank_sub_049_last_y            NUMBER(24,4),
  bank_sub_050_last_y            NUMBER(24,4),
  bank_sub_051_last_y            NUMBER(24,4),
  bank_sub_052_last_y            NUMBER(24,4),
  bank_sub_053_last_y            NUMBER(24,4),
  bank_sub_054_last_y            NUMBER(24,4),
  bank_sub_055_last_y            NUMBER(24,4),
  bank_sub_056_last_y            NUMBER(24,4),
  bank_sub_057_last_y            NUMBER(24,4),
  bank_sub_058_last_y            NUMBER(24,4),
  bank_sub_059_last_y            NUMBER(24,4),
  bank_sub_060_last_y            NUMBER(24,4),
  bank_sub_061_last_y            NUMBER(24,4),
  bank_sub_062_last_y            NUMBER(24,4),
  bank_sub_063_last_y            NUMBER(24,4),
  bank_sub_064_last_y            NUMBER(24,4),
  bank_sub_065_last_y            NUMBER(24,4),
  bank_sub_066_last_y            NUMBER(24,4),
  bank_sub_067_last_y            NUMBER(24,4),
  bank_sub_068_last_y            NUMBER(24,4),
  bank_sub_069_last_y            NUMBER(24,4),
  bank_sub_070_last_y            NUMBER(24,4),
  bank_sub_071_last_y            NUMBER(24,4),
  bank_sub_072_last_y            NUMBER(24,4),
  bank_sub_073_last_y            NUMBER(24,4),
  bank_sub_074_last_y            NUMBER(24,4),
  bank_sub_075_last_y            NUMBER(24,4),
  bank_sub_076_last_y            NUMBER(24,4),
  bank_sub_077_last_y            NUMBER(24,4),
  bank_sub_078_last_y            NUMBER(24,4),
  bank_sub_079_last_y            NUMBER(24,4),
  bank_sub_080_last_y            NUMBER(24,4),
  bank_sub_081_last_y            NUMBER(24,4),
  bank_sub_082_last_y            NUMBER(24,4),
  bank_sub_083_last_y            NUMBER(24,4),
  bank_sub_084_last_y            NUMBER(24,4),
  bank_sub_085_last_y            NUMBER(24,4),
  bank_sub_086_last_y            NUMBER(24,4),
  bank_sub_087_last_y            NUMBER(24,4),
  bank_sub_088_last_y            NUMBER(24,4),
  bank_sub_089_last_y            NUMBER(24,4),
  bank_sub_090_last_y            NUMBER(24,4),
  bank_sub_091_last_y            NUMBER(24,4),
  bank_sub_092_last_y            NUMBER(24,4),
  bank_sub_093_last_y            NUMBER(24,4),
  bank_sub_094_last_y            NUMBER(24,4),
  bank_sub_095_last_y            NUMBER(24,4),
  bank_sub_096_last_y            NUMBER(24,4),
  bank_sub_097_last_y            NUMBER(24,4),
  bank_sub_098_last_y            NUMBER(24,4),
  bank_sub_099_last_y            NUMBER(24,4),
  bank_sub_100_last_y            NUMBER(24,4),
  bank_sub_101_last_y            NUMBER(24,4),
  bank_sub_102_last_y            NUMBER(24,4),
  bank_sub_103_last_y            NUMBER(24,4),
  bank_sub_104_last_y            NUMBER(24,4),
  bank_sub_105_last_y            NUMBER(24,4),
  bank_sub_106_last_y            NUMBER(24,4),
  bank_sub_107_last_y            NUMBER(24,4),
  bank_sub_108_last_y            NUMBER(24,4),
  bank_sub_109_last_y            NUMBER(24,4),
  bank_sub_110_last_y            NUMBER(24,4),
  bank_sub_111_last_y            NUMBER(24,4),
  bank_sub_112_last_y            NUMBER(24,4),
  bank_sub_113_last_y            NUMBER(24,4),
  bank_sub_114_last_y            NUMBER(24,4),
  bank_sub_115_last_y            NUMBER(24,4),
  bank_sub_116_last_y            NUMBER(24,4),
  bank_sub_117_last_y            NUMBER(24,4),
  bank_sub_118_last_y            NUMBER(24,4),
  bank_sub_119_last_y            NUMBER(24,4),
  bank_sub_120_last_y            NUMBER(24,4),
  bank_sub_121_last_y            NUMBER(24,4),
  bank_sub_122_last_y            NUMBER(24,4),
  bank_sub_123_last_y            NUMBER(24,4),
  bank_sub_124_last_y            NUMBER(24,4),
  bank_sub_125_last_y            NUMBER(24,4),
  com_expend_last_y              NUMBER(24,4),
  act_capit_sx_last_y            NUMBER(24,4),
  act_capit_cx_last_y            NUMBER(24,4),
  inv_asset_cx_last_y            NUMBER(24,4),
  udr_reserve_sx_last_y          NUMBER(24,4),
  min_capit_sx_last_y            NUMBER(24,4),
  udr_reserve_cx_last_y          NUMBER(24,4),
  comexpend_cx_last_y            NUMBER(24,4),
  earnprem_sx_last_y             NUMBER(24,4),
  min_capit_last_y               NUMBER(24,4),
  act_capit_last_y               NUMBER(24,4),
  inv_asset_sx_last_y            NUMBER(24,4),
  ostlr_cx_last_y                NUMBER(24,4),
  ror_cx_last_y                  NUMBER(24,4),
  inv_asset_last_y               NUMBER(24,4),
  ostlr_sx_last_y                NUMBER(24,4),
  min_capit_cx_last_y            NUMBER(24,4),
  earnprem_cx_last_y             NUMBER(24,4),
  earnprem_last_y                NUMBER(24,4),
  com_expend_sx_last_y           NUMBER(24,4),
  com_compensate_cx_last_y       NUMBER(24,4),
  solven_ratio_sx_last_y         NUMBER(24,4),
  com_cost_cx_last_y             NUMBER(24,4),
  earnprem_gr_cx_last_y          NUMBER(24,4),
  nrorsx_last_y                  NUMBER(24,4),
  nror_last_y                    NUMBER(24,4),
  tror_last_y                    NUMBER(24,4),
  solven_ratio_cx_last_y         NUMBER(24,4),
  earnprem_gr_sx_last_y          NUMBER(24,4),
  solven_ratio_last_y            NUMBER(24,4),
  nror_cx_last_y                 NUMBER(24,4),
  earnprem_gr_last_y             NUMBER(24,4),
  sur_rate_last_y                NUMBER(24,4),
  ror_sx_last_y                  NUMBER(24,4),
  secu_sub_001_last_y            NUMBER(24,4),
  secu_sub_002_last_y            NUMBER(24,4),
  secu_sub_003_last_y            NUMBER(24,4),
  secu_sub_004_last_y            NUMBER(24,4),
  secu_sub_005_last_y            NUMBER(24,4),
  secu_sub_006_last_y            NUMBER(24,4),
  secu_sub_007_last_y            NUMBER(24,4),
  secu_sub_008_last_y            NUMBER(24,4),
  secu_sub_009_last_y            NUMBER(24,4),
  secu_sub_010_last_y            NUMBER(24,4),
  secu_sub_011_last_y            NUMBER(24,4),
  secu_sub_012_last_y            NUMBER(24,4),
  secu_sub_013_last_y            NUMBER(24,4),
  secu_sub_014_last_y            NUMBER(24,4),
  secu_sub_015_last_y            NUMBER(24,4),
  secu_sub_016_last_y            NUMBER(24,4),
  secu_sub_017_last_y            NUMBER(24,4),
  secu_sub_018_last_y            NUMBER(24,4),
  top10_frbm_last_y              NUMBER(24,4),
  spec_ment_loan_last_y          NUMBER(24,4),
  sum_last3_loan_last_y          NUMBER(24,4),
  trust_industry_amt_last_y      NUMBER(24,4),
  owner_industry_amt_last_y      NUMBER(24,4),
  operate_reve_amt_last_y        NUMBER(24,4),
  owner_asset_last_y             NUMBER(24,4),
  new_prod_amt_last_y            NUMBER(24,4),
  trust_loan_amt_last_y          NUMBER(24,4),
  trust_quity_inv_last_y         NUMBER(24,4),
  comp_reserve_fund_last_y       NUMBER(24,4),
  collect_trust_size_last_y      NUMBER(24,4),
  client_id_last_y               NUMBER(16),
  updt_by_last_y                 NUMBER(16),
  updt_dt_last_y                 TIMESTAMP(6)
)
tablespace CS_MASTER_TEST
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
alter table COMPY_FINANCE_LAST_Y
  add constraint PK_COMPY_FINANCE_LAST_Y primary key (COMPANY_ID_LAST_Y, RPT_DT_LAST_Y, RPT_TIMETYPE_CD_LAST_Y)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table COMPY_FROZENSHARE
prompt ================================
prompt
create table COMPY_FROZENSHARE
(
  compy_frozenshare_sid NUMBER(16) not null,
  company_id            NUMBER(16) not null,
  notice_dt             DATE not null,
  sharehd_id            NUMBER(16),
  sharehd_nm            VARCHAR2(300),
  sharehd_num           NUMBER(20,4),
  frozen_num            NUMBER(20,4),
  frozen_ratio          NUMBER(20,4),
  frozen_total_ratio    NUMBER(20,4),
  frozen_dt             DATE,
  unfrozen_dt           DATE,
  frozen_deadline       VARCHAR2(600),
  frozen_reason         VARCHAR2(600),
  pre_unfrozen_dt       DATE,
  remark                VARCHAR2(2000),
  update_dt             DATE,
  frozen_inst           VARCHAR2(300),
  frozen_type           VARCHAR2(80),
  frozen_share_typeid   NUMBER(16),
  transfer_dt           DATE,
  conter_purch_amt      NUMBER(20,4),
  conter_purch_ratio    NUMBER(20,4),
  acc_pledge_amt        NUMBER(20,4),
  acc_pledge_ratio      NUMBER(20,4),
  achg_share            NUMBER(20,4),
  achg_ratio            NUMBER(20,4),
  frozen_inst_id        NUMBER(16),
  pledge_purpose_cd     INTEGER,
  inv_amt               NUMBER(20,4),
  isdel                 INTEGER not null,
  src_company_cd        VARCHAR2(60),
  srcid                 VARCHAR2(100) not null,
  src_cd                VARCHAR2(10) not null,
  updt_dt               TIMESTAMP(6) not null
)
tablespace CS_MASTER_TEST
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
alter table COMPY_FROZENSHARE
  add constraint COMPY_FROZENSHARE_PKEY primary key (COMPY_FROZENSHARE_SID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table COMPY_GROUPGRAPH_CMB
prompt ===================================
prompt
create table COMPY_GROUPGRAPH_CMB
(
  compy_groupgraph_sid NUMBER(16) not null,
  father_cust_no       VARCHAR2(30) not null,
  child_cust_no        VARCHAR2(30) not null,
  relation_type_cd     VARCHAR2(30) not null,
  direct_shratio       NUMBER(24,4),
  remark               VARCHAR2(500),
  isdel                INTEGER not null,
  src_company_cd       VARCHAR2(60),
  src_cd               VARCHAR2(10) not null,
  updt_by              NUMBER(16) not null,
  updt_dt              TIMESTAMP(6) not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
alter table COMPY_GROUPGRAPH_CMB
  add constraint PK_COMPY_GROUPGRAPH_CMB primary key (FATHER_CUST_NO, CHILD_CUST_NO, RELATION_TYPE_CD)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table COMPY_GROUPWARNING_CMB
prompt =====================================
prompt
create table COMPY_GROUPWARNING_CMB
(
  compy_groupwarning_sid NUMBER(16) not null,
  company_id             NUMBER(16) not null,
  group_id               NUMBER(16),
  group_nm               VARCHAR2(300),
  is_private_group       INTEGER,
  risk_status_cd         VARCHAR2(30),
  confirm_reason         VARCHAR2(1000),
  ctrl_measures          VARCHAR2(1000),
  affirm_dt              TIMESTAMP(6),
  affirm_orgid           INTEGER,
  affirm_orgnm           VARCHAR2(300),
  isdel                  INTEGER not null,
  src_company_cd         VARCHAR2(60),
  src_cd                 VARCHAR2(10) not null,
  updt_by                NUMBER(16) not null,
  updt_dt                TIMESTAMP(6) not null
)
tablespace USERS
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
comment on table COMPY_GROUPWARNING_CMB
  is 'TGT-所属集团预警';
comment on column COMPY_GROUPWARNING_CMB.compy_groupwarning_sid
  is '所属集团预警流水号';
comment on column COMPY_GROUPWARNING_CMB.company_id
  is '企业标识符';
comment on column COMPY_GROUPWARNING_CMB.group_id
  is '所属集团核心客户号';
comment on column COMPY_GROUPWARNING_CMB.group_nm
  is '所属集团名称';
comment on column COMPY_GROUPWARNING_CMB.is_private_group
  is '是否民营企业';
comment on column COMPY_GROUPWARNING_CMB.risk_status_cd
  is '集团客户风险分层';
comment on column COMPY_GROUPWARNING_CMB.confirm_reason
  is '认定原因';
comment on column COMPY_GROUPWARNING_CMB.ctrl_measures
  is '管控措施';
comment on column COMPY_GROUPWARNING_CMB.affirm_dt
  is '认定时间';
comment on column COMPY_GROUPWARNING_CMB.affirm_orgid
  is '认定机构';
comment on column COMPY_GROUPWARNING_CMB.affirm_orgnm
  is '认定机构名称';
comment on column COMPY_GROUPWARNING_CMB.isdel
  is '是否删除';
comment on column COMPY_GROUPWARNING_CMB.src_company_cd
  is '源企业代码';
comment on column COMPY_GROUPWARNING_CMB.src_cd
  is '源系统';
comment on column COMPY_GROUPWARNING_CMB.updt_by
  is '更新人';
comment on column COMPY_GROUPWARNING_CMB.updt_dt
  is '更新时间';
alter table COMPY_GROUPWARNING_CMB
  add constraint PK_COMPY_GROUPWARNING_CMB primary key (COMPY_GROUPWARNING_SID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 80K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table COMPY_HIGHRISKLIST_CMB
prompt =====================================
prompt
create table COMPY_HIGHRISKLIST_CMB
(
  hishgrisklist_id  INTEGER not null,
  company_id        NUMBER(16) not null,
  list_type_cd      INTEGER,
  blacklist_srccd   INTEGER,
  blacklist_type_cd INTEGER,
  eff_dt            DATE,
  confirm_reason    VARCHAR2(1000),
  ctl_measure       VARCHAR2(2000),
  eff_flag          INTEGER,
  isdel             INTEGER not null,
  src_company_cd    VARCHAR2(60),
  src_cd            VARCHAR2(10) not null,
  updt_by           NUMBER(16) not null,
  updt_dt           TIMESTAMP(6) not null
)
tablespace USERS
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
comment on table COMPY_HIGHRISKLIST_CMB
  is 'TGT-高风险类名单';
comment on column COMPY_HIGHRISKLIST_CMB.hishgrisklist_id
  is '流水号';
comment on column COMPY_HIGHRISKLIST_CMB.company_id
  is '企业标识符';
comment on column COMPY_HIGHRISKLIST_CMB.list_type_cd
  is '名单类型';
comment on column COMPY_HIGHRISKLIST_CMB.blacklist_srccd
  is '黑名单来源';
comment on column COMPY_HIGHRISKLIST_CMB.blacklist_type_cd
  is '黑名单客户类型';
comment on column COMPY_HIGHRISKLIST_CMB.eff_dt
  is '生效日期';
comment on column COMPY_HIGHRISKLIST_CMB.confirm_reason
  is '认定原因';
comment on column COMPY_HIGHRISKLIST_CMB.ctl_measure
  is '管控措施';
comment on column COMPY_HIGHRISKLIST_CMB.eff_flag
  is '是否生效';
comment on column COMPY_HIGHRISKLIST_CMB.isdel
  is '是否删除';
comment on column COMPY_HIGHRISKLIST_CMB.src_company_cd
  is '源企业代码';
comment on column COMPY_HIGHRISKLIST_CMB.src_cd
  is '源系统';
comment on column COMPY_HIGHRISKLIST_CMB.updt_by
  is '更新人';
comment on column COMPY_HIGHRISKLIST_CMB.updt_dt
  is '更新时间';
create unique index U_COMPY_HIGHRISKLIST_CMB_IDX on COMPY_HIGHRISKLIST_CMB (COMPANY_ID, BLACKLIST_SRCCD, EFF_FLAG)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table COMPY_HIGHRISKLIST_CMB
  add constraint PK_COMPY_HIGHRISKLIST_CMB primary key (HISHGRISKLIST_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 80K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table COMPY_HIGHRISKLIST_CMB
  add constraint U_COMPY_HIGHRISKLIST_CMB_COT unique (COMPANY_ID, BLACKLIST_SRCCD, EFF_FLAG);

prompt
prompt Creating table COMPY_INCOMESTATE
prompt ================================
prompt
create table COMPY_INCOMESTATE
(
  compy_incomestate_sid   NUMBER(16) not null,
  first_notice_dt         DATE,
  latest_notice_dt        DATE,
  company_id              NUMBER(16) not null,
  rpt_dt                  INTEGER not null,
  start_dt                INTEGER,
  end_dt                  INTEGER,
  rpt_timetype_cd         INTEGER,
  combine_type_cd         INTEGER not null,
  rpt_srctype_id          NUMBER(16),
  data_ajust_type         INTEGER,
  data_type               INTEGER,
  is_public_rpt           INTEGER,
  company_type            INTEGER not null,
  currency                VARCHAR2(6),
  operate_reve            NUMBER(24,4),
  operate_exp             NUMBER(24,4),
  operate_tax             NUMBER(24,4),
  sale_exp                NUMBER(24,4),
  manage_exp              NUMBER(24,4),
  finance_exp             NUMBER(24,4),
  asset_devalue_loss      NUMBER(24,4),
  fvalue_income           NUMBER(24,4),
  invest_income           NUMBER(24,4),
  intn_reve               NUMBER(24,4),
  int_reve                NUMBER(24,4),
  int_exp                 NUMBER(24,4),
  commn_reve              NUMBER(24,4),
  comm_reve               NUMBER(24,4),
  comm_exp                NUMBER(24,4),
  exchange_income         NUMBER(24,4),
  premium_earned          NUMBER(24,4),
  premium_income          NUMBER(24,4),
  ripremium               NUMBER(24,4),
  undue_reserve           NUMBER(24,4),
  premium_exp             NUMBER(24,4),
  indemnity_exp           NUMBER(24,4),
  amortise_indemnity_exp  NUMBER(24,4),
  duty_reserve            NUMBER(24,4),
  amortise_duty_reserve   NUMBER(24,4),
  rireve                  NUMBER(24,4),
  riexp                   NUMBER(24,4),
  surrender_premium       NUMBER(24,4),
  policy_divi_exp         NUMBER(24,4),
  amortise_riexp          NUMBER(24,4),
  agent_trade_security    NUMBER(24,4),
  security_uw             NUMBER(24,4),
  client_asset_manage     NUMBER(24,4),
  operate_profit_other    NUMBER(24,4),
  operate_profit_balance  NUMBER(24,4),
  operate_profit          NUMBER(24,4),
  nonoperate_reve         NUMBER(24,4),
  nonoperate_exp          NUMBER(24,4),
  nonlasset_net_loss      NUMBER(24,4),
  sum_profit_other        NUMBER(24,4),
  sum_profit_balance      NUMBER(24,4),
  sum_profit              NUMBER(24,4),
  income_tax              NUMBER(24,4),
  net_profit_other2       NUMBER(24,4),
  net_profit_balance1     NUMBER(24,4),
  net_profit_balance2     NUMBER(24,4),
  net_profit              NUMBER(24,4),
  parent_net_profit       NUMBER(24,4),
  minority_income         NUMBER(24,4),
  undistribute_profit     NUMBER(24,4),
  basic_eps               NUMBER(24,4),
  diluted_eps             NUMBER(24,4),
  invest_joint_income     NUMBER(24,4),
  total_operate_reve      NUMBER(24,4),
  total_operate_exp       NUMBER(24,4),
  other_reve              NUMBER(24,4),
  other_exp               NUMBER(24,4),
  unconfirm_invloss       NUMBER(24,4),
  other_cincome           NUMBER(24,4),
  sum_cincome             NUMBER(24,4),
  parent_cincome          NUMBER(24,4),
  minority_cincome        NUMBER(24,4),
  net_contact_reserve     NUMBER(24,4),
  rdexp                   NUMBER(24,4),
  operate_manage_exp      NUMBER(24,4),
  insur_reve              NUMBER(24,4),
  nonlasset_reve          NUMBER(24,4),
  total_operatereve_other NUMBER(24,4),
  net_indemnity_exp       NUMBER(24,4),
  total_operateexp_other  NUMBER(24,4),
  net_profit_other1       NUMBER(24,4),
  cincome_balance1        NUMBER(24,4),
  cincome_balance2        NUMBER(24,4),
  other_net_income        NUMBER(24,4),
  reve_other              NUMBER(24,4),
  reve_balance            NUMBER(24,4),
  operate_exp_other       NUMBER(24,4),
  operate_exp_balance     NUMBER(24,4),
  bank_intnreve           NUMBER(24,4),
  bank_intreve            NUMBER(24,4),
  ninsur_commn_reve       NUMBER(24,4),
  ninsur_comm_reve        NUMBER(24,4),
  ninsur_comm_exp         NUMBER(24,4),
  remark                  VARCHAR2(1000),
  chk_status              VARCHAR2(200),
  isdel                   INTEGER not null,
  src_company_cd          VARCHAR2(60),
  srcid                   VARCHAR2(100),
  src_cd                  VARCHAR2(10) not null,
  updt_by                 NUMBER(16) not null,
  updt_dt                 TIMESTAMP(6) not null
)
tablespace CS_MASTER_TEST
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
alter table COMPY_INCOMESTATE
  add constraint PK_COMPY_INCOMESTATE primary key (COMPY_INCOMESTATE_SID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table COMPY_INDUSTRY
prompt =============================
prompt
create table COMPY_INDUSTRY
(
  compy_industry_sid NUMBER(16) not null,
  company_id         NUMBER(16) not null,
  industry_sid       NUMBER(16) not null,
  start_dt           DATE,
  end_dt             DATE,
  is_new             INTEGER,
  isdel              INTEGER not null,
  src_company_cd     VARCHAR2(60),
  srcid              VARCHAR2(100) not null,
  src_cd             VARCHAR2(10) not null,
  client_id          NUMBER(16) not null,
  updt_by            NUMBER(16) not null,
  updt_dt            TIMESTAMP(6) not null
)
tablespace CS_MASTER_TEST
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
alter table COMPY_INDUSTRY
  add constraint PK_COMPY_INDUSTRY primary key (COMPY_INDUSTRY_SID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table COMPY_INSURERINDEX
prompt =================================
prompt
create table COMPY_INSURERINDEX
(
  compy_insurerindex_sid NUMBER(16) not null,
  notice_dt              DATE,
  company_id             NUMBER(16) not null,
  rpt_dt                 INTEGER not null,
  unit                   INTEGER,
  com_expend             NUMBER(24,4),
  act_capit_sx           NUMBER(24,4),
  com_compensate_cx      NUMBER(24,4),
  act_capit_cx           NUMBER(24,4),
  inv_asset_cx           NUMBER(24,4),
  udr_reserve_sx         NUMBER(24,4),
  min_capit_sx           NUMBER(24,4),
  solven_ratio_sx        NUMBER(24,4),
  com_cost_cx            NUMBER(24,4),
  udr_reserve_cx         NUMBER(24,4),
  comexpend_cx           NUMBER(24,4),
  earnprem_gr_cx         NUMBER(24,4),
  earnprem_sx            NUMBER(24,4),
  nrorsx                 NUMBER(24,4),
  nror                   NUMBER(24,4),
  tror                   NUMBER(24,4),
  min_capit              NUMBER(24,4),
  act_capit              NUMBER(24,4),
  inv_asset_sx           NUMBER(24,4),
  solven_ratio_cx        NUMBER(24,4),
  ostlr_cx               NUMBER(24,4),
  ror_cx                 NUMBER(24,4),
  inv_asset              NUMBER(24,4),
  earnprem_gr_sx         NUMBER(24,4),
  solven_ratio           NUMBER(24,4),
  nror_cx                NUMBER(24,4),
  ostlr_sx               NUMBER(24,4),
  min_capit_cx           NUMBER(24,4),
  earnprem_gr            NUMBER(24,4),
  earnprem_cx            NUMBER(24,4),
  earnprem               NUMBER(24,4),
  sur_rate               NUMBER(24,4),
  com_expend_sx          NUMBER(24,4),
  ror_sx                 NUMBER(24,4),
  src_updt_dt            DATE,
  isdel                  INTEGER,
  src_company_cd         VARCHAR2(60),
  srcid                  VARCHAR2(100),
  src_cd                 VARCHAR2(10),
  updt_by                NUMBER(16) not null,
  updt_dt                TIMESTAMP(6)
)
tablespace CS_MASTER_TEST
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
alter table COMPY_INSURERINDEX
  add constraint PK_COMPY_INSURERINDEX primary key (COMPY_INSURERINDEX_SID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table COMPY_LIMIT_CMB
prompt ==============================
prompt
create table COMPY_LIMIT_CMB
(
  compy_limit_sid    NUMBER(16) not null,
  company_id         NUMBER(16) not null,
  limit_type_cd      VARCHAR2(30) not null,
  limit_status_cd    VARCHAR2(30),
  is_frozen          INTEGER,
  org_id             INTEGER,
  org_nm             VARCHAR2(300),
  currency           VARCHAR2(30),
  apply_limit        NUMBER(24,4),
  apply_valid_months INTEGER,
  apply_detail       VARCHAR2(2000),
  cust_limit         NUMBER(24,4),
  limit_usageratio   NUMBER(24,4),
  limit_used         NUMBER(24,4),
  limit_notused      NUMBER(24,4),
  limit_tmpover_amt  NUMBER(24,4),
  limit_tmpover_dt   DATE,
  eff_dt             DATE,
  due_dt             DATE,
  isdel              INTEGER not null,
  src_company_cd     VARCHAR2(60),
  src_cd             VARCHAR2(10) not null,
  updt_by            NUMBER(16) not null,
  updt_dt            TIMESTAMP(6) not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table COMPY_LIMIT_CMB
  is '总控限额';
comment on column COMPY_LIMIT_CMB.compy_limit_sid
  is '总控限额流水号';
comment on column COMPY_LIMIT_CMB.company_id
  is '企业标识符';
comment on column COMPY_LIMIT_CMB.limit_type_cd
  is '限额类型';
comment on column COMPY_LIMIT_CMB.limit_status_cd
  is '限额状态';
comment on column COMPY_LIMIT_CMB.is_frozen
  is '冻结标志';
comment on column COMPY_LIMIT_CMB.org_id
  is '发布机构ID';
comment on column COMPY_LIMIT_CMB.org_nm
  is '发布机构名称';
comment on column COMPY_LIMIT_CMB.currency
  is '币种';
comment on column COMPY_LIMIT_CMB.apply_limit
  is '生效限额';
comment on column COMPY_LIMIT_CMB.apply_valid_months
  is '有效期';
comment on column COMPY_LIMIT_CMB.apply_detail
  is '意见详情';
comment on column COMPY_LIMIT_CMB.cust_limit
  is '客户限额';
comment on column COMPY_LIMIT_CMB.limit_usageratio
  is '限额使用率';
comment on column COMPY_LIMIT_CMB.limit_used
  is '已用限额';
comment on column COMPY_LIMIT_CMB.limit_notused
  is '可用限额';
comment on column COMPY_LIMIT_CMB.limit_tmpover_amt
  is '可用限额包含例外超限限额';
comment on column COMPY_LIMIT_CMB.limit_tmpover_dt
  is '例外限额到期日';
comment on column COMPY_LIMIT_CMB.eff_dt
  is '限额生效时间';
comment on column COMPY_LIMIT_CMB.due_dt
  is '限额到期时间';
comment on column COMPY_LIMIT_CMB.isdel
  is '是否删除';
comment on column COMPY_LIMIT_CMB.src_company_cd
  is '源企业代码';
comment on column COMPY_LIMIT_CMB.src_cd
  is '源系统';
comment on column COMPY_LIMIT_CMB.updt_by
  is '更新人';
comment on column COMPY_LIMIT_CMB.updt_dt
  is '更新时间';
alter table COMPY_LIMIT_CMB
  add constraint PK_COMPY_LIMIT_CMB primary key (COMPANY_ID, LIMIT_TYPE_CD)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table COMPY_LIMIT_CMB
  add constraint PK_COMPY_LIMIT_SID unique (COMPY_LIMIT_SID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table COMPY_NEWSALARM
prompt ==============================
prompt
create table COMPY_NEWSALARM
(
  compy_newsalarm_sid NUMBER(16) not null,
  company_id          NUMBER(16) not null,
  company_nm          VARCHAR2(200),
  risk_type           VARCHAR2(12),
  newscodehd          VARCHAR2(20) not null,
  importance          INTEGER not null,
  news_cd             VARCHAR2(20) not null,
  publish_dt          DATE not null,
  news_title          VARCHAR2(800) not null,
  news_src            VARCHAR2(256),
  news_linkd          VARCHAR2(500),
  news_content        CLOB,
  isdel               NUMBER(16),
  src_company_cd      VARCHAR2(20) not null,
  src_id              INTEGER not null,
  src_cd              VARCHAR2(10),
  updt_dt             TIMESTAMP(6)
)
tablespace CS_MASTER_TEST
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
alter table COMPY_NEWSALARM
  add constraint PK_COMPY_NEWSALARM primary key (COMPY_NEWSALARM_SID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 80K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table COMPY_OPERATION
prompt ==============================
prompt
create table COMPY_OPERATION
(
  factor_operation_evidence_sid NUMBER not null,
  company_id                    NUMBER not null,
  rpt_dt                        DATE,
  system_cd                     NUMBER not null,
  operation_cd                  VARCHAR2(30) not null,
  operation_value               CLOB,
  selected_option               NUMBER,
  evidence1                     CLOB,
  evidence2                     CLOB,
  evidence3                     CLOB,
  evidence4                     CLOB,
  evidence5                     CLOB,
  evidence6                     CLOB,
  data_src1                     CLOB,
  data_src2                     CLOB,
  data_src3                     VARCHAR2(1000),
  data_src4                     VARCHAR2(1000),
  data_src5                     VARCHAR2(1000),
  data_src6                     VARCHAR2(1000),
  remark                        CLOB,
  suggestion                    CLOB,
  updt_dt                       DATE not null
)
tablespace CS_MASTER_TEST
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

prompt
prompt Creating table COMPY_OPERATIONCLEAR_CMB
prompt =======================================
prompt
create table COMPY_OPERATIONCLEAR_CMB
(
  compy_operationclear_sid NUMBER(16) not null,
  company_id               NUMBER(16) not null,
  rpt_dt                   DATE not null,
  currency                 VARCHAR2(30),
  all_amt_in               NUMBER(24,4),
  all_amt_out              NUMBER(24,4),
  avg_balance_cury         NUMBER(24,4),
  avg_grtbalance_cury      NUMBER(24,4),
  avg_loanbalance_cury     NUMBER(24,4),
  loan_deposit_ratio       NUMBER(38,10),
  gur_group                VARCHAR2(10),
  balance_sixmon           NUMBER(38,10),
  bal_1y_uptimes           INTEGER,
  bal_1y_uptimes_group     VARCHAR2(10),
  bbk_nm                   VARCHAR2(300),
  overdue_12m              VARCHAR2(10),
  cust_cnt                 INTEGER,
  pd_cust_cnt              INTEGER,
  pd_inf                   NUMBER(38,10),
  group_nm                 VARCHAR2(10),
  isdel                    INTEGER not null,
  src_company_cd           VARCHAR2(60),
  src_cd                   VARCHAR2(10) not null,
  updt_by                  NUMBER(16) not null,
  updt_dt                  TIMESTAMP(6) not null
)
tablespace USERS
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
comment on table COMPY_OPERATIONCLEAR_CMB
  is 'TGT-经营指标及结算汇总表';
comment on column COMPY_OPERATIONCLEAR_CMB.compy_operationclear_sid
  is '经营指标及结算汇总编号';
comment on column COMPY_OPERATIONCLEAR_CMB.company_id
  is '企业标识符';
comment on column COMPY_OPERATIONCLEAR_CMB.rpt_dt
  is '日期';
comment on column COMPY_OPERATIONCLEAR_CMB.currency
  is '币种代码';
comment on column COMPY_OPERATIONCLEAR_CMB.all_amt_in
  is '合计资金转入';
comment on column COMPY_OPERATIONCLEAR_CMB.all_amt_out
  is '合计资金转出';
comment on column COMPY_OPERATIONCLEAR_CMB.avg_balance_cury
  is '本年存款日均余额';
comment on column COMPY_OPERATIONCLEAR_CMB.avg_grtbalance_cury
  is '本年保证金日均余额';
comment on column COMPY_OPERATIONCLEAR_CMB.avg_loanbalance_cury
  is '本年贷款日均余额';
comment on column COMPY_OPERATIONCLEAR_CMB.loan_deposit_ratio
  is '存贷比';
comment on column COMPY_OPERATIONCLEAR_CMB.gur_group
  is '担保圈';
comment on column COMPY_OPERATIONCLEAR_CMB.balance_sixmon
  is '结算账户近6个月月均余额';
comment on column COMPY_OPERATIONCLEAR_CMB.bal_1y_uptimes
  is '客户过去一年月末存款余额发生大额增加的次数_U卡';
comment on column COMPY_OPERATIONCLEAR_CMB.bal_1y_uptimes_group
  is '客户过去一年月末存款余额发生大额增加的次数分组_U卡';
comment on column COMPY_OPERATIONCLEAR_CMB.bbk_nm
  is '管理分行名称';
comment on column COMPY_OPERATIONCLEAR_CMB.overdue_12m
  is '过去一年有无逾期记录';
comment on column COMPY_OPERATIONCLEAR_CMB.cust_cnt
  is '十二个月前or三月前客户数量';
comment on column COMPY_OPERATIONCLEAR_CMB.pd_cust_cnt
  is '十二个月后or三月后违约客户数量';
comment on column COMPY_OPERATIONCLEAR_CMB.pd_inf
  is '违约概率';
comment on column COMPY_OPERATIONCLEAR_CMB.group_nm
  is '所属分组';
comment on column COMPY_OPERATIONCLEAR_CMB.isdel
  is '是否删除';
comment on column COMPY_OPERATIONCLEAR_CMB.src_company_cd
  is '源企业代码';
comment on column COMPY_OPERATIONCLEAR_CMB.src_cd
  is '源系统';
comment on column COMPY_OPERATIONCLEAR_CMB.updt_by
  is '更新人';
comment on column COMPY_OPERATIONCLEAR_CMB.updt_dt
  is '更新时间';

prompt
prompt Creating table COMPY_OPERATIONCLEAR_CMB_1219
prompt ============================================
prompt
create table COMPY_OPERATIONCLEAR_CMB_1219
(
  compy_operationclear_sid NUMBER(16) not null,
  company_id               NUMBER(16) not null,
  rpt_dt                   DATE not null,
  currency                 VARCHAR2(30),
  all_amt_in               NUMBER(24,4),
  all_amt_out              NUMBER(24,4),
  avg_balance_cury         NUMBER(24,4),
  avg_grtbalance_cury      NUMBER(24,4),
  avg_loanbalance_cury     NUMBER(24,4),
  loan_deposit_ratio       NUMBER(38,10),
  gur_group                VARCHAR2(10),
  balance_sixmon           NUMBER(38,10),
  bal_1y_uptimes           INTEGER,
  bal_1y_uptimes_group     VARCHAR2(10),
  bbk_nm                   VARCHAR2(300),
  cust_cnt                 INTEGER,
  pd_cust_cnt              INTEGER,
  pd_inf                   NUMBER(38,10),
  group_nm                 VARCHAR2(10),
  isdel                    INTEGER not null,
  src_company_cd           VARCHAR2(60),
  src_cd                   VARCHAR2(10) not null,
  updt_by                  NUMBER(16) not null,
  updt_dt                  TIMESTAMP(6) not null
)
tablespace USERS
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
alter table COMPY_OPERATIONCLEAR_CMB_1219
  add constraint PK_COMPY_OPERATIONCLEAR_CMB primary key (COMPY_OPERATIONCLEAR_SID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 80K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table COMPY_OVERDUEINTEREST_CMB
prompt ========================================
prompt
create table COMPY_OVERDUEINTEREST_CMB
(
  compy_overdueinterest_sid NUMBER(16) not null,
  company_id                NUMBER(16) not null,
  data_dt                   DATE not null,
  overdue_amt               NUMBER(24,4),
  innerdebt_amt             NUMBER(24,4),
  outerdebt_amt             NUMBER(24,4),
  earliest_overdue_dt       DATE,
  longest_overdue_days      INTEGER,
  isdel                     INTEGER not null,
  src_company_cd            VARCHAR2(60),
  src_cd                    VARCHAR2(10) not null,
  updt_by                   NUMBER(16) not null,
  updt_dt                   TIMESTAMP(6) not null
)
tablespace USERS
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
comment on table COMPY_OVERDUEINTEREST_CMB
  is '逾期欠息';
comment on column COMPY_OVERDUEINTEREST_CMB.compy_overdueinterest_sid
  is '评级业务编号';
comment on column COMPY_OVERDUEINTEREST_CMB.company_id
  is '企业标识符';
comment on column COMPY_OVERDUEINTEREST_CMB.data_dt
  is '日期';
comment on column COMPY_OVERDUEINTEREST_CMB.overdue_amt
  is '逾期本金';
comment on column COMPY_OVERDUEINTEREST_CMB.innerdebt_amt
  is '表内欠息';
comment on column COMPY_OVERDUEINTEREST_CMB.outerdebt_amt
  is '表外欠息';
comment on column COMPY_OVERDUEINTEREST_CMB.earliest_overdue_dt
  is '本息最早逾期日';
comment on column COMPY_OVERDUEINTEREST_CMB.longest_overdue_days
  is '最长逾期天数';
comment on column COMPY_OVERDUEINTEREST_CMB.isdel
  is '是否删除';
comment on column COMPY_OVERDUEINTEREST_CMB.src_company_cd
  is '源企业代码';
comment on column COMPY_OVERDUEINTEREST_CMB.src_cd
  is '源系统';
comment on column COMPY_OVERDUEINTEREST_CMB.updt_by
  is '更新人';
comment on column COMPY_OVERDUEINTEREST_CMB.updt_dt
  is '更新时间';
alter table COMPY_OVERDUEINTEREST_CMB
  add constraint PK_COMPY_OVERDUEINTEREST_CMB primary key (COMPY_OVERDUEINTEREST_SID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 80K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table COMPY_PBCCREDIT_CMB
prompt ==================================
prompt
create table COMPY_PBCCREDIT_CMB
(
  compy_pbccredit_sid NUMBER(16) not null,
  company_id          NUMBER(16) not null,
  rpt_dt              DATE not null,
  normal_no           INTEGER,
  normal_balance      NUMBER(24,4),
  concerned_no        INTEGER,
  concerned_balance   NUMBER(24,4),
  bad_no              INTEGER,
  bad_balance         NUMBER(24,4),
  total_no            INTEGER,
  total_balance       NUMBER(24,4),
  isdel               INTEGER not null,
  src_company_cd      VARCHAR2(60),
  src_cd              VARCHAR2(10) not null,
  updt_by             NUMBER(16) not null,
  updt_dt             TIMESTAMP(6) not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table COMPY_PBCCREDIT_CMB
  is '人行征信';
comment on column COMPY_PBCCREDIT_CMB.compy_pbccredit_sid
  is '评级业务编号';
comment on column COMPY_PBCCREDIT_CMB.company_id
  is '企业标识符';
comment on column COMPY_PBCCREDIT_CMB.rpt_dt
  is '报告日期';
comment on column COMPY_PBCCREDIT_CMB.normal_no
  is '正常类汇总笔数';
comment on column COMPY_PBCCREDIT_CMB.normal_balance
  is '正常类汇总余额';
comment on column COMPY_PBCCREDIT_CMB.concerned_no
  is '关注类汇总笔数';
comment on column COMPY_PBCCREDIT_CMB.concerned_balance
  is '关注类汇总余额';
comment on column COMPY_PBCCREDIT_CMB.bad_no
  is '不良类汇总笔数';
comment on column COMPY_PBCCREDIT_CMB.bad_balance
  is '不良类汇总余额';
comment on column COMPY_PBCCREDIT_CMB.total_no
  is '合计笔数';
comment on column COMPY_PBCCREDIT_CMB.total_balance
  is '合计余额';
comment on column COMPY_PBCCREDIT_CMB.isdel
  is '是否删除';
comment on column COMPY_PBCCREDIT_CMB.src_company_cd
  is '源企业代码';
comment on column COMPY_PBCCREDIT_CMB.src_cd
  is '源系统';
comment on column COMPY_PBCCREDIT_CMB.updt_by
  is '更新人';
comment on column COMPY_PBCCREDIT_CMB.updt_dt
  is '更新时间';
alter table COMPY_PBCCREDIT_CMB
  add constraint PK_COMPY_PBCCREDIT_CMB primary key (COMPANY_ID, RPT_DT)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table COMPY_PBCCREDIT_CMB
  add constraint PK_COMPY_PBCCREDIT_SID unique (COMPY_PBCCREDIT_SID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table COMPY_PBCGUAR_CMB
prompt ================================
prompt
create table COMPY_PBCGUAR_CMB
(
  compy_pbcguar_sid  NUMBER(16) not null,
  msg_id             VARCHAR2(30),
  grtser_id          INTEGER,
  grtbusser_id       INTEGER,
  company_id         NUMBER(16) not null,
  rpt_dt             DATE,
  warrantee_id       INTEGER,
  warrantee_nm       VARCHAR2(300),
  currency           VARCHAR2(30),
  guar_amt           NUMBER(24,4),
  guar_type_cd       VARCHAR2(30),
  balance            INTEGER,
  end_dt             DATE,
  five_class_cd      VARCHAR2(30),
  warrantee_currency VARCHAR2(30),
  isdel              INTEGER not null,
  src_company_cd     VARCHAR2(60),
  src_cd             VARCHAR2(10) not null,
  updt_by            NUMBER(16) not null,
  updt_dt            TIMESTAMP(6) not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on table COMPY_PBCGUAR_CMB
  is 'TGT-担保信息';
comment on column COMPY_PBCGUAR_CMB.compy_pbcguar_sid
  is '评级业务编号';
comment on column COMPY_PBCGUAR_CMB.msg_id
  is '报文标识符';
comment on column COMPY_PBCGUAR_CMB.grtser_id
  is '担保合同流水号';
comment on column COMPY_PBCGUAR_CMB.grtbusser_id
  is '被担保业务流水号';
comment on column COMPY_PBCGUAR_CMB.company_id
  is '企业标识符';
comment on column COMPY_PBCGUAR_CMB.rpt_dt
  is '报告日期';
comment on column COMPY_PBCGUAR_CMB.warrantee_id
  is '被担保人核心客户号';
comment on column COMPY_PBCGUAR_CMB.warrantee_nm
  is '被担保人名称';
comment on column COMPY_PBCGUAR_CMB.currency
  is '担保币种';
comment on column COMPY_PBCGUAR_CMB.guar_amt
  is '担保金额';
comment on column COMPY_PBCGUAR_CMB.guar_type_cd
  is '担保形式';
comment on column COMPY_PBCGUAR_CMB.balance
  is '被担保业务余额';
comment on column COMPY_PBCGUAR_CMB.end_dt
  is '被担保业务结清（到期）日期';
comment on column COMPY_PBCGUAR_CMB.five_class_cd
  is '被担保业务五级分类';
comment on column COMPY_PBCGUAR_CMB.warrantee_currency
  is '被担保业务币种';
comment on column COMPY_PBCGUAR_CMB.isdel
  is '是否删除';
comment on column COMPY_PBCGUAR_CMB.src_company_cd
  is '源企业代码';
comment on column COMPY_PBCGUAR_CMB.src_cd
  is '源系统';
comment on column COMPY_PBCGUAR_CMB.updt_by
  is '更新人';
comment on column COMPY_PBCGUAR_CMB.updt_dt
  is '更新时间';
create unique index U_COMPY_PBCGUAR_CMB_IDX on COMPY_PBCGUAR_CMB (MSG_ID, GRTSER_ID, GRTBUSSER_ID)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
alter table COMPY_PBCGUAR_CMB
  add constraint U_COMPY_PBCGUAR_CMB_COT unique (MSG_ID, GRTSER_ID, GRTBUSSER_ID);

prompt
prompt Creating table COMPY_RATING_LIST
prompt ================================
prompt
create table COMPY_RATING_LIST
(
  compy_rating_list_sid NUMBER(11) not null,
  company_id            NUMBER(11),
  company_nm            VARCHAR2(200),
  exposure_sid          NUMBER(11),
  code                  VARCHAR2(100),
  rpt_dt                DATE
)
tablespace CS_MASTER_TEST
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

prompt
prompt Creating table COMPY_REGION
prompt ===========================
prompt
create table COMPY_REGION
(
  company_id NUMBER(16) not null,
  region_cd  INTEGER not null,
  client_id  NUMBER(16) not null,
  updt_by    NUMBER(16) not null,
  isdel      INTEGER not null,
  updt_dt    TIMESTAMP(6) not null
)
tablespace USERS
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
alter table COMPY_REGION
  add constraint PK_COMPY_REGION primary key (COMPANY_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 80K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table COMPY_RULEFACTOR_CMB
prompt ===================================
prompt
create table COMPY_RULEFACTOR_CMB
(
  compy_rulefactor_sid NUMBER(16) not null,
  company_id           NUMBER(16) not null,
  factor_cd            VARCHAR2(100) not null,
  factor_value         VARCHAR2(300),
  isdel                INTEGER not null,
  src_company_cd       VARCHAR2(60),
  src_cd               VARCHAR2(10) not null,
  updt_by              NUMBER(16) not null,
  updt_dt              TIMESTAMP(6) not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
comment on column COMPY_RULEFACTOR_CMB.compy_rulefactor_sid
  is '行内智能评级指标流水号';
comment on column COMPY_RULEFACTOR_CMB.company_id
  is '企业标识符';
comment on column COMPY_RULEFACTOR_CMB.factor_cd
  is '指标代码';
comment on column COMPY_RULEFACTOR_CMB.factor_value
  is '指标值';
comment on column COMPY_RULEFACTOR_CMB.isdel
  is '是否删除';
comment on column COMPY_RULEFACTOR_CMB.src_company_cd
  is '源企业代码';
comment on column COMPY_RULEFACTOR_CMB.src_cd
  is '源系统';
comment on column COMPY_RULEFACTOR_CMB.updt_by
  is '更新人';
comment on column COMPY_RULEFACTOR_CMB.updt_dt
  is '更新时间';
alter table COMPY_RULEFACTOR_CMB
  add constraint PK_COMPY_RULEFACTOR_CMB primary key (COMPY_RULEFACTOR_SID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table COMPY_SECRISKINDEX
prompt =================================
prompt
create table COMPY_SECRISKINDEX
(
  compy_secriskindex_sid NUMBER(16) not null,
  notice_dt              DATE,
  company_id             NUMBER(16) not null,
  rpt_dt                 INTEGER not null,
  rrt_style              INTEGER not null,
  unit                   INTEGER,
  item_cd                NUMBER(16) not null,
  begin_amt              NUMBER(24,4),
  end_amt                NUMBER(24,4),
  remark                 VARCHAR2(200),
  src_updt_dt            DATE,
  isdel                  INTEGER not null,
  src_company_cd         VARCHAR2(60),
  srcid                  VARCHAR2(100),
  src_cd                 VARCHAR2(10) not null,
  updt_by                NUMBER(16) not null,
  updt_dt                TIMESTAMP(6) not null
)
tablespace CS_MASTER_TEST
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
alter table COMPY_SECRISKINDEX
  add constraint PK_COMPY_SECRISKINDEX primary key (COMPY_SECRISKINDEX_SID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table COMPY_SECURITY_XW
prompt ================================
prompt
create table COMPY_SECURITY_XW
(
  secinner_id     NUMBER(16) not null,
  company_id      NUMBER(16) not null,
  src_secinner_cd VARCHAR2(30) not null,
  list_st         INTEGER not null,
  use_st          INTEGER not null,
  isdel           INTEGER not null,
  src_cd          VARCHAR2(10) not null,
  updt_dt         TIMESTAMP(6) not null
)
tablespace CS_MASTER_TEST
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
alter table COMPY_SECURITY_XW
  add constraint COMPY_SECURITY_XW_PKEY primary key (SECINNER_ID, COMPANY_ID, SRC_CD)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table COMPY_SHAREHOLDER
prompt ================================
prompt
create table COMPY_SHAREHOLDER
(
  compy_shareholder_sid NUMBER not null,
  company_id            NUMBER not null,
  notice_dt             DATE,
  end_dt                NUMBER not null,
  rank                  NUMBER,
  feature               NUMBER,
  share_type            VARCHAR2(200),
  sharehd_id            NUMBER,
  sharehdname           VARCHAR2(300),
  sharehd_natureid      NUMBER,
  sharehd_typeid        NUMBER,
  act_share_type        VARCHAR2(200),
  limited_share_num     NUMBER,
  cshare                NUMBER,
  ncshare               NUMBER,
  change_amount         NUMBER,
  sharehd_num           NUMBER,
  sharehd_ratio         NUMBER,
  hold_start_dt         DATE,
  hold_end_dt           DATE,
  share_relation        CLOB,
  pfshare_num           NUMBER,
  sharehd_rel_group     VARCHAR2(100),
  data_src              VARCHAR2(200),
  remark                CLOB,
  concerted_group       VARCHAR2(100),
  src_updt_dt           DATE,
  isdel                 NUMBER not null,
  src_company_cd        VARCHAR2(60),
  srcid                 VARCHAR2(100),
  src_cd                VARCHAR2(10) not null,
  updt_dt               DATE not null
)
tablespace CS_MASTER_TEST
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
alter table COMPY_SHAREHOLDER
  add primary key (COMPY_SHAREHOLDER_SID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table COMPY_VIOLATION
prompt ==============================
prompt
create table COMPY_VIOLATION
(
  compy_violation_sid NUMBER(16) not null,
  company_id          NUMBER(16) not null,
  notice_dt           DATE,
  security_nm         VARCHAR2(100),
  viola_ltype         VARCHAR2(300),
  viola_subject       INTEGER,
  punish_object       VARCHAR2(200),
  relation            VARCHAR2(200),
  viola_action        CLOB,
  punish_type         VARCHAR2(120),
  punish_step         CLOB,
  operater            VARCHAR2(120),
  punish_amt          NUMBER(24,4),
  related_law         VARCHAR2(1000),
  isdel               INTEGER not null,
  src_company_cd      VARCHAR2(60),
  srcid               VARCHAR2(100),
  src_cd              VARCHAR2(10) not null,
  updt_dt             TIMESTAMP(6) not null
)
tablespace CS_MASTER_TEST
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
alter table COMPY_VIOLATION
  add constraint COMPY_VIOLATION_PKEY primary key (COMPY_VIOLATION_SID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table COMPY_WARNINGS
prompt =============================
prompt
create table COMPY_WARNINGS
(
  compy_warnings_sid NUMBER(16) not null,
  subject_id         NUMBER(16) not null,
  subject_type       INTEGER,
  notice_dt          DATE not null,
  warning_type       INTEGER,
  severity           INTEGER,
  warning_score      INTEGER,
  warning_title      VARCHAR2(1000),
  type_id            INTEGER,
  status_flag        INTEGER,
  warning_result_cd  INTEGER,
  adjust_severity    INTEGER,
  adjust_score       INTEGER,
  remark             VARCHAR2(2000),
  process_by         NUMBER(16),
  process_dt         TIMESTAMP(6),
  isdel              INTEGER not null,
  updt_by            NUMBER(16) not null,
  src_cd             VARCHAR2(10) not null,
  updt_dt            TIMESTAMP(6) not null
)
tablespace USERS
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
alter table COMPY_WARNINGS
  add constraint PK_COMPY_WARNINGS primary key (COMPY_WARNINGS_SID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 80K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table COMPY_WARNINGS_CONTENT
prompt =====================================
prompt
create table COMPY_WARNINGS_CONTENT
(
  compy_warnings_sid NUMBER(16) not null,
  warning_content    CLOB
)
tablespace USERS
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

prompt
prompt Creating table CUSTOMER_CMB
prompt ===========================
prompt
create table CUSTOMER_CMB
(
  cust_no              NUMBER(16) not null,
  company_id           NUMBER(16),
  customer_nm          VARCHAR2(300),
  org_num              VARCHAR2(30),
  bl_numb              VARCHAR2(30),
  risk_status_cd       VARCHAR2(30),
  class_grade_cd       VARCHAR2(30),
  is_yjhplatform       INTEGER,
  is_loan              INTEGER,
  is_cmbrelatecust     INTEGER,
  customer_grade_cd    VARCHAR2(30),
  is_high_risk         INTEGER,
  group_cust_no        VARCHAR2(30),
  group_nm             VARCHAR2(300),
  group_warnstatus_cd  VARCHAR2(30),
  is_guar              INTEGER,
  guargrp_risklevel_cd VARCHAR2(30),
  isdel                INTEGER not null,
  src_company_cd       VARCHAR2(60),
  srcid                VARCHAR2(100) not null,
  src_cd               VARCHAR2(10) not null,
  updt_by              NUMBER(16) not null,
  updt_dt              TIMESTAMP(6) not null
)
tablespace USERS
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
alter table CUSTOMER_CMB
  add constraint PK_CUSTOMER_CMB primary key (CUST_NO)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 80K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table ELEMENT
prompt ======================
prompt
create table ELEMENT
(
  element_cd   VARCHAR2(30) not null,
  element_nm   VARCHAR2(100) not null,
  description  VARCHAR2(800),
  element_type VARCHAR2(100) not null,
  data_type    INTEGER not null,
  unit         INTEGER,
  format       VARCHAR2(20),
  src_cd       VARCHAR2(10) not null,
  isdel        INTEGER,
  client_id    NUMBER(16) not null,
  updt_by      NUMBER(16) not null,
  updt_dt      TIMESTAMP(6) not null
)
tablespace CS_MASTER_TEST
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
alter table ELEMENT
  add constraint PK_ELEMENT primary key (ELEMENT_CD)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table ETL_DM_LOADLOG
prompt =============================
prompt
create table ETL_DM_LOADLOG
(
  loadlog_sid       NUMBER(16) not null,
  process_nm        VARCHAR2(80) not null,
  orig_record_count NUMBER(16),
  dup_record_count  NUMBER(16),
  insert_count      NUMBER(16) not null,
  updt_count        NUMBER(16) not null,
  start_dt          TIMESTAMP(6) not null,
  end_dt            TIMESTAMP(6) not null,
  start_rowid       NUMBER(16),
  end_rowid         NUMBER(16)
)
tablespace CS_MASTER_TEST
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
alter table ETL_DM_LOADLOG
  add constraint PK_ETL_DM_LOADLOG primary key (LOADLOG_SID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table ETL_EXP_LOADLOG
prompt ==============================
prompt
create table ETL_EXP_LOADLOG
(
  loadlog_sid       NUMBER(16) not null,
  process_nm        VARCHAR2(80) not null,
  table_nm          VARCHAR2(30) not null,
  file_nm           VARCHAR2(100),
  orig_record_count NUMBER(16),
  record_count      NUMBER(16),
  start_dt          TIMESTAMP(6) not null,
  end_dt            TIMESTAMP(6)
)
tablespace CS_MASTER_TEST
  pctfree 10
  initrans 1
  maxtrans 255;
alter table ETL_EXP_LOADLOG
  add constraint PK_ETL_EXP_LOADLOG primary key (LOADLOG_SID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table EXPOSURE
prompt =======================
prompt
create table EXPOSURE
(
  exposure_sid     NUMBER(16) not null,
  exposure_cd      VARCHAR2(30) not null,
  exposure         VARCHAR2(100) not null,
  exposure_level   INTEGER not null,
  parent_expos_sid NUMBER(16),
  exposure_desc    VARCHAR2(100),
  remark           VARCHAR2(300),
  isdel            INTEGER not null,
  client_id        NUMBER(16),
  updt_by          NUMBER(16),
  updt_dt          TIMESTAMP(6) not null
)
tablespace CS_MASTER_TEST
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
alter table EXPOSURE
  add constraint PK_EXPOSURE primary key (EXPOSURE_SID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table EXPOSURE_FACTOR_AJUST_XW
prompt =======================================
prompt
create table EXPOSURE_FACTOR_AJUST_XW
(
  exposure_factor_ajust_sid NUMBER(16) not null,
  exposure_sid              NUMBER(16) not null,
  ajust_cd                  VARCHAR2(30) not null,
  formula_ch                VARCHAR2(2000),
  formula_en                VARCHAR2(2000),
  remark                    VARCHAR2(1000),
  publish_dt                DATE not null,
  isdel                     INTEGER,
  client_id                 NUMBER(16) not null,
  updt_by                   NUMBER(16) not null,
  updt_dt                   TIMESTAMP(6) not null
)
tablespace CS_MASTER_TEST
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
alter table EXPOSURE_FACTOR_AJUST_XW
  add constraint PK_EXPOSURE_FACTOR_AJUST_XW primary key (EXPOSURE_FACTOR_AJUST_SID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table EXPOSURE_FACTOR_XW
prompt =================================
prompt
create table EXPOSURE_FACTOR_XW
(
  exposure_factor_sid NUMBER(16) not null,
  exposure_sid        NUMBER(16) not null,
  factor_cd           VARCHAR2(30) not null,
  factor_format_cd    INTEGER not null,
  formula_ch          VARCHAR2(2000),
  formula_en          VARCHAR2(2000),
  remark              VARCHAR2(1000),
  publish_dt          DATE not null,
  isdel               INTEGER,
  client_id           NUMBER(16) not null,
  updt_by             NUMBER(16) not null,
  updt_dt             TIMESTAMP(6) not null
)
tablespace CS_MASTER_TEST
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
alter table EXPOSURE_FACTOR_XW
  add constraint PK_EXPOSURE_FACTOR_XW primary key (EXPOSURE_FACTOR_SID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table EXPOSURE_OWNER
prompt =============================
prompt
create table EXPOSURE_OWNER
(
  exposure_sid NUMBER(16) not null,
  user_id      NUMBER(16) not null,
  owner_type   INTEGER not null,
  client_id    NUMBER(16) not null,
  updt_by      NUMBER(16) not null,
  updt_dt      TIMESTAMP(6) not null
)
tablespace CS_MASTER_TEST
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

prompt
prompt Creating table FACTOR
prompt =====================
prompt
create table FACTOR
(
  factor_cd          VARCHAR2(30) not null,
  factor_nm          VARCHAR2(200) not null,
  factor_type        VARCHAR2(100) not null,
  factor_category_cd INTEGER not null,
  factor_appl_cd     INTEGER not null,
  factor_property_cd INTEGER not null,
  parent_factor_cd   VARCHAR2(30),
  factor_level       INTEGER not null,
  level_relation     VARCHAR2(30),
  description        VARCHAR2(1000),
  formula_ch         VARCHAR2(2000),
  formula_en         VARCHAR2(2000),
  formula_derived    VARCHAR2(4000),
  direction          INTEGER not null,
  unit               INTEGER,
  format             VARCHAR2(100),
  remark             VARCHAR2(1000),
  isdel              INTEGER,
  client_id          NUMBER(16) not null,
  updt_by            NUMBER(16) not null,
  updt_dt            TIMESTAMP(6) not null
)
tablespace CS_MASTER_TEST
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
alter table FACTOR
  add constraint PK_FACTOR primary key (FACTOR_CD)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table FACTOR_AJUSTMENT
prompt ===============================
prompt
create table FACTOR_AJUSTMENT
(
  ajust_cd          VARCHAR2(30) not null,
  ajust_nm          VARCHAR2(200) not null,
  ajust_type        VARCHAR2(100) not null,
  ajust_category_cd INTEGER not null,
  parent_ajust_cd   VARCHAR2(30),
  ajust_level       INTEGER not null,
  level_relation    VARCHAR2(30),
  description       VARCHAR2(1000),
  factor_cd         VARCHAR2(30),
  formula_ch        VARCHAR2(2000),
  formula_en        VARCHAR2(2000),
  direction         INTEGER not null,
  importance        INTEGER,
  unit              INTEGER,
  format            VARCHAR2(100),
  remark            VARCHAR2(1000),
  isdel             INTEGER,
  client_id         NUMBER(16) not null,
  updt_by           NUMBER(16) not null,
  updt_dt           TIMESTAMP(6) not null
)
tablespace CS_MASTER_TEST
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
alter table FACTOR_AJUSTMENT
  add constraint PK_FACTOR_AJUSTMENT primary key (AJUST_CD)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table FACTOR_CHANGE_WARNING
prompt ====================================
prompt
create table FACTOR_CHANGE_WARNING
(
  factor_change_warning_sid NUMBER(16) not null,
  company_id                NUMBER(16) not null,
  exposure_sid              NUMBER(16) not null,
  factor_cd                 VARCHAR2(30) not null,
  warning_regulation_sid    NUMBER(16) not null,
  rpt_dt                    DATE,
  cal_result                NUMBER(32,16),
  threshold                 NUMBER(32,16),
  warning_title             VARCHAR2(100),
  warning_content           VARCHAR2(1000),
  severity                  INTEGER not null,
  severity_adjusted         INTEGER,
  process_flag              INTEGER,
  client_id                 NUMBER(16) not null,
  updt_by                   NUMBER(16) not null,
  updt_dt                   TIMESTAMP(6) not null
)
tablespace CS_MASTER_TEST
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
alter table FACTOR_CHANGE_WARNING
  add constraint PK_FACTOR_CHANGE_WARNING primary key (FACTOR_CHANGE_WARNING_SID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 80K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table FACTOR_ELEMENT_XW
prompt ================================
prompt
create table FACTOR_ELEMENT_XW
(
  factor_element_sid  NUMBER(16) not null,
  factor_cd           VARCHAR2(30) not null,
  element_category_cd INTEGER not null,
  element_cd          VARCHAR2(30) not null,
  isdel               INTEGER,
  client_id           NUMBER(16) not null,
  updt_by             NUMBER(16) not null,
  updt_dt             TIMESTAMP(6) not null
)
tablespace CS_MASTER_TEST
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
alter table FACTOR_ELEMENT_XW
  add constraint PK_FACTOR_ELEMENT_XW primary key (FACTOR_ELEMENT_SID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table FACTOR_OPTION
prompt ============================
prompt
create table FACTOR_OPTION
(
  factor_option_sid NUMBER(16) not null,
  exposure_sid      INTEGER not null,
  factor_cd         VARCHAR2(30) not null,
  option_num        INTEGER not null,
  formula_ch        VARCHAR2(2000),
  formula_en        VARCHAR2(2000),
  remark            VARCHAR2(1000),
  isdel             INTEGER,
  client_id         NUMBER(16) not null,
  updt_by           NUMBER(16) not null,
  updt_dt           TIMESTAMP(6) not null
)
tablespace CS_MASTER_TEST
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
alter table FACTOR_OPTION
  add constraint PK_FACTOR_OPTION primary key (FACTOR_OPTION_SID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table INDUSTRY
prompt =======================
prompt
create table INDUSTRY
(
  id             NUMBER(16) not null,
  code           VARCHAR2(30) not null,
  name           VARCHAR2(100) not null,
  system_cd      INTEGER not null,
  industry_level INTEGER not null,
  parent_ind_sid NUMBER(16),
  creation_time  TIMESTAMP(6),
  client_id      NUMBER(16) not null,
  updt_by        NUMBER(16) not null,
  update_time    TIMESTAMP(6)
)
tablespace CS_MASTER_TEST
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
alter table INDUSTRY
  add constraint PK_INDUSTRY primary key (ID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table INVESTMENT_LIMIT
prompt ===============================
prompt
create table INVESTMENT_LIMIT
(
  investment_limit_sid NUMBER(16) not null,
  company_id           NUMBER(16) not null,
  type                 INTEGER not null,
  bond_dimension_cd    INTEGER,
  limit_item_cd        INTEGER not null,
  limit_vol            NUMBER(24,4),
  is_new               INTEGER not null,
  start_dt             DATE not null,
  end_dt               DATE not null,
  rating_record_id     NUMBER(16),
  workflow_sid         NUMBER(16),
  remark               VARCHAR2(1000),
  isdel                INTEGER not null,
  client_id            NUMBER(16) not null,
  updt_by              NUMBER(16) not null,
  updt_dt              TIMESTAMP(6) not null
)
tablespace USERS
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
alter table INVESTMENT_LIMIT
  add constraint PK_INVESTMENT_LIMIT primary key (INVESTMENT_LIMIT_SID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 80K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table INVESTMENT_LIMIT_RATIO
prompt =====================================
prompt
create table INVESTMENT_LIMIT_RATIO
(
  limit_ratio_sid NUMBER(16) not null,
  exposure_sid    NUMBER(16) not null,
  rating          VARCHAR2(10) not null,
  ratio           NUMBER(24,4),
  isdel           INTEGER not null,
  client_id       NUMBER(16) not null,
  updt_by         NUMBER(16) not null,
  updt_dt         TIMESTAMP(6) not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
alter table INVESTMENT_LIMIT_RATIO
  add constraint PK_INVESTMENT_LIMIT_RATIO primary key (LIMIT_RATIO_SID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table LKP_CHARCODE
prompt ===========================
prompt
create table LKP_CHARCODE
(
  constant_id   NUMBER(20) not null,
  constant_cd   VARCHAR2(30) not null,
  constant_nm   VARCHAR2(200) not null,
  parent_id     NUMBER(20),
  constant_type NUMBER(20) not null,
  remark        VARCHAR2(500),
  isdel         NUMBER(20) not null,
  updt_dt       DATE not null
)
tablespace CS_MASTER_TEST
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
alter table LKP_CHARCODE
  add primary key (CONSTANT_ID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table LKP_CONSTANT
prompt ===========================
prompt
create table LKP_CONSTANT
(
  constant_cd     VARCHAR2(30) not null,
  constant_nm     VARCHAR2(200) not null,
  parent_cd       VARCHAR2(30),
  constant_type   NUMBER(12) not null,
  src_constant_cd VARCHAR2(30),
  remark          VARCHAR2(500),
  isdel           INTEGER not null,
  updt_dt         TIMESTAMP(6) not null
)
tablespace USERS
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

prompt
prompt Creating table LKP_COUNTRY
prompt ==========================
prompt
create table LKP_COUNTRY
(
  country_id   NUMBER(20) not null,
  country_cd   NCHAR(2),
  country_cd3  NCHAR(3),
  encountry_nm VARCHAR2(200),
  cncountry_nm VARCHAR2(200) not null,
  updt_dt      DATE not null
)
tablespace CS_MASTER_TEST
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
alter table LKP_COUNTRY
  add primary key (COUNTRY_ID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table LKP_CURRENCY
prompt ===========================
prompt
create table LKP_CURRENCY
(
  currency_cd    NUMBER(20) not null,
  currency_short VARCHAR2(10) not null,
  currency       VARCHAR2(60) not null,
  updt_dt        DATE not null
)
tablespace CS_MASTER_TEST
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
alter table LKP_CURRENCY
  add primary key (CURRENCY_CD)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table LKP_DEFAULTFACTOR_DISP
prompt =====================================
prompt
create table LKP_DEFAULTFACTOR_DISP
(
  exposure_sid NUMBER(20) not null,
  exposure_cd  VARCHAR2(30) not null,
  factor_cd    VARCHAR2(30) not null,
  disp_nm      VARCHAR2(200) not null,
  disp_order   NUMBER(20),
  updt_dt      DATE not null
)
tablespace CS_MASTER_TEST
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
alter table LKP_DEFAULTFACTOR_DISP
  add primary key (EXPOSURE_CD, FACTOR_CD)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table LKP_DISP_FIELD
prompt =============================
prompt
create table LKP_DISP_FIELD
(
  disp_field_id NUMBER(20) not null,
  first_type    NUMBER(20) not null,
  second_type   VARCHAR2(100) not null,
  disp_field_cd VARCHAR2(60) not null,
  disp_field_nm VARCHAR2(100) not null
)
tablespace CS_MASTER_TEST
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
alter table LKP_DISP_FIELD
  add primary key (DISP_FIELD_ID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table LKP_FACTOR_EXCEPTION_RULE
prompt ========================================
prompt
create table LKP_FACTOR_EXCEPTION_RULE
(
  factor_exception_rule_sid NUMBER(20) not null,
  factor_cd                 VARCHAR2(30) not null,
  case_cd                   VARCHAR2(10) not null,
  description               VARCHAR2(200),
  numerator_rule            VARCHAR2(30) not null,
  operator                  VARCHAR2(10),
  denominator_rule          VARCHAR2(30) not null,
  replace_value             NUMBER(38,18),
  isdel                     NUMBER(11),
  client_id                 NUMBER(20),
  updt_by                   NUMBER(20),
  updt_dt                   DATE
)
tablespace CS_MASTER_TEST
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
alter table LKP_FACTOR_EXCEPTION_RULE
  add primary key (FACTOR_EXCEPTION_RULE_SID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table LKP_FINANCE_INDEX
prompt ================================
prompt
create table LKP_FINANCE_INDEX
(
  index_id   NUMBER(20) not null,
  index_cd   VARCHAR2(30) not null,
  finindex   VARCHAR2(200) not null,
  parent_id  NUMBER(20),
  index_type NUMBER(20) not null,
  remark     VARCHAR2(1000),
  isdel      NUMBER(11) not null,
  updt_dt    DATE not null
)
tablespace CS_MASTER_TEST
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
alter table LKP_FINANCE_INDEX
  add primary key (INDEX_ID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table LKP_FINANELEMENT
prompt ===============================
prompt
create table LKP_FINANELEMENT
(
  lkp_finanelement_sid NUMBER(20) not null,
  subject_cd           VARCHAR2(20) not null,
  subject_enm          VARCHAR2(30) not null,
  subject_nm           VARCHAR2(300) not null,
  subject_type         NUMBER(11) not null,
  parent_subject_cd    VARCHAR2(20) not null,
  subject_level        NUMBER(11) not null,
  company_type         NUMBER(11) not null,
  subject_lastyear     VARCHAR2(30),
  subject_blastyear    VARCHAR2(30),
  is_label             NUMBER(11) not null,
  isdel                NUMBER(11) not null,
  updt_dt              DATE not null
)
tablespace CS_MASTER_TEST
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
alter table LKP_FINANELEMENT
  add primary key (LKP_FINANELEMENT_SID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table LKP_FINANSUBJECT_DISP
prompt ====================================
prompt
create table LKP_FINANSUBJECT_DISP
(
  lkp_finansubject_disp_sid NUMBER(20) not null,
  subject_cd                VARCHAR2(20) not null,
  subject_enm               VARCHAR2(100) not null,
  subject_nm                VARCHAR2(300) not null,
  subject_type              NUMBER(20) not null,
  parent_subject_cd         VARCHAR2(20) not null,
  subject_level             NUMBER(20) not null,
  company_type              NUMBER(20) not null,
  disp_type                 NUMBER(20) not null,
  is_label                  NUMBER(20) not null,
  is_bold                   NUMBER(20) not null,
  is_formular               NUMBER(20) not null,
  unit                      VARCHAR2(20),
  isdel                     NUMBER(20) not null,
  updt_dt                   DATE not null
)
tablespace CS_MASTER_TEST
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
alter table LKP_FINANSUBJECT_DISP
  add primary key (LKP_FINANSUBJECT_DISP_SID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table LKP_INDUSTRY_ACCTING_STRD
prompt ========================================
prompt
create table LKP_INDUSTRY_ACCTING_STRD
(
  industry_sid         NUMBER(20) not null,
  accting_strd_item_id NUMBER(20) not null,
  updt_dt              DATE not null
)
tablespace CS_MASTER_TEST
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
alter table LKP_INDUSTRY_ACCTING_STRD
  add primary key (INDUSTRY_SID, ACCTING_STRD_ITEM_ID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table LKP_MARKET_ABBR
prompt ==============================
prompt
create table LKP_MARKET_ABBR
(
  market_cd   VARCHAR2(30) not null,
  market_abbr VARCHAR2(30),
  market_nm   VARCHAR2(80) not null,
  src_updt_dt DATE,
  isdel       NUMBER not null,
  updt_dt     DATE not null
)
tablespace CS_MASTER_TEST
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
alter table LKP_MARKET_ABBR
  add primary key (MARKET_CD)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table LKP_NUMBCODE
prompt ===========================
prompt
create table LKP_NUMBCODE
(
  constant_cd   NUMBER(20) not null,
  constant_nm   VARCHAR2(200) not null,
  constant_type NUMBER(20) not null,
  isdel         NUMBER(20) not null,
  updt_dt       DATE not null
)
tablespace CS_MASTER_TEST
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

prompt
prompt Creating table LKP_RATINGCD_XW
prompt ==============================
prompt
create table LKP_RATINGCD_XW
(
  constant_nm   VARCHAR2(200) not null,
  ratingcd_nm   VARCHAR2(200) not null,
  constant_type NUMBER(11) not null,
  updt_dt       DATE not null
)
tablespace CS_MASTER_TEST
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
alter table LKP_RATINGCD_XW
  add primary key (CONSTANT_NM, RATINGCD_NM, CONSTANT_TYPE)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table LKP_RATING_CODE_LIST
prompt ===================================
prompt
create table LKP_RATING_CODE_LIST
(
  rating_rnk        NUMBER(20),
  rating_code       VARCHAR2(4),
  rating_code_moody VARCHAR2(4)
)
tablespace CS_MASTER_TEST
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

prompt
prompt Creating table LKP_REGION
prompt =========================
prompt
create table LKP_REGION
(
  region_cd   NUMBER(20) not null,
  region_nm   VARCHAR2(200) not null,
  parent_cd   NUMBER(20),
  region_type NUMBER(20) not null,
  updt_dt     DATE not null
)
tablespace CS_MASTER_TEST
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
alter table LKP_REGION
  add primary key (REGION_CD)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table LKP_SUBSCRIBE_TABLE
prompt ==================================
prompt
create table LKP_SUBSCRIBE_TABLE
(
  subscribe_table_id   NUMBER(16) not null,
  subscribe_table      VARCHAR2(100) not null,
  subscribe_desc       VARCHAR2(100) not null,
  subscribe_field_list CLOB,
  subscribe_filter     VARCHAR2(800),
  file_nm              VARCHAR2(60),
  stg_table            VARCHAR2(30),
  stg_field_list       CLOB,
  tgt_table            VARCHAR2(30) not null,
  tgt_table_type       INTEGER,
  tgt_field_list       CLOB,
  tgt_logic_pk1        VARCHAR2(300),
  tgt_logic_pk2        VARCHAR2(300),
  tgt_physical_pk      VARCHAR2(200),
  process_type         INTEGER,
  isdel                INTEGER not null,
  updt_dt              TIMESTAMP(6) default systimestamp not null
)
tablespace CS_MASTER_TEST
  pctfree 10
  initrans 1
  maxtrans 255;
alter table LKP_SUBSCRIBE_TABLE
  add constraint PK_LKP_SUBSCRIBE_TABLE primary key (SUBSCRIBE_TABLE_ID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table LKP_WARNING_SCORE
prompt ================================
prompt
create table LKP_WARNING_SCORE
(
  importance    VARCHAR2(10),
  left_bracket  VARCHAR2(10),
  min_val       NUMBER(20,8) not null,
  max_val       NUMBER(20,8) not null,
  right_bracket VARCHAR2(10),
  isdel         INTEGER not null,
  updt_dt       TIMESTAMP(6) not null
)
tablespace USERS
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
comment on table LKP_WARNING_SCORE
  is 'TGT-预警分值映射';
comment on column LKP_WARNING_SCORE.importance
  is '严重程度:3-高 2-中 1-低';
comment on column LKP_WARNING_SCORE.left_bracket
  is '左括号 [  (';
comment on column LKP_WARNING_SCORE.min_val
  is '最小值';
comment on column LKP_WARNING_SCORE.max_val
  is '最大值';
comment on column LKP_WARNING_SCORE.right_bracket
  is '右括号] )';
comment on column LKP_WARNING_SCORE.isdel
  is '是否删除';
comment on column LKP_WARNING_SCORE.updt_dt
  is '更新时间';

prompt
prompt Creating table META_COLUMN
prompt ==========================
prompt
create table META_COLUMN
(
  meta_column_sid NUMBER(20) not null,
  meta_table_sid  NUMBER(20) not null,
  column_enm      VARCHAR2(30) not null,
  column_cnm      VARCHAR2(300) not null,
  column_desc     VARCHAR2(300),
  column_type     VARCHAR2(100),
  column_len      NUMBER(20),
  isreq           NUMBER(20),
  isdisp          NUMBER(20) not null,
  isexp           NUMBER(20) not null,
  updt_dt         DATE not null
)
tablespace CS_MASTER_TEST
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
alter table META_COLUMN
  add primary key (META_COLUMN_SID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table META_TABLE
prompt =========================
prompt
create table META_TABLE
(
  meta_table_sid NUMBER(20) not null,
  table_enm      VARCHAR2(30) not null,
  table_cnm      VARCHAR2(300) not null,
  table_desc     VARCHAR2(300),
  table_type     NUMBER(20) not null,
  isdel          NUMBER(20) not null,
  updt_dt        DATE not null
)
tablespace CS_MASTER_TEST
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
alter table META_TABLE
  add primary key (META_TABLE_SID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table OAUTH_ACCESS_TOKEN
prompt =================================
prompt
create table OAUTH_ACCESS_TOKEN
(
  token_id          VARCHAR2(256),
  token             BLOB,
  authentication_id VARCHAR2(256) not null,
  user_name         VARCHAR2(256),
  client_id         VARCHAR2(256),
  authentication    BLOB,
  refresh_token     VARCHAR2(256)
)
tablespace CS_MASTER_TEST
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
alter table OAUTH_ACCESS_TOKEN
  add primary key (AUTHENTICATION_ID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table OAUTH_APPROVALS
prompt ==============================
prompt
create table OAUTH_APPROVALS
(
  userid         VARCHAR2(256),
  clientid       VARCHAR2(256),
  scope          VARCHAR2(256),
  status         VARCHAR2(10),
  expiresat      DATE,
  lastmodifiedat DATE
)
tablespace CS_MASTER_TEST
  pctfree 10
  initrans 1
  maxtrans 255;

prompt
prompt Creating table OAUTH_CLIENT_DETAILS
prompt ===================================
prompt
create table OAUTH_CLIENT_DETAILS
(
  client_id               VARCHAR2(256) not null,
  resource_ids            VARCHAR2(256),
  client_secret           VARCHAR2(256),
  scope                   VARCHAR2(256),
  authorized_grant_types  VARCHAR2(256),
  web_server_redirect_uri VARCHAR2(256),
  authorities             VARCHAR2(256),
  access_token_validity   NUMBER(20),
  refresh_token_validity  NUMBER(20),
  additional_information  CLOB,
  autoapprove             VARCHAR2(256)
)
tablespace CS_MASTER_TEST
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
alter table OAUTH_CLIENT_DETAILS
  add primary key (CLIENT_ID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table OAUTH_CLIENT_TOKEN
prompt =================================
prompt
create table OAUTH_CLIENT_TOKEN
(
  token_id          VARCHAR2(256),
  token             BLOB,
  authentication_id VARCHAR2(256) not null,
  user_name         VARCHAR2(256),
  client_id         VARCHAR2(256)
)
tablespace CS_MASTER_TEST
  pctfree 10
  initrans 1
  maxtrans 255;
alter table OAUTH_CLIENT_TOKEN
  add primary key (AUTHENTICATION_ID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table OAUTH_CODE
prompt =========================
prompt
create table OAUTH_CODE
(
  code           VARCHAR2(256),
  authentication BLOB
)
tablespace CS_MASTER_TEST
  pctfree 10
  initrans 1
  maxtrans 255;

prompt
prompt Creating table OAUTH_REFRESH_TOKEN
prompt ==================================
prompt
create table OAUTH_REFRESH_TOKEN
(
  token_id       VARCHAR2(256),
  token          BLOB,
  authentication BLOB
)
tablespace CS_MASTER_TEST
  pctfree 10
  initrans 1
  maxtrans 255;

prompt
prompt Creating table PORTFOLIO
prompt ========================
prompt
create table PORTFOLIO
(
  portfolio_id  NUMBER(16) not null,
  name          VARCHAR2(200) not null,
  type          INTEGER not null,
  owner         VARCHAR2(80) not null,
  is_default    INTEGER not null,
  obsolete_dt   TIMESTAMP(6),
  regulation_id NUMBER(16),
  remark        VARCHAR2(1000),
  client_id     NUMBER(16) not null,
  create_dt     TIMESTAMP(6) not null,
  updt_by       NUMBER(16) not null,
  updt_dt       TIMESTAMP(6) not null
)
tablespace CS_MASTER_TEST
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
alter table PORTFOLIO
  add constraint PK_PORTFOLIO primary key (PORTFOLIO_ID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table PORTFOLIO_DISP_FIELD
prompt ===================================
prompt
create table PORTFOLIO_DISP_FIELD
(
  portfolio_disp_field_sid NUMBER(20) not null,
  portfolio_id             NUMBER(20) not null,
  disp_field_id            NUMBER(20) not null,
  updt_dt                  DATE not null
)
tablespace CS_MASTER_TEST
  pctfree 10
  initrans 1
  maxtrans 255;

prompt
prompt Creating table PORTFOLIO_ITEMS
prompt ==============================
prompt
create table PORTFOLIO_ITEMS
(
  id            NUMBER(20) not null,
  portfolio_id  NUMBER(20) not null,
  item_id       NUMBER(20),
  creation_time DATE
)
tablespace CS_MASTER_TEST
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
alter table PORTFOLIO_ITEMS
  add primary key (ID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 80K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table PRIVILEGE
prompt ========================
prompt
create table PRIVILEGE
(
  privilege_id   NUMBER(16) not null,
  privilege_cd   VARCHAR2(60) not null,
  privilege_nm   VARCHAR2(300),
  privilege_type VARCHAR2(100),
  parent_priv_id NUMBER(16),
  isdel          INTEGER,
  updt_by        NUMBER(16) not null,
  updt_dt        TIMESTAMP(6) not null
)
tablespace CS_MASTER_TEST
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
alter table PRIVILEGE
  add constraint PK_PRIVILEGE primary key (PRIVILEGE_ID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table PROCESS_LOG
prompt ==========================
prompt
create table PROCESS_LOG
(
  process_log_sid NUMBER(16) not null,
  process_nm      VARCHAR2(60) not null,
  task_nm         VARCHAR2(60) not null,
  task_typ_id     NUMBER(16) default 1 not null,
  isfailed        INTEGER not null,
  error_desc      VARCHAR2(2000),
  start_dt        DATE,
  end_dt          DATE,
  task_start_dt   DATE,
  task_end_dt     DATE,
  remark          VARCHAR2(2000),
  client_id       NUMBER(16) not null,
  updt_by         NUMBER(16) not null,
  updt_dt         TIMESTAMP(6) not null
)
tablespace CS_MASTER_TEST
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
alter table PROCESS_LOG
  add constraint PK_PROCESS_LOG primary key (PROCESS_LOG_SID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table RATING_ADJUSTMENT_REASON
prompt =======================================
prompt
create table RATING_ADJUSTMENT_REASON
(
  rating_adjustment_reason_id NUMBER(16) not null,
  rating_record_id            NUMBER(16) not null,
  event_id                    VARCHAR2(10) not null,
  event_type_id               NUMBER(16),
  creation_time               TIMESTAMP(6)
)
tablespace CS_MASTER_TEST
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
alter table RATING_ADJUSTMENT_REASON
  add constraint PK_RATING_HIST_ADJ_REASON primary key (RATING_ADJUSTMENT_REASON_ID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 80K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table RATING_APPROV
prompt ============================
prompt
create table RATING_APPROV
(
  rating_approv_sid NUMBER(16) not null,
  rating_record_id  NUMBER(16) not null,
  approval_st       INTEGER not null,
  approval_view     VARCHAR2(2000),
  approvor_id       NUMBER(16) not null,
  approval_dt       DATE,
  updt_by           NUMBER(16) not null,
  updt_dt           TIMESTAMP(6) not null
)
tablespace CS_MASTER_TEST
  pctfree 10
  initrans 1
  maxtrans 255;
alter table RATING_APPROV
  add constraint PK_RATING_APPROV primary key (RATING_APPROV_SID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table RATING_CALC_PD_REF
prompt =================================
prompt
create table RATING_CALC_PD_REF
(
  id            NUMBER(20) not null,
  rm_id         NUMBER(20) not null,
  formular      VARCHAR2(100),
  parameter_a   NUMBER,
  parameter_b   NUMBER,
  row_num       NUMBER(6),
  rms_id        NUMBER(20),
  creation_time DATE
)
tablespace CS_MASTER_TEST
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
alter table RATING_CALC_PD_REF
  add primary key (ID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table RATING_CHANGE_WARNING
prompt ====================================
prompt
create table RATING_CHANGE_WARNING
(
  rating_change_warning_sid NUMBER(16) not null,
  subject_id                NUMBER(16) not null,
  subject_nm                VARCHAR2(300) not null,
  subject_type              INTEGER not null,
  old_rating_dt             DATE,
  old_rating                VARCHAR2(50),
  new_rating_dt             DATE,
  new_rating                VARCHAR2(50),
  warning_title             VARCHAR2(100),
  warning_content           VARCHAR2(1000),
  severity                  INTEGER not null,
  severity_adjusted         INTEGER,
  process_flag              INTEGER not null,
  client_id                 NUMBER(16) not null,
  updt_by                   NUMBER(16) not null,
  updt_dt                   TIMESTAMP(6) default systimestamp not null
)
tablespace CS_MASTER_TEST
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
alter table RATING_CHANGE_WARNING
  add constraint PK_RATING_CHANGE_WARNING primary key (RATING_CHANGE_WARNING_SID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table RATING_DETAIL
prompt ============================
prompt
create table RATING_DETAIL
(
  rating_detail_id          NUMBER(20) not null,
  rating_record_id          NUMBER(20),
  rating_model_sub_model_id NUMBER(20),
  score                     NUMBER,
  new_score                 NUMBER,
  creation_time             DATE
)
tablespace CS_MASTER_TEST
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
alter table RATING_DETAIL
  add primary key (RATING_DETAIL_ID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table RATING_DISPLAY
prompt =============================
prompt
create table RATING_DISPLAY
(
  rating_display_sid NUMBER(16) not null,
  company_id         NUMBER(16) not null,
  final_rating       VARCHAR2(50) not null,
  rating_record_id   INTEGER not null,
  client_id          NUMBER(16) not null,
  updt_by            NUMBER(16) not null,
  updt_dt            TIMESTAMP(6) not null
)
tablespace CS_MASTER_TEST
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
alter table RATING_DISPLAY
  add constraint PK_RATING_DISPLAY primary key (RATING_DISPLAY_SID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table RATING_FACTOR
prompt ============================
prompt
create table RATING_FACTOR
(
  rating_factor_id          NUMBER(16) not null,
  rating_record_id          NUMBER(16) not null,
  rm_factor_id              NUMBER(16) not null,
  factor_val_revised        NUMBER(32,16),
  score                     NUMBER(20,16),
  creation_time             TIMESTAMP(6),
  factor_val                NUMBER(32,16),
  factor_exception_val      NUMBER(32,16),
  factor_exception_rule_sid NUMBER(16),
  factor_missing_cd         NUMBER(16),
  adjustment_comment        VARCHAR2(2000)
)
tablespace CS_MASTER_TEST
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
alter table RATING_FACTOR
  add constraint RATING_HIST_FACTOR_SCORE_PKEY primary key (RATING_FACTOR_ID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table RATING_FACTOR_AJUSTMENT
prompt ======================================
prompt
create table RATING_FACTOR_AJUSTMENT
(
  rating_factor_ajustment_sid NUMBER(16) not null,
  rating_record_id            NUMBER(16) not null,
  ajust_cd                    VARCHAR2(30) not null,
  remark                      VARCHAR2(2000),
  isdel                       INTEGER not null,
  client_id                   NUMBER(16) not null,
  updt_by                     NUMBER(16) not null,
  updt_dt                     TIMESTAMP(6) not null
)
tablespace CS_MASTER_TEST
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
alter table RATING_FACTOR_AJUSTMENT
  add constraint PK_RATING_FACTOR_AJUSTMENT primary key (RATING_FACTOR_AJUSTMENT_SID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table RATING_MASTER_SCALE
prompt ==================================
prompt
create table RATING_MASTER_SCALE
(
  id            NUMBER(16) not null,
  rating        VARCHAR2(30) not null,
  type          VARCHAR2(20) not null,
  mid_pd        NUMBER(20,8),
  max_val       NUMBER(20,8) not null,
  min_val       NUMBER(20,8) not null,
  creation_time TIMESTAMP(6),
  client_id     INTEGER not null,
  isdel         INTEGER not null
)
tablespace CS_MASTER_TEST
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

prompt
prompt Creating table RATING_MASTER_SCALE_FUTURE
prompt =========================================
prompt
create table RATING_MASTER_SCALE_FUTURE
(
  id            NUMBER(20) not null,
  rating        VARCHAR2(4) not null,
  type          VARCHAR2(20) not null,
  mid_pd        NUMBER,
  max_val       NUMBER not null,
  min_val       NUMBER not null,
  creation_time DATE,
  client_id     NUMBER(20) not null,
  isdel         NUMBER(20) not null
)
tablespace CS_MASTER_TEST
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
alter table RATING_MASTER_SCALE_FUTURE
  add primary key (ID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table RATING_MODEL
prompt ===========================
prompt
create table RATING_MODEL
(
  id              NUMBER(16) not null,
  code            VARCHAR2(20) not null,
  name            VARCHAR2(50) not null,
  client_id       NUMBER(16) not null,
  valid_from_date DATE,
  valid_to_date   DATE,
  ms_type         VARCHAR2(50),
  type            VARCHAR2(20) not null,
  version         INTEGER not null,
  is_active       INTEGER not null,
  isdel           INTEGER not null,
  creation_time   TIMESTAMP(6) not null
)
tablespace CS_MASTER_TEST
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
alter table RATING_MODEL
  add constraint RATING_MODEL_PKEY primary key (ID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table RATING_MODEL_EXPOSURE_XW
prompt =======================================
prompt
create table RATING_MODEL_EXPOSURE_XW
(
  rating_model_exposure_sid NUMBER(20) not null,
  model_id                  NUMBER(20),
  exposure_sid              NUMBER(20),
  updt_dt                   DATE
)
tablespace CS_MASTER_TEST
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
alter table RATING_MODEL_EXPOSURE_XW
  add primary key (RATING_MODEL_EXPOSURE_SID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table RATING_MODEL_FACTOR
prompt ==================================
prompt
create table RATING_MODEL_FACTOR
(
  id            NUMBER(16) not null,
  sub_model_id  NUMBER(16) not null,
  ft_code       VARCHAR2(50) not null,
  ratio         NUMBER(10,6),
  calc_param_1  VARCHAR2(50),
  calc_param_2  VARCHAR2(50),
  calc_param_3  VARCHAR2(50),
  calc_param_4  VARCHAR2(50),
  calc_param_5  VARCHAR2(50),
  calc_param_6  VARCHAR2(50),
  calc_param_7  VARCHAR2(50),
  calc_param_8  VARCHAR2(50),
  calc_param_9  VARCHAR2(50),
  calc_param_10 VARCHAR2(50),
  method_type   VARCHAR2(20),
  creation_time TIMESTAMP(6)
)
tablespace CS_MASTER_TEST
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
alter table RATING_MODEL_FACTOR
  add constraint PK_RATING_MODEL_FACTOR primary key (ID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table RATING_MODEL_FACTOR_PARAM_DESC
prompt =============================================
prompt
create table RATING_MODEL_FACTOR_PARAM_DESC
(
  id                 NUMBER(20) not null,
  method_type        VARCHAR2(20) not null,
  calc_param_1_desc  VARCHAR2(50),
  calc_param_2_desc  VARCHAR2(50),
  calc_param_3_desc  VARCHAR2(50),
  calc_param_4_desc  VARCHAR2(50),
  calc_param_5_desc  VARCHAR2(50),
  calc_param_6_desc  VARCHAR2(50),
  calc_param_7_desc  VARCHAR2(50),
  calc_param_8_desc  VARCHAR2(50),
  calc_param_9_desc  VARCHAR2(50),
  calc_param_10_desc VARCHAR2(50),
  creation_time      DATE
)
tablespace CS_MASTER_TEST
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
alter table RATING_MODEL_FACTOR_PARAM_DESC
  add primary key (ID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table RATING_MODEL_SUB_MODEL
prompt =====================================
prompt
create table RATING_MODEL_SUB_MODEL
(
  id            NUMBER(16) not null,
  name          VARCHAR2(50) not null,
  type          VARCHAR2(20) not null,
  parent_rm_id  NUMBER(16) not null,
  ratio         NUMBER(10,6) not null,
  intercept     NUMBER(24,18),
  parameter1    VARCHAR2(200),
  parameter2    VARCHAR2(200),
  parameter3    VARCHAR2(200),
  parameter4    VARCHAR2(200),
  parameter5    VARCHAR2(200),
  parameter6    VARCHAR2(200),
  parameter7    VARCHAR2(200),
  parameter8    VARCHAR2(200),
  parameter9    VARCHAR2(200),
  parameter10   VARCHAR2(200),
  is_base       INTEGER,
  mean_value    NUMBER(38,18),
  sd_value      NUMBER(38,18),
  creation_time TIMESTAMP(6),
  priority      INTEGER not null
)
tablespace CS_MASTER_TEST
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
alter table RATING_MODEL_SUB_MODEL
  add constraint RATING_MODEL_SUB_MODEL_PKEY primary key (ID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table RATING_QUEUE
prompt ===========================
prompt
create table RATING_QUEUE
(
  rating_queue_sid NUMBER(16) not null,
  company_id       NUMBER(16) not null,
  exposure_sid     NUMBER(16) not null,
  latest_run_dt    DATE,
  isfailed         INTEGER,
  failed_num       INTEGER,
  client_id        NUMBER(16) not null,
  updt_dt          TIMESTAMP(6) not null
)
tablespace CS_MASTER_TEST
  pctfree 10
  initrans 1
  maxtrans 255;
alter table RATING_QUEUE
  add constraint PK_RATING_QUEUE primary key (RATING_QUEUE_SID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table RATING_RECORD
prompt ============================
prompt
create table RATING_RECORD
(
  rating_record_id   NUMBER(16) not null,
  company_id         NUMBER(16) not null,
  exposure_sid       NUMBER(16) not null,
  model_id           NUMBER(16) not null,
  factor_dt          DATE not null,
  rpt_timetype_cd    INTEGER,
  rating_start_dt    TIMESTAMP(6) not null,
  rating_affirm_dt   TIMESTAMP(6),
  rating_type        INTEGER,
  total_score        NUMBER(32,16),
  raw_pd             NUMBER(20,16),
  scaling_point      NUMBER(16),
  scaled_pd          NUMBER(20,16),
  scaled_raw_rating  VARCHAR2(50),
  scaled_rating      VARCHAR2(50),
  final_rating       VARCHAR2(50),
  rating_st          INTEGER,
  effect_start_dt    DATE,
  effect_end_dt      DATE,
  client_id          NUMBER(16) not null,
  user_id            NUMBER(16) not null,
  updt_dt            TIMESTAMP(6) not null,
  adjustment_comment CLOB
)
tablespace CS_MASTER_TEST
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
alter table RATING_RECORD
  add constraint PK_RATING_RECORD primary key (RATING_RECORD_ID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table RATING_RECORD_LOG
prompt ================================
prompt
create table RATING_RECORD_LOG
(
  rating_record_log_sid NUMBER(16) not null,
  rating_record_id      NUMBER(16),
  company_id            NUMBER(16) not null,
  isfailed              INTEGER not null,
  error_desc            VARCHAR2(2000),
  start_dt              DATE,
  end_dt                DATE,
  client_id             NUMBER(16) not null,
  updt_by               NUMBER(16) not null,
  updt_dt               TIMESTAMP(6) not null
)
tablespace CS_MASTER_TEST
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
alter table RATING_RECORD_LOG
  add constraint PK_RATING_RECORD_LOG primary key (RATING_RECORD_LOG_SID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table RATING_RECORD_MANUAL
prompt ===================================
prompt
create table RATING_RECORD_MANUAL
(
  company_id         INTEGER,
  exposure_sid       INTEGER,
  company_nm         VARCHAR2(250),
  exposure           VARCHAR2(100),
  factor_dt          INTEGER,
  final_rating       VARCHAR2(50),
  adjustment_level   VARCHAR2(1000),
  adjustment_comment VARCHAR2(4000)
)
tablespace USERS
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

prompt
prompt Creating table RATING_REGULATION
prompt ================================
prompt
create table RATING_REGULATION
(
  rating_regulation_sid NUMBER(16) not null,
  regulation_nm         VARCHAR2(100) not null,
  regulation_type       VARCHAR2(300) not null,
  regulation_desc       VARCHAR2(1000),
  is_active             INTEGER not null,
  client_id             NUMBER(16) not null,
  updt_by               NUMBER(16) not null,
  updt_dt               TIMESTAMP(6) not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
alter table RATING_REGULATION
  add constraint PK_RATING_REGULATION primary key (RATING_REGULATION_SID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table RATING_REGULATION_DETAIL
prompt =======================================
prompt
create table RATING_REGULATION_DETAIL
(
  rating_regulation_detail_sid NUMBER(16) not null,
  rating_regulation_sid        VARCHAR2(100) not null,
  left_bracket                 VARCHAR2(10) not null,
  factor_cd                    VARCHAR2(30),
  cal_sign                     VARCHAR2(10),
  threshold                    NUMBER(32,16) not null,
  right_bracket                VARCHAR2(10),
  cal_logic                    VARCHAR2(100),
  is_active                    INTEGER not null,
  client_id                    NUMBER(16) not null,
  updt_by                      NUMBER(16) not null,
  updt_dt                      TIMESTAMP(6) not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
alter table RATING_REGULATION_DETAIL
  add constraint PK_RATING_REGULATION_DETAIL primary key (RATING_REGULATION_DETAIL_SID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table REGION_FACTOR
prompt ============================
prompt
create table REGION_FACTOR
(
  region_factor_sid NUMBER(16) not null,
  region_cd         NUMBER(16) not null,
  exposure_sid      NUMBER(16) not null,
  factor_cd         VARCHAR2(30) not null,
  factor_value      VARCHAR2(1000),
  selected_option   INTEGER,
  rpt_dt            DATE,
  notice_dt         DATE,
  remark            VARCHAR2(1000),
  isdel             INTEGER,
  client_id         NUMBER(16) not null,
  updt_by           NUMBER(16) not null,
  updt_dt           TIMESTAMP(6) not null
)
tablespace CS_MASTER_TEST
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
alter table REGION_FACTOR
  add constraint PK_REGION_FACTOR primary key (REGION_FACTOR_SID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table REGULATION_FILTER
prompt ================================
prompt
create table REGULATION_FILTER
(
  regulation_id NUMBER(16) not null,
  filter_nm     VARCHAR2(200) not null,
  filter        VARCHAR2(4000) not null,
  filter_desc   VARCHAR2(1000),
  filter_type   INTEGER not null,
  sql_type      INTEGER not null,
  is_public     INTEGER not null,
  is_editable   INTEGER not null,
  client_id     NUMBER(16) not null,
  updt_by       NUMBER(16) not null,
  updt_dt       TIMESTAMP(6) not null
)
tablespace CS_MASTER_TEST
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
alter table REGULATION_FILTER
  add constraint PK_REGULATION_FILTER primary key (REGULATION_ID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table REGULATION_FILTER_DETAIL
prompt =======================================
prompt
create table REGULATION_FILTER_DETAIL
(
  regulation_filter_detail_sid NUMBER(16) not null,
  regulation_id                NUMBER(16) not null,
  condition_cd                 VARCHAR2(30) not null,
  bracket_1                    CHAR(1),
  refer_table                  VARCHAR2(30),
  column_nm                    VARCHAR2(30) not null,
  symbol                       VARCHAR2(10) not null,
  value                        VARCHAR2(300) not null,
  bracket_2                    CHAR(1),
  logic_symbol                 VARCHAR2(10),
  condition_desc               VARCHAR2(600) not null,
  condition_exp                VARCHAR2(600) not null
)
tablespace CS_MASTER_TEST
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
alter table REGULATION_FILTER_DETAIL
  add constraint PK_REGULATION_FILTER_DETAIL primary key (REGULATION_FILTER_DETAIL_SID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 80K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table REPORT_BASICINFO
prompt ===============================
prompt
create table REPORT_BASICINFO
(
  report_id           NUMBER(16) not null,
  report_nm           VARCHAR2(200) not null,
  description         VARCHAR2(1000),
  report_url          VARCHAR2(300) not null,
  report_format       VARCHAR2(300),
  isdel               INTEGER not null,
  updt_by             NUMBER(16),
  updt_dt             TIMESTAMP(6),
  report_template_url VARCHAR2(300),
  sheet_nm            VARCHAR2(600)
)
tablespace USERS
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
comment on table REPORT_BASICINFO
  is '报表基本信息表';
comment on column REPORT_BASICINFO.report_id
  is '报表id';
comment on column REPORT_BASICINFO.report_nm
  is '报表名称';
comment on column REPORT_BASICINFO.description
  is '报表描述说明';
comment on column REPORT_BASICINFO.report_url
  is '报告下载链接';
comment on column REPORT_BASICINFO.report_format
  is '报告支持格式 如有多种格式，逗号分隔，例如：EXCEL,PDF';
comment on column REPORT_BASICINFO.isdel
  is '是否删除';
comment on column REPORT_BASICINFO.updt_by
  is '更新人';
comment on column REPORT_BASICINFO.updt_dt
  is '更新时间';
comment on column REPORT_BASICINFO.report_template_url
  is '报表模板路径';
comment on column REPORT_BASICINFO.sheet_nm
  is '报表sheet名称';
alter table REPORT_BASICINFO
  add constraint PK_REPORT_BASICINFO primary key (REPORT_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 80K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table REPORT_PARAM
prompt ===========================
prompt
create table REPORT_PARAM
(
  report_param_id NUMBER(16) not null,
  report_id       NUMBER(16) not null,
  param_key       VARCHAR2(100) not null,
  param_nm        VARCHAR2(200) not null,
  description     VARCHAR2(1000),
  param_type      INTEGER not null,
  param_order     INTEGER not null,
  isdel           INTEGER not null,
  updt_by         NUMBER(16),
  updt_dt         TIMESTAMP(6)
)
tablespace USERS
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
comment on table REPORT_PARAM
  is '报表参数配置表';
comment on column REPORT_PARAM.report_param_id
  is '主键';
comment on column REPORT_PARAM.report_id
  is '报表id';
comment on column REPORT_PARAM.param_key
  is '参数代码';
comment on column REPORT_PARAM.param_nm
  is '参数展示名称';
comment on column REPORT_PARAM.description
  is '参数含义说明';
comment on column REPORT_PARAM.param_type
  is '参数类型 0：文本； 1：日期';
comment on column REPORT_PARAM.param_order
  is '参数排序 用于页面参数输入框的排序';
comment on column REPORT_PARAM.isdel
  is '是否删除';
comment on column REPORT_PARAM.updt_by
  is '更新人';
comment on column REPORT_PARAM.updt_dt
  is '更新时间';
alter table REPORT_PARAM
  add constraint PK_REPORT_PARAM primary key (REPORT_PARAM_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 80K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table ROLE
prompt ===================
prompt
create table ROLE
(
  role_id   NUMBER(16) not null,
  role_nm   VARCHAR2(300) not null,
  owner_id  NUMBER(16),
  create_by NUMBER(16),
  create_dt TIMESTAMP(6),
  updt_by   NUMBER(16),
  updt_dt   TIMESTAMP(6),
  isdel     INTEGER
)
tablespace CS_MASTER_TEST
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
alter table ROLE
  add constraint PK_ROLE primary key (ROLE_ID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table ROLE_PRIV_XW
prompt ===========================
prompt
create table ROLE_PRIV_XW
(
  role_id      NUMBER(16) not null,
  privilege_id NUMBER(16) not null,
  assign_type  INTEGER default 0 not null,
  create_by    NUMBER(16),
  create_dt    TIMESTAMP(6),
  updt_by      NUMBER(16),
  updt_dt      TIMESTAMP(6)
)
tablespace CS_MASTER_TEST
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
alter table ROLE_PRIV_XW
  add constraint PK_ROLE_PRIV_XW primary key (ROLE_ID, PRIVILEGE_ID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table SECURITY
prompt =======================
prompt
create table SECURITY
(
  secinner_id      NUMBER(16) not null,
  security_cd      VARCHAR2(30) not null,
  security_nm      VARCHAR2(300) not null,
  security_snm     VARCHAR2(200),
  spell            VARCHAR2(80),
  security_type_id NUMBER(16) not null,
  trd_market_id    NUMBER(16) not null,
  company_id       NUMBER(16),
  list_st          INTEGER not null,
  list_dt          DATE,
  end_dt           DATE,
  use_st           INTEGER not null,
  currency         VARCHAR2(6),
  isdel            INTEGER not null,
  src_company_cd   VARCHAR2(60),
  src_secinner_cd  VARCHAR2(30) not null,
  srcid            VARCHAR2(100) not null,
  src_cd           VARCHAR2(10) not null,
  updt_dt          TIMESTAMP(6) not null
)
tablespace CS_MASTER_TEST
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
alter table SECURITY
  add constraint SECURITY_PKEY primary key (SECINNER_ID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table SYSCONFIG
prompt ========================
prompt
create table SYSCONFIG
(
  sysconfig_id      NUMBER(20) not null,
  sysconfig_nm      VARCHAR2(100) not null,
  sysconfig_desc    VARCHAR2(300),
  sysconfig_type_cd NUMBER(11) not null,
  value             VARCHAR2(100),
  value_supp        VARCHAR2(1000),
  is_comm           NUMBER(11),
  is_userconfig     NUMBER(11),
  remark            VARCHAR2(1000),
  isdel             NUMBER(11) not null,
  client_id         NUMBER(20) not null,
  updt_by           NUMBER(20) not null,
  updt_dt           DATE not null
)
tablespace CS_MASTER_TEST
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
alter table SYSCONFIG
  add primary key (SYSCONFIG_ID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table TASK
prompt ===================
prompt
create table TASK
(
  task_sid     NUMBER(16) not null,
  task_nm      VARCHAR2(300) not null,
  workflow_sid NUMBER(16) not null,
  task_type    INTEGER not null,
  context      VARCHAR2(100),
  task_result  INTEGER,
  comment      VARCHAR2(600),
  task_st      INTEGER not null,
  isdel        INTEGER not null,
  assignor     NUMBER(16),
  create_dt    TIMESTAMP(6) not null,
  assignee     NUMBER(16),
  updt_dt      TIMESTAMP(6)
)
tablespace CS_MASTER_TEST
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

prompt
prompt Creating table TASK_ACTION
prompt ==========================
prompt
create table TASK_ACTION
(
  task_action_sid NUMBER(16) not null,
  task_sid        NUMBER(16) not null,
  workflow_sid    NUMBER(16) not null,
  task_type       INTEGER not null,
  task_result     VARCHAR2(1000) not null,
  user_id         NUMBER(16) not null,
  role_nm         VARCHAR2(300) not null,
  rating          VARCHAR2(1000),
  isdel           INTEGER not null,
  client_id       NUMBER(16) not null,
  updt_by         NUMBER(16) not null,
  updt_dt         TIMESTAMP(6) not null,
  remark          CLOB
)
tablespace USERS
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
alter table TASK_ACTION
  add constraint PK_TASK_ACTION primary key (TASK_ACTION_SID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 80K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table TMP_COMPY_WARNINGS
prompt =================================
prompt
create table TMP_COMPY_WARNINGS
(
  company_id      NUMBER,
  company_nm      VARCHAR2(300) not null,
  notice_dt       DATE,
  type_id         NUMBER,
  severity        NUMBER,
  warning_title   VARCHAR2(726),
  warning_content VARCHAR2(726),
  exposure_sid    NUMBER(16),
  exposure        VARCHAR2(100),
  region_cd       NUMBER(20),
  region_nm       VARCHAR2(200),
  rnk             NUMBER
)
tablespace USERS
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

prompt
prompt Creating table USER_ACTIVITY
prompt ============================
prompt
create table USER_ACTIVITY
(
  user_activity_sid NUMBER(16) not null,
  user_id           NUMBER(16) not null,
  start_dt          TIMESTAMP(6) not null,
  end_dt            TIMESTAMP(6),
  ip_addr           VARCHAR2(100),
  operate_type_cd   VARCHAR2(30),
  operate_content   VARCHAR2(1000),
  isfailed          INTEGER not null,
  error_desc        VARCHAR2(2000),
  client_id         NUMBER(16) not null,
  updt_by           NUMBER(16) not null,
  updt_dt           TIMESTAMP(6) not null
)
tablespace CS_MASTER_TEST
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

prompt
prompt Creating table USER_BASICINFO
prompt =============================
prompt
create table USER_BASICINFO
(
  user_id     NUMBER(16) not null,
  user_nm     VARCHAR2(80) not null,
  password    VARCHAR2(80) not null,
  display_nm  VARCHAR2(80),
  display_enm VARCHAR2(80),
  user_gender INTEGER,
  birth       DATE,
  phone       VARCHAR2(30),
  email       VARCHAR2(60),
  wechat      VARCHAR2(30),
  company_nm  VARCHAR2(300),
  client_id   NUMBER(16),
  position_id INTEGER,
  create_dt   TIMESTAMP(6) not null,
  updt_by     INTEGER not null,
  updt_dt     TIMESTAMP(6) not null,
  isdel       INTEGER not null
)
tablespace CS_MASTER_TEST
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
alter table USER_BASICINFO
  add constraint PK_USER_BASICINFO primary key (USER_ID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table USER_ROLE_XW
prompt ===========================
prompt
create table USER_ROLE_XW
(
  user_id   NUMBER(16) not null,
  role_id   NUMBER(16) not null,
  create_by NUMBER(16),
  create_dt TIMESTAMP(6),
  updt_by   NUMBER(16),
  updt_dt   TIMESTAMP(6)
)
tablespace CS_MASTER_TEST
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

prompt
prompt Creating table WARNING_ACTION
prompt =============================
prompt
create table WARNING_ACTION
(
  warning_action_sid NUMBER(16) not null,
  action_cd          VARCHAR2(30) not null,
  action_nm          VARCHAR2(300) not null,
  action_desc        VARCHAR2(1000),
  client_id          NUMBER(16) not null,
  updt_by            NUMBER(16) not null,
  updt_dt            TIMESTAMP(6) not null
)
tablespace CS_MASTER_TEST
  pctfree 10
  initrans 1
  maxtrans 255;
alter table WARNING_ACTION
  add constraint PK_WARNING_ACTION primary key (WARNING_ACTION_SID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table WARNING_REGULATION
prompt =================================
prompt
create table WARNING_REGULATION
(
  warning_regulation_sid NUMBER(16) not null,
  regulation_nm          VARCHAR2(100) not null,
  regulation_type        VARCHAR2(300) not null,
  regulation_desc        VARCHAR2(1000),
  severity               INTEGER,
  warning_score          INTEGER,
  formula                VARCHAR2(2000),
  action_cd              VARCHAR2(50),
  is_active              INTEGER not null,
  client_id              NUMBER(16) not null,
  updt_by                NUMBER(16) not null,
  updt_dt                TIMESTAMP(6) not null
)
tablespace USERS
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
comment on column WARNING_REGULATION.warning_regulation_sid
  is '预警规则流水号';
comment on column WARNING_REGULATION.regulation_nm
  is '预警规则名称';
comment on column WARNING_REGULATION.regulation_type
  is '预警规则类型';
comment on column WARNING_REGULATION.regulation_desc
  is '预警规则描述';
comment on column WARNING_REGULATION.severity
  is '严重程度';
comment on column WARNING_REGULATION.warning_score
  is '信号分值';
comment on column WARNING_REGULATION.formula
  is '公式';
comment on column WARNING_REGULATION.action_cd
  is '预警操作代码';
comment on column WARNING_REGULATION.is_active
  is '是否激活';
comment on column WARNING_REGULATION.client_id
  is '客户标识符';
comment on column WARNING_REGULATION.updt_by
  is '更新人';
comment on column WARNING_REGULATION.updt_dt
  is '更新时间';
alter table WARNING_REGULATION
  add primary key (WARNING_REGULATION_SID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 80K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table WARNING_REGULATION_DETAIL
prompt ========================================
prompt
create table WARNING_REGULATION_DETAIL
(
  warning_regulation_detail_sid NUMBER(16) not null,
  warning_regulation_sid        NUMBER(16) not null,
  bracket_1                     VARCHAR2(10),
  column_nm                     VARCHAR2(2000) not null,
  symbol                        VARCHAR2(10) not null,
  value                         VARCHAR2(100) not null,
  bracket_2                     VARCHAR2(10),
  logic_symbol                  VARCHAR2(100),
  factor_cd                     VARCHAR2(30),
  cal_type                      INTEGER,
  updt_by                       NUMBER(16) not null,
  updt_dt                       TIMESTAMP(6) not null
)
tablespace CS_MASTER_TEST
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
alter table WARNING_REGULATION_DETAIL
  add constraint PK_WARNING_REGULATION_DETAIL primary key (WARNING_REGULATION_DETAIL_SID)
  using index 
  tablespace CS_MASTER_TEST
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 80K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table WORKFLOW
prompt =======================
prompt
create table WORKFLOW
(
  workflow_sid  NUMBER(16) not null,
  workflow_nm   VARCHAR2(300) not null,
  tgt_id        NUMBER(16) not null,
  tgt_nm        VARCHAR2(300) not null,
  context       VARCHAR2(100),
  workflow_type INTEGER not null,
  workflow_st   INTEGER,
  comment       VARCHAR2(600),
  isdel         INTEGER not null,
  client_id     NUMBER(16) not null,
  create_by     NUMBER(16) not null,
  create_dt     TIMESTAMP(6) not null,
  updt_by       NUMBER(16),
  updt_dt       TIMESTAMP(6)
)
tablespace CS_MASTER_TEST
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

prompt
prompt Creating sequence ACT_EVT_LOG_SEQ
prompt =================================
prompt
create sequence ACT_EVT_LOG_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_ACCTING_STRD_ITEM
prompt =======================================
prompt
create sequence SEQ_ACCTING_STRD_ITEM
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_ACCTING_STRD_SUBJECT
prompt ==========================================
prompt
create sequence SEQ_ACCTING_STRD_SUBJECT
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_ATTACHMENT
prompt ================================
prompt
create sequence SEQ_ATTACHMENT
minvalue 1
maxvalue 9999999999999999999999999999
start with 2081
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_BOND_BASICINFO
prompt ====================================
prompt
create sequence SEQ_BOND_BASICINFO
minvalue 1
maxvalue 9999999999999999999999999999
start with 10000000000181
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_BOND_BASICINFO_OLD
prompt ========================================
prompt
create sequence SEQ_BOND_BASICINFO_OLD
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_BOND_CREDITCHG
prompt ====================================
prompt
create sequence SEQ_BOND_CREDITCHG
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_BOND_FACTOR_DATA
prompt ======================================
prompt
create sequence SEQ_BOND_FACTOR_DATA
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_BOND_FACTOR_OPTION
prompt ========================================
prompt
create sequence SEQ_BOND_FACTOR_OPTION
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_BOND_PARTY
prompt ================================
prompt
create sequence SEQ_BOND_PARTY
minvalue 1
maxvalue 9999999999999999999999999999
start with 1001667601
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_BOND_PLEDGE
prompt =================================
prompt
create sequence SEQ_BOND_PLEDGE
minvalue 1
maxvalue 9999999999999999999999999999
start with 1000000321
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_BOND_POOL
prompt ===============================
prompt
create sequence SEQ_BOND_POOL
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_BOND_POOL_ITEM
prompt ====================================
prompt
create sequence SEQ_BOND_POOL_ITEM
minvalue 1
maxvalue 9999999999999999999999999999
start with 1661
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_BOND_POSITION_OUT
prompt =======================================
prompt
create sequence SEQ_BOND_POSITION_OUT
minvalue 1
maxvalue 9999999999999999999999999999
start with 2141
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_BOND_POSITION_OWN
prompt =======================================
prompt
create sequence SEQ_BOND_POSITION_OWN
minvalue 1
maxvalue 9999999999999999999999999999
start with 81
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_BOND_POSITION_STRUCTURED
prompt ==============================================
prompt
create sequence SEQ_BOND_POSITION_STRUCTURED
minvalue 1
maxvalue 9999999999999999999999999999
start with 2121
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_BOND_RATING_APPROV
prompt ========================================
prompt
create sequence SEQ_BOND_RATING_APPROV
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_BOND_RATING_CACUL
prompt =======================================
prompt
create sequence SEQ_BOND_RATING_CACUL
minvalue 1
maxvalue 99999999999999999
start with 434120
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_BOND_RATING_DETAIL
prompt ========================================
prompt
create sequence SEQ_BOND_RATING_DETAIL
minvalue 1
maxvalue 9999999999999999999999999999
start with 454861
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_BOND_RATING_DISPLAY
prompt =========================================
prompt
create sequence SEQ_BOND_RATING_DISPLAY
minvalue 1
maxvalue 9999999999999999999999999999
start with 40101
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_BOND_RATING_FACTOR
prompt ========================================
prompt
create sequence SEQ_BOND_RATING_FACTOR
minvalue 1
maxvalue 9999999999999999999999999999
start with 475861
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_BOND_RATING_MODEL
prompt =======================================
prompt
create sequence SEQ_BOND_RATING_MODEL
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_BOND_RATING_RECORD
prompt ========================================
prompt
create sequence SEQ_BOND_RATING_RECORD
minvalue 1
maxvalue 9999999999999999999999999999
start with 76241
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_BOND_RATING_SCALE_LGD
prompt ===========================================
prompt
create sequence SEQ_BOND_RATING_SCALE_LGD
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_BOND_RATING_SUBMODEL
prompt ==========================================
prompt
create sequence SEQ_BOND_RATING_SUBMODEL
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_BOND_WARRANTOR
prompt ====================================
prompt
create sequence SEQ_BOND_WARRANTOR
minvalue 1
maxvalue 9999999999999999999999999999
start with 200000000000701
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_BOND_WORKFLOW_ABS
prompt =======================================
prompt
create sequence SEQ_BOND_WORKFLOW_ABS
minvalue 1
maxvalue 9999999999999999999999999999
start with 141
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_CLIENT_BASICINFO
prompt ======================================
prompt
create sequence SEQ_CLIENT_BASICINFO
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_COMPY_AFFILPARTY
prompt ======================================
prompt
create sequence SEQ_COMPY_AFFILPARTY
minvalue 1
maxvalue 9999999999999999999999999999
start with 110000000000070
increment by 1
cache 10;

prompt
prompt Creating sequence SEQ_COMPY_BALANCESHEET
prompt ========================================
prompt
create sequence SEQ_COMPY_BALANCESHEET
minvalue 1
maxvalue 9999999999999999999999999999
start with 200000000652201
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_COMPY_BANKADDFIN
prompt ======================================
prompt
create sequence SEQ_COMPY_BANKADDFIN
minvalue 1
maxvalue 9999999999999999999999999999
start with 200000000056081
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_COMPY_BASICINFO
prompt =====================================
prompt
create sequence SEQ_COMPY_BASICINFO
minvalue 1
maxvalue 9999999999999999999999999999
start with 100000121
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_COMPY_CASHFLOW
prompt ====================================
prompt
create sequence SEQ_COMPY_CASHFLOW
minvalue 1
maxvalue 9999999999999999999999999999
start with 200000000937241
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_COMPY_ELEMENT
prompt ===================================
prompt
create sequence SEQ_COMPY_ELEMENT
minvalue 1
maxvalue 9999999999999999999999999999
start with 191621
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_COMPY_EVENT_TYPE
prompt ======================================
prompt
create sequence SEQ_COMPY_EVENT_TYPE
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_COMPY_EXPOSURE
prompt ====================================
prompt
create sequence SEQ_COMPY_EXPOSURE
minvalue 1
maxvalue 9999999999999999999999999999
start with 3621
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_COMPY_FACTOR_FINANCE
prompt ==========================================
prompt
create sequence SEQ_COMPY_FACTOR_FINANCE
minvalue 1
maxvalue 9999999999999999999999999999
start with 7395421
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_COMPY_FACTOR_OPERATION
prompt ============================================
prompt
create sequence SEQ_COMPY_FACTOR_OPERATION
minvalue 1
maxvalue 9999999999999999999999999999
start with 96981
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_COMPY_FINANAUDIT
prompt ======================================
prompt
create sequence SEQ_COMPY_FINANAUDIT
minvalue 1
maxvalue 9999999999999999999999999999
start with 200000000158461
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_COMPY_INCOMESTATE
prompt =======================================
prompt
create sequence SEQ_COMPY_INCOMESTATE
minvalue 1
maxvalue 9999999999999999999999999999
start with 200000000989521
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_COMPY_INDUSTRY
prompt ====================================
prompt
create sequence SEQ_COMPY_INDUSTRY
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_COMPY_INSURERINDEX
prompt ========================================
prompt
create sequence SEQ_COMPY_INSURERINDEX
minvalue 1
maxvalue 9999999999999999999999999999
start with 200000000000541
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_COMPY_RATING_LIST
prompt =======================================
prompt
create sequence SEQ_COMPY_RATING_LIST
minvalue 1
maxvalue 9999999999999999999999999999
start with 24621
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_COMPY_REGION
prompt ==================================
prompt
create sequence SEQ_COMPY_REGION
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_COMPY_SECRISKINDEX
prompt ========================================
prompt
create sequence SEQ_COMPY_SECRISKINDEX
minvalue 1
maxvalue 9999999999999999999999999999
start with 200000000007441
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_COMPY_TOP5CUST
prompt ====================================
prompt
create sequence SEQ_COMPY_TOP5CUST
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_COMPY_TOP5SUPP
prompt ====================================
prompt
create sequence SEQ_COMPY_TOP5SUPP
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_COMPY_WARNINGS
prompt ====================================
prompt
create sequence SEQ_COMPY_WARNINGS
minvalue 1
maxvalue 9999999999999999999999999999
start with 50881
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_ETL_DM_LOADLOG
prompt ====================================
prompt
create sequence SEQ_ETL_DM_LOADLOG
minvalue 1
maxvalue 9999999999999999999999999999
start with 241
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_ETL_EXP_LOADLOG
prompt =====================================
prompt
create sequence SEQ_ETL_EXP_LOADLOG
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_EXPOSURE
prompt ==============================
prompt
create sequence SEQ_EXPOSURE
minvalue 1
maxvalue 9999999999999999999999999999
start with 181
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_EXPOSURE_FACTOR_AJUST_XW
prompt ==============================================
prompt
create sequence SEQ_EXPOSURE_FACTOR_AJUST_XW
minvalue 1
maxvalue 9999999999999999999999999999
start with 101
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_EXPOSURE_FACTOR_XW
prompt ========================================
prompt
create sequence SEQ_EXPOSURE_FACTOR_XW
minvalue 1
maxvalue 9999999999999999999999999999
start with 121
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_FACTOR_AJUSTMENT
prompt ======================================
prompt
create sequence SEQ_FACTOR_AJUSTMENT
minvalue 1
maxvalue 9999999999999999999999999999
start with 101
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_FACTOR_CHANGE_WARNING
prompt ===========================================
prompt
create sequence SEQ_FACTOR_CHANGE_WARNING
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_FACTOR_ELEMENT_XW
prompt =======================================
prompt
create sequence SEQ_FACTOR_ELEMENT_XW
minvalue 1
maxvalue 9999999999999999999999999999
start with 261
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_FACTOR_OPERATION_ELEMENT
prompt ==============================================
prompt
create sequence SEQ_FACTOR_OPERATION_ELEMENT
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_FACTOR_OPTION
prompt ===================================
prompt
create sequence SEQ_FACTOR_OPTION
minvalue 1
maxvalue 9999999999999999999999999999
start with 81
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_INDUSTRY
prompt ==============================
prompt
create sequence SEQ_INDUSTRY
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_INDUSTRY_FACTOR_FINAN_XW
prompt ==============================================
prompt
create sequence SEQ_INDUSTRY_FACTOR_FINAN_XW
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_INDUSTRY_FACTOR_OPER_XW
prompt =============================================
prompt
create sequence SEQ_INDUSTRY_FACTOR_OPER_XW
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_INVESTMENT_LIMIT
prompt ======================================
prompt
create sequence SEQ_INVESTMENT_LIMIT
minvalue 1
maxvalue 9999999999999999999999999999
start with 2541
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_LKP_FINANELEMENT
prompt ======================================
prompt
create sequence SEQ_LKP_FINANELEMENT
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_LKP_FINANSUBJECT_DISP
prompt ===========================================
prompt
create sequence SEQ_LKP_FINANSUBJECT_DISP
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_LKP_SUBSCRIBE_TABLE
prompt =========================================
prompt
create sequence SEQ_LKP_SUBSCRIBE_TABLE
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_PORTFOLIO
prompt ===============================
prompt
create sequence SEQ_PORTFOLIO
minvalue 1
maxvalue 9999999999999999999999999999
start with 601
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_PORTFOLIO_DISP_FIELD
prompt ==========================================
prompt
create sequence SEQ_PORTFOLIO_DISP_FIELD
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_PORTFOLIO_FILTER_DETAIL
prompt =============================================
prompt
create sequence SEQ_PORTFOLIO_FILTER_DETAIL
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_PORTFOLIO_ITEMS
prompt =====================================
prompt
create sequence SEQ_PORTFOLIO_ITEMS
minvalue 1
maxvalue 9999999999999999999999999999
start with 21661
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_PRIVILEGE
prompt ===============================
prompt
create sequence SEQ_PRIVILEGE
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_PRIVILEGE_RESOURCE
prompt ========================================
prompt
create sequence SEQ_PRIVILEGE_RESOURCE
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_PROCESS_LOG
prompt =================================
prompt
create sequence SEQ_PROCESS_LOG
minvalue 1
maxvalue 9999999999999999999999999999
start with 5855061
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_RATING_APPROV
prompt ===================================
prompt
create sequence SEQ_RATING_APPROV
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_RATING_CALC_PD_REF
prompt ========================================
prompt
create sequence SEQ_RATING_CALC_PD_REF
minvalue 1
maxvalue 9999999999999999999999999999
start with 141
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_RATING_CHANGE_WARNING
prompt ===========================================
prompt
create sequence SEQ_RATING_CHANGE_WARNING
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_RATING_DISPLAY
prompt ====================================
prompt
create sequence SEQ_RATING_DISPLAY
minvalue 1
maxvalue 9999999999999999999999999999
start with 8961
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_RATING_FACTOR_AJUSTMENT
prompt =============================================
prompt
create sequence SEQ_RATING_FACTOR_AJUSTMENT
minvalue 1
maxvalue 9999999999999999999999999999
start with 61
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_RATING_HIST
prompt =================================
prompt
create sequence SEQ_RATING_HIST
minvalue 1
maxvalue 9999999999999999999999999999
start with 15721
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_RATING_HIST_DETAIL
prompt ========================================
prompt
create sequence SEQ_RATING_HIST_DETAIL
minvalue 1
maxvalue 9999999999999999999999999999
start with 24241
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_RATING_HIST_FACTOR_SCORE
prompt ==============================================
prompt
create sequence SEQ_RATING_HIST_FACTOR_SCORE
minvalue 1
maxvalue 9999999999999999999999999999
start with 139981
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_RATING_MASTER_SCALE
prompt =========================================
prompt
create sequence SEQ_RATING_MASTER_SCALE
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_RATING_MODEL
prompt ==================================
prompt
create sequence SEQ_RATING_MODEL
minvalue 1
maxvalue 9999999999999999999999999999
start with 141
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_RATING_MODEL_EXPOSURE_XW
prompt ==============================================
prompt
create sequence SEQ_RATING_MODEL_EXPOSURE_XW
minvalue 1
maxvalue 9999999999999999999999999999
start with 141
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_RATING_MODEL_FACTOR
prompt =========================================
prompt
create sequence SEQ_RATING_MODEL_FACTOR
minvalue 1
maxvalue 9999999999999999999999999999
start with 501
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_RATING_MODEL_SUB_MODEL
prompt ============================================
prompt
create sequence SEQ_RATING_MODEL_SUB_MODEL
minvalue 1
maxvalue 9999999999999999999999999999
start with 181
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_RATING_QUEUE
prompt ==================================
prompt
create sequence SEQ_RATING_QUEUE
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_RATING_RECORD_ADJUSTMENT
prompt ==============================================
prompt
create sequence SEQ_RATING_RECORD_ADJUSTMENT
minvalue 1
maxvalue 9223372036854775807
start with 348353
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_RATING_RECORD_LOG
prompt =======================================
prompt
create sequence SEQ_RATING_RECORD_LOG
minvalue 1
maxvalue 9999999999999999999999999999
start with 1501
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_RATING_SCORECARD_REF
prompt ==========================================
prompt
create sequence SEQ_RATING_SCORECARD_REF
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_REGION_FACTOR
prompt ===================================
prompt
create sequence SEQ_REGION_FACTOR
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_REGULATION_FILTER
prompt =======================================
prompt
create sequence SEQ_REGULATION_FILTER
minvalue 1
maxvalue 9999999999999999999999999999
start with 541
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_REGULATION_FILTER_DETAIL
prompt ==============================================
prompt
create sequence SEQ_REGULATION_FILTER_DETAIL
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_REPORT_BASICINFO
prompt ======================================
prompt
create sequence SEQ_REPORT_BASICINFO
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 10;

prompt
prompt Creating sequence SEQ_REPORT_PARAM
prompt ==================================
prompt
create sequence SEQ_REPORT_PARAM
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 10;

prompt
prompt Creating sequence SEQ_ROLE
prompt ==========================
prompt
create sequence SEQ_ROLE
minvalue 1
maxvalue 9999999999999999999999999999
start with 301
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_SECURITY
prompt ==============================
prompt
create sequence SEQ_SECURITY
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_SYSCONFIG
prompt ===============================
prompt
create sequence SEQ_SYSCONFIG
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TASK
prompt ==========================
prompt
create sequence SEQ_TASK
minvalue 1
maxvalue 9999999999999999999999999999
start with 5121
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TASK_ACTION
prompt =================================
prompt
create sequence SEQ_TASK_ACTION
minvalue 1
maxvalue 9999999999999999999999999999
start with 2701
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_TEST
prompt ==========================
prompt
create sequence SEQ_TEST
minvalue 1
maxvalue 9999999999999999999999999999
start with 21
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_USER_ACTIVITY
prompt ===================================
prompt
create sequence SEQ_USER_ACTIVITY
minvalue 1
maxvalue 9999999999999999999999999999
start with 28021
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_USER_BASICINFO
prompt ====================================
prompt
create sequence SEQ_USER_BASICINFO
minvalue 1
maxvalue 9999999999999999999999999999
start with 721
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_WARNINGS
prompt ==============================
prompt
create sequence SEQ_WARNINGS
minvalue 1
maxvalue 9999999999999999999999999999
start with 9421
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_WARNING_ACTION
prompt ====================================
prompt
create sequence SEQ_WARNING_ACTION
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_WARNING_REGULATION
prompt ========================================
prompt
create sequence SEQ_WARNING_REGULATION
minvalue 1
maxvalue 9999999999999999999999999999
start with 201
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_WARNING_REGULATION_DETAIL
prompt ===============================================
prompt
create sequence SEQ_WARNING_REGULATION_DETAIL
minvalue 1
maxvalue 9999999999999999999999999999
start with 341
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_WORKFLOW
prompt ==============================
prompt
create sequence SEQ_WORKFLOW
minvalue 1
maxvalue 9999999999999999999999999999
start with 15181
increment by 1
cache 20;

prompt
prompt Creating synonym FN_BOND_POSITION
prompt =================================
prompt
create or replace synonym FN_BOND_POSITION
  for CS_MASTER_TEST.SP_BOND_POSITION;

prompt
prompt Creating synonym FN_COMPY_FINANCE
prompt =================================
prompt
create or replace synonym FN_COMPY_FINANCE
  for CS_MASTER_TEST.SP_COMPY_FINANCE;

prompt
prompt Creating synonym FN_COMPY_WARNINGS
prompt ==================================
prompt
create or replace synonym FN_COMPY_WARNINGS
  for CS_MASTER_TEST.SP_COMPY_WARNINGS;

prompt
prompt Creating synonym FN_DROP_IF_EXIST
prompt =================================
prompt
create or replace synonym FN_DROP_IF_EXIST
  for CS_MASTER_TEST.SP_DROP_IF_EXIST;

prompt
prompt Creating synonym FN_REFRESH_MATVIEWS
prompt ====================================
prompt
create or replace synonym FN_REFRESH_MATVIEWS
  for CS_MASTER_TEST.SP_REFRESH_MATVIEWS;

prompt
prompt Creating synonym FN_SUBSCRIBE_TABLE
prompt ===================================
prompt
create or replace synonym FN_SUBSCRIBE_TABLE
  for CS_MASTER_TEST.SP_SUBSCRIBE_TABLE;

prompt
prompt Creating view INDUSTRY_VIEWER
prompt =============================
prompt
CREATE OR REPLACE FORCE VIEW INDUSTRY_VIEWER AS
SELECT
    a.id1,
    a.code1,
    a.name1,
    a.parent_ind_sid1,
    b.id2,
    b.code2,
    b.name2,
    b.parent_ind_sid2,
    c.id3,
    c.code3,
    c.name3,
    c.parent_ind_sid3
FROM
    (
        SELECT
            t.id             AS id1,
            t.code           AS code1,
            t.name           AS name1,
            t.parent_ind_sid AS parent_ind_sid1
        FROM
            industry t
        WHERE
            t.system_cd = 1018
        AND t.industry_level = 1) a
LEFT JOIN
    (
        SELECT
            t.id             AS id2,
            t.code           AS code2,
            t.name           AS name2,
            t.parent_ind_sid AS parent_ind_sid2
        FROM
            industry t
        WHERE
            t.system_cd = 1018
        AND t.industry_level = 2) b
ON
    b.parent_ind_sid2 = a.id1
LEFT JOIN
    (
        SELECT
            t.id             AS id3,
            t.code           AS code3,
            t.name           AS name3,
            t.parent_ind_sid AS parent_ind_sid3
        FROM
            industry t
        WHERE
            t.system_cd = 1018
        AND t.industry_level = 3) c
ON
    c.parent_ind_sid3 = b.id2;

prompt
prompt Creating view VW_BOND_ISSUER
prompt ============================
prompt
CREATE OR REPLACE FORCE VIEW VW_BOND_ISSUER AS
SELECT a.secinner_id,
    a.bond_party_sid,
    a.party_id AS issuer_id,
    b.company_nm AS issuer_nm
   FROM (SELECT a_1.secinner_id,
			b_1.bond_party_sid,
			COALESCE(b_1.party_id, d.company_id) AS party_id
		FROM bond_basicinfo a_1
         LEFT JOIN ( SELECT  b_1_1.bond_party_sid,
							b_1_1.party_id,
							b_1_1.secinner_id
					FROM bond_party b_1_1
					JOIN lkp_charcode c 
					ON b_1_1.party_type_id = c.constant_id 
					AND c.constant_type = 209 
					AND c.constant_nm in ('联合债务人', '债务人', '发起人') 
					AND b_1_1.isdel = 0 AND c.isdel = 0
					AND (b_1_1.end_dt is null or b_1_1.end_dt>=sysdate)
				 ) b_1 ON a_1.secinner_id = b_1.secinner_id
         LEFT JOIN security d ON a_1.secinner_id = d.secinner_id AND d.isdel = 0
		WHERE a_1.isdel = 0
		) a
		LEFT JOIN compy_basicinfo b ON a.party_id = b.company_id AND b.is_del = 0;

prompt
prompt Creating view VW_BOND_POSITION_ISSUER
prompt =====================================
prompt
CREATE OR REPLACE FORCE VIEW VW_BOND_POSITION_ISSUER AS
SELECT a.issuer_id
  FROM vw_bond_issuer a
  JOIN  bond_position b
    ON a.secinner_id = b.secinner_id
   AND b.isdel = 0;

prompt
prompt Creating view VW_BOND_RATING_CACUL
prompt ==================================
prompt
CREATE OR REPLACE FORCE VIEW VW_BOND_RATING_CACUL AS
WITH client AS (
         SELECT DISTINCT client_basicinfo.client_id
           FROM client_basicinfo
        ), 
		rating_cd1 AS (
         SELECT a.constant_id,
            a.constant_nm AS ratingcd_nm,
            a.constant_type
           FROM lkp_charcode a
          WHERE a.constant_type in (211,212,213,214,215) AND a.isdel = 0
        ),
		rating_cd2 AS (
         SELECT a.constant_id,
            a.constant_nm,
            b.ratingcd_nm,
            a.constant_type
           FROM lkp_charcode a
             JOIN lkp_ratingcd_xw b ON a.constant_nm= b.constant_nm
          WHERE a.constant_type in (201, 207) AND a.isdel = 0
        ), 
		rating_cd_region AS (
         SELECT a.region_cd,
            a.region_nm,
            b.ratingcd_nm
           FROM lkp_region a
             JOIN lkp_ratingcd_xw b ON substr(a.region_nm, 1, 2) = substr(b.constant_nm , 1, 2) AND a.parent_cd IS NULL and b.constant_type=6
        ), 
		rating_cd_industry AS (
         SELECT a.exposure_sid,
            a.exposure,
            b.ratingcd_nm
           FROM exposure a
            JOIN lkp_ratingcd_xw b ON a.exposure= b.constant_nm and constant_type=5
			where a.isdel=0
        )
 SELECT row_number()over(order by null) AS bond_rating_cacul_sid, 
    a.secinner_id,
    a.security_cd,
    a.security_nm,
    d.party_id AS company_id,
    m.company_nm,
    p.factor_dt,
    e.ratingcd_nm AS bond_type,
    coalesce(chg.remain_vol/10000,a.issue_vol) as remain_vol,
    lkpOrgnature.constant_nm AS corp_nature,
    r2.ratingcd_nm AS credit_region,
    l.ratingcd_nm AS industry,
    l.exposure,
    b.bond_pledge_sid,
    b.pledge_nm,
    h.ratingcd_nm AS pledge_type,
    i.ratingcd_nm AS pledge_control,
    j.ratingcd_nm AS pledge_depend,
    b.pledge_value,
    b.priority_value,
    r1.ratingcd_nm AS pledge_region,
    c.bond_warrantor_sid,
    c.warrantor_nm,
    f.ratingcd_nm AS guarantee_type,
    n.ratingcd_nm AS warrantor_type,
    o.ratingcd_nm AS warranty_strength,
    p.final_rating AS warrantor_rating,
    c.warranty_amt AS warranty_value,
    t.client_id
   FROM bond_basicinfo a
     JOIN client t ON 1 = 1
	 LEFT JOIN (select a.secinner_id,
	                   a.remain_vol,
					   row_number()over(partition by a.secinner_id order by a.change_dt desc) as rnk					   
	            from bond_opvolchg  a
				join lkp_charcode b on a.chg_type_id=b.constant_id and b.constant_type=45 and b.constant_nm in ('债券偿付本金','回售','到期','赎回')
				where a.change_dt is not null and a.change_dt<=systimestamp	and a.isdel=0			
				)chg on a.secinner_id=chg.secinner_id and rnk=1
     LEFT JOIN ( SELECT x.secinner_id,x.party_id
				 FROM bond_party x
				 JOIN lkp_charcode y 
				 ON x.party_type_id = y.constant_id AND y.constant_type = 209
				 AND y.constant_nm  in ('债务人', '联合债务人', '发起人') 
				)d ON a.secinner_id = d.secinner_id
     LEFT JOIN compy_basicinfo m ON d.party_id = m.company_id
     LEFT JOIN bond_pledge b ON a.secinner_id = b.secinner_id AND b.isdel = 0
     LEFT JOIN ( SELECT bond_warrantor_sid,
						secinner_id,
						warrantor_id,
						warrantor_nm,
						warrantor_type_id,
						guarantee_type_id,
						warranty_strength_id,
						warranty_amt,
						row_number() OVER (PARTITION BY secinner_id, warrantor_nm ORDER BY src_updt_dt DESC NULLS LAST, notice_dt DESC NULLS LAST) AS row_num
				FROM bond_warrantor
				WHERE isdel = 0
				)c ON a.secinner_id = c.secinner_id AND c.row_num = 1
     LEFT JOIN rating_cd2 e ON a.security_type_id = e.constant_id
	 LEFT JOIN compy_bondissuer bdissuer on d.party_id=bdissuer.company_id and bdissuer.isdel=0
	 LEFT JOIN lkp_charcode lkpOrgnature ON bdissuer.org_nature_id=lkpOrgnature.constant_id and lkpOrgnature.constant_type=46 and lkpOrgnature.isdel=0
	 LEFT JOIN rating_cd_region r2 ON bdissuer.region = r2.region_cd
     LEFT JOIN rating_cd1 h ON b.pledge_type_id = h.constant_id
     LEFT JOIN rating_cd1 i ON b.pledge_control_id = i.constant_id
     LEFT JOIN rating_cd1 j ON b.pledge_depend_id = j.constant_id
     LEFT JOIN rating_cd_region r1 ON b.region = r1.region_cd
     LEFT JOIN (SELECT a.company_id,
						a.client_id,
						b.ratingcd_nm,
						b.exposure
				FROM compy_exposure a
				JOIN rating_cd_industry b 
				ON a.exposure_sid = b.exposure_sid
				where a.isdel=0 and a.is_new=1
				) l ON coalesce(d.party_id,bdissuer.company_id) = l.company_id AND l.client_id = t.client_id
     LEFT JOIN rating_cd2 f ON c.guarantee_type_id = f.constant_id
     LEFT JOIN rating_cd1 n ON c.warrantor_type_id = n.constant_id
     LEFT JOIN rating_cd1 o ON c.warranty_strength_id = o.constant_id
     LEFT JOIN (SELECT 	company_id,
						client_id,
						factor_dt,
						final_rating,
						row_number() OVER (PARTITION BY company_id, client_id ORDER BY factor_dt DESC, rating_start_dt DESC) AS row_num
				FROM rating_record
				where rating_type=2 and RATING_ST=1
				) p ON c.warrantor_id = p.company_id AND p.row_num = 1 AND p.client_id = t.client_id
  WHERE a.isdel = 0;

prompt
prompt Creating view VW_COMPANY_EXPOSURE_XW
prompt ====================================
prompt
CREATE OR REPLACE FORCE VIEW VW_COMPANY_EXPOSURE_XW AS
SELECT c.company_id,
       c.company_nm       AS company_name,
       c.blnumb,
       i.exposure_sid,
       i.exposure,
       cb.sum_asset,
       cb.company_type,
       rh.final_rating,
       rh.rating_start_dt AS rating_dt,
       rh.factor_dt,
       i.client_id
  FROM compy_basicinfo c
  JOIN compy_exposure ci
    on ci.company_id = c.company_id
   AND ci.is_new = 1
   AND ci.isdel = 0
  JOIN exposure i
    ON i.exposure_sid = ci.exposure_sid
  LEFT JOIN (SELECT sum_asset,
                    company_type,
                    company_id,
                    row_number() OVER(PARTITION BY company_id ORDER BY rpt_dt DESC) AS rn
               FROM compy_balancesheet
              WHERE isdel = 0) cb
    ON cb.company_id = c.company_id
   AND cb.rn = 1
  LEFT JOIN (SELECT b.factor_dt,
                    a.company_id,
                    a.final_rating,
                    b.rating_start_dt
               FROM rating_display a
               JOIN rating_record b
                 ON a.rating_record_id = b.rating_record_id) rh
    ON c.company_id = rh.company_id;

prompt
prompt Creating view VW_COMPY_CREDITRATING_LATEST
prompt ==========================================
prompt
CREATE OR REPLACE FORCE VIEW VW_COMPY_CREDITRATING_LATEST AS
WITH
    rating_code_list AS
    (
          SELECT 1 AS rating_rnk,
               'AAA+' AS rating_code,
               'AAA1' AS rating_code_moody
          from dual
        UNION ALL
        SELECT 2 AS rating_rnk,
               'AAA' AS rating_code,
               'AAA2' AS rating_code_moody
          from dual
        UNION ALL
        SELECT 3 AS rating_rnk,
               'AAA-' AS rating_code,
               'AAA3' AS rating_code_moody
          from dual
        UNION ALL
        SELECT 4 AS rating_rnk,
               'AA+' AS rating_code,
               'AA1' AS rating_code_moody
          from dual
        UNION ALL
        SELECT 5 AS rating_rnk,
               'AA' AS rating_code,
               'AA2' AS rating_code_moody
          from dual
        UNION ALL
        SELECT 6 AS rating_rnk,
               'AA-' AS rating_code,
               'AA3' AS rating_code_moody
          from dual
        UNION ALL
        SELECT 7 AS rating_rnk,
               'A+' AS rating_code,
               'A1' AS rating_code_moody
          from dual
        UNION ALL
        SELECT 8 AS rating_rnk,
               'A' AS rating_code,
               'A2' AS rating_code_moody
          from dual
        UNION ALL
        SELECT 9 AS rating_rnk,
               'A-' AS rating_code,
               'A3' AS rating_code_moody
          from dual
        UNION ALL
        SELECT 10 AS rating_rnk,
               'BBB+' AS rating_code,
               'BAA1' AS rating_code_moody
          from dual
        UNION ALL
        SELECT 11 AS rating_rnk,
               'BBB' AS rating_code,
               'BAA2' AS rating_code_moody
          from dual
        UNION ALL
        SELECT 12 AS rating_rnk,
               'BBB-' AS rating_code,
               'BAA3' AS rating_code_moody
          from dual
        UNION ALL
        SELECT 13 AS rating_rnk,
               'BB+' AS rating_code,
               'BA1' AS rating_code_moody
          from dual
        UNION ALL
        SELECT 14 AS rating_rnk,
               'BB' AS rating_code,
               'BA2' AS rating_code_moody
          from dual
        UNION ALL
        SELECT 15 AS rating_rnk,
               'BB-' AS rating_code,
               'BA3' AS rating_code_moody
          from dual
        UNION ALL
        SELECT 16 AS rating_rnk,
               'B+' AS rating_code,
               'B1' AS rating_code_moody
          from dual
        UNION ALL
        SELECT 17 AS rating_rnk,
               'B' AS rating_code,
               'B2' AS rating_code_moody
          from dual
        UNION ALL
        SELECT 18 AS rating_rnk,
               'B-' AS rating_code,
               'B3' AS rating_code_moody
          from dual
        UNION ALL
        SELECT 19 AS rating_rnk,
               'CCC+' AS rating_code,
               'CAA1' AS rating_code_moody
          from dual
        UNION ALL
        SELECT 20 AS rating_rnk,
               'CCC' AS rating_code,
               'CAA2' AS rating_code_moody
          from dual
        UNION ALL
        SELECT 21 AS rating_rnk,
               'CCC-' AS rating_code,
               'CAA3' AS rating_code_moody
          from dual
        UNION ALL
        SELECT 22 AS rating_rnk,
               'CC' AS rating_code,
               'CA' AS rating_code_moody
          from dual
        UNION ALL
        SELECT 23 AS rating_rnk,
               'C' AS rating_code,
               'C' AS rating_code_moody
          from dual
        UNION ALL
        SELECT 24 AS rating_rnk,
               'D' AS rating_code,
               'D' AS rating_code_moody
          from dual
    )
  SELECT b.company_id,
         e.company_nm,
         x.exposure_cd,
         x.model_code,
         x.factor_dt,
         x.user_nm,
         x.qual_score,
         x.quan_score,
         x.total_score,
         f.rating_rnk AS final_rating_rnk,
         trim(x.final_rating) AS final_rating,
         x.scaled_pd,
         x.adjustment_comment,
         x.creation_time,
         v.rating_dt,
         g.rating_rnk,
         v.rating,
         v.credit_org_id,
         v.credit_org_nm,
         b.exposure_sid,
         b.exposure,
         d.region_cd,
         d.region_nm,
         y.sum_asset,
         to_date(y.rpt_dt, 'YYYYMMDD') AS rpt_dt,
         x.client_id
    FROM compy_basicinfo e
    LEFT JOIN (SELECT a.company_id,
                      a.exposure_sid,
                      c.exposure,
                      row_number() OVER(PARTITION BY a.company_id ORDER BY a.start_dt DESC) AS rnk
                 FROM compy_exposure a
                 JOIN exposure c
                   ON a.exposure_sid = c.exposure_sid) b
      ON b.company_id = e.company_id
     AND b.rnk = 1
    LEFT JOIN lkp_region d
      ON e.region = d.region_cd
    LEFT JOIN (SELECT a.company_id,
                      e_1.exposure_cd,
                      c."CODE" AS model_code,
                      a.factor_dt,
                      d_1.display_nm AS user_nm,
                      b_1.qual_score,
                      b_1.quan_score,
                      a.total_score,
                      a.final_rating,
                      a.scaled_pd,
                      a.adjustment_comment,
                      a.rating_start_dt AS creation_time,
                      a.client_id,
                      row_number() OVER(PARTITION BY a.company_id ORDER BY a.rating_start_dt DESC) AS rnk
                 FROM rating_record a
                 JOIN (SELECT a_1.rating_record_id AS rating_hist_id,
                             MAX(CASE
                                   WHEN b_2.type = 'DISCRETE' THEN
                                    a_1.score
                                   ELSE
                                    0
                                 END) AS qual_score,
                             MAX(CASE
                                   WHEN b_2.type in
                                        ('CONTINUOUS', 'DISCRETE_QUAN') THEN
                                    a_1.score
                                   ELSE
                                    0
                                 END) AS quan_score
                        FROM rating_detail a_1
                        JOIN rating_model_sub_model b_2
                          ON a_1.rating_model_sub_model_id = b_2.id
                       GROUP BY a_1.rating_record_id) b_1
                   ON a.rating_record_id = b_1.rating_hist_id
                 JOIN rating_model c
                   ON a.model_id = c."ID"
                 JOIN user_basicinfo d_1
                   ON a.user_id = d_1.user_id
                 JOIN exposure e_1
                   ON a.exposure_sid = e_1.exposure_sid
                WHERE a.rating_st = 1) x
      ON b.company_id = x.company_id
     AND x.rnk = 1
    LEFT JOIN (SELECT a.company_id,
                      a.rating_dt,
                      a.rating,
                      a.credit_org_id,
                      b_1.company_nm AS credit_org_nm,
                      row_number() OVER(PARTITION BY a.company_id ORDER BY a.rating_dt DESC, a.compy_creditrating_sid DESC) AS rnk
                 FROM compy_creditrating a
                 LEFT JOIN compy_basicinfo b_1
                   ON a.credit_org_id = b_1.company_id
                  AND b_1.is_del = 0
                WHERE a.isdel = 0 and nvl(b_1.company_nm,' ')<>'中国证券监督管理委员会') v
      ON b.company_id = v.company_id
     AND v.rnk = 1
    LEFT JOIN rating_code_list f
      ON (x.final_rating = f.rating_code OR x.final_rating = f.rating_code_moody)
    LEFT JOIN rating_code_list g
      ON (v.rating = g.rating_code OR v.rating = g.rating_code_moody)
    LEFT JOIN (SELECT company_id,
                      sum_asset,
                      rpt_dt,
                      row_number() OVER(PARTITION BY company_id ORDER BY rpt_dt DESC) AS rnk
                 FROM compy_balancesheet
                WHERE rpt_timetype_cd = 1
                  AND combine_type_cd = 1
                  AND data_ajust_type = 2) y
      ON b.company_id = y.company_id
     AND y.rnk = 1;

prompt
prompt Creating view VW_COMPY_ELEMENT
prompt ==============================
prompt
CREATE OR REPLACE FORCE VIEW VW_COMPY_ELEMENT AS
SELECT company_id,
       element_cd,
       CAST(element_value AS VARCHAR2(2000)) AS element_value,
       element_src,
       element_desc,
       rpt_dt,
       CASE TO_CHAR(rpt_dt, 'MM')
         WHEN '03' THEN
          3
         WHEN '06' THEN
          2
         WHEN '09' THEN
          4
         WHEN '12' THEN
          1
         ELSE
          -1
       END AS rpt_timetype_cd,
       isdel,
       client_id,
       updt_by,
       updt_dt
  FROM compy_element
UNION all
SELECT company_id,
       element_cd || '_last_y' AS element_cd,
       CAST(element_value AS VARCHAR2(2000)) AS element_value,
       element_src,
       element_desc,
       (rpt_dt + numtoyminterval(1, 'year')) AS rpt_dt,
       CASE TO_CHAR(rpt_dt, 'MM')
         WHEN '03' THEN
          3
         WHEN '06' THEN
          2
         WHEN '09' THEN
          4
         WHEN '12' THEN
          1
         ELSE
          -1
       END AS rpt_timetype_cd,
       isdel,
       client_id,
       updt_by,
       updt_dt
  FROM compy_element
 WHERE rpt_dt IN (SELECT (rpt_dt - numtoyminterval(1, 'year'))
                    FROM compy_element)
UNION all
SELECT company_id,
       element_cd || '_bf_last_y' AS element_cd,
       CAST(element_value AS VARCHAR2(2000)) AS element_value,
       element_src,
       element_desc,
       (rpt_dt + numtoyminterval(2, 'year')) AS rpt_dt,
       CASE TO_CHAR(rpt_dt, 'MM')
         WHEN '03' THEN
          3
         WHEN '06' THEN
          2
         WHEN '09' THEN
          4
         WHEN '12' THEN
          1
         ELSE
          -1
       END AS rpt_timetype_cd,
       isdel,
       client_id,
       updt_by,
       updt_dt
  FROM compy_element
 WHERE rpt_dt IN (SELECT (rpt_dt - numtoyminterval(2, 'year'))
                    FROM compy_element);

prompt
prompt Creating view VW_COMPY_EXPOSURE
prompt ===============================
prompt
CREATE OR REPLACE FORCE VIEW VW_COMPY_EXPOSURE AS
SELECT a.company_id,
       a.company_nm,
       b.exposure_sid,
       c.exposure,
       d.region_cd,
       d.region_nm
  FROM compy_basicinfo a
  JOIN compy_exposure b
    ON a.company_id = b.company_id
   AND b.isdel = 0
   AND b.is_new = 1
  JOIN exposure c
    ON b.exposure_sid = c.exposure_sid
  LEFT JOIN (SELECT region_cd, region_nm, parent_cd, region_type, updt_dt
               FROM lkp_region) d
    ON a.region = d.region_cd
 WHERE a.is_del = 0;

prompt
prompt Creating view VW_COMPY_INDUSTRY_DETAIL
prompt ======================================
prompt
CREATE OR REPLACE FORCE VIEW VW_COMPY_INDUSTRY_DETAIL AS
SELECT a.company_id,
       '1008' AS system_cd,
       c.name AS industry_level1,
       CASE
         WHEN b.industry_level = 2 THEN
          b.name
         ELSE
          NULL
       END AS industry_level2,
       NULL AS industry_level3
  FROM compy_industry a
  JOIN industry b
    ON a.industry_sid = b.id
   AND b.system_cd = 1008
  JOIN industry c
    ON b.parent_ind_sid = c.id
   AND c.system_cd = 1008
 WHERE a.isdel = 0
   AND a.is_new = 1
UNION ALL
SELECT
    s.company_id,
    s.system_cd,
    s.industry_level1,
    s.industry_level2,
    s.industry_level3
FROM
    (
        SELECT
            s_1.company_id,
            s_1.system_cd,
            s_1.industry_level1,
            s_1.industry_level2,
            s_1.industry_level3,
            s_1.updt_dt,
            row_number() OVER (PARTITION BY s_1.company_id ORDER BY
            CASE
                WHEN (s_1.industry_level3 IS NULL)
                THEN 0
                ELSE 1
            END DESC,
            CASE
                WHEN (s_1.industry_level2 IS NULL)
                THEN 0
                ELSE 1
            END DESC,
            CASE
                WHEN (s_1.industry_level1 IS NULL)
                THEN 0
                ELSE 1
            END DESC, s_1.updt_dt DESC) AS rnk
        FROM ( SELECT a.company_id,
                      '1011' AS system_cd,
                      c.name AS industry_level1,
                      d.name AS industry_level2,
                      CASE
                        WHEN b.industry_level = 3 THEN
                         b.name
                        ELSE
                         NULL
                      END AS industry_level3,
                      a.updt_dt
                 FROM compy_industry a
                 JOIN industry b
                   ON a.industry_sid = b.id
                  AND b.system_cd = 1011
                 JOIN industry c
                   ON SUBSTR(b.code, 1, 2) || '0000' = c.code
                  AND c.system_cd = 1011
                  AND c.industry_level = 1
                 LEFT JOIN industry d
                   ON SUBSTR(b.code, 1, 4) || '00' = d.code
                  AND d.system_cd = 1011
                  AND d.industry_level = 2
                WHERE a.isdel = 0
                  AND a.is_new = 1 ) s_1) s WHERE s.rnk = 1;

prompt
prompt Creating view VW_COMPY_SECURITY
prompt ===============================
prompt
CREATE OR REPLACE FORCE VIEW VW_COMPY_SECURITY AS
SELECT a.company_id,
       lkp1.constant_nm AS security_type,
       c.security_cd,
       c.trd_market_id,
       lkp2.constant_nm AS trd_market
  FROM compy_basicinfo a
  JOIN compy_security_xw b
    ON a.company_id = b.company_id
  JOIN security c
    ON b.secinner_id = c.secinner_id
   AND c.isdel = 0
  JOIN lkp_charcode lkp1
    ON lkp1.constant_type = 401
   AND lkp1.isdel = 0
   AND c.security_type_id = lkp1.constant_id
  JOIN lkp_charcode lkp2
    ON lkp2.constant_type = 402
   AND lkp2.isdel = 0
   AND c.trd_market_id = lkp2.constant_id
 WHERE to_char(lkp1.constant_nm) in ('A股', 'B股', 'H股')
   AND c.list_st IN (0, 3)
   AND a.company_st = 1
   AND a.country = 'CN';

prompt
prompt Creating view VW_COMPY_TYPE_ALL
prompt ===============================
prompt
CREATE OR REPLACE FORCE VIEW VW_COMPY_TYPE_ALL AS
SELECT a.company_id,
       a.region,
       a.company_type,
       a.company_nm,
       b.exposure_sid,
       c.exposure,
       d.region_cd,
       d.region_nm
  FROM (
  SELECT DISTINCT a_1.company_id,
                b_1.region,
                CASE
                  WHEN to_char(lkp1.security_type) IN ('A股', 'B股', 'H股') AND  a_1.list_st in (0, 3) THEN
                   '上市公司'
                  WHEN to_char(lkp1.security_type) in
                       ('私募基金', '私募证券投资基金', '私募股权基金', '其他私募基金', '私募商品基金') THEN
                   '私募'
                  WHEN to_char(lkp1.security_type) in
                       ('封闭式基金', '全国社保基金', '开放式基金') THEN
                   '公募'
                  ELSE
                   '退市'
                END AS company_type,
                b_1.company_nm
  FROM security a_1
  JOIN compy_basicinfo b_1
    ON a_1.company_id = b_1.company_id
   AND a_1.src_cd = 'DFCF'
  JOIN (SELECT constant_id AS security_type_id, constant_nm AS security_type
          FROM lkp_charcode
         WHERE constant_type = 401
           AND isdel = 0) lkp1
    ON a_1.security_type_id = lkp1.security_type_id
 WHERE ((to_char(lkp1.security_type) in ('A股', 'B股') AND
       a_1.list_st IN (0, 3)) OR to_char(lkp1.security_type) IN
       ('私募基金', '私募证券投资基金', '私募股权基金', '其他私募基金', '私募商品基金', '封闭式基金', '全国社保基金', '开放式基金'))
   AND b_1.is_del = 0
   AND b_1.company_st = 1
   AND b_1.country = 'CN'
UNION ALL
SELECT DISTINCT b_1.company_id,
                b_1.region,
                '发债企业' AS company_type,
                b_1.company_nm
  FROM security a_1
  JOIN compy_basicinfo b_1
    ON a_1.company_id = b_1.company_id
  JOIN bond_basicinfo c_1
    ON a_1.secinner_id = c_1.secinner_id
 WHERE c_1.mrty_dt >= systimestamp
   AND b_1.is_del = 0
   AND b_1.company_st = 1
   AND b_1.country = 'CN'
   AND c_1.isdel = 0
UNION ALL
SELECT DISTINCT a_1.company_id,
                b_1.region,
                '三板股' AS company_type,
                b_1.company_nm
  FROM security a_1
  JOIN compy_basicinfo b_1
    ON a_1.company_id = b_1.company_id
  JOIN (SELECT constant_id AS security_type_id, constant_nm AS security_type
          FROM lkp_charcode
         WHERE constant_type = 401
           AND isdel = 0) lkp2
    ON a_1.security_type_id = lkp2.security_type_id
 WHERE to_char(lkp2.security_type) = '三板股'
   AND b_1.is_del = 0
   AND a_1.list_st in (0, 3)
   AND a_1.isdel = 0
   AND b_1.company_st = 1
   AND b_1.country = 'CN'
  ) a
  JOIN compy_exposure b
    ON a.company_id = b.company_id
   AND b.is_new = 1
   AND b.isdel = 0
  JOIN exposure c
    ON b.exposure_sid = c.exposure_sid
  LEFT JOIN (SELECT region_cd, region_nm, parent_cd, region_type, updt_dt
               FROM lkp_region) d
    ON a.region = d.region_cd;

prompt
prompt Creating view VW_COMPY_WARNINGS
prompt ===============================
prompt
CREATE OR REPLACE FORCE VIEW VW_COMPY_WARNINGS AS
SELECT cws.compy_warnings_sid, --流水号
       cws.subject_id,--预警对象代码
       cbi.company_nm, --预警对象名称
       cws.notice_dt, --预警信号时间
       cws.warning_type, --正负面
       cws.severity, --严重程度
       cws.warning_score, --信号分值
       cws.warning_title, --预警标题
       cws.type_id, --信号分类代码
       --lkp1.constant_nm       AS type_nm, --信号分类名称
       cet.type_name         AS type_nm, --信号分类名称,
       cws.status_flag, --处理状态
       lkp2.constant_nm      AS status_nm, --处理状态名称
       cws.warning_result_cd, --处理类型
       lkp3.constant_nm      AS warning_result_nm, --处理类型名称
       cws.adjust_severity, --调整后严重程度
       cws.adjust_score, --调整后得分
       rdsp.final_rating, --企业内评
       cred.rating, --企业外评
       cbi.org_form_id, --企业性质
       lkp4.constant_nm      AS org_form, --企业性质
       eps.exposure_sid, --企业敞口id
       eps.exposure, --企业敞口
       cws.remark, --备注
       cws.process_by,--处理人
       cws.process_dt --处理时间
  FROM compy_warnings cws
  LEFT JOIN compy_event_type cet
    ON (cws.type_id = cet.id)
  LEFT JOIN lkp_constant lkp1
    ON (to_char(cws.type_id) = lkp1.constant_cd AND lkp1.isdel = 0 AND
       lkp1.constant_type = 103)
  LEFT JOIN lkp_constant lkp2
    ON (cws.status_flag = lkp2.constant_cd AND lkp2.isdel = 0 AND
       lkp2.constant_type = 101)
  LEFT JOIN lkp_constant lkp3
    ON (cws.warning_result_cd = lkp3.constant_cd AND lkp3.isdel = 0 AND
       lkp3.constant_type = 102)
  LEFT JOIN compy_basicinfo cbi
    ON (cws.subject_id = cbi.company_id AND cbi.is_del = 0)
  LEFT JOIN lkp_charcode lkp4
    ON (cbi.org_form_id = lkp4.constant_id AND lkp4.isdel = 0 AND
       lkp4.constant_type = 2)
  LEFT JOIN rating_display rdsp
    ON (cws.subject_id = rdsp.company_id)
  LEFT JOIN (SELECT cp.company_id, ep.exposure_sid, ep.exposure
               FROM compy_exposure cp, exposure ep
              WHERE cp.exposure_sid = ep.exposure_sid
                AND cp.is_new = 1
                AND cp.isdel = 0
                AND ep.isdel = 0) eps
    ON (cws.subject_id = eps.company_id)
  LEFT JOIN (SELECT t.company_id,
                    t.itype_cd,
                    t.rating_dt,
                    t.rate_typeid,
                    t.rating,
                    t.isdel,
                    row_number() over(PARTITION BY t.company_id ORDER BY updt_dt DESC) AS rn
               FROM compy_creditrating t
              WHERE t.isdel = 0) cred
    ON (cws.subject_id = cred.company_id AND cred.isdel = 0 AND cred.rn = 1)
 WHERE cws.isdel = 0
   AND cws.subject_type = 0  --0:企业
;

prompt
prompt Creating view VW_EXPIRED_RATING
prompt ===============================
prompt
CREATE OR REPLACE FORCE VIEW VW_EXPIRED_RATING AS
WITH
    balancesheet_latest AS
    (
        SELECT company_id, rpt_dt, updt_dt,
            row_number() OVER (PARTITION BY  company_id ORDER BY
            CASE
                WHEN data_ajust_type = 2
                THEN 0
                ELSE 1
            END,  compy_balancesheet_sid DESC) AS row_num
          FROM compy_balancesheet
         WHERE isdel = 0
           AND rpt_timetype_cd = 1
           AND combine_type_cd = 1
    )
    ,
    incomestate_latest AS
    (
        SELECT company_id, rpt_dt, updt_dt,
            row_number() OVER (PARTITION BY  company_id ORDER BY
            CASE
                WHEN data_ajust_type = 2
                THEN 0
                ELSE 1
            END,  compy_incomestate_sid DESC) AS row_num
          FROM compy_incomestate
         WHERE  isdel = 0 AND  rpt_timetype_cd = 1 AND combine_type_cd = 1
    )
    ,
    rating_hist_latest AS
    (
        SELECT company_id,
               client_id,
               final_rating,
               rating_start_dt AS creation_time,
               row_number() OVER(PARTITION BY company_id, client_id ORDER BY rating_start_dt DESC) AS row_num
          FROM rating_record
    )
SELECT a.company_id,
       b.company_nm,
       a.final_rating AS rating,
       a.creation_time AS rating_dt,
       CAST('评级时间超过一年' AS VARCHAR2(40)) AS expired_reason,
       a.client_id
  FROM rating_hist_latest a
  JOIN compy_basicinfo b
    ON a.company_id = CAST(b.company_id AS NUMBER)
 WHERE a.row_num = 1
   AND a.creation_time < (systimestamp - NUMTOYMINTERVAL(1, 'year'))
UNION ALL
SELECT a.company_id,
       b.company_nm,
       a.final_rating AS rating,
       a.creation_time AS rating_dt,
       CAST('评级时间未超过一年，但已有最新年报' AS VARCHAR2(4000)) AS expired_reason,
       a.client_id
  FROM rating_hist_latest a
  JOIN compy_basicinfo b
    ON a.company_id = CAST(b.company_id AS NUMBER)
  JOIN balancesheet_latest c
    ON a.company_id = CAST(c.company_id AS NUMBER)
  JOIN incomestate_latest d
    ON a.company_id = CAST(d.company_id AS NUMBER)
 WHERE a.row_num = 1
   AND c.row_num = 1
   AND d.row_num = 1
   AND (c.updt_dt < (systimestamp - NUMTODSINTERVAL(10, 'day')))
   AND (d.updt_dt < (systimestamp - NUMTODSINTERVAL(10, 'day')))
   AND (a.creation_time >= (systimestamp - NUMTOYMINTERVAL(1, 'year')));

prompt
prompt Creating view VW_FINANCE_SUBJECT
prompt ================================
prompt
CREATE OR REPLACE FORCE VIEW VW_FINANCE_SUBJECT AS
SELECT a_1.company_id,
       a_1.rpt_dt,
       a_1.end_dt,
       a_1.combine_type_cd,
       a_1.sum_liab,
       a_1.sum_asset,
       a_1.sum_sh_equity,
       a_1.sum_lasset,
       a_1.sum_lliab,
       b_1.sum_profit,
       b_1.finance_exp,
       to_number(SUBSTR(a_1.rpt_dt, 1,4)) * 4 +
       to_number(SUBSTR(a_1.rpt_dt, 5,2))/3 AS rpt_quarter,
    row_number() OVER (PARTITION BY a_1.company_id, a_1.rpt_dt ORDER BY
    CASE
        WHEN  a_1.data_ajust_type = 2
        THEN 0
        ELSE 1
    END, a_1.end_dt DESC, a_1.data_type) AS row_num

  FROM compy_balancesheet a_1
  JOIN compy_incomestate b_1
    ON a_1.company_id = b_1.company_id
   AND a_1.combine_type_cd = b_1.combine_type_cd
   AND a_1.rpt_dt = b_1.rpt_dt
   AND a_1.end_dt = b_1.end_dt
   AND a_1.data_type = b_1.data_type
   AND a_1.combine_type_cd = 1;

prompt
prompt Creating view VW_RATING_RECORD
prompt ==============================
prompt
create or replace force view vw_rating_record as
select
  r.rating_record_id   as id,
  r.company_id,
  r.exposure_sid,
  r.model_id,
  r.factor_dt,
  r.rpt_timetype_cd,
  r.rating_type,
  r.user_id,
  r.client_id,
  r.total_score,
  r.raw_pd,
  r.scaling_point,
  r.scaled_pd,
  r.scaled_raw_rating,
  r.scaled_rating,
  r.final_rating       as rating_result,
  r.adjustment_comment as adjust_comment,
  r.rating_st,
  r.effect_start_dt,
  r.effect_end_dt,
  r.rating_start_dt,
  r.rating_affirm_dt,
  i.exposure,
  rm."NAME"            as model_name,
  u.display_nm         as initiator,
  V.PROC_INST_ID_      as workflow_id
from rating_record r
  join exposure i
    on i.exposure_sid = r.exposure_sid
  join rating_model rm
    on rm."ID" = r.model_id
  join user_basicinfo u
    on u.user_id = r.user_id
  --LEFT JOIN workflow w
  --  ON w.context = r.rating_record_id;
  left join ACT_HI_VARINST V
    on concat(R.RATING_RECORD_ID,'') = V.TEXT_ and V.NAME_ = 'context' and V.VAR_TYPE_ = 'string' and V.PROC_INST_ID_ is not null
;

prompt
prompt Creating view VW_WARNINGS
prompt =========================
prompt
CREATE OR REPLACE FORCE VIEW VW_WARNINGS AS
SELECT a.record_sid,
       a.subject_id,
       a.subject_nm,
       a.notice_dt,
       a.type_id,
       a.severity,
       a.warning_title,
       a.warning_content,
       a.exposure_sid,
       a.exposure,
       a.region_cd,
       a.region_nm,
       a.subject_type,
       a.severity_adjusted,
       a.process_flag,
       a.src_tblnm
  FROM (SELECT rating_change_warning_sid AS record_sid,
               subject_id,
               subject_nm,
               new_rating_dt AS notice_dt,
               16 AS type_id,
               severity,
               warning_title,
               warning_content,
               0 AS exposure_sid,
               NULL AS exposure,
               0 AS region_cd,
               NULL AS region_nm,
               subject_type,
               severity_adjusted,
               process_flag,
               'rating_change_warning' AS src_tblnm
          FROM rating_change_warning
         WHERE subject_type = 1
        UNION ALL
        SELECT a_1.rating_change_warning_sid,
               a_1.subject_id,
               a_1.subject_nm,
               a_1.updt_dt AS notice_dt,
               17 AS type_id,
               a_1.severity AS importance,
               a_1.warning_title,
               a_1.warning_content,
               b.exposure_sid,
               c.exposure,
               d.region_cd,
               d.region_nm,
               a_1.subject_type,
               a_1.severity_adjusted,
               a_1.process_flag,
               'rating_change_warning' AS src_tblnm
          FROM rating_change_warning a_1
          JOIN compy_exposure b
            ON a_1.subject_id = b.company_id
           AND b.isdel = 0
           AND b.is_new = 1
          JOIN compy_basicinfo e
            ON b.company_id = e.company_id
           AND e.is_del = 0
          JOIN exposure c
            ON b.exposure_sid = c.exposure_sid
          LEFT JOIN lkp_region d
            ON e.region = d.region_cd
         WHERE a_1.subject_type = 0
        UNION ALL
        SELECT cw.compy_warnings_sid,
               cw.company_id,
               company_nm,
               cw.notice_dt,
               cw.type_id,
               cw.severity,
               CAST(cw.warning_title AS VARCHAR2(100)) AS warning_title,
               CAST(substr(cnt.warning_content, 0, 1000) AS VARCHAR2(1000)) AS warning_content,
               cps.exposure_sid,
               eps.exposure,
               d.region_cd,
               d.region_nm,
               0 AS subject_type,
               cw.adjust_severity AS severity_adjusted,
               cw.process_by AS process_flag,
               'compy_warnings' AS src_tblnm
          FROM compy_warnings cw
          JOIN compy_basicinfo cb
            ON (cw.company_id = cb.company_id AND cb.is_del = 0)
          LEFT JOIN compy_exposure cps
            ON (cw.company_id = cps.company_id AND cps.isdel = 0)
          LEFT JOIN exposure eps
            ON (cps.exposure_sid = eps.exposure_sid AND eps.isdel = 0)
          LEFT JOIN compy_warnings_content cnt
            ON (cw.compy_warnings_sid = cnt.compy_warnings_sid)
          LEFT JOIN lkp_region d
            ON cb.region = d.region_cd
         WHERE cw.isdel = 0) a
  JOIN compy_event_type g
    ON g.ID = a.type_id
  JOIN sysconfig h
    ON h.sysconfig_type_cd = 3
   AND h.sysconfig_desc = g.type_name
   AND h.value = '1'
UNION ALL
SELECT a.factor_change_warning_sid AS record_sid,
       a.company_id AS subject_id,
       e.company_nm AS subject_nm,
       a.updt_dt AS notice_dt,
       18 AS type_id,
       a.severity,
       a.warning_title AS warning_title,
       a.warning_content AS warning_content,
       a.exposure_sid,
       c.exposure,
       d.region_cd,
       d.region_nm,
       0 AS subject_type,
       a.severity_adjusted,
       a.process_flag,
       'factor_change_warning' AS src_tblnm
  FROM factor_change_warning a
  JOIN compy_exposure b
    ON a.company_id = b.company_id
   AND b.isdel = 0
   AND b.is_new = 1
  JOIN compy_basicinfo e
    ON b.company_id = e.company_id
   AND e.is_del = 0
  JOIN exposure c
    ON a.exposure_sid = c.exposure_sid
  LEFT JOIN lkp_region d
    ON e.region = d.region_cd;

prompt
prompt Creating materialized view VW_COMPY_FINANALARM
prompt ==============================================
prompt
CREATE MATERIALIZED VIEW VW_COMPY_FINANALARM
REFRESH FORCE ON DEMAND
AS
SELECT a.company_id,
    to_date(cast((a.rpt_dt) as character(20)), 'yyyymmdd') AS rpt_dt,
    to_date(cast((a.end_dt) as character(20)), 'yyyymmdd') AS end_dt,
        CASE
            WHEN (a.sum_asset = cast((0) as number)) THEN cast(NULL as number)
            ELSE ((a.sum_liab / a.sum_asset) * cast((100) as number))
        END AS leverage1,
        CASE
            WHEN (b.sum_asset = cast((0) as number)) THEN cast(NULL as number)
            ELSE ((b.sum_liab / b.sum_asset) * cast((100) as number))
        END AS leverage1_last_q,
        CASE
            WHEN (a.finance_exp = cast((0) as number)) THEN cast(NULL as number)
            ELSE (((a.sum_profit + a.finance_exp) / a.finance_exp) * cast((100) as number))
        END AS liquidity15,
        CASE
            WHEN (b.finance_exp = cast((0) as number)) THEN cast(NULL as number)
            ELSE (((b.sum_profit + b.finance_exp) / b.finance_exp) * cast((100) as number))
        END AS liquidity15_last_q,
        CASE
            WHEN (a.sum_lliab = cast((0) as number)) THEN cast(NULL as number)
            ELSE ((a.sum_lasset / a.sum_lliab) * cast((100) as number))
        END AS liquidity3,
        CASE
            WHEN (b.sum_lliab = cast((0) as number)) THEN cast(NULL as number)
            ELSE ((b.sum_lasset / b.sum_lliab) * cast((100) as number))
        END AS liquidity3_last_q,
        CASE
            WHEN ((a.sum_sh_equity + b.sum_sh_equity) = cast((0) as number)) THEN cast(NULL as number)
            ELSE (((cast((2) as number) * (a.sum_profit + a.finance_exp)) / (a.sum_sh_equity + b.sum_sh_equity)) * cast((100) as number)) 
        END AS profitability7,
        CASE
            WHEN ((b.sum_sh_equity + c.sum_sh_equity) = cast((0) as number)) THEN NULL
            ELSE (((cast((2) as number) * (b.sum_profit + b.finance_exp)) / (b.sum_sh_equity + c.sum_sh_equity)) * cast((100) as number))
        END AS profitability7_last_q
   FROM ((vw_finance_subject a
     JOIN vw_finance_subject b ON (((((a.company_id = b.company_id) AND ((a.rpt_quarter - cast((1) as number)) = b.rpt_quarter)) AND (a.row_num = 1)) AND (b.row_num = 1))))
     JOIN vw_finance_subject c ON (((((a.company_id = c.company_id) AND ((a.rpt_quarter - cast((2) as number)) = c.rpt_quarter)) AND (a.row_num = 1)) AND (c.row_num = 1))));

prompt
prompt Creating materialized view VW_REGION_LEVEL
prompt ==========================================
prompt
CREATE MATERIALIZED VIEW VW_REGION_LEVEL
REFRESH FORCE ON DEMAND
AS
SELECT a.region_cd,
       a.region_nm,
       a.region_type,
       a.region_cd AS region_cd_l1,
       a.region_nm AS region_nm_l1,
       NULL AS region_cd_l2,
       NULL AS region_nm_l2,
       NULL AS region_cd_l3,
       NULL AS region_nm_l3
  FROM lkp_region a
 WHERE a.region_type = 1
UNION ALL
SELECT a.region_cd,
       a.region_nm,
       a.region_type,
       b.region_cd AS region_cd_l1,
       b.region_nm AS region_nm_l1,
       a.region_cd AS region_cd_l2,
       a.region_nm AS region_nm_l2,
       NULL AS region_cd_l3,
       NULL AS region_nm_l3
  FROM lkp_region a
  JOIN lkp_region b
    ON b.region_cd = a.parent_cd
   AND b.region_type = 1
 WHERE a.region_type = 2
UNION ALL
SELECT a.region_cd,
       a.region_nm,
       a.region_type,
       c.region_cd   AS region_cd_l1,
       c.region_nm   AS region_nm_l1,
       b.region_cd   AS region_cd_l2,
       b.region_nm   AS region_nm_l2,
       a.region_cd   AS region_cd_l3,
       a.region_nm   AS region_nm_l3
  FROM lkp_region a
  JOIN lkp_region b
    ON b.region_cd = a.parent_cd
   and b.region_type = 2
  JOIN lkp_region c
    ON c.region_cd =
       cast((SUBSTR(a.region_cd, 1, 2) || '0000') as number(19))
   AND c.region_type = 1
 WHERE a.region_type = 3;

prompt
prompt Creating function GET_SEQ_NEXT
prompt ==============================
prompt
create or replace function get_seq_next(seq_name in varchar2) return number is
  seq_val number;
begin
  execute immediate 'select ' || seq_name || '.nextval from dual'
    into seq_val;
  return seq_val;
end get_seq_next;
/

prompt
prompt Creating procedure SP_DROP_IF_EXIST
prompt ===================================
prompt
CREATE OR REPLACE PROCEDURE sp_drop_if_exist(p_table in varchar2)
AS
  v_count number(10);
BEGIN
  SELECT COUNT(*)
    INTO V_COUNT
    FROM USER_TABLES
   WHERE TABLE_NAME = UPPER(p_table);

  IF V_COUNT > 0 THEN
    EXECUTE IMMEDIATE 'drop table ' || p_table || ' purge';
  END IF;
END;
/

prompt
prompt Creating procedure SP_BOND_POSITION
prompt ===================================
prompt
CREATE OR REPLACE PROCEDURE SP_BOND_POSITION
AS 

vstart_dt timestamp;
vinsert_count integer;
vupdt_count integer;
vorig_count integer;
vdeduped_count integer;
vdup_count integer;
vrow_count integer;
vstart_rowid integer;
vend_rowid integer;
vmessage varchar(1000) :='';
vsql varchar(4000) :='';

BEGIN

vstart_dt :=systimestamp;

SP_DROP_IF_EXIST('tmp_bond_position_1');
SP_DROP_IF_EXIST('tmp_bond_position');

vmessage :='start full refresh load.';

vmessage :='create tmp_bond_position_1.';	

SELECT COUNT(*) INTO vrow_count FROM CS_MASTER_STG.STG_BOND_POSITION;	

if vrow_count=0 then 
    vmessage :='No data found..';
    RAISE_APPLICATION_ERROR(-20021,vmessage);
end if;

SELECT MIN(record_sid) INTO vstart_rowid FROM CS_MASTER_STG.STG_BOND_POSITION;
SELECT MAX(record_sid) INTO vend_rowid FROM CS_MASTER_STG.STG_BOND_POSITION;


vsql := 'create table tmp_bond_position_1 as 
select
	security_cd,
	security_snm,
	trade_market,
	is_newpublic,
	is_convertible_bond,
	is_exchange_bond,
	cs_rating,
	cb_rating,
	apply_dt,
	data_dt,
	src_cd,
	isdel
from 
	(select 
	   security_cd,
       security_snm,
	   case when trade_market=0 then ''上海证券交易所'' when trade_market=1 then ''深圳证券交易所'' else null end as trade_market,
	   is_newpublic,
	   is_convertible_bond,
	   is_exchange_bond,
	   cs_rating,
	   cb_rating,
	   apply_dt,
	   data_dt,
	   src_cd,
	   isdel,
	   row_number()over(partition by security_cd,trade_market order by isdel asc,updt_dt desc) as rnk
	from ft_cs_master_stg.stg_bond_position
	)s
where rnk=1';

EXECUTE IMMEDIATE vsql;

vmessage :='start create table tmp_bond_position.';	
vsql := 'create table tmp_bond_position as
select a.security_cd,
	   b.constant_id as trd_market_id,
	   a.security_snm,
	   c.secinner_id,
	   a.is_newpublic,
	   a.is_convertible_bond,
	   a.is_exchange_bond,
	   a.cs_rating,
	   a.cb_rating,
	   a.apply_dt,
	   a.data_dt,
	   a.isdel,
	   a.src_cd,
	   systimestamp as updt_dt
from tmp_bond_position_1 a
	join lkp_charcode b 
	 on a.trade_market=b.constant_nm and b.constant_type=206 and b.isdel=0
	 left join bond_basicinfo c
	 on a.security_cd=c.security_cd
	 and a.security_snm=c.security_snm
	 and b.constant_id=c.trade_market_id and c.isdel=0';

EXECUTE IMMEDIATE vsql;

SELECT COUNT(*) INTO vorig_count FROM CS_MASTER_STG.STG_BOND_POSITION;		
SELECT COUNT(*)-COUNT(DISTINCT security_cd||trd_market_id) INTO vdup_count FROM CS_MASTER_STG.STG_BOND_POSITION;

--SELECT COUNT(*) INTO vinsert_count FROM tmp_bond_position WHERE (security_cd,trd_market_id) NOT IN (SELECT security_cd,trd_market_id FROM bond_position);
--SELECT COUNT(*) INTO vupdt_count FROM tmp_bond_position WHERE (security_cd,trd_market_id) IN (SELECT security_cd,trd_market_id FROM bond_position);


vmessage :='start insert.';		 
vsql := 'insert into  bond_position
select a.* from tmp_bond_position a
left join bond_position b
on a.security_cd=b.security_cd and a.trd_market_id=b.trd_market_id
where b.security_cd is null';
EXECUTE IMMEDIATE vsql;
vinsert_count := SQL%ROWCOUNT;


vmessage :='start update.';
vsql := 'MERGE INTO bond_position b
USING tmp_bond_position a
ON (a.security_cd=b.security_cd and a.trd_market_id=b.trd_market_id)
WHEN MATCHED THEN UPDATE SET
 security_cd=a.security_cd,
	trd_market_id=a.trd_market_id,
    security_snm=a.security_snm,
    secinner_id=a.secinner_id,
    is_newpublic=a.is_newpublic,
	is_convertible_bond=a.is_convertible_bond,
    is_exchange_bond=a.is_exchange_bond,
	cs_rating=a.cs_rating,
	cb_rating=a.cb_rating,
    apply_dt=a.apply_dt,
	data_dt=(case when b.isdel=0 then b.data_dt else a.data_dt end),
    isdel=a.isdel,
    src_cd=a.src_cd,
    updt_dt=a.updt_dt';
EXECUTE IMMEDIATE vsql;
vupdt_count := SQL%ROWCOUNT;

vmessage :='start updt isdel for deleted bonds';
vsql := 'update  bond_position a
set isdel=1,
	updt_dt=systimestamp
where (security_cd,trd_market_id) not in (select security_cd,trd_market_id from tmp_bond_position)
';
EXECUTE IMMEDIATE vsql;

vmessage :='start inserting load log.';	
vsql :='insert into etl_dm_loadlog
	(process_nm, orig_record_count, dup_record_count, insert_count, updt_count, start_dt, end_dt, start_rowid, end_rowid)
	select ''fn_bond_position'','||vorig_count||','||vdup_count||','||vinsert_count||','||vupdt_count||','''||vstart_dt||''','''||systimestamp||''','||vstart_rowid||','||vend_rowid;
vmessage := vsql;
execute immediate  vsql;

 sp_drop_if_exist('tmp_bond_position_1');
 sp_drop_if_exist('tmp_bond_position');

vmessage :='full fresh load completed.';	
EXCEPTION
	WHEN OTHERS THEN 
	RAISE_APPLICATION_ERROR(-20021,vmessage);
END;
/

prompt
prompt Creating procedure SP_COMPY_FINANCE
prompt ===================================
prompt
CREATE OR REPLACE PROCEDURE SP_COMPY_FINANCE(p_company_id in number, p_user_id  in number)
AS 

/*
FUNCTION Name:		fn_compy_finance
Paramter:			company_id
Description:		Generate compy_finance,compy_finance_dynamic
Example:			select fn_compy_finance(111111,user_id)
Creation Date:		2016-11-02
Author:				Nicky Shang
Modification:		2016-12-08 Nicky clear temp and wrk table.
					2017-02-17 Nicky add a parameter p_user_id for catching client_id and updt_by.
					2017-02-20 Nicky modify datatype of rpt_dt to date in compy_finance and compy_finance_dynamic.
					2017-05-23 Nicky removed compy_finance_dynamic and added compy_finance_last_y and compy_finance_bf_last_y
                    2017-07-27 mark: convert into oracle
*/

vStart_dt number(10);
vEnd_dt integer;
vRpt_dt integer;
vSQL VARCHAR(30000)	:='';
vSQL1 VARCHAR(30000)	:='';
vSQL2 VARCHAR(30000) :='';
vSQL3 VARCHAR(30000)	:='';
cClient_id integer;
cUpdt_by integer;

BEGIN
--step0:获取当前的user_id和updt_by
select client_id into cClient_id from user_basicinfo where user_id = p_user_id;
cUpdt_by:=p_user_id;

--step1:获取所有的company_id
SP_DROP_IF_EXIST('wrk_compy_id_all');
vSQL:='
CREATE TABLE wrk_compy_id_all
AS
SELECT DISTINCT company_id,rpt_dt,rpt_timetype_cd FROM compy_balancesheet 
WHERE isdel=0 AND combine_type_cd=1 AND data_ajust_type IN (2,3) AND rpt_timetype_cd in (2,3,4,7,8,9) AND company_id='||p_company_id||' 
UNION
SELECT DISTINCT company_id,rpt_dt,rpt_timetype_cd FROM compy_incomestate 
WHERE isdel=0 AND combine_type_cd=1 AND data_ajust_type IN (2,3) AND rpt_timetype_cd in (2,3,4,7,8,9) AND company_id='||p_company_id||' 
UNION
SELECT DISTINCT company_id,rpt_dt,rpt_timetype_cd FROM compy_cashflow 
WHERE isdel=0 AND combine_type_cd=1 AND data_ajust_type IN (2,3) AND rpt_timetype_cd in (2,3,4,7,8,9) AND company_id='||p_company_id||' 
UNION
SELECT DISTINCT company_id,rpt_dt,rpt_timetype_cd FROM compy_cashflow 
WHERE isdel=0 AND combine_type_cd=1 AND data_ajust_type IN (2,3) AND rpt_timetype_cd =1 AND chk_status = ''PASS'' AND company_id='||p_company_id||' 
UNION
SELECT DISTINCT company_id,rpt_dt,rpt_timetype_cd FROM compy_cashflow 
WHERE isdel=0 AND combine_type_cd=1 AND data_ajust_type IN (2,3) AND rpt_timetype_cd =1 AND chk_status = ''PASS'' AND company_id='||p_company_id||' 
UNION
SELECT DISTINCT company_id,rpt_dt,rpt_timetype_cd FROM compy_cashflow 
WHERE isdel=0 AND combine_type_cd=1 AND data_ajust_type IN (2,3) AND rpt_timetype_cd =1 AND chk_status = ''PASS'' AND company_id='||p_company_id
; 
execute immediate  vSQL;

select min(rpt_dt) into vStart_dt from wrk_compy_id_all;
select max(rpt_dt) into vEnd_dt from wrk_compy_id_all;

--TRUNCATE TABLE wrk_report_date_list;
SP_DROP_IF_EXIST('wrk_report_date_list');
vSQL := 'CREATE TABLE wrk_report_date_list AS SELECT DISTINCT rpt_dt FROM wrk_compy_id_all';
EXECUTE IMMEDIATE vSQL;

SP_DROP_IF_EXIST('wrk_balancesheet_part');
vSQL := 'CREATE TABLE wrk_balancesheet_part
AS
SELECT a.*
FROM
compy_balancesheet a
JOIN 
  (SELECT a.compy_balancesheet_sid,
  row_number()OVER(PARTITION BY a.company_id,a.rpt_dt ORDER  BY a.data_ajust_type,a.end_dt DESC,a.updt_dt DESC, a.compy_balancesheet_sid DESC) AS row_num
   FROM compy_balancesheet  a
	 join wrk_compy_id_all b on a.company_id = b.company_id and a.rpt_dt = b.rpt_dt and a.rpt_timetype_cd = b.rpt_timetype_cd
  WHERE  isdel=0
  AND combine_type_cd=1
  AND data_ajust_type IN (2,3)
  AND a.rpt_dt IN (SELECT rpt_dt FROM wrk_report_date_list) ) b ON a.compy_balancesheet_sid = b.compy_balancesheet_sid
WHERE b.row_num=1';
EXECUTE IMMEDIATE vSQL;

SP_DROP_IF_EXIST('wrk_balancesheet_part_1');
vSQL := 'create table wrk_balancesheet_part_1
AS
SELECT
a.compy_balancesheet_sid
,a.fst_notice_dt
,a.latest_notice_dt
,c.company_id
,c.rpt_dt
,a.start_dt
,a.end_dt
,c.rpt_timetype_cd
,a.combine_type_cd
,a.rpt_srctype_id
,a.data_ajust_type
,a.data_type
,a.is_public_rpt
,a.company_type
,a.currency
,a.monetary_fund
,a.tradef_asset
,a.bill_rec
,a.account_rec
,a.other_rec
,a.advance_pay
,a.dividend_rec
,a.interest_rec
,a.inventory
,a.nonl_asset_oneyear
,a.defer_expense
,a.other_lasset
,a.lasset_other
,a.lasset_balance
,a.sum_lasset
,a.saleable_fasset
,a.held_maturity_inv
,a.estate_invest
,a.lte_quity_inv
,a.ltrec
,a.fixed_asset
,a.construction_material
,a.construction_progress
,a.liquidate_fixed_asset
,a.product_biology_asset
,a.oilgas_asset
,a.intangible_asset
,a.develop_exp
,a.good_will
,a.ltdefer_asset
,a.defer_incometax_asset
,a.other_nonl_asset
,a.nonlasset_other
,a.nonlasset_balance
,a.sum_nonl_asset
,a.cash_and_depositcbank
,a.deposit_infi
,a.fi_deposit
,a.precious_metal
,a.lend_fund
,a.derive_fasset
,a.buy_sellback_fasset
,a.loan_advances
,a.agency_assets
,a.premium_rec
,a.subrogation_rec
,a.ri_rec
,a.undue_rireserve_rec
,a.claim_rireserve_rec
,a.life_rireserve_rec
,a.lthealth_rireserve_rec
,a.gdeposit_pay
,a.insured_pledge_loan
,a.capitalg_deposit_pay
,a.independent_asset
,a.client_fund
,a.settlement_provision
,a.client_provision
,a.seat_fee
,a.other_asset
,a.asset_other
,a.asset_balance
,a.sum_asset
,a.st_borrow 
,a.trade_fliab
,a.bill_pay
,a.account_pay
,a.advance_receive
,a.salary_pay
,a.tax_pay
,a.interest_pay
,a.dividend_pay
,a.other_pay
,a.accrue_expense
,a.anticipate_liab
,a.defer_income
,a.nonl_liab_oneyear
,a.other_lliab
,a.lliab_other
,a.lliab_balance
,a.sum_lliab
,a.lt_borrow
,a.bond_pay
,a.lt_account_pay
,a.special_pay
,a.defer_incometax_liab
,a.other_nonl_liab
,a.nonl_liab_other
,a.nonl_liab_balance
,a.sum_nonl_liab
,a.borrow_from_cbank
,a.borrow_fund
,a.derive_financedebt
,a.sell_buyback_fasset
,a.accept_deposit
,a.agency_liab
,a.other_liab
,a.premium_advance
,a.comm_pay
,a.ri_pay
,a.gdeposit_rec
,a.insured_deposit_inv
,a.undue_reserve
,a.claim_reserve
,a.life_reserve
,a.lt_health_reserve
,a.independent_liab
,a.pledge_borrow
,a.agent_trade_security
,a.agent_uw_security
,a.liab_other
,a.liab_balance
,a.sum_liab
,a.share_capital
,a.capital_reserve
,a.surplus_reserve
,a.retained_earning
,a.inventory_share
,a.general_risk_prepare
,a.diff_conversion_fc
,a.minority_equity
,a.sh_equity_other
,a.sh_equity_balance
,a.sum_parent_equity
,a.sum_sh_equity
,a.liabsh_equity_other
,a.liabsh_equity_balance
,a.sum_liabsh_equity
,a.td_eposit
,a.st_bond_rec
,a.claim_pay
,a.policy_divi_pay
,a.unconfirm_inv_loss
,a.ricontact_reserve_rec
,a.deposit
,a.contact_reserve
,a.invest_rec
,a.specia_lreserve
,a.subsidy_rec
,a.marginout_fund
,a.export_rebate_rec
,a.defer_income_oneyear
,a.lt_salary_pay
,case when coalesce(a.fvalue_fasset,0) <> 0 then a.fvalue_fasset else a.tradef_asset end as fvalue_fasset
,a.define_fvalue_fasset
,a.internal_rec
,a.clheld_sale_ass
,case when coalesce(a.fvalue_fliab,0)<>0 then a.fvalue_fliab else a.trade_fliab end as fvalue_fliab
,a.define_fvalue_fliab
,a.internal_pay
,a.clheld_sale_liab
,a.anticipate_lliab
,a.other_equity
,a.other_cincome
,a.plan_cash_divi
,a.parent_equity_other
,a.parent_equity_balance
,a.preferred_stock
,a.prefer_stoc_bond
,a.cons_biolo_asset
,a.stock_num_end
,a.net_mas_set
,a.outward_remittance
,a.cdandbill_rec
,a.hedge_reserve
,a.suggest_assign_divi
,a.marginout_security
,a.cagent_trade_security
,a.trade_risk_prepare
,a.creditor_planinv
,a.short_financing--新增应付短期融资款
,a.receivables--新增应收款项
,a.remark
,a.chk_status
,a.isdel
,a.src_company_cd
,a.srcid
,a.src_cd
,a.updt_dt
,CASE WHEN a.company_id is null then ''N'' ELSE ''Y'' END AS balancesheet_flg
FROM  wrk_compy_id_all c
LEFT JOIN wrk_balancesheet_part a ON a.company_id = c.company_id AND a.rpt_dt = c.rpt_dt
WHERE c.rpt_timetype_cd in (1,2,3,4)';
EXECUTE IMMEDIATE vSQL;

--step:创建财务费用财务附注表
--PERFORM SP_DROP_IF_EXIST('wrk_compy_finaexp');

--step2:获取所有的利润表的数据
SP_DROP_IF_EXIST('wrk_incomestate_part_1');
vSQL := 'CREATE TABLE wrk_incomestate_part_1
AS
SELECT a.*
FROM
compy_incomestate a
JOIN
  (SELECT a.compy_incomestate_sid,
  row_number()OVER(PARTITION BY a.company_id,a.rpt_dt,a.rpt_timetype_cd ORDER  BY a.data_ajust_type,a.end_dt DESC,a.updt_dt DESC, a.compy_incomestate_sid DESC ) AS row_num
   FROM compy_incomestate  a
	 join wrk_compy_id_all b on a.company_id = b.company_id and a.rpt_dt = b.rpt_dt and a.rpt_timetype_cd = b.rpt_timetype_cd
  WHERE  isdel=0
  AND combine_type_cd=1
  AND data_ajust_type IN (2,3)
  AND a.rpt_dt IN (SELECT rpt_dt FROM wrk_report_date_list) ) b ON a.compy_incomestate_sid = b.compy_incomestate_sid
WHERE b.row_num=1';
EXECUTE IMMEDIATE vSQL;

--step3:获取所有的现金流量表的数据
SP_DROP_IF_EXIST('wrk_cashflow_part_1');
vSQL := 'CREATE TABLE wrk_cashflow_part_1
AS
SELECT a.*
FROM
compy_cashflow a
JOIN
  (SELECT a.compy_cashflow_sid,
  row_number()OVER(PARTITION BY a.company_id,a.rpt_dt ORDER  BY a.data_ajust_type,a.end_dt DESC,a.updt_dt DESC, a.compy_cashflow_sid DESC ) AS row_num
   FROM compy_cashflow  a
	 join wrk_compy_id_all b on a.company_id = b.company_id and a.rpt_dt = b.rpt_dt and a.rpt_timetype_cd = b.rpt_timetype_cd
  WHERE  isdel=0
  AND combine_type_cd=1
  AND data_ajust_type IN (2,3)
  AND a.rpt_dt IN (SELECT rpt_dt FROM wrk_report_date_list) ) b ON a.compy_cashflow_sid = b.compy_cashflow_sid
WHERE b.row_num=1';
EXECUTE IMMEDIATE vSQL;

--step4:银行补充财务指标数据
SP_DROP_IF_EXIST('wrk_compy_bank_addfin_temp');
vSQL := 'CREATE TABLE wrk_compy_bank_addfin_temp
AS
SELECT
a.company_id,
a.rpt_dt,
CASE  substr(to_char(a.rpt_dt),5,2) WHEN ''03'' then 3 WHEN ''06'' THEN 2 WHEN ''09'' THEN 4 WHEN ''12'' THEN 1 END AS rpt_timetype_cd,
MAX(CASE WHEN item_cd= 19 THEN amt_end END) AS bank_sub_001,
MAX(CASE WHEN item_cd= 20 THEN amt_end END) AS bank_sub_002,
MAX(CASE WHEN item_cd= 21 THEN amt_end END) AS bank_sub_003,
MAX(CASE WHEN item_cd= 22 THEN amt_end END) AS bank_sub_004,
MAX(CASE WHEN item_cd= 24 THEN amt_end END) AS bank_sub_005,
MAX(CASE WHEN item_cd= 25 THEN amt_end END) AS bank_sub_006,
MAX(CASE WHEN item_cd= 26 THEN amt_end END) AS bank_sub_007,
MAX(CASE WHEN item_cd= 27 THEN amt_end END) AS bank_sub_008,
MAX(CASE WHEN item_cd= 28 THEN amt_end END) AS bank_sub_009,
MAX(CASE WHEN item_cd= 29 THEN amt_end END) AS bank_sub_010,
MAX(CASE WHEN item_cd= 30 THEN amt_end END) AS bank_sub_011,
MAX(CASE WHEN item_cd= 31 THEN amt_end END) AS bank_sub_012,
MAX(CASE WHEN item_cd= 32 THEN amt_end END) AS bank_sub_013,
MAX(CASE WHEN item_cd= 34 THEN amt_end END) AS bank_sub_014,
MAX(CASE WHEN item_cd= 35 THEN amt_end END) AS bank_sub_015,
MAX(CASE WHEN item_cd= 36 THEN amt_end END) AS bank_sub_016,
MAX(CASE WHEN item_cd= 37 THEN amt_end END) AS bank_sub_017,
MAX(CASE WHEN item_cd= 38 THEN amt_end END) AS bank_sub_018,
MAX(CASE WHEN item_cd= 39 THEN amt_end END) AS bank_sub_019,
MAX(CASE WHEN item_cd= 41 THEN amt_end END) AS bank_sub_020,
MAX(CASE WHEN item_cd= 42 THEN amt_end END) AS bank_sub_021,
MAX(CASE WHEN item_cd= 43 THEN amt_end END) AS bank_sub_022,
MAX(CASE WHEN item_cd= 44 THEN amt_end END) AS bank_sub_023,
MAX(CASE WHEN item_cd= 45 THEN amt_end END) AS bank_sub_024,
MAX(CASE WHEN item_cd= 46 THEN amt_end END) AS bank_sub_025,
MAX(CASE WHEN item_cd= 47 THEN amt_end END) AS bank_sub_026,
MAX(CASE WHEN item_cd= 48 THEN amt_end END) AS bank_sub_027,
MAX(CASE WHEN item_cd= 49 THEN amt_end END) AS bank_sub_028,
MAX(CASE WHEN item_cd= 50 THEN amt_end END) AS bank_sub_029,
MAX(CASE WHEN item_cd= 51 THEN amt_end END) AS bank_sub_030,
MAX(CASE WHEN item_cd= 52 THEN amt_end END) AS bank_sub_031,
MAX(CASE WHEN item_cd= 53 THEN amt_end END) AS bank_sub_032,
MAX(CASE WHEN item_cd= 55 THEN amt_end END) AS bank_sub_033,
MAX(CASE WHEN item_cd= 56 THEN amt_end END) AS bank_sub_034,
MAX(CASE WHEN item_cd= 57 THEN amt_end END) AS bank_sub_035,
MAX(CASE WHEN item_cd= 58 THEN amt_end END) AS bank_sub_036,
MAX(CASE WHEN item_cd= 59 THEN amt_end END) AS bank_sub_037,
MAX(CASE WHEN item_cd= 60 THEN amt_end END) AS bank_sub_038,
MAX(CASE WHEN item_cd= 62 THEN amt_end END) AS bank_sub_039,
MAX(CASE WHEN item_cd= 63 THEN amt_end END) AS bank_sub_040,
MAX(CASE WHEN item_cd= 64 THEN amt_end END) AS bank_sub_041,
MAX(CASE WHEN item_cd= 65 THEN amt_end END) AS bank_sub_042,
MAX(CASE WHEN item_cd= 67 THEN amt_end END) AS bank_sub_043,
MAX(CASE WHEN item_cd= 68 THEN amt_end END) AS bank_sub_044,
MAX(CASE WHEN item_cd= 69 THEN amt_end END) AS bank_sub_045,
MAX(CASE WHEN item_cd= 70 THEN amt_end END) AS bank_sub_046,
MAX(CASE WHEN item_cd= 71 THEN amt_end END) AS bank_sub_047,
MAX(CASE WHEN item_cd= 72 THEN amt_end END) AS bank_sub_048,
MAX(CASE WHEN item_cd= 73 THEN amt_end END) AS bank_sub_049,
MAX(CASE WHEN item_cd= 74 THEN amt_end END) AS bank_sub_050,
MAX(CASE WHEN item_cd= 75 THEN amt_end END) AS bank_sub_051,
MAX(CASE WHEN item_cd= 76 THEN amt_end END) AS bank_sub_052,
MAX(CASE WHEN item_cd= 77 THEN amt_end END) AS bank_sub_053,
MAX(CASE WHEN item_cd= 78 THEN amt_end END) AS bank_sub_054,
MAX(CASE WHEN item_cd= 79 THEN amt_end END) AS bank_sub_055,
MAX(CASE WHEN item_cd= 80 THEN amt_end END) AS bank_sub_056,
MAX(CASE WHEN item_cd= 81 THEN amt_end END) AS bank_sub_057,
MAX(CASE WHEN item_cd= 82 THEN amt_end END) AS bank_sub_058,
MAX(CASE WHEN item_cd= 83 THEN amt_end END) AS bank_sub_059,
MAX(CASE WHEN item_cd= 84 THEN amt_end END) AS bank_sub_060,
MAX(CASE WHEN item_cd= 85 THEN amt_end END) AS bank_sub_061,
MAX(CASE WHEN item_cd= 86 THEN amt_end END) AS bank_sub_062,
MAX(CASE WHEN item_cd= 87 THEN amt_end END) AS bank_sub_063,
MAX(CASE WHEN item_cd= 88 THEN amt_end END) AS bank_sub_064,
MAX(CASE WHEN item_cd= 89 THEN amt_end END) AS bank_sub_065,
MAX(CASE WHEN item_cd= 90 THEN amt_end END) AS bank_sub_066,
MAX(CASE WHEN item_cd= 91 THEN amt_end END) AS bank_sub_067,
MAX(CASE WHEN item_cd= 92 THEN amt_end END) AS bank_sub_068,
MAX(CASE WHEN item_cd= 93 THEN amt_end END) AS bank_sub_069,
MAX(CASE WHEN item_cd= 94 THEN amt_end END) AS bank_sub_070,
MAX(CASE WHEN item_cd= 95 THEN amt_end END) AS bank_sub_071,
MAX(CASE WHEN item_cd= 96 THEN amt_end END) AS bank_sub_072,
MAX(CASE WHEN item_cd= 97 THEN amt_end END) AS bank_sub_073,
MAX(CASE WHEN item_cd= 98 THEN amt_end END) AS bank_sub_074,
MAX(CASE WHEN item_cd= 100 THEN amt_end END) AS bank_sub_075,
MAX(CASE WHEN item_cd= 102 THEN amt_end END) AS bank_sub_076,
MAX(CASE WHEN item_cd= 103 THEN amt_end END) AS bank_sub_077,
MAX(CASE WHEN item_cd= 104 THEN amt_end END) AS bank_sub_078,
MAX(CASE WHEN item_cd= 105 THEN amt_end END) AS bank_sub_079,
MAX(CASE WHEN item_cd= 106 THEN amt_end END) AS bank_sub_080,
MAX(CASE WHEN item_cd= 107 THEN amt_end END) AS bank_sub_081,
MAX(CASE WHEN item_cd= 108 THEN amt_end END) AS bank_sub_082,
MAX(CASE WHEN item_cd= 109 THEN amt_end END) AS bank_sub_083,
MAX(CASE WHEN item_cd= 110 THEN amt_end END) AS bank_sub_084,
MAX(CASE WHEN item_cd= 111 THEN amt_end END) AS bank_sub_085,
MAX(CASE WHEN item_cd= 112 THEN amt_end END) AS bank_sub_086,
MAX(CASE WHEN item_cd= 114 THEN amt_end END) AS bank_sub_087,
MAX(CASE WHEN item_cd= 115 THEN amt_end END) AS bank_sub_088,
MAX(CASE WHEN item_cd= 116 THEN amt_end END) AS bank_sub_089,
MAX(CASE WHEN item_cd= 117 THEN amt_end END) AS bank_sub_090,
MAX(CASE WHEN item_cd= 118 THEN amt_end END) AS bank_sub_091,
MAX(CASE WHEN item_cd= 119 THEN amt_end END) AS bank_sub_092,
MAX(CASE WHEN item_cd= 120 THEN amt_end END) AS bank_sub_093,
MAX(CASE WHEN item_cd= 121 THEN amt_end END) AS bank_sub_094,
MAX(CASE WHEN item_cd= 122 THEN amt_end END) AS bank_sub_095,
MAX(CASE WHEN item_cd= 123 THEN amt_end END) AS bank_sub_096,
MAX(CASE WHEN item_cd= 124 THEN amt_end END) AS bank_sub_097,
MAX(CASE WHEN item_cd= 125 THEN amt_end END) AS bank_sub_098,
MAX(CASE WHEN item_cd= 126 THEN amt_end END) AS bank_sub_099,
MAX(CASE WHEN item_cd= 127 THEN amt_end END) AS bank_sub_100,
MAX(CASE WHEN item_cd= 128 THEN amt_end END) AS bank_sub_101,
MAX(CASE WHEN item_cd= 129 THEN amt_end END) AS bank_sub_102,
MAX(CASE WHEN item_cd= 130 THEN amt_end END) AS bank_sub_103,
MAX(CASE WHEN item_cd= 131 THEN amt_end END) AS bank_sub_104,
MAX(CASE WHEN item_cd= 132 THEN amt_end END) AS bank_sub_105,
MAX(CASE WHEN item_cd= 133 THEN amt_end END) AS bank_sub_106,
MAX(CASE WHEN item_cd= 134 THEN amt_end END) AS bank_sub_107,
MAX(CASE WHEN item_cd= 135 THEN amt_end END) AS bank_sub_108,
MAX(CASE WHEN item_cd= 136 THEN amt_end END) AS bank_sub_109,
MAX(CASE WHEN item_cd= 137 THEN amt_end END) AS bank_sub_110,
MAX(CASE WHEN item_cd= 139 THEN amt_end END) AS bank_sub_111,
MAX(CASE WHEN item_cd= 140 THEN amt_end END) AS bank_sub_112,
MAX(CASE WHEN item_cd= 141 THEN amt_end END) AS bank_sub_113,
MAX(CASE WHEN item_cd= 142 THEN amt_end END) AS bank_sub_114,
MAX(CASE WHEN item_cd= 143 THEN amt_end END) AS bank_sub_115,
MAX(CASE WHEN item_cd= 144 THEN amt_end END) AS bank_sub_116,
MAX(CASE WHEN item_cd= 145 THEN amt_end END) AS bank_sub_117,
MAX(CASE WHEN item_cd= 146 THEN amt_end END) AS bank_sub_118,
MAX(CASE WHEN item_cd= 147 THEN amt_end END) AS bank_sub_119,
MAX(CASE WHEN item_cd= 148 THEN amt_end END) AS bank_sub_120,
MAX(CASE WHEN item_cd= 149 THEN amt_end END) AS bank_sub_121,
MAX(CASE WHEN item_cd= 150 THEN amt_end END) AS bank_sub_122,
MAX(CASE WHEN item_cd= 151 THEN amt_end END) AS bank_sub_123,
MAX(CASE WHEN item_cd= 152 THEN amt_end END) AS bank_sub_124,
MAX(CASE WHEN item_cd= 153 THEN amt_end END) AS bank_sub_125
FROM
(
SELECT
a.company_id,
CASE WHEN a.unit = 2 THEN a.amt_end*1000
          WHEN  a.unit = 3 THEN a.amt_end*10000
          WHEN  a.unit = 4 THEN a.amt_end*1000000
      WHEN  a.unit = 5 THEN a.amt_end/100
          WHEN  a.unit = 6 THEN a.amt_end*100000000
          ELSE amt_end END AS amt_end ,
b.finindex,
a.rpt_dt,
a.item_cd,
ROW_number()OVER(PARTITION BY a.company_id,a.rpt_dt,b.finindex ORDER BY a.end_dt DESC ) AS ROW_num
 FROM COMPY_BANKADDFIN  a
JOIN LKP_FINANCE_INDEX b ON  a.item_cd = b.index_id
WHERE a.rpt_dt IN (SELECT rpt_dt FROM wrk_report_date_list)
AND a.combine_type_cd =1
AND b.index_type = 1
AND a.isdel=0
AND b.isdel=0
) a
WHERE row_num=1
GROUP BY company_id,rpt_dt';
EXECUTE IMMEDIATE vSQL;

SP_DROP_IF_EXIST('wrk_compy_bank_addfin');
vSQL := 'CREATE TABLE wrk_compy_bank_addfin
AS
SELECT
a.company_id,
a.rpt_dt,
a.rpt_timetype_cd,
b.bank_sub_005,
b.bank_sub_006,
b.bank_sub_014,
b.bank_sub_015,
b.bank_sub_016,
b.bank_sub_022,
b.bank_sub_067,
b.bank_sub_071,
b.bank_sub_073,
b.bank_sub_074,
b.bank_sub_112,
cast(null as number(24,4)) as owner_asset,--固有资产
cast(null as number(24,4)) as new_prod_amt,--新发行产品总金额
cast(null as number(24,4)) as trust_loan_amt,--信托资产贷款总额
cast(null as number(24,4)) as trust_quity_inv,--信托资产长期股权投资
cast(null as number(24,4)) as comp_reserve_fund,--赔偿准备金
cast(null as number(24,4)) as collect_trust_size,--集合类信托资产规模
b.bank_sub_116,
b.bank_sub_117,
b.bank_sub_119,
b.bank_sub_124,
b.bank_sub_125,
b.bank_sub_001,b.bank_sub_062,b.bank_sub_032,b.bank_sub_091,
b.bank_sub_002,b.bank_sub_063,b.bank_sub_033,b.bank_sub_092,
b.bank_sub_003,b.bank_sub_064,b.bank_sub_034,b.bank_sub_093,
b.bank_sub_004,b.bank_sub_065,b.bank_sub_035,b.bank_sub_094,
b.bank_sub_007,b.bank_sub_066,b.bank_sub_036,b.bank_sub_095,
b.bank_sub_008,b.bank_sub_068,b.bank_sub_037,b.bank_sub_096,
b.bank_sub_009,b.bank_sub_069,b.bank_sub_038,b.bank_sub_097,
b.bank_sub_010,b.bank_sub_070,b.bank_sub_039,b.bank_sub_098,
b.bank_sub_011,b.bank_sub_072,b.bank_sub_040,b.bank_sub_099,
b.bank_sub_012,b.bank_sub_075,b.bank_sub_041,b.bank_sub_100,
b.bank_sub_013,b.bank_sub_076,b.bank_sub_042,b.bank_sub_101,
b.bank_sub_017,b.bank_sub_077,b.bank_sub_043,b.bank_sub_102,
b.bank_sub_018,b.bank_sub_078,b.bank_sub_044,b.bank_sub_103,
b.bank_sub_019,b.bank_sub_079,b.bank_sub_045,b.bank_sub_104,
b.bank_sub_020,b.bank_sub_080,b.bank_sub_046,b.bank_sub_105,
b.bank_sub_021,b.bank_sub_081,b.bank_sub_047,b.bank_sub_106,
b.bank_sub_023,b.bank_sub_082,b.bank_sub_048,b.bank_sub_107,
b.bank_sub_024,b.bank_sub_083,b.bank_sub_049,b.bank_sub_108,
b.bank_sub_025,b.bank_sub_084,b.bank_sub_050,b.bank_sub_109,
b.bank_sub_026,b.bank_sub_085,b.bank_sub_051,b.bank_sub_110,
b.bank_sub_027,b.bank_sub_086,b.bank_sub_052,b.bank_sub_111,
b.bank_sub_028,b.bank_sub_087,b.bank_sub_053,b.bank_sub_113,
b.bank_sub_029,b.bank_sub_088,b.bank_sub_054,b.bank_sub_114,
b.bank_sub_030,b.bank_sub_089,b.bank_sub_055,b.bank_sub_115,
b.bank_sub_031,b.bank_sub_090,b.bank_sub_056,b.bank_sub_118,
b.bank_sub_057,b.bank_sub_120,b.bank_sub_058,b.bank_sub_121,
b.bank_sub_059,b.bank_sub_122,b.bank_sub_060,b.bank_sub_123,
b.bank_sub_061,
CASE WHEN b.company_id is null then ''N'' ELSE ''Y'' END AS bankaddfin_flg
from wrk_compy_id_all a
left join wrk_compy_bank_addfin_temp b on a.company_id = b.company_id and a.rpt_dt = b.rpt_dt and a.rpt_timetype_cd = b.rpt_timetype_cd';
EXECUTE IMMEDIATE vSQL;

--step5:创建保险公司监管指标表
SP_DROP_IF_EXIST('wrk_compy_insurerindex');
vSQL := 'CREATE TABLE wrk_compy_insurerindex
AS
SELECT
c.company_id,
c.rpt_dt,
c.rpt_timetype_cd,
--a.solven_ratio_cx,通过实际资本/最低资本计算得出
--NVL(a.solven_ratio_sx,b.solven_ratio_sx/100)  AS solven_ratio_sx, 通过实际资本/最低资本计算得出
a.com_expend,
a.inv_asset_cx,
a.udr_reserve_sx,
a.udr_reserve_cx,
a.comexpend_cx,
a.earnprem_sx,
a.inv_asset_sx,
a.ostlr_cx,
a.ror_cx,
a.inv_asset,
a.ostlr_sx,
a.earnprem_cx,
a.earnprem,
a.com_expend_sx,
a.com_compensate_cx,
a.solven_ratio_sx,
a.com_cost_cx,
a.earnprem_gr_cx,
a.nrorsx,
a.nror,
a.tror,
a.solven_ratio_cx,
a.earnprem_gr_sx,
a.solven_ratio,
a.nror_cx,
a.earnprem_gr,
a.sur_rate,
a.ror_sx,
a.act_capit_cx,
a.act_capit_sx,
a.min_capit_cx,
a.min_capit_sx,
a.act_capit,
a.min_capit,
CASE WHEN a.company_id is null then ''N'' ELSE ''Y'' END AS insurerindex_flg
FROM wrk_compy_id_all c
LEFT JOIN
  (SELECT a.company_id,
  a.rpt_dt,
  CASE  substr(to_char(a.rpt_dt),5,2) WHEN ''03'' then 3 WHEN ''06'' THEN 2 WHEN ''09'' THEN 4 WHEN ''12'' THEN 1 END AS rpt_timetype_cd, 
CASE WHEN a.unit=2 THEN 1000*com_expend     WHEN a.unit=3 THEN 10000*com_expend     WHEN a.unit=4 THEN 1000000*com_expend     ELSE com_expend     END AS com_expend    ,
CASE WHEN a.unit=2 THEN 1000*act_capit_sx   WHEN a.unit=3 THEN 10000*act_capit_sx   WHEN a.unit=4 THEN 1000000*act_capit_sx   ELSE act_capit_sx   END AS act_capit_sx  ,
CASE WHEN a.unit=2 THEN 1000*act_capit_cx   WHEN a.unit=3 THEN 10000*act_capit_cx   WHEN a.unit=4 THEN 1000000*act_capit_cx   ELSE act_capit_cx   END AS act_capit_cx  ,
CASE WHEN a.unit=2 THEN 1000*inv_asset_cx   WHEN a.unit=3 THEN 10000*inv_asset_cx   WHEN a.unit=4 THEN 1000000*inv_asset_cx   ELSE inv_asset_cx   END AS inv_asset_cx  ,
CASE WHEN a.unit=2 THEN 1000*udr_reserve_sx WHEN a.unit=3 THEN 10000*udr_reserve_sx WHEN a.unit=4 THEN 1000000*udr_reserve_sx ELSE udr_reserve_sx END AS udr_reserve_sx,
CASE WHEN a.unit=2 THEN 1000*min_capit_sx   WHEN a.unit=3 THEN 10000*min_capit_sx   WHEN a.unit=4 THEN 1000000*min_capit_sx   ELSE min_capit_sx   END AS min_capit_sx  ,
CASE WHEN a.unit=2 THEN 1000*udr_reserve_cx WHEN a.unit=3 THEN 10000*udr_reserve_cx WHEN a.unit=4 THEN 1000000*udr_reserve_cx ELSE udr_reserve_cx END AS udr_reserve_cx,
CASE WHEN a.unit=2 THEN 1000*comexpend_cx   WHEN a.unit=3 THEN 10000*comexpend_cx   WHEN a.unit=4 THEN 1000000*comexpend_cx   ELSE comexpend_cx   END AS comexpend_cx  ,
CASE WHEN a.unit=2 THEN 1000*earnprem_sx    WHEN a.unit=3 THEN 10000*earnprem_sx    WHEN a.unit=4 THEN 1000000*earnprem_sx    ELSE earnprem_sx    END AS earnprem_sx   ,
CASE WHEN a.unit=2 THEN 1000*min_capit      WHEN a.unit=3 THEN 10000*min_capit      WHEN a.unit=4 THEN 1000000*min_capit      ELSE min_capit      END AS min_capit     ,
CASE WHEN a.unit=2 THEN 1000*act_capit      WHEN a.unit=3 THEN 10000*act_capit      WHEN a.unit=4 THEN 1000000*act_capit      ELSE act_capit      END AS act_capit     ,
CASE WHEN a.unit=2 THEN 1000*inv_asset_sx   WHEN a.unit=3 THEN 10000*inv_asset_sx   WHEN a.unit=4 THEN 1000000*inv_asset_sx   ELSE inv_asset_sx   END AS inv_asset_sx  ,
CASE WHEN a.unit=2 THEN 1000*ostlr_cx       WHEN a.unit=3 THEN 10000*ostlr_cx       WHEN a.unit=4 THEN 1000000*ostlr_cx       ELSE ostlr_cx       END AS ostlr_cx      ,
CASE WHEN a.unit=2 THEN 1000*ror_cx         WHEN a.unit=3 THEN 10000*ror_cx         WHEN a.unit=4 THEN 1000000*ror_cx         ELSE ror_cx         END AS ror_cx        ,
CASE WHEN a.unit=2 THEN 1000*inv_asset      WHEN a.unit=3 THEN 10000*inv_asset      WHEN a.unit=4 THEN 1000000*inv_asset      ELSE inv_asset      END AS inv_asset     ,
CASE WHEN a.unit=2 THEN 1000*ostlr_sx       WHEN a.unit=3 THEN 10000*ostlr_sx       WHEN a.unit=4 THEN 1000000*ostlr_sx       ELSE ostlr_sx       END AS ostlr_sx      ,
CASE WHEN a.unit=2 THEN 1000*min_capit_cx   WHEN a.unit=3 THEN 10000*min_capit_cx   WHEN a.unit=4 THEN 1000000*min_capit_cx   ELSE min_capit_cx   END AS min_capit_cx  ,
CASE WHEN a.unit=2 THEN 1000*earnprem_cx    WHEN a.unit=3 THEN 10000*earnprem_cx    WHEN a.unit=4 THEN 1000000*earnprem_cx    ELSE earnprem_cx    END AS earnprem_cx   ,
CASE WHEN a.unit=2 THEN 1000*earnprem       WHEN a.unit=3 THEN 10000*earnprem       WHEN a.unit=4 THEN 1000000*earnprem       ELSE earnprem       END AS earnprem      ,
CASE WHEN a.unit=2 THEN 1000*com_expend_sx  WHEN a.unit=3 THEN 10000*com_expend_sx  WHEN a.unit=4 THEN 1000000*com_expend_sx  ELSE com_expend_sx  END AS com_expend_sx ,
com_compensate_cx/100 AS com_compensate_cx,
solven_ratio_sx/100   AS solven_ratio_sx  ,
com_cost_cx/100       AS com_cost_cx      ,
earnprem_gr_cx/100    AS earnprem_gr_cx   ,
nrorsx/100            AS nrorsx           ,
nror/100              AS nror             ,
tror/100              AS tror             ,
solven_ratio_cx/100   AS solven_ratio_cx  ,
earnprem_gr_sx/100    AS earnprem_gr_sx   ,
solven_ratio/100      AS solven_ratio     ,
nror_cx/100           AS nror_cx          ,
earnprem_gr/100       AS earnprem_gr      ,
sur_rate/100          AS sur_rate         ,
ror_sx/100            AS ror_sx           
  FROM COMPY_INSURERINDEX a
  WHERE a.rpt_dt IN (SELECT rpt_dt FROM wrk_report_date_list)
  AND a.isdel = 0
  ) a ON c.company_id = a.company_id AND c.rpt_dt = a.rpt_dt and c.rpt_timetype_cd = a.rpt_timetype_cd';
EXECUTE IMMEDIATE vSQL;

--step5:创建证券公司风险控制指标表
SP_DROP_IF_EXIST('wrk_compy_secriskindex_temp');
vSQL := 'CREATE TABLE wrk_compy_secriskindex_temp
AS
SELECT
a.company_id,
a.rpt_dt,
CASE  substr(to_char(a.rpt_dt),5,2) WHEN ''03'' then 3 WHEN ''06'' THEN 2 WHEN ''09'' THEN 4 WHEN ''12'' THEN 1 END AS rpt_timetype_cd,
MAX(CASE WHEN item_cd=1  THEN end_amt END)  AS secu_sub_001,
MAX(CASE WHEN item_cd=2 THEN end_amt END)   AS secu_sub_002,
MAX(CASE WHEN item_cd=3 THEN end_amt END)   AS secu_sub_003,
MAX(CASE WHEN item_cd=4 THEN end_amt END)   AS secu_sub_004,
MAX(CASE WHEN item_cd=5  THEN end_amt END)  AS secu_sub_005,
MAX(CASE WHEN item_cd=6 THEN end_amt END)   AS secu_sub_006,
MAX(CASE WHEN item_cd=7 THEN end_amt END)   AS secu_sub_007,
MAX(CASE WHEN item_cd=8 THEN end_amt END)   AS secu_sub_008,
MAX(CASE WHEN item_cd=9  THEN end_amt END)  AS secu_sub_009,
MAX(CASE WHEN item_cd=10  THEN end_amt END) AS secu_sub_010,
MAX(CASE WHEN item_cd=11 THEN end_amt END)  AS secu_sub_011,
MAX(CASE WHEN item_cd=12  THEN end_amt END) AS secu_sub_012,
MAX(CASE WHEN item_cd=13  THEN end_amt END) AS secu_sub_013,
MAX(CASE WHEN item_cd=14 THEN end_amt END)  AS secu_sub_014,
MAX(CASE WHEN item_cd=15 THEN end_amt END)  AS secu_sub_015,
MAX(CASE WHEN item_cd=16  THEN end_amt END) AS secu_sub_016,
MAX(CASE WHEN item_cd=17  THEN end_amt END) AS secu_sub_017,
MAX(CASE WHEN item_cd=18 THEN end_amt END)  AS secu_sub_018
FROM
  (
  SELECT
  a.company_id,
  CASE WHEN a.unit = 2 THEN a.end_amt*1000
          WHEN  a.unit = 3 THEN a.end_amt*10000
          WHEN  a.unit = 4 THEN a.end_amt*1000000
      WHEN  a.unit = 5 THEN a.end_amt/100
          ELSE end_amt END AS end_amt,
  b.finindex,
  a.rpt_dt,
  a.item_cd,
  ROW_number()OVER(PARTITION BY a.company_id,a.rpt_dt,b.finindex ORDER BY a.updt_dt DESC ) AS ROW_num
   FROM compy_secriskindex  a
  JOIN LKP_FINANCE_INDEX b ON  a.item_cd = b.index_id
  WHERE a.rpt_dt IN  (SELECT rpt_dt FROM wrk_report_date_list)
  AND b.index_type = 2
  AND a.isdel=0
  AND b.isdel=0
  ) a
WHERE row_num=1
GROUP BY company_id,rpt_dt';
EXECUTE IMMEDIATE vSQL;

SP_DROP_IF_EXIST('wrk_compy_secriskindex');
vSQL := 'CREATE TABLE wrk_compy_secriskindex
AS
SELECT
a.company_id,
a.rpt_dt,
a.rpt_timetype_cd,
b.secu_sub_011,
b.secu_sub_014,
b.secu_sub_018,
b.secu_sub_002,
b.secu_sub_009,
b.secu_sub_012,
b.secu_sub_001,
b.secu_sub_003,
b.secu_sub_004,
b.secu_sub_005,
b.secu_sub_006,
b.secu_sub_007,
b.secu_sub_008,
b.secu_sub_010,
b.secu_sub_013,
b.secu_sub_015,
b.secu_sub_016,
b.secu_sub_017,
CASE WHEN b.company_id is null then ''N'' ELSE ''Y'' END AS secriskindex_flg
from wrk_compy_id_all a
left join wrk_compy_secriskindex_temp b on a.company_id = b.company_id and a.rpt_dt = b.rpt_dt and a.rpt_timetype_cd = b.rpt_timetype_cd';
EXECUTE IMMEDIATE vSQL;

--step6:创建关注类贷款财务附注表
SP_DROP_IF_EXIST('wrk_compy_fcoloan');
--step6.1:创建五级分类后三类的资产合计表
SP_DROP_IF_EXIST('wrk_compy_fcoloan_sum');
--step7:创建十大贷款客户财务附注表
SP_DROP_IF_EXIST('wrk_compy_top10lc');
--信托行业规模
SP_DROP_IF_EXIST('wrk_trust_industry_size');

SP_DROP_IF_EXIST('wrk_compy_finance');
SP_DROP_IF_EXIST('wrk_compy_finance_last_y');
SP_DROP_IF_EXIST('wrk_compy_finance_bf_last_y');

vSQL := 'create table wrk_compy_finance as select * from compy_finance where 1=0';
EXECUTE IMMEDIATE vSQL;

vSQL := 'create table wrk_compy_finance_last_y as select * from compy_finance_last_y where 1=0';
EXECUTE IMMEDIATE vSQL;

vSQL := 'create table wrk_compy_finance_bf_last_y as select * from compy_finance_bf_last_y where 1=0';
EXECUTE IMMEDIATE vSQL;

vSQL := 'INSERT INTO  wrk_compy_finance
SELECT
a.company_id,
to_date(to_char(a.rpt_dt),''YYYYMMDD'') AS rpt_dt,
coalesce(b.fst_notice_dt,coalesce(c.first_notice_dt,g.first_notice_dt)) AS fst_notice_dt,
coalesce(b.latest_notice_dt,coalesce(c.latest_notice_dt,g.latest_notice_dt)) AS latest_notice_dt,
coalesce(b.start_dt,coalesce(c.start_dt,g.start_dt)) AS start_dt,
coalesce(b.end_dt,coalesce(c.end_dt,g.end_dt)) AS end_dt,
a.rpt_timetype_cd,
coalesce(b.combine_type_cd,coalesce(c.combine_type_cd,g.combine_type_cd)) AS combine_type_cd,
coalesce(b.rpt_srctype_id,coalesce(c.rpt_srctype_id,g.rpt_srctype_id)) AS rpt_srctype_id,
coalesce(b.data_ajust_type,coalesce(c.data_ajust_type,g.data_ajust_type)) AS data_ajust_type,
coalesce(b.data_type,coalesce(c.data_type,g.data_type)) AS data_type,
coalesce(b.is_public_rpt,coalesce(c.is_public_rpt,g.is_public_rpt)) AS is_public_rpt,
coalesce(b.company_type,coalesce(c.company_type,g.company_type)) AS company_type,
coalesce(b.currency,coalesce(c.currency,g.currency)) AS currency,
----------------------------------------------balancesheet----------------------------------------------
monetary_fund,
tradef_asset,
bill_rec,
account_rec,
other_rec,
advance_pay,
dividend_rec,
interest_rec,
inventory,
nonl_asset_oneyear,
defer_expense,
other_lasset,
lasset_other,
lasset_balance,
sum_lasset,
saleable_fasset,
held_maturity_inv,
estate_invest,
lte_quity_inv,
ltrec,
fixed_asset,
construction_material,
construction_progress,
liquidate_fixed_asset,
product_biology_asset,
oilgas_asset,
intangible_asset,
develop_exp,
good_will,
ltdefer_asset,
defer_incometax_asset,
other_nonl_asset,
nonlasset_other,
nonlasset_balance,
sum_nonl_asset,
cash_and_depositcbank,
deposit_infi,
fi_deposit,
precious_metal,
lend_fund,
derive_fasset,
buy_sellback_fasset,
loan_advances,
agency_assets,
coalesce(b.premium_rec,g.premium_rec) AS premium_rec,
subrogation_rec,
ri_rec,
undue_rireserve_rec,
claim_rireserve_rec,
life_rireserve_rec,
lthealth_rireserve_rec,
gdeposit_pay,
insured_pledge_loan,
capitalg_deposit_pay,
independent_asset,
client_fund,
settlement_provision,
client_provision,
seat_fee,
other_asset,
asset_other,
asset_balance,
sum_asset,
st_borrow,
trade_fliab,
bill_pay,
account_pay,
advance_receive,
salary_pay,
coalesce(b.tax_pay,g.tax_pay) AS tax_pay,
interest_pay,
dividend_pay,
other_pay,
accrue_expense,
anticipate_liab,
defer_income,
nonl_liab_oneyear,
other_lliab,
lliab_other,
lliab_balance,
sum_lliab,
lt_borrow,
bond_pay,
lt_account_pay,
special_pay,
defer_incometax_liab,
other_nonl_liab,
nonl_liab_other,
nonl_liab_balance,
sum_nonl_liab,
borrow_from_cbank,
borrow_fund,
derive_financedebt,
sell_buyback_fasset,
accept_deposit,
agency_liab,
other_liab,
premium_advance,
comm_pay,
ri_pay,
gdeposit_rec,
insured_deposit_inv,
coalesce(b.undue_reserve,c.undue_reserve) AS undue_reserve,
claim_reserve,
life_reserve,
lt_health_reserve,
independent_liab,
pledge_borrow,
coalesce(b.agent_trade_security,c.agent_trade_security) AS agent_trade_security,
agent_uw_security,
liab_other,
liab_balance,
sum_liab,
share_capital,
capital_reserve,
surplus_reserve,
retained_earning,
inventory_share,
general_risk_prepare,
diff_conversion_fc,
minority_equity,
sh_equity_other,
sh_equity_balance,
sum_parent_equity,
sum_sh_equity,
liabsh_equity_other,
liabsh_equity_balance,
sum_liabsh_equity,
td_eposit,
st_bond_rec,
claim_pay,
policy_divi_pay,
unconfirm_inv_loss,
ricontact_reserve_rec,
deposit,
contact_reserve,
invest_rec,
specia_lreserve,
subsidy_rec,
marginout_fund,
export_rebate_rec,
defer_income_oneyear,
lt_salary_pay,
fvalue_fasset,
define_fvalue_fasset,
internal_rec,
clheld_sale_ass,
fvalue_fliab,
define_fvalue_fliab,
internal_pay,
clheld_sale_liab,
anticipate_lliab,
other_equity,
coalesce(b.other_cincome,c.other_cincome) AS other_cincome,
plan_cash_divi,
parent_equity_other,
parent_equity_balance,
preferred_stock,
prefer_stoc_bond,
cons_biolo_asset,
stock_num_end,
net_mas_set,
outward_remittance,
cdandbill_rec,
hedge_reserve,
suggest_assign_divi,
marginout_security,
cagent_trade_security,
trade_risk_prepare,
creditor_planinv,
short_financing,--新增应付短期融资款
receivables,--新增应收款项
----------------------------------------------incomestate----------------------------------------------
operate_reve,
operate_exp,
operate_tax,
sale_exp,
manage_exp,
coalesce(c.finance_exp,g.finance_exp)  AS finance_exp,
asset_devalue_loss,
fvalue_income,
invest_income,
intn_reve,
int_reve,
int_exp,
commn_reve,
comm_reve,
comm_exp,
exchange_income,
premium_earned,
premium_income,
ripremium,
premium_exp,
indemnity_exp,
amortise_indemnity_exp,
duty_reserve,
amortise_duty_reserve,
rireve,
riexp,
surrender_premium,
policy_divi_exp,
amortise_riexp,
security_uw,
client_asset_manage,
operate_profit_other,
operate_profit_balance,
operate_profit,
nonoperate_reve,
nonoperate_exp,
nonlasset_net_loss,
sum_profit_other,
sum_profit_balance,
sum_profit,
income_tax,
net_profit_other2,
net_profit_balance1,
net_profit_balance2,
coalesce(c.net_profit,g.net_profit) AS net_profit,
parent_net_profit,
minority_income,
undistribute_profit,
basic_eps,
diluted_eps,
invest_joint_income,
total_operate_reve,
total_operate_exp,
other_reve,
other_exp,
unconfirm_invloss,
sum_cincome,
parent_cincome,
minority_cincome,
net_contact_reserve,
rdexp,
operate_manage_exp,
insur_reve,
nonlasset_reve,
total_operatereve_other,
net_indemnity_exp,
total_operateexp_other,
net_profit_other1,
cincome_balance1,
cincome_balance2,
other_net_income,
reve_other,
reve_balance,
operate_exp_other,
operate_exp_balance,
bank_intnreve,
bank_intreve,
ninsur_commn_reve,
ninsur_comm_reve,
ninsur_comm_exp,
----------------------------------------------cashflow----------------------------------------------
salegoods_service_rec,
tax_return_rec,
other_operate_rec,
ni_deposit,
niborrow_from_cbank,
niborrow_from_fi,
nidisp_trade_fasset,
nidisp_saleable_fasset,
niborrow_fund,
nibuyback_fund,
operate_flowin_other,
operate_flowin_balance,
sum_operate_flowin,
buygoods_service_pay,
employee_pay,
other_operat_epay,
niloan_advances,
nideposit_incbankfi,
indemnity_pay,
intandcomm_pay,
operate_flowout_other,
operate_flowout_balance,
sum_operate_flowout,
operate_flow_other,
operate_flow_balance,
net_operate_cashflow,
disposal_inv_rec,
inv_income_rec,
disp_filasset_rec,
disp_subsidiary_rec,
other_invrec,
inv_flowin_other,
inv_flowin_balance,
sum_inv_flowin,
buy_filasset_pay,
inv_pay,
get_subsidiary_pay,
other_inv_pay,
nipledge_loan,
inv_flowout_other,
inv_flowout_balance,
sum_inv_flowout,
inv_flow_other,
inv_cashflow_balance,
net_inv_cashflow,
accept_inv_rec,
loan_rec,
other_fina_rec,
issue_bond_rec,
niinsured_deposit_inv,
fina_flowin_other,
fina_flowin_balance,
sum_fina_flowin,
repay_debt_pay,
divi_profitorint_pay,
other_fina_pay,
fina_flowout_other,
fina_flowout_balance,
sum_fina_flowout,
fina_flow_other,
fina_flow_balance,
net_fina_cashflow,
effect_exchange_rate,
nicash_equi_other,
nicash_equi_balance,
nicash_equi,
cash_equi_beginning,
cash_equi_ending,
asset_devalue,
fixed_asset_etcdepr,
intangible_asset_amor,
ltdefer_exp_amor,
defer_exp_reduce,
drawing_exp_add,
disp_filasset_loss,
fixed_asset_loss,
fvalue_loss,
inv_loss,
defer_taxasset_reduce,
defer_taxliab_add,
inventory_reduce,
operate_rec_reduce,
operate_pay_add,
inoperate_flow_other,
inoperate_flow_balance,
innet_operate_cashflow,
debt_to_capital,
cb_oneyear,
finalease_fixed_asset,
cash_end,
cash_begin,
equi_end,
equi_begin,
innicash_equi_other,
innicash_equi_balance,
innicash_equi,
other,
subsidiary_accept,
subsidiary_pay,
divi_pay,
intandcomm_rec,
net_rirec,
nilend_fund,
defer_tax,
defer_income_amor,
exchange_loss,
fixandestate_depr,
fixed_asset_depr,
tradef_asset_reduce,
ndloan_advances,
reduce_pledget_deposit,
add_pledget_deposit,
buy_subsidiary_pay,
cash_equiending_other,
cash_equiending_balance,
nd_depositinc_bankfi,
niborrow_sell_buyback,
ndlend_buy_sellback,
net_cd,
nitrade_fliab,
ndtrade_fasset,
disp_masset_rec,
cancel_loan_rec,
ndborrow_from_cbank,
ndfide_posit,
ndissue_cd,
nilend_sell_buyback,
ndborrow_sell_buyback,
nitrade_fasset,
ndtrade_fliab,
buy_finaleaseasset_pay,
niaccount_rec,
issue_cd,
addshare_capital_rec,
issue_share_rec,
bond_intpay,
niother_finainstru,
uwsecurity_rec,
buysellback_fasset_rec,
agent_uwsecurity_rec,
nidirect_inv,
nitrade_settlement,
buysellback_fasset_pay,
nddisp_trade_fasset,
ndother_fina_instr,
ndborrow_fund,
nddirect_inv,
ndtrade_settlement,
ndbuyback_fund,
agenttrade_security_pay,
nddisp_saleable_fasset,
nisell_buyback,
ndbuy_sellback,
nettrade_fasset_rec,
net_ripay,
ndlend_fund,
nibuy_sellback,
ndsell_buyback,
ndinsured_deposit_inv,
nettrade_fasset_pay,
niinsured_pledge_loan,
disp_subsidiary_pay,
netsell_buyback_fassetrec,
netsell_buyback_fassetpay,
case when coalesce(int_exp,0)-coalesce(int_reve,0) = 0 then coalesce(sum_profit,0)+coalesce(coalesce(c.finance_exp,g.finance_exp),0) else coalesce(sum_profit,0)+coalesce(int_exp,0)-coalesce(int_reve,0) end as ebit,
case when coalesce(int_exp,0)-coalesce(int_reve,0) = 0 then coalesce(sum_profit,0)+coalesce(coalesce(c.finance_exp,g.finance_exp),0)+coalesce(fixed_asset_depr,0)+coalesce(intangible_asset_amor,0)+coalesce(ltdefer_exp_amor,0)
else coalesce(sum_profit,0)+coalesce(int_exp,0)-coalesce(int_reve,0)+coalesce(fixed_asset_depr,0)+coalesce(intangible_asset_amor,0)+coalesce(ltdefer_exp_amor,0) end as ebitda,
------------------------银行专项数据
d.bank_sub_001,
d.bank_sub_002,
d.bank_sub_003,
d.bank_sub_004,
d.bank_sub_005,
d.bank_sub_006,
d.bank_sub_007,
d.bank_sub_008,
d.bank_sub_009,
d.bank_sub_010,
d.bank_sub_011,
d.bank_sub_012,
d.bank_sub_013,
d.bank_sub_014,
d.bank_sub_015,
d.bank_sub_016,
d.bank_sub_017,
d.bank_sub_018,
d.bank_sub_019,
d.bank_sub_020,
d.bank_sub_021,
d.bank_sub_022,
d.bank_sub_023,
d.bank_sub_024,
d.bank_sub_025,
d.bank_sub_026,
d.bank_sub_027,
d.bank_sub_028,
d.bank_sub_029,
d.bank_sub_030,
d.bank_sub_031,
d.bank_sub_032,
d.bank_sub_033,
d.bank_sub_034,
d.bank_sub_035,
d.bank_sub_036,
d.bank_sub_037,
d.bank_sub_038,
d.bank_sub_039,
d.bank_sub_040,
d.bank_sub_041,
d.bank_sub_042,
d.bank_sub_043,
d.bank_sub_044,
d.bank_sub_045,
d.bank_sub_046,
d.bank_sub_047,
d.bank_sub_048,
d.bank_sub_049,
d.bank_sub_050,
d.bank_sub_051,
d.bank_sub_052,
d.bank_sub_053,
d.bank_sub_054,
d.bank_sub_055,
d.bank_sub_056,
d.bank_sub_057,
d.bank_sub_058,
d.bank_sub_059,
d.bank_sub_060,
d.bank_sub_061,
d.bank_sub_062,
d.bank_sub_063,
d.bank_sub_064,
d.bank_sub_065,
d.bank_sub_066,
d.bank_sub_067,
d.bank_sub_068,
d.bank_sub_069,
d.bank_sub_070,
d.bank_sub_071,
d.bank_sub_072,
d.bank_sub_073,
d.bank_sub_074,
d.bank_sub_075,
d.bank_sub_076,
d.bank_sub_077,
d.bank_sub_078,
d.bank_sub_079,
d.bank_sub_080,
d.bank_sub_081,
d.bank_sub_082,
d.bank_sub_083,
d.bank_sub_084,
d.bank_sub_085,
d.bank_sub_086,
d.bank_sub_087,
d.bank_sub_088,
d.bank_sub_089,
d.bank_sub_090,
d.bank_sub_091,
d.bank_sub_092,
d.bank_sub_093,
d.bank_sub_094,
d.bank_sub_095,
d.bank_sub_096,
d.bank_sub_097,
d.bank_sub_098,
d.bank_sub_099,
d.bank_sub_100,
d.bank_sub_101,
d.bank_sub_102,
d.bank_sub_103,
d.bank_sub_104,
d.bank_sub_105,
d.bank_sub_106,
d.bank_sub_107,
d.bank_sub_108,
d.bank_sub_109,
d.bank_sub_110,
d.bank_sub_111,
d.bank_sub_112,
d.bank_sub_113,
d.bank_sub_114,
d.bank_sub_115,
d.bank_sub_116,
d.bank_sub_117,
d.bank_sub_118,
d.bank_sub_119,
d.bank_sub_120,
d.bank_sub_121,
d.bank_sub_122,
d.bank_sub_123,
d.bank_sub_124,
d.bank_sub_125,
------------------------保险专项数据
e.com_expend,
e.act_capit_sx,
e.act_capit_cx,
e.inv_asset_cx,
e.udr_reserve_sx,
e.min_capit_sx,
e.udr_reserve_cx,
e.comexpend_cx,
e.earnprem_sx,
e.min_capit,
e.act_capit,
e.inv_asset_sx,
e.ostlr_cx,
e.ror_cx,
e.inv_asset,
e.ostlr_sx,
e.min_capit_cx,
e.earnprem_cx,
e.earnprem,
e.com_expend_sx,
e.com_compensate_cx,
e.solven_ratio_sx,
e.com_cost_cx,
e.earnprem_gr_cx,
e.nrorsx,
e.nror,
e.tror,
e.solven_ratio_cx,
e.earnprem_gr_sx,
e.solven_ratio,
e.nror_cx,
e.earnprem_gr,
e.sur_rate,
e.ror_sx,
----------------------证券专项数据
f.secu_sub_001,
f.secu_sub_002,
f.secu_sub_003,
f.secu_sub_004,
f.secu_sub_005,
f.secu_sub_006,
f.secu_sub_007,
f.secu_sub_008,
f.secu_sub_009,
f.secu_sub_010,
f.secu_sub_011,
f.secu_sub_012,
f.secu_sub_013,
f.secu_sub_014,
f.secu_sub_015,
f.secu_sub_016,
f.secu_sub_017,
f.secu_sub_018,
-------十大贷款客户
cast(null as number(24,4)) as top10_frbm,
-------关注类贷款财务附注
cast(null as number(24,4)) as spec_ment_loan,
-------五级分类后三类的资产合计
cast(null as number(24,4)) as sum_last3_loan,
-------信托行业规模
cast(null as number(24,4)) as trust_industry_amt,
cast(null as number(24,4)) as owner_industry_amt,
cast(null as number(24,4)) as operate_reve_amt,
--------信托类收集科目
cast(null as number(24,4)) as owner_asset,
cast(null as number(24,4)) as new_prod_amt,
cast(null as number(24,4)) as trust_loan_amt,
cast(null as number(24,4)) as trust_quity_inv,
cast(null as number(24,4)) as comp_reserve_fund,
cast(null as number(24,4)) as collect_trust_size,
'||cClient_id||' AS client_id,
'||cUpdt_by||' AS updt_by,
systimestamp AS updt_dt
FROM wrk_compy_id_all a
LEFT JOIN wrk_balancesheet_part_1 b ON a.company_id = b.company_id AND a.rpt_dt = b.rpt_dt  AND a.rpt_timetype_cd = b.rpt_timetype_cd
LEFT JOIN wrk_incomestate_part_1 c ON a.company_id = c.company_id AND a.rpt_dt =c.rpt_dt  AND a.rpt_timetype_cd = c.rpt_timetype_cd
LEFT JOIN wrk_cashflow_part_1 g ON a.company_id = g.company_id AND a.rpt_dt = g.rpt_dt  AND a.rpt_timetype_cd = g.rpt_timetype_cd
LEFT JOIN wrk_compy_bank_addfin d ON a.company_id = d.company_id AND a.rpt_dt = d.rpt_dt  AND a.rpt_timetype_cd = d.rpt_timetype_cd
LEFT JOIN wrk_compy_insurerindex e ON a.company_id = e.company_id AND a.rpt_dt = e.rpt_dt  AND a.rpt_timetype_cd = e.rpt_timetype_cd
LEFT JOIN wrk_compy_secriskindex f ON a.company_id = f.company_id AND a.rpt_dt = f.rpt_dt  AND a.rpt_timetype_cd = f.rpt_timetype_cd
--LEFT JOIN wrk_compy_top10lc h ON a.company_id = h.company_id AND a.rpt_dt = h.rpt_dt  AND a.rpt_timetype_cd = h.rpt_timetype_cd--十大贷款客户
--LEFT JOIN wrk_compy_fcoloan j ON a.company_id = j.company_id AND a.rpt_dt = j.rpt_dt  AND a.rpt_timetype_cd = j.rpt_timetype_cd--关注类贷款财务附注
--LEFT JOIN wrk_compy_fcoloan_sum k ON a.company_id = k.company_id AND a.rpt_dt = k.rpt_dt  AND a.rpt_timetype_cd = k.rpt_timetype_cd--五级分类后三类的资产合计
--LEFT JOIN wrk_trust_industry_size m ON a.rpt_dt = m.rpt_dt  AND a.rpt_timetype_cd = m.rpt_timetype_cd--信托行业规模
';
EXECUTE IMMEDIATE vSQL;

vRpt_dt:= vEnd_dt;
WHILE vRpt_dt>=vStart_dt
 LOOP
vSQL:='
INSERT INTO wrk_compy_finance_last_y
SELECT
company_id,
to_date('''||vRpt_dt||''',''YYYYMMDD'') AS rpt_dt,
CASE WHEN rpt_timetype_cd <= 4 then 
    CASE  substr('''||vRpt_dt||''',5,2) WHEN ''03'' then 3 WHEN ''06'' THEN 2 WHEN ''09'' THEN 4 WHEN ''12'' THEN 1 END 
WHEN rpt_timetype_cd > 4 then 
    CASE  substr('''||vRpt_dt||''',5,2) WHEN ''06'' THEN 8 WHEN ''09'' THEN 9 WHEN ''12'' THEN 7 END                                                      
END AS rpt_timetype_cd,
monetary_fund,
tradef_asset,
bill_rec,
account_rec,
other_rec,
advance_pay,
dividend_rec,
interest_rec,
inventory,
nonl_asset_oneyear,
defer_expense,
other_lasset,
lasset_other,
lasset_balance,
sum_lasset,
saleable_fasset,
held_maturity_inv,
estate_invest,
lte_quity_inv,
ltrec,
fixed_asset,
construction_material,
construction_progress,
liquidate_fixed_asset,
product_biology_asset,
oilgas_asset,
intangible_asset,
develop_exp,
good_will,
ltdefer_asset,
defer_incometax_asset,
other_nonl_asset,
nonlasset_other,
nonlasset_balance,
sum_nonl_asset,
cash_and_depositcbank,
deposit_infi,
fi_deposit,
precious_metal,
lend_fund,
derive_fasset,
buy_sellback_fasset,
loan_advances,
agency_assets,
premium_rec,
subrogation_rec,
ri_rec,
undue_rireserve_rec,
claim_rireserve_rec,
life_rireserve_rec,
lthealth_rireserve_rec,
gdeposit_pay,
insured_pledge_loan,
capitalg_deposit_pay,
independent_asset,
client_fund,
settlement_provision,
client_provision,
seat_fee,
other_asset,
asset_other,
asset_balance,
sum_asset,
st_borrow,
trade_fliab,
bill_pay,
account_pay,
advance_receive,
salary_pay,
tax_pay,
interest_pay,
dividend_pay,
other_pay,
accrue_expense,
anticipate_liab,
defer_income,
nonl_liab_oneyear,
other_lliab,
lliab_other,
lliab_balance,
sum_lliab,
lt_borrow,
bond_pay,
lt_account_pay,
special_pay,
defer_incometax_liab,
other_nonl_liab,
nonl_liab_other,
nonl_liab_balance,
sum_nonl_liab,
borrow_from_cbank,
borrow_fund,
derive_financedebt,
sell_buyback_fasset,
accept_deposit,
agency_liab,
other_liab,
premium_advance,
comm_pay,
ri_pay,
gdeposit_rec,
insured_deposit_inv,
undue_reserve,
claim_reserve,
life_reserve,
lt_health_reserve,
independent_liab,
pledge_borrow,
agent_trade_security,
agent_uw_security,
liab_other,
liab_balance,
sum_liab,
share_capital,
capital_reserve,
surplus_reserve,
retained_earning,
inventory_share,
general_risk_prepare,
diff_conversion_fc,
minority_equity,
sh_equity_other,
sh_equity_balance,
sum_parent_equity,
sum_sh_equity,
liabsh_equity_other,
liabsh_equity_balance,
sum_liabsh_equity,
td_eposit,
st_bond_rec,
claim_pay,
policy_divi_pay,
unconfirm_inv_loss,
ricontact_reserve_rec,
deposit,
contact_reserve,
invest_rec,
specia_lreserve,
subsidy_rec,
marginout_fund,
export_rebate_rec,
defer_income_oneyear,
lt_salary_pay,
fvalue_fasset,
define_fvalue_fasset,
internal_rec,
clheld_sale_ass,
fvalue_fliab,
define_fvalue_fliab,
internal_pay,
clheld_sale_liab,
anticipate_lliab,
other_equity,
other_cincome,
plan_cash_divi,
parent_equity_other,
parent_equity_balance,
preferred_stock,
prefer_stoc_bond,
cons_biolo_asset,
stock_num_end,
net_mas_set,
outward_remittance,
cdandbill_rec,
hedge_reserve,
suggest_assign_divi,
marginout_security,
cagent_trade_security,
trade_risk_prepare,
creditor_planinv,
short_financing,
receivables,
operate_reve,
operate_exp,
operate_tax,
sale_exp,
manage_exp,
finance_exp,
asset_devalue_loss,
fvalue_income,
invest_income,
intn_reve,
int_reve,
int_exp,
commn_reve,
comm_reve,
comm_exp,
exchange_income,
premium_earned,
premium_income,
ripremium,
premium_exp,
indemnity_exp,
amortise_indemnity_exp,
duty_reserve,
amortise_duty_reserve,
rireve,
riexp,
surrender_premium,
policy_divi_exp,
amortise_riexp,
security_uw,
client_asset_manage,
operate_profit_other,
operate_profit_balance,
operate_profit,
nonoperate_reve,
nonoperate_exp,
nonlasset_net_loss,
sum_profit_other,
sum_profit_balance,
sum_profit,
income_tax,
net_profit_other2,
net_profit_balance1,
net_profit_balance2,
net_profit,
parent_net_profit,
minority_income,
undistribute_profit,
basic_eps,
diluted_eps,
invest_joint_income,
total_operate_reve,
total_operate_exp,
other_reve,
other_exp,
unconfirm_invloss,
sum_cincome,
parent_cincome,
minority_cincome,
net_contact_reserve,
rdexp,
operate_manage_exp,
insur_reve,
nonlasset_reve,
total_operatereve_other,
net_indemnity_exp,
total_operateexp_other,
net_profit_other1,
cincome_balance1,
cincome_balance2,
other_net_income,
reve_other,
reve_balance,
operate_exp_other,
operate_exp_balance,
bank_intnreve,
bank_intreve,
ninsur_commn_reve,
ninsur_comm_reve,
ninsur_comm_exp,
salegoods_service_rec,
tax_return_rec,
other_operate_rec,
ni_deposit,
niborrow_from_cbank,
niborrow_from_fi,
nidisp_trade_fasset,
nidisp_saleable_fasset,
niborrow_fund,
nibuyback_fund,
operate_flowin_other,
operate_flowin_balance,
sum_operate_flowin,
buygoods_service_pay,
employee_pay,
other_operat_epay,
niloan_advances,
nideposit_incbankfi,
indemnity_pay,
intandcomm_pay,
operate_flowout_other,
operate_flowout_balance,
sum_operate_flowout,
operate_flow_other,
operate_flow_balance,
net_operate_cashflow,
disposal_inv_rec,
inv_income_rec,
disp_filasset_rec,
disp_subsidiary_rec,
other_invrec,
inv_flowin_other,
inv_flowin_balance,
sum_inv_flowin,
buy_filasset_pay,
inv_pay,
get_subsidiary_pay,
other_inv_pay,
nipledge_loan,
inv_flowout_other,
inv_flowout_balance,
sum_inv_flowout,
inv_flow_other,
inv_cashflow_balance,
net_inv_cashflow,
accept_inv_rec,
loan_rec,
other_fina_rec,
issue_bond_rec,
niinsured_deposit_inv,
fina_flowin_other,
fina_flowin_balance,
sum_fina_flowin,
repay_debt_pay,
divi_profitorint_pay,
other_fina_pay,
fina_flowout_other,
fina_flowout_balance,
sum_fina_flowout,
fina_flow_other,
fina_flow_balance,
net_fina_cashflow,
effect_exchange_rate,
nicash_equi_other,
nicash_equi_balance,
nicash_equi,
cash_equi_beginning,
cash_equi_ending,
asset_devalue,
fixed_asset_etcdepr,
intangible_asset_amor,
ltdefer_exp_amor,
defer_exp_reduce,
drawing_exp_add,
disp_filasset_loss,
fixed_asset_loss,
fvalue_loss,
inv_loss,
defer_taxasset_reduce,
defer_taxliab_add,
inventory_reduce,
operate_rec_reduce,
operate_pay_add,
inoperate_flow_other,
inoperate_flow_balance,
innet_operate_cashflow,
debt_to_capital,
cb_oneyear,
finalease_fixed_asset,
cash_end,
cash_begin,
equi_end,
equi_begin,
innicash_equi_other,
innicash_equi_balance,
innicash_equi,
other,
subsidiary_accept,
subsidiary_pay,
divi_pay,
intandcomm_rec,
net_rirec,
nilend_fund,
defer_tax,
defer_income_amor,
exchange_loss,
fixandestate_depr,
fixed_asset_depr,
tradef_asset_reduce,
ndloan_advances,
reduce_pledget_deposit,
add_pledget_deposit,
buy_subsidiary_pay,
cash_equiending_other,
cash_equiending_balance,
nd_depositinc_bankfi,
niborrow_sell_buyback,
ndlend_buy_sellback,
net_cd,
nitrade_fliab,
ndtrade_fasset,
disp_masset_rec,
cancel_loan_rec,
ndborrow_from_cbank,
ndfide_posit,
ndissue_cd,
nilend_sell_buyback,
ndborrow_sell_buyback,
nitrade_fasset,
ndtrade_fliab,
buy_finaleaseasset_pay,
niaccount_rec,
issue_cd,
addshare_capital_rec,
issue_share_rec,
bond_intpay,
niother_finainstru,
uwsecurity_rec,
buysellback_fasset_rec,
agent_uwsecurity_rec,
nidirect_inv,
nitrade_settlement,
buysellback_fasset_pay,
nddisp_trade_fasset,
ndother_fina_instr,
ndborrow_fund,
nddirect_inv,
ndtrade_settlement,
ndbuyback_fund,
agenttrade_security_pay,
nddisp_saleable_fasset,
nisell_buyback,
ndbuy_sellback,
nettrade_fasset_rec,
net_ripay,
ndlend_fund,
nibuy_sellback,
ndsell_buyback,
ndinsured_deposit_inv,
nettrade_fasset_pay,
niinsured_pledge_loan,
disp_subsidiary_pay,
netsell_buyback_fassetrec,
netsell_buyback_fassetpay,
ebit,
ebitda,
bank_sub_001,
bank_sub_002,
bank_sub_003,
bank_sub_004,
bank_sub_005,
bank_sub_006,
bank_sub_007,
bank_sub_008,
bank_sub_009,
bank_sub_010,
bank_sub_011,
bank_sub_012,
bank_sub_013,
bank_sub_014,
bank_sub_015,
bank_sub_016,
bank_sub_017,
bank_sub_018,
bank_sub_019,
bank_sub_020,
bank_sub_021,
bank_sub_022,
bank_sub_023,
bank_sub_024,
bank_sub_025,
bank_sub_026,
bank_sub_027,
bank_sub_028,
bank_sub_029,
bank_sub_030,
bank_sub_031,
bank_sub_032,
bank_sub_033,
bank_sub_034,
bank_sub_035,
bank_sub_036,
bank_sub_037,
bank_sub_038,
bank_sub_039,
bank_sub_040,
bank_sub_041,
bank_sub_042,
bank_sub_043,
bank_sub_044,
bank_sub_045,
bank_sub_046,
bank_sub_047,
bank_sub_048,
bank_sub_049,
bank_sub_050,
bank_sub_051,
bank_sub_052,
bank_sub_053,
bank_sub_054,
bank_sub_055,
bank_sub_056,
bank_sub_057,
bank_sub_058,
bank_sub_059,
bank_sub_060,
bank_sub_061,
bank_sub_062,
bank_sub_063,
bank_sub_064,
bank_sub_065,
bank_sub_066,
bank_sub_067,
bank_sub_068,
bank_sub_069,
bank_sub_070,
bank_sub_071,
bank_sub_072,
bank_sub_073,
bank_sub_074,
bank_sub_075,
bank_sub_076,
bank_sub_077,
bank_sub_078,
bank_sub_079,
bank_sub_080,
bank_sub_081,
bank_sub_082,
bank_sub_083,
bank_sub_084,
bank_sub_085,
bank_sub_086,
bank_sub_087,
bank_sub_088,
bank_sub_089,
bank_sub_090,
bank_sub_091,
bank_sub_092,
bank_sub_093,
bank_sub_094,
bank_sub_095,
bank_sub_096,
bank_sub_097,
bank_sub_098,
bank_sub_099,
bank_sub_100,
bank_sub_101,
bank_sub_102,
bank_sub_103,
bank_sub_104,
bank_sub_105,
bank_sub_106,
bank_sub_107,
bank_sub_108,
bank_sub_109,
bank_sub_110,
bank_sub_111,
bank_sub_112,
bank_sub_113,
bank_sub_114,
bank_sub_115,
bank_sub_116,
bank_sub_117,
bank_sub_118,
bank_sub_119,
bank_sub_120,
bank_sub_121,
bank_sub_122,
bank_sub_123,
bank_sub_124,
bank_sub_125,
com_expend,
act_capit_sx,
act_capit_cx,
inv_asset_cx,
udr_reserve_sx,
min_capit_sx,
udr_reserve_cx,
comexpend_cx,
earnprem_sx,
min_capit,
act_capit,
inv_asset_sx,
ostlr_cx,
ror_cx,
inv_asset,
ostlr_sx,
min_capit_cx,
earnprem_cx,
earnprem,
com_expend_sx,
com_compensate_cx,
solven_ratio_sx,
com_cost_cx,
earnprem_gr_cx,
nrorsx,
nror,
tror,
solven_ratio_cx,
earnprem_gr_sx,
solven_ratio,
nror_cx,
earnprem_gr,
sur_rate,
ror_sx,
secu_sub_001,
secu_sub_002,
secu_sub_003,
secu_sub_004,
secu_sub_005,
secu_sub_006,
secu_sub_007,
secu_sub_008,
secu_sub_009,
secu_sub_010,
secu_sub_011,
secu_sub_012,
secu_sub_013,
secu_sub_014,
secu_sub_015,
secu_sub_016,
secu_sub_017,
secu_sub_018,
top10_frbm,
spec_ment_loan,
sum_last3_loan,
trust_industry_amt,
owner_industry_amt,
operate_reve_amt,
owner_asset,
new_prod_amt,
trust_loan_amt,
trust_quity_inv,
comp_reserve_fund,
collect_trust_size,
client_id,
updt_by,
updt_dt
FROM wrk_compy_finance
WHERE  cast(to_char(rpt_dt,''YYYYMMDD'') AS integer) ='||(vRpt_dt-10000);

execute immediate  vSQL;

vSQL:='
INSERT INTO wrk_compy_finance_bf_last_y
SELECT
company_id,
to_date('''||vRpt_dt||''',''YYYYMMDD'') AS rpt_dt,
CASE WHEN rpt_timetype_cd <= 4 then 
CASE  substr('''||vRpt_dt||''',5,2) WHEN ''03'' then 3 WHEN ''06'' THEN 2 WHEN ''09'' THEN 4 WHEN ''12'' THEN 1 END 
            WHEN rpt_timetype_cd > 4 then 
CASE  substr('''||vRpt_dt||''',5,2) WHEN ''06'' THEN 8 WHEN ''09'' THEN 9 WHEN ''12'' THEN 7 END                                                      
            END AS rpt_timetype_cd,
monetary_fund,
tradef_asset,
bill_rec,
account_rec,
other_rec,
advance_pay,
dividend_rec,
interest_rec,
inventory,
nonl_asset_oneyear,
defer_expense,
other_lasset,
lasset_other,
lasset_balance,
sum_lasset,
saleable_fasset,
held_maturity_inv,
estate_invest,
lte_quity_inv,
ltrec,
fixed_asset,
construction_material,
construction_progress,
liquidate_fixed_asset,
product_biology_asset,
oilgas_asset,
intangible_asset,
develop_exp,
good_will,
ltdefer_asset,
defer_incometax_asset,
other_nonl_asset,
nonlasset_other,
nonlasset_balance,
sum_nonl_asset,
cash_and_depositcbank,
deposit_infi,
fi_deposit,
precious_metal,
lend_fund,
derive_fasset,
buy_sellback_fasset,
loan_advances,
agency_assets,
premium_rec,
subrogation_rec,
ri_rec,
undue_rireserve_rec,
claim_rireserve_rec,
life_rireserve_rec,
lthealth_rireserve_rec,
gdeposit_pay,
insured_pledge_loan,
capitalg_deposit_pay,
independent_asset,
client_fund,
settlement_provision,
client_provision,
seat_fee,
other_asset,
asset_other,
asset_balance,
sum_asset,
st_borrow,
trade_fliab,
bill_pay,
account_pay,
advance_receive,
salary_pay,
tax_pay,
interest_pay,
dividend_pay,
other_pay,
accrue_expense,
anticipate_liab,
defer_income,
nonl_liab_oneyear,
other_lliab,
lliab_other,
lliab_balance,
sum_lliab,
lt_borrow,
bond_pay,
lt_account_pay,
special_pay,
defer_incometax_liab,
other_nonl_liab,
nonl_liab_other,
nonl_liab_balance,
sum_nonl_liab,
borrow_from_cbank,
borrow_fund,
derive_financedebt,
sell_buyback_fasset,
accept_deposit,
agency_liab,
other_liab,
premium_advance,
comm_pay,
ri_pay,
gdeposit_rec,
insured_deposit_inv,
undue_reserve,
claim_reserve,
life_reserve,
lt_health_reserve,
independent_liab,
pledge_borrow,
agent_trade_security,
agent_uw_security,
liab_other,
liab_balance,
sum_liab,
share_capital,
capital_reserve,
surplus_reserve,
retained_earning,
inventory_share,
general_risk_prepare,
diff_conversion_fc,
minority_equity,
sh_equity_other,
sh_equity_balance,
sum_parent_equity,
sum_sh_equity,
liabsh_equity_other,
liabsh_equity_balance,
sum_liabsh_equity,
td_eposit,
st_bond_rec,
claim_pay,
policy_divi_pay,
unconfirm_inv_loss,
ricontact_reserve_rec,
deposit,
contact_reserve,
invest_rec,
specia_lreserve,
subsidy_rec,
marginout_fund,
export_rebate_rec,
defer_income_oneyear,
lt_salary_pay,
fvalue_fasset,
define_fvalue_fasset,
internal_rec,
clheld_sale_ass,
fvalue_fliab,
define_fvalue_fliab,
internal_pay,
clheld_sale_liab,
anticipate_lliab,
other_equity,
other_cincome,
plan_cash_divi,
parent_equity_other,
parent_equity_balance,
preferred_stock,
prefer_stoc_bond,
cons_biolo_asset,
stock_num_end,
net_mas_set,
outward_remittance,
cdandbill_rec,
hedge_reserve,
suggest_assign_divi,
marginout_security,
cagent_trade_security,
trade_risk_prepare,
creditor_planinv,
short_financing,
receivables,
operate_reve,
operate_exp,
operate_tax,
sale_exp,
manage_exp,
finance_exp,
asset_devalue_loss,
fvalue_income,
invest_income,
intn_reve,
int_reve,
int_exp,
commn_reve,
comm_reve,
comm_exp,
exchange_income,
premium_earned,
premium_income,
ripremium,
premium_exp,
indemnity_exp,
amortise_indemnity_exp,
duty_reserve,
amortise_duty_reserve,
rireve,
riexp,
surrender_premium,
policy_divi_exp,
amortise_riexp,
security_uw,
client_asset_manage,
operate_profit_other,
operate_profit_balance,
operate_profit,
nonoperate_reve,
nonoperate_exp,
nonlasset_net_loss,
sum_profit_other,
sum_profit_balance,
sum_profit,
income_tax,
net_profit_other2,
net_profit_balance1,
net_profit_balance2,
net_profit,
parent_net_profit,
minority_income,
undistribute_profit,
basic_eps,
diluted_eps,
invest_joint_income,
total_operate_reve,
total_operate_exp,
other_reve,
other_exp,
unconfirm_invloss,
sum_cincome,
parent_cincome,
minority_cincome,
net_contact_reserve,
rdexp,
operate_manage_exp,
insur_reve,
nonlasset_reve,
total_operatereve_other,
net_indemnity_exp,
total_operateexp_other,
net_profit_other1,
cincome_balance1,
cincome_balance2,
other_net_income,
reve_other,
reve_balance,
operate_exp_other,
operate_exp_balance,
bank_intnreve,
bank_intreve,
ninsur_commn_reve,
ninsur_comm_reve,
ninsur_comm_exp,
salegoods_service_rec,
tax_return_rec,
other_operate_rec,
ni_deposit,
niborrow_from_cbank,
niborrow_from_fi,
nidisp_trade_fasset,
nidisp_saleable_fasset,
niborrow_fund,
nibuyback_fund,
operate_flowin_other,
operate_flowin_balance,
sum_operate_flowin,
buygoods_service_pay,
employee_pay,
other_operat_epay,
niloan_advances,
nideposit_incbankfi,
indemnity_pay,
intandcomm_pay,
operate_flowout_other,
operate_flowout_balance,
sum_operate_flowout,
operate_flow_other,
operate_flow_balance,
net_operate_cashflow,
disposal_inv_rec,
inv_income_rec,
disp_filasset_rec,
disp_subsidiary_rec,
other_invrec,
inv_flowin_other,
inv_flowin_balance,
sum_inv_flowin,
buy_filasset_pay,
inv_pay,
get_subsidiary_pay,
other_inv_pay,
nipledge_loan,
inv_flowout_other,
inv_flowout_balance,
sum_inv_flowout,
inv_flow_other,
inv_cashflow_balance,
net_inv_cashflow,
accept_inv_rec,
loan_rec,
other_fina_rec,
issue_bond_rec,
niinsured_deposit_inv,
fina_flowin_other,
fina_flowin_balance,
sum_fina_flowin,
repay_debt_pay,
divi_profitorint_pay,
other_fina_pay,
fina_flowout_other,
fina_flowout_balance,
sum_fina_flowout,
fina_flow_other,
fina_flow_balance,
net_fina_cashflow,
effect_exchange_rate,
nicash_equi_other,
nicash_equi_balance,
nicash_equi,
cash_equi_beginning,
cash_equi_ending,
asset_devalue,
fixed_asset_etcdepr,
intangible_asset_amor,
ltdefer_exp_amor,
defer_exp_reduce,
drawing_exp_add,
disp_filasset_loss,
fixed_asset_loss,
fvalue_loss,
inv_loss,
defer_taxasset_reduce,
defer_taxliab_add,
inventory_reduce,
operate_rec_reduce,
operate_pay_add,
inoperate_flow_other,
inoperate_flow_balance,
innet_operate_cashflow,
debt_to_capital,
cb_oneyear,
finalease_fixed_asset,
cash_end,
cash_begin,
equi_end,
equi_begin,
innicash_equi_other,
innicash_equi_balance,
innicash_equi,
other,
subsidiary_accept,
subsidiary_pay,
divi_pay,
intandcomm_rec,
net_rirec,
nilend_fund,
defer_tax,
defer_income_amor,
exchange_loss,
fixandestate_depr,
fixed_asset_depr,
tradef_asset_reduce,
ndloan_advances,
reduce_pledget_deposit,
add_pledget_deposit,
buy_subsidiary_pay,
cash_equiending_other,
cash_equiending_balance,
nd_depositinc_bankfi,
niborrow_sell_buyback,
ndlend_buy_sellback,
net_cd,
nitrade_fliab,
ndtrade_fasset,
disp_masset_rec,
cancel_loan_rec,
ndborrow_from_cbank,
ndfide_posit,
ndissue_cd,
nilend_sell_buyback,
ndborrow_sell_buyback,
nitrade_fasset,
ndtrade_fliab,
buy_finaleaseasset_pay,
niaccount_rec,
issue_cd,
addshare_capital_rec,
issue_share_rec,
bond_intpay,
niother_finainstru,
uwsecurity_rec,
buysellback_fasset_rec,
agent_uwsecurity_rec,
nidirect_inv,
nitrade_settlement,
buysellback_fasset_pay,
nddisp_trade_fasset,
ndother_fina_instr,
ndborrow_fund,
nddirect_inv,
ndtrade_settlement,
ndbuyback_fund,
agenttrade_security_pay,
nddisp_saleable_fasset,
nisell_buyback,
ndbuy_sellback,
nettrade_fasset_rec,
net_ripay,
ndlend_fund,
nibuy_sellback,
ndsell_buyback,
ndinsured_deposit_inv,
nettrade_fasset_pay,
niinsured_pledge_loan,
disp_subsidiary_pay,
netsell_buyback_fassetrec,
netsell_buyback_fassetpay,
ebit,
ebitda,
bank_sub_001,
bank_sub_002,
bank_sub_003,
bank_sub_004,
bank_sub_005,
bank_sub_006,
bank_sub_007,
bank_sub_008,
bank_sub_009,
bank_sub_010,
bank_sub_011,
bank_sub_012,
bank_sub_013,
bank_sub_014,
bank_sub_015,
bank_sub_016,
bank_sub_017,
bank_sub_018,
bank_sub_019,
bank_sub_020,
bank_sub_021,
bank_sub_022,
bank_sub_023,
bank_sub_024,
bank_sub_025,
bank_sub_026,
bank_sub_027,
bank_sub_028,
bank_sub_029,
bank_sub_030,
bank_sub_031,
bank_sub_032,
bank_sub_033,
bank_sub_034,
bank_sub_035,
bank_sub_036,
bank_sub_037,
bank_sub_038,
bank_sub_039,
bank_sub_040,
bank_sub_041,
bank_sub_042,
bank_sub_043,
bank_sub_044,
bank_sub_045,
bank_sub_046,
bank_sub_047,
bank_sub_048,
bank_sub_049,
bank_sub_050,
bank_sub_051,
bank_sub_052,
bank_sub_053,
bank_sub_054,
bank_sub_055,
bank_sub_056,
bank_sub_057,
bank_sub_058,
bank_sub_059,
bank_sub_060,
bank_sub_061,
bank_sub_062,
bank_sub_063,
bank_sub_064,
bank_sub_065,
bank_sub_066,
bank_sub_067,
bank_sub_068,
bank_sub_069,
bank_sub_070,
bank_sub_071,
bank_sub_072,
bank_sub_073,
bank_sub_074,
bank_sub_075,
bank_sub_076,
bank_sub_077,
bank_sub_078,
bank_sub_079,
bank_sub_080,
bank_sub_081,
bank_sub_082,
bank_sub_083,
bank_sub_084,
bank_sub_085,
bank_sub_086,
bank_sub_087,
bank_sub_088,
bank_sub_089,
bank_sub_090,
bank_sub_091,
bank_sub_092,
bank_sub_093,
bank_sub_094,
bank_sub_095,
bank_sub_096,
bank_sub_097,
bank_sub_098,
bank_sub_099,
bank_sub_100,
bank_sub_101,
bank_sub_102,
bank_sub_103,
bank_sub_104,
bank_sub_105,
bank_sub_106,
bank_sub_107,
bank_sub_108,
bank_sub_109,
bank_sub_110,
bank_sub_111,
bank_sub_112,
bank_sub_113,
bank_sub_114,
bank_sub_115,
bank_sub_116,
bank_sub_117,
bank_sub_118,
bank_sub_119,
bank_sub_120,
bank_sub_121,
bank_sub_122,
bank_sub_123,
bank_sub_124,
bank_sub_125,
com_expend,
act_capit_sx,
act_capit_cx,
inv_asset_cx,
udr_reserve_sx,
min_capit_sx,
udr_reserve_cx,
comexpend_cx,
earnprem_sx,
min_capit,
act_capit,
inv_asset_sx,
ostlr_cx,
ror_cx,
inv_asset,
ostlr_sx,
min_capit_cx,
earnprem_cx,
earnprem,
com_expend_sx,
com_compensate_cx,
solven_ratio_sx,
com_cost_cx,
earnprem_gr_cx,
nrorsx,
nror,
tror,
solven_ratio_cx,
earnprem_gr_sx,
solven_ratio,
nror_cx,
earnprem_gr,
sur_rate,
ror_sx,
secu_sub_001,
secu_sub_002,
secu_sub_003,
secu_sub_004,
secu_sub_005,
secu_sub_006,
secu_sub_007,
secu_sub_008,
secu_sub_009,
secu_sub_010,
secu_sub_011,
secu_sub_012,
secu_sub_013,
secu_sub_014,
secu_sub_015,
secu_sub_016,
secu_sub_017,
secu_sub_018,
top10_frbm,
spec_ment_loan,
sum_last3_loan,
trust_industry_amt,
owner_industry_amt,
operate_reve_amt,
owner_asset,
new_prod_amt,
trust_loan_amt,
trust_quity_inv,
comp_reserve_fund,
collect_trust_size,
client_id,
updt_by,
updt_dt
FROM wrk_compy_finance
WHERE  cast(to_char(rpt_dt,''YYYYMMDD'') AS integer) ='||(vRpt_dt-20000);

EXECUTE IMMEDIATE  VSQL;

select case substr(to_char(vRpt_dt),5,2) when '12' then 20091231-301 when '09' then 20090930-300 when '6' then  20090930-299 when '3' then 20090930-9100 end  into vRpt_dt from dual;

END LOOP;

vSQL := 'DELETE FROM compy_finance a where exists (select 1 FROM wrk_compy_finance b WHERE a.company_id = b.company_id AND a.rpt_dt = b.rpt_dt AND a.rpt_timetype_cd = b.rpt_timetype_cd)';
EXECUTE IMMEDIATE  vSQL;
vSQL := 'DELETE FROM compy_finance_last_y a where exists (select 1 FROM wrk_compy_finance_last_y b WHERE a.company_id_last_y = b.company_id_last_y AND a.rpt_dt_last_y = b.rpt_dt_last_y AND a.rpt_timetype_cd_last_y = b.rpt_timetype_cd_last_y)';
EXECUTE IMMEDIATE  vSQL;
vSQL := 'DELETE FROM compy_finance_bf_last_y a where exists (select 1 FROM wrk_compy_finance_bf_last_y b WHERE a.company_id_bf_last_y = b.company_id_bf_last_y AND a.rpt_dt_bf_last_y = b.rpt_dt_bf_last_y AND a.rpt_timetype_cd_bf_last_y = b.rpt_timetype_cd_bf_last_y)';
EXECUTE IMMEDIATE  vSQL;

vSQL := 'INSERT INTO compy_finance SELECT * FROM wrk_compy_finance';
EXECUTE IMMEDIATE  vSQL;
vSQL := 'INSERT INTO compy_finance_last_y SELECT * FROM wrk_compy_finance_last_y';
EXECUTE IMMEDIATE  vSQL;
vSQL := 'INSERT INTO compy_finance_bf_last_y SELECT * FROM wrk_compy_finance_bf_last_y';
EXECUTE IMMEDIATE  vSQL;

--Clear temp tables
 SP_DROP_IF_EXIST('wrk_compy_id_all_1');
 --SP_DROP_IF_EXIST('wrk_compy_id_all');
 SP_DROP_IF_EXIST('wrk_balancesheet_part');
 SP_DROP_IF_EXIST('wrk_balancesheet_part_1');
 SP_DROP_IF_EXIST('wrk_incomestate_part_1');
 SP_DROP_IF_EXIST('wrk_cashflow_part_1');
 SP_DROP_IF_EXIST('wrk_compy_bank_addfin');
 SP_DROP_IF_EXIST('wrk_compy_insurerindex');
 SP_DROP_IF_EXIST('wrk_compy_secriskindex');
 SP_DROP_IF_EXIST('wrk_compy_fcoloan');
 SP_DROP_IF_EXIST('wrk_compy_fcoloan_sum');
 SP_DROP_IF_EXIST('wrk_compy_top10lc');
 SP_DROP_IF_EXIST('wrk_trust_industry_size');
 SP_DROP_IF_EXIST('compy_finance_dynamic_part_1');
 SP_DROP_IF_EXIST('compy_finance_dynamic_part_2');
 SP_DROP_IF_EXIST('wrk_compy_finance');
 SP_DROP_IF_EXIST('wrk_compy_finance_dynamic');
 SP_DROP_IF_EXIST('wrk_report_date_list');
 SP_DROP_IF_EXIST('wrk_compy_finance');
 SP_DROP_IF_EXIST('wrk_compy_finance_last_y');
 SP_DROP_IF_EXIST('wrk_compy_finance_bf_last_y');
 SP_DROP_IF_EXIST('wrk_compy_secriskindex_temp');


exception when others then 

    dbms_output.put_line( 'Execute FN_COMPY_FINANCE failed');
    raise_application_error( -20021,SQLERRM||' '||SQLCODE||' '||vSQL);

END;
/

prompt
prompt Creating procedure SP_COMPY_WARNINGS
prompt ====================================
prompt
CREATE OR REPLACE PROCEDURE SP_COMPY_WARNINGS
AS 
/*

2017-07-27 mark, convert to oracle
*/
vStart_dt timestamp;
vLast_dt timestamp;
vInsert_Count integer;
vUpdt_Count integer;
vOrig_Count integer;
vDup_Count integer;
vMessage varchar(1000) :='';
vSQL varchar(4000) :='';
vSQL1 varchar(4000) :='';
vSQL2 varchar(4000) :='';
vSQL3 varchar(4000) :='';
vSQL4 varchar(4000) :='';
vSQL5 varchar(4000) :='';

BEGIN

vStart_dt := systimestamp;
select max(start_dt) INTO vLast_dt from etl_dm_loadlog where upper(process_nm)='SP_COMPY_WARNINGS';

SP_DROP_IF_EXIST('tmp_compy_warnings');


	vMessage :='Start incremental refresh load..';

	vSQL1 :='create table tmp_compy_warnings
			 as
			select company_id,
				   company_name as company_nm,
				   notice_dt,
				   type_id,
				   importance as severity,
				   case_title as warning_title,
				   case_content as warning_content,
				   exposure_sid,
				   exposure,
				   region_cd,
				   region_nm,
				   rnk
			from 
				(select a.*,row_number()over(partition by company_id,notice_dt,type_id,importance,case_title order by 1) as rnk
				 from vw_compy_warnings a
				where notice_dt>=date'''||NVL(to_char(vLast_dt,'YYYY-MM-DD'),'1900-01-01')||'''
			    )a';

	vMessage :=vSQL1;	
	execute immediate  vSQL1;

	vSQL2 :='select count(*) from tmp_compy_warnings';	
	vMessage := vSQL2;
	execute immediate  vSQL2;
    vOrig_Count := SQL%ROWCOUNT;

	vSQL3 :='select count(*) from tmp_compy_warnings where rnk<>1';	
	vMessage :=vSQL3;
	execute immediate  vSQL3;
    vDup_Count := SQL%ROWCOUNT;


	vSQL4 :='select count(*)
			from tmp_compy_warnings a
			where rnk=1 and not exists (select compy_warnings_sid 
								from compy_warnings b 
								where a.company_id=b.company_id
									and a.notice_dt=b.notice_dt
									and a.type_id=b.type_id
									and a.severity=b.severity
									and a.warning_title=to_char(b.warning_title))';
                                    -- can't join with clob

	vMessage :=vSQL4;
	execute immediate  vSQL4;
    vInsert_Count := SQL%ROWCOUNT;


	vSQL5 :='insert into compy_warnings
			 select  seq_warnings.nextval,
				company_id,
				company_nm,
				notice_dt,
				type_id,
				severity,
				warning_title,
				warning_content,
				exposure_sid,
				exposure,
				region_cd,
				region_nm,
				null as severity_adjusted,
				0 as process_flag,
				sysdate as updt_dt
			from tmp_compy_warnings a
			where rnk=1 and not exists (select compy_warnings_sid 
								from compy_warnings b 
								where a.company_id=b.company_id
									and a.notice_dt=b.notice_dt
									and a.type_id=b.type_id
									and a.severity=b.severity
									and a.warning_title=to_char(b.warning_title)
									)';
	vMessage :=vSQL5;			 
	execute immediate  vSQL5;

	--统计数据加载情况

	vUpdt_Count :=0;
    vMessage :='Incremental load completed, start inserting load log';

	insert into ETL_DM_LOADLOG
	(loadlog_sid,process_nm, orig_record_count, dup_record_count, insert_count, updt_count, start_dt, end_dt, start_rowid, end_rowid)
	select seq_etl_dm_loadlog.nextval,'SP_COMPY_WARNINGS',vOrig_Count,vDup_Count,vInsert_Count,vUpdt_Count,vStart_dt,systimestamp,null, null from dual;


EXCEPTION
	WHEN OTHERS THEN 
	RAISE_APPLICATION_ERROR( -20021, SQLERRM||' '||SQLCODE||' '||vmessage);
END;
/

prompt
prompt Creating procedure SP_REFRESH_MATVIEWS
prompt ======================================
prompt
CREATE OR REPLACE PROCEDURE SP_REFRESH_MATVIEWS
AS 
    v_matviewname USER_MVIEWS.mview_name%TYPE;
BEGIN
		FOR v_matviewname IN (SELECT mview_name FROM USER_MVIEWS)
		LOOP
			DBMS_MVIEW.REFRESH(v_matviewname.mview_name);
			DBMS_OUTPUT.PUT_LINE(systimestamp || ':   ' || v_matviewname.mview_name || ' successfully refreshed');
		END LOOP;
END;
/

prompt
prompt Creating procedure SP_REFRESH_MV
prompt ================================
prompt
CREATE OR REPLACE PROCEDURE "SP_REFRESH_MV"
is
begin
        for rec in (select MVIEW_NAME from user_mview_analysis)
        loop
                dbms_mview.refresh(rec.MVIEW_NAME, 'C');
        end loop;
 end;
/

prompt
prompt Creating procedure SP_SUBSCRIBE_TABLE
prompt =====================================
prompt
CREATE OR REPLACE PROCEDURE SP_SUBSCRIBE_TABLE(p_table IN varchar2)
AS 

/*
FUNCTION Name:		fn_subscribe_table
Paramter:			none
Description:		subscribe table from master data service to master
Example:			select fn_subscribe_table
Creation Date:		2017-01-10
Author:				Shawn zhang
*/

    vStart_dt TIMESTAMP;
    vLast_dt TIMESTAMP;
    vSubscribe_table VARCHAR(30) := '';
	vTgt_table VARCHAR(30) := '';
	vTgt_pk VARCHAR(100) := '';
	vSQL VARCHAR(30000)	:= '';
	vSQL1 VARCHAR(30000)	:= '';
	vSQL2 VARCHAR(30000)	:= '';
	vSQL3 VARCHAR(30000)	:= '';
    vClient_id VARCHAR(30) := '1';
    vUser_id VARCHAR(30) := '0';
    vFt_cs_master_ds VARCHAR(30) := 'ft_cs_master_ds';
    --v_record record;
    vMessage VARCHAR(30000);
	vOrig_record_count NUMERIC(19,0) := 0;
	vInsert_count NUMERIC(19,0) := 0;
	vUpdt_count NUMERIC(19,0) := 0;
	vEnd_dt  TIMESTAMP;
	vStart_rowid NUMERIC(19,0) := null;
	vEnd_rowid NUMERIC(19,0) := null;
    vProcess_type NUMERIC(19,0) := 0;

BEGIN
vMessage := 'Start...';
vStart_dt := systimestamp;
for v_record in (select * from LKP_SUBSCRIBE_TABLE where lower(subscribe_table) like p_table|| '%' order by subscribe_table_id)
loop

  vMessage := 'Start Loop';
  vSubscribe_table := v_record.subscribe_table;
  vTgt_table :=  v_record.tgt_table;
  vProcess_type := v_record.process_type;

  if vProcess_type = 2 or vProcess_type = 4 or vProcess_type = 5 then
		vTgt_pk := v_record.tgt_logic_pk1;
  else
		vTgt_pk := v_record.tgt_physical_pk;
  end if;

  select max(start_dt) into vLast_dt from ETL_DM_LOADLOG where process_nm = vTgt_table;
  vMessage := 'Will Subscribe';

  if vLast_dt is null THEN
    if vTgt_table = 'INDUSTRY' then
			vSQL := 'select max(update_time) from ' || vTgt_table || ' where client_id = '|| vClient_id;
    elsif lower(vTgt_table) = 'compy_creditrating_info' then 
			vSQL := 'select max(updt_dt) from ' || vTgt_table ;
    elsif v_record.tgt_field_list not like '%src_cd%' then 
			vSQL := 'select max(updt_dt) from ' || vTgt_table || ' where client_id = '|| vClient_id;
	  else 
			vSQL := 'select max(updt_dt) from ' || vTgt_table || ' where src_cd = ''CSCS''';
    end if;

    vMessage := vSQL;
    execute immediate  vSQL into vLast_dt;
    if vLast_dt is null THEN
       vLast_dt := '1900-01-01';
    END IF;
  end if;

  vSQL1 := replace(replace(replace(v_record.tgt_field_list, 'client_id', vClient_id), 'updt_by', vUser_id),'mitigation_value','null');

  if vTgt_table = 'INDUSTRY' then
		vSQL2 := ' where update_time >= ''' || vLast_dt || '''';
  else
		vSQL2 := ' where updt_dt >= ''' || vLast_dt || '''';
  end if;
  --get Orig_record_count
  vSQL := 'select count(*) from ' || vFt_cs_master_ds || '.' || vSubscribe_table || vSQL2;
  vMessage := vSQL;
  execute immediate  vSQL into vOrig_record_count;

  --get vUpdt_count
  vSQL := 'select count(*) from ' || vTgt_table || ' where ' || vTgt_pk || ' in ' ||
  '(select ' || vTgt_pk || ' from ' || vFt_cs_master_ds || '.' || vSubscribe_table || vSQL2 || ')';  
  vMessage := vSQL;
  execute immediate  vSQL into vUpdt_count;

  --keep existed records
  vSQL := 'create table tmp_deleted_pk as select ' || v_record.tgt_physical_pk || ' as pk, ' || v_record.tgt_logic_pk1 || ' as lpk '
  || ' from ' || vTgt_table || ' where ' || vTgt_pk || ' in ' ||
  '(select ' || vTgt_pk || ' from ' || vFt_cs_master_ds || '.' || vSubscribe_table || vSQL2 || ')';  
  vMessage := vSQL; 
  --return vMessage; 
  execute immediate  vSQL;


  --删除存在记录
  --vSQL := ' delete from ' || vTgt_table || ' where ' || vTgt_pk || ' in ' ||
  --'(select ' || vTgt_pk || ' from ' || vFt_cs_master_ds || '.' || vSubscribe_table || vSQL2 || ')';
  --vMessage := vSQL;
  --execute vSQL;

  --插入新的记录
  if vProcess_type = 2 or vProcess_type = 4  then

		vSQL := ' delete from ' || vTgt_table || ' where ' || vTgt_pk || ' in ' ||
	 '(select lpk from tmp_deleted_pk) ';
    vMessage := vSQL;  
    execute immediate  vSQL;

		 vSQL := ' insert into ' || vTgt_table 
    || ' select ' || vSQL1 || ' from ' || vFt_cs_master_ds || '.' || vSubscribe_table 
	  || ' a inner join tmp_deleted_pk b '
	  || ' on '|| v_record.tgt_logic_pk1 || ' = b.lpk'
	  || vSQL2;
     vMessage := vSQL; 
     execute immediate  vSQL;

    --execute ' select replace('''||vSQL||''', ''' || v_record.tgt_physical_pk || ','','''')' ;
    vSQL3 := replace(v_record.tgt_field_list, lower(v_record.tgt_physical_pk)||',', '');
    vSQL1 := replace(vSQL1, lower(v_record.tgt_physical_pk)||',', '');

		if lower(vSQL1) like '%srcid%' then
			vSQL :=  'select replace('''||vSQL1||''', ''srcid'', '|| ''''|| v_record.tgt_physical_pk ||''')';
			vMessage := vSQL;
			execute immediate  vSQL into vSQL1;
		end if; 

   	--vSQL := ' insert into ' || vTgt_table || '('|| v_record.tgt_field_list || ')'||
    vSQL := ' insert into ' || vTgt_table || '('|| vSQL3 || ')'||
    ' select ' || vSQL1 || ' from ' || vFt_cs_master_ds || '.' || vSubscribe_table 
	  || ' a left join tmp_deleted_pk b '
	  || ' on '|| v_record.tgt_logic_pk1 || ' = b.lpk'
	  || vSQL2 || ' and b.pk is null';

    vMessage := vSQL;
    execute immediate  vSQL;

  else

		vSQL := ' delete from ' || vTgt_table || ' where ' || vTgt_pk || ' in ' ||
    '(select ' || vTgt_pk || ' from ' || vFt_cs_master_ds || '.' || vSubscribe_table || vSQL2 || ')';
    vMessage := vSQL;
    execute immediate  vSQL;

		if lower(vSQL1) like '%srcid%' then
			vSQL :=  'select replace('''||vSQL1||''', ''srcid'', '|| ''''|| v_record.tgt_physical_pk ||''')';
			vMessage := vSQL;
			execute immediate  vSQL into vSQL1;
		end if; 

		 vSQL := ' insert into ' || vTgt_table || 
    ' select ' || vSQL1 || ' from ' || vFt_cs_master_ds || '.' || vSubscribe_table || vSQL2;
    vMessage := vSQL;
    execute immediate  vSQL;

  end if;

  --Get insert count
  vInsert_count := vOrig_record_count - vUpdt_count;
  vSQL := 'drop table tmp_deleted_pk';
  EXECUTE IMMEDIATE vSQL;

  --insert log
  vSQL := ' insert into etl_dm_loadlog
	(process_nm, orig_record_count, dup_record_count, insert_count, updt_count, start_dt, end_dt, start_rowid, end_rowid)
	select ''' || vTgt_table || ''','|| vOrig_record_count||', 0, '|| vInsert_count||', '|| vUpdt_count||', '''||vStart_dt ||''', '''|| systimestamp ||''', null, null';
  vMessage := vSQL;
  execute immediate  vSQL;
end loop;
--vMessage := 'Success!';
DBMS_OUTPUT.PUT_LINE( 'Success!' );

EXCEPTION
	WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE( vMessage);
END;
/

