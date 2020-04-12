-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 05, 2020 at 09:11 PM
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
-- Database: `mysqlmaing5`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `alterarRondaPlaneada` (IN `id` INT, IN `novoId` INT, IN `dataInicial` TIMESTAMP, IN `novaData` TIMESTAMP)  NO SQL
BEGIN
	UPDATE rondaplaneada
    SET 
    rondaplaneada.idUtilizador= CASE WHEN novoId !="" THEN novoId ELSE rondaplaneada.idUtilizador END,
    rondaplaneada.data= CASE WHEN novaData !="" THEN novaData ELSE rondaplaneada.data END
    WHERE idUtilizador=id AND rondaplaneada.data=dataInicial;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `criarRondaPlaneada` (IN `dataTurno` TIMESTAMP, IN `id` INT)  NO SQL
BEGIN
	INSERT INTO rondaplaneada VALUES (dataTurno, id);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `criarUtilizador` (IN `email` VARCHAR(100), IN `morada` VARCHAR(500), IN `nome` VARCHAR(200), IN `tipoUtilizador` ENUM('ChefeSeguranca','Seguranca','Administrador','DiretorMuseu','Auditor'), IN `pass` VARCHAR(45))  NO SQL
BEGIN
	DECLARE str VARCHAR(10); SET str = (SELECT SUBSTRING_INDEX(email, '@', 1));
    
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
	IF ( tipoUtilizador = 'Auditor' ) THEN
    	SET @query = CONCAT('GRANT Auditor TO "', str, '";');
        PREPARE stmt FROM @query;
    	EXECUTE stmt;
        DEALLOCATE PREPARE stmt;
        SET @q = CONCAT('SET DEFAULT ROLE Auditor FOR "', str, '";');
        PREPARE stmt FROM @q;
    	EXECUTE stmt;
    END IF;

    INSERT INTO utilizador VALUES (NULL , nome, email, tipoUtilizador, morada);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `editarSistema` (IN `valorLimite` DECIMAL(6,2), IN `limite` ENUM('limiteTemperatura','limiteHumidade','limiteLuminosidade'))  NO SQL
BEGIN 
UPDATE sistema
SET LimiteTemperatura=IF(limite='limiteTemperatura', valorLimite, sistema.LimiteTemperatura), LimiteHumidade=IF(limite='limiteHumidade', valorLimite, sistema.LimiteHumidade), LimiteLuminosidade=IF(limite='limiteLuminosidade', valorLimite, sistema.LimiteLuminosidade);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `editarUtilizador` (IN `idUtilizador` INT, IN `newNome` VARCHAR(200), IN `newEmail` VARCHAR(100), IN `newMorada` VARCHAR(500))  NO SQL
    SQL SECURITY INVOKER
BEGIN

SELECT SUBSTRING_INDEX(CURRENT_USER, '@', 1) INTO @str;

SELECT tipoUtilizador INTO @tipo FROM utilizador WHERE SUBSTRING_INDEX(email, '@', 1) = @str;

SELECT id INTO @id FROM utilizador WHERE SUBSTRING_INDEX(email, '@', 1) = @str;

SELECT email INTO @mail FROM utilizador WHERE id = idUtilizador;

IF(@tipo = 'Administrador') THEN
	IF(newNome != "") THEN 
		UPDATE utilizador SET nome = newNome WHERE idUtilizador = id;
	END IF;
	IF(newEmail != "") THEN
		UPDATE utilizador SET email = newEmail WHERE idUtilizador = id;
		SET @query = CONCAT('RENAME USER "', SUBSTRING_INDEX(@mail, '@', 1), '" TO "', SUBSTRING_INDEX(newEmail, '@', 1), '";');
		PREPARE stmt FROM @query;
		EXECUTE stmt;
	END IF;
	IF(newMorada != "") THEN
		UPDATE utilizador SET morada = newMorada WHERE idUtilizador = id;
	END IF;
ELSEIF(idUtilizador = @id) THEN
	IF(newNome != "") THEN 
		UPDATE utilizador SET nome = newNome WHERE @id = id;
	END IF;
	IF(newEmail != "") THEN
		UPDATE utilizador SET email = newEmail WHERE @id = id;
		SET @query = CONCAT('RENAME USER "', @str, '" TO "', SUBSTRING_INDEX(newEmail, '@', 1), '";');
		PREPARE stmt FROM @query;
		EXECUTE stmt;
	END IF;
	IF(newMorada != "") THEN
		UPDATE utilizador SET morada = newMorada WHERE @id = id;
	END IF;
END IF;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getSelectFromUtilizador` ()  NO SQL
    SQL SECURITY INVOKER
BEGIN
	DECLARE str VARCHAR(10); 
    SET str = (SELECT SUBSTRING_INDEX(CURRENT_USER, '@', 1));
    
    IF ((SELECT count(*) FROM utilizador WHERE str = SUBSTRING_INDEX(email, '@', 1) and tipoUtilizador = 'Seguranca')= 1) THEN
    	SELECT * FROM utilizador WHERE str = SUBSTRING_INDEX(email, '@', 1);
    ELSE
    	SELECT * FROM utilizador;
    END IF;
    
    IF ( str = 'root' ) THEN 
    	INSERT INTO logutilizador VALUES (NULL, NOW(), 'Select', NULL, 0, CURRENT_USER(), 'root', 'root', 'servidor');
    ELSE
    	call insertSelectLogs(str);
     END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertSelectLogs` (IN `str` VARCHAR(10))  NO SQL
BEGIN
INSERT INTO logutilizador VALUES
(NULL, NOW(), 'Select', NULL, (SELECT id FROM utilizador WHERE str = SUBSTRING_INDEX(email, '@', 1)), str, (SELECT nome FROM utilizador WHERE str = SUBSTRING_INDEX(email, '@', 1)), (SELECT tipoUtilizador FROM utilizador WHERE str = SUBSTRING_INDEX(email, '@', 1)), (SELECT morada FROM utilizador WHERE str = SUBSTRING_INDEX(email, '@', 1)));
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `monitorizarLeiturasSensores` (IN `DataHoraInicial` TIMESTAMP, IN `DataHoraFinal` TIMESTAMP)  NO SQL
BEGIN
	SELECT  *  FROM medicoessensores 
	WHERE  (medicoessensores.dataHoraMedicao BETWEEN DataHoraInicial AND DataHoraFinal);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `passarCartao` (IN `id` INT)  NO SQL
BEGIN
IF((SELECT COUNT(*) FROM rondaextra WHERE idUtilizador = id) = 0 ) THEN
    	INSERT INTO rondaextra VALUES (NOW(), NULL, id);
    
	ELSEIF ((SELECT dataHoraFim FROM rondaextra WHERE idUtilizador = id ORDER BY dataHoraInicio DESC LIMIT 1) IS NULL ) THEN
	UPDATE rondaextra SET dataHoraFim = NOW() WHERE dataHoraFim IS NULL AND id = idUtilizador;
   	ELSE
    	INSERT INTO rondaextra VALUES (NOW(), NULL, id);
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pesquisaTabelaTempELum` (IN `dataHoraMedicaoInicial` TIMESTAMP, IN `dataHoraMedicaoFinal` TIMESTAMP)  NO SQL
BEGIN 
SELECT * FROM medicoessensores 
WHERE (dataHoraMedicao BETWEEN dataHoraMedicaoInicial AND DataHoraMedicaoFinal) AND ( tipoSensor = 'Temperatura' OR tipoSensor = 'Luminosidade');
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `removerRondaPlaneada` (IN `dataTurno` TIMESTAMP, IN `id` INT)  NO SQL
BEGIN
	DELETE FROM rondaplaneada where rondaplaneada.data=dataTurno AND idUtilizador=id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `removerUtilizador` (IN `idUtilizador` INT)  NO SQL
BEGIN
	SELECT email INTO @st FROM utilizador WHERE id = idUtilizador;
   
    SET @query = CONCAT('DROP USER "', SUBSTRING_INDEX(@st, '@', 1), '";');
    PREPARE stmt FROM @query;
    EXECUTE stmt;
    DELETE FROM utilizador where id=idUtilizador;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `logmedicoessensores`
--

CREATE TABLE `logmedicoessensores` (
  `id` int(11) NOT NULL,
  `data` timestamp NOT NULL DEFAULT current_timestamp(),
  `operacao` enum('Insert','Update','Delete') NOT NULL,
  `campoAlterado` varchar(100) DEFAULT NULL,
  `idMedicao` int(11) NOT NULL,
  `valorMedicao` decimal(6,2) NOT NULL,
  `tipoSensor` enum('Temperatura','Humidade','Luminosidade','Movimento') NOT NULL,
  `dataHoraMedicao` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `logrondaextra`
--

CREATE TABLE `logrondaextra` (
  `id` int(11) NOT NULL,
  `data` timestamp NOT NULL DEFAULT current_timestamp(),
  `operacao` enum('Insert','Update','Delete') NOT NULL,
  `campoAlterado` varchar(100) DEFAULT NULL,
  `dataHoraInicio` timestamp NULL DEFAULT NULL,
  `dataHoraFim` timestamp NULL DEFAULT NULL,
  `idUtilizador` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `logrondaplaneada`
--

CREATE TABLE `logrondaplaneada` (
  `id` int(11) NOT NULL,
  `operacao` enum('Insert','Update','Delete') NOT NULL,
  `campoAlterado` varchar(100) DEFAULT NULL,
  `dataRonda` timestamp NULL DEFAULT NULL,
  `idUtilizador` int(11) NOT NULL,
  `data` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `logsistema`
--

CREATE TABLE `logsistema` (
  `id` int(11) NOT NULL,
  `data` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `operacao` enum('Insert','Update','Delete') NOT NULL,
  `campoAlterado` varchar(100) NOT NULL,
  `limiteTemperatura` decimal(6,2) DEFAULT NULL,
  `limiteHumidade` decimal(6,2) DEFAULT NULL,
  `limiteLuminosidade` decimal(6,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `logutilizador`
--

CREATE TABLE `logutilizador` (
  `id` int(11) NOT NULL,
  `data` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `operacao` enum('Insert','Update','Delete','Select') NOT NULL,
  `campoAlterado` varchar(100) DEFAULT NULL,
  `idUtilizador` int(11) NOT NULL,
  `emailUtilizador` varchar(100) NOT NULL,
  `nomeUtilizador` varchar(200) NOT NULL,
  `tipoUtilizador` enum('Seguranca','ChefeSeguranca','DiretorMuseu','Administrador') NOT NULL,
  `moradaUtilizador` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `logutilizador`
--

INSERT INTO `logutilizador` (`id`, `data`, `operacao`, `campoAlterado`, `idUtilizador`, `emailUtilizador`, `nomeUtilizador`, `tipoUtilizador`, `moradaUtilizador`) VALUES
(200, '2020-04-05 15:19:48', 'Select', NULL, 22, 'alexmfc', 'Alexandre', 'Seguranca', 'rua blbla'),
(201, '2020-04-05 15:58:41', 'Update', 'email', 22, 'alexmfc10@gmail.com', 'Alexandre', 'Seguranca', 'rua blbla'),
(202, '2020-04-05 16:29:08', 'Update', 'email', 22, 'alexmfc@gmail.com', 'Alexandre', 'Seguranca', 'rua blbla'),
(203, '2020-04-05 16:30:27', 'Update', 'email', 22, 'alexmfc10@gmail.com', 'Alexandre', 'Seguranca', 'rua blbla');

-- --------------------------------------------------------

--
-- Table structure for table `medicoessensores`
--

CREATE TABLE `medicoessensores` (
  `id` int(11) NOT NULL,
  `valorMedicao` decimal(6,2) NOT NULL,
  `tipoSensor` enum('Temperatura','Humidade','Luminosidade','Movimento') NOT NULL,
  `dataHoraMedicao` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `medicoessensores`
--

INSERT INTO `medicoessensores` (`id`, `valorMedicao`, `tipoSensor`, `dataHoraMedicao`) VALUES
(1, '3.00', 'Luminosidade', '2020-03-29 01:06:13'),
(5, '3.00', 'Humidade', '2020-03-20 21:41:19'),
(12, '8.00', 'Movimento', '2020-03-20 21:41:56'),
(13, '27.00', 'Temperatura', '2020-04-02 15:52:19'),
(15, '4.00', 'Temperatura', '2020-04-02 15:53:32'),
(16, '10.00', 'Luminosidade', '2020-04-02 15:53:32');

--
-- Triggers `medicoessensores`
--
DELIMITER $$
CREATE TRIGGER `novaMedicao` AFTER INSERT ON `medicoessensores` FOR EACH ROW BEGIN
DECLARE new_id INT;
INSERT INTO logmedicoessensores VALUES (new_id, NOW(), 'Insert', null, new.id, new.valorMedicao, new.tipoSensor, new.dataHoraMedicao); 
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `rondaextra`
--

CREATE TABLE `rondaextra` (
  `dataHoraInicio` timestamp NOT NULL DEFAULT current_timestamp(),
  `dataHoraFim` timestamp NULL DEFAULT NULL,
  `idUtilizador` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `rondaextra`
--

INSERT INTO `rondaextra` (`dataHoraInicio`, `dataHoraFim`, `idUtilizador`) VALUES
('2020-03-30 13:07:11', '2020-03-30 13:18:36', 6),
('2020-03-30 13:21:39', '2020-03-30 13:25:04', 13),
('2020-04-01 11:06:05', '2020-04-02 14:40:18', 14);

--
-- Triggers `rondaextra`
--
DELIMITER $$
CREATE TRIGGER `iniciarRondaExtra` AFTER INSERT ON `rondaextra` FOR EACH ROW BEGIN
DECLARE new_id INT;
INSERT INTO logrondaextra VALUES (new_id, NOW(), 'Insert', null, new.dataHoraInicio, null, new.idUtilizador);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `terminarRondaExtra` AFTER UPDATE ON `rondaextra` FOR EACH ROW BEGIN
DECLARE new_id INT;
IF (old.dataHoraFim IS NULL) THEN
	INSERT INTO logrondaextra VALUES (new_id, NOW(), 'Update', 'Data e hora final', new.dataHoraInicio, new.dataHoraFim, new.idUtilizador);
END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `rondaplaneada`
--

CREATE TABLE `rondaplaneada` (
  `data` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `idUtilizador` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `rondaplaneada`
--

INSERT INTO `rondaplaneada` (`data`, `idUtilizador`) VALUES
('2020-03-23 16:00:00', 1),
('2020-03-30 14:30:00', 13),
('2020-03-21 14:07:37', 14);

--
-- Triggers `rondaplaneada`
--
DELIMITER $$
CREATE TRIGGER `adicionarRonda` AFTER INSERT ON `rondaplaneada` FOR EACH ROW BEGIN
declare new_id INT ;
INSERT INTO logrondaplaneada VALUES (new_id, 'Insert', null, new.data, new.idUtilizador, now());
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `apagarRonda` AFTER DELETE ON `rondaplaneada` FOR EACH ROW BEGIN
declare new_id INT;
INSERT INTO logrondaplaneada VALUES (new_id, 'Delete', null, old.data, old.idUtilizador, NOW());
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `atualizarRonda` AFTER UPDATE ON `rondaplaneada` FOR EACH ROW BEGIN
DECLARE new_id INT;
IF (new.data <> old.data) THEN
INSERT INTO logrondaplaneada VALUES (new_id, 'Update', 'Data', new.data, new.idUtilizador, NOW());
END IF;
IF (new.idUtilizador <> old.idUtilizador) THEN
	INSERT INTO logrondaplaneada VALUES (new_id, 'Update', 'IdUtilizador', new.data, new.idUtilizador, NOW());
END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `sistema`
--

CREATE TABLE `sistema` (
  `limiteTemperatura` decimal(6,2) DEFAULT NULL,
  `limiteHumidade` decimal(6,2) DEFAULT NULL,
  `limiteLuminosidade` decimal(6,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `sistema`
--

INSERT INTO `sistema` (`limiteTemperatura`, `limiteHumidade`, `limiteLuminosidade`) VALUES
('34.50', '56.00', '66.00');

--
-- Triggers `sistema`
--
DELIMITER $$
CREATE TRIGGER `alterarLimite` AFTER UPDATE ON `sistema` FOR EACH ROW BEGIN
DECLARE new_id INT;
IF (new.limiteTemperatura <> old.limiteTemperatura) THEN
	INSERT INTO logsistema VALUES (new_id, NOW(), 'Update', 'limiteTemperatura', new.limiteTemperatura, new.limiteHumidade, new.limiteLuminosidade);
END IF;
IF (new.limiteHumidade <> old.limiteHumidade) THEN
	INSERT INTO logsistema VALUES (new_id, NOW(), 'Update', 'limiteHumidade', new.limiteTemperatura, new.limiteHumidade, new.limiteLuminosidade);
END IF;

IF (new.limiteLuminosidade <> old.limiteLuminosidade) THEN
	INSERT INTO logsistema VALUES (new_id, NOW(), 'Update', 'limiteLuminosidade', new.limiteTemperatura, new.limiteHumidade, new.limiteLuminosidade);
END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `utilizador`
--

CREATE TABLE `utilizador` (
  `id` int(11) NOT NULL,
  `nome` varchar(200) NOT NULL,
  `email` varchar(100) NOT NULL,
  `tipoUtilizador` enum('Seguranca','ChefeSeguranca','DiretorMuseu','Administrador','Auditor') NOT NULL,
  `morada` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `utilizador`
--

INSERT INTO `utilizador` (`id`, `nome`, `email`, `tipoUtilizador`, `morada`) VALUES
(1, 'fonifoni', 'beatriz.olaf@gm.com', 'Seguranca', 'rua s'),
(6, 'fonifoni', 'beatriz.isabel41@gmail.com', 'Administrador', 'Rua da Torrinha n32'),
(13, 'fonifoni', 'bgfredw@gmail.com', 'ChefeSeguranca', 'rua do ze'),
(14, 'Vasco', 'vascom@gmail.com', 'Seguranca', 'rua da lapa'),
(20, 'Joana Cavalheiro', 'joana1998@gmail.com', 'Administrador', 'Rua 25 de Abril'),
(22, 'Alexandre', 'alexmfc10@gmail.com', 'Seguranca', 'rua blbla');

--
-- Triggers `utilizador`
--
DELIMITER $$
CREATE TRIGGER `actualizaUtilizador` AFTER UPDATE ON `utilizador` FOR EACH ROW BEGIN
DECLARE new_id INT;
IF (new.tipoUtilizador <> old.tipoUtilizador) THEN
INSERT INTO logutilizador VALUES (new_id, NOW(), 'Update', 'tipoUtilizador', new.id, new.email, new.nome, new.tipoUtilizador, new.morada);
END IF;
IF (new.email <> old.email) THEN
	INSERT INTO logutilizador VALUES (new_id, NOW(), 'Update', 'email', new.id, new.email, new.nome, new.tipoUtilizador, new.morada);
END IF;
IF (new.morada <> old.morada) THEN
	INSERT INTO logutilizador VALUES (new_id, NOW(), 'Update', 'morada', new.id, new.email, new.nome, new.tipoUtilizador, new.morada);
END IF;
IF (new.nome <> old.nome) THEN
	INSERT INTO logutilizador VALUES (new_id, NOW(), 'Update', 'nome', new.id, new.email, new.nome, new.tipoUtilizador, new.morada);
END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `apagarUtilizador` AFTER DELETE ON `utilizador` FOR EACH ROW BEGIN
DECLARE new_id INT;
INSERT INTO logutilizador VALUES (new_id, NOW(), 'Delete', null, old.id, old.email, old.nome, old.tipoUtilizador, old.morada);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `novoUtilizador` AFTER INSERT ON `utilizador` FOR EACH ROW BEGIN
DECLARE new_id INT;
INSERT INTO logutilizador VALUES (new_id, NOW(), 'Insert', null, new.id, new.email, new.nome, new.tipoUtilizador, new.morada);
END
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `logmedicoessensores`
--
ALTER TABLE `logmedicoessensores`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `logrondaextra`
--
ALTER TABLE `logrondaextra`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `logrondaplaneada`
--
ALTER TABLE `logrondaplaneada`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `logsistema`
--
ALTER TABLE `logsistema`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `logutilizador`
--
ALTER TABLE `logutilizador`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `medicoessensores`
--
ALTER TABLE `medicoessensores`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rondaextra`
--
ALTER TABLE `rondaextra`
  ADD PRIMARY KEY (`dataHoraInicio`),
  ADD KEY `idUtilizador` (`idUtilizador`);

--
-- Indexes for table `rondaplaneada`
--
ALTER TABLE `rondaplaneada`
  ADD PRIMARY KEY (`data`),
  ADD KEY `idUtilizador` (`idUtilizador`);

--
-- Indexes for table `utilizador`
--
ALTER TABLE `utilizador`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `logmedicoessensores`
--
ALTER TABLE `logmedicoessensores`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=107;

--
-- AUTO_INCREMENT for table `logrondaextra`
--
ALTER TABLE `logrondaextra`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=262;

--
-- AUTO_INCREMENT for table `logrondaplaneada`
--
ALTER TABLE `logrondaplaneada`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=113;

--
-- AUTO_INCREMENT for table `logsistema`
--
ALTER TABLE `logsistema`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=104;

--
-- AUTO_INCREMENT for table `logutilizador`
--
ALTER TABLE `logutilizador`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=204;

--
-- AUTO_INCREMENT for table `medicoessensores`
--
ALTER TABLE `medicoessensores`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `utilizador`
--
ALTER TABLE `utilizador`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `rondaextra`
--
ALTER TABLE `rondaextra`
  ADD CONSTRAINT `rondaextra_ibfk_1` FOREIGN KEY (`idUtilizador`) REFERENCES `utilizador` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `rondaplaneada`
--
ALTER TABLE `rondaplaneada`
  ADD CONSTRAINT `rondaplaneada_ibfk_1` FOREIGN KEY (`idUtilizador`) REFERENCES `utilizador` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
