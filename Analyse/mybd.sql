-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema BD
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `BD` ;

-- -----------------------------------------------------
-- Schema BD
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `BD` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ;
USE `BD` ;

-- -----------------------------------------------------
-- Table `BD`.`Patients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD`.`Patients` (
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

CREATE UNIQUE INDEX `telephone_UNIQUE` ON `BD`.`Patients` (`telephone` ASC) VISIBLE;

CREATE UNIQUE INDEX `email_UNIQUE` ON `BD`.`Patients` (`email` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `BD`.`Médecins`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD`.`Médecins` (
  `id` INT NOT NULL,
  `nom` VARCHAR(100) NOT NULL,
  `prenom` VARCHAR(100) NOT NULL,
  `specialite` VARCHAR(100) NULL,
  `telephone` VARCHAR(15) NULL,
  `email` VARCHAR(100) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `telephone_UNIQUE` ON `BD`.`Médecins` (`telephone` ASC) VISIBLE;

CREATE UNIQUE INDEX `email_UNIQUE` ON `BD`.`Médecins` (`email` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `BD`.`Rendez_vous`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD`.`Rendez_vous` (
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
    REFERENCES `BD`.`Médecins` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Rendez_vous_Patients1`
    FOREIGN KEY (`Patients_id`)
    REFERENCES `BD`.`Patients` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Rendez-vous_Médecins_idx` ON `BD`.`Rendez_vous` (`Médecins_id` ASC) VISIBLE;

CREATE INDEX `fk_Rendez_vous_Patients1_idx` ON `BD`.`Rendez_vous` (`Patients_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `BD`.`tarifs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD`.`tarifs` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `frais` VARCHAR(45) NOT NULL,
  `tarif` FLOAT(6,2) NOT NULL,
  `Médecins_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_tarifs_Médecins1`
    FOREIGN KEY (`Médecins_id`)
    REFERENCES `BD`.`Médecins` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_tarifs_Médecins1_idx` ON `BD`.`tarifs` (`Médecins_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `BD`.`Frais`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD`.`Frais` (
  `id` INT NOT NULL,
  `type-frais` VARCHAR(100) NULL,
  `statut` VARCHAR(100) NULL,
  `tarifs_id` INT NOT NULL,
  `Rendez_vous_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Frais_tarifs1`
    FOREIGN KEY (`tarifs_id`)
    REFERENCES `BD`.`tarifs` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Frais_Rendez_vous1`
    FOREIGN KEY (`Rendez_vous_id`)
    REFERENCES `BD`.`Rendez_vous` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Frais_tarifs1_idx` ON `BD`.`Frais` (`tarifs_id` ASC) VISIBLE;

CREATE INDEX `fk_Frais_Rendez_vous1_idx` ON `BD`.`Frais` (`Rendez_vous_id` ASC) VISIBLE;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
