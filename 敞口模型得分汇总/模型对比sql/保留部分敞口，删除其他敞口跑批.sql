CREATE TABLE zhc_rid AS
SELECT rating_record_id,a.updt_dt
  FROM rating_record a
 WHERE a.exposure_sid IN (6379);--É¾³ý³¨¿Ú

CREATE TABLE zhc_tmp AS
SELECT bond_rating_record_sid, x.rating_record_id, x.updt_dt
  FROM bond_rating_xw x
 WHERE x.rating_record_id IN
       (SELECT rating_record_id
          FROM rating_record a
         WHERE a.exposure_sid IN (6379)); --±£Áô³¨¿Ú

DELETE FROM bond_rating_record
 WHERE bond_rating_record_sid IN
       (SELECT zc.bond_rating_record_sid FROM zhc_tmp zc);
DELETE FROM bond_rating_detail
 WHERE bond_rating_record_sid IN
       (SELECT zc.bond_rating_record_sid FROM zhc_tmp zc);
DELETE FROM bond_rating_factor
 WHERE bond_rating_record_sid IN
       (SELECT zc.bond_rating_record_sid FROM zhc_tmp zc);
DELETE FROM bond_rating_xw
 WHERE bond_rating_record_sid IN
       (SELECT zc.bond_rating_record_sid FROM zhc_tmp zc);
DELETE FROM bond_rating_approv
 WHERE bond_rating_record_sid IN
       (SELECT zc.bond_rating_record_sid FROM zhc_tmp zc);
DELETE FROM bond_rating_display
 WHERE bond_rating_record_id  IN
       (SELECT zc.bond_rating_record_sid FROM zhc_tmp zc);
       

DELETE FROM rating_detail
 WHERE rating_record_id IN (SELECT rating_record_id FROM zhc_rid);
DELETE FROM rating_display
 WHERE rating_record_id IN (SELECT rating_record_id FROM zhc_rid);
DELETE FROM rating_factor
 WHERE rating_record_id IN (SELECT rating_record_id FROM zhc_rid);
DELETE FROM rating_approv
 WHERE rating_record_id IN (SELECT rating_record_id FROM zhc_rid);
DELETE FROM rating_adjustment_reason
 WHERE rating_record_id IN (SELECT rating_record_id FROM zhc_rid);
DELETE FROM rating_record_log
 WHERE rating_record_id IN (SELECT rating_record_id FROM zhc_rid);
DELETE FROM rating_record
 WHERE rating_record_id IN (SELECT rating_record_id FROM zhc_rid);
