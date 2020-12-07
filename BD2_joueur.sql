-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema joueurs
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema joueurs
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `joueurs` DEFAULT CHARACTER SET utf8mb4 ;
USE `joueurs` ;

-- -----------------------------------------------------
-- Table `joueurs`.`agents`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `joueurs`.`agents` (
  `Id` INT(11) NOT NULL AUTO_INCREMENT,
  `prenom` VARCHAR(45) NOT NULL,
  `nom` VARCHAR(45) NOT NULL,
  `telephone` VARCHAR(15) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `joueurs`.`compagnies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `joueurs`.`compagnies` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `anneeinnoguration` DATE NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `joueurs`.`directeurs_generaux`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `joueurs`.`directeurs_generaux` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `prenom` VARCHAR(45) NOT NULL,
  `actif` TINYINT(4) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `joueurs`.`equipes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `joueurs`.`equipes` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `ville` VARCHAR(45) NOT NULL,
  `annee_creation` DATE NOT NULL,
  `directeurs_generaux_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_equipes_directeurs_generaux1_idx` (`directeurs_generaux_id` ASC) VISIBLE,
  CONSTRAINT `fk_equipes_directeurs_generaux1`
    FOREIGN KEY (`directeurs_generaux_id`)
    REFERENCES `joueurs`.`directeurs_generaux` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `joueurs`.`postes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `joueurs`.`postes` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `poste` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `joueurs`.`joueurs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `joueurs`.`joueurs` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `prenom` VARCHAR(100) NOT NULL,
  `actif` TINYINT(4) NOT NULL,
  `agents_Id` INT(11) NOT NULL,
  `postes_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_joueurs_agents_idx` (`agents_Id` ASC) VISIBLE,
  INDEX `fk_joueurs_postes1_idx` (`postes_id` ASC) VISIBLE,
  CONSTRAINT `fk_joueurs_agents`
    FOREIGN KEY (`agents_Id`)
    REFERENCES `joueurs`.`agents` (`Id`),
  CONSTRAINT `fk_joueurs_postes1`
    FOREIGN KEY (`postes_id`)
    REFERENCES `joueurs`.`postes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `joueurs`.`personnels`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `joueurs`.`personnels` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `prenom` VARCHAR(45) NOT NULL,
  `actif` VARCHAR(45) NOT NULL,
  `postes_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_personnels_postes1_idx` (`postes_id` ASC) VISIBLE,
  CONSTRAINT `fk_personnels_postes1`
    FOREIGN KEY (`postes_id`)
    REFERENCES `joueurs`.`postes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `joueurs`.`signatures`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `joueurs`.`signatures` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `date` DATE NOT NULL,
  `joueurs_id` INT(11) NULL,
  `personnels_id` INT(11) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_signatures_joueurs1_idx` (`joueurs_id` ASC) VISIBLE,
  INDEX `fk_signatures_personnels1_idx` (`personnels_id` ASC) VISIBLE,
  CONSTRAINT `fk_signatures_joueurs1`
    FOREIGN KEY (`joueurs_id`)
    REFERENCES `joueurs`.`joueurs` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_signatures_personnels1`
    FOREIGN KEY (`personnels_id`)
    REFERENCES `joueurs`.`personnels` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `joueurs`.`contrats`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `joueurs`.`contrats` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `salaire` VARCHAR(100) NOT NULL,
  `nombre_annees` INT(11) NOT NULL,
  `equipes_id` INT(11) NOT NULL,
  `signature_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_contrats_equipes1_idx` (`equipes_id` ASC) VISIBLE,
  INDEX `fk_contrats_signature1_idx` (`signature_id` ASC) VISIBLE,
  CONSTRAINT `fk_contrats_equipes1`
    FOREIGN KEY (`equipes_id`)
    REFERENCES `joueurs`.`equipes` (`id`),
  CONSTRAINT `fk_contrats_signature1`
    FOREIGN KEY (`signature_id`)
    REFERENCES `joueurs`.`signatures` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `joueurs`.`contratspubicitaires`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `joueurs`.`contratspubicitaires` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `salaire` VARCHAR(45) NOT NULL,
  `annees` INT(11) NOT NULL,
  `compagnies_id` INT(11) NOT NULL,
  `signatures_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_contratspubicitaires_compagnies1_idx` (`compagnies_id` ASC) VISIBLE,
  INDEX `fk_contratspubicitaires_signatures1_idx` (`signatures_id` ASC) VISIBLE,
  CONSTRAINT `fk_contratspubicitaires_compagnies1`
    FOREIGN KEY (`compagnies_id`)
    REFERENCES `joueurs`.`compagnies` (`id`),
  CONSTRAINT `fk_contratspubicitaires_signatures1`
    FOREIGN KEY (`signatures_id`)
    REFERENCES `joueurs`.`signatures` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
