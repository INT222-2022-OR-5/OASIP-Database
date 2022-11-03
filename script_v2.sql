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
  `userId` INT NULL,
  PRIMARY KEY (`eventId`),
  INDEX `fk_Event_EventCategory_idx` (`eventCategoryId` ASC) VISIBLE,
  INDEX `fk_Event_User_idx` (`userId` ASC) VISIBLE,
  CONSTRAINT `fk_Event_EventCategory`
    FOREIGN KEY (`eventCategoryId`)
    REFERENCES `mydb`.`EventCategory` (`eventCategoryId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Event_User`
    FOREIGN KEY (`userId`)
    REFERENCES `mydb`.`User` (`userId`))
ENGINE = InnoDB CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `mydb`.`User`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`User` ;

CREATE TABLE IF NOT EXISTS `mydb`.`User` (
	`userID` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(100) NOT NULL,
    `email`  VARCHAR(50) NOT NULL,
    `password` VARCHAR(100) NOT NULL,
    `role` enum('admin','lecturer','student') DEFAULT 'student' NOT NULL,
    `createdOn` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
    `updatedOn` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP ,
    PRIMARY KEY(`userID`),
    UNIQUE INDEX `username_UNIQUE` (`name` ASC) VISIBLE,
	UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mydb`.`CategoryOwner`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`CategoryOwner` ;

CREATE TABLE IF NOT EXISTS `mydb`.`CategoryOwner` (
  `eventCategoryId` INT NOT NULL,
  `userId` INT NOT NULL,
  PRIMARY KEY (`userId`, `eventCategoryId`),
  INDEX `fk_user_has_eventcategory_eventcategory1_idx` (`eventCategoryId` ASC) VISIBLE,
  INDEX `fk_user_has_eventcategory_user1_idx` (`userId` ASC) VISIBLE,
  CONSTRAINT `fk_user_has_eventcategory_user1`
    FOREIGN KEY (`userId`)
    REFERENCES `mydb`.`User` (`userId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_eventcategory_eventcategory1`
    FOREIGN KEY (`eventCategoryId`)
    REFERENCES `mydb`.`EventCategory` (`eventCategoryId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

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

-- user
use mydb;

INSERT INTO User (userID,name,email,role,password,createdOn,updatedOn)
VALUES (1, 'OASIP ADMIN','oasip.admin@kmutt.ac.th','admin','$argon2id$v=19$m=4096,t=3,p=1$sYXzbUOqBoHY1NfhJ8cjnw$H6+adWySiFPgcUogJK3hEhcF6Y4fusy7tcXYEL+f0cQ','2022-08-01 00:00:00+07:00','2022-08-01 00:00:00+07:00');

INSERT INTO User (userID,name,email,role,password,createdOn,updatedOn)
VALUES (2, 'Olarn Rojanapornpun','olarn.roj@kmutt.ac.th','lecturer','$argon2id$v=19$m=4096,t=3,p=1$Sx7y2jxKZSjpWUV4srd8eg$AMH09iFiPQgAZ00cAdN3Gucqfhx2kRo3tQbHeLSR0RE','2022-08-08 15:00:00+07:00','2022-08-08 15:00:00+07:00');

INSERT INTO User (userID,name,email,role,password,createdOn,updatedOn)
VALUES (3, 'Pichet Limvachiranan','pichet.limv@kmutt.ac.th','lecturer','$argon2id$v=19$m=4096,t=3,p=1$46EB43gQ46Z1/EmdqxtKNA$7m6cWGO2iDlFl/ETDYuYf+ArnSjRnsNwXLIP18DTYQY','2022-08-08 15:00:01+07:00','2022-08-08 15:00:01+07:00');

INSERT INTO User (userID,name,email,role,password,createdOn,updatedOn)
VALUES (4, 'Umaporn Supasitthimethee','umaporn.sup@kmutt.ac.th','lecturer','$argon2id$v=19$m=4096,t=3,p=1$1Z2UK1zC76FIQeLH54GVAQ$qfXcHF31LnuWpt37QAcWyNp8PdbOQ+jjaV1xWXixS0M','2022-08-08 15:00:02+07:00','2022-08-08 15:00:02+07:00');

INSERT INTO User (userID,name,email,role,password,createdOn,updatedOn)
VALUES (5, 'Siam Yamsaengsung','siam.yam@kmutt.ac.th','lecturer','$argon2id$v=19$m=4096,t=3,p=1$C4pPaNWKTnZQX2mPs14jlg$rQ5W5NYKqGOu1B4GkUWq8cFbcg2peFWGjpUMr9Nkm8g','2022-08-08 15:00:03+07:00','2022-08-08 15:00:03+07:00');

INSERT INTO User (userID,name,email,role,password,createdOn,updatedOn)
VALUES (6, 'Sunisa Sathapornvajana','sunisa.sat@kmutt.ac.th','lecturer','$argon2id$v=19$m=4096,t=3,p=1$29/ffaszvjvi3CZO45bSCg$kKpfq5WEswoqa/LfyIZzQaQ6AFdjhyiYjXRCfMiTnwg','2022-08-08 15:00:04+07:00','2022-08-08 15:00:04+07:00');

INSERT INTO User (userID,name,email,role,password,createdOn,updatedOn)
VALUES (7, 'Somchai Jaidee','somchai.jai@kmutt.ac.th','student','$argon2id$v=19$m=4096,t=3,p=1$dmsOy7LPTjmooPu+P2oTZA$NZFTFd3f0K1Sp19aaUwyn3jgiy15yFcXhp8E4/1yXoI','2022-08-08 16:00:00+07:00','2022-08-08 16:00:00+07:00');

INSERT INTO User (userID,name,email,role,password,createdOn,updatedOn)
VALUES (8, 'Komkrid Rakdee','komkrid.rak@mail.kmutt.ac.th','student','$argon2id$v=19$m=4096,t=3,p=1$8W61ZOC5RU7sJP5kKRbSqg$OLwZNPeMqxp+g0Vbn+odcA47XMClFN+IswTueVah7F0','2022-08-08 16:00:00+07:00','2022-08-08 16:00:00+07:00');

INSERT INTO User (userID,name,email,role,password,createdOn,updatedOn)
VALUES (9, 'สมเกียรติ ขยันเรียน','somkiat.kay@kmutt.ac.th','student','$argon2id$v=19$m=4096,t=3,p=1$gBqgjspF45FcIKQEw8GmaQ$alrOCZ0YrDqOu8/aZiLDMGZo4vFkSEAXA0YoHhY0BDQ','2022-08-16 09:00:00+07:00','2022-08-16 09:00:00+07:00');

-- eventcategory_owner
INSERT INTO CategoryOwner (eventCategoryId,userId)
VALUES (1,2),(2,2),(2,5),(3,6),(4,4),(5,3),(5,2);

-- event
use mydb;

INSERT INTO Event (eventId,bookingName,bookingEmail,eventStartTime,eventDuration,eventNotes,eventCategoryId,userId)
VALUES (1, 'Somchai Jaidee(OR-7)', 'somchai.jai@mail.kmutt.ac.th', '2022-05-23 13:30:00', 30, NULL, 2, 7);

INSERT INTO Event (eventId,bookingName,bookingEmail,eventStartTime,eventDuration,eventNotes,eventCategoryId,userId)
VALUES (2, 'Somsri Rakdee(SJ-3)', 'somsri.rak@mail.kmutt.ac.th', '2022-04-27 09:30:00', 30, 'ขอปรึกษาปัญหาเพื่อนไม่ช่วยงาน ', 1, NULL);

INSERT INTO Event (eventId,bookingName,bookingEmail,eventStartTime,eventDuration,eventNotes,eventCategoryId,userId)
VALUES (3,'สมเกียรติ ขยันเรียน กลุ่ม TT-4','somkiat.kay@kmutt.ac.th','2022-05-23 16:30:00', 15, NULL , 3, 9);
