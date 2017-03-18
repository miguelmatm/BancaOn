-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 15-02-2017 a las 19:42:27
-- Versión del servidor: 10.1.16-MariaDB
-- Versión de PHP: 5.5.38

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `bancaonline`
--

-- --------------------------------------------------------
CREATE DATABASE IF NOT EXISTS `bancaonline` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `bancaonline`;
--
-- Estructura de tabla para la tabla `bancos`
--

CREATE TABLE `bancos` (
  `nombre` varchar(25) NOT NULL,
  `inicc` varchar(17) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `bancos`
--

INSERT INTO `bancos` (`nombre`, `inicc`) VALUES
('BBVA', '45688759946213568'),
('Santander', '46852516897845956');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cc_op`
--

CREATE TABLE `cc_op` (
  `cod_op` int(11) NOT NULL,
  `cc` varchar(23) NOT NULL,
  `tipo` varchar(5) NOT NULL,
  `saldo` float(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `cc_op`
--

INSERT INTO `cc_op` (`cod_op`, `cc`, `tipo`, `saldo`) VALUES
(208, '46852516897845956082', 'Cargo', 345.00),
(209, '46852516897845956395', 'Abono', 655.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cuentas`
--

CREATE TABLE `cuentas` (
  `CIF_emp` varchar(10) DEFAULT NULL,
  `CC` varchar(23) NOT NULL,
  `Banco` varchar(30) NOT NULL,
  `Oficina` varchar(100) NOT NULL,
  `Saldo` float(10,2) NOT NULL,
  `Usado` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `cuentas`
--

INSERT INTO `cuentas` (`CIF_emp`, `CC`, `Banco`, `Oficina`, `Saldo`, `Usado`) VALUES
('C33333333', '45688759946213568027', 'BBVA', '1', 500.00, 1),
(NULL, '45688759946213568403', 'BBVA', '3', 500.00, 0),
('C33333333', '45688759946213568758', 'BBVA', '1', 500.00, 1),
(NULL, '45688759946213568831', 'BBVA', '3', 500.00, 0),
('B22222222', '46852516897845956082', 'Santander', '1', 345.00, 1),
('B22222222', '46852516897845956395', 'Santander', '1', 655.00, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empresas`
--

CREATE TABLE `empresas` (
  `CIF` varchar(10) NOT NULL,
  `pw` varchar(4) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `domicilio` varchar(150) NOT NULL,
  `activa` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `empresas`
--

INSERT INTO `empresas` (`CIF`, `pw`, `nombre`, `domicilio`, `activa`) VALUES
('B22222222', '2222', 'Clestra', 'Calle Ancho', 1),
('C33333333', '3333', 'Serramar', 'Cl', 1),
('D44444444', '4444', 'Damaterra', 'Sol', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `operaciones`
--

CREATE TABLE `operaciones` (
  `codigo` int(11) NOT NULL,
  `tipo` varchar(5) NOT NULL,
  `referencias` varchar(13) NOT NULL,
  `remitente` varchar(50) NOT NULL,
  `fecha` varchar(10) NOT NULL,
  `fecha_valor` varchar(10) NOT NULL,
  `concepto` varchar(30) NOT NULL,
  `concepto_ext` varchar(100) NOT NULL,
  `cantidad` float(10,2) NOT NULL,
  `saldo` float(10,2) NOT NULL,
  `periodica` varchar(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `operaciones`
--

INSERT INTO `operaciones` (`codigo`, `tipo`, `referencias`, `remitente`, `fecha`, `fecha_valor`, `concepto`, `concepto_ext`, `cantidad`, `saldo`, `periodica`) VALUES
(208, 'Cargo', '15217082395C', 'remitente', '15-2-2017', '15-2-2017', 'Concepto', 'Concepto ext', -155.00, 345.00, '0'),
(209, 'Abono', '15217082395A', 'remitente', '15-2-2017', '15-2-2017', 'Concepto', 'Concepto ext', 155.00, 655.00, '0');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `transfperiod`
--

CREATE TABLE `transfperiod` (
  `cod` int(11) NOT NULL,
  `cc1` varchar(23) NOT NULL,
  `cc2` varchar(23) NOT NULL,
  `proximafecha` varchar(10) NOT NULL,
  `cantidad` float NOT NULL,
  `dias` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `bancos`
--
ALTER TABLE `bancos`
  ADD PRIMARY KEY (`nombre`);

--
-- Indices de la tabla `cc_op`
--
ALTER TABLE `cc_op`
  ADD PRIMARY KEY (`cod_op`,`cc`),
  ADD KEY `CCOP_CC_FK` (`cc`);

--
-- Indices de la tabla `cuentas`
--
ALTER TABLE `cuentas`
  ADD PRIMARY KEY (`CC`);

--
-- Indices de la tabla `empresas`
--
ALTER TABLE `empresas`
  ADD PRIMARY KEY (`CIF`);

--
-- Indices de la tabla `operaciones`
--
ALTER TABLE `operaciones`
  ADD PRIMARY KEY (`codigo`,`tipo`);

--
-- Indices de la tabla `transfperiod`
--
ALTER TABLE `transfperiod`
  ADD PRIMARY KEY (`cod`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `operaciones`
--
ALTER TABLE `operaciones`
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=210;
--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `cc_op`
--
ALTER TABLE `cc_op`
  ADD CONSTRAINT `CCOP_CC_FK` FOREIGN KEY (`cc`) REFERENCES `cuentas` (`CC`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `CCOP_COD_FK` FOREIGN KEY (`cod_op`) REFERENCES `operaciones` (`codigo`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
