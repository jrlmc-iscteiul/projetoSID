-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 05-Abr-2020 às 21:16
-- Versão do servidor: 10.4.11-MariaDB
-- versão do PHP: 7.4.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `mysql_main_g28`
--

DELIMITER $$
--
-- Procedimentos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `acrescentarTurno` (IN `diaTurno` VARCHAR(20), IN `horaTurno` TIME, IN `emailU` VARCHAR(100))  NO SQL
BEGIN
IF((SELECT COUNT(*) FROM diasemana WHERE diasemana.HoraRonda = horaTurno AND diasemana.DiaSemana = diaTurno) = 0) THEN
	INSERT INTO diasemana VALUES (horaTurno, diaTurno);
	INSERT INTO rondaplaneada VALUES (emailU, diaTurno, horaTurno);
    
ELSE
	INSERT INTO rondaplaneada VALUES (emailU, diaTurno, horaTurno);
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `adicionarRondaExtra` (IN `EmailUtilizador` VARCHAR(100), IN `DataeHora` TIMESTAMP)  NO SQL
BEGIN
	INSERT INTO rondaextra
	VALUES (EmailUtilizador, DataEHora);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `alterarMorada` (IN `emailDoUtilizador` VARCHAR(100), IN `morada` VARCHAR(100))  NO SQL
BEGIN
	UPDATE utilizadores SET MoradaUtilizador=morada WHERE EmailUtilizador=emailDoUtilizador;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `alterarTurno` (IN `emailDoUtilizador` VARCHAR(100), IN `diaInicial` VARCHAR(20), IN `horaInicial` TIME, IN `novoEmail` VARCHAR(100), IN `novoDia` VARCHAR(20), IN `novaHora` TIME)  NO SQL
BEGIN
	UPDATE rondaplaneada
    SET 
    rondaplaneada.EmailUtilizador= CASE WHEN novoEmail !="" then novoEmail else rondaplaneada.EmailUtilizador END, 
    rondaplaneada.DiaSemana= CASE WHEN novoDia !="" then novoDia else rondaplaneada.DiaSemana END, 
    rondaplaneada.HoraRonda= CASE WHEN novaHora !="" then novaHora else rondaplaneada.HoraRonda END
    WHERE EmailUtilizador=emailDoUtilizador AND DiaSemana=diaInicial AND HoraRonda=horaInicial;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `consultarUtilizador` ()  NO SQL
    SQL SECURITY INVOKER
BEGIN
	DECLARE str VARCHAR(10); SET str = (SELECT SUBSTRING_INDEX(CURRENT_USER, '@', 1));
    
    IF ((SELECT tipoUtilizador FROM utilizadores WHERE str = SUBSTRING_INDEX(EmailUtilizador, '@', 1)) = 'Seguranca') THEN
    	SELECT * FROM utilizadores WHERE str = SUBSTRING_INDEX(EmailUtilizador, '@', 1);
    ELSE
    	SELECT * FROM utilizadores;
    END IF;
    
    IF ( str = 'root' ) THEN 
    	INSERT INTO logsutilizador VALUES (NULL, 'Root', NOW(), 'Select', NULL, NULL);
    ELSE
    	CALL insertLogs(str);
     END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `criarUtilizador` (IN `emailDoUtilizador` VARCHAR(100), IN `NomeUtilizador` VARCHAR(200), IN `TipoUtilizador` ENUM('Administrador','ChefeSeguranca','Seguranca','DiretorMuseu'), IN `MoradaUtilizador` VARCHAR(100), IN `pass` VARCHAR(45))  NO SQL
BEGIN
	DECLARE str VARCHAR(10); SET str = (SELECT SUBSTRING_INDEX(emailDoUtilizador, '@', 1));
    
	SET @query = CONCAT('CREATE USER "', str, '" IDENTIFIED BY "', pass, '";');
    PREPARE stmt FROM @query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    
    IF ( tipoUtilizador = 'Administrador' ) THEN
    	SET @q = CONCAT('GRANT Administrador TO "', str, '";');
        PREPARE stmt FROM @q;
    	EXECUTE stmt;
        DEALLOCATE PREPARE stmt;
    	SET @query = CONCAT('SET DEFAULT ROLE Administrador FOR "', str, '";');
        PREPARE stmt FROM @query;
    	EXECUTE stmt;
    END IF;
    IF ( tipoUtilizador = 'DiretorMuseu' ) THEN
    	SET @query = CONCAT('GRANT DiretorMuseu TO "', str, '";');
        PREPARE stmt FROM @query;
    	EXECUTE stmt;
        DEALLOCATE PREPARE stmt;
        SET @q = CONCAT('SET DEFAULT ROLE DiretorMuseu FOR "', str, '";');
        PREPARE stmt FROM @q;
    	EXECUTE stmt;
    END IF;
    IF ( tipoUtilizador = 'ChefeSeguranca' ) THEN
        SET @q = CONCAT('GRANT ChefeSeguranca TO "', str, '";');
        PREPARE stmt FROM @q;
    	EXECUTE stmt;
        DEALLOCATE PREPARE stmt;
        SET @query = CONCAT('SET DEFAULT ROLE ChefeSeguranca FOR "', str, '";');
        PREPARE stmt FROM @query;
    	EXECUTE stmt;
    END IF;
    IF ( tipoUtilizador = 'Seguranca' ) THEN
    	SET @q = CONCAT('GRANT Seguranca TO "', str, '";');
        PREPARE stmt FROM @q;
    	EXECUTE stmt;
        DEALLOCATE PREPARE stmt;
    	SET @query = CONCAT('SET DEFAULT ROLE Seguranca FOR "', str, '";');
        PREPARE stmt FROM @query;
    	EXECUTE stmt;
    END IF;
    
	INSERT INTO utilizadores
	VALUES (emailDoUtilizador, NomeUtilizador, TipoUtilizador, MoradaUtilizador);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `doMigration` ()  NO SQL
BEGIN   
	CALL generateLogsFile('diaSemana');
    CALL generateLogsFile('medicoesSensores');
    CALL generateLogsFile('rondaExtra');
    CALL generateLogsFile('rondaPlaneada');
    CALL generateLogsFile('utilizadores');
    CALL generateLogsFile('sistema');
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `editarSistema` (IN `limite` ENUM('limiteTemperatura','limiteHumidade','limiteLuminosidade'), IN `valorLimite` DECIMAL(6,2))  NO SQL
BEGIN 
UPDATE sistema
SET LimiteTemperatura=IF(limite='limiteTemperatura', valorLimite, sistema.LimiteTemperatura), 
LimiteHumidade=IF(limite='limiteHumidade', valorLimite, sistema.LimiteHumidade),
LimiteLuminosidade=IF(limite='limiteLuminosidade', valorLimite, sistema.LimiteLuminosidade);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `generateLogsFile` (IN `nomeTabela` VARCHAR(50))  NO SQL
BEGIN 

    CALL getLastID(nomeTabela, @lastId); 
    SELECT @lastId; 

    IF (nomeTabela = 'diaSemana' AND LOAD_FILE('C:/Users/ASUS/Documents/logsDiaSemana.csv') IS NULL) THEN 
        SELECT * FROM logsdiasemana WHERE logsdiasemana.id > @lastId INTO OUTFILE 'C:/Users/ASUS/Documents/logsDiaSemana.csv' FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n'; 

        UPDATE sistema SET sistema.LogsDiaSemana = (SELECT MAX(id) FROM logsdiasemana);
    END IF; 

    IF (nomeTabela = 'medicoesSensores'  AND LOAD_FILE('C:/Users/ASUS/Documents/logsMedicoesSensores.csv') IS NULL) THEN 
        SELECT * FROM logsmedicoessensores WHERE logsmedicoessensores.id > @lastId INTO OUTFILE 'C:/Users/ASUS/Documents/logsMedicoesSensores.csv' FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n'; 

        UPDATE sistema SET sistema.LogsMedicoesSensores = (SELECT MAX(id) FROM logsmedicoessensores);
    END IF; 

    IF (nomeTabela = 'rondaExtra' AND LOAD_FILE('C:/Users/ASUS/Documents/logsRondaExtra.csv') IS NULL) THEN 
        SELECT * FROM logsrondaextra WHERE logsrondaextra.id > @lastId INTO OUTFILE 'C:/Users/ASUS/Documents/logsRondaExtra.csv' FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n';  

        UPDATE sistema SET sistema.LogsRondaExtra = (SELECT MAX(id) FROM logsrondaextra);
    END IF; 

    IF (nomeTabela = 'utilizadores'  AND LOAD_FILE('C:/Users/ASUS/Documents/logsUtilizador.csv') IS NULL) THEN 
        SELECT * FROM logsutilizador WHERE logsutilizador.id > @lastId INTO OUTFILE 'C:/Users/ASUS/Documents/logsUtilizador.csv' FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n'; 

        UPDATE sistema SET sistema.LogsUtilizador = (SELECT MAX(id) FROM logsutilizador);
    END IF;

    IF (nomeTabela = 'rondaPlaneada'  AND LOAD_FILE('C:/Users/ASUS/Documents/logsRondaPlaneada.csv') IS NULL) THEN 
        SELECT * FROM logsrondaplaneada WHERE logsrondaplaneada.id > @lastId INTO OUTFILE 'C:/Users/ASUS/Documents/logsRondaPlaneada.csv' FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n'; 

        UPDATE sistema SET sistema.LogsRondaPlaneada = (SELECT MAX(id) FROM logsrondaplaneada);
    END IF;

    IF (nomeTabela = 'sistema'  AND LOAD_FILE('C:/Users/ASUS/Documents/logsSistema.csv') IS NULL) THEN 
        SELECT * FROM logssistema WHERE logssistema.id > @lastId INTO OUTFILE 'C:/Users/ASUS/Documents/logsSistema.csv' FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n'; 

        CALL setLogSistemaId();
    END IF; 
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getLastID` (IN `nomeTabela` VARCHAR(50), OUT `lastId` INT)  NO SQL
BEGIN 
IF (nomeTabela = 'diaSemana') THEN 
SELECT sistema.LogsDiaSemana FROM sistema INTO lastId; 
END IF; 

IF (nomeTabela = 'medicoesSensores') THEN 
SELECT sistema.LogsMedicoesSensores FROM sistema INTO lastId; 
END IF; 

IF (nomeTabela = 'rondaExtra') THEN 
SELECT sistema.LogsRondaExtra FROM sistema INTO lastId; 
END IF;

IF (nomeTabela = 'sistema') THEN 
SELECT sistema.LogsSistema FROM sistema INTO lastId; 
END IF; 

IF (nomeTabela = 'utilizadores') THEN 
SELECT sistema.LogsUtilizador FROM sistema INTO lastId; 
END IF; 

IF (nomeTabela = 'rondaPlaneada') THEN 
SELECT sistema.LogsRondaPlaneada FROM sistema INTO lastId; 
END IF; 

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertLogs` (IN `str` VARCHAR(50))  NO SQL
BEGIN
INSERT INTO logsutilizador VALUES (NULL, (SELECT EmailUtilizador FROM utilizadores WHERE str = SUBSTRING_INDEX(EmailUtilizador, '@', 1)), NOW(), 'Select', NULL, NULL);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pesquisarLeituras` (IN `DataHoraInicial` TIMESTAMP, IN `DataHoraFinal` TIMESTAMP)  NO SQL
BEGIN
	SELECT  *  FROM medicoessensores 
	WHERE  (DataHoraMedicao BETWEEN DataHoraInicial AND DataHoraFinal);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `removerTurno` (IN `diaRonda` VARCHAR(20), IN `hora` TIME, IN `email` VARCHAR(100))  NO SQL
BEGIN
	DELETE FROM rondaplaneada where EmailUtilizador=email AND HoraRonda=hora AND DiaSemana=diaRonda;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `removerUtilizador` (IN `EmailDoUtilizador` VARCHAR(100))  NO SQL
BEGIN
	SELECT EmailUtilizador INTO @st FROM utilizadores WHERE utilizadores.EmailUtilizador = emailDoUtilizador;
   
    SET @query = CONCAT('DROP USER "', SUBSTRING_INDEX(@st, '@', 1), '";');
    PREPARE stmt FROM @query;
    EXECUTE stmt;
    DELETE FROM utilizadores where utilizadores.EmailUtilizador=emailDoUtilizador;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `setLogSistemaId` ()  NO SQL
BEGIN
    DECLARE maximoId INT;
    SET maximoId = (SELECT MAX(id) FROM logssistema);
    UPDATE sistema SET sistema.LogsSistema = maximoId;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `diasemana`
--

CREATE TABLE `diasemana` (
  `HoraRonda` time NOT NULL,
  `DiaSemana` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `diasemana`
--

INSERT INTO `diasemana` (`HoraRonda`, `DiaSemana`) VALUES
('18:18:45', 'domingo'),
('17:31:33', 'quarta'),
('22:16:00', 'quinta'),
('07:34:45', 'segunda'),
('20:00:00', 'sexta'),
('21:00:00', 'sexta'),
('15:00:00', 'terca'),
('20:13:01', 'terca');

--
-- Acionadores `diasemana`
--
DELIMITER $$
CREATE TRIGGER `After_Delete_DiaSemana` AFTER DELETE ON `diasemana` FOR EACH ROW BEGIN
DECLARE new_id INT;
INSERT INTO logsdiasemana VALUES (new_id,'' , NOW(), 'D', CONCAT(OLD.DiaSemana, '|', OLD.HoraRonda), ''); 
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `After_Insert_DiaSemana` AFTER INSERT ON `diasemana` FOR EACH ROW BEGIN
DECLARE new_id INT;
INSERT INTO logsdiasemana VALUES (new_id, '', NOW(), 'I', '', CONCAT (NEW.DiaSemana, '|', NEW.HoraRonda)); 
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `After_Update_DiaSemana` AFTER UPDATE ON `diasemana` FOR EACH ROW BEGIN
DECLARE new_id INT;
INSERT INTO logsdiasemana VALUES (new_id, '', NOW(), 'U', CONCAT(OLD.DiaSemana, '|', OLD.HoraRonda), CONCAT(NEW.DiaSemana, '|', NEW.HoraRonda)); 
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `logsdiasemana`
--

CREATE TABLE `logsdiasemana` (
  `ID` int(11) NOT NULL,
  `UserID` varchar(50) DEFAULT NULL,
  `Data` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `Operacao` varchar(6) NOT NULL,
  `ValoresAntigos` varchar(5000) DEFAULT NULL,
  `ValoresNovos` varchar(5000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `logsdiasemana`
--

INSERT INTO `logsdiasemana` (`ID`, `UserID`, `Data`, `Operacao`, `ValoresAntigos`, `ValoresNovos`) VALUES
(8, 'ana', '2020-03-29 12:05:39', 'i', 'hnbgvfed', 'bgfd'),
(9, '', '2020-03-29 12:07:00', 'I', '', 'domingo|20:00:00'),
(10, '', '2020-03-29 12:08:44', 'U', 'quarta|15:16:00', 'quarta|15:30:00'),
(11, '', '2020-03-29 12:08:48', 'D', 'segunda|22:22:00', ''),
(12, '', '2020-03-29 12:10:35', 'U', 'segunda|10:00:00', 'segunda|10:15:00'),
(13, '', '2020-03-29 12:10:50', 'I', '', 'sexta|10:00:00'),
(14, '', '2020-03-29 12:12:40', 'D', 'domingo|20:00:00', ''),
(15, '', '2020-03-29 12:12:56', 'I', '', '23:00:00|00:00:00'),
(16, '', '2020-03-29 12:13:04', 'D', '23:00:00|00:00:00', ''),
(17, '', '2020-03-29 12:13:20', 'I', '', 'quinta|17:00:00'),
(18, '', '2020-03-29 13:56:42', 'D', 'terca|23:30:00', ''),
(19, '', '2020-03-29 14:00:05', 'I', '', 'sabado|20:00:00'),
(20, '', '2020-03-29 14:02:14', 'I', '', 'segunda|12:00:00'),
(21, '', '2020-03-29 14:34:34', 'D', 'domingo|15:15:00', ''),
(22, '', '2020-03-29 14:42:11', 'I', '', 'sabado|21:00:00'),
(23, '', '2020-03-29 14:52:03', 'D', 'sabado|20:00:00', ''),
(24, '', '2020-03-29 17:53:02', 'D', 'quarta|15:30:00.000000', ''),
(25, '', '2020-03-29 17:53:02', 'D', 'quinta|17:00:00.000000', ''),
(26, '', '2020-03-29 17:53:02', 'D', 'sabado|21:00:00.000000', ''),
(27, '', '2020-03-29 17:53:02', 'D', 'segunda|10:15:00.000000', ''),
(28, '', '2020-03-29 17:53:02', 'D', 'segunda|12:00:00.000000', ''),
(29, '', '2020-03-29 17:53:02', 'D', 'sexta|10:00:00.000000', ''),
(30, '', '2020-04-01 14:24:25', 'I', '', 'terca|20:13:01'),
(31, '', '2020-04-01 14:24:42', 'I', '', 'terca|15:00:00'),
(32, '', '2020-04-01 16:32:18', 'I', '', 'quarta|17:31:33'),
(33, '', '2020-04-01 16:32:18', 'I', '', 'quinta|22:16:00'),
(34, '', '2020-04-01 16:35:11', 'I', '', 'domingo|18:18:45'),
(35, '', '2020-04-01 16:35:11', 'I', '', 'segunda|07:34:45'),
(36, '', '2020-04-02 11:02:37', 'I', '', 'sexta|20:00:00'),
(37, '', '2020-04-02 11:37:10', 'I', '', 'sexta|21:00:00');

-- --------------------------------------------------------

--
-- Estrutura da tabela `logsmedicoessensores`
--

CREATE TABLE `logsmedicoessensores` (
  `ID` int(11) NOT NULL,
  `UserID` varchar(50) DEFAULT NULL,
  `Data` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `Operacao` varchar(6) NOT NULL,
  `ValoresAntigos` varchar(5000) DEFAULT NULL,
  `ValoresNovos` varchar(5000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `logsmedicoessensores`
--

INSERT INTO `logsmedicoessensores` (`ID`, `UserID`, `Data`, `Operacao`, `ValoresAntigos`, `ValoresNovos`) VALUES
(1, NULL, '2020-03-29 00:54:41', 'I', NULL, '1738.00'),
(2, NULL, '2020-03-29 00:55:12', 'D', '3.00', NULL),
(3, '', '2020-03-29 15:02:58', 'I', '', '10.00'),
(4, '', '2020-03-29 15:02:58', 'I', '', '20.00');

-- --------------------------------------------------------

--
-- Estrutura da tabela `logsrondaextra`
--

CREATE TABLE `logsrondaextra` (
  `ID` int(11) NOT NULL,
  `UserID` varchar(50) DEFAULT NULL,
  `Data` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `Operacao` varchar(6) NOT NULL,
  `ValoresAntigos` varchar(5000) DEFAULT NULL,
  `ValoresNovos` varchar(5000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `logsrondaextra`
--

INSERT INTO `logsrondaextra` (`ID`, `UserID`, `Data`, `Operacao`, `ValoresAntigos`, `ValoresNovos`) VALUES
(1, 'beatriz.isa2@hotmail.com', '2020-03-29 00:52:43', 'I', NULL, 'beatriz.isa2@hotmail.com|2020-03-29 00:52:43'),
(2, 'zeca@hotm.com', '2020-03-29 00:54:00', 'D', 'zeca@hotm.com|0000-00-00 00:00:00', NULL),
(4, 'zeca@hotm.com', '2020-03-29 15:03:37', 'I', '', 'zeca@hotm.com|2020-03-18 16:03:14'),
(5, 'biocas@hotmail.com', '2020-03-29 15:03:37', 'I', '', 'biocas@hotmail.com|2020-03-29 16:03:37'),
(6, 'beatriz.isa2@hotmail.com', '2020-04-01 11:05:23', 'I', '', 'beatriz.isa2@hotmail.com|2020-04-01 12:05:23'),
(7, 'biocas@hotmail.com', '2020-04-01 14:12:54', 'I', '', 'biocas@hotmail.com|2020-04-01 15:12:54'),
(8, 'biocas@hotmail.com', '2020-04-02 10:20:18', 'I', '', 'biocas@hotmail.com|2020-03-29 00:52:44'),
(9, 'beatriz.isa2@hotmail.com', '2020-04-02 10:22:57', 'I', '', 'beatriz.isa2@hotmail.com|2020-04-01 13:05:23');

-- --------------------------------------------------------

--
-- Estrutura da tabela `logsrondaplaneada`
--

CREATE TABLE `logsrondaplaneada` (
  `ID` int(11) NOT NULL,
  `UserID` varchar(50) DEFAULT NULL,
  `Data` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `Operacao` varchar(6) NOT NULL,
  `ValoresAntigos` varchar(5000) DEFAULT NULL,
  `ValoresNovos` varchar(5000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `logsrondaplaneada`
--

INSERT INTO `logsrondaplaneada` (`ID`, `UserID`, `Data`, `Operacao`, `ValoresAntigos`, `ValoresNovos`) VALUES
(1, 'biocas@hotmail.com', '2020-03-29 00:49:21', 'U', 'zeca@hotm.com|terca|23:30:00', 'biocas@hotmail.com|quarta|23:30:00'),
(2, 'zeca@hotm.com', '2020-03-29 00:50:12', 'I', NULL, 'zeca@hotm.com|terca|00:49:52'),
(3, 'zeca@hotm.com', '2020-03-29 00:51:22', 'D', 'zeca@hotm.com|terca|00:49:52', NULL),
(4, 'beatriz.isa2@hotmail.com', '2020-03-29 15:04:16', 'I', '', 'beatriz.isa2@hotmail.com|sabado|10:00:00'),
(5, 'beatriz.isa2@hotmail.com', '2020-03-29 17:23:13', 'I', '', 'beatriz.isa2@hotmail.com|sabado|15:30:00'),
(10, 'beatriz.isa2@hotmail.com', '2020-04-01 16:46:58', 'I', '', 'beatriz.isa2@hotmail.com|domingo|19:36:00'),
(11, 'beatriz.isa2@hotmail.com', '2020-04-01 16:46:58', 'I', '', 'beatriz.isa2@hotmail.com|quarta|15:16:00'),
(12, 'biocas@hotmail.com', '2020-04-01 16:47:34', 'I', '', 'biocas@hotmail.com|quinta|15:00:00'),
(13, 'biocas@hotmail.com', '2020-04-01 16:47:34', 'I', '', 'biocas@hotmail.com|quinta|15:15:15'),
(15, 'beatriz.isa2@hotmail.com', '2020-04-01 16:49:52', 'I', '', 'beatriz.isa2@hotmail.com|quinta|15:00:00'),
(16, 'biocas@hotmail.com', '2020-04-01 16:49:52', 'I', '', 'biocas@hotmail.com|quinta|15:15:14'),
(17, 'zeca@hotm.com', '2020-04-01 16:49:52', 'I', '', 'zeca@hotm.com|terça|17:18:00'),
(18, 'biocas@hotmail.com', '2020-04-01 16:50:20', 'I', '', 'biocas@hotmail.com|terca|19:36:01'),
(48, 'biocas@hotmail.com', '2020-04-01 16:53:54', 'I', '', 'biocas@hotmail.com|terca|19:36:20'),
(49, 'biocas@hotmail.com', '2020-04-01 16:53:54', 'I', '', 'biocas@hotmail.com|terca|19:36:02'),
(50, 'biocas@hotmail.com', '2020-04-01 16:53:54', 'I', '', 'biocas@hotmail.com|terca|19:36:04'),
(51, 'biocas@hotmail.com', '2020-04-01 16:53:54', 'I', '', 'biocas@hotmail.com|terca|19:36:05'),
(52, 'biocas@hotmail.com', '2020-04-01 16:53:54', 'I', '', 'biocas@hotmail.com|terca|19:36:06'),
(53, 'biocas@hotmail.com', '2020-04-01 16:53:54', 'I', '', 'biocas@hotmail.com|terca|19:36:07'),
(54, 'biocas@hotmail.com', '2020-04-01 16:53:54', 'I', '', 'biocas@hotmail.com|terca|19:36:08'),
(55, 'biocas@hotmail.com', '2020-04-01 16:53:54', 'I', '', 'biocas@hotmail.com|terca|19:36:09'),
(56, 'biocas@hotmail.com', '2020-04-01 16:53:54', 'I', '', 'biocas@hotmail.com|terca|19:36:10'),
(57, 'biocas@hotmail.com', '2020-04-01 16:53:54', 'I', '', 'biocas@hotmail.com|terca|19:36:11'),
(58, 'biocas@hotmail.com', '2020-04-01 16:53:54', 'I', '', 'biocas@hotmail.com|terca|19:36:12'),
(59, 'biocas@hotmail.com', '2020-04-01 16:53:54', 'I', '', 'biocas@hotmail.com|terca|19:36:13'),
(60, 'biocas@hotmail.com', '2020-04-01 16:53:54', 'I', '', 'biocas@hotmail.com|terca|19:36:17'),
(61, 'biocas@hotmail.com', '2020-04-01 16:53:54', 'I', '', 'biocas@hotmail.com|terca|19:36:18'),
(62, 'biocas@hotmail.com', '2020-04-01 16:53:54', 'I', '', 'biocas@hotmail.com|terca|19:36:19'),
(63, 'biocas@hotmail.com', '2020-04-01 16:53:54', 'I', '', 'biocas@hotmail.com|terca|19:36:22'),
(64, 'zeca@hotm.com', '2020-04-01 17:06:00', 'I', '', 'zeca@hotm.com|domingo|14:55:01'),
(65, 'zeca@hotm.com', '2020-04-01 17:06:00', 'I', '', 'zeca@hotm.com|domingo|14:55:02'),
(66, 'zeca@hotm.com', '2020-04-01 17:06:00', 'I', '', 'zeca@hotm.com|domingo|14:55:03'),
(67, 'zeca@hotm.com', '2020-04-01 17:06:00', 'I', '', 'zeca@hotm.com|domingo|14:55:04'),
(68, 'zeca@hotm.com', '2020-04-01 17:06:00', 'I', '', 'zeca@hotm.com|domingo|14:55:05'),
(69, 'zeca@hotm.com', '2020-04-01 17:06:00', 'I', '', 'zeca@hotm.com|domingo|14:55:06'),
(70, 'zeca@hotm.com', '2020-04-01 17:06:00', 'I', '', 'zeca@hotm.com|domingo|14:55:07'),
(71, 'zeca@hotm.com', '2020-04-01 17:06:00', 'I', '', 'zeca@hotm.com|domingo|14:55:08'),
(72, 'zeca@hotm.com', '2020-04-01 17:06:00', 'I', '', 'zeca@hotm.com|domingo|14:55:09'),
(73, 'zeca@hotm.com', '2020-04-01 17:06:00', 'I', '', 'zeca@hotm.com|domingo|14:55:10'),
(74, 'zeca@hotm.com', '2020-04-01 17:06:00', 'I', '', 'zeca@hotm.com|domingo|14:55:11'),
(75, 'zeca@hotm.com', '2020-04-01 17:06:00', 'I', '', 'zeca@hotm.com|domingo|14:55:12'),
(76, 'zeca@hotm.com', '2020-04-01 17:06:00', 'I', '', 'zeca@hotm.com|domingo|14:55:13'),
(77, 'zeca@hotm.com', '2020-04-01 17:06:00', 'I', '', 'zeca@hotm.com|domingo|14:55:14'),
(78, 'zeca@hotm.com', '2020-04-01 17:06:00', 'I', '', 'zeca@hotm.com|domingo|14:55:15'),
(79, 'zeca@hotm.com', '2020-04-01 17:06:00', 'I', '', 'zeca@hotm.com|domingo|14:55:16'),
(80, 'zeca@hotm.com', '2020-04-01 17:06:00', 'I', '', 'zeca@hotm.com|domingo|14:55:17'),
(81, 'zeca@hotm.com', '2020-04-01 17:06:00', 'I', '', 'zeca@hotm.com|domingo|14:55:18'),
(82, 'zeca@hotm.com', '2020-04-01 17:06:00', 'I', '', 'zeca@hotm.com|domingo|14:55:19'),
(83, 'zeca@hotm.com', '2020-04-01 17:06:00', 'I', '', 'zeca@hotm.com|domingo|14:55:20'),
(84, 'zeca@hotm.com', '2020-04-01 17:06:00', 'I', '', 'zeca@hotm.com|domingo|14:55:21'),
(85, 'zeca@hotm.com', '2020-04-01 17:06:00', 'I', '', 'zeca@hotm.com|domingo|14:55:22'),
(86, 'zeca@hotm.com', '2020-04-01 17:06:00', 'I', '', 'zeca@hotm.com|domingo|14:55:23'),
(87, 'zeca@hotm.com', '2020-04-01 17:06:00', 'I', '', 'zeca@hotm.com|domingo|14:55:24'),
(88, 'beatriz.isa2@hotmail.com', '2020-04-01 20:21:33', 'I', '', 'beatriz.isa2@hotmail.com|quinta|11:23:00'),
(89, 'beatriz.isa2@hotmail.com', '2020-04-01 20:21:33', 'I', '', 'beatriz.isa2@hotmail.com|quarta|11:23:00'),
(90, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:01'),
(91, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:02'),
(92, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:03'),
(93, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:04'),
(94, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:05'),
(95, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:06'),
(96, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:07'),
(97, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:08'),
(98, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:09'),
(99, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:10'),
(100, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:11'),
(101, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:12'),
(102, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:13'),
(103, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:15'),
(104, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:16'),
(105, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:17'),
(106, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:18'),
(107, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:19'),
(108, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:20'),
(109, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:21'),
(110, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:22'),
(111, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:23'),
(112, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:24'),
(113, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:25'),
(114, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:26'),
(115, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:27'),
(116, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:28'),
(117, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:29'),
(118, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:30'),
(119, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:31'),
(120, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:32'),
(121, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:33'),
(122, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:34'),
(123, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:35'),
(124, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:36'),
(125, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:37'),
(126, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:38'),
(127, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:39'),
(128, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:40'),
(129, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:41'),
(130, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:42'),
(131, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:43'),
(132, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:44'),
(133, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:45'),
(134, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:46'),
(135, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:47'),
(136, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:48'),
(137, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:49'),
(138, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:50'),
(139, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:51'),
(140, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:52'),
(141, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:53'),
(142, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:54'),
(143, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:55'),
(144, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:56'),
(145, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:57'),
(146, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:58'),
(147, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:23:59'),
(148, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:24:00'),
(149, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:24:01'),
(150, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:24:02'),
(151, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:24:03'),
(152, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:24:04'),
(153, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:24:05'),
(154, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:24:06'),
(155, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:24:07'),
(156, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:24:08'),
(157, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:24:09'),
(158, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:24:10'),
(159, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:24:11'),
(160, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:24:12'),
(161, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:24:13'),
(162, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:24:14'),
(163, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:24:15'),
(164, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:24:16'),
(165, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:24:17'),
(166, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:24:18'),
(167, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:24:19'),
(168, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:24:20'),
(169, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:24:21'),
(170, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:24:22'),
(171, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:24:23'),
(172, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:24:24'),
(173, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:24:25'),
(174, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:24:26'),
(175, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:24:27'),
(176, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:24:28'),
(177, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:24:29'),
(178, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:24:30'),
(179, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:24:31'),
(180, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:24:32'),
(181, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:24:33'),
(182, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:24:34'),
(183, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:24:35'),
(184, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:24:36'),
(185, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:24:37'),
(186, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:24:38'),
(187, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:24:39'),
(188, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:24:40'),
(189, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:24:41'),
(190, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:24:42'),
(191, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:24:43'),
(192, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:24:44'),
(193, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:24:45'),
(194, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:24:46'),
(195, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:24:47'),
(196, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:24:48'),
(197, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:24:49'),
(198, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:24:50'),
(199, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:24:51'),
(200, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:24:52'),
(201, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:24:53'),
(202, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:24:54'),
(203, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:24:55'),
(204, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:24:56'),
(205, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:24:57'),
(206, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:24:58'),
(207, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:24:59'),
(208, 'beatriz.isa2@hotmail.com', '2020-04-01 20:51:35', 'I', '', 'beatriz.isa2@hotmail.com|segunda|11:25:00'),
(209, 'biocas@hotmail.com', '2020-04-02 10:33:16', 'U', 'beatriz.isa2@hotmail.com|domingo|19:36:00', 'biocas@hotmail.com|domingo |19:36:00'),
(210, 'beatriz.isa2@hotmail.com', '2020-04-02 11:00:22', 'D', 'beatriz.isa2@hotmail.com|quarta|11:23:00', ''),
(211, 'biocas@hotmail.com', '2020-04-02 11:02:37', 'I', '', 'biocas@hotmail.com|sexta|20:00:00'),
(212, 'beatriz.isa2@hotmail.com', '2020-04-02 11:03:53', 'I', '', 'beatriz.isa2@hotmail.com|sexta|20:00:00'),
(213, 'jdjmelao10@sapo.pt', '2020-04-02 11:37:10', 'I', '', 'jdjmelao10@sapo.pt|sexta|21:00:00'),
(214, 'jdjmelao10@sapo.pt', '2020-04-02 11:39:09', 'I', '', 'jdjmelao10@sapo.pt|sexta|21:00:00'),
(215, 'zeca@hotm.com', '2020-04-03 20:41:20', 'U', 'beatriz.isa2@hotmail.com|quarta|15:16:00', 'zeca@hotm.com|quarta|15:16:01'),
(216, 'beatriz.isa2@hotmail.com', '2020-04-04 11:54:28', 'U', 'beatriz.isa2@hotmail.com|quinta|11:23:00', 'beatriz.isa2@hotmail.com|sexta|11:23:00');

-- --------------------------------------------------------

--
-- Estrutura da tabela `logssistema`
--

CREATE TABLE `logssistema` (
  `ID` int(11) NOT NULL,
  `UserID` varchar(50) DEFAULT NULL,
  `Data` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `Operacao` varchar(6) NOT NULL,
  `ValoresAntigos` varchar(5000) DEFAULT NULL,
  `ValoresNovos` varchar(5000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `logssistema`
--

INSERT INTO `logssistema` (`ID`, `UserID`, `Data`, `Operacao`, `ValoresAntigos`, `ValoresNovos`) VALUES
(26, NULL, '2020-03-29 10:17:47', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(27, NULL, '2020-03-29 10:18:23', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(28, NULL, '2020-03-29 10:18:24', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(29, NULL, '2020-03-29 10:18:24', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(30, NULL, '2020-03-29 10:18:24', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(31, NULL, '2020-03-29 10:18:24', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(32, NULL, '2020-03-29 10:22:19', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(33, NULL, '2020-03-29 10:22:19', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(34, NULL, '2020-03-29 10:22:19', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(35, NULL, '2020-03-29 10:22:19', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(36, NULL, '2020-03-29 10:22:19', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(37, NULL, '2020-03-29 10:26:42', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(38, NULL, '2020-03-29 10:26:42', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(39, NULL, '2020-03-29 10:26:42', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(40, NULL, '2020-03-29 10:26:42', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(41, NULL, '2020-03-29 10:26:42', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(42, NULL, '2020-03-29 10:28:40', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(43, NULL, '2020-03-29 10:28:40', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(44, NULL, '2020-03-29 10:28:40', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(45, NULL, '2020-03-29 10:29:13', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(46, NULL, '2020-03-29 10:29:13', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(47, NULL, '2020-03-29 10:29:14', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(48, NULL, '2020-03-29 10:29:14', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(49, NULL, '2020-03-29 10:29:14', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(50, NULL, '2020-03-29 10:29:45', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(51, NULL, '2020-03-29 10:29:45', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(52, NULL, '2020-03-29 10:29:45', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(53, NULL, '2020-03-29 10:29:45', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(54, NULL, '2020-03-29 10:29:45', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(55, NULL, '2020-03-29 10:34:09', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(56, NULL, '2020-03-29 10:34:09', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(57, NULL, '2020-03-29 10:34:09', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(58, NULL, '2020-03-29 10:34:53', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(59, NULL, '2020-03-29 10:34:53', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(60, NULL, '2020-03-29 10:34:53', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(61, NULL, '2020-03-29 10:34:53', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(62, NULL, '2020-03-29 10:34:53', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(63, NULL, '2020-03-29 10:35:01', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(64, NULL, '2020-03-29 10:35:01', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(65, NULL, '2020-03-29 10:35:01', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(66, NULL, '2020-03-29 10:35:01', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(67, NULL, '2020-03-29 10:35:01', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(68, NULL, '2020-03-29 10:42:27', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(69, NULL, '2020-03-29 10:42:27', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(70, NULL, '2020-03-29 10:42:27', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(71, NULL, '2020-03-29 10:42:27', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(72, NULL, '2020-03-29 10:42:27', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(73, NULL, '2020-03-29 10:42:27', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(74, NULL, '2020-03-29 10:43:09', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(75, NULL, '2020-03-29 10:43:09', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(76, NULL, '2020-03-29 10:43:09', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(77, NULL, '2020-03-29 10:43:09', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(78, NULL, '2020-03-29 10:43:09', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(79, NULL, '2020-03-29 10:53:06', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(80, NULL, '2020-03-29 10:53:06', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(81, NULL, '2020-03-29 10:53:06', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(82, NULL, '2020-03-29 10:53:06', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(83, NULL, '2020-03-29 10:53:06', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(84, NULL, '2020-03-29 10:53:06', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(85, NULL, '2020-03-29 10:53:23', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(86, NULL, '2020-03-29 10:53:23', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(87, NULL, '2020-03-29 10:53:23', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(88, NULL, '2020-03-29 10:53:23', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(89, NULL, '2020-03-29 10:53:23', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(90, NULL, '2020-03-29 10:58:13', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(91, NULL, '2020-03-29 10:58:13', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(92, NULL, '2020-03-29 10:58:13', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(93, NULL, '2020-03-29 10:58:13', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(94, NULL, '2020-03-29 10:58:13', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(95, '', '2020-03-29 11:02:11', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(96, '', '2020-03-29 11:02:11', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(97, '', '2020-03-29 11:02:11', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(98, '', '2020-03-29 11:02:11', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(99, '', '2020-03-29 11:02:11', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(100, '', '2020-03-29 11:02:11', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(101, '', '2020-03-29 11:02:19', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(102, '', '2020-03-29 11:02:19', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(103, '', '2020-03-29 11:02:19', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(104, '', '2020-03-29 11:02:19', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(105, '', '2020-03-29 11:02:19', 'U', '33.00|66.00|70.00', '33.00|66.00|70.00'),
(106, '', '2020-03-29 11:07:19', 'U', '33.00|66.00|70.00|7|2|2|0|4|3', '33.00|66.00|70.00|0|2|2|0|4|3'),
(107, '', '2020-03-29 11:07:19', 'U', '33.00|66.00|70.00|0|2|2|0|4|3', '33.00|66.00|70.00|0|0|2|0|4|3'),
(108, '', '2020-03-29 11:07:19', 'U', '33.00|66.00|70.00|0|0|2|0|4|3', '33.00|66.00|70.00|0|0|0|0|4|3'),
(109, '', '2020-03-29 11:07:19', 'U', '33.00|66.00|70.00|0|0|0|0|4|3', '33.00|66.00|70.00|0|0|0|0|4|3'),
(110, '', '2020-03-29 11:07:19', 'U', '33.00|66.00|70.00|0|0|0|0|4|3', '33.00|66.00|70.00|0|0|0|0|0|3'),
(111, '', '2020-03-29 11:07:19', 'U', '33.00|66.00|70.00|0|0|0|0|0|3', '33.00|66.00|70.00|0|0|0|0|0|0'),
(112, '', '2020-03-29 11:08:59', 'U', '33.00|66.00|70.00|0|0|0|0|0|0', '33.00|66.00|70.00|7|0|0|0|0|0'),
(113, '', '2020-03-29 11:08:59', 'U', '33.00|66.00|70.00|7|0|0|0|0|0', '33.00|66.00|70.00|7|2|0|0|0|0'),
(114, '', '2020-03-29 11:08:59', 'U', '33.00|66.00|70.00|7|2|0|0|0|0', '33.00|66.00|70.00|7|2|2|0|0|0'),
(115, '', '2020-03-29 11:08:59', 'U', '33.00|66.00|70.00|7|2|2|0|0|0', '33.00|66.00|70.00|7|2|2|0|0|3'),
(116, '', '2020-03-29 11:08:59', 'U', '33.00|66.00|70.00|7|2|2|0|0|3', '33.00|66.00|70.00|7|2|2|0|4|3'),
(117, '', '2020-03-29 12:06:05', 'U', '33.00|66.00|70.00|7|2|2|0|4|3', '33.00|66.00|70.00|8|2|2|0|4|3'),
(118, '', '2020-03-29 12:07:40', 'U', '33.00|66.00|70.00|8|2|2|0|4|3', '33.00|66.00|70.00|9|2|2|0|4|3'),
(119, '', '2020-03-29 12:09:29', 'U', '33.00|66.00|70.00|9|2|2|0|4|3', '33.00|66.00|70.00|11|2|2|0|4|3'),
(120, '', '2020-03-29 12:11:25', 'U', '33.00|66.00|70.00|11|2|2|0|4|3', '33.00|66.00|70.00|13|2|2|0|4|3'),
(121, '', '2020-03-29 12:13:44', 'U', '33.00|66.00|70.00|13|2|2|0|4|3', '33.00|66.00|70.00|17|2|2|0|4|3'),
(122, '', '2020-03-29 13:57:02', 'U', '33.00|66.00|70.00|17|2|2|0|4|3', '33.00|66.00|70.00|18|2|2|0|4|3'),
(123, '', '2020-03-29 14:01:00', 'U', '33.00|66.00|70.00|18|2|2|0|4|3', '33.00|66.00|70.00|19|2|2|0|4|3'),
(124, '', '2020-03-29 14:02:21', 'U', '33.00|66.00|70.00|19|2|2|0|4|3', '33.00|66.00|70.00|20|2|2|0|4|3'),
(125, '', '2020-03-29 14:35:01', 'U', '33.00|66.00|70.00|20|2|2|0|4|3', '33.00|66.00|70.00|21|2|2|0|4|3'),
(126, '', '2020-03-29 14:42:41', 'U', '33.00|66.00|70.00|21|2|2|0|4|3', '33.00|66.00|70.00|22|2|2|0|4|3'),
(127, '', '2020-03-29 14:52:33', 'U', '33.00|66.00|70.00|22|2|2|0|4|3', '33.00|66.00|70.00|23|2|2|0|4|3'),
(128, '', '2020-03-29 15:02:08', 'U', '33.00|66.00|70.00|23|2|2|0|4|3', '33.00|66.00|70.00|23|2|2|0|4|3'),
(129, '', '2020-03-29 15:02:08', 'U', '33.00|66.00|70.00|23|2|2|0|4|3', '33.00|66.00|70.00|23|2|2|0|4|3'),
(130, '', '2020-03-29 15:02:08', 'U', '33.00|66.00|70.00|23|2|2|0|4|3', '33.00|66.00|70.00|23|2|2|0|4|3'),
(131, '', '2020-03-29 15:02:08', 'U', '33.00|66.00|70.00|23|2|2|0|4|3', '33.00|66.00|70.00|23|2|2|0|4|3'),
(132, '', '2020-03-29 15:02:08', 'U', '33.00|66.00|70.00|23|2|2|0|4|3', '33.00|66.00|70.00|23|2|2|0|4|3'),
(133, '', '2020-03-29 15:04:42', 'U', '33.00|66.00|70.00|23|2|2|0|4|3', '33.00|66.00|70.00|23|2|2|0|4|3'),
(134, '', '2020-03-29 15:04:42', 'U', '33.00|66.00|70.00|23|2|2|0|4|3', '33.00|66.00|70.00|23|4|2|0|4|3'),
(135, '', '2020-03-29 15:04:42', 'U', '33.00|66.00|70.00|23|4|2|0|4|3', '33.00|66.00|70.00|23|4|5|0|4|3'),
(136, '', '2020-03-29 15:04:42', 'U', '33.00|66.00|70.00|23|4|5|0|4|3', '33.00|66.00|70.00|23|4|5|0|4|4'),
(137, '', '2020-03-29 15:04:42', 'U', '33.00|66.00|70.00|23|4|5|0|4|4', '33.00|66.00|70.00|23|4|5|0|4|4'),
(138, '', '2020-03-29 15:11:24', 'U', '33.00|66.00|70.00|23|4|5|0|4|4', '33.00|66.00|70.00|23|4|5|0|4|4'),
(139, '', '2020-03-29 15:29:17', 'U', '33.00|66.00|70.00|23|4|5|0|4|4', '33.00|66.00|70.00|23|4|5|0|4|4'),
(140, '', '2020-03-29 15:29:17', 'U', '33.00|66.00|70.00|23|4|5|0|4|4', '33.00|66.00|70.00|23|4|5|0|4|4'),
(141, '', '2020-03-29 15:29:17', 'U', '33.00|66.00|70.00|23|4|5|0|4|4', '33.00|66.00|70.00|23|4|5|0|4|4'),
(142, '', '2020-03-29 15:29:17', 'U', '33.00|66.00|70.00|23|4|5|0|4|4', '33.00|66.00|70.00|23|4|5|0|4|4'),
(143, '', '2020-03-29 15:29:17', 'U', '33.00|66.00|70.00|23|4|5|0|4|4', '33.00|66.00|70.00|23|4|5|0|4|4'),
(144, '', '2020-03-29 15:34:45', 'U', '33.00|66.00|70.00|23|4|5|0|4|4', '33.00|66.00|100.00|23|4|5|0|4|4'),
(145, '', '2020-03-29 15:35:15', 'U', '33.00|66.00|100.00|23|4|5|0|4|4', '33.00|66.00|100.00|23|4|5|0|4|4'),
(146, '', '2020-03-29 15:35:15', 'U', '33.00|66.00|100.00|23|4|5|0|4|4', '33.00|66.00|100.00|23|4|5|0|4|4'),
(147, '', '2020-03-29 15:35:15', 'U', '33.00|66.00|100.00|23|4|5|0|4|4', '33.00|66.00|100.00|23|4|5|0|4|4'),
(148, '', '2020-03-29 15:35:15', 'U', '33.00|66.00|100.00|23|4|5|0|4|4', '33.00|66.00|100.00|23|4|5|0|4|4'),
(149, '', '2020-03-29 15:35:15', 'U', '33.00|66.00|100.00|23|4|5|0|4|4', '33.00|66.00|100.00|23|4|5|0|4|4'),
(150, '', '2020-03-29 15:35:54', 'U', '33.00|66.00|100.00|23|4|5|0|4|4', '33.00|66.00|100.00|23|4|5|0|4|4'),
(151, '', '2020-03-29 15:35:54', 'U', '33.00|66.00|100.00|23|4|5|0|4|4', '33.00|66.00|100.00|23|4|5|0|4|4'),
(152, '', '2020-03-29 15:35:54', 'U', '33.00|66.00|100.00|23|4|5|0|4|4', '33.00|66.00|100.00|23|4|5|0|4|4'),
(153, '', '2020-03-29 15:35:54', 'U', '33.00|66.00|100.00|23|4|5|0|4|4', '33.00|66.00|100.00|23|4|5|0|4|4'),
(154, '', '2020-03-29 15:35:54', 'U', '33.00|66.00|100.00|23|4|5|0|4|4', '33.00|66.00|100.00|23|4|5|0|4|4'),
(155, '', '2020-03-29 15:38:52', 'U', '33.00|66.00|100.00|23|4|5|0|4|4', '33.00|66.00|100.00|23|4|5|127|4|4'),
(156, '', '2020-03-29 15:39:02', 'U', '33.00|66.00|100.00|23|4|5|127|4|4', '33.00|66.00|100.00|23|4|5|137|4|4'),
(157, '', '2020-03-29 15:39:10', 'U', '33.00|66.00|100.00|23|4|5|137|4|4', '33.00|66.00|100.00|23|4|5|137|4|4'),
(158, '', '2020-03-29 15:39:10', 'U', '33.00|66.00|100.00|23|4|5|137|4|4', '33.00|66.00|100.00|23|4|5|137|4|4'),
(159, '', '2020-03-29 15:39:10', 'U', '33.00|66.00|100.00|23|4|5|137|4|4', '33.00|66.00|100.00|23|4|5|137|4|4'),
(160, '', '2020-03-29 15:39:10', 'U', '33.00|66.00|100.00|23|4|5|137|4|4', '33.00|66.00|100.00|23|4|5|137|4|4'),
(161, '', '2020-03-29 15:39:10', 'U', '33.00|66.00|100.00|23|4|5|137|4|4', '33.00|66.00|100.00|23|4|5|137|4|4'),
(162, '', '2020-03-29 16:12:17', 'U', '33.00|66.00|100.00|23|4|5|137|4|4', '33.00|66.00|100.00|23|4|5|137|4|4'),
(163, '', '2020-03-29 17:03:03', 'U', '33.00|66.00|100.00|23|4|5|137|4|4', '33.00|66.00|100.00|23|4|5|137|4|4'),
(164, '', '2020-03-29 17:03:03', 'U', '33.00|66.00|100.00|23|4|5|137|4|4', '33.00|66.00|100.00|23|4|5|137|4|4'),
(165, '', '2020-03-29 17:03:03', 'U', '33.00|66.00|100.00|23|4|5|137|4|4', '33.00|66.00|100.00|23|4|5|137|4|4'),
(166, '', '2020-03-29 17:03:03', 'U', '33.00|66.00|100.00|23|4|5|137|4|4', '33.00|66.00|100.00|23|4|5|137|4|4'),
(167, '', '2020-03-29 17:03:03', 'U', '33.00|66.00|100.00|23|4|5|137|4|4', '33.00|66.00|100.00|23|4|5|137|4|4'),
(168, '', '2020-03-29 17:03:29', 'U', '33.00|66.00|100.00|23|4|5|137|4|4', '33.00|66.00|100.00|23|4|5|137|4|4'),
(169, '', '2020-03-29 17:03:29', 'U', '33.00|66.00|100.00|23|4|5|137|4|4', '33.00|66.00|100.00|23|4|5|137|4|4'),
(170, '', '2020-03-29 17:03:29', 'U', '33.00|66.00|100.00|23|4|5|137|4|4', '33.00|66.00|100.00|23|4|5|137|4|4'),
(171, '', '2020-03-29 17:03:29', 'U', '33.00|66.00|100.00|23|4|5|137|4|4', '33.00|66.00|100.00|23|4|5|137|4|4'),
(172, '', '2020-03-29 17:03:29', 'U', '33.00|66.00|100.00|23|4|5|137|4|4', '33.00|66.00|100.00|23|4|5|137|4|4'),
(173, '', '2020-03-29 20:40:54', 'U', '33.00|66.00|100.00|23|4|5|137|4|4', '33.00|66.00|100.00|29|4|5|137|4|4'),
(174, '', '2020-03-29 20:40:54', 'U', '33.00|66.00|100.00|29|4|5|137|4|4', '33.00|66.00|100.00|29|29|5|137|4|4'),
(175, '', '2020-03-29 20:40:54', 'U', '33.00|66.00|100.00|29|29|5|137|4|4', '33.00|66.00|100.00|29|29|5|137|4|4'),
(176, '', '2020-03-29 21:22:22', 'U', '33.00|66.00|100.00|29|29|5|137|4|4', '33.00|66.00|100.00|29|29|5|137|4|4'),
(177, '', '2020-03-29 21:22:22', 'U', '33.00|66.00|100.00|29|29|5|137|4|4', '33.00|66.00|100.00|29|29|5|137|4|4'),
(178, '', '2020-03-29 21:22:22', 'U', '33.00|66.00|100.00|29|29|5|137|4|4', '33.00|66.00|100.00|29|29|5|137|4|4'),
(179, '', '2020-03-29 21:58:54', 'U', '33.00|66.00|100.00|29|29|5|137|4|4', '33.00|66.00|100.00|29|29|5|178|4|4'),
(180, '', '2020-03-29 22:02:19', 'U', '33.00|66.00|100.00|29|29|5|178|4|4', '33.00|66.00|100.00|29|29|5|178|4|4'),
(181, '', '2020-03-29 22:02:19', 'U', '33.00|66.00|100.00|29|29|5|178|4|4', '33.00|66.00|100.00|29|4|5|178|4|4'),
(182, '', '2020-03-29 22:02:19', 'U', '33.00|66.00|100.00|29|4|5|178|4|4', '33.00|66.00|100.00|29|4|5|178|4|4'),
(183, '', '2020-03-29 22:02:19', 'U', '33.00|66.00|100.00|29|4|5|178|4|4', '33.00|66.00|100.00|29|4|5|178|4|5'),
(184, '', '2020-03-29 22:02:19', 'U', '33.00|66.00|100.00|29|4|5|178|4|5', '33.00|66.00|100.00|29|4|5|178|4|5'),
(185, '', '2020-03-29 22:02:19', 'U', '33.00|66.00|100.00|29|4|5|178|4|5', '33.00|66.00|100.00|29|4|5|184|4|5'),
(186, '', '2020-03-29 22:08:43', 'U', '33.00|66.00|100.00|29|4|5|184|4|5', '33.00|66.00|100.00|29|4|5|184|4|5'),
(187, '', '2020-03-29 22:08:43', 'U', '33.00|66.00|100.00|29|4|5|184|4|5', '33.00|66.00|100.00|29|4|5|184|4|5'),
(188, '', '2020-03-29 22:08:43', 'U', '33.00|66.00|100.00|29|4|5|184|4|5', '33.00|66.00|100.00|29|4|5|184|4|5'),
(189, '', '2020-03-29 22:08:43', 'U', '33.00|66.00|100.00|29|4|5|184|4|5', '33.00|66.00|100.00|29|4|5|184|4|5'),
(190, '', '2020-03-29 22:08:43', 'U', '33.00|66.00|100.00|29|4|5|184|4|5', '33.00|66.00|100.00|29|4|5|184|4|5'),
(191, '', '2020-03-29 22:08:43', 'U', '33.00|66.00|100.00|29|4|5|184|4|5', '33.00|66.00|100.00|29|4|5|190|4|5'),
(192, '', '2020-04-02 10:52:07', 'U', '33.00|66.00|100.00|29|4|5|190|4|5', '33.00|37.00|100.00|29|4|5|190|4|5'),
(193, '', '2020-04-02 11:04:35', 'U', '33.00|37.00|100.00|29|4|5|190|4|5', '33.00|37.00|100.00|29|4|5|192|4|5'),
(194, '', '2020-04-02 11:05:37', 'U', '33.00|37.00|100.00|29|4|5|192|4|5', '33.00|37.00|100.00|29|4|5|193|4|5'),
(195, '', '2020-04-02 11:06:24', 'U', '33.00|37.00|100.00|29|4|5|193|4|5', '33.00|37.00|100.00|29|4|5|194|4|5');

-- --------------------------------------------------------

--
-- Estrutura da tabela `logsutilizador`
--

CREATE TABLE `logsutilizador` (
  `ID` int(11) NOT NULL,
  `UserID` varchar(50) NOT NULL,
  `Data` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `Operacao` varchar(6) NOT NULL,
  `ValoresAntigos` varchar(5000) DEFAULT NULL,
  `ValoresNovos` varchar(5000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `logsutilizador`
--

INSERT INTO `logsutilizador` (`ID`, `UserID`, `Data`, `Operacao`, `ValoresAntigos`, `ValoresNovos`) VALUES
(1, 'biocas@hotm.com', '2020-03-27 02:25:00', 'inser', 'xxx', 'yyy'),
(2, 'a', '2020-03-29 00:22:17', 'I', NULL, 'a|a|a|a'),
(3, 'a', '2020-03-29 00:23:57', 'U', 'a|a|a|a', 'a|b|a|a'),
(4, 'a', '2020-03-29 00:25:42', 'D', 'a|b|a|a', NULL),
(5, 'beatriz.isa2@hotmail.com', '2020-04-02 10:21:47', 'U', 'beatriz.isa2@hotmail.com|hello|segur|', 'beatriz.isa2@hotmail.com|hello|segur|rua 31'),
(6, 'joaodiogo@hotmail.com', '2020-04-02 10:41:32', 'I', NULL, 'joaodiogo@hotmail.com|joao|chefe|'),
(7, 'joaodiogo@hotmail.com', '2020-04-02 11:01:08', 'D', 'joaodiogo@hotmail.com|joao|chefe|', NULL),
(8, 'jdjmelao10@sapo.pt', '2020-04-02 11:36:47', 'I', NULL, 'jdjmelao10@sapo.pt|joao||'),
(9, 'jdjmelao10@sapo.pt', '2020-04-02 11:37:43', 'D', 'jdjmelao10@sapo.pt|joao||', NULL),
(10, 'jdjmelao10@sapo.pt', '2020-04-02 11:38:45', 'I', NULL, 'jdjmelao10@sapo.pt|joao||'),
(11, 'jdjmelao10@sapo.pt', '2020-04-02 11:39:45', 'D', 'jdjmelao10@sapo.pt|joao||', NULL),
(12, 'beatriz.isa2@hotmail.com', '2020-04-02 14:23:11', 'U', 'beatriz.isa2@hotmail.com|hello||rua 31', 'beatriz.isa2@hotmail.com|hello|Seguranca|rua 31'),
(13, 'biocas@hotmail.com', '2020-04-02 14:23:16', 'U', 'biocas@hotmail.com|biocas||tttttttttt2', 'biocas@hotmail.com|biocas|ChefeSeguranca|tttttttttt2'),
(14, 'zeca@hotm.com', '2020-04-02 14:23:22', 'U', 'zeca@hotm.com|zequinha||ruaxd', 'zeca@hotm.com|zequinha|Administrador|ruaxd'),
(15, 'ritinha@ritz.com', '2020-04-02 15:22:33', 'I', NULL, 'ritinha@ritz.com|ritz|Administrador|ritz'),
(16, 'ritinha@ritz.com', '2020-04-02 15:24:25', 'D', 'ritinha@ritz.com|ritz|Administrador|ritz', NULL),
(17, 'riti@iscte.pt', '2020-04-04 18:24:40', 'I', NULL, 'riti@iscte.pt|bibibi|Seguranca|ruaz'),
(18, 'riti@iscte.pt', '2020-04-04 18:28:10', 'D', 'riti@iscte.pt|bibibi|Seguranca|ruaz', NULL),
(19, 'Root', '2020-04-04 22:05:45', 'Select', NULL, NULL),
(20, 'Root', '2020-04-05 15:49:27', 'Select', NULL, NULL),
(21, 'lololo@123', '2020-04-05 15:51:31', 'I', NULL, 'lololo@123|123|Seguranca|13');

-- --------------------------------------------------------

--
-- Estrutura da tabela `medicoessensores`
--

CREATE TABLE `medicoessensores` (
  `IDMedicao` int(11) NOT NULL,
  `ValorMedicao` decimal(6,2) NOT NULL,
  `DataHoraMedicao` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `medicoessensores`
--

INSERT INTO `medicoessensores` (`IDMedicao`, `ValorMedicao`, `DataHoraMedicao`) VALUES
(1, '7.00', '2020-03-31 00:59:45'),
(3, '1738.00', '2020-03-29 00:54:41'),
(4, '10.00', '2020-03-29 15:02:58'),
(5, '20.00', '2020-03-29 15:02:58');

--
-- Acionadores `medicoessensores`
--
DELIMITER $$
CREATE TRIGGER `After_Delete_MedicoesSensores` AFTER DELETE ON `medicoessensores` FOR EACH ROW BEGIN
DECLARE new_id INT;
INSERT INTO logsmedicoessensores VALUES (new_id, '', NOW(), 'D', OLD.ValorMedicao, ''); 
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `After_Insert_MedicoesSensores` AFTER INSERT ON `medicoessensores` FOR EACH ROW BEGIN
DECLARE new_id INT;
INSERT INTO logsmedicoessensores VALUES (new_id, '', NOW(), 'I', '', NEW.ValorMedicao); 
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `After_Update_MedicoesSensores` AFTER UPDATE ON `medicoessensores` FOR EACH ROW BEGIN
DECLARE new_id INT;
INSERT INTO logsmedicoessensores VALUES (new_id, '', NOW(), 'U', OLD.ValorMedicao, NEW.ValorMedicao); 
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `rondaextra`
--

CREATE TABLE `rondaextra` (
  `EmailUtilizador` varchar(100) NOT NULL,
  `DataHora` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `rondaextra`
--

INSERT INTO `rondaextra` (`EmailUtilizador`, `DataHora`) VALUES
('beatriz.isa2@hotmail.com', '2020-03-29 00:52:43'),
('beatriz.isa2@hotmail.com', '2020-04-01 11:05:23'),
('beatriz.isa2@hotmail.com', '2020-04-01 12:05:23'),
('biocas@hotmail.com', '2020-03-29 00:52:44'),
('biocas@hotmail.com', '2020-03-29 15:03:37'),
('biocas@hotmail.com', '2020-04-01 14:12:54'),
('zeca@hotm.com', '1999-01-02 22:22:00'),
('zeca@hotm.com', '2020-03-18 16:03:14');

--
-- Acionadores `rondaextra`
--
DELIMITER $$
CREATE TRIGGER `After_Delete_RondaExtra` AFTER DELETE ON `rondaextra` FOR EACH ROW BEGIN
DECLARE new_id INT;
INSERT INTO logsrondaextra VALUES (new_id, OLD.emailutilizador, NOW(), 'D', CONCAT (OLD.emailutilizador, '|', OLD.DataHora), '');
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `After_Insert_RondaExtra` AFTER INSERT ON `rondaextra` FOR EACH ROW BEGIN
DECLARE new_id INT;
INSERT INTO logsrondaextra VALUES (new_id, NEW.emailutilizador, NOW(), 'I', '', CONCAT (NEW.emailutilizador, '|', NEW.DataHora));
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `After_Update_RondaExtra` AFTER UPDATE ON `rondaextra` FOR EACH ROW BEGIN
DECLARE new_id INT;
INSERT INTO logsrondaextra VALUES (new_id, new.emailutilizador, NOW(), 'U', CONCAT (OLD.emailutilizador, '|', OLD.DataHora), CONCAT (new.emailutilizador, '|', new.DataHora));
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `rondaplaneada`
--

CREATE TABLE `rondaplaneada` (
  `EmailUtilizador` varchar(100) NOT NULL,
  `DiaSemana` varchar(20) NOT NULL,
  `HoraRonda` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `rondaplaneada`
--

INSERT INTO `rondaplaneada` (`EmailUtilizador`, `DiaSemana`, `HoraRonda`) VALUES
('beatriz.isa2@hotmail.com', 'quinta', '15:00:00'),
('beatriz.isa2@hotmail.com', 'segunda', '11:23:01'),
('beatriz.isa2@hotmail.com', 'segunda', '11:23:02'),
('beatriz.isa2@hotmail.com', 'segunda', '11:23:03'),
('beatriz.isa2@hotmail.com', 'segunda', '11:23:04'),
('beatriz.isa2@hotmail.com', 'segunda', '11:23:05'),
('beatriz.isa2@hotmail.com', 'segunda', '11:23:06'),
('beatriz.isa2@hotmail.com', 'segunda', '11:23:07'),
('beatriz.isa2@hotmail.com', 'segunda', '11:23:08'),
('beatriz.isa2@hotmail.com', 'segunda', '11:23:09'),
('beatriz.isa2@hotmail.com', 'segunda', '11:23:10'),
('beatriz.isa2@hotmail.com', 'segunda', '11:23:11'),
('beatriz.isa2@hotmail.com', 'segunda', '11:23:12'),
('beatriz.isa2@hotmail.com', 'segunda', '11:23:13'),
('beatriz.isa2@hotmail.com', 'segunda', '11:23:15'),
('beatriz.isa2@hotmail.com', 'segunda', '11:23:16'),
('beatriz.isa2@hotmail.com', 'segunda', '11:23:17'),
('beatriz.isa2@hotmail.com', 'segunda', '11:23:18'),
('beatriz.isa2@hotmail.com', 'segunda', '11:23:19'),
('beatriz.isa2@hotmail.com', 'segunda', '11:23:20'),
('beatriz.isa2@hotmail.com', 'segunda', '11:23:21'),
('beatriz.isa2@hotmail.com', 'segunda', '11:23:22'),
('beatriz.isa2@hotmail.com', 'segunda', '11:23:23'),
('beatriz.isa2@hotmail.com', 'segunda', '11:23:24'),
('beatriz.isa2@hotmail.com', 'segunda', '11:23:25'),
('beatriz.isa2@hotmail.com', 'segunda', '11:23:26'),
('beatriz.isa2@hotmail.com', 'segunda', '11:23:27'),
('beatriz.isa2@hotmail.com', 'segunda', '11:23:28'),
('beatriz.isa2@hotmail.com', 'segunda', '11:23:29'),
('beatriz.isa2@hotmail.com', 'segunda', '11:23:30'),
('beatriz.isa2@hotmail.com', 'segunda', '11:23:31'),
('beatriz.isa2@hotmail.com', 'segunda', '11:23:32'),
('beatriz.isa2@hotmail.com', 'segunda', '11:23:33'),
('beatriz.isa2@hotmail.com', 'segunda', '11:23:34'),
('beatriz.isa2@hotmail.com', 'segunda', '11:23:35'),
('beatriz.isa2@hotmail.com', 'segunda', '11:23:36'),
('beatriz.isa2@hotmail.com', 'segunda', '11:23:37'),
('beatriz.isa2@hotmail.com', 'segunda', '11:23:38'),
('beatriz.isa2@hotmail.com', 'segunda', '11:23:39'),
('beatriz.isa2@hotmail.com', 'segunda', '11:23:40'),
('beatriz.isa2@hotmail.com', 'segunda', '11:23:41'),
('beatriz.isa2@hotmail.com', 'segunda', '11:23:42'),
('beatriz.isa2@hotmail.com', 'segunda', '11:23:43'),
('beatriz.isa2@hotmail.com', 'segunda', '11:23:44'),
('beatriz.isa2@hotmail.com', 'segunda', '11:23:45'),
('beatriz.isa2@hotmail.com', 'segunda', '11:23:46'),
('beatriz.isa2@hotmail.com', 'segunda', '11:23:47'),
('beatriz.isa2@hotmail.com', 'segunda', '11:23:48'),
('beatriz.isa2@hotmail.com', 'segunda', '11:23:49'),
('beatriz.isa2@hotmail.com', 'segunda', '11:23:50'),
('beatriz.isa2@hotmail.com', 'segunda', '11:23:51'),
('beatriz.isa2@hotmail.com', 'segunda', '11:23:52'),
('beatriz.isa2@hotmail.com', 'segunda', '11:23:53'),
('beatriz.isa2@hotmail.com', 'segunda', '11:23:54'),
('beatriz.isa2@hotmail.com', 'segunda', '11:23:55'),
('beatriz.isa2@hotmail.com', 'segunda', '11:23:56'),
('beatriz.isa2@hotmail.com', 'segunda', '11:23:57'),
('beatriz.isa2@hotmail.com', 'segunda', '11:23:58'),
('beatriz.isa2@hotmail.com', 'segunda', '11:23:59'),
('beatriz.isa2@hotmail.com', 'segunda', '11:24:00'),
('beatriz.isa2@hotmail.com', 'segunda', '11:24:01'),
('beatriz.isa2@hotmail.com', 'segunda', '11:24:02'),
('beatriz.isa2@hotmail.com', 'segunda', '11:24:03'),
('beatriz.isa2@hotmail.com', 'segunda', '11:24:04'),
('beatriz.isa2@hotmail.com', 'segunda', '11:24:05'),
('beatriz.isa2@hotmail.com', 'segunda', '11:24:06'),
('beatriz.isa2@hotmail.com', 'segunda', '11:24:07'),
('beatriz.isa2@hotmail.com', 'segunda', '11:24:08'),
('beatriz.isa2@hotmail.com', 'segunda', '11:24:09'),
('beatriz.isa2@hotmail.com', 'segunda', '11:24:10'),
('beatriz.isa2@hotmail.com', 'segunda', '11:24:11'),
('beatriz.isa2@hotmail.com', 'segunda', '11:24:12'),
('beatriz.isa2@hotmail.com', 'segunda', '11:24:13'),
('beatriz.isa2@hotmail.com', 'segunda', '11:24:14'),
('beatriz.isa2@hotmail.com', 'segunda', '11:24:15'),
('beatriz.isa2@hotmail.com', 'segunda', '11:24:16'),
('beatriz.isa2@hotmail.com', 'segunda', '11:24:17'),
('beatriz.isa2@hotmail.com', 'segunda', '11:24:18'),
('beatriz.isa2@hotmail.com', 'segunda', '11:24:19'),
('beatriz.isa2@hotmail.com', 'segunda', '11:24:20'),
('beatriz.isa2@hotmail.com', 'segunda', '11:24:21'),
('beatriz.isa2@hotmail.com', 'segunda', '11:24:22'),
('beatriz.isa2@hotmail.com', 'segunda', '11:24:23'),
('beatriz.isa2@hotmail.com', 'segunda', '11:24:24'),
('beatriz.isa2@hotmail.com', 'segunda', '11:24:25'),
('beatriz.isa2@hotmail.com', 'segunda', '11:24:26'),
('beatriz.isa2@hotmail.com', 'segunda', '11:24:27'),
('beatriz.isa2@hotmail.com', 'segunda', '11:24:28'),
('beatriz.isa2@hotmail.com', 'segunda', '11:24:29'),
('beatriz.isa2@hotmail.com', 'segunda', '11:24:30'),
('beatriz.isa2@hotmail.com', 'segunda', '11:24:31'),
('beatriz.isa2@hotmail.com', 'segunda', '11:24:32'),
('beatriz.isa2@hotmail.com', 'segunda', '11:24:33'),
('beatriz.isa2@hotmail.com', 'segunda', '11:24:34'),
('beatriz.isa2@hotmail.com', 'segunda', '11:24:35'),
('beatriz.isa2@hotmail.com', 'segunda', '11:24:36'),
('beatriz.isa2@hotmail.com', 'segunda', '11:24:37'),
('beatriz.isa2@hotmail.com', 'segunda', '11:24:38'),
('beatriz.isa2@hotmail.com', 'segunda', '11:24:39'),
('beatriz.isa2@hotmail.com', 'segunda', '11:24:40'),
('beatriz.isa2@hotmail.com', 'segunda', '11:24:41'),
('beatriz.isa2@hotmail.com', 'segunda', '11:24:42'),
('beatriz.isa2@hotmail.com', 'segunda', '11:24:43'),
('beatriz.isa2@hotmail.com', 'segunda', '11:24:44'),
('beatriz.isa2@hotmail.com', 'segunda', '11:24:45'),
('beatriz.isa2@hotmail.com', 'segunda', '11:24:46'),
('beatriz.isa2@hotmail.com', 'segunda', '11:24:47'),
('beatriz.isa2@hotmail.com', 'segunda', '11:24:48'),
('beatriz.isa2@hotmail.com', 'segunda', '11:24:49'),
('beatriz.isa2@hotmail.com', 'segunda', '11:24:50'),
('beatriz.isa2@hotmail.com', 'segunda', '11:24:51'),
('beatriz.isa2@hotmail.com', 'segunda', '11:24:52'),
('beatriz.isa2@hotmail.com', 'segunda', '11:24:53'),
('beatriz.isa2@hotmail.com', 'segunda', '11:24:54'),
('beatriz.isa2@hotmail.com', 'segunda', '11:24:55'),
('beatriz.isa2@hotmail.com', 'segunda', '11:24:56'),
('beatriz.isa2@hotmail.com', 'segunda', '11:24:57'),
('beatriz.isa2@hotmail.com', 'segunda', '11:24:58'),
('beatriz.isa2@hotmail.com', 'segunda', '11:24:59'),
('beatriz.isa2@hotmail.com', 'segunda', '11:25:00'),
('beatriz.isa2@hotmail.com', 'sexta', '11:23:00'),
('beatriz.isa2@hotmail.com', 'sexta', '20:00:00'),
('biocas@hotmail.com', 'domingo ', '19:36:00'),
('biocas@hotmail.com', 'quinta', '15:00:00'),
('biocas@hotmail.com', 'quinta', '15:15:14'),
('biocas@hotmail.com', 'quinta', '15:15:15'),
('biocas@hotmail.com', 'sexta', '20:00:00'),
('biocas@hotmail.com', 'terca', '19:36:01'),
('biocas@hotmail.com', 'terca', '19:36:02'),
('biocas@hotmail.com', 'terca', '19:36:04'),
('biocas@hotmail.com', 'terca', '19:36:05'),
('biocas@hotmail.com', 'terca', '19:36:06'),
('biocas@hotmail.com', 'terca', '19:36:07'),
('biocas@hotmail.com', 'terca', '19:36:08'),
('biocas@hotmail.com', 'terca', '19:36:09'),
('biocas@hotmail.com', 'terca', '19:36:10'),
('biocas@hotmail.com', 'terca', '19:36:11'),
('biocas@hotmail.com', 'terca', '19:36:12'),
('biocas@hotmail.com', 'terca', '19:36:13'),
('biocas@hotmail.com', 'terca', '19:36:17'),
('biocas@hotmail.com', 'terca', '19:36:18'),
('biocas@hotmail.com', 'terca', '19:36:19'),
('biocas@hotmail.com', 'terca', '19:36:20'),
('biocas@hotmail.com', 'terca', '19:36:22'),
('zeca@hotm.com', 'domingo', '14:55:01'),
('zeca@hotm.com', 'domingo', '14:55:02'),
('zeca@hotm.com', 'domingo', '14:55:03'),
('zeca@hotm.com', 'domingo', '14:55:04'),
('zeca@hotm.com', 'domingo', '14:55:05'),
('zeca@hotm.com', 'domingo', '14:55:06'),
('zeca@hotm.com', 'domingo', '14:55:07'),
('zeca@hotm.com', 'domingo', '14:55:08'),
('zeca@hotm.com', 'domingo', '14:55:09'),
('zeca@hotm.com', 'domingo', '14:55:10'),
('zeca@hotm.com', 'domingo', '14:55:11'),
('zeca@hotm.com', 'domingo', '14:55:12'),
('zeca@hotm.com', 'domingo', '14:55:13'),
('zeca@hotm.com', 'domingo', '14:55:14'),
('zeca@hotm.com', 'domingo', '14:55:15'),
('zeca@hotm.com', 'domingo', '14:55:16'),
('zeca@hotm.com', 'domingo', '14:55:17'),
('zeca@hotm.com', 'domingo', '14:55:18'),
('zeca@hotm.com', 'domingo', '14:55:19'),
('zeca@hotm.com', 'domingo', '14:55:20'),
('zeca@hotm.com', 'domingo', '14:55:21'),
('zeca@hotm.com', 'domingo', '14:55:22'),
('zeca@hotm.com', 'domingo', '14:55:23'),
('zeca@hotm.com', 'domingo', '14:55:24'),
('zeca@hotm.com', 'quarta', '15:16:01'),
('zeca@hotm.com', 'terça', '17:18:00');

--
-- Acionadores `rondaplaneada`
--
DELIMITER $$
CREATE TRIGGER `After_Delete_RondaPlaneada` AFTER DELETE ON `rondaplaneada` FOR EACH ROW BEGIN
DECLARE new_id INT;
INSERT INTO logsrondaplaneada VALUES (new_id, OLD.EmailUtilizador, NOW(), 'D', CONCAT (OLD.EmailUtilizador, '|', OLD.DiaSemana, '|', OLD.HoraRonda), ''); 
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `After_Insert_RondaPlaneada` AFTER INSERT ON `rondaplaneada` FOR EACH ROW BEGIN
DECLARE new_id INT;
INSERT INTO logsrondaplaneada VALUES (new_id, NEW.emailutilizador, NOW(), 'I', '', CONCAT (NEW.emailutilizador, '|', NEW.diasemana, '|', NEW.horaronda));
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `After_Update_RondaPlaneada` AFTER UPDATE ON `rondaplaneada` FOR EACH ROW BEGIN
DECLARE new_id INT;
INSERT INTO logsrondaplaneada VALUES (new_id, NEW.EmailUtilizador, NOW(), 'U', CONCAT (OLD.EmailUtilizador, '|', OLD.DiaSemana, '|', OLD.HoraRonda), CONCAT (NEW.EmailUtilizador, '|', NEW.DiaSemana, '|', NEW.HoraRonda));
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `sistema`
--

CREATE TABLE `sistema` (
  `LimiteTemperatura` decimal(6,2) NOT NULL,
  `LimiteHumidade` decimal(6,2) NOT NULL,
  `LimiteLuminosidade` decimal(6,2) NOT NULL,
  `LogsDiaSemana` int(11) NOT NULL,
  `LogsMedicoesSensores` int(11) NOT NULL,
  `LogsRondaExtra` int(11) NOT NULL,
  `LogsSistema` int(11) NOT NULL,
  `LogsUtilizador` int(11) NOT NULL,
  `LogsRondaPlaneada` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `sistema`
--

INSERT INTO `sistema` (`LimiteTemperatura`, `LimiteHumidade`, `LimiteLuminosidade`, `LogsDiaSemana`, `LogsMedicoesSensores`, `LogsRondaExtra`, `LogsSistema`, `LogsUtilizador`, `LogsRondaPlaneada`) VALUES
('33.00', '37.00', '100.00', 29, 4, 5, 194, 4, 5);

--
-- Acionadores `sistema`
--
DELIMITER $$
CREATE TRIGGER `After_Delete_Sistema` AFTER DELETE ON `sistema` FOR EACH ROW BEGIN
DECLARE new_id INT;
INSERT INTO logssistema VALUES (new_id, '', NOW(), 'D', concat(old.LimiteTemperatura, '|', old.LimiteHumidade, '|', old.LimiteLuminosidade, '|', old.LogsDiaSemana,'|', old.LogsMedicoesSensores, '|', old.LogsRondaExtra, '|', old.LogsSistema, '|', old.LogsUtilizador, '|', old.LogsRondaPlaneada), '');
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `After_Insert_Sistema` AFTER INSERT ON `sistema` FOR EACH ROW BEGIN
DECLARE new_id INT;
INSERT INTO logssistema VALUES (new_id, '', NOW(), 'I', '', concat(new.LimiteTemperatura, '|', new.LimiteHumidade, '|', new.LimiteLuminosidade, '|', new.LogsDiaSemana,'|', new.LogsMedicoesSensores, '|', new.LogsRondaExtra, '|', new.LogsSistema, '|', new.LogsUtilizador, '|', new.LogsRondaPlaneada));
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `After_Update_Sistema` AFTER UPDATE ON `sistema` FOR EACH ROW BEGIN
DECLARE new_id INT;
INSERT INTO logssistema VALUES (new_id, '', NOW(), 'U', concat(old.LimiteTemperatura, '|', old.LimiteHumidade, '|', old.LimiteLuminosidade, '|', old.LogsDiaSemana,'|', old.LogsMedicoesSensores, '|', old.LogsRondaExtra, '|', old.LogsSistema, '|', old.LogsUtilizador, '|', old.LogsRondaPlaneada), concat(new.LimiteTemperatura, '|', new.LimiteHumidade, '|', new.LimiteLuminosidade, '|', new.LogsDiaSemana,'|', new.LogsMedicoesSensores, '|', new.LogsRondaExtra, '|', new.LogsSistema, '|', new.LogsUtilizador, '|', new.LogsRondaPlaneada));
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `utilizadores`
--

CREATE TABLE `utilizadores` (
  `EmailUtilizador` varchar(100) NOT NULL,
  `NomeUtilizador` varchar(200) NOT NULL,
  `TipoUtilizador` enum('Seguranca','ChefeSeguranca','Administrador','DiretorMuseu') NOT NULL,
  `MoradaUtilizador` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `utilizadores`
--

INSERT INTO `utilizadores` (`EmailUtilizador`, `NomeUtilizador`, `TipoUtilizador`, `MoradaUtilizador`) VALUES
('beatriz.isa2@hotmail.com', 'hello', 'Seguranca', 'rua 31'),
('biocas@hotmail.com', 'biocas', 'ChefeSeguranca', 'tttttttttt2'),
('lololo@123', '123', 'Seguranca', '13'),
('zeca@hotm.com', 'zequinha', 'Administrador', 'ruaxd');

--
-- Acionadores `utilizadores`
--
DELIMITER $$
CREATE TRIGGER `After_Delete_Utilizadores` AFTER DELETE ON `utilizadores` FOR EACH ROW BEGIN
DECLARE new_id INT;
INSERT INTO logsutilizador VALUES (new_id, OLD.emailUtilizador, NOW(), 'D', CONCAT(OLD.emailUtilizador, '|', OLD.nomeUtilizador, '|', OLD.tipoUtilizador, '|', OLD.moradaUtilizador), null); 
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `After_Insert_Utilizadores` AFTER INSERT ON `utilizadores` FOR EACH ROW BEGIN
DECLARE new_id INT;
INSERT INTO logsutilizador VALUES (new_id, NEW.emailUtilizador, NOW(), 'I', null, CONCAT(NEW.emailUtilizador, '|', NEW.nomeUtilizador, '|', NEW.tipoUtilizador, '|', NEW.moradaUtilizador)); 
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `After_Update_Utilizadores` AFTER UPDATE ON `utilizadores` FOR EACH ROW BEGIN
DECLARE new_id INT;
INSERT INTO logsutilizador VALUES (new_id, NEW.emailUtilizador, NOW(), 'U', CONCAT(OLD.emailUtilizador, '|', OLD.nomeUtilizador, '|', OLD.tipoUtilizador, '|', OLD.moradaUtilizador), CONCAT(NEW.emailUtilizador, '|', NEW.nomeUtilizador, '|', NEW.tipoUtilizador, '|', NEW.moradaUtilizador)); 
END
$$
DELIMITER ;

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `diasemana`
--
ALTER TABLE `diasemana`
  ADD PRIMARY KEY (`DiaSemana`,`HoraRonda`) USING BTREE;

--
-- Índices para tabela `logsdiasemana`
--
ALTER TABLE `logsdiasemana`
  ADD PRIMARY KEY (`ID`);

--
-- Índices para tabela `logsmedicoessensores`
--
ALTER TABLE `logsmedicoessensores`
  ADD PRIMARY KEY (`ID`);

--
-- Índices para tabela `logsrondaextra`
--
ALTER TABLE `logsrondaextra`
  ADD PRIMARY KEY (`ID`);

--
-- Índices para tabela `logsrondaplaneada`
--
ALTER TABLE `logsrondaplaneada`
  ADD PRIMARY KEY (`ID`);

--
-- Índices para tabela `logssistema`
--
ALTER TABLE `logssistema`
  ADD PRIMARY KEY (`ID`);

--
-- Índices para tabela `logsutilizador`
--
ALTER TABLE `logsutilizador`
  ADD PRIMARY KEY (`ID`);

--
-- Índices para tabela `medicoessensores`
--
ALTER TABLE `medicoessensores`
  ADD PRIMARY KEY (`IDMedicao`);

--
-- Índices para tabela `rondaextra`
--
ALTER TABLE `rondaextra`
  ADD PRIMARY KEY (`DataHora`),
  ADD KEY `EmailUtilizador` (`EmailUtilizador`);

--
-- Índices para tabela `rondaplaneada`
--
ALTER TABLE `rondaplaneada`
  ADD PRIMARY KEY (`EmailUtilizador`,`DiaSemana`,`HoraRonda`),
  ADD KEY `EmailUtilizador` (`EmailUtilizador`),
  ADD KEY `DiaSemana` (`DiaSemana`);

--
-- Índices para tabela `utilizadores`
--
ALTER TABLE `utilizadores`
  ADD PRIMARY KEY (`EmailUtilizador`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `logsdiasemana`
--
ALTER TABLE `logsdiasemana`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT de tabela `logsmedicoessensores`
--
ALTER TABLE `logsmedicoessensores`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de tabela `logsrondaextra`
--
ALTER TABLE `logsrondaextra`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de tabela `logsrondaplaneada`
--
ALTER TABLE `logsrondaplaneada`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=217;

--
-- AUTO_INCREMENT de tabela `logssistema`
--
ALTER TABLE `logssistema`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=196;

--
-- AUTO_INCREMENT de tabela `logsutilizador`
--
ALTER TABLE `logsutilizador`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT de tabela `medicoessensores`
--
ALTER TABLE `medicoessensores`
  MODIFY `IDMedicao` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `rondaextra`
--
ALTER TABLE `rondaextra`
  ADD CONSTRAINT `RondaExtra_ibfk_1` FOREIGN KEY (`EmailUtilizador`) REFERENCES `utilizadores` (`EmailUtilizador`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `rondaplaneada`
--
ALTER TABLE `rondaplaneada`
  ADD CONSTRAINT `rondaplaneada_ibfk_1` FOREIGN KEY (`EmailUtilizador`) REFERENCES `utilizadores` (`EmailUtilizador`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `rondaplaneada_ibfk_2` FOREIGN KEY (`DiaSemana`) REFERENCES `diasemana` (`DiaSemana`) ON DELETE CASCADE ON UPDATE CASCADE;

DELIMITER $$
--
-- Eventos
--
CREATE DEFINER=`root`@`localhost` EVENT `Migration` ON SCHEDULE EVERY 12 HOUR STARTS '2020-03-28 00:00:00' ON COMPLETION PRESERVE ENABLE DO CALL doMigration()$$

DELIMITER ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
