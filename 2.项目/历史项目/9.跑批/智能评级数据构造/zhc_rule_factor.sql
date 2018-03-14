-- Create table
create table ZHC_RULE_FACTOR
(
  a       VARCHAR2(500),
  b       VARCHAR2(500),
  c       VARCHAR2(500),
  d       VARCHAR2(500),
  e       VARCHAR2(500),
  f       VARCHAR2(500),
  g       NUMBER,
  h       VARCHAR2(500),
  i       VARCHAR2(500),
  j       NUMBER,
  k       NUMBER,
  l       VARCHAR2(500),
  m       VARCHAR2(500),
  n       VARCHAR2(500),
  o       VARCHAR2(500),
  p       VARCHAR2(500),
  q       NUMBER,
  r       NUMBER,
  s       NUMBER(38,10),
  t       NUMBER(38,10),
  u       NUMBER(38,10),
  v       NUMBER(38,10),
  w       NUMBER(38,10),
  x       NUMBER(38,10),
  y       NUMBER(38,10),
  z       VARCHAR2(500),
  aa      VARCHAR2(500),
  updt_dt DATE default sysdate
)
tablespace TBS_CUR_DAT
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
-- Add comments to the columns 
comment on column ZHC_RULE_FACTOR.a
  is '核心客户号';
comment on column ZHC_RULE_FACTOR.b
  is '发行人中文名称';
comment on column ZHC_RULE_FACTOR.c
  is '评审池意见';
comment on column ZHC_RULE_FACTOR.d
  is '基础评级小级';
comment on column ZHC_RULE_FACTOR.e
  is '基础评级大级';
comment on column ZHC_RULE_FACTOR.f
  is '外部评级';
comment on column ZHC_RULE_FACTOR.g
  is '客户评级结果代码';
comment on column ZHC_RULE_FACTOR.h
  is '客户风险分层';
comment on column ZHC_RULE_FACTOR.i
  is '最低十级分类';
comment on column ZHC_RULE_FACTOR.j
  is '是否高风险类名单';
comment on column ZHC_RULE_FACTOR.k
  is '授信额度连续下降_3m';
comment on column ZHC_RULE_FACTOR.l
  is '所属集团风险分层';
comment on column ZHC_RULE_FACTOR.m
  is '担保圈';
comment on column ZHC_RULE_FACTOR.n
  is '客户过去一年月末存款余额发生大额增加的次数分组_U卡';
comment on column ZHC_RULE_FACTOR.o
  is '过去一年有无逾期记录Y有逾期N无逾期';
comment on column ZHC_RULE_FACTOR.p
  is '过去六个月内是否有授信审批被否决';
comment on column ZHC_RULE_FACTOR.q
  is '过去1年是否有央行征信中的不良记录';
comment on column ZHC_RULE_FACTOR.r
  is '过去1年是否有央行征信中的关注类记录';
comment on column ZHC_RULE_FACTOR.s
  is '最低交易价格面值比';
comment on column ZHC_RULE_FACTOR.t
  is '额度敞口金额';
comment on column ZHC_RULE_FACTOR.u
  is '存贷比';
comment on column ZHC_RULE_FACTOR.v
  is '结算账户近6个月月均余额';
comment on column ZHC_RULE_FACTOR.w
  is '客户过去一年月末存款余额发生大额增加的次数_U卡';
comment on column ZHC_RULE_FACTOR.x
  is '对外担保额度';
comment on column ZHC_RULE_FACTOR.y
  is '非正常类对外担保额度';
comment on column ZHC_RULE_FACTOR.z
  is '组别';
comment on column ZHC_RULE_FACTOR.aa
  is '多维矩阵得分';
