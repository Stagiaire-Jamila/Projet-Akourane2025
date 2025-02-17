-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Base de donnée teste
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `Base de donnée teste` ;

-- -----------------------------------------------------
-- Schema Base de donnée teste
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Base de donnée teste` DEFAULT CHARACTER SET utf8 ;
USE `Base de donnée teste` ;

-- -----------------------------------------------------
-- Table `Base de donnée teste`.`Patients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Base de donnée teste`.`Patients` (
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

CREATE UNIQUE INDEX `telephone_UNIQUE` ON `Base de donnée teste`.`Patients` (`telephone` ASC) VISIBLE;

CREATE UNIQUE INDEX `email_UNIQUE` ON `Base de donnée teste`.`Patients` (`email` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Base de donnée teste`.`Médecins`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Base de donnée teste`.`Médecins` (
  `id` INT NOT NULL,
  `nom` VARCHAR(100) NOT NULL,
  `prenom` VARCHAR(100) NOT NULL,
  `specialite` VARCHAR(100) NULL,
  `telephone` VARCHAR(15) NULL,
  `email` VARCHAR(100) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `telephone_UNIQUE` ON `Base de donnée teste`.`Médecins` (`telephone` ASC) VISIBLE;

CREATE UNIQUE INDEX `email_UNIQUE` ON `Base de donnée teste`.`Médecins` (`email` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Base de donnée teste`.`Rendez_vous`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Base de donnée teste`.`Rendez_vous` (
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
    REFERENCES `Base de donnée teste`.`Médecins` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Rendez_vous_Patients1`
    FOREIGN KEY (`Patients_id`)
    REFERENCES `Base de donnée teste`.`Patients` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Rendez-vous_Médecins_idx` ON `Base de donnée teste`.`Rendez_vous` (`Médecins_id` ASC) VISIBLE;

CREATE INDEX `fk_Rendez_vous_Patients1_idx` ON `Base de donnée teste`.`Rendez_vous` (`Patients_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Base de donnée teste`.`tarifs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Base de donnée teste`.`tarifs` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `frais` VARCHAR(45) NOT NULL,
  `tarif` FLOAT(6,2) NOT NULL,
  `Médecins_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_tarifs_Médecins1`
    FOREIGN KEY (`Médecins_id`)
    REFERENCES `Base de donnée teste`.`Médecins` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_tarifs_Médecins1_idx` ON `Base de donnée teste`.`tarifs` (`Médecins_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Base de donnée teste`.`Frais`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Base de donnée teste`.`Frais` (
  `id` INT NOT NULL,
  `type-frais` VARCHAR(100) NULL,
  `statut` VARCHAR(100) NULL,
  `tarifs_id` INT NOT NULL,
  `Rendez_vous_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Frais_tarifs1`
    FOREIGN KEY (`tarifs_id`)
    REFERENCES `Base de donnée teste`.`tarifs` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Frais_Rendez_vous1`
    FOREIGN KEY (`Rendez_vous_id`)
    REFERENCES `Base de donnée teste`.`Rendez_vous` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Frais_tarifs1_idx` ON `Base de donnée teste`.`Frais` (`tarifs_id` ASC) VISIBLE;

CREATE INDEX `fk_Frais_Rendez_vous1_idx` ON `Base de donnée teste`.`Frais` (`Rendez_vous_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Base de donnée teste`.`Facture`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Base de donnée teste`.`Facture` (
  `id-facture` INT NOT NULL,
  `id-patient` VARCHAR(45) NOT NULL,
  `montant total` DECIMAL(10,2) NULL,
  `date-emission` DATE NULL,
  PRIMARY KEY (`id-facture`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
