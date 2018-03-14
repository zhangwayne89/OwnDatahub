drop index ACT_IDX_BYTEAR_DEPL;
drop index ACT_IDX_EXE_PROCINST;
drop index ACT_IDX_EXE_PARENT;
drop index ACT_IDX_EXE_SUPER;
drop index ACT_IDX_TSKASS_TASK;
drop index ACT_IDX_TASK_EXEC;
drop index ACT_IDX_TASK_PROCINST;
drop index ACT_IDX_TASK_PROCDEF;
drop index ACT_IDX_VAR_EXE;
drop index ACT_IDX_VAR_PROCINST;
drop index ACT_IDX_VAR_BYTEARRAY;
drop index ACT_IDX_JOB_EXCEPTION;
drop index ACT_IDX_MODEL_SOURCE;
drop index ACT_IDX_MODEL_SOURCE_EXTRA;
drop index ACT_IDX_MODEL_DEPLOYMENT;
drop index ACT_IDX_PROCDEF_INFO_JSON;

drop index ACT_IDX_EXEC_BUSKEY;
drop index ACT_IDX_TASK_CREATE;
drop index ACT_IDX_IDENT_LNK_USER;
drop index ACT_IDX_IDENT_LNK_GROUP;
drop index ACT_IDX_VARIABLE_TASK_ID;

alter table ACT_GE_BYTEARRAY
  drop constraint ACT_FK_BYTEARR_DEPL;

alter table ACT_RU_EXECUTION
  drop constraint ACT_FK_EXE_PROCINST;

alter table ACT_RU_EXECUTION
  drop constraint ACT_FK_EXE_PARENT;

alter table ACT_RU_EXECUTION
  drop constraint ACT_FK_EXE_SUPER;

alter table ACT_RU_EXECUTION
  drop constraint ACT_FK_EXE_PROCDEF;

alter table ACT_RU_IDENTITYLINK
  drop constraint ACT_FK_TSKASS_TASK;

alter table ACT_RU_IDENTITYLINK
  drop constraint ACT_FK_ATHRZ_PROCEDEF;

alter table ACT_RU_TASK
  drop constraint ACT_FK_TASK_EXE;

alter table ACT_RU_TASK
  drop constraint ACT_FK_TASK_PROCINST;

alter table ACT_RU_TASK
  drop constraint ACT_FK_TASK_PROCDEF;

alter table ACT_RU_VARIABLE
  drop constraint ACT_FK_VAR_EXE;

alter table ACT_RU_VARIABLE
  drop constraint ACT_FK_VAR_PROCINST;

alter table ACT_RU_VARIABLE
  drop constraint ACT_FK_VAR_BYTEARRAY;

alter table ACT_RU_JOB
  drop constraint ACT_FK_JOB_EXCEPTION;

alter table ACT_RU_EVENT_SUBSCR
  drop constraint ACT_FK_EVENT_EXEC;

alter table ACT_RE_PROCDEF
  drop constraint ACT_UNIQ_PROCDEF;

alter table ACT_RE_MODEL
  drop constraint ACT_FK_MODEL_SOURCE;

alter table ACT_RE_MODEL
  drop constraint ACT_FK_MODEL_SOURCE_EXTRA;

alter table ACT_RE_MODEL
  drop constraint ACT_FK_MODEL_DEPLOYMENT;

alter table ACT_PROCDEF_INFO
  drop constraint ACT_UNIQ_INFO_PROCDEF;

alter table ACT_PROCDEF_INFO
  drop constraint ACT_FK_INFO_JSON_BA;

alter table ACT_PROCDEF_INFO
  drop constraint ACT_FK_INFO_PROCDEF;

drop index ACT_IDX_EVENT_SUBSCR_CONFIG_;
drop index ACT_IDX_EVENT_SUBSCR;
drop index ACT_IDX_ATHRZ_PROCEDEF;
drop index ACT_IDX_PROCDEF_INFO_PROC;

drop table ACT_GE_PROPERTY;
drop table ACT_GE_BYTEARRAY;
drop table ACT_RE_DEPLOYMENT;
drop table ACT_RE_MODEL;
drop table ACT_RE_PROCDEF;
drop table ACT_RU_IDENTITYLINK;
drop table ACT_RU_VARIABLE;
drop table ACT_RU_TASK;
drop table ACT_RU_EXECUTION;
drop table ACT_RU_JOB;
drop table ACT_RU_EVENT_SUBSCR;

drop sequence act_evt_log_seq;
drop table ACT_EVT_LOG;
drop table ACT_PROCDEF_INFO;
drop index ACT_IDX_HI_PRO_INST_END;
drop index ACT_IDX_HI_PRO_I_BUSKEY;
drop index ACT_IDX_HI_ACT_INST_START;
drop index ACT_IDX_HI_ACT_INST_END;
drop index ACT_IDX_HI_DETAIL_PROC_INST;
drop index ACT_IDX_HI_DETAIL_ACT_INST;
drop index ACT_IDX_HI_DETAIL_TIME;
drop index ACT_IDX_HI_DETAIL_NAME;
drop index ACT_IDX_HI_DETAIL_TASK_ID;
drop index ACT_IDX_HI_PROCVAR_PROC_INST;
drop index ACT_IDX_HI_PROCVAR_NAME_TYPE;
drop index ACT_IDX_HI_ACT_INST_PROCINST;
drop index ACT_IDX_HI_IDENT_LNK_USER;
drop index ACT_IDX_HI_IDENT_LNK_TASK;
drop index ACT_IDX_HI_IDENT_LNK_PROCINST;
drop index ACT_IDX_HI_TASK_INST_PROCINST;

drop table ACT_HI_PROCINST;
drop table ACT_HI_ACTINST;
drop table ACT_HI_VARINST;
drop table ACT_HI_TASKINST;
drop table ACT_HI_DETAIL;
drop table ACT_HI_COMMENT;
drop table ACT_HI_ATTACHMENT;
drop table ACT_HI_IDENTITYLINK;
alter table ACT_ID_MEMBERSHIP
  drop constraint ACT_FK_MEMB_GROUP;

alter table ACT_ID_MEMBERSHIP
  drop constraint ACT_FK_MEMB_USER;

drop index ACT_IDX_MEMB_GROUP;
drop index ACT_IDX_MEMB_USER;

drop table ACT_ID_INFO;
drop table ACT_ID_MEMBERSHIP;
drop table ACT_ID_GROUP;
drop table ACT_ID_USER;

create table ACT_GE_PROPERTY (
  NAME_  varchar2(64),
  VALUE_ varchar2(300),
  REV_   integer,
  primary key (NAME_)
);
insert into ACT_GE_PROPERTY
values ('schema.version', '5.22.0.0', 1);
insert into ACT_GE_PROPERTY
values ('schema.history', 'create(5.22.0.0)', 1);

insert into ACT_GE_PROPERTY
values ('next.dbid', '1', 1);

create table ACT_GE_BYTEARRAY (
  ID_            varchar2(64),
  REV_           integer,
  NAME_          varchar2(255),
  DEPLOYMENT_ID_ varchar2(64),
  BYTES_         blob,
  GENERATED_     number(1, 0) check (GENERATED_ in (1, 0)),
  primary key (ID_)
);

create table ACT_RE_DEPLOYMENT (
  ID_          varchar2(64),
  NAME_        varchar2(255),
  CATEGORY_    varchar2(255),
  TENANT_ID_   varchar2(255) default '',
  DEPLOY_TIME_ timestamp(6),
  primary key (ID_)
);

create table ACT_RE_MODEL (
  ID_                           varchar2(64) not null,
  REV_                          integer,
  NAME_                         varchar2(255),
  KEY_                          varchar2(255),
  CATEGORY_                     varchar2(255),
  CREATE_TIME_                  timestamp(6),
  LAST_UPDATE_TIME_             timestamp(6),
  VERSION_                      integer,
  META_INFO_                    varchar2(2000),
  DEPLOYMENT_ID_                varchar2(64),
  EDITOR_SOURCE_VALUE_ID_       varchar2(64),
  EDITOR_SOURCE_EXTRA_VALUE_ID_ varchar2(64),
  TENANT_ID_                    varchar2(255) default '',
  primary key (ID_)
);

create table ACT_RU_EXECUTION (
  ID_               varchar2(64),
  REV_              integer,
  PROC_INST_ID_     varchar2(64),
  BUSINESS_KEY_     varchar2(255),
  PARENT_ID_        varchar2(64),
  PROC_DEF_ID_      varchar2(64),
  SUPER_EXEC_       varchar2(64),
  ACT_ID_           varchar2(255),
  IS_ACTIVE_        number(1, 0) check (IS_ACTIVE_ in (1, 0)),
  IS_CONCURRENT_    number(1, 0) check (IS_CONCURRENT_ in (1, 0)),
  IS_SCOPE_         number(1, 0) check (IS_SCOPE_ in (1, 0)),
  IS_EVENT_SCOPE_   number(1, 0) check (IS_EVENT_SCOPE_ in (1, 0)),
  SUSPENSION_STATE_ integer,
  CACHED_ENT_STATE_ integer,
  TENANT_ID_        varchar2(255) default '',
  NAME_             varchar2(255),
  LOCK_TIME_        timestamp(6),
  primary key (ID_)
);

create table ACT_RU_JOB (
  ID_                  varchar2(64)  not null,
  REV_                 integer,
  TYPE_                varchar2(255) not null,
  LOCK_EXP_TIME_       timestamp(6),
  LOCK_OWNER_          varchar2(255),
  EXCLUSIVE_           number(1, 0) check (EXCLUSIVE_ in (1, 0)),
  EXECUTION_ID_        varchar2(64),
  PROCESS_INSTANCE_ID_ varchar2(64),
  PROC_DEF_ID_         varchar2(64),
  RETRIES_             integer,
  EXCEPTION_STACK_ID_  varchar2(64),
  EXCEPTION_MSG_       varchar2(2000),
  DUEDATE_             timestamp(6),
  REPEAT_              varchar2(255),
  HANDLER_TYPE_        varchar2(255),
  HANDLER_CFG_         varchar2(2000),
  TENANT_ID_           varchar2(255) default '',
  primary key (ID_)
);

create table ACT_RE_PROCDEF (
  ID_                     varchar2(64)  not null,
  REV_                    integer,
  CATEGORY_               varchar2(255),
  NAME_                   varchar2(255),
  KEY_                    varchar2(255) not null,
  VERSION_                integer        not null,
  DEPLOYMENT_ID_          varchar2(64),
  RESOURCE_NAME_          varchar2(2000),
  DGRM_RESOURCE_NAME_     varchar(4000),
  DESCRIPTION_            varchar2(2000),
  HAS_START_FORM_KEY_     number(1, 0) check (HAS_START_FORM_KEY_ in (1, 0)),
  HAS_GRAPHICAL_NOTATION_ number(1, 0) check (HAS_GRAPHICAL_NOTATION_ in (1, 0)),
  SUSPENSION_STATE_       integer,
  TENANT_ID_              varchar2(255) default '',
  primary key (ID_)
);

create table ACT_RU_TASK (
  ID_               varchar2(64),
  REV_              integer,
  EXECUTION_ID_     varchar2(64),
  PROC_INST_ID_     varchar2(64),
  PROC_DEF_ID_      varchar2(64),
  NAME_             varchar2(255),
  PARENT_TASK_ID_   varchar2(64),
  DESCRIPTION_      varchar2(2000),
  TASK_DEF_KEY_     varchar2(255),
  OWNER_            varchar2(255),
  ASSIGNEE_         varchar2(255),
  DELEGATION_       varchar2(64),
  PRIORITY_         integer,
  CREATE_TIME_      timestamp(6),
  DUE_DATE_         timestamp(6),
  CATEGORY_         varchar2(255),
  SUSPENSION_STATE_ integer,
  TENANT_ID_        varchar2(255) default '',
  FORM_KEY_         varchar2(255),
  primary key (ID_)
);

create table ACT_RU_IDENTITYLINK (
  ID_           varchar2(64),
  REV_          integer,
  GROUP_ID_     varchar2(255),
  TYPE_         varchar2(255),
  USER_ID_      varchar2(255),
  TASK_ID_      varchar2(64),
  PROC_INST_ID_ varchar2(64),
  PROC_DEF_ID_  varchar2(64),
  primary key (ID_)
);

create table ACT_RU_VARIABLE (
  ID_           varchar2(64)  not null,
  REV_          integer,
  TYPE_         varchar2(255) not null,
  NAME_         varchar2(255) not null,
  EXECUTION_ID_ varchar2(64),
  PROC_INST_ID_ varchar2(64),
  TASK_ID_      varchar2(64),
  BYTEARRAY_ID_ varchar2(64),
  DOUBLE_       number(*, 10),
  LONG_         number(19, 0),
  TEXT_         varchar2(2000),
  TEXT2_        varchar2(2000),
  primary key (ID_)
);

create table ACT_RU_EVENT_SUBSCR (
  ID_            varchar2(64)  not null,
  REV_           integer,
  EVENT_TYPE_    varchar2(255) not null,
  EVENT_NAME_    varchar2(255),
  EXECUTION_ID_  varchar2(64),
  PROC_INST_ID_  varchar2(64),
  ACTIVITY_ID_   varchar2(64),
  CONFIGURATION_ varchar2(255),
  CREATED_       timestamp(6)   not null,
  PROC_DEF_ID_   varchar2(64),
  TENANT_ID_     varchar2(255) default '',
  primary key (ID_)
);

create table ACT_EVT_LOG (
  LOG_NR_       number(19),
  TYPE_         varchar2(64),
  PROC_DEF_ID_  varchar2(64),
  PROC_INST_ID_ varchar2(64),
  EXECUTION_ID_ varchar2(64),
  TASK_ID_      varchar2(64),
  TIME_STAMP_   timestamp(6) not null,
  USER_ID_      varchar2(255),
  DATA_         blob,
  LOCK_OWNER_   varchar2(255),
  LOCK_TIME_    timestamp(6) null,
  IS_PROCESSED_ number(3) default 0,
  primary key (LOG_NR_)
);

create sequence act_evt_log_seq;

create table ACT_PROCDEF_INFO (
  ID_           varchar2(64) not null,
  PROC_DEF_ID_  varchar2(64) not null,
  REV_          integer,
  INFO_JSON_ID_ varchar2(64),
  primary key (ID_)
);

create index ACT_IDX_EXEC_BUSKEY
  on ACT_RU_EXECUTION (BUSINESS_KEY_);
create index ACT_IDX_TASK_CREATE
  on ACT_RU_TASK (CREATE_TIME_);
create index ACT_IDX_IDENT_LNK_USER
  on ACT_RU_IDENTITYLINK (USER_ID_);
create index ACT_IDX_IDENT_LNK_GROUP
  on ACT_RU_IDENTITYLINK (GROUP_ID_);
create index ACT_IDX_EVENT_SUBSCR_CONFIG_
  on ACT_RU_EVENT_SUBSCR (CONFIGURATION_);
create index ACT_IDX_VARIABLE_TASK_ID
  on ACT_RU_VARIABLE (TASK_ID_);

create index ACT_IDX_BYTEAR_DEPL
  on ACT_GE_BYTEARRAY (DEPLOYMENT_ID_);
alter table ACT_GE_BYTEARRAY
  add constraint ACT_FK_BYTEARR_DEPL
foreign key (DEPLOYMENT_ID_)
references ACT_RE_DEPLOYMENT (ID_);

alter table ACT_RE_PROCDEF
  add constraint ACT_UNIQ_PROCDEF
unique (KEY_, VERSION_, TENANT_ID_);

create index ACT_IDX_EXE_PROCINST
  on ACT_RU_EXECUTION (PROC_INST_ID_);
alter table ACT_RU_EXECUTION
  add constraint ACT_FK_EXE_PROCINST
foreign key (PROC_INST_ID_)
references ACT_RU_EXECUTION (ID_);

create index ACT_IDX_EXE_PARENT
  on ACT_RU_EXECUTION (PARENT_ID_);
alter table ACT_RU_EXECUTION
  add constraint ACT_FK_EXE_PARENT
foreign key (PARENT_ID_)
references ACT_RU_EXECUTION (ID_);

create index ACT_IDX_EXE_SUPER
  on ACT_RU_EXECUTION (SUPER_EXEC_);
alter table ACT_RU_EXECUTION
  add constraint ACT_FK_EXE_SUPER
foreign key (SUPER_EXEC_)
references ACT_RU_EXECUTION (ID_);

create index ACT_IDX_EXE_PROCDEF
  on ACT_RU_EXECUTION (PROC_DEF_ID_);
alter table ACT_RU_EXECUTION
  add constraint ACT_FK_EXE_PROCDEF
foreign key (PROC_DEF_ID_)
references ACT_RE_PROCDEF (ID_);

create index ACT_IDX_TSKASS_TASK
  on ACT_RU_IDENTITYLINK (TASK_ID_);
alter table ACT_RU_IDENTITYLINK
  add constraint ACT_FK_TSKASS_TASK
foreign key (TASK_ID_)
references ACT_RU_TASK (ID_);

create index ACT_IDX_ATHRZ_PROCEDEF
  on ACT_RU_IDENTITYLINK (PROC_DEF_ID_);
alter table ACT_RU_IDENTITYLINK
  add constraint ACT_FK_ATHRZ_PROCEDEF
foreign key (PROC_DEF_ID_)
references ACT_RE_PROCDEF (ID_);

create index ACT_IDX_IDL_PROCINST
  on ACT_RU_IDENTITYLINK (PROC_INST_ID_);
alter table ACT_RU_IDENTITYLINK
  add constraint ACT_FK_IDL_PROCINST
foreign key (PROC_INST_ID_)
references ACT_RU_EXECUTION (ID_);

create index ACT_IDX_TASK_EXEC
  on ACT_RU_TASK (EXECUTION_ID_);
alter table ACT_RU_TASK
  add constraint ACT_FK_TASK_EXE
foreign key (EXECUTION_ID_)
references ACT_RU_EXECUTION (ID_);

create index ACT_IDX_TASK_PROCINST
  on ACT_RU_TASK (PROC_INST_ID_);
alter table ACT_RU_TASK
  add constraint ACT_FK_TASK_PROCINST
foreign key (PROC_INST_ID_)
references ACT_RU_EXECUTION (ID_);

create index ACT_IDX_TASK_PROCDEF
  on ACT_RU_TASK (PROC_DEF_ID_);
alter table ACT_RU_TASK
  add constraint ACT_FK_TASK_PROCDEF
foreign key (PROC_DEF_ID_)
references ACT_RE_PROCDEF (ID_);

create index ACT_IDX_VAR_EXE
  on ACT_RU_VARIABLE (EXECUTION_ID_);
alter table ACT_RU_VARIABLE
  add constraint ACT_FK_VAR_EXE
foreign key (EXECUTION_ID_)
references ACT_RU_EXECUTION (ID_);

create index ACT_IDX_VAR_PROCINST
  on ACT_RU_VARIABLE (PROC_INST_ID_);
alter table ACT_RU_VARIABLE
  add constraint ACT_FK_VAR_PROCINST
foreign key (PROC_INST_ID_)
references ACT_RU_EXECUTION (ID_);

create index ACT_IDX_VAR_BYTEARRAY
  on ACT_RU_VARIABLE (BYTEARRAY_ID_);
alter table ACT_RU_VARIABLE
  add constraint ACT_FK_VAR_BYTEARRAY
foreign key (BYTEARRAY_ID_)
references ACT_GE_BYTEARRAY (ID_);

create index ACT_IDX_JOB_EXCEPTION
  on ACT_RU_JOB (EXCEPTION_STACK_ID_);
alter table ACT_RU_JOB
  add constraint ACT_FK_JOB_EXCEPTION
foreign key (EXCEPTION_STACK_ID_)
references ACT_GE_BYTEARRAY (ID_);

create index ACT_IDX_EVENT_SUBSCR
  on ACT_RU_EVENT_SUBSCR (EXECUTION_ID_);
alter table ACT_RU_EVENT_SUBSCR
  add constraint ACT_FK_EVENT_EXEC
foreign key (EXECUTION_ID_)
references ACT_RU_EXECUTION (ID_);

create index ACT_IDX_MODEL_SOURCE
  on ACT_RE_MODEL (EDITOR_SOURCE_VALUE_ID_);
alter table ACT_RE_MODEL
  add constraint ACT_FK_MODEL_SOURCE
foreign key (EDITOR_SOURCE_VALUE_ID_)
references ACT_GE_BYTEARRAY (ID_);

create index ACT_IDX_MODEL_SOURCE_EXTRA
  on ACT_RE_MODEL (EDITOR_SOURCE_EXTRA_VALUE_ID_);
alter table ACT_RE_MODEL
  add constraint ACT_FK_MODEL_SOURCE_EXTRA
foreign key (EDITOR_SOURCE_EXTRA_VALUE_ID_)
references ACT_GE_BYTEARRAY (ID_);

create index ACT_IDX_MODEL_DEPLOYMENT
  on ACT_RE_MODEL (DEPLOYMENT_ID_);
alter table ACT_RE_MODEL
  add constraint ACT_FK_MODEL_DEPLOYMENT
foreign key (DEPLOYMENT_ID_)
references ACT_RE_DEPLOYMENT (ID_);

create index ACT_IDX_PROCDEF_INFO_JSON
  on ACT_PROCDEF_INFO (INFO_JSON_ID_);
alter table ACT_PROCDEF_INFO
  add constraint ACT_FK_INFO_JSON_BA
foreign key (INFO_JSON_ID_)
references ACT_GE_BYTEARRAY (ID_);

create index ACT_IDX_PROCDEF_INFO_PROC
  on ACT_PROCDEF_INFO (PROC_DEF_ID_);
alter table ACT_PROCDEF_INFO
  add constraint ACT_FK_INFO_PROCDEF
foreign key (PROC_DEF_ID_)
references ACT_RE_PROCDEF (ID_);

alter table ACT_PROCDEF_INFO
  add constraint ACT_UNIQ_INFO_PROCDEF
unique (PROC_DEF_ID_);
create table ACT_HI_PROCINST (
  ID_                        varchar2(64) not null,
  PROC_INST_ID_              varchar2(64) not null,
  BUSINESS_KEY_              varchar2(255),
  PROC_DEF_ID_               varchar2(64) not null,
  START_TIME_                timestamp(6)  not null,
  END_TIME_                  timestamp(6),
  DURATION_                  number(19, 0),
  START_USER_ID_             varchar2(255),
  START_ACT_ID_              varchar2(255),
  END_ACT_ID_                varchar2(255),
  SUPER_PROCESS_INSTANCE_ID_ varchar2(64),
  DELETE_REASON_             varchar2(2000),
  TENANT_ID_                 varchar2(255) default '',
  NAME_                      varchar2(255),
  primary key (ID_),
  unique (PROC_INST_ID_)
);

create table ACT_HI_ACTINST (
  ID_                varchar2(64)  not null,
  PROC_DEF_ID_       varchar2(64)  not null,
  PROC_INST_ID_      varchar2(64)  not null,
  EXECUTION_ID_      varchar2(64)  not null,
  ACT_ID_            varchar2(255) not null,
  TASK_ID_           varchar2(64),
  CALL_PROC_INST_ID_ varchar2(64),
  ACT_NAME_          varchar2(255),
  ACT_TYPE_          varchar2(255) not null,
  ASSIGNEE_          varchar2(255),
  START_TIME_        timestamp(6)   not null,
  END_TIME_          timestamp(6),
  DURATION_          number(19, 0),
  TENANT_ID_         varchar2(255) default '',
  primary key (ID_)
);

create table ACT_HI_TASKINST (
  ID_             varchar2(64) not null,
  PROC_DEF_ID_    varchar2(64),
  TASK_DEF_KEY_   varchar2(255),
  PROC_INST_ID_   varchar2(64),
  EXECUTION_ID_   varchar2(64),
  PARENT_TASK_ID_ varchar2(64),
  NAME_           varchar2(255),
  DESCRIPTION_    varchar2(2000),
  OWNER_          varchar2(255),
  ASSIGNEE_       varchar2(255),
  START_TIME_     timestamp(6)  not null,
  CLAIM_TIME_     timestamp(6),
  END_TIME_       timestamp(6),
  DURATION_       number(19, 0),
  DELETE_REASON_  varchar2(2000),
  PRIORITY_       integer,
  DUE_DATE_       timestamp(6),
  FORM_KEY_       varchar2(255),
  CATEGORY_       varchar2(255),
  TENANT_ID_      varchar2(255) default '',
  primary key (ID_)
);

create table ACT_HI_VARINST (
  ID_                varchar2(64)  not null,
  PROC_INST_ID_      varchar2(64),
  EXECUTION_ID_      varchar2(64),
  TASK_ID_           varchar2(64),
  NAME_              varchar2(255) not null,
  VAR_TYPE_          varchar2(100),
  REV_               integer,
  BYTEARRAY_ID_      varchar2(64),
  DOUBLE_            number(*, 10),
  LONG_              number(19, 0),
  TEXT_              varchar2(2000),
  TEXT2_             varchar2(2000),
  CREATE_TIME_       timestamp(6),
  LAST_UPDATED_TIME_ timestamp(6),
  primary key (ID_)
);

create table ACT_HI_DETAIL (
  ID_           varchar2(64)  not null,
  TYPE_         varchar2(255) not null,
  PROC_INST_ID_ varchar2(64),
  EXECUTION_ID_ varchar2(64),
  TASK_ID_      varchar2(64),
  ACT_INST_ID_  varchar2(64),
  NAME_         varchar2(255) not null,
  VAR_TYPE_     varchar2(64),
  REV_          integer,
  TIME_         timestamp(6)   not null,
  BYTEARRAY_ID_ varchar2(64),
  DOUBLE_       number(*, 10),
  LONG_         number(19, 0),
  TEXT_         varchar2(2000),
  TEXT2_        varchar2(2000),
  primary key (ID_)
);

create table ACT_HI_COMMENT (
  ID_           varchar2(64) not null,
  TYPE_         varchar2(255),
  TIME_         timestamp(6)  not null,
  USER_ID_      varchar2(255),
  TASK_ID_      varchar2(64),
  PROC_INST_ID_ varchar2(64),
  ACTION_       varchar2(255),
  MESSAGE_      varchar2(2000),
  FULL_MSG_     blob,
  primary key (ID_)
);

create table ACT_HI_ATTACHMENT (
  ID_           varchar2(64) not null,
  REV_          integer,
  USER_ID_      varchar2(255),
  NAME_         varchar2(255),
  DESCRIPTION_  varchar2(2000),
  TYPE_         varchar2(255),
  TASK_ID_      varchar2(64),
  PROC_INST_ID_ varchar2(64),
  URL_          varchar2(2000),
  CONTENT_ID_   varchar2(64),
  TIME_         timestamp(6),
  primary key (ID_)
);

create table ACT_HI_IDENTITYLINK (
  ID_           varchar2(64),
  GROUP_ID_     varchar2(255),
  TYPE_         varchar2(255),
  USER_ID_      varchar2(255),
  TASK_ID_      varchar2(64),
  PROC_INST_ID_ varchar2(64),
  primary key (ID_)
);

create index ACT_IDX_HI_PRO_INST_END
  on ACT_HI_PROCINST (END_TIME_);
create index ACT_IDX_HI_PRO_I_BUSKEY
  on ACT_HI_PROCINST (BUSINESS_KEY_);
create index ACT_IDX_HI_ACT_INST_START
  on ACT_HI_ACTINST (START_TIME_);
create index ACT_IDX_HI_ACT_INST_END
  on ACT_HI_ACTINST (END_TIME_);
create index ACT_IDX_HI_DETAIL_PROC_INST
  on ACT_HI_DETAIL (PROC_INST_ID_);
create index ACT_IDX_HI_DETAIL_ACT_INST
  on ACT_HI_DETAIL (ACT_INST_ID_);
create index ACT_IDX_HI_DETAIL_TIME
  on ACT_HI_DETAIL (TIME_);
create index ACT_IDX_HI_DETAIL_NAME
  on ACT_HI_DETAIL (NAME_);
create index ACT_IDX_HI_DETAIL_TASK_ID
  on ACT_HI_DETAIL (TASK_ID_);
create index ACT_IDX_HI_PROCVAR_PROC_INST
  on ACT_HI_VARINST (PROC_INST_ID_);
create index ACT_IDX_HI_PROCVAR_NAME_TYPE
  on ACT_HI_VARINST (NAME_, VAR_TYPE_);
create index ACT_IDX_HI_PROCVAR_TASK_ID
  on ACT_HI_VARINST (TASK_ID_);
create index ACT_IDX_HI_IDENT_LNK_USER
  on ACT_HI_IDENTITYLINK (USER_ID_);
create index ACT_IDX_HI_IDENT_LNK_TASK
  on ACT_HI_IDENTITYLINK (TASK_ID_);
create index ACT_IDX_HI_IDENT_LNK_PROCINST
  on ACT_HI_IDENTITYLINK (PROC_INST_ID_);

create index ACT_IDX_HI_ACT_INST_PROCINST
  on ACT_HI_ACTINST (PROC_INST_ID_, ACT_ID_);
create index ACT_IDX_HI_ACT_INST_EXEC
  on ACT_HI_ACTINST (EXECUTION_ID_, ACT_ID_);
create index ACT_IDX_HI_TASK_INST_PROCINST
  on ACT_HI_TASKINST (PROC_INST_ID_);
create table ACT_ID_GROUP (
  ID_   varchar2(64),
  REV_  integer,
  NAME_ varchar2(255),
  TYPE_ varchar2(255),
  primary key (ID_)
);

create table ACT_ID_MEMBERSHIP (
  USER_ID_  varchar2(64),
  GROUP_ID_ varchar2(64),
  primary key (USER_ID_, GROUP_ID_)
);

create table ACT_ID_USER (
  ID_         varchar2(64),
  REV_        integer,
  FIRST_      varchar2(255),
  LAST_       varchar2(255),
  EMAIL_      varchar2(255),
  PWD_        varchar2(255),
  PICTURE_ID_ varchar2(64),
  primary key (ID_)
);

create table ACT_ID_INFO (
  ID_        varchar2(64),
  REV_       integer,
  USER_ID_   varchar2(64),
  TYPE_      varchar2(64),
  KEY_       varchar2(255),
  VALUE_     varchar2(255),
  PASSWORD_  blob,
  PARENT_ID_ varchar2(255),
  primary key (ID_)
);

create index ACT_IDX_MEMB_GROUP
  on ACT_ID_MEMBERSHIP (GROUP_ID_);
alter table ACT_ID_MEMBERSHIP
  add constraint ACT_FK_MEMB_GROUP
foreign key (GROUP_ID_)
references ACT_ID_GROUP (ID_);

create index ACT_IDX_MEMB_USER
  on ACT_ID_MEMBERSHIP (USER_ID_);
alter table ACT_ID_MEMBERSHIP
  add constraint ACT_FK_MEMB_USER
foreign key (USER_ID_)
references ACT_ID_USER (ID_);

