prompt PL/SQL Developer Export User Objects for user CMAP_APP@CMB_UAT
prompt Created by zhangcong on 2018年2月2日
set define off
spool 模型自动验证构造对象.log

prompt
prompt Creating table ZMD_CMP_CAIKUANG
prompt ===============================
prompt
create table ZMD_CMP_CAIKUANG
(
  key                  VARCHAR2(300) not null,
  company_id           NUMBER(16) not null,
  company_nm           VARCHAR2(300) not null,
  rpt_date             DATE not null,
  modelscore           NUMBER(32,16),
  qnmodelscore         NUMBER,
  qlmodelscore         NUMBER,
  qlmodelscoreorig     NUMBER,
  profitability3_val   NUMBER,
  structure2_val       NUMBER,
  leverage07_val       NUMBER,
  leverage18_val       NUMBER,
  size2_val            NUMBER,
  profitability3_score NUMBER,
  structure2_score     NUMBER,
  leverage07_score     NUMBER,
  leverage18_score     NUMBER,
  size2_score          NUMBER,
  factor_004_val       NUMBER,
  factor_006_val       NUMBER,
  factor_007_val       NUMBER,
  factor_008_val       NUMBER,
  factor_012_val       NUMBER,
  factor_580_val       NUMBER,
  factor_582_val       NUMBER,
  factor_001_val       NUMBER,
  factor_059_val       NUMBER,
  factor_004_score     NUMBER,
  factor_006_score     NUMBER,
  factor_007_score     NUMBER,
  factor_008_score     NUMBER,
  factor_012_score     NUMBER,
  factor_580_score     NUMBER,
  factor_582_score     NUMBER,
  factor_001_score     NUMBER,
  factor_059_score     NUMBER
)
;

prompt
prompt Creating table ZMD_CMP_FANGDICHAN
prompt =================================
prompt
create table ZMD_CMP_FANGDICHAN
(
  key                VARCHAR2(300) not null,
  company_id         NUMBER(16) not null,
  company_nm         VARCHAR2(300) not null,
  rpt_date           DATE not null,
  modelscore         NUMBER(32,16),
  qnmodelscore       NUMBER,
  qlmodelscore       NUMBER,
  qlmodelscoreorig   NUMBER,
  structure3_val     NUMBER,
  structure019_val   NUMBER,
  leverage17_val     NUMBER,
  operation3_val     NUMBER,
  size2_val          NUMBER,
  specific7_val      NUMBER,
  structure3_score   NUMBER,
  structure019_score NUMBER,
  leverage17_score   NUMBER,
  operation3_score   NUMBER,
  size2_score        NUMBER,
  specific7_score    NUMBER,
  factor_015_val     NUMBER,
  factor_001_val     NUMBER,
  factor_192_val     NUMBER,
  factor_190_val     NUMBER,
  factor_006_val     NUMBER,
  factor_020_val     NUMBER,
  factor_015_score   NUMBER,
  factor_001_score   NUMBER,
  factor_192_score   NUMBER,
  factor_190_score   NUMBER,
  factor_006_score   NUMBER,
  factor_020_score   NUMBER
)
;

prompt
prompt Creating table ZMD_CMP_FUWUYE
prompt =============================
prompt
create table ZMD_CMP_FUWUYE
(
  key                  VARCHAR2(300) not null,
  company_id           NUMBER(16) not null,
  company_nm           VARCHAR2(300) not null,
  rpt_date             DATE not null,
  modelscore           NUMBER(32,16),
  qnmodelscore         NUMBER,
  qlmodelscore         NUMBER,
  qlmodelscoreorig     NUMBER,
  profitability3_val   NUMBER,
  structure2_val       NUMBER,
  leverage18_val       NUMBER,
  operation1_val       NUMBER,
  size2_val            NUMBER,
  profitability3_score NUMBER,
  structure2_score     NUMBER,
  leverage18_score     NUMBER,
  operation1_score     NUMBER,
  size2_score          NUMBER,
  factor_001_val       NUMBER,
  factor_029_val       NUMBER,
  factor_086_val       NUMBER,
  factor_003_val       NUMBER,
  factor_001_score     NUMBER,
  factor_029_score     NUMBER,
  factor_086_score     NUMBER,
  factor_003_score     NUMBER
)
;

prompt
prompt Creating table ZMD_CMP_GONGYESHEBEIZZ
prompt =====================================
prompt
create table ZMD_CMP_GONGYESHEBEIZZ
(
  key                  VARCHAR2(300) not null,
  company_id           NUMBER(16) not null,
  company_nm           VARCHAR2(300) not null,
  rpt_date             DATE not null,
  modelscore           NUMBER(32,16),
  qnmodelscore         NUMBER,
  qlmodelscore         NUMBER,
  qlmodelscoreorig     NUMBER,
  profitability3_val   NUMBER,
  structure2_val       NUMBER,
  leverage09_val       NUMBER,
  operation1_val       NUMBER,
  size2_val            NUMBER,
  profitability3_score NUMBER,
  structure2_score     NUMBER,
  leverage09_score     NUMBER,
  operation1_score     NUMBER,
  size2_score          NUMBER,
  factor_001_val       NUMBER,
  factor_071_val       NUMBER,
  factor_173_val       NUMBER,
  factor_011_val       NUMBER,
  factor_012_val       NUMBER,
  factor_008_val       NUMBER,
  factor_001_score     NUMBER,
  factor_071_score     NUMBER,
  factor_173_score     NUMBER,
  factor_011_score     NUMBER,
  factor_012_score     NUMBER,
  factor_008_score     NUMBER
)
;

prompt
prompt Creating table ZMD_CMP_GONGYONGSHIYE
prompt ====================================
prompt
create table ZMD_CMP_GONGYONGSHIYE
(
  key                  VARCHAR2(300) not null,
  company_id           NUMBER(16) not null,
  company_nm           VARCHAR2(300) not null,
  rpt_date             DATE not null,
  modelscore           NUMBER(32,16),
  qnmodelscore         NUMBER,
  qlmodelscore         NUMBER,
  qlmodelscoreorig     NUMBER,
  profitability3_val   NUMBER,
  structure019_val     NUMBER,
  operation13_val      NUMBER,
  size2_val            NUMBER,
  profitability3_score NUMBER,
  structure019_score   NUMBER,
  operation13_score    NUMBER,
  size2_score          NUMBER,
  factor_004_val       NUMBER,
  factor_001_val       NUMBER,
  factor_079_val       NUMBER,
  factor_003_val       NUMBER,
  factor_004_score     NUMBER,
  factor_001_score     NUMBER,
  factor_079_score     NUMBER,
  factor_003_score     NUMBER
)
;

prompt
prompt Creating table ZMD_CMP_GUQUANTOUZI
prompt ==================================
prompt
create table ZMD_CMP_GUQUANTOUZI
(
  key              VARCHAR2(300) not null,
  company_id       NUMBER(16) not null,
  company_nm       VARCHAR2(300) not null,
  rpt_date         DATE not null,
  modelscore       NUMBER(32,16),
  factor_125_val   NUMBER,
  factor_134_val   NUMBER,
  factor_127_val   NUMBER,
  factor_128_val   NUMBER,
  factor_129_val   NUMBER,
  factor_130_val   NUMBER,
  factor_120_val   NUMBER,
  factor_108_val   NUMBER,
  factor_004_val   NUMBER,
  factor_113_val   NUMBER,
  factor_132_val   NUMBER,
  factor_094_val   NUMBER,
  factor_133_val   NUMBER,
  factor_122_val   NUMBER,
  factor_125_score NUMBER,
  factor_134_score NUMBER,
  factor_127_score NUMBER,
  factor_128_score NUMBER,
  factor_129_score NUMBER,
  factor_130_score NUMBER,
  factor_120_score NUMBER,
  factor_108_score NUMBER,
  factor_004_score NUMBER,
  factor_113_score NUMBER,
  factor_132_score NUMBER,
  factor_094_score NUMBER,
  factor_133_score NUMBER,
  factor_122_score NUMBER
)
;

prompt
prompt Creating table ZMD_CMP_JIANZHU
prompt ==============================
prompt
create table ZMD_CMP_JIANZHU
(
  key                  VARCHAR2(300) not null,
  company_id           NUMBER(16) not null,
  company_nm           VARCHAR2(300) not null,
  rpt_date             DATE not null,
  modelscore           NUMBER(32,16),
  qnmodelscore         NUMBER,
  qlmodelscore         NUMBER,
  qlmodelscoreorig     NUMBER,
  profitability6_val   NUMBER,
  structure2_val       NUMBER,
  structure13_val      NUMBER,
  leverage9_val        NUMBER,
  operation6_val       NUMBER,
  size4_val            NUMBER,
  profitability6_score NUMBER,
  structure2_score     NUMBER,
  structure13_score    NUMBER,
  leverage9_score      NUMBER,
  operation6_score     NUMBER,
  size4_score          NUMBER,
  factor_001_val       NUMBER,
  factor_029_val       NUMBER,
  factor_032_val       NUMBER,
  factor_034_val       NUMBER,
  factor_012_val       NUMBER,
  factor_001_score     NUMBER,
  factor_029_score     NUMBER,
  factor_032_score     NUMBER,
  factor_034_score     NUMBER,
  factor_012_score     NUMBER
)
;

prompt
prompt Creating table ZMD_CMP_JIAOTONGYUNSHU
prompt =====================================
prompt
create table ZMD_CMP_JIAOTONGYUNSHU
(
  key               VARCHAR2(300) not null,
  company_id        NUMBER(16) not null,
  company_nm        VARCHAR2(300) not null,
  rpt_date          DATE not null,
  modelscore        NUMBER(32,16),
  qnmodelscore      NUMBER,
  qlmodelscore      NUMBER,
  qlmodelscoreorig  NUMBER,
  structure1_val    NUMBER,
  operation12_val   NUMBER,
  leverage6_val     NUMBER,
  size2_val         NUMBER,
  structure1_score  NUMBER,
  operation12_score NUMBER,
  leverage6_score   NUMBER,
  size2_score       NUMBER,
  factor_001_val    NUMBER,
  factor_077_val    NUMBER,
  factor_583_val    NUMBER,
  factor_006_val    NUMBER,
  factor_078_val    NUMBER,
  factor_001_score  NUMBER,
  factor_077_score  NUMBER,
  factor_583_score  NUMBER,
  factor_006_score  NUMBER,
  factor_078_score  NUMBER
)
;

prompt
prompt Creating table ZMD_CMP_JINRONGTONGYONG
prompt ======================================
prompt
create table ZMD_CMP_JINRONGTONGYONG
(
  key              VARCHAR2(300) not null,
  company_id       NUMBER(16) not null,
  company_nm       VARCHAR2(300) not null,
  rpt_date         DATE not null,
  modelscore       NUMBER(32,16),
  factor_125_val   NUMBER,
  factor_118_val   NUMBER,
  factor_119_val   NUMBER,
  factor_108_val   NUMBER,
  factor_005_val   NUMBER,
  factor_120_val   NUMBER,
  factor_121_val   NUMBER,
  factor_113_val   NUMBER,
  factor_123_val   NUMBER,
  factor_114_val   NUMBER,
  factor_124_val   NUMBER,
  factor_122_val   NUMBER,
  factor_125_score NUMBER,
  factor_118_score NUMBER,
  factor_119_score NUMBER,
  factor_108_score NUMBER,
  factor_005_score NUMBER,
  factor_120_score NUMBER,
  factor_121_score NUMBER,
  factor_113_score NUMBER,
  factor_123_score NUMBER,
  factor_114_score NUMBER,
  factor_124_score NUMBER,
  factor_122_score NUMBER
)
;

prompt
prompt Creating table ZMD_CMP_PIFALINGSHOU
prompt ===================================
prompt
create table ZMD_CMP_PIFALINGSHOU
(
  key                  VARCHAR2(300) not null,
  company_id           NUMBER(16) not null,
  company_nm           VARCHAR2(300) not null,
  rpt_date             DATE not null,
  modelscore           NUMBER(32,16),
  qnmodelscore         NUMBER,
  qlmodelscore         NUMBER,
  qlmodelscoreorig     NUMBER,
  profitability3_val   NUMBER,
  structure2_val       NUMBER,
  leverage5_val        NUMBER,
  operation6_val       NUMBER,
  size1_val            NUMBER,
  profitability3_score NUMBER,
  structure2_score     NUMBER,
  leverage5_score      NUMBER,
  operation6_score     NUMBER,
  size1_score          NUMBER,
  factor_001_val       NUMBER,
  factor_071_val       NUMBER,
  factor_089_val       NUMBER,
  factor_009_val       NUMBER,
  factor_008_val       NUMBER,
  factor_001_score     NUMBER,
  factor_071_score     NUMBER,
  factor_089_score     NUMBER,
  factor_009_score     NUMBER,
  factor_008_score     NUMBER
)
;

prompt
prompt Creating table ZMD_CMP_RONGZIPINGTAI
prompt ====================================
prompt
create table ZMD_CMP_RONGZIPINGTAI
(
  key                VARCHAR2(300) not null,
  company_id         NUMBER(16) not null,
  company_nm         VARCHAR2(300) not null,
  rpt_date           DATE not null,
  modelscore         NUMBER(32,16),
  factor_514_val     NUMBER,
  zs_factor_14_val   NUMBER,
  factor_522_val     NUMBER,
  factor_520_val     NUMBER,
  factor_528_val     NUMBER,
  factor_181_val     NUMBER,
  zs_factor_22_val   NUMBER,
  zs_factor_34_val   NUMBER,
  zs_factor_08_val   NUMBER,
  factor_183_val     NUMBER,
  factor_514_score   NUMBER,
  zs_factor_14_score NUMBER,
  factor_522_score   NUMBER,
  factor_520_score   NUMBER,
  factor_528_score   NUMBER,
  factor_181_score   NUMBER,
  zs_factor_22_score NUMBER,
  zs_factor_34_score NUMBER,
  zs_factor_08_score NUMBER,
  factor_183_score   NUMBER
)
;

prompt
prompt Creating table ZMD_CMP_RONGZIXINGDB
prompt ===================================
prompt
create table ZMD_CMP_RONGZIXINGDB
(
  key              VARCHAR2(300) not null,
  company_id       NUMBER(16) not null,
  company_nm       VARCHAR2(300) not null,
  rpt_date         DATE not null,
  modelscore       NUMBER(32,16),
  factor_001_val   NUMBER,
  factor_135_val   NUMBER,
  factor_004_val   NUMBER,
  factor_096_val   NUMBER,
  factor_095_val   NUMBER,
  factor_136_val   NUMBER,
  factor_094_val   NUMBER,
  factor_098_val   NUMBER,
  factor_099_val   NUMBER,
  factor_100_val   NUMBER,
  factor_102_val   NUMBER,
  factor_103_val   NUMBER,
  factor_001_score NUMBER,
  factor_135_score NUMBER,
  factor_004_score NUMBER,
  factor_096_score NUMBER,
  factor_095_score NUMBER,
  factor_136_score NUMBER,
  factor_094_score NUMBER,
  factor_098_score NUMBER,
  factor_099_score NUMBER,
  factor_100_score NUMBER,
  factor_102_score NUMBER,
  factor_103_score NUMBER
)
;

prompt
prompt Creating table ZMD_CMP_SHOUXIQIYE
prompt =================================
prompt
create table ZMD_CMP_SHOUXIQIYE
(
  key              VARCHAR2(300) not null,
  company_id       NUMBER(16) not null,
  company_nm       VARCHAR2(300) not null,
  rpt_date         DATE not null,
  modelscore       NUMBER(32,16),
  factor_125_val   NUMBER,
  factor_106_val   NUMBER,
  factor_107_val   NUMBER,
  factor_108_val   NUMBER,
  factor_126_val   NUMBER,
  factor_109_val   NUMBER,
  factor_110_val   NUMBER,
  factor_005_val   NUMBER,
  factor_111_val   NUMBER,
  factor_112_val   NUMBER,
  factor_113_val   NUMBER,
  factor_114_val   NUMBER,
  factor_094_val   NUMBER,
  factor_116_val   NUMBER,
  factor_117_val   NUMBER,
  factor_115_val   NUMBER,
  factor_125_score NUMBER,
  factor_106_score NUMBER,
  factor_107_score NUMBER,
  factor_108_score NUMBER,
  factor_126_score NUMBER,
  factor_109_score NUMBER,
  factor_110_score NUMBER,
  factor_005_score NUMBER,
  factor_111_score NUMBER,
  factor_112_score NUMBER,
  factor_113_score NUMBER,
  factor_114_score NUMBER,
  factor_094_score NUMBER,
  factor_116_score NUMBER,
  factor_117_score NUMBER,
  factor_115_score NUMBER
)
;

prompt
prompt Creating table ZMD_CMP_XIAOFEIPINZZ
prompt ===================================
prompt
create table ZMD_CMP_XIAOFEIPINZZ
(
  key                  VARCHAR2(300) not null,
  company_id           NUMBER(16) not null,
  company_nm           VARCHAR2(300) not null,
  rpt_date             DATE not null,
  modelscore           NUMBER(32,16),
  qnmodelscore         NUMBER,
  qlmodelscore         NUMBER,
  qlmodelscoreorig     NUMBER,
  profitability6_val   NUMBER,
  structure2_val       NUMBER,
  leverage3_val        NUMBER,
  leverage18_val       NUMBER,
  operation1_val       NUMBER,
  size1_val            NUMBER,
  profitability6_score NUMBER,
  structure2_score     NUMBER,
  leverage3_score      NUMBER,
  leverage18_score     NUMBER,
  operation1_score     NUMBER,
  size1_score          NUMBER,
  factor_001_val       NUMBER,
  factor_071_val       NUMBER,
  factor_012_val       NUMBER,
  factor_004_val       NUMBER,
  factor_001_score     NUMBER,
  factor_071_score     NUMBER,
  factor_012_score     NUMBER,
  factor_004_score     NUMBER
)
;

prompt
prompt Creating table ZMD_CMP_YIBANGONGSHANGTY
prompt =======================================
prompt
create table ZMD_CMP_YIBANGONGSHANGTY
(
  key                  VARCHAR2(300) not null,
  company_id           NUMBER(16) not null,
  company_nm           VARCHAR2(300) not null,
  rpt_date             DATE not null,
  modelscore           NUMBER(32,16),
  factor_001_val       NUMBER,
  factor_071_val       NUMBER,
  factor_011_val       NUMBER,
  factor_002_val       NUMBER,
  factor_012_val       NUMBER,
  factor_003_val       NUMBER,
  factor_008_val       NUMBER,
  factor_506_val       NUMBER,
  profitability3_val   NUMBER,
  structure2_val       NUMBER,
  leverage07_val       NUMBER,
  leverage09_val       NUMBER,
  leverage18_val       NUMBER,
  operation1_val       NUMBER,
  factor_001_score     NUMBER,
  factor_071_score     NUMBER,
  factor_011_score     NUMBER,
  factor_002_score     NUMBER,
  factor_012_score     NUMBER,
  factor_003_score     NUMBER,
  factor_008_score     NUMBER,
  factor_506_score     NUMBER,
  profitability3_score NUMBER,
  structure2_score     NUMBER,
  leverage07_score     NUMBER,
  leverage09_score     NUMBER,
  leverage18_score     NUMBER,
  operation1_score     NUMBER
)
;

prompt
prompt Creating table ZMD_CMP_YINHANG
prompt ==============================
prompt
create table ZMD_CMP_YINHANG
(
  key                          VARCHAR2(300) not null,
  company_id                   NUMBER(16) not null,
  company_nm                   VARCHAR2(300) not null,
  rpt_date                     DATE not null,
  modelscore                   NUMBER(32,16),
  qnmodelscore                 NUMBER,
  qlmodelscore                 NUMBER,
  qlmodelscoreorig             NUMBER,
  zs_bank_leverage3_val        NUMBER,
  zs_bank_liquidity4_val       NUMBER,
  zs_bank_profitability2_val   NUMBER,
  zs_bank_profitability4_val   NUMBER,
  zs_bank_profitability8_val   NUMBER,
  zs_bank_size1_val            NUMBER,
  zs_bank_leverage3_score      NUMBER,
  zs_bank_liquidity4_score     NUMBER,
  zs_bank_profitability2_score NUMBER,
  zs_bank_profitability4_score NUMBER,
  zs_bank_profitability8_score NUMBER,
  zs_bank_size1_score          NUMBER,
  factor_001_val               NUMBER,
  factor_614_val               NUMBER,
  factor_619_val               NUMBER,
  factor_623_val               NUMBER,
  factor_426_val               NUMBER,
  factor_634_val               NUMBER,
  factor_112_val               NUMBER,
  factor_450_val               NUMBER,
  factor_617_val               NUMBER,
  factor_001_score             NUMBER,
  factor_614_score             NUMBER,
  factor_619_score             NUMBER,
  factor_623_score             NUMBER,
  factor_426_score             NUMBER,
  factor_634_score             NUMBER,
  factor_112_score             NUMBER,
  factor_450_score             NUMBER,
  factor_617_score             NUMBER
)
;

prompt
prompt Creating table ZMD_CMP_YIYAOZHIZAO
prompt ==================================
prompt
create table ZMD_CMP_YIYAOZHIZAO
(
  key                  VARCHAR2(300) not null,
  company_id           NUMBER(16) not null,
  company_nm           VARCHAR2(300) not null,
  rpt_date             DATE not null,
  modelscore           NUMBER(32,16),
  qnmodelscore         NUMBER,
  qlmodelscore         NUMBER,
  qlmodelscoreorig     NUMBER,
  profitability3_val   NUMBER,
  structure2_val       NUMBER,
  leverage18_val       NUMBER,
  operation13_val      NUMBER,
  size2_val            NUMBER,
  size10_val           NUMBER,
  profitability3_score NUMBER,
  structure2_score     NUMBER,
  leverage18_score     NUMBER,
  operation13_score    NUMBER,
  size2_score          NUMBER,
  size10_score         NUMBER,
  factor_001_val       NUMBER,
  factor_071_val       NUMBER,
  factor_091_val       NUMBER,
  factor_011_val       NUMBER,
  factor_001_score     NUMBER,
  factor_071_score     NUMBER,
  factor_091_score     NUMBER,
  factor_011_score     NUMBER
)
;

prompt
prompt Creating table ZMD_CMP_YUANCAILIAOZZ
prompt ====================================
prompt
create table ZMD_CMP_YUANCAILIAOZZ
(
  key                  VARCHAR2(300) not null,
  company_id           NUMBER(16) not null,
  company_nm           VARCHAR2(300) not null,
  rpt_date             DATE not null,
  modelscore           NUMBER(32,16),
  qnmodelscore         NUMBER,
  qlmodelscore         NUMBER,
  qlmodelscoreorig     NUMBER,
  profitability6_val   NUMBER,
  structure2_val       NUMBER,
  leverage07_val       NUMBER,
  leverage18_val       NUMBER,
  operation5_val       NUMBER,
  size2_val            NUMBER,
  profitability6_score NUMBER,
  structure2_score     NUMBER,
  leverage07_score     NUMBER,
  leverage18_score     NUMBER,
  operation5_score     NUMBER,
  size2_score          NUMBER,
  factor_071_val       NUMBER,
  factor_074_val       NUMBER,
  factor_067_val       NUMBER,
  factor_012_val       NUMBER,
  factor_582_val       NUMBER,
  factor_001_val       NUMBER,
  factor_008_val       NUMBER,
  factor_071_score     NUMBER,
  factor_074_score     NUMBER,
  factor_067_score     NUMBER,
  factor_012_score     NUMBER,
  factor_582_score     NUMBER,
  factor_001_score     NUMBER,
  factor_008_score     NUMBER
)
;

prompt
prompt Creating table ZMD_CMP_ZHENGQUANGONGSI
prompt ======================================
prompt
create table ZMD_CMP_ZHENGQUANGONGSI
(
  key                       VARCHAR2(300) not null,
  company_id                NUMBER(16) not null,
  company_nm                VARCHAR2(300) not null,
  rpt_date                  DATE not null,
  modelscore                NUMBER(32,16),
  qnmodelscore              NUMBER,
  qlmodelscore              NUMBER,
  qlmodelscoreorig          NUMBER,
  secu_growth7_val          NUMBER,
  secu_leverage3_val        NUMBER,
  secu_profitability8_val   NUMBER,
  secu_regulatory03_val     NUMBER,
  secu_size010_val          NUMBER,
  secu_growth7_score        NUMBER,
  secu_leverage3_score      NUMBER,
  secu_profitability8_score NUMBER,
  secu_regulatory03_score   NUMBER,
  secu_size010_score        NUMBER,
  factor_039_val            NUMBER,
  factor_044_val            NUMBER,
  factor_047_val            NUMBER,
  factor_050_val            NUMBER,
  factor_054_val            NUMBER,
  factor_056_val            NUMBER,
  factor_004_val            NUMBER,
  factor_039_score          NUMBER,
  factor_044_score          NUMBER,
  factor_047_score          NUMBER,
  factor_050_score          NUMBER,
  factor_054_score          NUMBER,
  factor_056_score          NUMBER,
  factor_004_score          NUMBER
)
;

prompt
prompt Creating view VW_ZMD_CMP_CAIKUANG
prompt =================================
prompt
CREATE OR REPLACE FORCE VIEW VW_ZMD_CMP_CAIKUANG AS
SELECT key,
       company_id,
       company_nm,
       rpt_date,
       modelscore,
       qnmodelscore,
       qlmodelscore,
       qlmodelscoreorig,
       profitability3_val,
       structure2_val,
       leverage07_val,
       leverage18_val,
       size2_val,
       profitability3_score,
       structure2_score,
       leverage07_score,
       leverage18_score,
       size2_score,
       factor_004_val,
       factor_006_val,
       factor_007_val,
       factor_008_val,
       factor_012_val,
       factor_580_val,
       factor_582_val,
       factor_001_val,
       factor_059_val,
       factor_004_score,
       factor_006_score,
       factor_007_score,
       factor_008_score,
       factor_012_score,
       factor_580_score,
       factor_582_score,
       factor_001_score,
       factor_059_score
  FROM (WITH factor_score_val AS (SELECT *
                                    FROM (SELECT t.rating_record_id,
                                                 rmf.ft_code,
                                                 t.score,
                                                 CASE
                                                   WHEN f.factor_type = '规模' THEN
                                                    exp(t.factor_val)
                                                   ELSE
                                                    t.factor_val
                                                 END AS factor_val
                                            FROM rating_factor t
                                            JOIN rating_model_factor rmf
                                              ON t.rm_factor_id = rmf.id
                                            JOIN factor f
                                              ON rmf.ft_code = f.factor_cd) mid
                                  pivot(MAX(factor_val) AS val, MAX(score) AS score
                                     FOR ft_code IN('Profitability3' AS
                                                   profitability3,
                                                   'Size2' AS size2,
                                                   'Leverage18' AS leverage18,
                                                   'Structure2' AS structure2,
                                                   'factor_001' AS factor_001,
                                                   'factor_004' AS factor_004,
                                                   'factor_006' AS factor_006,
                                                   'factor_007' AS factor_007,
                                                   'factor_008' AS factor_008,
                                                   'factor_012' AS factor_012,
                                                   'factor_059' AS factor_059,
                                                   'factor_580' AS factor_580,
                                                   'factor_582' AS factor_582,
                                                   'Leverage07' AS leverage07))), model_score AS (SELECT rating_record_id,
                                                                                                         qn_score,
                                                                                                         qn_orig_score,
                                                                                                         ql_score,
                                                                                                         ql_orig_score
                                                                                                    FROM (SELECT t.rating_record_id,
                                                                                                                 NAME,
                                                                                                                 score,
                                                                                                                 new_score
                                                                                                            FROM rating_detail t
                                                                                                            JOIN rating_model_sub_model rms
                                                                                                              ON t.rating_model_sub_model_id =
                                                                                                                 rms.id) mid
                                                                                                  pivot(MAX(score) AS orig_score, MAX(new_score) AS score
                                                                                                     FOR NAME IN('财务分析' AS qn,
                                                                                                                '非财务分析' AS ql)))
         SELECT cbf.company_nm AS key,
                r.company_id,
                cbf.company_nm,
                r.factor_dt    AS rpt_date,
                --r.rating_record_id,
                r.total_score AS modelscore,
                model_score.qn_score AS qnmodelscore,
                model_score.ql_score AS qlmodelscore,
                model_score.ql_orig_score AS qlmodelscoreorig,
                profitability3_val,
                structure2_val,
                leverage07_val,
                leverage18_val,
                size2_val,
                profitability3_score,
                structure2_score,
                leverage07_score,
                leverage18_score,
                size2_score,
                factor_004_val,
                factor_006_val,
                factor_007_val,
                factor_008_val,
                factor_012_val,
                factor_580_val,
                factor_582_val,
                factor_001_val,
                factor_059_val,
                factor_004_score,
                factor_006_score,
                factor_007_score,
                factor_008_score,
                factor_012_score,
                factor_580_score,
                factor_582_score,
                factor_001_score,
                factor_059_score,
                row_number() over(PARTITION BY cbf.company_id ORDER BY r.updt_dt DESC) AS rn
           FROM rating_record r
           JOIN compy_basicinfo cbf
             ON r.company_id = cbf.company_id
            AND cbf.is_del = 0
         --AND cbf.company_nm = '中国石油天然气股份有限公司'
           JOIN compy_exposure ce
             ON cbf.company_id = ce.company_id
            AND ce.is_new = 1
            AND ce.isdel = 0
           JOIN exposure e
             ON ce.exposure_sid = e.exposure_sid
            AND e.isdel = 0
            AND e.exposure = '采矿'
           JOIN factor_score_val
             ON r.rating_record_id = factor_score_val.rating_record_id
           JOIN model_score
             ON r.rating_record_id = model_score.rating_record_id)
          WHERE rn = 1
;

prompt
prompt Creating view VW_ZMD_CMP_FANGDICHAN
prompt ===================================
prompt
CREATE OR REPLACE FORCE VIEW VW_ZMD_CMP_FANGDICHAN AS
SELECT key,
       company_id,
       company_nm,
       rpt_date,
       modelscore,
       qnmodelscore,
       qlmodelscore,
       qlmodelscoreorig,
       structure3_val,
       structure019_val,
       leverage17_val,
       operation3_val,
       size2_val,
       specific7_val,
       structure3_score,
       structure019_score,
       leverage17_score,
       operation3_score,
       size2_score,
       specific7_score,

       factor_015_val,
       factor_001_val,
       factor_192_val,
       factor_190_val,
       factor_006_val,
       factor_020_val,
       factor_015_score,
       factor_001_score,
       factor_192_score,
       factor_190_score,
       factor_006_score,
       factor_020_score
  FROM (WITH factor_score_val AS (SELECT *
                                    FROM (SELECT t.rating_record_id,
                                                 rmf.ft_code,
                                                 t.score,
                                                 CASE
                                                   WHEN f.factor_type = '规模' THEN
                                                    exp(t.factor_val)
                                                   ELSE
                                                    t.factor_val
                                                 END AS factor_val
                                            FROM rating_factor t
                                            JOIN rating_model_factor rmf
                                              ON t.rm_factor_id = rmf.id
                                            JOIN factor f
                                              ON rmf.ft_code = f.factor_cd) mid
                                  pivot(MAX(factor_val) AS val, MAX(score) AS score
                                     FOR ft_code IN(

                                                   'Structure3' AS structure3,
                                                   'Structure019' AS Structure019,
                                                   'Leverage17' AS leverage17,
                                                   'Operation3' AS operation3,
                                                   'Size2' AS size2,
                                                   'Specific7' AS specific7,

                                                   'factor_015' AS factor_015,
                                                   'factor_001' AS factor_001,
                                                   'factor_192' AS factor_192,
                                                   'factor_190' AS factor_190,
                                                   'factor_006' AS factor_006,
                                                   'factor_020' AS factor_020

                                                   ))), model_score AS (SELECT rating_record_id,
                                                                               qn_score,
                                                                               qn_orig_score,
                                                                               qi_score,
                                                                               qi_orig_score
                                                                          FROM (SELECT t.rating_record_id,
                                                                                       NAME,
                                                                                       score,
                                                                                       new_score
                                                                                  FROM rating_detail t
                                                                                  JOIN rating_model_sub_model rms
                                                                                    ON t.rating_model_sub_model_id =
                                                                                       rms.id) mid
                                                                        pivot(MAX(score) AS orig_score, MAX(new_score) AS score
                                                                           FOR NAME IN('财务分析' AS qn,
                                                                                      '非财务分析' AS qi)))
         SELECT cbf.company_nm AS key,
                r.company_id,
                cbf.company_nm,
                r.factor_dt    AS rpt_date,
                --r.rating_record_id,
                r.total_score             AS modelscore,
                model_score.qn_score      AS qnmodelscore,
                model_score.qi_score      AS qlmodelscore,
                model_score.qi_orig_score AS qlmodelscoreorig,
                structure3_val,
                structure019_val,
                leverage17_val,
                operation3_val,
                size2_val,
                specific7_val,
                structure3_score,
                structure019_score,
                leverage17_score,
                operation3_score,
                size2_score,
                specific7_score,

                factor_015_val,
                factor_001_val,
                factor_192_val,
                factor_190_val,
                factor_006_val,
                factor_020_val,
                factor_015_score,
                factor_001_score,
                factor_192_score,
                factor_190_score,
                factor_006_score,
                factor_020_score,
                row_number() over(PARTITION BY cbf.company_id ORDER BY r.updt_dt DESC) AS rn
           FROM rating_record r
           JOIN compy_basicinfo cbf
             ON r.company_id = cbf.company_id
            AND cbf.is_del = 0
         --AND cbf.company_nm = '中国石油天然气股份有限公司'
           JOIN compy_exposure ce
             ON cbf.company_id = ce.company_id
            AND ce.is_new = 1
            AND ce.isdel = 0
           JOIN exposure e
             ON ce.exposure_sid = e.exposure_sid
            AND e.isdel = 0
            AND e.exposure = '房地产'
           JOIN factor_score_val
             ON r.rating_record_id = factor_score_val.rating_record_id
           JOIN model_score
             ON r.rating_record_id = model_score.rating_record_id)
          WHERE rn = 1
;

prompt
prompt Creating view VW_ZMD_CMP_FUWUYE
prompt ===============================
prompt
CREATE OR REPLACE FORCE VIEW VW_ZMD_CMP_FUWUYE AS
SELECT key,
       company_id,
       company_nm,
       rpt_date,
       modelscore,
       qnmodelscore,
       qlmodelscore,
       qlmodelscoreorig,

       profitability3_val,
       structure2_val,
       leverage18_val,
       operation1_val,
       size2_val,

       profitability3_score,
       structure2_score,
       leverage18_score,
       operation1_score,
       size2_score,

       factor_001_val,
       factor_029_val,
       factor_086_val,
       factor_003_val,

       factor_001_score,
       factor_029_score,
       factor_086_score,
       factor_003_score

  FROM (

       WITH factor_score_val AS (SELECT *
                                   FROM (SELECT t.rating_record_id,
                                                rmf.ft_code,
                                                t.score,
                                                CASE
                                                  WHEN f.factor_type = '规模' THEN
                                                   exp(t.factor_val)
                                                  ELSE
                                                   t.factor_val
                                                END AS factor_val
                                           FROM rating_factor t
                                           JOIN rating_model_factor rmf
                                             ON t.rm_factor_id = rmf.id
                                           JOIN factor f
                                             ON rmf.ft_code = f.factor_cd) mid
                                 pivot(MAX(factor_val) AS val, MAX(score) AS score
                                    FOR ft_code IN('Profitability3' AS
                                                  profitability3,
                                                  'Structure2' AS structure2,
                                                  'Leverage18' AS leverage18,
                                                  'Operation1' AS operation1,
                                                  'Size2' AS size2,
                                                  'factor_001' AS factor_001,
                                                  'factor_029' AS factor_029,
                                                  'factor_086' AS factor_086,
                                                  'factor_003' AS factor_003))), model_score AS (SELECT rating_record_id,
                                                                                                        qn_score,
                                                                                                        qn_orig_score,
                                                                                                        qi_score,
                                                                                                        qi_orig_score
                                                                                                   FROM (SELECT t.rating_record_id,
                                                                                                                NAME,
                                                                                                                score,
                                                                                                                new_score
                                                                                                           FROM rating_detail t
                                                                                                           JOIN rating_model_sub_model rms
                                                                                                             ON t.rating_model_sub_model_id =
                                                                                                                rms.id) mid
                                                                                                 pivot(MAX(score) AS orig_score, MAX(new_score) AS score
                                                                                                    FOR NAME IN('财务分析' AS qn,
                                                                                                               '非财务分析' AS qi)))
         SELECT cbf.company_nm AS key,
                r.company_id,
                cbf.company_nm,
                r.factor_dt    AS rpt_date,
                --r.rating_record_id,
                r.total_score             AS modelscore,
                model_score.qn_score      AS qnmodelscore,
                model_score.qi_score      AS qlmodelscore,
                model_score.qi_orig_score AS qlmodelscoreorig,

                profitability3_val,
                structure2_val,
                leverage18_val,
                operation1_val,
                size2_val,

                profitability3_score,
                structure2_score,
                leverage18_score,
                operation1_score,
                size2_score,

                factor_001_val,
                factor_029_val,
                factor_086_val,
                factor_003_val,

                factor_001_score,
                factor_029_score,
                factor_086_score,
                factor_003_score,

                row_number() over(PARTITION BY cbf.company_id ORDER BY r.updt_dt DESC) AS rn
           FROM rating_record r
           JOIN compy_basicinfo cbf
             ON r.company_id = cbf.company_id
            AND cbf.is_del = 0
         --AND cbf.company_nm = '中国石油天然气股份有限公司'
           JOIN compy_exposure ce
             ON cbf.company_id = ce.company_id
            AND ce.is_new = 1
            AND ce.isdel = 0
           JOIN exposure e
             ON ce.exposure_sid = e.exposure_sid
            AND e.isdel = 0
            AND e.exposure = '服务业'
           JOIN factor_score_val
             ON r.rating_record_id = factor_score_val.rating_record_id
           JOIN model_score
             ON r.rating_record_id = model_score.rating_record_id)
          WHERE rn = 1
;

prompt
prompt Creating view VW_ZMD_CMP_GONGYESHEBEIZZ
prompt =======================================
prompt
CREATE OR REPLACE FORCE VIEW VW_ZMD_CMP_GONGYESHEBEIZZ AS
SELECT key,
       company_id,
       company_nm,
       rpt_date,
       modelscore,
       qnmodelscore,
       qlmodelscore,
       qlmodelscoreorig,

       profitability3_val,
       structure2_val,
       leverage09_val,
       operation1_val,
       size2_val,

       profitability3_score,
       structure2_score,
       leverage09_score,
       operation1_score,
       size2_score,

       factor_001_val,
       factor_071_val,
       factor_173_val,
       factor_011_val,
       factor_012_val,
       factor_008_val,
       factor_001_score,
       factor_071_score,
       factor_173_score,
       factor_011_score,
       factor_012_score,
       factor_008_score

  FROM (

       WITH factor_score_val AS (SELECT *
                                   FROM (SELECT t.rating_record_id,
                                                rmf.ft_code,
                                                t.score,
                                                CASE
                                                  WHEN f.factor_type = '规模' THEN
                                                   exp(t.factor_val)
                                                  ELSE
                                                   t.factor_val
                                                END AS factor_val
                                           FROM rating_factor t
                                           JOIN rating_model_factor rmf
                                             ON t.rm_factor_id = rmf.id
                                           JOIN factor f
                                             ON rmf.ft_code = f.factor_cd) mid
                                 pivot(MAX(factor_val) AS val, MAX(score) AS score
                                    FOR ft_code IN('Profitability3' AS
                                                  profitability3,
                                                  'Structure2' AS structure2,
                                                  'Leverage09' AS leverage09,
                                                  'Operation1' AS operation1,
                                                  'Size2' AS size2,
                                                  'factor_001' AS factor_001,
                                                  'factor_071' AS factor_071,
                                                  'factor_173' AS factor_173,
                                                  'factor_011' AS factor_011,
                                                  'factor_012' AS factor_012,
                                                  'factor_008' AS factor_008))), model_score AS (SELECT rating_record_id,
                                                                                                         qn_score,
                                                                                                         qn_orig_score,
                                                                                                         qi_score,
                                                                                                         qi_orig_score
                                                                                                    FROM (SELECT t.rating_record_id,
                                                                                                                 NAME,
                                                                                                                 score,
                                                                                                                 new_score
                                                                                                            FROM rating_detail t
                                                                                                            JOIN rating_model_sub_model rms
                                                                                                              ON t.rating_model_sub_model_id =
                                                                                                                 rms.id) mid
                                                                                                  pivot(MAX(score) AS orig_score, MAX(new_score) AS score
                                                                                                     FOR NAME IN('财务分析' AS qn,
                                                                                                                '非财务分析' AS qi)))
         SELECT cbf.company_nm AS key,
                r.company_id,
                cbf.company_nm,
                r.factor_dt    AS rpt_date,
                --r.rating_record_id,
                r.total_score             AS modelscore,
                model_score.qn_score      AS qnmodelscore,
                model_score.qi_score      AS qlmodelscore,
                model_score.qi_orig_score AS qlmodelscoreorig,
                profitability3_val,
                structure2_val,
                leverage09_val,
                operation1_val,
                size2_val,

                profitability3_score,
                structure2_score,
                leverage09_score,
                operation1_score,
                size2_score,

                factor_001_val,
                factor_071_val,
                factor_173_val,
                factor_011_val,
                factor_012_val,
                factor_008_val,
                factor_001_score,
                factor_071_score,
                factor_173_score,
                factor_011_score,
                factor_012_score,
                factor_008_score,
                row_number() over(PARTITION BY cbf.company_id ORDER BY r.updt_dt DESC) AS rn
           FROM rating_record r
           JOIN compy_basicinfo cbf
             ON r.company_id = cbf.company_id
            AND cbf.is_del = 0
         --AND cbf.company_nm = '中国石油天然气股份有限公司'
           JOIN compy_exposure ce
             ON cbf.company_id = ce.company_id
            AND ce.is_new = 1
            AND ce.isdel = 0
           JOIN exposure e
             ON ce.exposure_sid = e.exposure_sid
            AND e.isdel = 0
            AND e.exposure = '工业设备制造'
           JOIN factor_score_val
             ON r.rating_record_id = factor_score_val.rating_record_id
           JOIN model_score
             ON r.rating_record_id = model_score.rating_record_id

          )
          WHERE rn = 1
;

prompt
prompt Creating view VW_ZMD_CMP_GONGYONGSHIYE
prompt ======================================
prompt
CREATE OR REPLACE FORCE VIEW VW_ZMD_CMP_GONGYONGSHIYE AS
SELECT key,
       company_id,
       company_nm,
       rpt_date,
       modelscore,
       qnmodelscore,
       qlmodelscore,
       qlmodelscoreorig,

       profitability3_val,
       structure019_val,
       operation13_val,
       size2_val,
       profitability3_score,
       structure019_score,
       operation13_score,
       size2_score,
       factor_004_val,
       factor_001_val,
       factor_079_val,
       factor_003_val,
       factor_004_score,
       factor_001_score,
       factor_079_score,
       factor_003_score

  FROM (

  WITH factor_score_val AS
   (SELECT *
      FROM (SELECT t.rating_record_id,
                   rmf.ft_code,
                   t.score,
                   CASE
                     WHEN f.factor_type = '规模' THEN
                      exp(t.factor_val)
                     ELSE
                      t.factor_val
                   END AS factor_val
              FROM rating_factor t
              JOIN rating_model_factor rmf
                ON t.rm_factor_id = rmf.id
              JOIN factor f
                ON rmf.ft_code = f.factor_cd) mid
    pivot(MAX(factor_val) AS val, MAX(score) AS score
       FOR ft_code IN('Profitability3' AS Profitability3,
                     'Structure019' AS Structure019,
                     'Operation13' AS Operation13,
                     'Size2' AS Size2,
                     'factor_004' AS factor_004,
                     'factor_001' AS factor_001,
                     'factor_079' AS factor_079,
                     'factor_003' AS factor_003
                     ))),
  model_score AS
   (SELECT rating_record_id, qn_score, qn_orig_score, qi_score, qi_orig_score
      FROM (SELECT t.rating_record_id, NAME, score, new_score
              FROM rating_detail t
              JOIN rating_model_sub_model rms
                ON t.rating_model_sub_model_id = rms.id) mid
    pivot(MAX(score) AS orig_score, MAX(new_score) AS score
       FOR NAME IN('财务分析' AS qn, '非财务分析' AS qi)))
  SELECT cbf.company_nm AS key,
         r.company_id,
         cbf.company_nm,
         r.factor_dt    AS rpt_date,
         --r.rating_record_id,
         r.total_score AS modelscore,
         model_score.qn_score AS qnmodelscore,
         model_score.qi_score AS qlmodelscore,
         model_score.qi_orig_score AS qlmodelscoreorig,
         profitability3_val,
         structure019_val,
         operation13_val,
         size2_val,
         profitability3_score,
         structure019_score,
         operation13_score,
         size2_score,
         factor_004_val,
         factor_001_val,
         factor_079_val,
         factor_003_val,
         factor_004_score,
         factor_001_score,
         factor_079_score,
         factor_003_score,
         row_number() over(PARTITION BY cbf.company_id ORDER BY r.updt_dt DESC) AS rn
    FROM rating_record r
    JOIN compy_basicinfo cbf
      ON r.company_id = cbf.company_id
     AND cbf.is_del = 0
  --AND cbf.company_nm = '中国石油天然气股份有限公司'
    JOIN compy_exposure ce
      ON cbf.company_id = ce.company_id
     AND ce.is_new = 1
     AND ce.isdel = 0
    JOIN exposure e
      ON ce.exposure_sid = e.exposure_sid
     AND e.isdel = 0
     AND e.exposure = '公用事业'
    JOIN factor_score_val
      ON r.rating_record_id = factor_score_val.rating_record_id
    JOIN model_score
      ON r.rating_record_id = model_score.rating_record_id

             )
          WHERE rn = 1
;

prompt
prompt Creating view VW_ZMD_CMP_GUQUANTOUZI
prompt ====================================
prompt
CREATE OR REPLACE FORCE VIEW VW_ZMD_CMP_GUQUANTOUZI AS
SELECT key,
       company_id,
       company_nm,
       rpt_date,
       modelscore,

       factor_125_val,
       factor_134_val,
       factor_127_val,
       factor_128_val,
       factor_129_val,
       factor_130_val,
       factor_120_val,
       factor_108_val,
       factor_004_val,
       factor_113_val,
       factor_132_val,
       factor_094_val,
       factor_133_val,
       factor_122_val,
       factor_125_score,
       factor_134_score,
       factor_127_score,
       factor_128_score,
       factor_129_score,
       factor_130_score,
       factor_120_score,
       factor_108_score,
       factor_004_score,
       factor_113_score,
       factor_132_score,
       factor_094_score,
       factor_133_score,
       factor_122_score

  FROM (

       WITH factor_score_val AS (SELECT *
                                   FROM (SELECT t.rating_record_id,
                                                rmf.ft_code,
                                                t.score,
                                                CASE
                                                  WHEN f.factor_type = '规模' THEN
                                                   exp(t.factor_val)
                                                  ELSE
                                                   t.factor_val
                                                END AS factor_val
                                           FROM rating_factor t
                                           JOIN rating_model_factor rmf
                                             ON t.rm_factor_id = rmf.id
                                           JOIN factor f
                                             ON rmf.ft_code = f.factor_cd) mid
                                 pivot(MAX(factor_val) AS val, MAX(score) AS score
                                    FOR ft_code IN('factor_125' AS factor_125,
                                                  'factor_134' AS factor_134,
                                                  'factor_127' AS factor_127,
                                                  'factor_128' AS factor_128,
                                                  'factor_129' AS factor_129,
                                                  'factor_130' AS factor_130,
                                                  'factor_120' AS factor_120,
                                                  'factor_108' AS factor_108,
                                                  'factor_004' AS factor_004,
                                                  'factor_113' AS factor_113,
                                                  'factor_132' AS factor_132,
                                                  'factor_094' AS factor_094,
                                                  'factor_133' AS factor_133,
                                                  'factor_122' AS factor_122

                                                  ))), model_score AS (SELECT rating_record_id,
                                                                              qn_score,
                                                                              qn_orig_score,
                                                                              qi_score,
                                                                              qi_orig_score
                                                                         FROM (SELECT t.rating_record_id,
                                                                                      NAME,
                                                                                      score,
                                                                                      new_score
                                                                                 FROM rating_detail t
                                                                                 JOIN rating_model_sub_model rms
                                                                                   ON t.rating_model_sub_model_id =
                                                                                      rms.id) mid
                                                                       pivot(MAX(score) AS orig_score, MAX(new_score) AS score
                                                                          FOR NAME IN('财务分析' AS qn,
                                                                                     '非财务分析' AS qi)))
         SELECT cbf.company_nm AS key,
                r.company_id,
                cbf.company_nm,
                r.factor_dt    AS rpt_date,
                --r.rating_record_id,
                r.total_score             AS modelscore,
                model_score.qn_score      AS qnmodelscore,
                model_score.qi_score      AS qlmodelscore,
                model_score.qi_orig_score AS qlmodelscoreorig,

                factor_125_val,
                factor_134_val,
                factor_127_val,
                factor_128_val,
                factor_129_val,
                factor_130_val,
                factor_120_val,
                factor_108_val,
                factor_004_val,
                factor_113_val,
                factor_132_val,
                factor_094_val,
                factor_133_val,
                factor_122_val,
                factor_125_score,
                factor_134_score,
                factor_127_score,
                factor_128_score,
                factor_129_score,
                factor_130_score,
                factor_120_score,
                factor_108_score,
                factor_004_score,
                factor_113_score,
                factor_132_score,
                factor_094_score,
                factor_133_score,
                factor_122_score,

                row_number() over(PARTITION BY cbf.company_id ORDER BY r.updt_dt DESC) AS rn
           FROM rating_record r
           JOIN compy_basicinfo cbf
             ON r.company_id = cbf.company_id
            AND cbf.is_del = 0
         --AND cbf.company_nm = '中国石油天然气股份有限公司'
           JOIN compy_exposure ce
             ON cbf.company_id = ce.company_id
            AND ce.is_new = 1
            AND ce.isdel = 0
           JOIN exposure e
             ON ce.exposure_sid = e.exposure_sid
            AND e.isdel = 0
            AND e.exposure = '股权投资'
           JOIN factor_score_val
             ON r.rating_record_id = factor_score_val.rating_record_id
           JOIN model_score
             ON r.rating_record_id = model_score.rating_record_id)
          WHERE rn = 1
;

prompt
prompt Creating view VW_ZMD_CMP_JIANZHU
prompt ================================
prompt
CREATE OR REPLACE FORCE VIEW VW_ZMD_CMP_JIANZHU AS
SELECT key,
       company_id,
       company_nm,
       rpt_date,
       modelscore,
       qnmodelscore,
       qlmodelscore,
       qlmodelscoreorig,

       profitability6_val,
       structure2_val,
       structure13_val,
       leverage09_val,
       operation6_val,
       size4_val,

       profitability6_score,
       structure2_score,
       structure13_score,
       leverage09_score,
       operation6_score,
       size4_score,

       factor_001_val,
       factor_029_val,
       factor_032_val,
       factor_034_val,
       factor_012_val,

       factor_001_score,
       factor_029_score,
       factor_032_score,
       factor_034_score,
       factor_012_score

  FROM (WITH factor_score_val AS (SELECT *
                                    FROM (SELECT t.rating_record_id,
                                                 rmf.ft_code,
                                                 t.score,
                                                 CASE
                                                   WHEN f.factor_type = '规模' THEN
                                                    exp(t.factor_val)
                                                   ELSE
                                                    t.factor_val
                                                 END AS factor_val
                                            FROM rating_factor t
                                            JOIN rating_model_factor rmf
                                              ON t.rm_factor_id = rmf.id
                                            JOIN factor f
                                              ON rmf.ft_code = f.factor_cd) mid
                                  pivot(MAX(factor_val) AS val, MAX(score) AS score
                                     FOR ft_code IN(
                                                   'Profitability6' AS profitability6,
                                                   'Structure2' AS structure2,
                                                   'Structure13' AS structure13,
                                                   'Leverage09' AS leverage09,
                                                   'Operation6' AS operation6,
                                                   'Size4' AS size4,

                                                   'factor_001' AS factor_001,
                                                   'factor_029' AS factor_029,
                                                   'factor_032' AS factor_032,
                                                   'factor_034' AS factor_034,
                                                   'factor_012' AS factor_012

                                                   ))), model_score AS (SELECT rating_record_id,
                                                                               qn_score,
                                                                               qn_orig_score,
                                                                               qi_score,
                                                                               qi_orig_score
                                                                          FROM (SELECT t.rating_record_id,
                                                                                       NAME,
                                                                                       score,
                                                                                       new_score
                                                                                  FROM rating_detail t
                                                                                  JOIN rating_model_sub_model rms
                                                                                    ON t.rating_model_sub_model_id =
                                                                                       rms.id) mid
                                                                        pivot(MAX(score) AS orig_score, MAX(new_score) AS score
                                                                           FOR NAME IN('财务分析' AS qn,
                                                                                      '非财务分析' AS qi)))
         SELECT cbf.company_nm AS key,
                r.company_id,
                cbf.company_nm,
                r.factor_dt    AS rpt_date,
                --r.rating_record_id,
                r.total_score             AS modelscore,
                model_score.qn_score      AS qnmodelscore,
                model_score.qi_score      AS qlmodelscore,
                model_score.qi_orig_score AS qlmodelscoreorig,
                profitability6_val,
       structure2_val,
       structure13_val,
       leverage09_val,
       operation6_val,
       size4_val,

       profitability6_score,
       structure2_score,
       structure13_score,
       leverage09_score,
       operation6_score,
       size4_score,

       factor_001_val,
       factor_029_val,
       factor_032_val,
       factor_034_val,
       factor_012_val,

       factor_001_score,
       factor_029_score,
       factor_032_score,
       factor_034_score,
       factor_012_score,
                row_number() over(PARTITION BY cbf.company_id ORDER BY r.updt_dt DESC) AS rn
           FROM rating_record r
           JOIN compy_basicinfo cbf
             ON r.company_id = cbf.company_id
            AND cbf.is_del = 0
         --AND cbf.company_nm = '中国石油天然气股份有限公司'
           JOIN compy_exposure ce
             ON cbf.company_id = ce.company_id
            AND ce.is_new = 1
            AND ce.isdel = 0
           JOIN exposure e
             ON ce.exposure_sid = e.exposure_sid
            AND e.isdel = 0
            AND e.exposure = '建筑'
           JOIN factor_score_val
             ON r.rating_record_id = factor_score_val.rating_record_id
           JOIN model_score
             ON r.rating_record_id = model_score.rating_record_id)
          WHERE rn = 1
;

prompt
prompt Creating view VW_ZMD_CMP_JIAOTONGYUNSHU
prompt =======================================
prompt
CREATE OR REPLACE FORCE VIEW VW_ZMD_CMP_JIAOTONGYUNSHU AS
SELECT key,
       company_id,
       company_nm,
       rpt_date,
       modelscore,
       qnmodelscore,
       qlmodelscore,
       qlmodelscoreorig,

       structure1_val,
       operation12_val,
       leverage6_val,
       size2_val,

       structure1_score,
       operation12_score,
       leverage6_score,
       size2_score,

       factor_001_val,
       factor_077_val,
       factor_583_val,
       factor_006_val,
       factor_078_val,

       factor_001_score,
       factor_077_score,
       factor_583_score,
       factor_006_score,
       factor_078_score

  FROM (

       WITH factor_score_val AS (SELECT *
                                   FROM (SELECT t.rating_record_id,
                                                rmf.ft_code,
                                                t.score,
                                                CASE
                                                  WHEN f.factor_type = '规模' THEN
                                                   exp(t.factor_val)
                                                  ELSE
                                                   t.factor_val
                                                END AS factor_val
                                           FROM rating_factor t
                                           JOIN rating_model_factor rmf
                                             ON t.rm_factor_id = rmf.id
                                           JOIN factor f
                                             ON rmf.ft_code = f.factor_cd) mid
                                 pivot(MAX(factor_val) AS val, MAX(score) AS score
                                    FOR ft_code IN('Structure1' AS structure1,
                                                  'Operation12' AS operation12,
                                                  'Leverage6' AS leverage6,
                                                  'Size2' AS size2,
                                                  'factor_001' AS factor_001,
                                                  'factor_077' AS factor_077,
                                                  'factor_583' AS factor_583,
                                                  'factor_006' AS factor_006,
                                                  'factor_078' AS factor_078))), model_score AS (SELECT rating_record_id,
                                                                                                         qn_score,
                                                                                                         qn_orig_score,
                                                                                                         qi_score,
                                                                                                         qi_orig_score
                                                                                                    FROM (SELECT t.rating_record_id,
                                                                                                                 NAME,
                                                                                                                 score,
                                                                                                                 new_score
                                                                                                            FROM rating_detail t
                                                                                                            JOIN rating_model_sub_model rms
                                                                                                              ON t.rating_model_sub_model_id =
                                                                                                                 rms.id) mid
                                                                                                  pivot(MAX(score) AS orig_score, MAX(new_score) AS score
                                                                                                     FOR NAME IN('财务分析' AS qn,
                                                                                                                '非财务分析' AS qi)))
         SELECT cbf.company_nm AS key,
                r.company_id,
                cbf.company_nm,
                r.factor_dt    AS rpt_date,
                --r.rating_record_id,
                r.total_score             AS modelscore,
                model_score.qn_score      AS qnmodelscore,
                model_score.qi_score      AS qlmodelscore,
                model_score.qi_orig_score AS qlmodelscoreorig,

                structure1_val,
                operation12_val,
                leverage6_val,
                size2_val,

                structure1_score,
                operation12_score,
                leverage6_score,
                size2_score,

                factor_001_val,
                factor_077_val,
                factor_583_val,
                factor_006_val,
                factor_078_val,

                factor_001_score,
                factor_077_score,
                factor_583_score,
                factor_006_score,
                factor_078_score,

                row_number() over(PARTITION BY cbf.company_id ORDER BY r.updt_dt DESC) AS rn
           FROM rating_record r
           JOIN compy_basicinfo cbf
             ON r.company_id = cbf.company_id
            AND cbf.is_del = 0
         --AND cbf.company_nm = '中国石油天然气股份有限公司'
           JOIN compy_exposure ce
             ON cbf.company_id = ce.company_id
            AND ce.is_new = 1
            AND ce.isdel = 0
           JOIN exposure e
             ON ce.exposure_sid = e.exposure_sid
            AND e.isdel = 0
            AND e.exposure = '交通运输'
           JOIN factor_score_val
             ON r.rating_record_id = factor_score_val.rating_record_id
           JOIN model_score
             ON r.rating_record_id = model_score.rating_record_id)
          WHERE rn = 1
;

prompt
prompt Creating view VW_ZMD_CMP_JINRONGTONGYONG
prompt ========================================
prompt
CREATE OR REPLACE FORCE VIEW VW_ZMD_CMP_JINRONGTONGYONG AS
SELECT key,
       company_id,
       company_nm,
       rpt_date,
       modelscore,

       factor_125_val,
       factor_118_val,
       factor_119_val,
       factor_108_val,
       factor_005_val,
       factor_120_val,
       factor_121_val,
       factor_113_val,
       factor_123_val,
       factor_114_val,
       factor_124_val,
       factor_122_val,
       factor_125_score,
       factor_118_score,
       factor_119_score,
       factor_108_score,
       factor_005_score,
       factor_120_score,
       factor_121_score,
       factor_113_score,
       factor_123_score,
       factor_114_score,
       factor_124_score,
       factor_122_score

  FROM (

       WITH factor_score_val AS (SELECT *
                                   FROM (SELECT t.rating_record_id,
                                                rmf.ft_code,
                                                t.score,
                                                CASE
                                                  WHEN f.factor_type = '规模' THEN
                                                   exp(t.factor_val)
                                                  ELSE
                                                   t.factor_val
                                                END AS factor_val
                                           FROM rating_factor t
                                           JOIN rating_model_factor rmf
                                             ON t.rm_factor_id = rmf.id
                                           JOIN factor f
                                             ON rmf.ft_code = f.factor_cd) mid
                                 pivot(MAX(factor_val) AS val, MAX(score) AS score
                                    FOR ft_code IN('factor_125' AS factor_125,
                                                  'factor_118' AS factor_118,
                                                  'factor_119' AS factor_119,
                                                  'factor_108' AS factor_108,
                                                  'factor_005' AS factor_005,
                                                  'factor_120' AS factor_120,
                                                  'factor_121' AS factor_121,
                                                  'factor_113' AS factor_113,
                                                  'factor_123' AS factor_123,
                                                  'factor_114' AS factor_114,
                                                  'factor_124' AS factor_124,
                                                  'factor_122' AS factor_122

                                                  ))), model_score AS (SELECT rating_record_id,
                                                                              qn_score,
                                                                              qn_orig_score,
                                                                              ql_score,
                                                                              ql_orig_score
                                                                         FROM (SELECT t.rating_record_id,
                                                                                      NAME,
                                                                                      score,
                                                                                      new_score
                                                                                 FROM rating_detail t
                                                                                 JOIN rating_model_sub_model rms
                                                                                   ON t.rating_model_sub_model_id =
                                                                                      rms.id) mid
                                                                       pivot(MAX(score) AS orig_score, MAX(new_score) AS score
                                                                          FOR NAME IN('财务分析' AS qn,
                                                                                     '非财务分析' AS ql)))
         SELECT cbf.company_nm AS key,
                r.company_id,
                cbf.company_nm,
                r.factor_dt    AS rpt_date,
                --r.rating_record_id,
                r.total_score             AS modelscore,
                model_score.qn_score      AS qnmodelscore,
                model_score.ql_score      AS qlmodelscore,
                model_score.ql_orig_score AS qlmodelscoreorig,

                factor_125_val,
                factor_118_val,
                factor_119_val,
                factor_108_val,
                factor_005_val,
                factor_120_val,
                factor_121_val,
                factor_113_val,
                factor_123_val,
                factor_114_val,
                factor_124_val,
                factor_122_val,
                factor_125_score,
                factor_118_score,
                factor_119_score,
                factor_108_score,
                factor_005_score,
                factor_120_score,
                factor_121_score,
                factor_113_score,
                factor_123_score,
                factor_114_score,
                factor_124_score,
                factor_122_score,

                row_number() over(PARTITION BY cbf.company_id ORDER BY r.updt_dt DESC) AS rn
           FROM rating_record r
           JOIN compy_basicinfo cbf
             ON r.company_id = cbf.company_id
            AND cbf.is_del = 0
         --AND cbf.company_nm = '中国石油天然气股份有限公司'
           JOIN compy_exposure ce
             ON cbf.company_id = ce.company_id
            AND ce.is_new = 1
            AND ce.isdel = 0
           JOIN exposure e
             ON ce.exposure_sid = e.exposure_sid
            AND e.isdel = 0
            AND e.exposure = '金融通用'
           JOIN factor_score_val
             ON r.rating_record_id = factor_score_val.rating_record_id
           JOIN model_score
             ON r.rating_record_id = model_score.rating_record_id)
          WHERE rn = 1
;

prompt
prompt Creating view VW_ZMD_CMP_PIFALINGSHOU
prompt =====================================
prompt
CREATE OR REPLACE FORCE VIEW VW_ZMD_CMP_PIFALINGSHOU AS
SELECT key,
       company_id,
       company_nm,
       rpt_date,
       modelscore,
       qnmodelscore,
       qlmodelscore,
       qlmodelscoreorig,
       profitability3_val,
       structure2_val,
       leverage5_val,
       operation6_val,
       size1_val,

       profitability3_score,
       structure2_score,
       leverage5_score,
       operation6_score,
       size1_score,

       factor_001_val,
       factor_071_val,
       factor_089_val,
       factor_009_val,
       factor_008_val,
       factor_001_score,
       factor_071_score,
       factor_089_score,
       factor_009_score,
       factor_008_score

  FROM (

       WITH factor_score_val AS (SELECT *
                                   FROM (SELECT t.rating_record_id,
                                                rmf.ft_code,
                                                t.score,
                                                CASE
                                                  WHEN f.factor_type = '规模' THEN
                                                   exp(t.factor_val)
                                                  ELSE
                                                   t.factor_val
                                                END AS factor_val
                                           FROM rating_factor t
                                           JOIN rating_model_factor rmf
                                             ON t.rm_factor_id = rmf.id
                                           JOIN factor f
                                             ON rmf.ft_code = f.factor_cd) mid
                                 pivot(MAX(factor_val) AS val, MAX(score) AS score
                                    FOR ft_code IN('Profitability3' AS
                                                  profitability3,
                                                  'Structure2' AS structure2,
                                                  'Leverage5' AS leverage5,
                                                  'Operation6' AS operation6,
                                                  'Size1' AS size1,
                                                  'factor_001' AS factor_001,
                                                  'factor_071' AS factor_071,
                                                  'factor_089' AS factor_089,
                                                  'factor_009' AS factor_009,
                                                  'factor_008' AS factor_008

                                                  ))), model_score AS (SELECT rating_record_id,
                                                                              qn_score,
                                                                              qn_orig_score,
                                                                              qi_score,
                                                                              qi_orig_score
                                                                         FROM (SELECT t.rating_record_id,
                                                                                      NAME,
                                                                                      score,
                                                                                      new_score
                                                                                 FROM rating_detail t
                                                                                 JOIN rating_model_sub_model rms
                                                                                   ON t.rating_model_sub_model_id =
                                                                                      rms.id) mid
                                                                       pivot(MAX(score) AS orig_score, MAX(new_score) AS score
                                                                          FOR NAME IN('财务分析' AS qn,
                                                                                     '非财务分析' AS qi)))
         SELECT cbf.company_nm AS key,
                r.company_id,
                cbf.company_nm,
                r.factor_dt    AS rpt_date,
                --r.rating_record_id,
                r.total_score             AS modelscore,
                model_score.qn_score      AS qnmodelscore,
                model_score.qi_score      AS qlmodelscore,
                model_score.qi_orig_score AS qlmodelscoreorig,

                profitability3_val,
                structure2_val,
                leverage5_val,
                operation6_val,
                size1_val,

                profitability3_score,
                structure2_score,
                leverage5_score,
                operation6_score,
                size1_score,

                factor_001_val,
                factor_071_val,
                factor_089_val,
                factor_009_val,
                factor_008_val,
                factor_001_score,
                factor_071_score,
                factor_089_score,
                factor_009_score,
                factor_008_score,

                row_number() over(PARTITION BY cbf.company_id ORDER BY r.updt_dt DESC) AS rn
           FROM rating_record r
           JOIN compy_basicinfo cbf
             ON r.company_id = cbf.company_id
            AND cbf.is_del = 0
         --AND cbf.company_nm = '中国石油天然气股份有限公司'
           JOIN compy_exposure ce
             ON cbf.company_id = ce.company_id
            AND ce.is_new = 1
            AND ce.isdel = 0
           JOIN exposure e
             ON ce.exposure_sid = e.exposure_sid
            AND e.isdel = 0
            AND e.exposure = '批发零售'
           JOIN factor_score_val
             ON r.rating_record_id = factor_score_val.rating_record_id
           JOIN model_score
             ON r.rating_record_id = model_score.rating_record_id)
          WHERE rn = 1
;

prompt
prompt Creating view VW_ZMD_CMP_RONGZIPINGTAI
prompt ======================================
prompt
CREATE OR REPLACE FORCE VIEW VW_ZMD_CMP_RONGZIPINGTAI AS
SELECT key,
       company_id,
       company_nm,
       rpt_date,
       modelscore,

       factor_514_val,
       zs_factor_14_val,
       factor_522_val,
       factor_520_val,
       factor_528_val,
       factor_181_val,
       zs_factor_22_val,
       zs_factor_34_val,
       zs_factor_08_val,
       factor_183_val,
       factor_514_score,
       zs_factor_14_score,
       factor_522_score,
       factor_520_score,
       factor_528_score,
       factor_181_score,
       zs_factor_22_score,
       zs_factor_34_score,
       zs_factor_08_score,
       factor_183_score

  FROM (

       WITH factor_score_val AS (SELECT *
                                   FROM (SELECT t.rating_record_id,
                                                rmf.ft_code,
                                                t.score,
                                                CASE
                                                  WHEN f.factor_type = '规模' THEN
                                                   exp(t.factor_val)
                                                  ELSE
                                                   t.factor_val
                                                END AS factor_val
                                           FROM rating_factor t
                                           JOIN rating_model_factor rmf
                                             ON t.rm_factor_id = rmf.id
                                           JOIN factor f
                                             ON rmf.ft_code = f.factor_cd) mid
                                 pivot(MAX(factor_val) AS val, MAX(score) AS score
                                    FOR ft_code IN('factor_514' AS factor_514,
                                                  'zs_factor_14' AS zs_factor_14,
                                                  'factor_522' AS factor_522,
                                                  'factor_520' AS factor_520,
                                                  'factor_528' AS factor_528,
                                                  'factor_181' AS factor_181,
                                                  'zs_factor_22' AS zs_factor_22,
                                                  'zs_factor_34' AS zs_factor_34,
                                                  'zs_factor_08' AS zs_factor_08,
                                                  'factor_183' AS factor_183))), model_score AS (SELECT rating_record_id,
                                                                                                        qn_score,
                                                                                                        qn_orig_score,
                                                                                                        qi_score,
                                                                                                        qi_orig_score
                                                                                                   FROM (SELECT t.rating_record_id,
                                                                                                                NAME,
                                                                                                                score,
                                                                                                                new_score
                                                                                                           FROM rating_detail t
                                                                                                           JOIN rating_model_sub_model rms
                                                                                                             ON t.rating_model_sub_model_id =
                                                                                                                rms.id) mid
                                                                                                 pivot(MAX(score) AS orig_score, MAX(new_score) AS score
                                                                                                    FOR NAME IN('财务分析' AS qn,
                                                                                                               '非财务分析' AS qi)))
         SELECT cbf.company_nm AS key,
                r.company_id,
                cbf.company_nm,
                r.factor_dt    AS rpt_date,
                --r.rating_record_id,
                r.total_score             AS modelscore,
                model_score.qn_score      AS qnmodelscore,
                model_score.qi_score      AS qlmodelscore,
                model_score.qi_orig_score AS qlmodelscoreorig,

                factor_514_val,
                zs_factor_14_val,
                factor_522_val,
                factor_520_val,
                factor_528_val,
                factor_181_val,
                zs_factor_22_val,
                zs_factor_34_val,
                zs_factor_08_val,
                factor_183_val,
                factor_514_score,
                zs_factor_14_score,
                factor_522_score,
                factor_520_score,
                factor_528_score,
                factor_181_score,
                zs_factor_22_score,
                zs_factor_34_score,
                zs_factor_08_score,
                factor_183_score,

                row_number() over(PARTITION BY cbf.company_id ORDER BY r.updt_dt DESC) AS rn
           FROM rating_record r
           JOIN compy_basicinfo cbf
             ON r.company_id = cbf.company_id
            AND cbf.is_del = 0
         --AND cbf.company_nm = '中国石油天然气股份有限公司'
           JOIN compy_exposure ce
             ON cbf.company_id = ce.company_id
            AND ce.is_new = 1
            AND ce.isdel = 0
           JOIN exposure e
             ON ce.exposure_sid = e.exposure_sid
            AND e.isdel = 0
            AND e.exposure = '融资平台'
           JOIN factor_score_val
             ON r.rating_record_id = factor_score_val.rating_record_id
           JOIN model_score
             ON r.rating_record_id = model_score.rating_record_id)
          WHERE rn = 1
;

prompt
prompt Creating view VW_ZMD_CMP_RONGZIXINGDB
prompt =====================================
prompt
CREATE OR REPLACE FORCE VIEW VW_ZMD_CMP_RONGZIXINGDB AS
SELECT key,
       company_id,
       company_nm,
       rpt_date,
       modelscore,

       factor_001_val,
       factor_135_val,
       factor_004_val,
       factor_096_val,
       factor_095_val,
       factor_136_val,
       factor_094_val,
       factor_098_val,
       factor_099_val,
       factor_100_val,
       factor_102_val,
       factor_103_val,

       factor_001_score,
       factor_135_score,
       factor_004_score,
       factor_096_score,
       factor_095_score,
       factor_136_score,
       factor_094_score,
       factor_098_score,
       factor_099_score,
       factor_100_score,
       factor_102_score,
       factor_103_score

  FROM (

       WITH factor_score_val AS (SELECT *
                                   FROM (SELECT t.rating_record_id,
                                                rmf.ft_code,
                                                t.score,
                                                CASE
                                                  WHEN f.factor_type = '规模'
                                                  AND lower(f.factor_cd) LIKE '%size%'
                                                  AND f.factor_property_cd = 0
                                                   THEN
                                                   exp(t.factor_val)
                                                  ELSE
                                                   t.factor_val
                                                END AS factor_val
                                           FROM rating_factor t
                                           JOIN rating_model_factor rmf
                                             ON t.rm_factor_id = rmf.id
                                           JOIN factor f
                                             ON rmf.ft_code = f.factor_cd) mid
                                 pivot(MAX(factor_val) AS val, MAX(score) AS score
                                    FOR ft_code IN('factor_001' AS factor_001,
                                                  'factor_135' AS factor_135,
                                                  'factor_004' AS factor_004,
                                                  'factor_096' AS factor_096,
                                                  'factor_095' AS factor_095,
                                                  'factor_136' AS factor_136,
                                                  'factor_094' AS factor_094,
                                                  'factor_098' AS factor_098,
                                                  'factor_099' AS factor_099,
                                                  'factor_100' AS factor_100,
                                                  'factor_102' AS factor_102,
                                                  'factor_103' AS factor_103

                                                  ))), model_score AS (SELECT rating_record_id,
                                                                              qn_score,
                                                                              qn_orig_score,
                                                                              qi_score,
                                                                              qi_orig_score
                                                                         FROM (SELECT t.rating_record_id,
                                                                                      NAME,
                                                                                      score,
                                                                                      new_score
                                                                                 FROM rating_detail t
                                                                                 JOIN rating_model_sub_model rms
                                                                                   ON t.rating_model_sub_model_id =
                                                                                      rms.id) mid
                                                                       pivot(MAX(score) AS orig_score, MAX(new_score) AS score
                                                                          FOR NAME IN('财务分析' AS qn,
                                                                                     '非财务分析' AS qi)))
         SELECT cbf.company_nm AS key,
                r.company_id,
                cbf.company_nm,
                r.factor_dt    AS rpt_date,
                --r.rating_record_id,
                r.total_score             AS modelscore,
                model_score.qn_score      AS qnmodelscore,
                model_score.qi_score      AS qlmodelscore,
                model_score.qi_orig_score AS qlmodelscoreorig,

                factor_001_val,
                factor_135_val,
                factor_004_val,
                factor_096_val,
                factor_095_val,
                factor_136_val,
                factor_094_val,
                factor_098_val,
                factor_099_val,
                factor_100_val,
                factor_102_val,
                factor_103_val,

                factor_001_score,
                factor_135_score,
                factor_004_score,
                factor_096_score,
                factor_095_score,
                factor_136_score,
                factor_094_score,
                factor_098_score,
                factor_099_score,
                factor_100_score,
                factor_102_score,
                factor_103_score,

                row_number() over(PARTITION BY cbf.company_id ORDER BY r.updt_dt DESC) AS rn
           FROM rating_record r
           JOIN compy_basicinfo cbf
             ON r.company_id = cbf.company_id
            AND cbf.is_del = 0
         --AND cbf.company_nm = '中国石油天然气股份有限公司'
           JOIN compy_exposure ce
             ON cbf.company_id = ce.company_id
            AND ce.is_new = 1
            AND ce.isdel = 0
           JOIN exposure e
             ON ce.exposure_sid = e.exposure_sid
            AND e.isdel = 0
            AND e.exposure = '融资性担保'
           JOIN factor_score_val
             ON r.rating_record_id = factor_score_val.rating_record_id
           JOIN model_score
             ON r.rating_record_id = model_score.rating_record_id)
          WHERE rn = 1
;

prompt
prompt Creating view VW_ZMD_CMP_SHOUXIQIYE
prompt ===================================
prompt
CREATE OR REPLACE FORCE VIEW VW_ZMD_CMP_SHOUXIQIYE AS
SELECT key,
       company_id,
       company_nm,
       rpt_date,
       modelscore,

       factor_125_val,
       factor_106_val,
       factor_107_val,
       factor_108_val,
       factor_126_val,
       factor_109_val,
       factor_110_val,
       factor_005_val,
       factor_111_val,
       factor_112_val,
       factor_113_val,
       factor_114_val,
       factor_094_val,
       factor_116_val,
       factor_117_val,
       factor_115_val,
       factor_125_score,
       factor_106_score,
       factor_107_score,
       factor_108_score,
       factor_126_score,
       factor_109_score,
       factor_110_score,
       factor_005_score,
       factor_111_score,
       factor_112_score,
       factor_113_score,
       factor_114_score,
       factor_094_score,
       factor_116_score,
       factor_117_score,
       factor_115_score

  FROM (

       WITH factor_score_val AS (SELECT *
                                   FROM (SELECT t.rating_record_id,
                                                rmf.ft_code,
                                                t.score,
                                                CASE
                                                  WHEN f.factor_type = '规模'
                                                    AND lower(f.factor_cd) LIKE '%size%'
                                                    AND f.factor_property_cd=0
                                                    THEN
                                                   exp(t.factor_val)
                                                  ELSE
                                                   t.factor_val
                                                END AS factor_val
                                           FROM rating_factor t
                                           JOIN rating_model_factor rmf
                                             ON t.rm_factor_id = rmf.id
                                           JOIN factor f
                                             ON rmf.ft_code = f.factor_cd) mid
                                 pivot(MAX(factor_val) AS val, MAX(score) AS score
                                    FOR ft_code IN('factor_125' AS factor_125,
                                                  'factor_106' AS factor_106,
                                                  'factor_107' AS factor_107,
                                                  'factor_108' AS factor_108,
                                                  'factor_126' AS factor_126,
                                                  'factor_109' AS factor_109,
                                                  'factor_110' AS factor_110,
                                                  'factor_005' AS factor_005,
                                                  'factor_111' AS factor_111,
                                                  'factor_112' AS factor_112,
                                                  'factor_113' AS factor_113,
                                                  'factor_114' AS factor_114,
                                                  'factor_094' AS factor_094,
                                                  'factor_116' AS factor_116,
                                                  'factor_117' AS factor_117,
                                                  'factor_115' AS factor_115))), model_score AS (SELECT rating_record_id,
                                                                                                        qn_score,
                                                                                                        qn_orig_score,
                                                                                                        qi_score,
                                                                                                        qi_orig_score
                                                                                                   FROM (SELECT t.rating_record_id,
                                                                                                                NAME,
                                                                                                                score,
                                                                                                                new_score
                                                                                                           FROM rating_detail t
                                                                                                           JOIN rating_model_sub_model rms
                                                                                                             ON t.rating_model_sub_model_id =
                                                                                                                rms.id) mid
                                                                                                 pivot(MAX(score) AS orig_score, MAX(new_score) AS score
                                                                                                    FOR NAME IN('财务分析' AS qn,
                                                                                                               '非财务分析' AS qi)))
         SELECT cbf.company_nm AS key,
                r.company_id,
                cbf.company_nm,
                r.factor_dt    AS rpt_date,
                --r.rating_record_id,
                r.total_score             AS modelscore,
                model_score.qn_score      AS qnmodelscore,
                model_score.qi_score      AS qlmodelscore,
                model_score.qi_orig_score AS qlmodelscoreorig,

                factor_125_val,
                factor_106_val,
                factor_107_val,
                factor_108_val,
                factor_126_val,
                factor_109_val,
                factor_110_val,
                factor_005_val,
                factor_111_val,
                factor_112_val,
                factor_113_val,
                factor_114_val,
                factor_094_val,
                factor_116_val,
                factor_117_val,
                factor_115_val,
                factor_125_score,
                factor_106_score,
                factor_107_score,
                factor_108_score,
                factor_126_score,
                factor_109_score,
                factor_110_score,
                factor_005_score,
                factor_111_score,
                factor_112_score,
                factor_113_score,
                factor_114_score,
                factor_094_score,
                factor_116_score,
                factor_117_score,
                factor_115_score,

                row_number() over(PARTITION BY cbf.company_id ORDER BY r.updt_dt DESC) AS rn
           FROM rating_record r
           JOIN compy_basicinfo cbf
             ON r.company_id = cbf.company_id
            AND cbf.is_del = 0
         --AND cbf.company_nm = '中国石油天然气股份有限公司'
           JOIN compy_exposure ce
             ON cbf.company_id = ce.company_id
            AND ce.is_new = 1
            AND ce.isdel = 0
           JOIN exposure e
             ON ce.exposure_sid = e.exposure_sid
            AND e.isdel = 0
            AND e.exposure = '收息企业'
           JOIN factor_score_val
             ON r.rating_record_id = factor_score_val.rating_record_id
           JOIN model_score
             ON r.rating_record_id = model_score.rating_record_id)
          WHERE rn = 1
;

prompt
prompt Creating view VW_ZMD_CMP_XIAOFEIPINZZ
prompt =====================================
prompt
CREATE OR REPLACE FORCE VIEW VW_ZMD_CMP_XIAOFEIPINZZ AS
SELECT key,
       company_id,
       company_nm,
       rpt_date,
       modelscore,
       qnmodelscore,
       qlmodelscore,
       qlmodelscoreorig,

       profitability6_val,
       structure2_val,
       leverage3_val,
       leverage18_val,
       operation1_val,
       size1_val,

       profitability6_score,
       structure2_score,
       leverage3_score,
       leverage18_score,
       operation1_score,
       size1_score,

       factor_001_val,
       factor_071_val,
       factor_012_val,
       factor_004_val,

       factor_001_score,
       factor_071_score,
       factor_012_score,
       factor_004_score

  FROM (

       WITH factor_score_val AS
        (SELECT *
           FROM (SELECT t.rating_record_id,
                        rmf.ft_code,
                        t.score,
                        CASE
                          WHEN f.factor_type = '规模' THEN
                           exp(t.factor_val)
                          ELSE
                           t.factor_val
                        END AS factor_val
                   FROM rating_factor t
                   JOIN rating_model_factor rmf
                     ON t.rm_factor_id = rmf.id
                   JOIN factor f
                     ON rmf.ft_code = f.factor_cd) mid
         pivot(MAX(factor_val) AS val, MAX(score) AS score
            FOR ft_code IN('Profitability6' AS profitability6,
                          'Structure2' AS structure2,
                          'Leverage3' AS leverage3,
                          'Leverage18' AS leverage18,
                          'Operation1' AS operation1,
                          'Size1' AS size1,
                          'factor_001' AS factor_001,
                          'factor_071' AS factor_071,
                          'factor_012' AS factor_012,
                          'factor_004' AS factor_004

                          ))),
       model_score AS
        (SELECT rating_record_id,
                qn_score,
                qn_orig_score,
                qi_score,
                qi_orig_score
           FROM (SELECT t.rating_record_id, NAME, score, new_score
                   FROM rating_detail t
                   JOIN rating_model_sub_model rms
                     ON t.rating_model_sub_model_id = rms.id) mid
         pivot(MAX(score) AS orig_score, MAX(new_score) AS score
            FOR NAME IN('财务分析' AS qn, '非财务分析' AS qi)))
       SELECT cbf.company_nm AS key,
              r.company_id,
              cbf.company_nm,
              r.factor_dt    AS rpt_date,
              --r.rating_record_id,
              r.total_score             AS modelscore,
              model_score.qn_score      AS qnmodelscore,
              model_score.qi_score      AS qlmodelscore,
              model_score.qi_orig_score AS qlmodelscoreorig,

              profitability6_val,
              structure2_val,
              leverage3_val,
              leverage18_val,
              operation1_val,
              size1_val,

              profitability6_score,
              structure2_score,
              leverage3_score,
              leverage18_score,
              operation1_score,
              size1_score,

              factor_001_val,
              factor_071_val,
              factor_012_val,
              factor_004_val,

              factor_001_score,
              factor_071_score,
              factor_012_score,
              factor_004_score,

              row_number() over(PARTITION BY cbf.company_id ORDER BY r.updt_dt DESC) AS rn
         FROM rating_record r
         JOIN compy_basicinfo cbf
           ON r.company_id = cbf.company_id
          AND cbf.is_del = 0
       --AND cbf.company_nm = '中国石油天然气股份有限公司'
         JOIN compy_exposure ce
           ON cbf.company_id = ce.company_id
          AND ce.is_new = 1
          AND ce.isdel = 0
         JOIN exposure e
           ON ce.exposure_sid = e.exposure_sid
          AND e.isdel = 0
          AND e.exposure = '消费品制造'
         JOIN factor_score_val
           ON r.rating_record_id = factor_score_val.rating_record_id
         JOIN model_score
           ON r.rating_record_id = model_score.rating_record_id)
          WHERE rn = 1
;

prompt
prompt Creating view VW_ZMD_CMP_YIBANGONGSHANGTY
prompt =========================================
prompt
CREATE OR REPLACE FORCE VIEW VW_ZMD_CMP_YIBANGONGSHANGTY AS
SELECT key,
       company_id,
       company_nm,
       rpt_date,
       modelscore,

       factor_001_val,
       factor_071_val,
       factor_011_val,
       factor_002_val,
       factor_012_val,
       factor_003_val,
       factor_008_val,
       factor_506_val,
       profitability3_val,
       structure2_val,
       leverage07_val,
       leverage09_val,

       leverage18_val,
       operation1_val,
       factor_001_score,
       factor_071_score,
       factor_011_score,
       factor_002_score,
       factor_012_score,
       factor_003_score,
       factor_008_score,
       factor_506_score,
       profitability3_score,
       structure2_score,
       leverage07_score,
       leverage09_score,

       leverage18_score,
       operation1_score

  FROM (

       WITH factor_score_val AS (SELECT *
                                   FROM (SELECT t.rating_record_id,
                                                rmf.ft_code,
                                                t.score,
                                                CASE
                                                  WHEN f.factor_type = '规模' THEN
                                                   exp(t.factor_val)
                                                  ELSE
                                                   t.factor_val
                                                END AS factor_val
                                           FROM rating_factor t
                                           JOIN rating_model_factor rmf
                                             ON t.rm_factor_id = rmf.id
                                           JOIN factor f
                                             ON rmf.ft_code = f.factor_cd) mid
                                 pivot(MAX(factor_val) AS val, MAX(score) AS score
                                    FOR ft_code IN('factor_001' AS factor_001,
                                                  'factor_071' AS factor_071,
                                                  'factor_011' AS factor_011,
                                                  'factor_002' AS factor_002,
                                                  'factor_012' AS factor_012,
                                                  'factor_003' AS factor_003,
                                                  'factor_008' AS factor_008,
                                                  'factor_506' AS factor_506,
                                                  'Profitability3' AS
                                                  profitability3,
                                                  'Structure2' AS structure2,
                                                  'Leverage07' AS leverage07,
                                                  'Leverage09' AS leverage09,
                                                  'Leverage18' AS leverage18,
                                                  'Operation1' AS operation1))), model_score AS (SELECT rating_record_id,
                                                                                                        qn_score,
                                                                                                        qn_orig_score,
                                                                                                        qi_score,
                                                                                                        qi_orig_score
                                                                                                   FROM (SELECT t.rating_record_id,
                                                                                                                NAME,
                                                                                                                score,
                                                                                                                new_score
                                                                                                           FROM rating_detail t
                                                                                                           JOIN rating_model_sub_model rms
                                                                                                             ON t.rating_model_sub_model_id =
                                                                                                                rms.id) mid
                                                                                                 pivot(MAX(score) AS orig_score, MAX(new_score) AS score
                                                                                                    FOR NAME IN('财务分析' AS qn,
                                                                                                               '非财务分析' AS qi)))
         SELECT cbf.company_nm AS key,
                r.company_id,
                cbf.company_nm,
                r.factor_dt    AS rpt_date,
                --r.rating_record_id,
                r.total_score             AS modelscore,
                model_score.qn_score      AS qnmodelscore,
                model_score.qi_score      AS qlmodelscore,
                model_score.qi_orig_score AS qlmodelscoreorig,

                factor_001_val,
                factor_071_val,
                factor_011_val,
                factor_002_val,
                factor_012_val,
                factor_003_val,
                factor_008_val,
                factor_506_val,
                profitability3_val,
                structure2_val,
                leverage07_val,
                leverage09_val,

                leverage18_val,
                operation1_val,
                factor_001_score,
                factor_071_score,
                factor_011_score,
                factor_002_score,
                factor_012_score,
                factor_003_score,
                factor_008_score,
                factor_506_score,
                profitability3_score,
                structure2_score,
                leverage07_score,
                leverage09_score,

                leverage18_score,
                operation1_score,

                row_number() over(PARTITION BY cbf.company_id ORDER BY r.updt_dt DESC) AS rn
           FROM rating_record r
           JOIN compy_basicinfo cbf
             ON r.company_id = cbf.company_id
            AND cbf.is_del = 0
         --AND cbf.company_nm = '中国石油天然气股份有限公司'
           JOIN compy_exposure ce
             ON cbf.company_id = ce.company_id
            AND ce.is_new = 1
            AND ce.isdel = 0
           JOIN exposure e
             ON ce.exposure_sid = e.exposure_sid
            AND e.isdel = 0
            AND e.exposure = '一般工商通用'
           JOIN factor_score_val
             ON r.rating_record_id = factor_score_val.rating_record_id
           JOIN model_score
             ON r.rating_record_id = model_score.rating_record_id)
          WHERE rn = 1
;

prompt
prompt Creating view VW_ZMD_CMP_YINHANG
prompt ================================
prompt
CREATE OR REPLACE FORCE VIEW VW_ZMD_CMP_YINHANG AS
SELECT key,
       company_id,
       company_nm,
       rpt_date,
       modelscore,
       qnmodelscore,
       qlmodelscore,
       qlmodelscoreorig,

       zs_bank_leverage3_val,
       zs_bank_liquidity4_val,
       zs_bank_profitability2_val,
       zs_bank_profitability4_val,
       zs_bank_profitability8_val,
       zs_bank_size1_val,

       zs_bank_leverage3_score,
       zs_bank_liquidity4_score,
       zs_bank_profitability2_score,
       zs_bank_profitability4_score,
       zs_bank_profitability8_score,
       zs_bank_size1_score,

       factor_001_val,
       factor_614_val,
       factor_619_val,
       factor_623_val,
       factor_426_val,
       factor_634_val,
       factor_112_val,
       factor_450_val,
       factor_617_val,
       factor_001_score,
       factor_614_score,
       factor_619_score,
       factor_623_score,
       factor_426_score,
       factor_634_score,
       factor_112_score,
       factor_450_score,
       factor_617_score

  FROM (

       WITH factor_score_val AS
        (SELECT *
           FROM (SELECT t.rating_record_id,
                        rmf.ft_code,
                        t.score,
                        CASE
                          WHEN f.factor_type = '规模' THEN
                           exp(t.factor_val)
                          ELSE
                           t.factor_val
                        END AS factor_val
                   FROM rating_factor t
                   JOIN rating_model_factor rmf
                     ON t.rm_factor_id = rmf.id
                   JOIN factor f
                     ON rmf.ft_code = f.factor_cd) mid
         pivot(MAX(factor_val) AS val, MAX(score) AS score
            FOR ft_code IN('zs_Bank_Leverage3' AS zs_bank_leverage3,
                          'zs_Bank_Liquidity4' AS zs_bank_liquidity4,
                          'zs_Bank_Profitability2' AS zs_bank_profitability2,
                          'zs_Bank_Profitability4' AS zs_bank_profitability4,
                          'zs_Bank_Profitability8' AS zs_bank_profitability8,
                          'zs_Bank_Size1' AS zs_bank_size1,
                          'factor_001' AS factor_001,
                          'factor_614' AS factor_614,
                          'factor_619' AS factor_619,
                          'factor_623' AS factor_623,
                          'factor_426' AS factor_426,
                          'factor_634' AS factor_634,
                          'factor_112' AS factor_112,
                          'factor_450' AS factor_450,
                          'factor_617' AS factor_617))),
       model_score AS
        (SELECT rating_record_id,
                qn_score,
                qn_orig_score,
                qi_score,
                qi_orig_score
           FROM (SELECT t.rating_record_id, NAME, score, new_score
                   FROM rating_detail t
                   JOIN rating_model_sub_model rms
                     ON t.rating_model_sub_model_id = rms.id) mid
         pivot(MAX(score) AS orig_score, MAX(new_score) AS score
            FOR NAME IN('财务分析' AS qn, '非财务分析' AS qi)))
       SELECT cbf.company_nm            AS key,
              r.company_id,
              cbf.company_nm,
              r.factor_dt               AS rpt_date,
              r.total_score             AS modelscore,
              model_score.qn_score      AS qnmodelscore,
              model_score.qi_score      AS qlmodelscore,
              model_score.qi_orig_score AS qlmodelscoreorig,

              zs_bank_leverage3_val,
              zs_bank_liquidity4_val,
              zs_bank_profitability2_val,
              zs_bank_profitability4_val,
              zs_bank_profitability8_val,
              zs_bank_size1_val,

              zs_bank_leverage3_score,
              zs_bank_liquidity4_score,
              zs_bank_profitability2_score,
              zs_bank_profitability4_score,
              zs_bank_profitability8_score,
              zs_bank_size1_score,

              factor_001_val,
              factor_614_val,
              factor_619_val,
              factor_623_val,
              factor_426_val,
              factor_634_val,
              factor_112_val,
              factor_450_val,
              factor_617_val,
              factor_001_score,
              factor_614_score,
              factor_619_score,
              factor_623_score,
              factor_426_score,
              factor_634_score,
              factor_112_score,
              factor_450_score,
              factor_617_score,

              row_number() over(PARTITION BY cbf.company_id ORDER BY r.updt_dt DESC) AS rn
         FROM rating_record r
         JOIN compy_basicinfo cbf
           ON r.company_id = cbf.company_id
          AND cbf.is_del = 0
         JOIN compy_exposure ce
           ON cbf.company_id = ce.company_id
          AND ce.is_new = 1
          AND ce.isdel = 0
         JOIN exposure e
           ON ce.exposure_sid = e.exposure_sid
          AND e.isdel = 0
          AND e.exposure = '银行'
         JOIN factor_score_val
           ON r.rating_record_id = factor_score_val.rating_record_id
         JOIN model_score
           ON r.rating_record_id = model_score.rating_record_id)
        WHERE rn = 1;

prompt
prompt Creating view VW_ZMD_CMP_YIYAOZHIZAO
prompt ====================================
prompt
CREATE OR REPLACE FORCE VIEW VW_ZMD_CMP_YIYAOZHIZAO AS
SELECT key,
       company_id,
       company_nm,
       rpt_date,
       modelscore,
       qnmodelscore,
       qlmodelscore,
       qlmodelscoreorig,

       profitability3_val,
       structure2_val,
       leverage18_val,
       operation13_val,
       size2_val,
       size10_val,

       profitability3_score,
       structure2_score,
       leverage18_score,
       operation13_score,
       size2_score,
       size10_score,

       factor_001_val,
       factor_071_val,
       factor_091_val,
       factor_011_val,

       factor_001_score,
       factor_071_score,
       factor_091_score,
       factor_011_score

  FROM (

       WITH factor_score_val AS
        (SELECT *
           FROM (SELECT t.rating_record_id,
                        rmf.ft_code,
                        t.score,
                        CASE
                          WHEN f.factor_type = '规模' THEN
                           exp(t.factor_val)
                          ELSE
                           t.factor_val
                        END AS factor_val
                   FROM rating_factor t
                   JOIN rating_model_factor rmf
                     ON t.rm_factor_id = rmf.id
                   JOIN factor f
                     ON rmf.ft_code = f.factor_cd) mid
         pivot(MAX(factor_val) AS val, MAX(score) AS score
            FOR ft_code IN('Profitability3' AS profitability3,
                          'Structure2' AS structure2,
                          'Leverage18' AS leverage18,
                          'Operation13' AS operation13,
                          'Size2' AS size2,
                          'Size10' AS size10,
                          'factor_001' AS factor_001,
                          'factor_071' AS factor_071,
                          'factor_091' AS factor_091,
                          'factor_011' AS factor_011

                          ))),
       model_score AS
        (SELECT rating_record_id,
                qn_score,
                qn_orig_score,
                qi_score,
                qi_orig_score
           FROM (SELECT t.rating_record_id, NAME, score, new_score
                   FROM rating_detail t
                   JOIN rating_model_sub_model rms
                     ON t.rating_model_sub_model_id = rms.id) mid
         pivot(MAX(score) AS orig_score, MAX(new_score) AS score
            FOR NAME IN('财务分析' AS qn, '非财务分析' AS qi)))
       SELECT cbf.company_nm AS key,
              r.company_id,
              cbf.company_nm,
              r.factor_dt    AS rpt_date,
              --r.rating_record_id,
              r.total_score             AS modelscore,
              model_score.qn_score      AS qnmodelscore,
              model_score.qi_score      AS qlmodelscore,
              model_score.qi_orig_score AS qlmodelscoreorig,

              profitability3_val,
              structure2_val,
              leverage18_val,
              operation13_val,
              size2_val,
              size10_val,

              profitability3_score,
              structure2_score,
              leverage18_score,
              operation13_score,
              size2_score,
              size10_score,

              factor_001_val,
              factor_071_val,
              factor_091_val,
              factor_011_val,

              factor_001_score,
              factor_071_score,
              factor_091_score,
              factor_011_score,

              row_number() over(PARTITION BY cbf.company_id ORDER BY r.updt_dt DESC) AS rn
         FROM rating_record r
         JOIN compy_basicinfo cbf
           ON r.company_id = cbf.company_id
          AND cbf.is_del = 0
       --AND cbf.company_nm = '中国石油天然气股份有限公司'
         JOIN compy_exposure ce
           ON cbf.company_id = ce.company_id
          AND ce.is_new = 1
          AND ce.isdel = 0
         JOIN exposure e
           ON ce.exposure_sid = e.exposure_sid
          AND e.isdel = 0
          AND e.exposure = '医药制造'
         JOIN factor_score_val
           ON r.rating_record_id = factor_score_val.rating_record_id
         JOIN model_score
           ON r.rating_record_id = model_score.rating_record_id
          )
          --WHERE rn = 1
;

prompt
prompt Creating view VW_ZMD_CMP_YUANCAILIAOZZ
prompt ======================================
prompt
CREATE OR REPLACE FORCE VIEW VW_ZMD_CMP_YUANCAILIAOZZ AS
SELECT key,
       company_id,
       company_nm,
       rpt_date,
       modelscore,
       qnmodelscore,
       qlmodelscore,
       qlmodelscoreorig,

       profitability6_val,
       structure2_val,
       leverage07_val,
       leverage18_val,
       operation5_val,
       size2_val,
       profitability6_score,
       structure2_score,
       leverage07_score,
       leverage18_score,
       operation5_score,
       size2_score,
       factor_071_val,
       factor_074_val,
       factor_067_val,
       factor_012_val,
       factor_582_val,
       factor_001_val,
       factor_008_val,

       factor_071_score,
       factor_074_score,
       factor_067_score,
       factor_012_score,
       factor_582_score,
       factor_001_score,
       factor_008_score

  FROM (

       WITH factor_score_val AS (SELECT *
                                   FROM (SELECT t.rating_record_id,
                                                rmf.ft_code,
                                                t.score,
                                                CASE
                                                  WHEN f.factor_type = '规模' THEN
                                                   exp(t.factor_val)
                                                  ELSE
                                                   t.factor_val
                                                END AS factor_val
                                           FROM rating_factor t
                                           JOIN rating_model_factor rmf
                                             ON t.rm_factor_id = rmf.id
                                           JOIN factor f
                                             ON rmf.ft_code = f.factor_cd) mid
                                 pivot(MAX(factor_val) AS val, MAX(score) AS score
                                    FOR ft_code IN('Profitability6' AS
                                                  profitability6,
                                                  'Structure2' AS structure2,
                                                  'Leverage07' AS leverage07,
                                                  'Leverage18' AS leverage18,
                                                  'Operation5' AS operation5,
                                                  'Size2' AS size2,
                                                  'factor_071' AS factor_071,
                                                  'factor_074' AS factor_074,
                                                  'factor_067' AS factor_067,
                                                  'factor_012' AS factor_012,
                                                  'factor_582' AS factor_582,
                                                  'factor_001' AS factor_001,
                                                  'factor_008' AS factor_008))), model_score AS (SELECT rating_record_id,
                                                                                                        qn_score,
                                                                                                        qn_orig_score,
                                                                                                        qi_score,
                                                                                                        qi_orig_score
                                                                                                   FROM (SELECT t.rating_record_id,
                                                                                                                NAME,
                                                                                                                score,
                                                                                                                new_score
                                                                                                           FROM rating_detail t
                                                                                                           JOIN rating_model_sub_model rms
                                                                                                             ON t.rating_model_sub_model_id =
                                                                                                                rms.id) mid
                                                                                                 pivot(MAX(score) AS orig_score, MAX(new_score) AS score
                                                                                                    FOR NAME IN('财务分析' AS qn,
                                                                                                               '非财务分析' AS qi)))
         SELECT cbf.company_nm AS key,
                r.company_id,
                cbf.company_nm,
                r.factor_dt    AS rpt_date,
                --r.rating_record_id,
                r.total_score             AS modelscore,
                model_score.qn_score      AS qnmodelscore,
                model_score.qi_score      AS qlmodelscore,
                model_score.qi_orig_score AS qlmodelscoreorig,

                profitability6_val,
                structure2_val,
                leverage07_val,
                leverage18_val,
                operation5_val,
                size2_val,
                profitability6_score,
                structure2_score,
                leverage07_score,
                leverage18_score,
                operation5_score,
                size2_score,
                factor_071_val,
                factor_074_val,
                factor_067_val,
                factor_012_val,
                factor_582_val,
                factor_001_val,
                factor_008_val,

                factor_071_score,
                factor_074_score,
                factor_067_score,
                factor_012_score,
                factor_582_score,
                factor_001_score,
                factor_008_score,

                row_number() over(PARTITION BY cbf.company_id ORDER BY r.updt_dt DESC) AS rn
           FROM rating_record r
           JOIN compy_basicinfo cbf
             ON r.company_id = cbf.company_id
            AND cbf.is_del = 0
         --AND cbf.company_nm = '中国石油天然气股份有限公司'
           JOIN compy_exposure ce
             ON cbf.company_id = ce.company_id
            AND ce.is_new = 1
            AND ce.isdel = 0
           JOIN exposure e
             ON ce.exposure_sid = e.exposure_sid
            AND e.isdel = 0
            AND e.exposure = '原材料制造'
           JOIN factor_score_val
             ON r.rating_record_id = factor_score_val.rating_record_id
           JOIN model_score
             ON r.rating_record_id = model_score.rating_record_id)
          WHERE rn = 1
;

prompt
prompt Creating view VW_ZMD_CMP_ZHENGQUANGONGSI
prompt ========================================
prompt
CREATE OR REPLACE FORCE VIEW VW_ZMD_CMP_ZHENGQUANGONGSI AS
SELECT key,
       company_id,
       company_nm,
       rpt_date,
       modelscore,
       qnmodelscore,
       qlmodelscore,
       qlmodelscoreorig,

       secu_growth7_val,
       secu_leverage3_val,
       secu_profitability8_val,
       secu_regulatory03_val,
       secu_size010_val,

       secu_growth7_score,
       secu_leverage3_score,
       secu_profitability8_score,
       secu_regulatory03_score,
       secu_size010_score,

       factor_039_val,
       factor_044_val,
       factor_047_val,
       factor_050_val,
       factor_054_val,
       factor_056_val,
       factor_004_val,

       factor_039_score,
       factor_044_score,
       factor_047_score,
       factor_050_score,
       factor_054_score,
       factor_056_score,
       factor_004_score

  FROM (

       WITH factor_score_val AS
        (SELECT *
           FROM (SELECT t.rating_record_id,
                        rmf.ft_code,
                        t.score,
                        CASE
                          WHEN f.factor_type = '规模' THEN
                           exp(t.factor_val)
                          ELSE
                           t.factor_val
                        END AS factor_val
                   FROM rating_factor t
                   JOIN rating_model_factor rmf
                     ON t.rm_factor_id = rmf.id
                   JOIN factor f
                     ON rmf.ft_code = f.factor_cd) mid
         pivot(MAX(factor_val) AS val, MAX(score) AS score
            FOR ft_code IN('Secu_Growth7' AS secu_growth7,
                          'Secu_Leverage3' AS secu_leverage3,
                          'Secu_Profitability8' AS secu_profitability8,
                          'Secu_Regulatory03' AS secu_regulatory03,
                          'Secu_Size010' AS secu_size010,
                          'factor_039' AS factor_039,
                          'factor_044' AS factor_044,
                          'factor_047' AS factor_047,
                          'factor_050' AS factor_050,
                          'factor_054' AS factor_054,
                          'factor_056' AS factor_056,
                          'factor_004' AS factor_004))),
       model_score AS
        (SELECT rating_record_id,
                qn_score,
                qn_orig_score,
                qi_score,
                qi_orig_score
           FROM (SELECT t.rating_record_id, NAME, score, new_score
                   FROM rating_detail t
                   JOIN rating_model_sub_model rms
                     ON t.rating_model_sub_model_id = rms.id) mid
         pivot(MAX(score) AS orig_score, MAX(new_score) AS score
            FOR NAME IN('财务分析' AS qn, '非财务分析' AS qi)))
       SELECT cbf.company_nm            AS key,
              r.company_id,
              cbf.company_nm,
              r.factor_dt               AS rpt_date,
              r.total_score             AS modelscore,
              model_score.qn_score      AS qnmodelscore,
              model_score.qi_score      AS qlmodelscore,
              model_score.qi_orig_score AS qlmodelscoreorig,

              secu_growth7_val,
              secu_leverage3_val,
              secu_profitability8_val,
              secu_regulatory03_val,
              secu_size010_val,
              factor_039_val,
              factor_044_val,
              factor_047_val,
              factor_050_val,
              factor_054_val,
              factor_056_val,
              factor_004_val,
              secu_growth7_score,
              secu_leverage3_score,
              secu_profitability8_score,
              secu_regulatory03_score,
              secu_size010_score,
              factor_039_score,
              factor_044_score,
              factor_047_score,
              factor_050_score,
              factor_054_score,
              factor_056_score,
              factor_004_score,

              row_number() over(PARTITION BY cbf.company_id ORDER BY r.updt_dt DESC) AS rn
         FROM rating_record r
         JOIN compy_basicinfo cbf
           ON r.company_id = cbf.company_id
          AND cbf.is_del = 0
         JOIN compy_exposure ce
           ON cbf.company_id = ce.company_id
          AND ce.is_new = 1
          AND ce.isdel = 0
         JOIN exposure e
           ON ce.exposure_sid = e.exposure_sid
          AND e.isdel = 0
          AND e.exposure = '证券公司'
         JOIN factor_score_val
           ON r.rating_record_id = factor_score_val.rating_record_id
         JOIN model_score
           ON r.rating_record_id = model_score.rating_record_id)
        WHERE rn = 1;


prompt Done
spool off
set define on
