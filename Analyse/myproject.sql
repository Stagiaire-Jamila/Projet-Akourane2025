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
-- Table `myproject`.`Medecins`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `myproject`.`Medecins` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(100) NOT NULL,
  `prenom` VARCHAR(100) NOT NULL,
  `specialite` VARCHAR(100) NULL,
  `telephone` VARCHAR(15) NULL,
  `email` VARCHAR(100) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `telephone_UNIQUE` ON `myproject`.`Medecins` (`telephone` ASC) VISIBLE;

CREATE UNIQUE INDEX `email_UNIQUE` ON `myproject`.`Medecins` (`email` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `myproject`.`total_tarifs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `myproject`.`total_tarifs` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `frais` VARCHAR(100) NOT NULL,
  `tarif` FLOAT(6,2) NOT NULL,
  `montant total` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `myproject`.`Rendez_vous`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `myproject`.`Rendez_vous` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `objet` VARCHAR(200) NOT NULL,
  `date_rdv` VARCHAR(45) NOT NULL,
  `heur_rdv` DATETIME NOT NULL,
  `reciption` TIME NOT NULL,
  `date_paiements` DATETIME NOT NULL,
  `pays` VARCHAR(3) NOT NULL,
  `Medecins_id` INT NOT NULL,
  `total_tarifs_id` INT NOT NULL,
  PRIMARY KEY (`id`, `total_tarifs_id`, `Medecins_id`),
  CONSTRAINT `fk_Rendez_vous_Medecins`
    FOREIGN KEY (`Medecins_id`)
    REFERENCES `myproject`.`Medecins` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Rendez_vous_total_tarifs1`
    FOREIGN KEY (`total_tarifs_id`)
    REFERENCES `myproject`.`total_tarifs` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Rendez_vous_Medecins_idx` ON `myproject`.`Rendez_vous` (`Medecins_id` ASC) VISIBLE;

CREATE INDEX `fk_Rendez_vous_total_tarifs1_idx` ON `myproject`.`Rendez_vous` (`total_tarifs_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `myproject`.`Patients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `myproject`.`Patients` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(100) NOT NULL,
  `prenom` VARCHAR(100) NOT NULL,
  `naissance` DATE NOT NULL,
  `adresse` VARCHAR(255) NOT NULL,
  `telephone` VARCHAR(15) NULL,
  `email` VARCHAR(100) NULL,
  `observation` TEXT NOT NULL,
  `Rendez_vous_id` INT NOT NULL,
  PRIMARY KEY (`id`, `Rendez_vous_id`),
  CONSTRAINT `fk_Patients_Rendez_vous1`
    FOREIGN KEY (`Rendez_vous_id`)
    REFERENCES `myproject`.`Rendez_vous` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `telephone_UNIQUE` ON `myproject`.`Patients` (`telephone` ASC) VISIBLE;

CREATE UNIQUE INDEX `email_UNIQUE` ON `myproject`.`Patients` (`email` ASC) VISIBLE;

CREATE INDEX `fk_Patients_Rendez_vous1_idx` ON `myproject`.`Patients` (`Rendez_vous_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `myproject`.`Frais`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `myproject`.`Frais` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `type-frais` VARCHAR(100) NOT NULL,
  `statut` VARCHAR(100) NOT NULL,
  `tarifs` FLOAT(6,2) NOT NULL,
  `total_tarifs_id` INT NOT NULL,
  PRIMARY KEY (`id`, `total_tarifs_id`),
  CONSTRAINT `fk_Frais_total_tarifs1`
    FOREIGN KEY (`total_tarifs_id`)
    REFERENCES `myproject`.`total_tarifs` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Frais_total_tarifs1_idx` ON `myproject`.`Frais` (`total_tarifs_id` ASC) VISIBLE;

USE `myproject` ;

-- -----------------------------------------------------
-- procedure ajouter_medecin
-- -----------------------------------------------------

DELIMITER $$
USE `myproject`$$
CREATE PROCEDURE `ajouter_medecin`(
    IN _nom VARCHAR(100),
    IN _prenom VARCHAR(100),
    IN _specialite VARCHAR(100),
    IN _telephone VARCHAR(15),
    IN _email VARCHAR(100)
)
BEGIN
    INSERT INTO `myproject`.`Medecins` (`nom`, `prenom`, `specialite`, `telephone`, `email`)
    VALUES (_nom, _prenom, _specialite, _telephone, _email);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure ajouter_total_tarif
-- -----------------------------------------------------

DELIMITER $$
USE `myproject`$$
CREATE PROCEDURE `ajouter_total_tarif`(
    IN _frais VARCHAR(45),
    IN _tarif FLOAT(6,2),
    IN _montant_total DECIMAL(10,2)
)
BEGIN
    INSERT INTO `myproject`.`total_tarifs` (`frais`, `tarif`, `montant total`)
    VALUES (_frais, _tarif, _montant_total);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure ajouter_rendez_vous
-- -----------------------------------------------------

DELIMITER $$
USE `myproject`$$
CREATE PROCEDURE `ajouter_rendez_vous`(
    IN _objet VARCHAR(200),
    IN _date_rdv VARCHAR(45),
    IN _heur_rdv DATETIME,
    IN _reciption TIME,
    IN _date_paiements DATETIME,
    IN _pays VARCHAR(3),
    IN _Medecins_id INT,
    IN _total_tarifs_id INT
)
BEGIN
    INSERT INTO `myproject`.`Rendez_vous` (`objet`, `date_rdv`, `heur_rdv`, `reciption`, `date_paiements`, `pays`, `Medecins_id`, `total_tarifs_id`)
    VALUES (_objet, _date_rdv, _heur_rdv, _reciption, _date_paiements, _pays, _Medecins_id, _total_tarifs_id);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure ajouter_patient
-- -----------------------------------------------------

DELIMITER $$
USE `myproject`$$
CREATE PROCEDURE `ajouter_patient`(
    IN _nom VARCHAR(100),
    IN _prenom VARCHAR(100),
    IN _naissance DATE,
    IN _adresse VARCHAR(255),
    IN _telephone VARCHAR(15),
    IN _email VARCHAR(100),
    IN _observation TEXT,
    IN _Rendez_vous_id INT
)
BEGIN
    INSERT INTO `myproject`.`Patients` (`nom`, `prenom`, `naissance`, `adresse`, `telephone`, `email`, `observation`, `Rendez_vous_id`)
    VALUES (_nom, _prenom, _naissance, _adresse, _telephone, _email, _observation, _Rendez_vous_id);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure ajouter_frais
-- -----------------------------------------------------

DELIMITER $$
USE `myproject`$$
CREATE PROCEDURE `ajouter_frais`(
    IN _type_frais VARCHAR(100),
    IN _statut VARCHAR(100),
    IN _tarifs FLOAT(6,2),
    IN _total_tarifs_id INT
)
BEGIN
    INSERT INTO `myproject`.`Frais` (`type-frais`, `statut`, `tarifs`, `total_tarifs_id`)
    VALUES (_type_frais, _statut, _tarifs, _total_tarifs_id);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure modifier_medecin
-- -----------------------------------------------------

DELIMITER $$
USE `myproject`$$
CREATE PROCEDURE `myproject`.`modifier_medecin`(
    IN p_id INT,
    IN p_nom VARCHAR(100),
    IN p_prenom VARCHAR(100),
    IN p_specialite VARCHAR(100),
    IN p_telephone VARCHAR(15),
    IN p_email VARCHAR(100)
)
BEGIN
    -- Mise à jour du médecin dans la table Medecins
    UPDATE `myproject`.`Medecins`
    SET
        `nom` = p_nom,
        `prenom` = p_prenom,
        `specialite` = p_specialite,
        `telephone` = p_telephone,
        `email` = p_email
    WHERE `id` = p_id;
    
    -- Optionnellement, vous pouvez vérifier si la mise à jour a été effectuée avec succès
    IF ROW_COUNT() = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Le médecin avec l\'ID spécifié n\'existe pas.';
    END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure modifier_total_tarifs
-- -----------------------------------------------------

DELIMITER $$
USE `myproject`$$
CREATE PROCEDURE `myproject`.`modifier_total_tarifs`(
    IN p_id INT,
    IN p_frais VARCHAR(45),
    IN p_tarif FLOAT(6,2),
    IN p_montant_total DECIMAL(10,2)
)
BEGIN
    UPDATE `myproject`.`total_tarifs`
    SET
        `frais` = p_frais,
        `tarif` = p_tarif,
        `montant total` = p_montant_total
    WHERE `id` = p_id;

    IF ROW_COUNT() = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Le tarif avec l\'ID spécifié n\'existe pas.';
    END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure modifier_rendez_vous
-- -----------------------------------------------------

DELIMITER $$
USE `myproject`$$
CREATE PROCEDURE `myproject`.`modifier_rendez_vous`(
    IN p_id INT,
    IN p_objet VARCHAR(200),
    IN p_date_rdv VARCHAR(45),
    IN p_heur_rdv DATETIME,
    IN p_reciption TIME,
    IN p_date_paiements DATETIME,
    IN p_pays VARCHAR(3),
    IN p_Medecins_id INT,
    IN p_total_tarifs_id INT
)
BEGIN
    UPDATE `myproject`.`Rendez_vous`
    SET
        `objet` = p_objet,
        `date_rdv` = p_date_rdv,
        `heur_rdv` = p_heur_rdv,
        `reciption` = p_reciption,
        `date_paiements` = p_date_paiements,
        `pays` = p_pays,
        `Medecins_id` = p_Medecins_id,
        `total_tarifs_id` = p_total_tarifs_id
    WHERE `id` = p_id;

    IF ROW_COUNT() = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Le rendez-vous avec l\'ID spécifié n\'existe pas.';
    END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure modifier_patients
-- -----------------------------------------------------

DELIMITER $$
USE `myproject`$$
CREATE PROCEDURE `myproject`.`modifier_patients`(
    IN p_id INT,
    IN p_nom VARCHAR(100),
    IN p_prenom VARCHAR(100),
    IN p_naissance DATE,
    IN p_adresse VARCHAR(255),
    IN p_telephone VARCHAR(15),
    IN p_email VARCHAR(100),
    IN p_observation TEXT,
    IN p_Rendez_vous_id INT
)
BEGIN
    UPDATE `myproject`.`Patients`
    SET
        `nom` = p_nom,
        `prenom` = p_prenom,
        `naissance` = p_naissance,
        `adresse` = p_adresse,
        `telephone` = p_telephone,
        `email` = p_email,
        `observation` = p_observation,
        `Rendez_vous_id` = p_Rendez_vous_id
    WHERE `id` = p_id;

    IF ROW_COUNT() = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Le patient avec l\'ID spécifié n\'existe pas.';
    END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure modifier_frais
-- -----------------------------------------------------

DELIMITER $$
USE `myproject`$$
CREATE PROCEDURE `myproject`.`modifier_frais`(
    IN p_id INT,
    IN p_type_frais VARCHAR(100),
    IN p_statut VARCHAR(100),
    IN p_tarifs FLOAT(6,2),
    IN p_total_tarifs_id INT
)
BEGIN
    UPDATE `myproject`.`Frais`
    SET
        `type-frais` = p_type_frais,
        `statut` = p_statut,
        `tarifs` = p_tarifs,
        `total_tarifs_id` = p_total_tarifs_id
    WHERE `id` = p_id;

    IF ROW_COUNT() = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Le frais avec l\'ID spécifié n\'existe pas.';
    END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure supprimer_medecin
-- -----------------------------------------------------

DELIMITER $$
USE `myproject`$$
CREATE PROCEDURE supprimer_medecin(IN doctor_id INT)
BEGIN
    -- First, delete the related records from 'Rendez_vous' table
    DELETE FROM myproject.Rendez_vous WHERE Medecins_id = doctor_id;
    
    -- Then delete the doctor from the 'Medecins' table
    DELETE FROM myproject.Medecins WHERE id = doctor_id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure supprimer_total_tarifs
-- -----------------------------------------------------

DELIMITER $$
USE `myproject`$$
CREATE PROCEDURE supprimer_total_tarifs(IN total_tarifs_id INT)
BEGIN
    -- First, delete associated records from 'Frais' table
    DELETE FROM myproject.Frais WHERE total_tarifs_id = total_tarifs_id;
    
    -- Then delete the related records from 'Rendez_vous' table
    DELETE FROM myproject.Rendez_vous WHERE total_tarifs_id = total_tarifs_id;

    -- Finally, delete the total_tarifs record
    DELETE FROM myproject.total_tarifs WHERE id = total_tarifs_id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure supprimer_patient
-- -----------------------------------------------------

DELIMITER $$
USE `myproject`$$
CREATE PROCEDURE supprimer_patient(IN patient_id INT)
BEGIN
    -- First, delete the related records from 'Rendez_vous' table
    DELETE FROM myproject.Rendez_vous WHERE id = patient_id;
    
    -- Then delete the patient from the 'Patients' table
    DELETE FROM myproject.Patients WHERE id = patient_id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure supprimer_frais
-- -----------------------------------------------------

DELIMITER $$
USE `myproject`$$
CREATE PROCEDURE supprimer_frais(IN frais_id INT)
BEGIN
    -- Delete the related fare record from the 'Frais' table
    DELETE FROM myproject.Frais WHERE id = frais_id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure supprimer_rendez_vous
-- -----------------------------------------------------

DELIMITER $$
USE `myproject`$$
CREATE PROCEDURE supprimer_rendez_vous(IN rendez_vous_id INT, IN medecins_id INT, IN total_tarifs_id INT)
BEGIN
    -- Delete the record from the 'Rendez_vous' table
    DELETE FROM myproject.Rendez_vous 
    WHERE id = rendez_vous_id AND Medecins_id = medecins_id AND total_tarifs_id = total_tarifs_id;
    
    -- You can also check if the deletion was successful (optional)
    IF ROW_COUNT() = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Rendez-vous record not found or could not be deleted.';
    END IF;
END$$

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
