-- phpMyAdmin SQL Dump
-- version 3.3.2deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Aug 15, 2010 at 12:29 AM
-- Server version: 5.1.41
-- PHP Version: 5.3.2-1ubuntu4.2

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `ocwiki`
--

-- --------------------------------------------------------

--
-- Table structure for table `ocwAnswer`
--

CREATE TABLE IF NOT EXISTS `ocwAnswer` (
  `ans_id` int(11) NOT NULL AUTO_INCREMENT,
  `ans_question` int(11) NOT NULL,
  `ans_content` int(11) NOT NULL,
  `ans_correct` tinyint(1) NOT NULL,
  `ans_status` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT 'NORMAL',
  `ans_version` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ans_id`),
  KEY `ans_content` (`ans_content`),
  KEY `ans_question` (`ans_question`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `ocwAnswer`
--

INSERT INTO `ocwAnswer` (`ans_id`, `ans_question`, `ans_content`, `ans_correct`, `ans_status`, `ans_version`) VALUES
(1, 1, 2, 0, 'NORMAL', 0),
(2, 1, 3, 0, 'NORMAL', 0),
(3, 1, 4, 0, 'NORMAL', 0),
(4, 1, 5, 1, 'NORMAL', 0);

-- --------------------------------------------------------

--
-- Table structure for table `ocwArticleTopic`
--

CREATE TABLE IF NOT EXISTS `ocwArticleTopic` (
  `art_id` int(11) NOT NULL,
  `art_topic` int(11) NOT NULL,
  PRIMARY KEY (`art_id`,`art_topic`),
  KEY `art_topic` (`art_topic`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ocwArticleTopic`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocwChange`
--

CREATE TABLE IF NOT EXISTS `ocwChange` (
  `chg_id` int(11) NOT NULL AUTO_INCREMENT,
  `chg_user` int(11) NOT NULL,
  `chg_datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `chg_comment` varchar(140) COLLATE utf8_vietnamese1_ci NOT NULL,
  `chg_article` int(11) NOT NULL,
  `chg_delegate` mediumtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `chg_minor` tinyint(1) NOT NULL,
  PRIMARY KEY (`chg_id`),
  KEY `chg_user` (`chg_user`),
  KEY `chg_namespace` (`chg_article`),
  KEY `chg_article` (`chg_article`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_vietnamese1_ci AUTO_INCREMENT=1 ;

--
-- Dumping data for table `ocwChange`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocwConstraint`
--

CREATE TABLE IF NOT EXISTS `ocwConstraint` (
  `con_id` int(11) NOT NULL AUTO_INCREMENT,
  `con_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `con_section` int(11) NOT NULL,
  `lc_level` int(11) DEFAULT NULL,
  `con_count` int(11) NOT NULL,
  `con_version` int(11) NOT NULL DEFAULT '0',
  `con_status` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT 'NORMAL',
  PRIMARY KEY (`con_id`),
  KEY `con_section` (`con_section`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `ocwConstraint`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocwHistory`
--

CREATE TABLE IF NOT EXISTS `ocwHistory` (
  `hist_id` int(11) NOT NULL AUTO_INCREMENT,
  `hist_test` int(11) NOT NULL,
  `hist_user` int(11) NOT NULL,
  `hist_date` datetime NOT NULL,
  `hist_mark` decimal(10,4) NOT NULL,
  `hist_time` int(11) NOT NULL COMMENT 'Thời gian làm bài thực tế, tính bằng giây',
  PRIMARY KEY (`hist_id`),
  KEY `hist_user` (`hist_user`),
  KEY `hist_test` (`hist_test`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_vietnamese1_ci AUTO_INCREMENT=1 ;

--
-- Dumping data for table `ocwHistory`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocwQuestion`
--

CREATE TABLE IF NOT EXISTS `ocwQuestion` (
  `art_id` int(11) NOT NULL,
  `art_content` int(11) NOT NULL,
  `ques_level` int(11) NOT NULL,
  `art_author` int(11) NOT NULL,
  `art_create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `art_status` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT 'NORMAL',
  `art_last_change` int(11) DEFAULT NULL,
  `art_version` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`art_id`),
  KEY `art_author` (`art_author`),
  KEY `art_content` (`art_content`),
  KEY `art_last_change` (`art_last_change`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Các câu hỏi';

--
-- Dumping data for table `ocwQuestion`
--

INSERT INTO `ocwQuestion` (`art_id`, `art_content`, `ques_level`, `art_author`, `art_create_date`, `art_status`, `art_last_change`, `art_version`) VALUES
(1, 1, 3, 1, '2010-08-14 10:05:31', 'NORMAL', NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `ocwSection`
--

CREATE TABLE IF NOT EXISTS `ocwSection` (
  `sect_id` int(11) NOT NULL AUTO_INCREMENT,
  `sect_test` int(11) NOT NULL,
  `sect_text` varchar(10000) CHARACTER SET utf8 COLLATE utf8_vietnamese1_ci DEFAULT NULL,
  `sect_order` int(11) NOT NULL,
  `sect_status` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT 'NORMAL',
  `sect_version` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`sect_id`),
  KEY `tblSection_ibfk_1` (`sect_test`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `ocwSection`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocwSectionQuestion`
--

CREATE TABLE IF NOT EXISTS `ocwSectionQuestion` (
  `sq_id` int(11) NOT NULL AUTO_INCREMENT,
  `sq_section` int(11) NOT NULL,
  `sq_question` int(11) NOT NULL,
  `sq_mark` int(11) NOT NULL DEFAULT '1',
  `sq_status` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT 'NORMAL',
  `sq_version` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`sq_id`),
  UNIQUE KEY `uq_section_question` (`sq_section`,`sq_question`),
  KEY `sq_question` (`sq_question`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `ocwSectionQuestion`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocwSectionQuestionAnswer`
--

CREATE TABLE IF NOT EXISTS `ocwSectionQuestionAnswer` (
  `sq_id` int(11) NOT NULL,
  `ans_id` int(11) NOT NULL,
  PRIMARY KEY (`sq_id`,`ans_id`),
  KEY `ans_id` (`ans_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ocwSectionQuestionAnswer`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocwSectionStructure`
--

CREATE TABLE IF NOT EXISTS `ocwSectionStructure` (
  `sstr_id` int(11) NOT NULL AUTO_INCREMENT,
  `sstr_test` int(11) NOT NULL,
  `sstr_content` int(11) DEFAULT NULL,
  `sstr_order` int(11) NOT NULL,
  `sstr_version` int(11) NOT NULL DEFAULT '0',
  `sstr_status` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT 'NORMAL',
  PRIMARY KEY (`sstr_id`),
  KEY `sstr_test` (`sstr_test`),
  KEY `sstr_content` (`sstr_content`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_vietnamese1_ci AUTO_INCREMENT=1 ;

--
-- Dumping data for table `ocwSectionStructure`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocwTest`
--

CREATE TABLE IF NOT EXISTS `ocwTest` (
  `art_id` int(11) NOT NULL,
  `test_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_vietnamese1_ci NOT NULL,
  `art_content` int(11) NOT NULL,
  `art_create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `art_author` int(11) NOT NULL,
  `test_type` char(5) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
  `test_time` int(11) NOT NULL COMMENT 'Thời gian làm bài, tính bằng phút',
  `art_status` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT 'NORMAL',
  `art_last_change` int(11) DEFAULT NULL,
  `art_version` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`art_id`),
  UNIQUE KEY `test_name` (`test_name`),
  KEY `user_id` (`art_author`),
  KEY `art_content` (`art_content`),
  KEY `art_last_change` (`art_last_change`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Đề thi';

--
-- Dumping data for table `ocwTest`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocwTestStructure`
--

CREATE TABLE IF NOT EXISTS `ocwTestStructure` (
  `art_id` int(11) NOT NULL,
  `tstr_name` varchar(200) COLLATE utf8_vietnamese1_ci NOT NULL,
  `art_content` int(11) NOT NULL,
  `art_author` int(11) NOT NULL,
  `art_create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `tstr_time` int(11) NOT NULL,
  `tstr_type` char(5) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
  `art_status` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT 'NORMAL',
  `art_version` int(11) NOT NULL DEFAULT '0',
  `art_last_change` int(11) DEFAULT NULL,
  PRIMARY KEY (`art_id`),
  UNIQUE KEY `tstr_name` (`tstr_name`),
  KEY `art_author` (`art_author`),
  KEY `art_content` (`art_content`),
  KEY `art_last_change` (`art_last_change`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_vietnamese1_ci;

--
-- Dumping data for table `ocwTestStructure`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocwText`
--

CREATE TABLE IF NOT EXISTS `ocwText` (
  `txt_id` int(11) NOT NULL AUTO_INCREMENT,
  `txt_text` mediumtext COLLATE utf8_vietnamese1_ci NOT NULL,
  PRIMARY KEY (`txt_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_vietnamese1_ci AUTO_INCREMENT=6 ;

--
-- Dumping data for table `ocwText`
--

INSERT INTO `ocwText` (`txt_id`, `txt_text`) VALUES
(1, 'jafla;dsfaf\r\na \r\n\r\nfas\r\nf'),
(2, 'lkjflkdsfafasdf'),
(3, 'lkjasfkljdsf'),
(4, 'kjhkjhlj;l'),
(5, 'kjhkjhlj;lkhhlk');

-- --------------------------------------------------------

--
-- Table structure for table `ocwTopic`
--

CREATE TABLE IF NOT EXISTS `ocwTopic` (
  `art_id` int(11) NOT NULL,
  `top_name` varchar(200) COLLATE utf8_vietnamese1_ci NOT NULL,
  `top_parent` int(11) DEFAULT NULL,
  `art_content` int(11) DEFAULT NULL,
  `art_author` int(11) NOT NULL,
  `art_create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `art_last_change` int(11) DEFAULT NULL,
  `art_status` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT 'NORMAL',
  `art_version` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`art_id`),
  UNIQUE KEY `top_name` (`top_name`),
  KEY `tblTopic_ibfk_1` (`top_parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_vietnamese1_ci COMMENT='Xếp các câu hỏi vào thể loại để dễ sinh đề tự động';

--
-- Dumping data for table `ocwTopic`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocwTopicConstraintTopic`
--

CREATE TABLE IF NOT EXISTS `ocwTopicConstraintTopic` (
  `con_id` int(11) NOT NULL,
  `art_id` int(11) NOT NULL,
  PRIMARY KEY (`con_id`,`art_id`),
  KEY `art_id` (`art_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ocwTopicConstraintTopic`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocwUser`
--

CREATE TABLE IF NOT EXISTS `ocwUser` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_vietnamese1_ci NOT NULL,
  `user_fullname` varchar(100) CHARACTER SET utf8 COLLATE utf8_vietnamese1_ci NOT NULL,
  `user_pass` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `user_email` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `user_group` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `user_avatar` varchar(50) CHARACTER SET ascii COLLATE ascii_bin DEFAULT NULL,
  `user_warning` varchar(200) CHARACTER SET utf8 COLLATE utf8_vietnamese1_ci DEFAULT NULL,
  `user_blocked` tinyint(1) NOT NULL DEFAULT '0',
  `user_register_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `name` (`user_name`),
  UNIQUE KEY `email` (`user_email`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `ocwUser`
--

INSERT INTO `ocwUser` (`user_id`, `user_name`, `user_fullname`, `user_pass`, `user_email`, `user_group`, `user_avatar`, `user_warning`, `user_blocked`, `user_register_date`) VALUES
(1, 'admin', 'abc', '1234', 'admin@ocwiki.org', 'teacher', NULL, NULL, 0, '2010-08-14 09:45:50');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `ocwAnswer`
--
ALTER TABLE `ocwAnswer`
  ADD CONSTRAINT `ocwAnswer_ibfk_1` FOREIGN KEY (`ans_content`) REFERENCES `ocwText` (`txt_id`),
  ADD CONSTRAINT `ocwAnswer_ibfk_2` FOREIGN KEY (`ans_question`) REFERENCES `ocwQuestion` (`art_id`);

--
-- Constraints for table `ocwArticleTopic`
--
ALTER TABLE `ocwArticleTopic`
  ADD CONSTRAINT `ocwArticleTopic_ibfk_1` FOREIGN KEY (`art_topic`) REFERENCES `ocwTopic` (`art_id`);

--
-- Constraints for table `ocwChange`
--
ALTER TABLE `ocwChange`
  ADD CONSTRAINT `ocwChange_ibfk_1` FOREIGN KEY (`chg_user`) REFERENCES `ocwUser` (`user_id`),
  ADD CONSTRAINT `ocwChange_ibfk_2` FOREIGN KEY (`chg_user`) REFERENCES `ocwUser` (`user_id`);

--
-- Constraints for table `ocwConstraint`
--
ALTER TABLE `ocwConstraint`
  ADD CONSTRAINT `ocwConstraint_ibfk_1` FOREIGN KEY (`con_section`) REFERENCES `ocwSectionStructure` (`sstr_id`);

--
-- Constraints for table `ocwHistory`
--
ALTER TABLE `ocwHistory`
  ADD CONSTRAINT `ocwHistory_ibfk_1` FOREIGN KEY (`hist_test`) REFERENCES `ocwTest` (`art_id`),
  ADD CONSTRAINT `ocwHistory_ibfk_2` FOREIGN KEY (`hist_user`) REFERENCES `ocwUser` (`user_id`);

--
-- Constraints for table `ocwQuestion`
--
ALTER TABLE `ocwQuestion`
  ADD CONSTRAINT `ocwQuestion_ibfk_1` FOREIGN KEY (`art_content`) REFERENCES `ocwText` (`txt_id`),
  ADD CONSTRAINT `ocwQuestion_ibfk_3` FOREIGN KEY (`art_author`) REFERENCES `ocwUser` (`user_id`),
  ADD CONSTRAINT `ocwQuestion_ibfk_4` FOREIGN KEY (`art_last_change`) REFERENCES `ocwChange` (`chg_id`);

--
-- Constraints for table `ocwSection`
--
ALTER TABLE `ocwSection`
  ADD CONSTRAINT `ocwSection_ibfk_2` FOREIGN KEY (`sect_test`) REFERENCES `ocwTest` (`art_id`) ON DELETE CASCADE;

--
-- Constraints for table `ocwSectionQuestion`
--
ALTER TABLE `ocwSectionQuestion`
  ADD CONSTRAINT `ocwSectionQuestion_ibfk_1` FOREIGN KEY (`sq_section`) REFERENCES `ocwSection` (`sect_id`),
  ADD CONSTRAINT `ocwSectionQuestion_ibfk_2` FOREIGN KEY (`sq_question`) REFERENCES `ocwQuestion` (`art_id`);

--
-- Constraints for table `ocwSectionQuestionAnswer`
--
ALTER TABLE `ocwSectionQuestionAnswer`
  ADD CONSTRAINT `ocwSectionQuestionAnswer_ibfk_1` FOREIGN KEY (`sq_id`) REFERENCES `ocwQuestion` (`art_id`),
  ADD CONSTRAINT `ocwSectionQuestionAnswer_ibfk_2` FOREIGN KEY (`ans_id`) REFERENCES `ocwAnswer` (`ans_id`);

--
-- Constraints for table `ocwSectionStructure`
--
ALTER TABLE `ocwSectionStructure`
  ADD CONSTRAINT `ocwSectionStructure_ibfk_1` FOREIGN KEY (`sstr_test`) REFERENCES `ocwTestStructure` (`art_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `ocwSectionStructure_ibfk_2` FOREIGN KEY (`sstr_test`) REFERENCES `ocwTestStructure` (`art_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `ocwSectionStructure_ibfk_3` FOREIGN KEY (`sstr_content`) REFERENCES `ocwText` (`txt_id`);

--
-- Constraints for table `ocwTest`
--
ALTER TABLE `ocwTest`
  ADD CONSTRAINT `ocwTest_ibfk_1` FOREIGN KEY (`art_author`) REFERENCES `ocwUser` (`user_id`),
  ADD CONSTRAINT `ocwTest_ibfk_5` FOREIGN KEY (`art_content`) REFERENCES `ocwText` (`txt_id`),
  ADD CONSTRAINT `ocwTest_ibfk_6` FOREIGN KEY (`art_last_change`) REFERENCES `ocwChange` (`chg_id`);

--
-- Constraints for table `ocwTestStructure`
--
ALTER TABLE `ocwTestStructure`
  ADD CONSTRAINT `ocwTestStructure_ibfk_1` FOREIGN KEY (`art_author`) REFERENCES `ocwUser` (`user_id`),
  ADD CONSTRAINT `ocwTestStructure_ibfk_5` FOREIGN KEY (`art_content`) REFERENCES `ocwText` (`txt_id`),
  ADD CONSTRAINT `ocwTestStructure_ibfk_6` FOREIGN KEY (`art_last_change`) REFERENCES `ocwChange` (`chg_id`);

--
-- Constraints for table `ocwTopic`
--
ALTER TABLE `ocwTopic`
  ADD CONSTRAINT `ocwTopic_ibfk_1` FOREIGN KEY (`top_parent`) REFERENCES `ocwTopic` (`art_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `ocwTopic_ibfk_2` FOREIGN KEY (`top_parent`) REFERENCES `ocwTopic` (`art_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ocwTopicConstraintTopic`
--
ALTER TABLE `ocwTopicConstraintTopic`
  ADD CONSTRAINT `ocwTopicConstraintTopic_ibfk_1` FOREIGN KEY (`con_id`) REFERENCES `ocwConstraint` (`con_id`),
  ADD CONSTRAINT `ocwTopicConstraintTopic_ibfk_2` FOREIGN KEY (`art_id`) REFERENCES `ocwTopic` (`art_id`);
