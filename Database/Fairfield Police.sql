-- phpMyAdmin SQL Dump
-- version 4.0.10.7
-- http://www.phpmyadmin.net
--
-- Host: localhost:3306
-- Generation Time: May 07, 2016 at 06:05 PM
-- Server version: 5.1.73-cll
-- PHP Version: 5.4.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;



-- --------------------------------------------------------

--
-- Table structure for table `tbl_applied_jobs`
--

CREATE TABLE IF NOT EXISTS `tbl_applied_jobs` (
  `apj_id` int(11) NOT NULL AUTO_INCREMENT,
  `job_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `applied_time` datetime NOT NULL,
  `status` varchar(2) NOT NULL DEFAULT '0',
  PRIMARY KEY (`apj_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `tbl_applied_jobs`
--

INSERT INTO `tbl_applied_jobs` (`apj_id`, `job_id`, `user_id`, `applied_time`, `status`) VALUES
(2, 1, 2, '2016-04-14 08:52:05', '-1'),
(3, 3, 2, '2016-04-16 20:05:10', '1'),
(4, 4, 3, '2016-04-26 23:10:58', '1');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_availabilities`
--

CREATE TABLE IF NOT EXISTS `tbl_availabilities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `from_date` date NOT NULL,
  `to_date` date NOT NULL,
  `availability` varchar(500) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_jobs`
--

CREATE TABLE IF NOT EXISTS `tbl_jobs` (
  `jobs_id` int(11) NOT NULL AUTO_INCREMENT,
  `job_id` varchar(100) NOT NULL,
  `title` varchar(200) NOT NULL,
  `date` varchar(50) NOT NULL,
  `place` varchar(150) NOT NULL,
  `address` varchar(250) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`jobs_id`),
  UNIQUE KEY `job_id` (`job_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `tbl_jobs`
--

INSERT INTO `tbl_jobs` (`jobs_id`, `job_id`, `title`, `date`, `place`, `address`, `is_active`) VALUES
(1, '123', 'title', '12/04/2016', 'gggg', 'dfsfsdf', 1),
(4, '123456', '123456', '28/04/2016', 'Milford', 'Milford Mall CT', 1),
(5, '10001', 'Security Head', '13/05/2016', 'Milford', 'Milford Green\r\nMilford\r\nConnecticut\r\nContact number:123-456-7890', 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_questions`
--

CREATE TABLE IF NOT EXISTS `tbl_questions` (
  `question_id` int(11) NOT NULL AUTO_INCREMENT,
  `question` varchar(200) NOT NULL,
  `answer` varchar(100) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`question_id`),
  UNIQUE KEY `question` (`question`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `tbl_questions`
--

INSERT INTO `tbl_questions` (`question_id`, `question`, `answer`, `is_active`) VALUES
(2, '2+2', '4', 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_users`
--

CREATE TABLE IF NOT EXISTS `tbl_users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `password` varchar(150) NOT NULL,
  `department` varchar(50) NOT NULL,
  `level` varchar(50) NOT NULL,	
  `address1` varchar(150) NOT NULL,
  `address2` varchar(150) NOT NULL,
  `city` varchar(150) NOT NULL,
  `state` varchar(150) NOT NULL,
  `zip` varchar(150) NOT NULL,
  `mobile` varchar(50) NOT NULL,
  `role` varchar(100) NOT NULL,
  `date_of_registration` varchar(50) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `tbl_users`
--

INSERT INTO `tbl_users` (`user_id`, `first_name`, `last_name`, `email`, `password`, `department`, `level`, `address1`, `address2`, `city`, `state`, `zip`, `mobile`, `role`, `date_of_registration`, `is_active`) VALUES
(1, 'Police', 'Department', 'admin@gmail.com', 'admin!2345', '0', '0', '', '', '', '', '', '', 'ADMIN', '0000-00-00 00:00:00', 1),
(2, 'khaja', 'shaik', 'khaja@gmail.com', 'khaja', 'dept 1', 'level1', '', '', '', '', '', '', 'USER', '2016-03-31 18:47:28', 1),
(3, 'lohith', 'chanda', 'chandalohith@gmail.com', 'admin@12345', '123456', 'level1', '', '', '', '', '', '', 'USER', '2016-04-26 22:57:35', 1),
(4, 'khaja', 'shaik', 'khajamohiddin.476@gmail.com', '123456', '123', 'level1', '', '', '', '', '', '', 'USER', '2016-05-07 17:20:20', 1),
(5, 'krishna', 'sai', 'krishna@gmail.com', '123', 'it', 'level2', '', '', '', '', '', '', 'USER', '2016-05-07 20:43:56', 1),
(6, 'sai', 'manohar', 'sai@gmail.com', '123456', 'sai', 'level1', '', '', '', '', '', '', 'USER', '2016-05-07 20:44:58', 1);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
