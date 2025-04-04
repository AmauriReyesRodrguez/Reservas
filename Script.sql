-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema reserva_schema
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema reserva_schema
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `reserva_schema` DEFAULT CHARACTER SET utf8 ;
SHOW WARNINGS;
USE `reserva_schema` ;

-- -----------------------------------------------------
-- Table `reserva_schema`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `reserva_schema`.`usuario` (
  `id_usuario` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(70) NULL,
  `email` VARCHAR(80) NULL,
  `contraseña` VARCHAR(60) NULL,
  PRIMARY KEY (`id_usuario`))
ENGINE = InnoDB;



SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `reserva_schema`.`sala`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `reserva_schema`.`sala` (
  `id_sala` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(80) NULL,
  `capacidad` INT NULL,
  PRIMARY KEY (`id_sala`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `reserva_schema`.`reserva`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `reserva_schema`.`reserva` (
  `id_reserva` INT NOT NULL AUTO_INCREMENT,
  `id_usuario` INT NOT NULL,
  `id_sala` INT NOT NULL,
  `fecha` DATE NOT NULL,
  `hora_inicio` TIME NOT NULL,
  `hora_fin` TIME NOT NULL,
  PRIMARY KEY (`id_reserva`),
  CONSTRAINT `id_usuario`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `reserva_schema`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_sala`
    FOREIGN KEY (`id_sala`)
    REFERENCES `reserva_schema`.`sala` (`id_sala`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
PACK_KEYS = DEFAULT
KEY_BLOCK_SIZE = 1;

SHOW WARNINGS;
CREATE INDEX `id_usuario_idx` ON `reserva_schema`.`reserva` (`id_usuario` ASC) VISIBLE;

SHOW WARNINGS;
CREATE INDEX `id_sala_idx` ON `reserva_schema`.`reserva` (`id_sala` ASC) VISIBLE;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `reserva_schema`.`componente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `reserva_schema`.`componente` (
  `id_componente` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(70) NULL,
  `disponibles` INT NOT NULL,
  PRIMARY KEY (`id_componente`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `reserva_schema`.`alerta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `reserva_schema`.`alerta` (
  `id_alerta` INT NOT NULL AUTO_INCREMENT,
  `id_reserva` INT NOT NULL,
  `fecha_envío` DATETIME NULL,
  PRIMARY KEY (`id_alerta`),
  CONSTRAINT `id_reserva`
    FOREIGN KEY (`id_reserva`)
    REFERENCES `reserva_schema`.`reserva` (`id_reserva`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE INDEX `id_reserva_idx` ON `reserva_schema`.`alerta` (`id_reserva` ASC) VISIBLE;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `reserva_schema`.`devoluciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `reserva_schema`.`devoluciones` (
  `id_devoluciones` INT NOT NULL AUTO_INCREMENT,
  `id_reserva` INT NOT NULL,
  `id_usuario` INT NOT NULL,
  `id_componente` INT NOT NULL,
  `cantidad_devuelta` INT NOT NULL,
  `fecha_devolución` DATETIME NOT NULL,
  PRIMARY KEY (`id_devoluciones`),
  CONSTRAINT `fk_id_reserva`
    FOREIGN KEY (`id_reserva`)
    REFERENCES `reserva_schema`.`reserva` (`id_reserva`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_id_usuario`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `reserva_schema`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_id_componente`
    FOREIGN KEY (`id_componente`)
    REFERENCES `reserva_schema`.`componente` (`id_componente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- DROP TABLE IF EXISTS reserva_schema.devoluciones;

SHOW WARNINGS;
CREATE INDEX `id_reserva_idx` ON `reserva_schema`.`devoluciones` (`id_reserva` ASC) VISIBLE;

SHOW WARNINGS;
CREATE INDEX `id_usuario_idx` ON `reserva_schema`.`devoluciones` (`id_usuario` ASC) VISIBLE;

SHOW WARNINGS;
CREATE INDEX `id_componente_idx` ON `reserva_schema`.`devoluciones` (`id_componente` ASC) VISIBLE;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `reserva_schema`.`reserva_componente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `reserva_schema`.`reserva_componente` (
  `id_reserva` INT NOT NULL,
  `id_componente` INT NOT NULL,
  `cantidad` INT NOT NULL,
  PRIMARY KEY (`id_reserva`, `id_componente`),
  CONSTRAINT `FK_reserva_componenete_id_reserva`
    FOREIGN KEY (`id_reserva`)
    REFERENCES `reserva_schema`.`reserva` (`id_reserva`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_reserva_componete_id_componente`
    FOREIGN KEY (`id_componente`)
    REFERENCES `reserva_schema`.`componente` (`id_componente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE INDEX `id_componente_idx` ON `reserva_schema`.`reserva_componente` (`id_componente` ASC) VISIBLE;

SHOW WARNINGS;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

SHOW TABLES; -- Ver todas las tablas
DESC usuario; -- Ver la estructura de la tabla usuario (repite para otras tablas)
DESC alerta;
DESC sala;
DESC reserva;
DESC reserva_componente;

INSERT INTO usuario (id_usuario, nombre, email, contraseña) 
VALUES (1, 'Juan Pérez', 'juanperez@email.com', 'password123');

INSERT INTO sala (id_sala, nombre, capacidad) 
VALUES (1, 'Sala A', 50);

INSERT INTO reserva (id_reserva, id_usuario, id_sala, fecha, hora_inicio, hora_fin) 
VALUES (1, 1, 1, '2025-04-04', '10:00:00', '12:00:00');

INSERT INTO componente (id_componente, nombre, disponibles) 
VALUES (1, 'Proyector', 5);

INSERT INTO reserva_componente (id_reserva, id_componente, cantidad) 
VALUES (1, 1, 1);

SELECT * FROM usuario;
SELECT * FROM sala;
SELECT * FROM reserva;
SELECT * FROM componente;
SELECT * FROM reserva_componente;

