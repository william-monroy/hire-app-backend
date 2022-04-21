-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Apr 21, 2022 at 12:18 PM
-- Server version: 10.3.34-MariaDB-cll-lve
-- PHP Version: 7.4.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `afuentesalanis_densodb`
--

-- --------------------------------------------------------

--
-- Table structure for table `administrator`
--

CREATE TABLE `administrator` (
  `id` int(11) NOT NULL,
  `fName` varchar(255) NOT NULL,
  `lName` varchar(255) NOT NULL,
  `age` date NOT NULL,
  `email` varchar(255) NOT NULL,
  `phoneNumber` varchar(20) NOT NULL,
  `passwordHash` varchar(300) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `administrator`
--

INSERT INTO `administrator` (`id`, `fName`, `lName`, `age`, `email`, `phoneNumber`, `passwordHash`) VALUES
(1, 'Andres', 'Fuentes', '2002-04-23', 'andres.fuentes@afared.com', '8120329739', 'abcdefg');

-- --------------------------------------------------------

--
-- Table structure for table `candidate`
--

CREATE TABLE `candidate` (
  `id` int(11) NOT NULL,
  `fName` varchar(255) NOT NULL,
  `lName` varchar(255) NOT NULL,
  `age` date DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `phoneNumber` varchar(20) NOT NULL,
  `passwordHash` varchar(300) NOT NULL,
  `idAdministrator` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `candidate`
--

INSERT INTO `candidate` (`id`, `fName`, `lName`, `age`, `email`, `phoneNumber`, `passwordHash`, `idAdministrator`) VALUES
(1, 'Daniel', 'Martinez', '2001-09-20', 'a01177464@tec.mx', '9912345678', 'hdsjahdjashdjad', 1);

-- --------------------------------------------------------

--
-- Table structure for table `test1`
--

CREATE TABLE `test1` (
  `id` int(11) NOT NULL,
  `answer1` int(11) NOT NULL,
  `answer2` int(11) NOT NULL,
  `answer3` int(11) NOT NULL,
  `answer4` int(11) NOT NULL,
  `answer5` int(11) NOT NULL,
  `answer6` int(11) NOT NULL,
  `idCandidate` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `test1`
--

INSERT INTO `test1` (`id`, `answer1`, `answer2`, `answer3`, `answer4`, `answer5`, `answer6`, `idCandidate`) VALUES
(1, 1, 1, 1, 1, 1, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `test2`
--

CREATE TABLE `test2` (
  `id` int(11) NOT NULL,
  `answer1` int(11) NOT NULL,
  `answer2` int(11) NOT NULL,
  `answer3` int(11) NOT NULL,
  `answer4` int(11) NOT NULL,
  `answer5` int(11) NOT NULL,
  `idCandidate` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `test2`
--

INSERT INTO `test2` (`id`, `answer1`, `answer2`, `answer3`, `answer4`, `answer5`, `idCandidate`) VALUES
(1, 1, 1, 1, 1, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `test3`
--

CREATE TABLE `test3` (
  `id` int(11) NOT NULL,
  `answer1` int(11) NOT NULL,
  `answer2` int(11) NOT NULL,
  `answer3` int(11) NOT NULL,
  `answer4` int(11) NOT NULL,
  `answer5` int(11) NOT NULL,
  `answer6` int(11) NOT NULL,
  `idCandidate` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `test3`
--

INSERT INTO `test3` (`id`, `answer1`, `answer2`, `answer3`, `answer4`, `answer5`, `answer6`, `idCandidate`) VALUES
(1, 1, 1, 1, 0, 0, 1, 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `administrator`
--
ALTER TABLE `administrator`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `candidate`
--
ALTER TABLE `candidate`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idAdministrator` (`idAdministrator`);

--
-- Indexes for table `test1`
--
ALTER TABLE `test1`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idCandidate` (`idCandidate`);

--
-- Indexes for table `test2`
--
ALTER TABLE `test2`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idCandidate` (`idCandidate`);

--
-- Indexes for table `test3`
--
ALTER TABLE `test3`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idCandidate` (`idCandidate`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `candidate`
--
ALTER TABLE `candidate`
  ADD CONSTRAINT `candidate_ibfk_1` FOREIGN KEY (`idAdministrator`) REFERENCES `administrator` (`id`);

--
-- Constraints for table `test1`
--
ALTER TABLE `test1`
  ADD CONSTRAINT `test1_ibfk_1` FOREIGN KEY (`idCandidate`) REFERENCES `candidate` (`id`);

--
-- Constraints for table `test2`
--
ALTER TABLE `test2`
  ADD CONSTRAINT `test2_ibfk_1` FOREIGN KEY (`idCandidate`) REFERENCES `candidate` (`id`);

--
-- Constraints for table `test3`
--
ALTER TABLE `test3`
  ADD CONSTRAINT `test3_ibfk_1` FOREIGN KEY (`idCandidate`) REFERENCES `candidate` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
