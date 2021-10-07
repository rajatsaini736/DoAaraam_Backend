-- Adminer 4.7.7 MySQL dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

DROP TABLE IF EXISTS `child_services`;
CREATE TABLE `child_services` (
  `id` varchar(250) NOT NULL,
  `parent_service_id` varchar(250) NOT NULL,
  `name` varchar(250) NOT NULL,
  `image` varchar(250) NOT NULL,
  `price` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `parent_service_id` (`parent_service_id`),
  CONSTRAINT `child_services_ibfk_2` FOREIGN KEY (`parent_service_id`) REFERENCES `parent_services` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `child_services` (`id`, `parent_service_id`, `name`, `image`, `price`) VALUES
('A00A0',	'A00',	'PLUMBER',	'plumber.svg',	2000),
('A00A1',	'A00',	'ELECTRICIAN',	'lightBulb.svg',	1000),
('A00A2',	'A00',	'CLEANING',	'washing.svg',	1000),
('A00A3',	'A00',	'MEDICAL',	'doctor.svg',	1000),
('B00B0',	'B00',	'MENS CARE',	'http://placekitten.com/300/300',	3000),
('B00B1',	'B00',	'WOMEN\'S CARE',	'http://placekitten.com/300/300',	3000),
('B00B2',	'B00',	'KIDS CARE',	'http://placekitten.com/300/300',	3000);

DROP TABLE IF EXISTS `complete_orders`;
CREATE TABLE `complete_orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` varchar(250) DEFAULT NULL,
  `vendor_confirm` enum('Yes','No') DEFAULT NULL,
  `user_confirm` enum('Yes','No') DEFAULT NULL,
  `final_vendor_price` int DEFAULT NULL,
  `duration` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `vendor_rating` int DEFAULT NULL,
  `user_rating` int DEFAULT NULL,
  `vendor_comment` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  CONSTRAINT `complete_orders_ibfk_2` FOREIGN KEY (`order_id`) REFERENCES `order_details` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `complete_orders` (`id`, `order_id`, `vendor_confirm`, `user_confirm`, `final_vendor_price`, `duration`, `vendor_rating`, `user_rating`, `vendor_comment`) VALUES
(73,	'0d672a0527662c22d407V000A00A0A196',	'Yes',	'Yes',	500,	'2021-01-14 05:35:41',	4,	4,	'Nice vendor'),
(74,	'0d672a0527662c22d407V000A00A0A297',	'Yes',	'Yes',	500,	'2021-01-14 05:39:37',	4,	4,	'Nice vendor'),
(75,	'0d672a0527662c22d407V000A00A0A398',	'Yes',	'Yes',	500,	'2021-01-14 05:39:40',	4,	4,	'Nice vendor'),
(76,	'0d672a0527662c22d407V000A00A0A297',	'Yes',	'Yes',	500,	'2021-01-14 05:39:43',	4,	4,	'Nice vendor'),
(77,	'0d672a0527662c22d407V000A00A0A398',	'Yes',	'Yes',	500,	'2021-01-14 05:39:46',	4,	4,	'Nice vendor'),
(78,	'0d672a0527662c22d407V000A00A0A297',	'Yes',	'Yes',	500,	'2021-01-14 05:39:49',	4,	4,	'Nice vendor'),
(79,	'0d672a0527662c22d407V000A00A0A398',	'Yes',	'Yes',	500,	'2021-01-14 05:39:52',	4,	4,	'Nice vendor'),
(80,	'0d672a0527662c22d407V000A00A0A297',	'Yes',	'Yes',	500,	'2021-01-14 05:39:55',	4,	4,	'Nice vendor'),
(81,	'0d672a0527662c22d407V000A00A0A398',	'Yes',	'Yes',	500,	'2021-01-14 05:39:58',	4,	4,	'Nice vendor'),
(82,	'0d672a0527662c22d407V000A00A0A398',	'Yes',	'Yes',	500,	'2021-01-14 05:40:00',	4,	4,	'Nice vendor'),
(83,	'0d672a0527662c22d407V000A00A0A398',	'Yes',	'Yes',	500,	'2021-01-14 05:40:00',	4,	4,	'Nice vendor'),
(84,	'0d672a0527662c22d407V000A00A0A398',	'Yes',	'Yes',	500,	'2021-01-14 05:40:01',	4,	4,	'Nice vendor'),
(85,	'0d672a0527662c22d407V000A00A0A398',	'Yes',	'Yes',	500,	'2021-01-14 05:40:03',	4,	4,	'Nice vendor'),
(86,	'0d672a0527662c22d407V000A00A0A297',	'Yes',	'Yes',	500,	'2021-01-14 08:18:35',	4,	4,	'Nice vendor'),
(87,	'0d672a0527662c22d407V000A00A0A297',	'Yes',	'Yes',	500,	'2021-01-14 08:18:35',	4,	4,	'Nice vendor'),
(88,	'0d672a0527662c22d407V000A00A0A398',	'Yes',	'Yes',	500,	'2021-01-14 08:18:35',	4,	4,	'Nice vendor'),
(89,	'0d672a0527662c22d407V000A00A0A398',	'Yes',	'Yes',	500,	'2021-01-14 08:18:35',	4,	4,	'Nice vendor'),
(90,	'0d672a0527662c22d407V000A00A0A398',	'Yes',	'Yes',	500,	'2021-01-14 08:18:41',	4,	4,	'Nice vendor'),
(91,	'0d672a0527662c22d407V000A00A0A297',	'Yes',	'Yes',	500,	'2021-01-14 08:18:41',	4,	4,	'Nice vendor'),
(92,	'0d672a0527662c22d407V000A00A0A398',	'Yes',	'Yes',	500,	'2021-01-14 08:18:42',	4,	4,	'Nice vendor'),
(93,	'0d672a0527662c22d407V000A00A0A297',	'Yes',	'Yes',	500,	'2021-01-14 08:18:42',	4,	4,	'Nice vendor'),
(94,	'0d672a0527662c22d407V000A00A0A398',	'Yes',	'Yes',	500,	'2021-01-14 08:18:42',	4,	4,	'Nice vendor'),
(95,	'0d672a0527662c22d407V000A00A0A297',	'Yes',	'Yes',	500,	'2021-01-14 08:18:42',	4,	4,	'Nice vendor'),
(96,	'0d672a0527662c22d407V000A00A0A297',	'Yes',	'Yes',	500,	'2021-01-14 08:18:42',	4,	4,	'Nice vendor'),
(97,	'0d672a0527662c22d407V000A00A0A398',	'Yes',	'Yes',	500,	'2021-01-14 08:18:43',	4,	4,	'Nice vendor'),
(98,	'0d672a0527662c22d407V000A00A0A297',	'Yes',	'Yes',	500,	'2021-01-14 08:18:43',	4,	4,	'Nice vendor'),
(99,	'0d672a0527662c22d407V000A00A0A398',	'Yes',	'Yes',	500,	'2021-01-14 08:18:43',	4,	4,	'Nice vendor'),
(100,	'0d672a0527662c22d407V000A00A0A297',	'Yes',	'Yes',	500,	'2021-01-14 08:18:43',	4,	4,	'Nice vendor'),
(101,	'0d672a0527662c22d407V000A00A0A398',	'Yes',	'Yes',	500,	'2021-01-14 08:18:43',	4,	4,	'Nice vendor'),
(102,	'0d672a0527662c22d407V000A00A0A297',	'Yes',	'Yes',	500,	'2021-01-14 08:18:44',	4,	4,	'Nice vendor'),
(103,	'0d672a0527662c22d407V000A00A0A297',	'Yes',	'Yes',	500,	'2021-01-14 08:18:44',	4,	4,	'Nice vendor'),
(104,	'0d672a0527662c22d407V000A00A0A398',	'Yes',	'Yes',	500,	'2021-01-14 08:18:44',	4,	4,	'Nice vendor'),
(105,	'0d672a0527662c22d407V000A00A0A398',	'Yes',	'Yes',	500,	'2021-01-14 08:18:44',	4,	4,	'Nice vendor'),
(162,	'b112b51cb237ece3ced2V000A00A0A2125',	'Yes',	'Yes',	500,	'2021-01-17 22:56:58',	4,	4,	'Nice vendor'),
(163,	'b112b51cb237ece3ced2V000A00A0A2125',	'Yes',	'Yes',	500,	'2021-01-17 22:57:50',	4,	4,	'Nice vendor'),
(164,	'b112b51cb237ece3ced2V000A00A0A2125',	'Yes',	'Yes',	500,	'2021-01-17 22:58:12',	4,	4,	'Nice vendor'),
(165,	'b112b51cb237ece3ced2V000A00A0A2125',	'Yes',	'Yes',	500,	'2021-01-17 22:58:14',	4,	4,	'Nice vendor'),
(166,	'b112b51cb237ece3ced2V000A00A0A2125',	'Yes',	'Yes',	500,	'2021-01-17 22:58:15',	4,	4,	'Nice vendor'),
(167,	'b112b51cb237ece3ced2V000A00A0A2125',	'Yes',	'Yes',	500,	'2021-01-17 22:58:16',	4,	4,	'Nice vendor'),
(168,	'b112b51cb237ece3ced2V000A00A0A2125',	'Yes',	'Yes',	500,	'2021-01-17 22:58:16',	4,	4,	'Nice vendor'),
(169,	'b112b51cb237ece3ced2V000A00A0A2125',	'Yes',	'Yes',	500,	'2021-01-17 22:58:17',	4,	4,	'Nice vendor'),
(170,	'b112b51cb237ece3ced2V000A00A0A2125',	'Yes',	'Yes',	500,	'2021-01-17 22:58:18',	4,	4,	'Nice vendor'),
(171,	'b112b51cb237ece3ced2V000A00A0A2125',	'Yes',	'Yes',	500,	'2021-01-17 22:58:18',	4,	4,	'Nice vendor'),
(172,	'b112b51cb237ece3ced2V000A00A0A2125',	'Yes',	'Yes',	500,	'2021-01-17 22:58:19',	4,	4,	'Nice vendor'),
(173,	'b112b51cb237ece3ced2V000A00A0A2125',	'Yes',	'Yes',	500,	'2021-01-17 22:58:22',	4,	4,	'Nice vendor'),
(174,	'b112b51cb237ece3ced2V000A00A0A2125',	'Yes',	'Yes',	500,	'2021-01-17 22:58:23',	4,	4,	'Nice vendor'),
(175,	'b112b51cb237ece3ced2V000A00A0A2125',	'Yes',	'Yes',	500,	'2021-01-17 22:58:23',	4,	4,	'Nice vendor'),
(176,	'b112b51cb237ece3ced2V000A00A0A2125',	'Yes',	'Yes',	500,	'2021-01-17 22:58:23',	4,	4,	'Nice vendor'),
(177,	'b112b51cb237ece3ced2V000A00A0A1126',	'Yes',	'Yes',	500,	'2021-01-17 23:03:00',	4,	4,	'Nice vendor'),
(178,	'b112b51cb237ece3ced2V000A00A0A1127',	'Yes',	'Yes',	500,	'2021-01-18 04:51:37',	4,	4,	'Nice vendor'),
(179,	'b112b51cb237ece3ced2V000A00A0A1128',	'Yes',	'Yes',	500,	'2021-01-18 04:52:06',	4,	4,	'Nice vendor'),
(180,	'b112b51cb237ece3ced2V000A00A0A1129',	'Yes',	'Yes',	500,	'2021-01-18 05:04:57',	4,	4,	'Nice vendor');

DROP TABLE IF EXISTS `order_details`;
CREATE TABLE `order_details` (
  `id` varchar(250) NOT NULL,
  `user_id` varchar(250) NOT NULL,
  `vendor_id` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `user_order_id` int NOT NULL,
  `total_price` int NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `user_order_id` (`user_order_id`),
  KEY `vendor_id` (`vendor_id`),
  CONSTRAINT `order_details_ibfk_4` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `order_details_ibfk_5` FOREIGN KEY (`user_order_id`) REFERENCES `user_orders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `order_details_ibfk_6` FOREIGN KEY (`vendor_id`) REFERENCES `vendors` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `order_details` (`id`, `user_id`, `vendor_id`, `user_order_id`, `total_price`, `created_at`) VALUES
('0d672a0527662c22d407V000A00A0A180',	'0d672a0527662c22d407',	'V000',	80,	500,	'2021-01-13 09:49:49'),
('0d672a0527662c22d407V000A00A0A185',	'0d672a0527662c22d407',	'V000',	85,	500,	'2021-01-14 03:08:48'),
('0d672a0527662c22d407V000A00A0A186',	'0d672a0527662c22d407',	'V000',	86,	500,	'2021-01-14 03:10:00'),
('0d672a0527662c22d407V000A00A0A190',	'0d672a0527662c22d407',	'V000',	90,	500,	'2021-01-14 03:41:24'),
('0d672a0527662c22d407V000A00A0A196',	'0d672a0527662c22d407',	'V000',	96,	500,	'2021-01-14 05:30:36'),
('0d672a0527662c22d407V000A00A0A297',	'0d672a0527662c22d407',	'V000',	97,	500,	'2021-01-14 05:38:15'),
('0d672a0527662c22d407V000A00A0A398',	'0d672a0527662c22d407',	'V000',	98,	500,	'2021-01-14 05:38:28'),
('b112b51cb237ece3ced2V000A00A0A1126',	'b112b51cb237ece3ced2',	'V000',	126,	500,	'2021-01-17 22:57:36'),
('b112b51cb237ece3ced2V000A00A0A1127',	'b112b51cb237ece3ced2',	'V000',	127,	500,	'2021-01-18 04:50:57'),
('b112b51cb237ece3ced2V000A00A0A1128',	'b112b51cb237ece3ced2',	'V000',	128,	500,	'2021-01-18 04:51:58'),
('b112b51cb237ece3ced2V000A00A0A1129',	'b112b51cb237ece3ced2',	'V000',	129,	500,	'2021-01-18 05:04:44'),
('b112b51cb237ece3ced2V000A00A0A2125',	'b112b51cb237ece3ced2',	'V000',	125,	500,	'2021-01-17 22:56:20');

DROP TABLE IF EXISTS `parent_services`;
CREATE TABLE `parent_services` (
  `id` varchar(250) NOT NULL,
  `name` varchar(250) NOT NULL,
  `image1` varchar(250) NOT NULL,
  `image2` varchar(255) NOT NULL,
  `price` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `parent_services` (`id`, `name`, `image1`, `image2`, `price`) VALUES
('A00',	'HOME',	'http://placekitten.com/300/300',	'http://placekitten.com/300/300',	5000),
('B00',	'GROOMING',	'http://placekitten.com/300/300',	'http://placekitten.com/300/300',	9000);

DROP TABLE IF EXISTS `unit_services`;
CREATE TABLE `unit_services` (
  `id` varchar(250) NOT NULL,
  `parent_service_id` varchar(250) NOT NULL,
  `child_service_id` varchar(250) NOT NULL,
  `name` varchar(250) NOT NULL,
  `price` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `parent_service_id` (`parent_service_id`),
  KEY `child_service_id` (`child_service_id`),
  CONSTRAINT `unit_services_ibfk_3` FOREIGN KEY (`parent_service_id`) REFERENCES `parent_services` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `unit_services_ibfk_4` FOREIGN KEY (`child_service_id`) REFERENCES `child_services` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `unit_services` (`id`, `parent_service_id`, `child_service_id`, `name`, `price`) VALUES
('A00A0A0',	'A00',	'A00A0',	'TAPES',	500),
('A00A0A1',	'A00',	'A00A0',	'BATHROOM',	500),
('A00A0A2',	'A00',	'A00A0',	'PIPES',	500),
('A00A0A3',	'A00',	'A00A0',	'OTHERS',	500);

DROP TABLE IF EXISTS `user_orders`;
CREATE TABLE `user_orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` varchar(250) NOT NULL,
  `name` varchar(250) NOT NULL,
  `contact` bigint NOT NULL,
  `email` varchar(250) NOT NULL,
  `unit_service_id` varchar(250) NOT NULL,
  `details` text NOT NULL,
  `complete` enum('Yes','No') NOT NULL DEFAULT 'No',
  `cancelled` enum('Yes','No') NOT NULL DEFAULT 'No',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `unit_service_id` (`unit_service_id`),
  CONSTRAINT `user_orders_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_orders_ibfk_4` FOREIGN KEY (`unit_service_id`) REFERENCES `unit_services` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `user_orders` (`id`, `user_id`, `name`, `contact`, `email`, `unit_service_id`, `details`, `complete`, `cancelled`, `created_at`) VALUES
(80,	'0d672a0527662c22d407',	'rajat%20saini',	7073491568,	'ahadf@gmail.com',	'A00A0A1',	'very%20big%20problem',	'Yes',	'No',	'2021-01-13 17:58:20'),
(85,	'0d672a0527662c22d407',	'ashish',	9772657090,	'ahadf@gmail.com',	'A00A0A1',	'new%20',	'Yes',	'No',	'2021-01-14 03:09:49'),
(86,	'0d672a0527662c22d407',	'ashish',	9772657090,	'ahadf@gmail.com',	'A00A0A1',	'new',	'Yes',	'No',	'2021-01-14 03:26:40'),
(90,	'0d672a0527662c22d407',	'ashisha',	45,	'ahadf@gmail.com',	'A00A0A1',	'aa',	'Yes',	'No',	'2021-01-14 03:42:26'),
(96,	'0d672a0527662c22d407',	'hihi',	78,	'ahadf@gmail.com',	'A00A0A1',	'adf',	'Yes',	'No',	'2021-01-14 05:35:41'),
(97,	'0d672a0527662c22d407',	'new',	45,	'ahadf@gmail.com',	'A00A0A2',	'45',	'Yes',	'No',	'2021-01-14 08:18:35'),
(98,	'0d672a0527662c22d407',	'new',	45,	'ahadf@gmail.com',	'A00A0A3',	'45',	'Yes',	'No',	'2021-01-14 08:18:35'),
(125,	'b112b51cb237ece3ced2',	'rohit',	9407494862,	'rohitpat1998@gmail.com',	'A00A0A2',	'problem',	'Yes',	'No',	'2021-01-17 22:56:58'),
(126,	'b112b51cb237ece3ced2',	'rohit',	9407494862,	'rohitpat1998@gmail.com',	'A00A0A1',	'problem',	'Yes',	'No',	'2021-01-17 23:03:00'),
(127,	'b112b51cb237ece3ced2',	'rohit',	9407494862,	'rohitpat1998@gmail.com',	'A00A0A1',	'problem',	'Yes',	'No',	'2021-01-18 04:51:37'),
(128,	'b112b51cb237ece3ced2',	'rohit',	9407494862,	'rohitpat1998@gmail.com',	'A00A0A1',	'problem',	'Yes',	'No',	'2021-01-18 04:52:06'),
(129,	'b112b51cb237ece3ced2',	'rohit',	9407494862,	'rohitpat1998@gmail.com',	'A00A0A1',	'problem5',	'Yes',	'No',	'2021-01-18 05:04:57');

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` varchar(250) NOT NULL,
  `name` varchar(250) NOT NULL,
  `contact` varchar(10) DEFAULT NULL,
  `email` varchar(250) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `address` text,
  `pincode` varchar(11) DEFAULT NULL,
  `state` varchar(250) DEFAULT NULL,
  `profile_pic` varchar(250) DEFAULT NULL,
  `social_signup` enum('Yes','No') NOT NULL DEFAULT 'No',
  `complete_profile` enum('Yes','No') NOT NULL DEFAULT 'No',
  `deactivate_account` enum('Yes','No') NOT NULL DEFAULT 'No',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `users` (`id`, `name`, `contact`, `email`, `password`, `address`, `pincode`, `state`, `profile_pic`, `social_signup`, `complete_profile`, `deactivate_account`, `created_at`) VALUES
('0d672a0527662c22d407',	'ashish',	'9772657090',	'ahadf@gmail.com',	'$2a$10$R.0BL7hQR9uv8UO19F4wkO1VtllWdhjtujLlYBk1vwbGf.7yd2sPy',	'nawa',	'341509',	'raj',	'hi.jpg',	'No',	'Yes',	'No',	'2021-01-07 17:44:42'),
('306faf86e4837021d9a0',	'ashish',	'9772657090',	'aish@gmail.com',	'$2a$10$b6pqluyfd1gEhurpsEF7COyKaqZJs/Q5ajeYwHyBSHRar0x4gvPVS',	'nawa',	'341509',	'raj',	'hi.jpg',	'No',	'Yes',	'No',	'2021-01-07 17:24:46'),
('b112b51cb237ece3ced2',	'rohit',	'9407494862',	'rohitpat1998@gmail.com',	'$2a$10$8psOJibStXVG.mkToEZV5uZ9HJ769h8kmmA98f2yOPUvVCln1ThlK',	'address',	'800011',	'Bihar',	'',	'No',	'Yes',	'No',	'2021-01-17 22:29:27');

DROP TABLE IF EXISTS `vendor_service_list`;
CREATE TABLE `vendor_service_list` (
  `id` int NOT NULL AUTO_INCREMENT,
  `vendor_id` varchar(250) NOT NULL,
  `unit_service_id` varchar(250) NOT NULL,
  `rating` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `vendor_id` (`vendor_id`),
  KEY `unit_service_id` (`unit_service_id`),
  CONSTRAINT `vendor_service_list_ibfk_3` FOREIGN KEY (`vendor_id`) REFERENCES `vendors` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `vendor_service_list_ibfk_4` FOREIGN KEY (`unit_service_id`) REFERENCES `unit_services` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `vendors`;
CREATE TABLE `vendors` (
  `id` varchar(250) NOT NULL,
  `name` varchar(250) DEFAULT NULL,
  `contact` bigint DEFAULT NULL,
  `email` varchar(250) DEFAULT NULL,
  `sub_title` varchar(250) DEFAULT NULL,
  `experience` tinytext,
  `work_sample` varchar(250) DEFAULT NULL,
  `details` text,
  `password` varchar(250) DEFAULT NULL,
  `active` enum('Yes','No') DEFAULT 'Yes',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `vendors` (`id`, `name`, `contact`, `email`, `sub_title`, `experience`, `work_sample`, `details`, `password`, `active`, `created_at`) VALUES
('V000',	'Test Vendor',	9772657090,	'vendor@gmail.com',	'new vendor',	'well experienced',	'4 samples',	'passionate vendor',	'testvendor',	'Yes',	'2021-01-14 02:27:50');

-- 2021-01-18 05:32:40
