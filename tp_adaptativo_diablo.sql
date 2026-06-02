-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         12.2.2-MariaDB - MariaDB Server
-- SO del servidor:              Win64
-- HeidiSQL Versión:             12.14.0.7165
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para tp_adaptativo
CREATE DATABASE IF NOT EXISTS `tp_adaptativo` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_uca1400_ai_ci */;
USE `tp_adaptativo`;

-- Volcando estructura para tabla tp_adaptativo.entidad_tiene_opcion_unica
CREATE TABLE IF NOT EXISTS `entidad_tiene_opcion_unica` (
  `id_entidad` int(11) NOT NULL,
  `id_opcion_valida` int(11) DEFAULT NULL,
  `id_grupo` int(11) NOT NULL,
  PRIMARY KEY (`id_entidad`,`id_grupo`),
  KEY `id_opcion_valida` (`id_opcion_valida`),
  CONSTRAINT `1` FOREIGN KEY (`id_entidad`) REFERENCES `entidades` (`id`),
  CONSTRAINT `2` FOREIGN KEY (`id_opcion_valida`) REFERENCES `opciones_validas` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Volcando datos para la tabla tp_adaptativo.entidad_tiene_opcion_unica: ~4 rows (aproximadamente)
INSERT INTO `entidad_tiene_opcion_unica` (`id_entidad`, `id_opcion_valida`, `id_grupo`) VALUES
	(1, 101, 1),
	(2, 102, 1),
	(3, 103, 1),
	(4, 104, 1);

-- Volcando estructura para tabla tp_adaptativo.entidad_tiene_opciones_multiples
CREATE TABLE IF NOT EXISTS `entidad_tiene_opciones_multiples` (
  `id_entidad` int(11) NOT NULL,
  `id_opcion_valida` int(11) NOT NULL,
  PRIMARY KEY (`id_entidad`,`id_opcion_valida`),
  KEY `id_opcion_valida` (`id_opcion_valida`),
  CONSTRAINT `1` FOREIGN KEY (`id_entidad`) REFERENCES `entidades` (`id`),
  CONSTRAINT `2` FOREIGN KEY (`id_opcion_valida`) REFERENCES `opciones_validas` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Volcando datos para la tabla tp_adaptativo.entidad_tiene_opciones_multiples: ~9 rows (aproximadamente)
INSERT INTO `entidad_tiene_opciones_multiples` (`id_entidad`, `id_opcion_valida`) VALUES
	(1, 203),
	(1, 301),
	(2, 201),
	(2, 202),
	(2, 302),
	(3, 205),
	(3, 303),
	(4, 204),
	(4, 304);

-- Volcando estructura para tabla tp_adaptativo.entidades
CREATE TABLE IF NOT EXISTS `entidades` (
  `id` int(11) NOT NULL,
  `activo` tinyint(4) DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Volcando datos para la tabla tp_adaptativo.entidades: ~4 rows (aproximadamente)
INSERT INTO `entidades` (`id`, `activo`) VALUES
	(1, 1),
	(2, 1),
	(3, 1),
	(4, 1);

-- Volcando estructura para tabla tp_adaptativo.grupos_opciones
CREATE TABLE IF NOT EXISTS `grupos_opciones` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `activo` tinyint(4) DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Volcando datos para la tabla tp_adaptativo.grupos_opciones: ~3 rows (aproximadamente)
INSERT INTO `grupos_opciones` (`id`, `nombre`, `activo`) VALUES
	(1, 'Clase', 1),
	(2, 'Atributos', 1),
	(3, 'Armas', 1);

-- Volcando estructura para tabla tp_adaptativo.opciones
CREATE TABLE IF NOT EXISTS `opciones` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Volcando datos para la tabla tp_adaptativo.opciones: ~13 rows (aproximadamente)
INSERT INTO `opciones` (`id`, `nombre`) VALUES
	(1, 'Paladín'),
	(2, 'Bárbaro'),
	(3, 'Hechicera'),
	(4, 'Asesina'),
	(10, 'Fuerza'),
	(11, 'Vida'),
	(12, 'Velocidad'),
	(13, 'Destreza'),
	(14, 'Maná'),
	(20, 'Espada'),
	(21, 'Hacha'),
	(22, 'Vara'),
	(23, 'Garras');

-- Volcando estructura para tabla tp_adaptativo.opciones_validas
CREATE TABLE IF NOT EXISTS `opciones_validas` (
  `id` int(11) NOT NULL,
  `id_opcion` int(11) DEFAULT NULL,
  `id_grupo` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_opcion` (`id_opcion`),
  KEY `id_grupo` (`id_grupo`),
  CONSTRAINT `1` FOREIGN KEY (`id_opcion`) REFERENCES `opciones` (`id`),
  CONSTRAINT `2` FOREIGN KEY (`id_grupo`) REFERENCES `grupos_opciones` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Volcando datos para la tabla tp_adaptativo.opciones_validas: ~13 rows (aproximadamente)
INSERT INTO `opciones_validas` (`id`, `id_opcion`, `id_grupo`) VALUES
	(101, 1, 1),
	(102, 2, 1),
	(103, 3, 1),
	(104, 4, 1),
	(201, 10, 2),
	(202, 11, 2),
	(203, 12, 2),
	(204, 13, 2),
	(205, 14, 2),
	(301, 20, 3),
	(302, 21, 3),
	(303, 22, 3),
	(304, 23, 3);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
