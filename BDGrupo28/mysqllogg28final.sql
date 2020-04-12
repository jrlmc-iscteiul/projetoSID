-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 05, 2020 at 09:12 PM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.4.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mysqllogg28`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `pesquisarSistema` (IN `nomeTabela` VARCHAR(50), IN `emailUtilizador` VARCHAR(100), IN `dataOperacao` VARCHAR(50), IN `operacao` VARCHAR(6))  NO SQL
BEGIN

IF (nomeTabela = 'logsutilizador') THEN 

	IF (emailUtilizador = "" and dataOperacao = "" and operacao = "") THEN
    	SELECT * FROM logsutilizador;
    END IF; 

	IF (emailUtilizador != "" and dataOperacao != "" and operacao != "") THEN
    	SELECT * FROM logsutilizador WHERE (logsutilizador.UserID = emailUtilizador AND logsutilizador.Data = dataOperacao and logsutilizador.Operacao = operacao);
    END IF; 
    
    IF (emailUtilizador != "" and dataOperacao = "" and operacao = "") THEN
		SELECT * FROM logsutilizador WHERE logsutilizador.UserID = emailUtilizador;
 	END IF;

	IF (emailUtilizador = "" and dataOperacao != "" and operacao = "") THEN
		SELECT * FROM logsutilizador WHERE logsutilizador.Data = dataOperacao;
    END IF;
    
	IF (emailUtilizador = "" and dataOperacao = "" and operacao != "") THEN
		SELECT * FROM logsutilizador WHERE logsutilizador.Operacao = operacao;
	END IF;
	
	IF (emailUtilizador != "" and dataOperacao != "" and operacao = "") THEN
    	SELECT * FROM logsutilizador WHERE (logsutilizador.UserID = emailUtilizador AND logsutilizador.Data = dataOperacao);
    END IF; 
	
	IF (emailUtilizador != "" and dataOperacao = "" and operacao != "") THEN
    	SELECT * FROM logsutilizador WHERE (logsutilizador.UserID = emailUtilizador AND logsutilizador.Operacao = operacao);
    END IF; 
	
	IF (emailUtilizador = "" and dataOperacao != "" and operacao != "") THEN
    	SELECT * FROM logsutilizador WHERE (logsutilizador.Data = dataOperacao AND logsutilizador.Operacao = operacao);
    END IF; 
	
END IF;


IF (nomeTabela = 'logssistema') THEN 

	IF (emailUtilizador = "" and dataOperacao = "" and operacao = "") THEN
    	SELECT * FROM logssistema;
    END IF; 

	IF (emailUtilizador != "" and dataOperacao != "" and operacao != "") THEN
    	SELECT * FROM logssistema WHERE (logssistema.UserID = emailUtilizador AND logssistema.Data = dataOperacao and logssistema.Operacao = operacao);
    END IF; 
    
    IF (emailUtilizador != "" and dataOperacao = "" and operacao = "") THEN
		SELECT * FROM logssistema WHERE logssistema.UserID = emailUtilizador;
 	END IF;

	IF (emailUtilizador = "" and dataOperacao != "" and operacao = "") THEN
		SELECT * FROM logssistema WHERE logssistema.Data = dataOperacao;
    END IF;
    
	IF (emailUtilizador = "" and dataOperacao = "" and operacao != "") THEN
		SELECT * FROM logssistema WHERE logssistema.Operacao = operacao;
	END IF;
	
	IF (emailUtilizador != "" and dataOperacao != "" and operacao = "") THEN
    	SELECT * FROM logssistema WHERE (logssistema.UserID = emailUtilizador AND logssistema.Data = dataOperacao);
    END IF; 
	
	IF (emailUtilizador != "" and dataOperacao = "" and operacao != "") THEN
    	SELECT * FROM logssistema WHERE (logssistema.UserID = emailUtilizador AND logssistema.Operacao = operacao);
    END IF; 
	
	IF (emailUtilizador = "" and dataOperacao != "" and operacao != "") THEN
    	SELECT * FROM logssistema WHERE (logssistema.Data = dataOperacao AND logssistema.Operacao = operacao);
    END IF; 
	
END IF;


IF (nomeTabela = 'logsrondaplaneada') THEN 

	IF (emailUtilizador = "" and dataOperacao = "" and operacao = "") THEN
    	SELECT * FROM logsrondaplaneada;
    END IF; 

	IF (emailUtilizador != "" and dataOperacao != "" and operacao != "") THEN
    	SELECT * FROM logsrondaplaneada WHERE (logsrondaplaneada.UserID = emailUtilizador AND logsrondaplaneada.Data = dataOperacao and logsrondaplaneada.Operacao = operacao);
    END IF; 
    
    IF (emailUtilizador != "" and dataOperacao = "" and operacao = "") THEN
		SELECT * FROM logsrondaplaneada WHERE logsrondaplaneada.UserID = emailUtilizador;
 	END IF;

	IF (emailUtilizador = "" and dataOperacao != "" and operacao = "") THEN
		SELECT * FROM logsrondaplaneada WHERE logsrondaplaneada.Data = dataOperacao;
    END IF;
    
	IF (emailUtilizador = "" and dataOperacao = "" and operacao != "") THEN
		SELECT * FROM logsrondaplaneada WHERE logsrondaplaneada.Operacao = operacao;
	END IF;
	
	IF (emailUtilizador != "" and dataOperacao != "" and operacao = "") THEN
    	SELECT * FROM logsrondaplaneada WHERE (logsrondaplaneada.UserID = emailUtilizador AND logsrondaplaneada.Data = dataOperacao);
    END IF; 
	
	IF (emailUtilizador != "" and dataOperacao = "" and operacao != "") THEN
    	SELECT * FROM logsrondaplaneada WHERE (logsrondaplaneada.UserID = emailUtilizador AND logsrondaplaneada.Operacao = operacao);
    END IF; 
	
	IF (emailUtilizador = "" and dataOperacao != "" and operacao != "") THEN
    	SELECT * FROM logsrondaplaneada WHERE (logsrondaplaneada.Data = dataOperacao AND logsrondaplaneada.Operacao = operacao);
    END IF; 
	
END IF;


IF (nomeTabela = 'logsrondaextra') THEN 

	IF (emailUtilizador = "" and dataOperacao = "" and operacao = "") THEN
    	SELECT * FROM logsrondaextra;
    END IF; 

	IF (emailUtilizador != "" and dataOperacao != "" and operacao != "") THEN
    	SELECT * FROM logsrondaextra WHERE (logsrondaextra.UserID = emailUtilizador AND logsrondaextra.Data = dataOperacao and logsrondaextra.Operacao = operacao);
    END IF; 
    
    IF (emailUtilizador != "" and dataOperacao = "" and operacao = "") THEN
		SELECT * FROM logsrondaextra WHERE logsrondaextra.UserID = emailUtilizador;
 	END IF;

	IF (emailUtilizador = "" and dataOperacao != "" and operacao = "") THEN
		SELECT * FROM logsrondaextra WHERE logsrondaextra.Data = dataOperacao;
    END IF;
    
	IF (emailUtilizador = "" and dataOperacao = "" and operacao != "") THEN
		SELECT * FROM logsrondaextra WHERE logsrondaextra.Operacao = operacao;
	END IF;
	
	IF (emailUtilizador != "" and dataOperacao != "" and operacao = "") THEN
    	SELECT * FROM logsrondaextra WHERE (logsrondaextra.UserID = emailUtilizador AND logsrondaextra.Data = dataOperacao);
    END IF; 
	
	IF (emailUtilizador != "" and dataOperacao = "" and operacao != "") THEN
    	SELECT * FROM logsrondaextra WHERE (logsrondaextra.UserID = emailUtilizador AND logsrondaextra.Operacao = operacao);
    END IF; 
	
	IF (emailUtilizador = "" and dataOperacao != "" and operacao != "") THEN
    	SELECT * FROM logsrondaextra WHERE (logsrondaextra.Data = dataOperacao AND logsrondaextra.Operacao = operacao);
    END IF; 
	
END IF;


IF (nomeTabela = 'logsmedicoessensores') THEN 

	IF (emailUtilizador = "" and dataOperacao = "" and operacao = "") THEN
    	SELECT * FROM logsmedicoessensores;
    END IF; 

	IF (emailUtilizador != "" and dataOperacao != "" and operacao != "") THEN
    	SELECT * FROM logsmedicoessensores WHERE (logsmedicoessensores.UserID = emailUtilizador AND logsmedicoessensores.Data = dataOperacao and logsmedicoessensores.Operacao = operacao);
    END IF; 
    
    IF (emailUtilizador != "" and dataOperacao = "" and operacao = "") THEN
		SELECT * FROM logsmedicoessensores WHERE logsmedicoessensores.UserID = emailUtilizador;
 	END IF;

	IF (emailUtilizador = "" and dataOperacao != "" and operacao = "") THEN
		SELECT * FROM logsmedicoessensores WHERE logsmedicoessensores.Data = dataOperacao;
    END IF;
    
	IF (emailUtilizador = "" and dataOperacao = "" and operacao != "") THEN
		SELECT * FROM logsmedicoessensores WHERE logsmedicoessensores.Operacao = operacao;
	END IF;
	
	IF (emailUtilizador != "" and dataOperacao != "" and operacao = "") THEN
    	SELECT * FROM logsmedicoessensores WHERE (logsmedicoessensores.UserID = emailUtilizador AND logsmedicoessensores.Data = dataOperacao);
    END IF; 
	
	IF (emailUtilizador != "" and dataOperacao = "" and operacao != "") THEN
    	SELECT * FROM logsmedicoessensores WHERE (logsmedicoessensores.UserID = emailUtilizador AND logsmedicoessensores.Operacao = operacao);
    END IF; 
	
	IF (emailUtilizador = "" and dataOperacao != "" and operacao != "") THEN
    	SELECT * FROM logsmedicoessensores WHERE (logsmedicoessensores.Data = dataOperacao AND logsmedicoessensores.Operacao = operacao);
    END IF; 
	
END IF;


IF (nomeTabela = 'logsdiasemana') THEN 

	IF (emailUtilizador = "" and dataOperacao = "" and operacao = "") THEN
    	SELECT * FROM logsdiasemana;
    END IF; 

	IF (emailUtilizador != "" and dataOperacao != "" and operacao != "") THEN
    	SELECT * FROM logsdiasemana WHERE (logsdiasemana.UserID = emailUtilizador AND logsdiasemana.Data = dataOperacao and logsdiasemana.Operacao = operacao);
    END IF; 
    
    IF (emailUtilizador != "" and dataOperacao = "" and operacao = "") THEN
		SELECT * FROM logsdiasemana WHERE logsdiasemana.UserID = emailUtilizador;
 	END IF;

	IF (emailUtilizador = "" and dataOperacao != "" and operacao = "") THEN
		SELECT * FROM logsdiasemana WHERE logsdiasemana.Data = dataOperacao;
    END IF;
    
	IF (emailUtilizador = "" and dataOperacao = "" and operacao != "") THEN
		SELECT * FROM logsdiasemana WHERE logsdiasemana.Operacao = operacao;
	END IF;
	
	IF (emailUtilizador != "" and dataOperacao != "" and operacao = "") THEN
    	SELECT * FROM logsdiasemana WHERE (logsdiasemana.UserID = emailUtilizador AND logsdiasemana.Data = dataOperacao);
    END IF; 
	
	IF (emailUtilizador != "" and dataOperacao = "" and operacao != "") THEN
    	SELECT * FROM logsdiasemana WHERE (logsdiasemana.UserID = emailUtilizador AND logsdiasemana.Operacao = operacao);
    END IF; 
	
	IF (emailUtilizador = "" and dataOperacao != "" and operacao != "") THEN
    	SELECT * FROM logsdiasemana WHERE (logsdiasemana.Data = dataOperacao AND logsdiasemana.Operacao = operacao);
    END IF; 
	
END IF;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `logsdiasemana`
--

CREATE TABLE `logsdiasemana` (
  `ID` int(11) NOT NULL,
  `UserID` varchar(50) NOT NULL,
  `Data` timestamp NOT NULL DEFAULT current_timestamp(),
  `Operacao` varchar(6) NOT NULL,
  `ValoresAntigos` varchar(5000) NOT NULL,
  `ValoresNovos` varchar(5000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `logsdiasemana`
--

INSERT INTO `logsdiasemana` (`ID`, `UserID`, `Data`, `Operacao`, `ValoresAntigos`, `ValoresNovos`) VALUES
(8, 'ana', '2020-03-29 11:05:39', 'i', 'hnbgvfed', 'bgfd'),
(9, '', '2020-03-29 11:07:00', 'I', '', 'domingo|20:00:00'),
(10, '', '2020-03-29 11:08:44', 'U', 'quarta|15:16:00', 'quarta|15:30:00'),
(11, '', '2020-03-29 11:08:48', 'D', 'segunda|22:22:00', ''),
(12, '', '2020-03-29 11:10:35', 'U', 'segunda|10:00:00', 'segunda|10:15:00'),
(13, '', '2020-03-29 11:10:50', 'I', '', 'sexta|10:00:00'),
(14, '', '2020-03-29 11:12:40', 'D', 'domingo|20:00:00', ''),
(15, '', '2020-03-29 11:12:56', 'I', '', '23:00:00|00:00:00'),
(16, '', '2020-03-29 11:13:04', 'D', '23:00:00|00:00:00', ''),
(17, '', '2020-03-29 11:13:20', 'I', '', 'quinta|17:00:00'),
(18, '', '2020-03-29 12:56:42', 'D', 'terca|23:30:00', ''),
(19, '', '2020-03-29 13:00:05', 'I', '', 'sabado|20:00:00'),
(20, '', '2020-03-29 13:02:14', 'I', '', 'segunda|12:00:00'),
(21, '', '2020-03-29 13:34:34', 'D', 'domingo|15:15:00', ''),
(22, '', '2020-03-29 13:42:11', 'I', '', 'sabado|21:00:00'),
(23, '', '2020-03-29 13:52:03', 'D', 'sabado|20:00:00', ''),
(24, '', '2020-03-29 16:53:02', 'D', 'quarta|15:30:00.000000', ''),
(25, '', '2020-03-29 16:53:02', 'D', 'quinta|17:00:00.000000', ''),
(26, '', '2020-03-29 16:53:02', 'D', 'sabado|21:00:00.000000', ''),
(27, '', '2020-03-29 16:53:02', 'D', 'segunda|10:15:00.000000', ''),
(28, '', '2020-03-29 16:53:02', 'D', 'segunda|12:00:00.000000', ''),
(29, '', '2020-03-29 16:53:02', 'D', 'sexta|10:00:00.000000', ''),
(30, '', '2020-04-01 13:24:25', 'I', '', 'terca|20:13:01'),
(31, '', '2020-04-01 13:24:42', 'I', '', 'terca|15:00:00'),
(32, '', '2020-04-01 14:56:43', 'I', '', 'terça|15:56:21'),
(33, '', '2020-04-01 14:56:54', 'I', '', 'terça|16:54:43'),
(34, '', '2020-04-01 14:57:04', 'I', '', 'terça|20:56:54'),
(35, '', '2020-04-01 14:57:10', 'I', '', 'terça|20:57:04'),
(36, '', '2020-04-01 14:57:17', 'I', '', 'terça|24:57:10'),
(37, '', '2020-04-01 14:57:28', 'I', '', 'segunda|39:57:17'),
(38, '', '2020-04-01 15:01:58', 'I', '', 'terça|17:01:17'),
(39, '', '2020-04-01 15:02:48', 'I', '', 'terça|17:01:11'),
(40, '', '2020-04-01 15:02:48', 'I', '', 'terça|17:01:12'),
(41, '', '2020-04-01 15:02:48', 'I', '', 'terça|17:01:31'),
(68, '', '2020-04-01 15:05:52', 'I', '', 'quarta|17:01:14'),
(69, '', '2020-04-01 15:05:52', 'I', '', 'terça|17:01:15'),
(70, '', '2020-04-01 15:05:52', 'I', '', 'terça|17:01:16'),
(71, '', '2020-04-01 15:05:52', 'I', '', 'terça|17:01:10'),
(72, '', '2020-04-01 15:05:52', 'I', '', 'terça|17:01:18'),
(73, '', '2020-04-01 15:05:52', 'I', '', 'terça|17:01:19'),
(74, '', '2020-04-01 15:05:52', 'I', '', 'terça|17:01:21'),
(75, '', '2020-04-01 15:05:52', 'I', '', 'terça|17:01:01'),
(76, '', '2020-04-01 15:05:52', 'I', '', 'terça|17:01:41'),
(77, '', '2020-04-01 15:05:52', 'I', '', 'terça|17:01:51'),
(78, '', '2020-04-01 15:05:52', 'I', '', 'terça|17:11:31'),
(79, '', '2020-04-01 15:05:52', 'I', '', 'terça|17:11:11'),
(80, '', '2020-04-01 15:05:52', 'I', '', 'terça|17:01:22'),
(81, '', '2020-04-01 15:05:52', 'I', '', 'terça|17:41:21'),
(82, '', '2020-04-01 15:05:52', 'I', '', 'terça|17:41:11'),
(83, '', '2020-04-01 15:05:52', 'I', '', 'terça|17:21:11'),
(84, '', '2020-04-01 15:11:35', 'I', '', 'sexta|19:01:21'),
(85, '', '2020-04-01 15:11:35', 'I', '', 'sexta|19:01:31'),
(86, '', '2020-04-01 15:11:35', 'I', '', 'sexta|19:01:41'),
(87, '', '2020-04-01 15:11:35', 'I', '', 'sexta|19:01:51'),
(88, '', '2020-04-01 15:11:35', 'I', '', 'sexta|19:02:11'),
(89, '', '2020-04-01 15:11:35', 'I', '', 'sexta|19:03:11'),
(90, '', '2020-04-01 15:11:35', 'I', '', 'sexta|19:04:11'),
(91, '', '2020-04-01 15:11:35', 'I', '', 'sexta|19:05:11'),
(92, '', '2020-04-01 15:11:35', 'I', '', 'sexta|19:06:11'),
(93, '', '2020-04-01 15:11:35', 'I', '', 'sexta|19:07:11'),
(94, '', '2020-04-01 15:11:35', 'I', '', 'sexta|19:08:11'),
(95, '', '2020-04-01 15:11:35', 'I', '', 'sexta|19:09:11'),
(96, '', '2020-04-01 15:11:35', 'I', '', 'sexta|19:10:11'),
(97, '', '2020-04-01 15:11:35', 'I', '', 'sexta|19:11:11'),
(98, '', '2020-04-01 15:11:35', 'I', '', 'sexta|10:01:11'),
(99, '', '2020-04-01 15:11:35', 'I', '', 'sexta|11:01:11'),
(100, '', '2020-04-01 15:11:35', 'I', '', 'sexta|12:01:11'),
(101, '', '2020-04-01 15:11:35', 'I', '', 'sexta|13:01:11'),
(102, '', '2020-04-01 15:11:35', 'I', '', 'sexta|14:01:11'),
(103, '', '2020-04-01 15:11:35', 'I', '', 'sexta|15:01:11'),
(104, '', '2020-04-01 15:11:35', 'I', '', 'sexta|16:01:11'),
(105, '', '2020-04-01 15:11:35', 'I', '', 'sexta|17:01:11'),
(106, '', '2020-04-01 15:11:35', 'I', '', 'sexta|18:01:11'),
(107, '', '2020-04-01 15:11:35', 'I', '', 'sexta|20:01:11'),
(161, '', '2020-04-01 15:35:41', 'I', '', 'sexta|10:00:00'),
(162, '', '2020-04-01 15:35:41', 'I', '', 'sexta|11:00:00'),
(163, '', '2020-04-01 15:35:41', 'I', '', 'sexta|12:00:00'),
(164, '', '2020-04-01 15:35:41', 'I', '', 'sexta|13:00:00'),
(165, '', '2020-04-01 15:35:41', 'I', '', 'sexta|14:00:00'),
(166, '', '2020-04-01 15:35:41', 'I', '', 'sexta|15:00:00'),
(167, '', '2020-04-01 15:35:41', 'I', '', 'sexta|16:00:00'),
(168, '', '2020-04-01 15:35:41', 'I', '', 'sexta|17:00:00'),
(169, '', '2020-04-01 15:35:41', 'I', '', 'sexta|18:00:00'),
(170, '', '2020-04-01 15:35:41', 'I', '', 'sexta|19:00:00'),
(171, '', '2020-04-01 15:35:41', 'I', '', 'sexta|10:01:00'),
(172, '', '2020-04-01 15:35:41', 'I', '', 'sexta|10:02:00'),
(173, '', '2020-04-01 15:35:41', 'I', '', 'sexta|10:03:00'),
(174, '', '2020-04-01 15:35:41', 'I', '', 'sexta|10:04:00'),
(175, '', '2020-04-01 15:35:41', 'I', '', 'sexta|10:05:00'),
(176, '', '2020-04-01 15:35:41', 'I', '', 'sexta|10:06:00'),
(177, '', '2020-04-01 15:35:41', 'I', '', 'sexta|10:07:00'),
(178, '', '2020-04-01 15:35:41', 'I', '', 'sexta|10:08:00'),
(179, '', '2020-04-01 15:35:41', 'I', '', 'sexta|10:09:00'),
(180, '', '2020-04-01 15:35:41', 'I', '', 'sexta|10:01:01'),
(181, '', '2020-04-01 15:35:41', 'I', '', 'sexta|10:01:02'),
(182, '', '2020-04-01 15:35:41', 'I', '', 'sexta|10:01:03'),
(183, '', '2020-04-01 15:35:41', 'I', '', 'sexta|10:01:40'),
(184, '', '2020-04-01 15:35:41', 'I', '', 'sexta|10:01:50'),
(185, '', '2020-04-01 15:35:41', 'I', '', 'sexta|10:01:51'),
(186, '', '2020-04-01 15:35:41', 'I', '', 'sexta|10:01:41');

-- --------------------------------------------------------

--
-- Table structure for table `logsmedicoessensores`
--

CREATE TABLE `logsmedicoessensores` (
  `ID` int(11) NOT NULL,
  `UserID` varchar(50) NOT NULL,
  `Data` timestamp NOT NULL DEFAULT current_timestamp(),
  `Operacao` varchar(6) NOT NULL,
  `ValoresAntigos` varchar(5000) NOT NULL,
  `ValoresNovos` varchar(5000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `logsmedicoessensores`
--

INSERT INTO `logsmedicoessensores` (`ID`, `UserID`, `Data`, `Operacao`, `ValoresAntigos`, `ValoresNovos`) VALUES
(1, '', '2020-03-29 00:54:41', 'I', '', '1738.00'),
(2, '', '2020-03-29 00:55:12', 'D', '3.00', ''),
(3, '', '2020-03-29 14:02:58', 'I', '', '10.00'),
(4, '', '2020-03-29 14:02:58', 'I', '', '20.00'),
(5, '', '2020-04-05 09:50:32', 'I', '', '45.00'),
(6, '', '2020-04-05 09:56:47', 'I', '', '1.00'),
(7, '', '2020-04-05 09:56:47', 'I', '', '20.00'),
(8, '', '2020-04-05 09:56:47', 'I', '', '30.00'),
(9, '', '2020-04-05 09:56:47', 'I', '', '40.00'),
(10, '', '2020-04-05 09:56:47', 'I', '', '50.00'),
(11, '', '2020-04-01 13:59:30', 'I', '', '4.00'),
(12, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(13, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(14, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(15, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(16, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(17, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(18, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(19, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(20, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(21, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(22, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(23, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(24, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(25, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(26, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(27, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(28, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(29, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(30, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(31, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(32, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(33, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(34, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(35, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(36, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(37, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(38, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(39, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(40, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(41, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(42, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(43, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(44, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(45, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(46, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(47, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(48, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(49, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(50, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(61, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(62, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(63, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(64, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(65, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(66, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(67, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(68, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(69, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(70, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(71, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(72, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(73, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(74, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(75, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(76, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(77, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(78, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(79, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(80, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(81, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(82, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(83, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(84, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(85, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(86, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(87, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(88, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(89, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(90, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(91, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(92, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(93, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(94, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(95, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(96, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(97, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(98, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(99, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(100, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(101, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(102, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(103, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(104, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(105, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(106, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(107, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(108, '', '2020-04-01 13:59:30', 'I', '', '3.00'),
(109, '', '2020-04-01 13:59:30', 'I', '', '3.00');

-- --------------------------------------------------------

--
-- Table structure for table `logsrondaextra`
--

CREATE TABLE `logsrondaextra` (
  `ID` int(11) NOT NULL,
  `UserID` varchar(50) NOT NULL,
  `Data` timestamp NOT NULL DEFAULT current_timestamp(),
  `Operacao` varchar(6) NOT NULL,
  `ValoresAntigos` varchar(5000) NOT NULL,
  `ValoresNovos` varchar(5000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `logsrondaextra`
--

INSERT INTO `logsrondaextra` (`ID`, `UserID`, `Data`, `Operacao`, `ValoresAntigos`, `ValoresNovos`) VALUES
(1, 'beatriz.isa2@hotmail.com', '2020-03-29 00:52:43', 'I', '', 'beatriz.isa2@hotmail.com|2020-03-29 00:52:43'),
(2, 'zeca@hotm.com', '2020-03-29 00:54:00', 'D', 'zeca@hotm.com|0000-00-00 00:00:00', ''),
(4, 'zeca@hotm.com', '2020-03-29 14:03:37', 'I', '', 'zeca@hotm.com|2020-03-18 16:03:14'),
(5, 'biocas@hotmail.com', '2020-03-29 14:03:37', 'I', '', 'biocas@hotmail.com|2020-03-29 16:03:37'),
(6, 'beatriz.isa2@hotmail.com', '2020-04-01 10:05:23', 'I', '', 'beatriz.isa2@hotmail.com|2020-04-01 12:05:23'),
(7, 'biocas@hotmail.com', '2020-04-01 13:12:54', 'I', '', 'biocas@hotmail.com|2020-04-01 15:12:54'),
(8, 'biocas@hotmail.com', '2020-04-02 09:20:18', 'I', '', 'biocas@hotmail.com|2020-03-29 00:52:44'),
(9, 'beatriz.isa2@hotmail.com', '2020-04-02 09:22:57', 'I', '', 'beatriz.isa2@hotmail.com|2020-04-01 13:05:23'),
(10, 'biocas@hotmail.com', '2020-04-05 09:50:40', 'I', '', 'biocas@hotmail.com|2020-04-05 10:50:40'),
(11, 'henrique.branco@gmail.com', '2020-04-01 14:47:03', 'I', '', 'henrique.branco@gmail.com|2020-04-20 16:46:40'),
(12, 'henrique.branco@gmail.com', '2020-04-01 14:47:03', 'I', '', 'henrique.branco@gmail.com|2020-04-01 16:00:40'),
(13, 'henrique.branco@gmail.com', '2020-04-01 14:47:15', 'I', '', 'henrique.branco@gmail.com|2020-04-01 16:28:03'),
(14, 'henrique.branco@gmail.com', '2020-04-01 14:47:15', 'I', '', 'henrique.branco@gmail.com|2020-04-01 08:47:03'),
(15, 'henrique.branco@gmail.com', '2020-04-01 14:47:26', 'I', '', 'henrique.branco@gmail.com|2020-04-01 16:47:38'),
(16, 'henrique.branco@gmail.com', '2020-04-01 14:47:26', 'I', '', 'henrique.branco@gmail.com|2020-04-01 16:47:15'),
(17, 'henrique.branco@gmail.com', '2020-04-01 14:48:03', 'I', '', 'henrique.branco@gmail.com|2020-04-01 16:33:26'),
(18, 'henrique.branco@gmail.com', '2020-04-01 14:48:03', 'I', '', 'henrique.branco@gmail.com|2020-04-01 16:47:26'),
(19, 'henrique.branco@gmail.com', '2020-04-01 14:48:18', 'I', '', 'henrique.branco@gmail.com|2020-04-08 16:48:02'),
(20, 'blabla@gmail.com', '2020-04-01 14:48:18', 'I', '', 'blabla@gmail.com|2020-04-01 16:48:02'),
(21, 'dklfmvdfb @gmail.com', '2020-04-01 14:48:28', 'I', '', 'dklfmvdfb @gmail.com|2020-04-29 16:48:18'),
(22, 'dfjndfg@gmail.com', '2020-04-01 14:48:28', 'I', '', 'dfjndfg@gmail.com|2020-04-01 16:48:18'),
(23, 'adfndjn@gmail.com', '2020-04-01 14:48:43', 'I', '', 'adfndjn@gmail.com|2020-04-09 16:48:28'),
(24, 'henrique.branco@gmail.com', '2020-04-01 14:48:43', 'I', '', 'henrique.branco@gmail.com|2020-04-01 16:48:28'),
(27, 'henrique.branco@gmail.com', '2020-04-01 14:49:09', 'I', '', 'henrique.branco@gmail.com|2020-04-09 16:48:42'),
(28, 'beatriz.isa2@hotmail.com', '2020-04-01 14:49:09', 'I', '', 'beatriz.isa2@hotmail.com|2020-04-01 16:48:42'),
(29, 'henrique.branco@gmail.com', '2020-04-01 14:49:23', 'I', '', 'henrique.branco@gmail.com|2020-04-16 16:49:09'),
(30, 'henrique.branco@gmail.com', '2020-04-01 14:49:23', 'I', '', 'henrique.branco@gmail.com|2020-04-01 16:49:09'),
(31, 'henrique.branco@gmail.com', '2020-04-01 14:49:44', 'I', '', 'henrique.branco@gmail.com|2020-04-01 15:49:44'),
(32, 'henrique.branco@gmail.com', '2020-04-01 14:49:44', 'I', '', 'henrique.branco@gmail.com|2020-04-01 12:49:23'),
(33, 'henrique.branco@gmail.com', '2020-04-01 14:49:48', 'I', '', 'henrique.branco@gmail.com|2020-04-01 15:49:48'),
(34, 'henrique.branco@gmail.com', '2020-04-01 14:49:51', 'I', '', 'henrique.branco@gmail.com|2020-04-01 15:49:51'),
(35, 'henrique.branco@gmail.com', '2020-04-01 14:49:54', 'I', '', 'henrique.branco@gmail.com|2020-04-01 15:49:54'),
(36, 'henrique.branco@gmail.com', '2020-04-01 14:49:56', 'I', '', 'henrique.branco@gmail.com|2020-04-01 15:49:56'),
(37, 'henrique.branco@gmail.com', '2020-04-01 14:49:59', 'I', '', 'henrique.branco@gmail.com|2020-04-01 15:49:59'),
(38, 'henrique.branco@gmail.com', '2020-04-01 14:50:01', 'I', '', 'henrique.branco@gmail.com|2020-04-01 15:50:01'),
(39, 'henrique.branco@gmail.com', '2020-04-01 14:50:03', 'I', '', 'henrique.branco@gmail.com|2020-04-01 15:50:03'),
(40, 'alberto.jardim@gmail.com', '2020-04-01 14:50:15', 'I', '', 'alberto.jardim@gmail.com|2020-04-01 15:50:15'),
(41, 'alberto.jardim@gmail.com', '2020-04-01 14:50:51', 'I', '', 'alberto.jardim@gmail.com|2020-04-01 15:50:51'),
(42, 'alberto.jardim@gmail.com', '2020-04-01 14:50:54', 'I', '', 'alberto.jardim@gmail.com|2020-04-01 15:50:54'),
(43, 'alberto.jardim@gmail.com', '2020-04-01 14:50:56', 'I', '', 'alberto.jardim@gmail.com|2020-04-01 15:50:56'),
(44, 'alberto.jardim@gmail.com', '2020-04-01 14:50:58', 'I', '', 'alberto.jardim@gmail.com|2020-04-01 15:50:58'),
(45, 'alberto.jardim@gmail.com', '2020-04-01 14:51:00', 'I', '', 'alberto.jardim@gmail.com|2020-04-01 15:51:00'),
(46, 'alberto.jardim@gmail.com', '2020-04-01 14:51:02', 'I', '', 'alberto.jardim@gmail.com|2020-04-01 15:51:02'),
(47, 'alberto.jardim@gmail.com', '2020-04-01 14:51:05', 'I', '', 'alberto.jardim@gmail.com|2020-04-01 15:51:05'),
(48, 'alberto.jardim@gmail.com', '2020-04-01 14:51:07', 'I', '', 'alberto.jardim@gmail.com|2020-04-01 15:51:07'),
(49, 'alberto.jardim@gmail.com', '2020-04-01 14:51:09', 'I', '', 'alberto.jardim@gmail.com|2020-04-01 15:51:09'),
(50, 'alberto.jardim@gmail.com', '2020-04-01 14:51:11', 'I', '', 'alberto.jardim@gmail.com|2020-04-01 15:51:11'),
(51, 'alberto.jardim@gmail.com', '2020-04-01 14:51:14', 'I', '', 'alberto.jardim@gmail.com|2020-04-01 15:51:14'),
(52, 'alberto.jardim@gmail.com', '2020-04-01 14:51:16', 'I', '', 'alberto.jardim@gmail.com|2020-04-01 15:51:16'),
(53, 'alberto.jardim@gmail.com', '2020-04-01 14:51:18', 'I', '', 'alberto.jardim@gmail.com|2020-04-01 15:51:18'),
(62, 'alberto.jardim@gmail.com', '2020-04-01 14:51:38', 'I', '', 'alberto.jardim@gmail.com|2020-04-01 15:51:38'),
(63, 'alberto.jardim@gmail.com', '2020-04-01 14:51:40', 'I', '', 'alberto.jardim@gmail.com|2020-04-01 15:51:40'),
(64, 'alberto.jardim@gmail.com', '2020-04-01 14:51:43', 'I', '', 'alberto.jardim@gmail.com|2020-04-01 15:51:43'),
(65, 'alberto.jardim@gmail.com', '2020-04-01 14:51:45', 'I', '', 'alberto.jardim@gmail.com|2020-04-01 15:51:45'),
(66, 'alberto.jardim@gmail.com', '2020-04-01 14:51:47', 'I', '', 'alberto.jardim@gmail.com|2020-04-01 15:51:47'),
(67, 'alberto.jardim@gmail.com', '2020-04-01 14:51:49', 'I', '', 'alberto.jardim@gmail.com|2020-04-01 15:51:49'),
(68, 'alberto.jardim@gmail.com', '2020-04-01 14:51:52', 'I', '', 'alberto.jardim@gmail.com|2020-04-01 15:51:52'),
(69, 'alberto.jardim@gmail.com', '2020-04-01 14:51:54', 'I', '', 'alberto.jardim@gmail.com|2020-04-01 15:51:54'),
(70, 'alberto.jardim@gmail.com', '2020-04-01 14:51:56', 'I', '', 'alberto.jardim@gmail.com|2020-04-01 15:51:56'),
(71, 'alberto.jardim@gmail.com', '2020-04-01 14:51:59', 'I', '', 'alberto.jardim@gmail.com|2020-04-01 15:51:59'),
(72, 'blabla@gmail.com', '2020-04-01 14:52:37', 'I', '', 'blabla@gmail.com|2020-04-01 15:52:37'),
(73, 'blabla@gmail.com', '2020-04-01 14:52:45', 'I', '', 'blabla@gmail.com|2020-04-01 15:52:45'),
(74, 'blabla@gmail.com', '2020-04-01 14:52:48', 'I', '', 'blabla@gmail.com|2020-04-01 15:52:48'),
(75, 'blabla@gmail.com', '2020-04-01 14:52:50', 'I', '', 'blabla@gmail.com|2020-04-01 15:52:50'),
(76, 'blabla@gmail.com', '2020-04-01 14:52:52', 'I', '', 'blabla@gmail.com|2020-04-01 15:52:52'),
(77, 'blabla@gmail.com', '2020-04-01 14:52:54', 'I', '', 'blabla@gmail.com|2020-04-01 15:52:54'),
(78, 'blabla@gmail.com', '2020-04-01 14:52:56', 'I', '', 'blabla@gmail.com|2020-04-01 15:52:56'),
(79, 'blabla@gmail.com', '2020-04-01 14:52:58', 'I', '', 'blabla@gmail.com|2020-04-01 15:52:58'),
(80, 'blabla@gmail.com', '2020-04-01 14:53:00', 'I', '', 'blabla@gmail.com|2020-04-01 15:53:00'),
(81, 'blabla@gmail.com', '2020-04-01 14:53:02', 'I', '', 'blabla@gmail.com|2020-04-01 15:53:02'),
(82, 'blabla@gmail.com', '2020-04-01 14:53:04', 'I', '', 'blabla@gmail.com|2020-04-01 15:53:04'),
(83, 'blabla@gmail.com', '2020-04-01 14:53:06', 'I', '', 'blabla@gmail.com|2020-04-01 15:53:06'),
(84, 'blabla@gmail.com', '2020-04-01 14:53:08', 'I', '', 'blabla@gmail.com|2020-04-01 15:53:08'),
(85, 'blabla@gmail.com', '2020-04-01 14:53:10', 'I', '', 'blabla@gmail.com|2020-04-01 15:53:10'),
(86, 'blabla@gmail.com', '2020-04-01 14:53:12', 'I', '', 'blabla@gmail.com|2020-04-01 15:53:12'),
(87, 'blabla@gmail.com', '2020-04-01 14:53:15', 'I', '', 'blabla@gmail.com|2020-04-01 15:53:15'),
(88, 'blabla@gmail.com', '2020-04-01 14:53:17', 'I', '', 'blabla@gmail.com|2020-04-01 15:53:17'),
(89, 'blabla@gmail.com', '2020-04-01 14:53:19', 'I', '', 'blabla@gmail.com|2020-04-01 15:53:19'),
(90, 'blabla@gmail.com', '2020-04-01 14:53:21', 'I', '', 'blabla@gmail.com|2020-04-01 15:53:21'),
(91, 'blabla@gmail.com', '2020-04-01 14:53:23', 'I', '', 'blabla@gmail.com|2020-04-01 15:53:23'),
(92, 'blabla@gmail.com', '2020-04-01 14:53:26', 'I', '', 'blabla@gmail.com|2020-04-01 15:53:26'),
(93, 'blabla@gmail.com', '2020-04-01 14:53:28', 'I', '', 'blabla@gmail.com|2020-04-01 15:53:28'),
(94, 'blabla@gmail.com', '2020-04-01 14:53:30', 'I', '', 'blabla@gmail.com|2020-04-01 15:53:30'),
(95, 'blabla@gmail.com', '2020-04-01 14:53:32', 'I', '', 'blabla@gmail.com|2020-04-01 15:53:32'),
(96, 'blabla@gmail.com', '2020-04-01 14:53:34', 'I', '', 'blabla@gmail.com|2020-04-01 15:53:34'),
(97, 'blabla@gmail.com', '2020-04-01 14:53:37', 'I', '', 'blabla@gmail.com|2020-04-01 15:53:37'),
(98, 'blabla@gmail.com', '2020-04-01 14:53:39', 'I', '', 'blabla@gmail.com|2020-04-01 15:53:39'),
(99, 'blabla@gmail.com', '2020-04-01 14:53:40', 'I', '', 'blabla@gmail.com|2020-04-01 15:53:40'),
(100, 'blabla@gmail.com', '2020-04-01 14:53:43', 'I', '', 'blabla@gmail.com|2020-04-01 15:53:43'),
(101, 'blabla@gmail.com', '2020-04-01 14:53:45', 'I', '', 'blabla@gmail.com|2020-04-01 15:53:45'),
(102, 'blabla@gmail.com', '2020-04-01 14:53:48', 'I', '', 'blabla@gmail.com|2020-04-01 15:53:48'),
(103, 'blabla@gmail.com', '2020-04-01 14:53:59', 'I', '', 'blabla@gmail.com|2020-04-01 15:53:59'),
(104, 'beatriz.isa2@hotmail.com', '2020-04-01 14:54:07', 'I', '', 'beatriz.isa2@hotmail.com|2020-04-01 15:54:07'),
(105, 'beatriz.isa2@hotmail.com', '2020-04-01 14:54:10', 'I', '', 'beatriz.isa2@hotmail.com|2020-04-01 15:54:10'),
(106, 'beatriz.isa2@hotmail.com', '2020-04-01 14:54:12', 'I', '', 'beatriz.isa2@hotmail.com|2020-04-01 15:54:12'),
(107, 'beatriz.isa2@hotmail.com', '2020-04-01 14:54:14', 'I', '', 'beatriz.isa2@hotmail.com|2020-04-01 15:54:14'),
(108, 'beatriz.isa2@hotmail.com', '2020-04-01 14:54:16', 'I', '', 'beatriz.isa2@hotmail.com|2020-04-01 15:54:16'),
(109, 'beatriz.isa2@hotmail.com', '2020-04-01 14:54:18', 'I', '', 'beatriz.isa2@hotmail.com|2020-04-01 15:54:18'),
(110, 'beatriz.isa2@hotmail.com', '2020-04-01 14:54:20', 'I', '', 'beatriz.isa2@hotmail.com|2020-04-01 15:54:20'),
(111, 'beatriz.isa2@hotmail.com', '2020-04-01 14:54:23', 'I', '', 'beatriz.isa2@hotmail.com|2020-04-01 15:54:23');

-- --------------------------------------------------------

--
-- Table structure for table `logsrondaplaneada`
--

CREATE TABLE `logsrondaplaneada` (
  `ID` int(11) NOT NULL,
  `UserID` varchar(50) NOT NULL,
  `Data` timestamp NOT NULL DEFAULT current_timestamp(),
  `Operacao` varchar(6) NOT NULL,
  `ValoresAntigos` varchar(5000) NOT NULL,
  `ValoresNovos` varchar(5000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `logsrondaplaneada`
--

INSERT INTO `logsrondaplaneada` (`ID`, `UserID`, `Data`, `Operacao`, `ValoresAntigos`, `ValoresNovos`) VALUES
(1, 'biocas@hotmail.com', '2020-03-29 00:49:21', 'U', 'zeca@hotm.com|terca|23:30:00', 'biocas@hotmail.com|quarta|23:30:00'),
(2, 'zeca@hotm.com', '2020-03-29 00:50:12', 'I', '', 'zeca@hotm.com|terca|00:49:52'),
(3, 'zeca@hotm.com', '2020-03-29 00:51:22', 'D', 'zeca@hotm.com|terca|00:49:52', ''),
(4, 'beatriz.isa2@hotmail.com', '2020-03-29 14:04:16', 'I', '', 'beatriz.isa2@hotmail.com|sabado|10:00:00'),
(5, 'beatriz.isa2@hotmail.com', '2020-03-29 16:23:13', 'I', '', 'beatriz.isa2@hotmail.com|sabado|15:30:00'),
(10, 'beatriz.isa2@hotmail.com', '2020-04-01 15:46:58', 'I', '', 'beatriz.isa2@hotmail.com|domingo|19:36:00'),
(11, 'beatriz.isa2@hotmail.com', '2020-04-01 15:46:58', 'I', '', 'beatriz.isa2@hotmail.com|quarta|15:16:00'),
(12, 'biocas@hotmail.com', '2020-04-01 15:47:34', 'I', '', 'biocas@hotmail.com|quinta|15:00:00'),
(13, 'biocas@hotmail.com', '2020-04-01 15:47:34', 'I', '', 'biocas@hotmail.com|quinta|15:15:15'),
(15, 'beatriz.isa2@hotmail.com', '2020-04-01 15:49:52', 'I', '', 'beatriz.isa2@hotmail.com|quinta|15:00:00'),
(16, 'biocas@hotmail.com', '2020-04-01 15:49:52', 'I', '', 'biocas@hotmail.com|quinta|15:15:14'),
(17, 'zeca@hotm.com', '2020-04-01 15:49:52', 'I', '', 'zeca@hotm.com|terça|17:18:00'),
(18, 'biocas@hotmail.com', '2020-04-01 15:50:20', 'I', '', 'biocas@hotmail.com|terca|19:36:01'),
(48, 'biocas@hotmail.com', '2020-04-01 15:53:54', 'I', '', 'biocas@hotmail.com|terca|19:36:20'),
(49, 'biocas@hotmail.com', '2020-04-01 15:53:54', 'I', '', 'biocas@hotmail.com|terca|19:36:02'),
(50, 'biocas@hotmail.com', '2020-04-01 15:53:54', 'I', '', 'biocas@hotmail.com|terca|19:36:04'),
(51, 'biocas@hotmail.com', '2020-04-01 15:53:54', 'I', '', 'biocas@hotmail.com|terca|19:36:05'),
(52, 'biocas@hotmail.com', '2020-04-01 15:53:54', 'I', '', 'biocas@hotmail.com|terca|19:36:06'),
(53, 'biocas@hotmail.com', '2020-04-01 15:53:54', 'I', '', 'biocas@hotmail.com|terca|19:36:07'),
(54, 'biocas@hotmail.com', '2020-04-01 15:53:54', 'I', '', 'biocas@hotmail.com|terca|19:36:08'),
(55, 'biocas@hotmail.com', '2020-04-01 15:53:54', 'I', '', 'biocas@hotmail.com|terca|19:36:09'),
(56, 'biocas@hotmail.com', '2020-04-01 15:53:54', 'I', '', 'biocas@hotmail.com|terca|19:36:10'),
(57, 'biocas@hotmail.com', '2020-04-01 15:53:54', 'I', '', 'biocas@hotmail.com|terca|19:36:11'),
(58, 'biocas@hotmail.com', '2020-04-01 15:53:54', 'I', '', 'biocas@hotmail.com|terca|19:36:12'),
(59, 'biocas@hotmail.com', '2020-04-01 15:53:54', 'I', '', 'biocas@hotmail.com|terca|19:36:13'),
(60, 'biocas@hotmail.com', '2020-04-01 15:53:54', 'I', '', 'biocas@hotmail.com|terca|19:36:17'),
(61, 'biocas@hotmail.com', '2020-04-01 15:53:54', 'I', '', 'biocas@hotmail.com|terca|19:36:18'),
(62, 'biocas@hotmail.com', '2020-04-01 15:53:54', 'I', '', 'biocas@hotmail.com|terca|19:36:19'),
(63, 'biocas@hotmail.com', '2020-04-01 15:53:54', 'I', '', 'biocas@hotmail.com|terca|19:36:22'),
(64, 'zeca@hotm.com', '2020-04-01 16:06:00', 'I', '', 'zeca@hotm.com|domingo|14:55:01'),
(65, 'zeca@hotm.com', '2020-04-01 16:06:00', 'I', '', 'zeca@hotm.com|domingo|14:55:02'),
(66, 'zeca@hotm.com', '2020-04-01 16:06:00', 'I', '', 'zeca@hotm.com|domingo|14:55:03'),
(67, 'zeca@hotm.com', '2020-04-01 16:06:00', 'I', '', 'zeca@hotm.com|domingo|14:55:04'),
(68, 'zeca@hotm.com', '2020-04-01 16:06:00', 'I', '', 'zeca@hotm.com|domingo|14:55:05'),
(69, 'zeca@hotm.com', '2020-04-01 16:06:00', 'I', '', 'zeca@hotm.com|domingo|14:55:06'),
(70, 'zeca@hotm.com', '2020-04-01 16:06:00', 'I', '', 'zeca@hotm.com|domingo|14:55:07'),
(71, 'zeca@hotm.com', '2020-04-01 16:06:00', 'I', '', 'zeca@hotm.com|domingo|14:55:08'),
(72, 'zeca@hotm.com', '2020-04-01 16:06:00', 'I', '', 'zeca@hotm.com|domingo|14:55:09'),
(73, 'zeca@hotm.com', '2020-04-01 16:06:00', 'I', '', 'zeca@hotm.com|domingo|14:55:10'),
(74, 'zeca@hotm.com', '2020-04-01 16:06:00', 'I', '', 'zeca@hotm.com|domingo|14:55:11'),
(75, 'zeca@hotm.com', '2020-04-01 16:06:00', 'I', '', 'zeca@hotm.com|domingo|14:55:12'),
(76, 'zeca@hotm.com', '2020-04-01 16:06:00', 'I', '', 'zeca@hotm.com|domingo|14:55:13'),
(77, 'zeca@hotm.com', '2020-04-01 16:06:00', 'I', '', 'zeca@hotm.com|domingo|14:55:14'),
(78, 'zeca@hotm.com', '2020-04-01 16:06:00', 'I', '', 'zeca@hotm.com|domingo|14:55:15'),
(79, 'zeca@hotm.com', '2020-04-01 16:06:00', 'I', '', 'zeca@hotm.com|domingo|14:55:16'),
(80, 'zeca@hotm.com', '2020-04-01 16:06:00', 'I', '', 'zeca@hotm.com|domingo|14:55:17'),
(81, 'zeca@hotm.com', '2020-04-01 16:06:00', 'I', '', 'zeca@hotm.com|domingo|14:55:18'),
(82, 'zeca@hotm.com', '2020-04-01 16:06:00', 'I', '', 'zeca@hotm.com|domingo|14:55:19'),
(83, 'zeca@hotm.com', '2020-04-01 16:06:00', 'I', '', 'zeca@hotm.com|domingo|14:55:20'),
(84, 'zeca@hotm.com', '2020-04-01 16:06:00', 'I', '', 'zeca@hotm.com|domingo|14:55:21'),
(85, 'zeca@hotm.com', '2020-04-01 16:06:00', 'I', '', 'zeca@hotm.com|domingo|14:55:22'),
(86, 'zeca@hotm.com', '2020-04-01 16:06:00', 'I', '', 'zeca@hotm.com|domingo|14:55:23'),
(87, 'zeca@hotm.com', '2020-04-01 16:06:00', 'I', '', 'zeca@hotm.com|domingo|14:55:24'),
(88, 'beatriz.isa2@hotmail.com', '2020-04-01 19:21:33', 'I', '', 'beatriz.isa2@hotmail.com|quinta|11:23:00'),
(89, 'beatriz.isa2@hotmail.com', '2020-04-01 19:21:33', 'I', '', 'beatriz.isa2@hotmail.com|quarta|11:23:00'),
(90, 'beatriz.isa2@hotmail.com', '2020-04-01 19:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:01'),
(91, 'beatriz.isa2@hotmail.com', '2020-04-01 19:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:02'),
(92, 'beatriz.isa2@hotmail.com', '2020-04-01 19:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:03'),
(93, 'beatriz.isa2@hotmail.com', '2020-04-01 19:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:04'),
(94, 'beatriz.isa2@hotmail.com', '2020-04-01 19:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:05'),
(95, 'beatriz.isa2@hotmail.com', '2020-04-01 19:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:06'),
(96, 'beatriz.isa2@hotmail.com', '2020-04-01 19:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:07'),
(97, 'beatriz.isa2@hotmail.com', '2020-04-01 19:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:08'),
(98, 'beatriz.isa2@hotmail.com', '2020-04-01 19:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:09'),
(99, 'beatriz.isa2@hotmail.com', '2020-04-01 19:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:10'),
(100, 'beatriz.isa2@hotmail.com', '2020-04-01 19:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:11'),
(101, 'beatriz.isa2@hotmail.com', '2020-04-01 19:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:12'),
(102, 'beatriz.isa2@hotmail.com', '2020-04-01 19:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:13'),
(103, 'beatriz.isa2@hotmail.com', '2020-04-01 19:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:15'),
(104, 'beatriz.isa2@hotmail.com', '2020-04-01 19:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:16'),
(105, 'beatriz.isa2@hotmail.com', '2020-04-01 19:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:17'),
(106, 'beatriz.isa2@hotmail.com', '2020-04-01 19:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:18'),
(107, 'beatriz.isa2@hotmail.com', '2020-04-01 19:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:19'),
(108, 'beatriz.isa2@hotmail.com', '2020-04-01 19:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:20'),
(109, 'beatriz.isa2@hotmail.com', '2020-04-01 19:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:21'),
(110, 'beatriz.isa2@hotmail.com', '2020-04-01 19:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:22'),
(111, 'beatriz.isa2@hotmail.com', '2020-04-01 19:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:23'),
(112, 'beatriz.isa2@hotmail.com', '2020-04-01 19:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:24'),
(113, 'beatriz.isa2@hotmail.com', '2020-04-01 19:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:25'),
(114, 'beatriz.isa2@hotmail.com', '2020-04-01 19:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:26'),
(115, 'beatriz.isa2@hotmail.com', '2020-04-01 19:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:27'),
(116, 'beatriz.isa2@hotmail.com', '2020-04-01 19:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:28'),
(117, 'beatriz.isa2@hotmail.com', '2020-04-01 19:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:29'),
(118, 'beatriz.isa2@hotmail.com', '2020-04-01 19:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:30'),
(119, 'beatriz.isa2@hotmail.com', '2020-04-01 19:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:31'),
(120, 'beatriz.isa2@hotmail.com', '2020-04-01 19:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:32'),
(121, 'beatriz.isa2@hotmail.com', '2020-04-01 19:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:33'),
(122, 'beatriz.isa2@hotmail.com', '2020-04-01 19:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:34'),
(123, 'beatriz.isa2@hotmail.com', '2020-04-01 19:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:35'),
(124, 'beatriz.isa2@hotmail.com', '2020-04-01 19:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:36'),
(125, 'beatriz.isa2@hotmail.com', '2020-04-01 19:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:37'),
(126, 'beatriz.isa2@hotmail.com', '2020-04-01 19:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:38'),
(127, 'beatriz.isa2@hotmail.com', '2020-04-01 19:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:39'),
(128, 'beatriz.isa2@hotmail.com', '2020-04-01 19:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:40'),
(129, 'beatriz.isa2@hotmail.com', '2020-04-01 19:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:41'),
(130, 'beatriz.isa2@hotmail.com', '2020-04-01 19:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:42'),
(131, 'beatriz.isa2@hotmail.com', '2020-04-01 19:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:43'),
(132, 'beatriz.isa2@hotmail.com', '2020-04-01 19:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:44'),
(133, 'beatriz.isa2@hotmail.com', '2020-04-01 19:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:45'),
(134, 'beatriz.isa2@hotmail.com', '2020-04-01 19:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:46');

-- --------------------------------------------------------

--
-- Table structure for table `logssistema`
--

CREATE TABLE `logssistema` (
  `ID` int(11) NOT NULL,
  `UserID` varchar(50) NOT NULL,
  `Data` timestamp NOT NULL DEFAULT current_timestamp(),
  `Operacao` varchar(6) NOT NULL,
  `ValoresAntigos` varchar(5000) NOT NULL,
  `ValoresNovos` varchar(5000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `logssistema`
--

INSERT INTO `logssistema` (`ID`, `UserID`, `Data`, `Operacao`, `ValoresAntigos`, `ValoresNovos`) VALUES
(26, '', '2020-03-29 09:17:47', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(27, '', '2020-03-29 09:18:23', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(28, '', '2020-03-29 09:18:24', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(29, '', '2020-03-29 09:18:24', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(30, '', '2020-03-29 09:18:24', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(31, '', '2020-03-29 09:18:24', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(32, '', '2020-03-29 09:22:19', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(33, '', '2020-03-29 09:22:19', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(34, '', '2020-03-29 09:22:19', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(35, '', '2020-03-29 09:22:19', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(36, '', '2020-03-29 09:22:19', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(37, '', '2020-03-29 09:26:42', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(38, '', '2020-03-29 09:26:42', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(39, '', '2020-03-29 09:26:42', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(40, '', '2020-03-29 09:26:42', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(41, '', '2020-03-29 09:26:42', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(42, '', '2020-03-29 09:28:40', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(43, '', '2020-03-29 09:28:40', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(44, '', '2020-03-29 09:28:40', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(45, '', '2020-03-29 09:29:13', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(46, '', '2020-03-29 09:29:13', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(47, '', '2020-03-29 09:29:14', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(48, '', '2020-03-29 09:29:14', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(49, '', '2020-03-29 09:29:14', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(50, '', '2020-03-29 09:29:45', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(51, '', '2020-03-29 09:29:45', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(52, '', '2020-03-29 09:29:45', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(53, '', '2020-03-29 09:29:45', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(54, '', '2020-03-29 09:29:45', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(55, '', '2020-03-29 09:34:09', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(56, '', '2020-03-29 09:34:09', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(57, '', '2020-03-29 09:34:09', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(73, '', '2020-03-29 09:42:27', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(74, '', '2020-03-29 09:43:09', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(75, '', '2020-03-29 09:43:09', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(76, '', '2020-03-29 09:43:09', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(77, '', '2020-03-29 09:43:09', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(78, '', '2020-03-29 09:43:09', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(79, '', '2020-03-29 09:53:06', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(80, '', '2020-03-29 09:53:06', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(81, '', '2020-03-29 09:53:06', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(82, '', '2020-03-29 09:53:06', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(83, '', '2020-03-29 09:53:06', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(84, '', '2020-03-29 09:53:06', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(85, '', '2020-03-29 09:53:23', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(86, '', '2020-03-29 09:53:23', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(87, '', '2020-03-29 09:53:23', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(88, '', '2020-03-29 09:53:23', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(89, '', '2020-03-29 09:53:23', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(90, '', '2020-03-29 09:58:13', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(91, '', '2020-03-29 09:58:13', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(92, '', '2020-03-29 09:58:13', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(93, '', '2020-03-29 09:58:13', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(94, '', '2020-03-29 09:58:13', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(95, '', '2020-03-29 10:02:11', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(96, '', '2020-03-29 10:02:11', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(97, '', '2020-03-29 10:02:11', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(98, '', '2020-03-29 10:02:11', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(99, '', '2020-03-29 10:02:11', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(100, '', '2020-03-29 10:02:11', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(101, '', '2020-03-29 10:02:19', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(102, '', '2020-03-29 10:02:19', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(103, '', '2020-03-29 10:02:19', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(104, '', '2020-03-29 10:02:19', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(105, '', '2020-03-29 10:02:19', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(106, '', '2020-03-29 10:07:19', 'U', '33.00|66.00|70.00|7|2|2|0|4|3', '33.00|66.00|70.00|0|2|2|0|4|3'),
(107, '', '2020-03-29 10:07:19', 'U', '33.00|66.00|70.00|0|2|2|0|4|3', '33.00|66.00|70.00|0|0|2|0|4|3'),
(108, '', '2020-03-29 10:07:19', 'U', '33.00|66.00|70.00|0|0|2|0|4|3', '33.00|66.00|70.00|0|0|0|0|4|3'),
(109, '', '2020-03-29 10:07:19', 'U', '33.00|66.00|70.00|0|0|0|0|4|3', '33.00|66.00|70.00|0|0|0|0|4|3'),
(110, '', '2020-03-29 10:07:19', 'U', '33.00|66.00|70.00|0|0|0|0|4|3', '33.00|66.00|70.00|0|0|0|0|0|3'),
(111, '', '2020-03-29 10:07:19', 'U', '33.00|66.00|70.00|0|0|0|0|0|3', '33.00|66.00|70.00|0|0|0|0|0|0'),
(112, '', '2020-03-29 10:08:59', 'U', '33.00|66.00|70.00|0|0|0|0|0|0', '33.00|66.00|70.00|7|0|0|0|0|0'),
(113, '', '2020-03-29 10:08:59', 'U', '33.00|66.00|70.00|7|0|0|0|0|0', '33.00|66.00|70.00|7|2|0|0|0|0'),
(114, '', '2020-03-29 10:08:59', 'U', '33.00|66.00|70.00|7|2|0|0|0|0', '33.00|66.00|70.00|7|2|2|0|0|0'),
(115, '', '2020-03-29 10:08:59', 'U', '33.00|66.00|70.00|7|2|2|0|0|0', '33.00|66.00|70.00|7|2|2|0|0|3'),
(116, '', '2020-03-29 10:08:59', 'U', '33.00|66.00|70.00|7|2|2|0|0|3', '33.00|66.00|70.00|7|2|2|0|4|3'),
(117, '', '2020-03-29 11:06:05', 'U', '33.00|66.00|70.00|7|2|2|0|4|3', '33.00|66.00|70.00|8|2|2|0|4|3'),
(118, '', '2020-03-29 11:07:40', 'U', '33.00|66.00|70.00|8|2|2|0|4|3', '33.00|66.00|70.00|9|2|2|0|4|3'),
(119, '', '2020-03-29 11:09:29', 'U', '33.00|66.00|70.00|9|2|2|0|4|3', '33.00|66.00|70.00|11|2|2|0|4|3'),
(120, '', '2020-03-29 11:11:25', 'U', '33.00|66.00|70.00|11|2|2|0|4|3', '33.00|66.00|70.00|13|2|2|0|4|3'),
(121, '', '2020-03-29 11:13:44', 'U', '33.00|66.00|70.00|13|2|2|0|4|3', '33.00|66.00|70.00|17|2|2|0|4|3'),
(197, '', '2020-04-05 09:48:38', 'U', '33.00|37.00|100.00|0|0|0|0|0|0', '33.00|37.00|100.00|0|0|0|0|0|0'),
(198, '', '2020-04-05 09:48:38', 'U', '33.00|37.00|100.00|0|0|0|0|0|0', '33.00|37.00|100.00|0|0|0|0|0|0'),
(199, '', '2020-04-05 09:48:38', 'U', '33.00|37.00|100.00|0|0|0|0|0|0', '33.00|37.00|100.00|0|0|0|0|0|0'),
(200, '', '2020-04-05 09:48:38', 'U', '33.00|37.00|100.00|0|0|0|0|0|0', '33.00|37.00|100.00|0|0|0|0|0|0'),
(201, '', '2020-04-05 09:48:38', 'U', '33.00|37.00|100.00|0|0|0|0|0|0', '33.00|37.00|100.00|0|0|0|0|0|0'),
(202, '', '2020-04-05 09:48:38', 'U', '33.00|37.00|100.00|0|0|0|0|0|0', '33.00|37.00|100.00|0|0|0|201|0|0'),
(203, '', '2020-04-05 09:51:25', 'U', '33.00|37.00|100.00|0|0|0|201|0|0', '33.00|37.00|100.00|38|0|0|201|0|0'),
(204, '', '2020-04-05 09:51:25', 'U', '33.00|37.00|100.00|38|0|0|201|0|0', '33.00|37.00|100.00|38|5|0|201|0|0'),
(205, '', '2020-04-05 09:51:25', 'U', '33.00|37.00|100.00|38|5|0|201|0|0', '33.00|37.00|100.00|38|5|10|201|0|0'),
(206, '', '2020-04-05 09:51:25', 'U', '33.00|37.00|100.00|38|5|10|201|0|0', '33.00|37.00|100.00|38|5|10|201|0|217'),
(216, '', '2020-04-05 10:01:05', 'U', '33.00|37.00|100.00|0|0|0|0|0|217', '33.00|37.00|100.00|0|0|0|0|0|0'),
(217, '', '2020-04-05 10:01:12', 'U', '33.00|37.00|100.00|0|0|0|0|0|0', '33.00|37.00|100.00|17|0|0|0|0|0'),
(218, '', '2020-04-05 10:01:12', 'U', '33.00|37.00|100.00|17|0|0|0|0|0', '33.00|37.00|100.00|17|10|0|0|0|0'),
(219, '', '2020-04-05 10:01:12', 'U', '33.00|37.00|100.00|17|10|0|0|0|0', '33.00|37.00|100.00|17|10|10|0|0|0'),
(220, '', '2020-04-05 10:01:12', 'U', '33.00|37.00|100.00|17|10|10|0|0|0', '33.00|37.00|100.00|17|10|10|0|0|217'),
(221, '', '2020-04-05 10:01:12', 'U', '33.00|37.00|100.00|17|10|10|0|0|217', '33.00|37.00|100.00|17|10|10|0|20|217'),
(222, '', '2020-04-05 10:01:12', 'U', '33.00|37.00|100.00|17|10|10|0|20|217', '33.00|37.00|100.00|17|10|10|221|20|217'),
(223, '', '2020-04-05 10:13:21', 'U', '33.00|37.00|100.00|17|10|10|221|20|217', '33.00|37.00|100.00|0|0|0|0|0|0'),
(230, '', '2020-04-05 10:19:44', 'U', '33.00|37.00|100.00|83|50|53|228|60|217', '33.00|37.00|100.00|0|0|0|0|0|0'),
(231, '', '2020-04-05 10:20:46', 'U', '33.00|37.00|100.00|0|0|0|0|0|0', '33.00|37.00|100.00|186|0|0|0|0|0'),
(232, '', '2020-04-05 10:20:46', 'U', '33.00|37.00|100.00|186|0|0|0|0|0', '33.00|37.00|100.00|186|109|0|0|0|0'),
(233, '', '2020-04-05 10:20:46', 'U', '33.00|37.00|100.00|186|109|0|0|0|0', '33.00|37.00|100.00|186|109|111|0|0|0'),
(234, '', '2020-04-05 10:20:46', 'U', '33.00|37.00|100.00|186|109|111|0|0|0', '33.00|37.00|100.00|186|109|111|0|0|134'),
(235, '', '2020-04-05 10:20:46', 'U', '33.00|37.00|100.00|186|109|111|0|0|134', '33.00|37.00|100.00|186|109|111|0|110|134');

-- --------------------------------------------------------

--
-- Table structure for table `logsutilizador`
--

CREATE TABLE `logsutilizador` (
  `ID` int(11) NOT NULL,
  `UserID` varchar(50) NOT NULL,
  `Data` timestamp NOT NULL DEFAULT current_timestamp(),
  `Operacao` varchar(6) NOT NULL,
  `ValoresAntigos` varchar(5000) NOT NULL,
  `ValoresNovos` varchar(5000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `logsutilizador`
--

INSERT INTO `logsutilizador` (`ID`, `UserID`, `Data`, `Operacao`, `ValoresAntigos`, `ValoresNovos`) VALUES
(1, 'biocas@hotm.com', '2020-03-27 02:25:00', 'inser', 'xxx', 'yyy'),
(2, 'a', '2020-03-29 00:22:17', 'I', '', 'a|a|a|a'),
(3, 'a', '2020-03-29 00:23:57', 'U', 'a|a|a|a', 'a|b|a|a'),
(4, 'a', '2020-03-29 00:25:42', 'D', 'a|b|a|a', ''),
(5, 'beatriz.isa2@hotmail.com', '2020-04-02 09:21:47', 'U', 'beatriz.isa2@hotmail.com|hello|segur|', 'beatriz.isa2@hotmail.com|hello|segur|rua 31'),
(6, 'joaodiogo@hotmail.com', '2020-04-02 09:41:32', 'I', '', 'joaodiogo@hotmail.com|joao|chefe|'),
(7, 'joaodiogo@hotmail.com', '2020-04-02 10:01:08', 'D', 'joaodiogo@hotmail.com|joao|chefe|', ''),
(8, 'jdjmelao10@sapo.pt', '2020-04-02 10:36:47', 'I', '', 'jdjmelao10@sapo.pt|joao||'),
(9, 'jdjmelao10@sapo.pt', '2020-04-02 10:37:43', 'D', 'jdjmelao10@sapo.pt|joao||', ''),
(15, 'biocas@hotmail.com', '2020-04-01 13:55:22', 'D', 'biocas@hotmail.com|biocas|segur|tttttttttt2', ''),
(16, 'zeca@hotm.com', '2020-04-01 13:55:24', 'D', 'zeca@hotm.com|zequinha|admin|ruaxd', ''),
(17, 'beatriz.isa2@hotmail.com', '2020-04-01 13:55:27', 'D', 'beatriz.isa2@hotmail.com|hello|segur|', ''),
(18, 'adfndjn@gmail.com', '2020-04-01 13:55:39', 'I', '', 'adfndjn@gmail.com|sldkfdn|seg|avenida ajsidnsd'),
(19, 'adlkfjsln@gmail.com', '2020-04-01 13:55:39', 'I', '', 'adlkfjsln@gmail.com|klsdfsdln|seg|avenida asihjdna'),
(20, 'grfedw', '2020-04-05 09:51:07', 'I', '', 'grfedw|fabio|Seguranca|rua btvrced'),
(21, 'adsfosndgij@gmail.com', '2020-04-01 13:55:39', 'I', '', 'adsfosndgij@gmail.com|sadfnjsadf|seg|avenida sdfojsdf'),
(22, 'alberto.jardim@gmail.com', '2020-04-01 13:55:39', 'I', '', 'alberto.jardim@gmail.com|alberto |seg|rua marinho pinto'),
(23, 'alsjfnsdj@gmail.com', '2020-04-01 13:55:39', 'I', '', 'alsjfnsdj@gmail.com|slkdfsdf|seg|avenida sdofijkd'),
(24, 'andre.miguel@gmail.com', '2020-04-01 13:55:39', 'I', '', 'andre.miguel@gmail.com|andre|seg|avenida afonso henriques'),
(25, 'aoksljfsdojn@gmail.com', '2020-04-01 13:55:39', 'I', '', 'aoksljfsdojn@gmail.com|adfkljsdf|seg|avenida sdofijsd'),
(26, 'asdfsdnj@gmail.com', '2020-04-01 13:55:39', 'I', '', 'asdfsdnj@gmail.com|oksdjfsdn|seg|sldkjnsd'),
(27, 'asojfnsdjn@gmail.com', '2020-04-01 13:55:39', 'I', '', 'asojfnsdjn@gmail.com|sdljknvsdn|seg|avenida sdifjnsd'),
(28, 'beatriz.isa2@hotmail.com', '2020-04-01 13:55:39', 'I', '', 'beatriz.isa2@hotmail.com|hello|segur|'),
(29, 'biocas@hotmail.com', '2020-04-01 13:55:39', 'I', '', 'biocas@hotmail.com|biocas|segur|tttttttttt2'),
(30, 'blabla@gmail.com', '2020-04-01 13:55:39', 'I', '', 'blabla@gmail.com|blabla|seg|rua da t'),
(31, 'dfjndfg@gmail.com', '2020-04-01 13:55:39', 'I', '', 'dfjndfg@gmail.com|kdfjfnjno|seg|rua dfklvmdfbv'),
(32, 'dfljnnji@gmail.com', '2020-04-01 13:55:39', 'I', '', 'dfljnnji@gmail.com|wlkefn|seg|avenida sdofjidfv'),
(33, 'diogo@gmail.com', '2020-04-01 13:55:39', 'I', '', 'diogo@gmail.com|Diogo|seg|rua ttt'),
(34, 'djfvoskf@gmail.com', '2020-04-01 13:55:39', 'I', '', 'djfvoskf@gmail.com|ksdlnvsdofjn|seg|avenida sdojsd'),
(35, 'djknsdv@gmail.com', '2020-04-01 13:55:39', 'I', '', 'djknsdv@gmail.com|klsdfmsdlkf|seg|kdslsdfk'),
(36, 'dklfmvdfb @gmail.com', '2020-04-01 13:55:39', 'I', '', 'dklfmvdfb @gmail.com|dflknvdf |seg|avenida skldfb'),
(37, 'dksdl@gmail.com', '2020-04-01 13:55:39', 'I', '', 'dksdl@gmail.com|klsdvdsk|seg|avenida sdofij'),
(38, 'dofnsdfonj@gmail.com', '2020-04-01 13:55:39', 'I', '', 'dofnsdfonj@gmail.com|lknsdskdfn|seg|avenida dofjsv'),
(39, 'dsvndfbihj@gmail.com', '2020-04-01 13:55:39', 'I', '', 'dsvndfbihj@gmail.com|ojnvcdfs|seg|avenida sdojlf'),
(40, 'dvjnskjfn@gmail.com', '2020-04-01 13:55:39', 'I', '', 'dvjnskjfn@gmail.com|kjlsdvnsdn|seg|avenida sdokjsd'),
(41, 'dwoifjfoj@gmail.com', '2020-04-01 13:55:39', 'I', '', 'dwoifjfoj@gmail.com|sdoifjodn|seg|avenida sdifojd'),
(42, 'efifnjgn@gmail.com', '2020-04-01 13:55:39', 'I', '', 'efifnjgn@gmail.com|fgnfjn|seg|rua sijfnvkdfk'),
(43, 'Eliseu@gmail.com', '2020-04-01 13:55:39', 'I', '', 'Eliseu@gmail.com|Eliseu|seg|rua manuel jose'),
(44, 'fbdfgbijn@gmail.com', '2020-04-01 13:55:39', 'I', '', 'fbdfgbijn@gmail.com|dlnvfgn|seg|avenida dskfsfv'),
(45, 'fdlvdfngrwifj@gmail.com', '2020-04-01 13:55:39', 'I', '', 'fdlvdfngrwifj@gmail.com|dkvdlfn|seg|avenida sdijnfkvkjn'),
(51, 'jknfdwn@gmail.com', '2020-04-01 13:55:39', 'I', '', 'jknfdwn@gmail.com|sjkdnsdfkjn|seg|avenida aisfjnsd'),
(52, 'joao.mau@gmail.com', '2020-04-01 13:55:39', 'I', '', 'joao.mau@gmail.com|joao|seg|rua das varandas'),
(53, 'jose.maria@gmail.com', '2020-04-01 13:55:39', 'I', '', 'jose.maria@gmail.com|jose|seg|rua do pontal'),
(54, 'kdnvdlfn@gmail.com', '2020-04-01 13:55:39', 'I', '', 'kdnvdlfn@gmail.com|kldnvdfjnlg|seg|rua fgojndfbjv'),
(55, 'kldfvfdn@gmail.com', '2020-04-01 13:55:39', 'I', '', 'kldfvfdn@gmail.com|lkndfgn|seg|avenida ksdfsd'),
(56, 'kldfvn@gmail.com', '2020-04-01 13:55:39', 'I', '', 'kldfvn@gmail.com|lkdnsvsd|seg|rua sdkvldfoj'),
(57, 'klmsdfvk@gmail.com', '2020-04-01 13:55:39', 'I', '', 'klmsdfvk@gmail.com|fdklndfbln|seg|avenida dfbdfvnkj'),
(58, 'klsdvn@gmail.com', '2020-04-01 13:55:39', 'I', '', 'klsdvn@gmail.com|kdlvdfbnv|seg|avenida sdvojnsdv'),
(59, 'luis.jesus@gmail.com', '2020-04-01 13:55:39', 'I', '', 'luis.jesus@gmail.com|luis|seg|rua palmela'),
(60, 'manuel@gmail.com', '2020-04-01 13:55:39', 'I', '', 'manuel@gmail.com|manuel|chefS|rua pal'),
(61, 'marco.reis@gmail.com', '2020-04-01 13:55:39', 'I', '', 'marco.reis@gmail.com|marco|seg|rua primeiro de maio'),
(62, 'mariana.martins@gmail.com', '2020-04-01 13:55:39', 'I', '', 'mariana.martins@gmail.com|mariana|chefS|rua da oura'),
(63, 'mario@gmail.com', '2020-04-01 13:55:39', 'I', '', 'mario@gmail.com|Mario|seg|rua palmena'),
(64, 'masqdfjiv@gmail.com', '2020-04-01 13:55:39', 'I', '', 'masqdfjiv@gmail.com|amsoque|seg|avenida sdfonsdj'),
(65, 'miguel.alberto@gmail.com', '2020-04-01 13:55:39', 'I', '', 'miguel.alberto@gmail.com|miguel|seg|rua da favela'),
(66, 'net@gmail.com', '2020-04-01 13:55:39', 'I', '', 'net@gmail.com|net|seg|rua da internet'),
(67, 'nuno.branco@gmail.com', '2020-04-01 13:55:39', 'I', '', 'nuno.branco@gmail.com|nuno|seg|rua d henrique'),
(68, 'nuno@gmail.com', '2020-04-01 13:55:39', 'I', '', 'nuno@gmail.com|nuno|seg|rua mario crespim'),
(69, 'odnfgefi@gmail.com', '2020-04-01 13:55:39', 'I', '', 'odnfgefi@gmail.com|oidfggfn|seg|avenida svoijfb'),
(70, 'ofgnebib@gmail.com', '2020-04-01 13:55:39', 'I', '', 'ofgnebib@gmail.com|dsofnuefbin|seg|avenida fdljeobi'),
(71, 'oidvsdnf@gmail.com', '2020-04-01 13:55:39', 'I', '', 'oidvsdnf@gmail.com|oijfwojnf|seg|avenida sdofijsfv'),
(72, 'ojnfgdji@gmail.com', '2020-04-01 13:55:39', 'I', '', 'ojnfgdji@gmail.com|oenfgevn|seg|avenida sfvoijfb'),
(73, 'okdjfglnfe@gmail.com', '2020-04-01 13:55:39', 'I', '', 'okdjfglnfe@gmail.com|oskdfjfn|seg|avenida sdisvjnk'),
(74, 'oskdnvdfjnv@gmail.com', '2020-04-01 13:55:39', 'I', '', 'oskdnvdfjnv@gmail.com|klsdflwkjfn|seg|rua fvokjsfjkd'),
(75, 'qeprokwefop@gmail.com', '2020-04-01 13:55:39', 'I', '', 'qeprokwefop@gmail.com|slnffdlnvdfbv|seg|dkdfbvnldv kn'),
(76, 'rara@gmail.com', '2020-04-01 13:55:39', 'I', '', 'rara@gmail.com|rara|admin|rua pararara'),
(77, 'sadofjsd@gmail.com', '2020-04-01 13:55:39', 'I', '', 'sadofjsd@gmail.com|skdlnfsd|seg|avenida sdvojsdkj'),
(78, 'sdfjdkf@gmail.com', '2020-04-01 13:55:39', 'I', '', 'sdfjdkf@gmail.com|sdofksdkf|seg|avenida sdovkds'),
(79, 'sdfjrofnweu@gmail.com', '2020-04-01 13:55:39', 'I', '', 'sdfjrofnweu@gmail.com|skdfsdkjf|seg|rua wrvdkfvoe'),
(80, 'sdfjsd@gmail.com', '2020-04-01 13:55:39', 'I', '', 'sdfjsd@gmail.com|klsdfdsjln|seg|avenida sdofij'),
(81, 'sdfknsdn@gmail.com', '2020-04-01 13:55:39', 'I', '', 'sdfknsdn@gmail.com|dkljvfdn|seg|avenida sdfkjnsd'),
(82, 'sdflkdfn@gmail.com', '2020-04-01 13:55:39', 'I', '', 'sdflkdfn@gmail.com|oksdfldsk|seg|avenida sdifjsdv'),
(83, 'sdfogifd@gmail.com', '2020-04-01 13:55:39', 'I', '', 'sdfogifd@gmail.com|ojnfdgen|seg|avenida sdvoifjv'),
(84, 'sdfsggoui@gmail.com', '2020-04-01 13:55:39', 'I', '', 'sdfsggoui@gmail.com|sdjdsfldf|seg|avenida fojvfkn'),
(85, 'sdjknfsd@gmail.com', '2020-04-01 13:55:39', 'I', '', 'sdjknfsd@gmail.com|sldnvsd|seg|sdnlskdf'),
(86, 'sdjndn@gmail.com', '2020-04-01 13:55:39', 'I', '', 'sdjndn@gmail.com|sdnvsdvnkj|seg|avenida afojksd'),
(87, 'sdjnsfvjn@gmail.com', '2020-04-01 13:55:39', 'I', '', 'sdjnsfvjn@gmail.com|jknefgfn|seg|avenida sdknjkdfvjn'),
(88, 'sdkfljsdf@gmail.com', '2020-04-01 13:55:39', 'I', '', 'sdkfljsdf@gmail.com|sdjlkfnsd|seg|avenida oijfsdlk'),
(89, 'sdklfjsdlk@gmail.com', '2020-04-01 13:55:39', 'I', '', 'sdklfjsdlk@gmail.com|klsdfdskflj|seg|avenida ajodfkl'),
(90, 'sdkljfsdn@gmail.com', '2020-04-01 13:55:39', 'I', '', 'sdkljfsdn@gmail.com|klsdfdsn|seg|avenida aifojsd'),
(91, 'sdklnsd@gmail.com', '2020-04-01 13:55:39', 'I', '', 'sdklnsd@gmail.com|sdokfljsd|seg|rua svoknsd'),
(92, 'sdknfsd@gmail.com', '2020-04-01 13:55:39', 'I', '', 'sdknfsd@gmail.com|sdojnfsdfjn|seg|avenida sdfojdf'),
(93, 'sdnfsd@gmail.com', '2020-04-01 13:55:39', 'I', '', 'sdnfsd@gmail.com|sdlfnsdn|seg|avenida dofijsd'),
(94, 'sdofnfgwe0i@gmail.com', '2020-04-01 13:55:39', 'I', '', 'sdofnfgwe0i@gmail.com|sdlnsdf |seg|avenida sdfojisdn'),
(95, 'sdojfsdjn@gmail.com', '2020-04-01 13:55:39', 'I', '', 'sdojfsdjn@gmail.com|dfkldfln|seg|avenida adfojdf'),
(96, 'simao.pereira@gmail.com', '2020-04-01 13:55:39', 'I', '', 'simao.pereira@gmail.com|Simao|seg|rua primeiro de maio'),
(97, 'sjkfndfb@gmail.com', '2020-04-01 13:55:39', 'I', '', 'sjkfndfb@gmail.com|nsdijvdfn|seg|avenida nsdnfvj'),
(98, 'sjnvdfone@gmail.com', '2020-04-01 13:55:39', 'I', '', 'sjnvdfone@gmail.com|djkvndf|seg|avenida dvkjfoj'),
(99, 'skdfln@gmail.com', '2020-04-01 13:55:39', 'I', '', 'skdfln@gmail.com|okdfksnf|seg|avenida sdfijnsfvi'),
(100, 'skdfosfjo9@gmail.com', '2020-04-01 13:55:39', 'I', '', 'skdfosfjo9@gmail.com|nwefsjdvn|seg|avenida wodfsdvnj'),
(101, 'skdjnsfij@gmail.com', '2020-04-01 13:55:39', 'I', '', 'skdjnsfij@gmail.com|skldnsdfn|seg|avenida sdfijlk'),
(102, 'skldnfsdfn@gmail.com', '2020-04-01 13:55:39', 'I', '', 'skldnfsdfn@gmail.com|jsndvsdf |seg|avenida sdvijdfj'),
(103, 'skldsdfkjl@gmail.com', '2020-04-01 13:55:39', 'I', '', 'skldsdfkjl@gmail.com|sdkfjsdf|seg|avenida aijfksd'),
(104, 'sldjkfnsd@gmail.com', '2020-04-01 13:55:39', 'I', '', 'sldjkfnsd@gmail.com|jskdnvsdnj|seg|avenida sdifjosd'),
(105, 'sodkfjweofhweoi@gmail.com', '2020-04-01 13:55:39', 'I', '', 'sodkfjweofhweoi@gmail.com|oskdjfwfj|seg|avenida difjsdjn'),
(106, 'sodkjsdn@gmail.com', '2020-04-01 13:55:39', 'I', '', 'sodkjsdn@gmail.com|skldfnds|seg|avenida idjfksd'),
(107, 'sodknvsd@gmail.com', '2020-04-01 13:55:39', 'I', '', 'sodknvsd@gmail.com|lkcvnsdfv|seg|rua sdojkojn'),
(108, 'teresa@gmail.com', '2020-04-01 13:55:39', 'I', '', 'teresa@gmail.com|teresa|admin|rua bloura'),
(109, 'triangulo@gmail.com', '2020-04-01 13:55:39', 'I', '', 'triangulo@gmail.com|triangulo|seg|avenida sesimbra'),
(110, 'vldkfnb@gmail.com', '2020-04-01 13:55:39', 'I', '', 'vldkfnb@gmail.com|dfovçjdfbn|seg|avenida sdlvkdjfv');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `logsdiasemana`
--
ALTER TABLE `logsdiasemana`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `logsmedicoessensores`
--
ALTER TABLE `logsmedicoessensores`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `logsrondaextra`
--
ALTER TABLE `logsrondaextra`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `logsrondaplaneada`
--
ALTER TABLE `logsrondaplaneada`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `logssistema`
--
ALTER TABLE `logssistema`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `logsutilizador`
--
ALTER TABLE `logsutilizador`
  ADD PRIMARY KEY (`ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
