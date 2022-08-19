-- ======================== Create table ===========================

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`EventCategory`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`EventCategory` ;

CREATE TABLE IF NOT EXISTS `mydb`.`EventCategory` (
  `eventCategoryId` INT NOT NULL AUTO_INCREMENT,
  `eventCategoryName` VARCHAR(100) NOT NULL,
  `eventCategoryDescription` VARCHAR(500) NULL,
  `eventDuration` INT NOT NULL,
  PRIMARY KEY (`eventCategoryId`),
  UNIQUE INDEX `eventCategoryName_UNIQUE` (`eventCategoryName` ASC) VISIBLE)
ENGINE = InnoDB CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mydb`.`Event`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Event` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Event` (
  `eventId` INT NOT NULL AUTO_INCREMENT,
  `bookingName` VARCHAR(100) NOT NULL,
  `bookingEmail` VARCHAR(100) NOT NULL,
  `eventStartTime` DATETIME NOT NULL,
  `eventDuration` INT NOT NULL,
  `eventNotes` VARCHAR(500) NULL,
  `eventCategoryId` INT NOT NULL,
  PRIMARY KEY (`eventId`),
  INDEX `fk_Event_EventCategory_idx` (`eventCategoryId` ASC) VISIBLE,
  CONSTRAINT `fk_Event_EventCategory`
    FOREIGN KEY (`eventCategoryId`)
    REFERENCES `mydb`.`EventCategory` (`eventCategoryId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


-- -----------------------------------------------------
-- Table `mydb`.`User`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`User` ;

CREATE TABLE IF NOT EXISTS `mydb`.`User` (
	`userID` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(100) NOT NULL,
    `email`  VARCHAR(50) NOT NULL,
    `role` enum('admin','lecturer','student') NOT NULL,
    `createdOn` datetime not null default current_timestamp ,
    `updatedOn` datetime not null default current_timestamp on update current_timestamp ,
    PRIMARY KEY(`userID`),
    UNIQUE INDEX `username_UNIQUE` (`name` ASC) VISIBLE,
	UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- ======================== Insert Data ===========================
-- eventcategory
use mydb;

INSERT INTO EventCategory (eventCategoryID,eventCategoryName,eventCategoryDescription,eventDuration)
VALUES (1,'Project Management Clinic', 'ตารางนัดหมายนี้ใช้สำหรับนัดหมาย project management clinic ในวิชา INT221 integrated project I ให้นักศึกษาเตรียมเอกสารที่เกี่ยวข้องเพื่อแสดงระหว่างขอคำปรึกษา', 30);

INSERT INTO EventCategory (eventCategoryID,eventCategoryName,eventCategoryDescription,eventDuration)
VALUES (2,'DevOps/Infra Clinic', 'Use this event category for DevOps/Infra clinic.', 20);

INSERT INTO EventCategory (eventCategoryID,eventCategoryName,eventCategoryDescription,eventDuration)
VALUES (3,'Database Clinic', 'ตารางนัดหมายนี้ใช้สำหรับนัดหมาย database clinic ในวิชา INT221 integrated project I', 15);

INSERT INTO EventCategory (eventCategoryID,eventCategoryName,eventCategoryDescription,eventDuration)
VALUES (4,'Client-side Clinic', 'ตารางนัดหมายนี้ใช้สำหรับนัดหมาย Client-side clinic ในวิชา INT221 integrated project I', 30);

INSERT INTO EventCategory (eventCategoryID,eventCategoryName,eventCategoryDescription,eventDuration)
VALUES (5,'Server-side Clinic', NULL, 30);

-- event

INSERT INTO Event (eventId,bookingName,bookingEmail,eventStartTime,eventDuration,eventNotes,eventCategoryId)
VALUES (1, 'Somchai Jaidee(OR-7)', 'somchai.jai@mail.kmutt.ac.th', '2022-05-23 13:30:00', 30, NULL, 2);

INSERT INTO Event (eventId,bookingName,bookingEmail,eventStartTime,eventDuration,eventNotes,eventCategoryId)
VALUES (2, 'Somsri Rakdee(SJ-3)', 'somsri.rak@mail.kmutt.ac.th', '2022-04-27 09:30:00', 30, 'ขอปรึกษาปัญหาเพื่อนไม่ช่วยงาน ', 1);

INSERT INTO Event (eventId,bookingName,bookingEmail,eventStartTime,eventDuration,eventNotes,eventCategoryId)
VALUES (3,'สมเกียรติ ขยันเรียน กลุ่ม TT-4','somkiat.kay@kmutt.ac.th','2022-05-23 16:30:00', 15, NULL , 3);

-- user

INSERT INTO user (name,email,role,createdOn,updatedOn)
VALUES ('OASIP ADMIN','oasip.admin@kmutt.ac.th','admin','2022-08-01 00:00:00+07:00','2022-08-01 00:00:00+07:00');

INSERT INTO user (name,email,role,createdOn,updatedOn)
VALUES ('Somchai Jaidee','somchai.jai@kmutt.ac.th','lecturer','2022-08-08 15:00:00+07:00','2022-08-08 15:00:00+07:00');

INSERT INTO user (name,email,role,createdOn,updatedOn)
VALUES ('Komkrid Rakdee','komkrid.rak@mail.kmutt.ac.th','student','2022-08-08 15:00:01+07:00','2022-08-08 15:00:01+07:00');

INSERT INTO user (name,email,role,createdOn,updatedOn)
VALUES ('สมเกียรติ ขยันเรียน','somkiat.kay@kmutt.ac.th','student','2022-08-16 09:00:00+07:00','2022-08-16 09:00:00+07:00');
