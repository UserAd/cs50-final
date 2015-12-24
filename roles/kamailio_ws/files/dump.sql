CREATE TABLE IF NOT EXISTS `sip_capture` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `micro_ts` bigint(18) NOT NULL DEFAULT '0',
  `method` varchar(50) NOT NULL DEFAULT '',
  `reply_reason` varchar(100) NOT NULL,
  `ruri` varchar(200) NOT NULL DEFAULT '',
  `ruri_user` varchar(100) NOT NULL DEFAULT '',
  `from_user` varchar(100) NOT NULL DEFAULT '',
  `from_tag` varchar(64) NOT NULL DEFAULT '',
  `to_user` varchar(100) NOT NULL DEFAULT '',
  `to_tag` varchar(64) NOT NULL,
  `pid_user` varchar(100) NOT NULL DEFAULT '',
  `contact_user` varchar(120) NOT NULL,
  `auth_user` varchar(120) NOT NULL,
  `callid` varchar(100) NOT NULL DEFAULT '',
  `callid_aleg` varchar(100) NOT NULL DEFAULT '',
  `via_1` varchar(256) NOT NULL,
  `via_1_branch` varchar(80) NOT NULL,
  `cseq` varchar(25) NOT NULL,
  `diversion` varchar(256) NOT NULL,
  `reason` varchar(200) NOT NULL,
  `content_type` varchar(256) NOT NULL,
  `auth` varchar(256) NOT NULL,
  `user_agent` varchar(256) NOT NULL,
  `source_ip` varchar(60) NOT NULL DEFAULT '',
  `source_port` int(10) NOT NULL,
  `destination_ip` varchar(60) NOT NULL DEFAULT '',
  `destination_port` int(10) NOT NULL,
  `contact_ip` varchar(60) NOT NULL,
  `contact_port` int(10) NOT NULL,
  `originator_ip` varchar(60) NOT NULL DEFAULT '',
  `originator_port` int(10) NOT NULL,
  `proto` int(5) NOT NULL,
  `family` int(1) DEFAULT NULL,
  `rtp_stat` varchar(256) NOT NULL,
  `type` int(2) NOT NULL,
  `node` varchar(125) NOT NULL,
  `msg` varchar(1500) NOT NULL,
  `ruri_domain` varchar(150) NOT NULL DEFAULT '',
  `from_domain` varchar(150) NOT NULL DEFAULT '',
  `to_domain` varchar(150) NOT NULL DEFAULT '',
  `correlation_id` varchar(256) NOT NULL,
  PRIMARY KEY (`id`,`callid`),
  KEY `callid_aleg` (`callid_aleg`),
  KEY `callid` (`callid`),
  KEY `correlation_id` (`correlation_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `rtcp_capture` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `micro_ts` bigint(18) NOT NULL DEFAULT '0',
  `correlation_id` varchar(256) NOT NULL DEFAULT '',
  `source_ip` varchar(60) NOT NULL DEFAULT '',
  `source_port` int(10) NOT NULL DEFAULT 0,
  `destination_ip` varchar(60) NOT NULL DEFAULT '',
  `destination_port` int(10) NOT NULL DEFAULT 0,
  `proto` int(5) NOT NULL DEFAULT 0,
  `family` int(1) DEFAULT NULL,
  `type` int(2) NOT NULL DEFAULT 0,
  `node` varchar(125) NOT NULL DEFAULT '',
  `msg` varchar(1500) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`,`date`),
  KEY `date` (`date`),
  KEY `correlationid` (`correlation_id`(255))
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

DELIMITER //

CREATE TABLE IF NOT EXISTS `sip_capture_0` LIKE sip_capture;
CREATE TABLE IF NOT EXISTS `sip_capture_1` LIKE sip_capture;
CREATE TABLE IF NOT EXISTS `sip_capture_2` LIKE sip_capture;


CREATE EVENT IF NOT EXISTS rotate_sip_capture_table
ON SCHEDULE
  EVERY 1 WEEK
  STARTS CURRENT_DATE + INTERVAL 6 - WEEKDAY(CURRENT_DATE) DAY
    DO BEGIN
      CREATE TABLE sip_capture_new1 LIKE sip_capture_0;
      CREATE TABLE sip_capture_new2 LIKE sip_capture_1;
      CREATE TABLE sip_capture_new3 LIKE sip_capture_2;

      RENAME TABLE sip_capture_0 TO sip_capture_old1, sip_capture_new1 TO sip_capture_0;
      RENAME TABLE sip_capture_1 TO sip_capture_old2, sip_capture_new2 TO sip_capture_1;
      RENAME TABLE sip_capture_2 TO sip_capture_old3, sip_capture_new3 TO sip_capture_2;


      DROP TABLE sip_capture_old1;
      DROP TABLE sip_capture_old2;
      DROP TABLE sip_capture_old3;

    END//
DELIMITER ;


