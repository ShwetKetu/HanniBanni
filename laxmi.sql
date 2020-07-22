-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 22, 2020 at 07:42 AM
-- Server version: 10.4.13-MariaDB
-- PHP Version: 7.2.32

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `laxmi`
--

-- --------------------------------------------------------

--
-- Table structure for table `contact`
--

CREATE TABLE `contact` (
  `SNo` int(11) NOT NULL,
  `Name` text NOT NULL,
  `Email` varchar(50) NOT NULL,
  `Phone_No` varchar(50) NOT NULL,
  `Message` varchar(50) NOT NULL,
  `Date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `contact`
--

INSERT INTO `contact` (`SNo`, `Name`, `Email`, `Phone_No`, `Message`, `Date`) VALUES
(1, 'Shwet', 'ketu1009@gmail.com', '7838330653', 'Hello World', '2020-07-19 14:51:24'),
(2, 'Ketu', 'shwetk1234@gmail.com', '7838330654', 'Cheers..!!', '2020-07-19 17:00:58'),
(3, 'Ishu', 'ishu234@gmail.com', '9847443333', 'Call Me ASAP', '2020-07-19 23:46:40'),
(4, 'Shilpi', 'Shilpi@sk.com', '8382728299', 'Can you do this', '2020-07-20 08:22:07'),
(5, 'Megha', 'Megha@isk.com', '8483822222', 'You are pathetic', '2020-07-20 08:30:22'),
(6, 'Sandeep', '2811sandeep@gmail.com', '8439298452', 'Living In Reverse', '2020-07-20 08:32:34');

-- --------------------------------------------------------

--
-- Table structure for table `post`
--

CREATE TABLE `post` (
  `SNo` int(11) NOT NULL,
  `Title` varchar(50) NOT NULL,
  `Tagline` text NOT NULL,
  `Slug` varchar(25) NOT NULL,
  `Content` varchar(500) NOT NULL,
  `Images` varchar(30) NOT NULL,
  `Date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `post`
--

INSERT INTO `post` (`SNo`, `Title`, `Tagline`, `Slug`, `Content`, `Images`, `Date`) VALUES
(1, 'Updates And News', 'Scroll Down', 'First-Post', 'Lets Join Hands To Share Happiness Together With A Yummy Toast And A Cup Of Tea', 'rusk12.jfif', '2020-07-20 09:03:49'),
(2, 'New Offers', 'Hurry Fast', 'Second-Post', '5 % Discount On Purchase Of Amount More Than 20k.', 'hurryup2.jpg', '2020-07-21 19:42:42'),
(3, 'Coming Soon', 'Stay With Us', 'Third-Post', 'Your Wait Is Finally Over', 'rusk7.jpg', '2020-07-20 12:02:43'),
(4, 'Want Some Fun', 'With New Flavour', 'Fourth-Post', 'You Will Go In Different Dimension Altogether Just With One Bite..:)', 'rusk3.jpg', '2020-07-20 12:04:56'),
(5, 'Now Or Never', 'What Are You Waiting For', 'Fifth-Post', 'Order It Now..', 'rusk1.jpg', '2020-07-20 12:07:21'),
(6, 'Grateful', 'Blessing', 'Sixth-Post', 'With Your Blessings And God\'s Blessing, We Are Here Now...', 'rusk4.jpg', '2020-07-20 20:52:46'),
(7, 'GUI', 'GUI', 'GUI', 'GUI', 'gjg.jpg', '2020-07-20 18:41:12');

-- --------------------------------------------------------

--
-- Table structure for table `toast`
--

CREATE TABLE `toast` (
  `SNo` int(11) NOT NULL,
  `Name` text NOT NULL,
  `Type` text NOT NULL,
  `Price` varchar(50) NOT NULL,
  `Description` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contact`
--
ALTER TABLE `contact`
  ADD PRIMARY KEY (`SNo`);

--
-- Indexes for table `post`
--
ALTER TABLE `post`
  ADD PRIMARY KEY (`SNo`);

--
-- Indexes for table `toast`
--
ALTER TABLE `toast`
  ADD PRIMARY KEY (`SNo`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contact`
--
ALTER TABLE `contact`
  MODIFY `SNo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `post`
--
ALTER TABLE `post`
  MODIFY `SNo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `toast`
--
ALTER TABLE `toast`
  MODIFY `SNo` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
