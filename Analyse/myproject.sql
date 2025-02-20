-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema myproject
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `myproject` ;

-- -----------------------------------------------------
-- Schema myproject
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `myproject` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ;
USE `myproject` ;

-- -----------------------------------------------------
-- Table `myproject`.`Patients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `myproject`.`Patients` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(100) NOT NULL,
  `prenom` VARCHAR(100) NOT NULL,
  `naissance` DATE NULL,
  `adresse` VARCHAR(255) NULL,
  `telephone` VARCHAR(15) NULL,
  `email` VARCHAR(100) NULL,
  `observation` TEXT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `telephone_UNIQUE` ON `myproject`.`Patients` (`telephone` ASC) VISIBLE;

CREATE UNIQUE INDEX `email_UNIQUE` ON `myproject`.`Patients` (`email` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `myproject`.`Médecins`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `myproject`.`Médecins` (
  `id` INT NOT NULL,
  `nom` VARCHAR(100) NOT NULL,
  `prenom` VARCHAR(100) NOT NULL,
  `specialite` VARCHAR(100) NULL,
  `telephone` VARCHAR(15) NULL,
  `email` VARCHAR(100) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `telephone_UNIQUE` ON `myproject`.`Médecins` (`telephone` ASC) VISIBLE;

CREATE UNIQUE INDEX `email_UNIQUE` ON `myproject`.`Médecins` (`email` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `myproject`.`Rendez_vous`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `myproject`.`Rendez_vous` (
  `id` INT NOT NULL,
  `objet` VARCHAR(200) NOT NULL DEFAULT 'Consultation',
  `date_rdv` VARCHAR(45) NULL,
  `heur_rdv` DATETIME NULL,
  `reciption` TIME NULL,
  `Médecins_id` INT NOT NULL,
  `Patients_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Rendez-vous_Médecins`
    FOREIGN KEY (`Médecins_id`)
    REFERENCES `myproject`.`Médecins` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Rendez_vous_Patients1`
    FOREIGN KEY (`Patients_id`)
    REFERENCES `myproject`.`Patients` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Rendez-vous_Médecins_idx` ON `myproject`.`Rendez_vous` (`Médecins_id` ASC) VISIBLE;

CREATE INDEX `fk_Rendez_vous_Patients1_idx` ON `myproject`.`Rendez_vous` (`Patients_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `myproject`.`tarifs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `myproject`.`tarifs` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `frais` VARCHAR(45) NOT NULL,
  `tarif` FLOAT(6,2) NOT NULL,
  `Médecins_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_tarifs_Médecins1`
    FOREIGN KEY (`Médecins_id`)
    REFERENCES `myproject`.`Médecins` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_tarifs_Médecins1_idx` ON `myproject`.`tarifs` (`Médecins_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `myproject`.`Frais`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `myproject`.`Frais` (
  `id` INT NOT NULL,
  `type-frais` VARCHAR(100) NULL,
  `statut` VARCHAR(100) NULL,
  `tarifs_id` INT NOT NULL,
  `Rendez_vous_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Frais_tarifs1`
    FOREIGN KEY (`tarifs_id`)
    REFERENCES `myproject`.`tarifs` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Frais_Rendez_vous1`
    FOREIGN KEY (`Rendez_vous_id`)
    REFERENCES `myproject`.`Rendez_vous` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Frais_tarifs1_idx` ON `myproject`.`Frais` (`tarifs_id` ASC) VISIBLE;

CREATE INDEX `fk_Frais_Rendez_vous1_idx` ON `myproject`.`Frais` (`Rendez_vous_id` ASC) VISIBLE;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
