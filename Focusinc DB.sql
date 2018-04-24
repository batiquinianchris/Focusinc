-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`PC_Lifespan`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PC_Lifespan` (
  `PL_ID` INT NOT NULL,
  `MANUFACTURED_DATE` DATE NULL,
  `PC_MONTH&YEAR` VARCHAR(45) NULL,
  PRIMARY KEY (`PL_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Assets`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Assets` (
  `ASSET_ID` INT NOT NULL AUTO_INCREMENT,
  `MOUSE` VARCHAR(45) NULL,
  `PC` VARCHAR(45) NULL,
  `KEYBOARD` VARCHAR(45) NULL,
  `HEADSET` VARCHAR(45) NULL,
  `MONITOR` VARCHAR(45) NULL,
  `WEBCAM` VARCHAR(45) NULL,
  `ASSET_PL_ID` INT NOT NULL,
  PRIMARY KEY (`ASSET_ID`),
  INDEX `fk_Assets_PC_LIFESPAN1_idx` (`ASSET_PL_ID` ASC),
  CONSTRAINT `fk_Assets_PC_LIFESPAN1`
    FOREIGN KEY (`ASSET_PL_ID`)
    REFERENCES `mydb`.`PC_Lifespan` (`PL_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Person`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Person` (
  `PERSON_ID` INT NOT NULL,
  `FIRSTNAME` VARCHAR(45) NULL,
  `LASTNAME` VARCHAR(45) NULL,
  `STATUS` VARCHAR(45) NULL,
  `PERSON_ASSET_ID` INT NOT NULL,
  PRIMARY KEY (`PERSON_ID`),
  INDEX `fk_Person_Assets1_idx` (`PERSON_ASSET_ID` ASC),
  CONSTRAINT `fk_Person_Assets1`
    FOREIGN KEY (`PERSON_ASSET_ID`)
    REFERENCES `mydb`.`Assets` (`ASSET_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Accounts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Accounts` (
  `ACCOUNT_ID` INT NOT NULL,
  `ACCOUNT_NAME` VARCHAR(45) NULL,
  `ACCOUNT_STATUS` VARCHAR(45) NULL,
  `ACCOUNT_PERSON_ID` INT NOT NULL,
  PRIMARY KEY (`ACCOUNT_ID`),
  INDEX `fk_Accounts_Person_idx` (`ACCOUNT_PERSON_ID` ASC),
  CONSTRAINT `fk_Accounts_Person`
    FOREIGN KEY (`ACCOUNT_PERSON_ID`)
    REFERENCES `mydb`.`Person` (`PERSON_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`History`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`History` (
  `HISTORY_ID` INT NOT NULL,
  `DT_TRANSACTION` DATETIME NULL,
  `TYPE` VARCHAR(45) NULL,
  `DESCRIPTION` VARCHAR(45) NULL,
  `HISTORY_PERSON_ID` INT NULL,
  `HISTORY_ASSET_ID` INT NULL,
  PRIMARY KEY (`HISTORY_ID`),
  INDEX `fk_History_Person1_idx` (`HISTORY_PERSON_ID` ASC),
  INDEX `fk_History_Assets1_idx` (`HISTORY_ASSET_ID` ASC),
  CONSTRAINT `fk_History_Person1`
    FOREIGN KEY (`HISTORY_PERSON_ID`)
    REFERENCES `mydb`.`Person` (`PERSON_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_History_Assets1`
    FOREIGN KEY (`HISTORY_ASSET_ID`)
    REFERENCES `mydb`.`Assets` (`ASSET_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Working_place`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Working_place` (
  `WP_ID` INT NOT NULL,
  `FLOOR` VARCHAR(45) NULL,
  `WORKSTATION_NO` VARCHAR(45) NULL,
  `WP_PERSON_ID` INT NOT NULL,
  PRIMARY KEY (`WP_ID`),
  INDEX `fk_Working_place_Person1_idx` (`WP_PERSON_ID` ASC),
  CONSTRAINT `fk_Working_place_Person1`
    FOREIGN KEY (`WP_PERSON_ID`)
    REFERENCES `mydb`.`Person` (`PERSON_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
