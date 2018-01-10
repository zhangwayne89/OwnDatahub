CREATE OR REPLACE VIEW VW_RPT_REVIEW_POOL_RISK AS
WITH tmp_bond_pool AS
 (SELECT po1.item_id AS secinner_id, po1.bond_pool_id
    FROM bond_pool_item po1, bond_pool po2
   WHERE po1.bond_pool_id = po2.bond_pool_id
     AND po2.group_type = 1
     AND po1.isdel = 0
     AND po2.isdel = 0),
tmp_bond_party AS
 (SELECT secinner_id, notice_dt, party_nm
    FROM (SELECT secinner_id,
                 notice_dt,
                 party_nm,
                 row_number() over(PARTITION BY secinner_id ORDER BY notice_dt DESC) AS rn
            FROM bond_party
          )
   WHERE rn = 1),
tmp_creditrating_cmb AS
 (SELECT company_id, final_rating
    FROM (SELECT company_id,
                 final_rating,
                 row_number() over(PARTITION BY company_id ORDER BY effect_end_dt DESC, rating_no DESC) AS rn
            FROM compy_creditrating_cmb
           WHERE isdel = 0
             --AND rating_start_dt <= ${v_date}
             --AND effect_end_dt >= SYSDATE
           )
   WHERE rn = 1),
tmp_creditrating AS
 (SELECT company_id, rating
    FROM (SELECT company_id,
                 rating,
                 row_number() over(PARTITION BY company_id ORDER BY rating_dt DESC, notice_dt DESC, compy_creditrating_sid DESC) AS rn
            FROM compy_creditrating
          )
   WHERE rn = 1),
tmp_bond_creditchg AS
 (SELECT secinner_id, rating
    FROM (SELECT secinner_id,
                 rating,
                 row_number() over(PARTITION BY secinner_id ORDER BY change_dt DESC, notice_dt DESC, bond_creditchg_sid DESC) AS rn
            FROM bond_creditchg)
   WHERE rn = 1),
tmp_exposure AS
 (SELECT company_id, exposure_sid
    FROM (SELECT company_id,
                 exposure_sid,
                 row_number() over(PARTITION BY company_id ORDER BY end_dt DESC) AS rn
            FROM compy_exposure
           WHERE isdel = 0
             --AND start_dt <= ${v_date}
             --AND end_dt >= ${v_date}
           )
   WHERE rn = 1),
tmp_industry AS --zjh_sub_class
 (SELECT cid.company_id, ity.parent_ind_sid, ity.name
    FROM compy_industry cid, industry ity
   WHERE to_char(cid.industry_sid) = ity.id
     AND ity.system_cd = 1008
     AND ity.industry_level = 2
     AND cid.isdel = 0
     --AND cid.start_dt <= ${v_date}
     --AND cid.end_dt >= ${v_date}
     ),
tmp_warnlevelchg AS
 (SELECT company_id, warn_level
    FROM (SELECT company_id,
                 warn_level,
                 row_number() over(PARTITION BY company_id ORDER BY submit_dt DESC, warnchg_id DESC) AS rn
            FROM compy_warnlevelchg_cmb
           WHERE isdel = 0)
   WHERE rn = 1),
tmp_region AS
 (SELECT rgn.company_id, rgn.region_cd, kp4.region_nm
    FROM compy_region rgn, lkp_region kp4
   WHERE rgn.region_cd = kp4.region_cd
     AND rgn.isdel = 0),
tmp_groupwarning AS
 (SELECT company_id, risk_status_cd
    FROM (SELECT company_id,
                 risk_status_cd,
                 row_number() over(PARTITION BY company_id ORDER BY affirm_dt DESC, compy_groupwarning_sid DESC) AS rn
            FROM compy_groupwarning_cmb
           WHERE isdel = 0)
   WHERE rn = 1),
tmp_bond_warrantor AS
 (SELECT secinner_id,
         listagg(warrantor_nm, ',') within GROUP(ORDER BY warrantor_nm) AS warrantor_nm
    FROM bond_warrantor
   WHERE isdel = 0
     --AND start_dt <= ${v_date}
     --AND end_dt >= ${v_date}
   GROUP BY secinner_id),
tmp_constant AS
 (SELECT constant_cd, constant_nm, constant_type
    FROM lkp_constant
   WHERE isdel = 0
   GROUP BY constant_cd, constant_nm, constant_type),
tmp_charcode AS
 (SELECT constant_id, constant_nm, constant_type
    FROM lkp_charcode
   WHERE isdel = 0
   GROUP BY constant_id, constant_nm, constant_type)
SELECT basinfo.security_cd, --  债券代码
       vw_issuer.issuer_nm, --  发行人名称
       basinfo.security_snm, --  债券名称
       tmp_bond_party.party_nm, --  当事人名称
       basinfo.security_type_id, --  债券类型id
       kp1.constant_nm          AS security_type, --  债券类型
       --basinfo.issue_type_cd, --  募集方式cd
       kp2.constant_nm          AS issue_type, --募集方式
       basinfo.frst_value_dt, --  起息日期
       basinfo.last_value_dt, --  止息日期
       basinfo.bond_period, --  债券期限_年
       --tmp_creditrating_cmb.final_rating, --  终审评级cd
       kp3.constant_nm cmb_rating, --终审评级
       tmp_creditrating.rating AS company_rating, --主体外部评级
       tmp_bond_creditchg.rating AS bond_rating, --债券外部评级
       CASE
         WHEN bond_pool.group_type = 3 THEN
          REPLACE(bond_pool.pool_nm, '预警池')
         ELSE
          NULL
       END AS bond_warn_level, --债券预警级别
       CASE
         WHEN bond_pool.group_type = 4 THEN
          'Y'
         ELSE
          'N'
       END AS is_import_notice, --是否重点关注
       exposure.exposure, --  敞口名称
       industry.name AS zjh_class, --证监会（大类）
       tmp_industry.name AS zjh_sub_class, --证监会（细分）
       tmp_region.region_nm, --地区代码
       cmp_bas.org_form_id, --企业性质id
       kp6.constant_nm AS org_form, --企业性质
       custcmb.cust_no AS cno, --核心系统客户编号
       custcmb.group_nm, --所属集团
       --custcmb.class_grade_cd, --客户最低分类cd
       kp7.constant_nm AS class_grade, --客户最低分类
       --nvl(custcmb.risk_status_cd, tmp_warnlevelchg.warn_level) AS risk_status_cd1,
       kp8.constant_nm AS risk_status1, --单户预警
       --tmp_groupwarning.risk_status_cd AS risk_status_cd2, --集团预警
       kp9.constant_nm AS risk_status2, --集团预警
       CASE
         WHEN exposure.exposure = '融资平台' THEN
          'Y'
         ELSE
          'N'
       END AS is_chengtou, --是否城投企业
       tmp_bond_warrantor.warrantor_nm, --担保人名称
       custcmb.is_yjhplatform, --是否银监会平台
       CASE
         WHEN instr(basinfo.security_nm, '永续') >= 1 THEN
          'Y'
         ELSE
          'N'
       END AS is_yongxubond, --是否永续债
       CASE
         WHEN instr(basinfo.security_nm, '次级') >= 1 THEN
          'Y'
         ELSE
          'N'
       END AS is_cijibond --是否次级债
  FROM tmp_bond_pool
  LEFT JOIN vw_bond_issuer vw_issuer
    ON (tmp_bond_pool.secinner_id = vw_issuer.secinner_id)
  LEFT JOIN bond_basicinfo basinfo
    ON (vw_issuer.secinner_id = basinfo.secinner_id)
  LEFT JOIN tmp_bond_party
    ON (vw_issuer.secinner_id = tmp_bond_party.secinner_id)
  LEFT JOIN tmp_charcode kp1
    ON (basinfo.security_type_id = kp1.constant_id AND kp1.constant_type = 201)
  LEFT JOIN (SELECT DISTINCT constant_cd, constant_nm
               FROM lkp_numbcode
              WHERE constant_type = 205
                AND isdel = 0) kp2
    ON (basinfo.issue_type_cd = kp2.constant_cd)
  LEFT JOIN tmp_creditrating_cmb
    ON (vw_issuer.issuer_id = tmp_creditrating_cmb.company_id)
  LEFT JOIN tmp_constant kp3
    ON (to_char(tmp_creditrating_cmb.final_rating) = kp3.constant_cd AND
       kp3.constant_type = 28)
  LEFT JOIN tmp_creditrating
    ON (vw_issuer.issuer_id = tmp_creditrating.company_id)
  LEFT JOIN tmp_bond_creditchg
    ON (vw_issuer.secinner_id = tmp_bond_creditchg.secinner_id)
  LEFT JOIN bond_pool
    ON (tmp_bond_pool.bond_pool_id = bond_pool.bond_pool_id AND
       bond_pool.group_type IN (3, 4))
  LEFT JOIN tmp_exposure
    ON (vw_issuer.issuer_id = tmp_exposure.company_id)
  LEFT JOIN exposure
    ON (tmp_exposure.exposure_sid = exposure.exposure_sid AND
       exposure.isdel = 0)
  LEFT JOIN tmp_industry
    ON (vw_issuer.issuer_id = tmp_industry.company_id)
  LEFT JOIN industry
    ON (to_char(tmp_industry.parent_ind_sid) = industry.id AND
       industry.system_cd = 1008 AND industry.industry_level = 1)
  LEFT JOIN tmp_region
    ON (vw_issuer.issuer_id = tmp_region.company_id)
  LEFT JOIN compy_basicinfo cmp_bas
    ON (vw_issuer.issuer_id = cmp_bas.company_id AND cmp_bas.is_del = 0)
  LEFT JOIN tmp_charcode kp6
    ON (to_char(cmp_bas.org_form_id) = kp6.constant_id AND
       kp6.constant_type = 2)
  LEFT JOIN customer_cmb custcmb
    ON (vw_issuer.issuer_id = custcmb.company_id AND custcmb.isdel = 0)
  LEFT JOIN tmp_constant kp7
    ON (custcmb.class_grade_cd = kp7.constant_cd AND kp7.constant_type = 8)
  LEFT JOIN tmp_warnlevelchg
    ON (vw_issuer.issuer_id = tmp_warnlevelchg.company_id)
  LEFT JOIN tmp_constant kp8
    ON (nvl(custcmb.risk_status_cd, tmp_warnlevelchg.warn_level) =
       kp8.constant_cd AND kp8.constant_type = 7)
  LEFT JOIN tmp_groupwarning
    ON (vw_issuer.issuer_id = tmp_groupwarning.company_id)
  LEFT JOIN tmp_constant kp9
    ON (tmp_groupwarning.risk_status_cd = kp9.constant_cd AND
       kp9.constant_type = 7)
  LEFT JOIN tmp_bond_warrantor
    ON (vw_issuer.secinner_id = tmp_bond_warrantor.secinner_id)
;
