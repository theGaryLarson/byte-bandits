-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema targeted_marketing_pt_3
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `targeted_marketing_pt_3` ;

-- -----------------------------------------------------
-- Schema targeted_marketing_pt_3
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `targeted_marketing_pt_3` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `targeted_marketing_pt_3` ;

-- -----------------------------------------------------
-- Table `targeted_marketing_pt_3`.`core_profile`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing_pt_3`.`core_profile` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing_pt_3`.`core_profile` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `f_name` VARCHAR(255) NULL,
  `l_name` VARCHAR(255) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `targeted_marketing_pt_3`.`address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing_pt_3`.`address` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing_pt_3`.`address` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `core_id` INT NOT NULL,
  `street` VARCHAR(45) NOT NULL,
  `apt` VARCHAR(45) NULL DEFAULT NULL,
  `city` VARCHAR(45) NOT NULL,
  `state` VARCHAR(45) NOT NULL,
  `zip` VARCHAR(45) NOT NULL,
  `country` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `core_id` (`core_id` ASC) VISIBLE,
  CONSTRAINT `address_ibfk_1`
    FOREIGN KEY (`core_id`)
    REFERENCES `targeted_marketing_pt_3`.`core_profile` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `targeted_marketing_pt_3`.`alias`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing_pt_3`.`alias` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing_pt_3`.`alias` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `core_id` INT NOT NULL,
  `f_name` VARCHAR(45) NULL DEFAULT NULL,
  `l_name` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_alias_core_profile1_idx` (`core_id` ASC) VISIBLE,
  CONSTRAINT `fk_alias_core_profile1`
    FOREIGN KEY (`core_id`)
    REFERENCES `targeted_marketing_pt_3`.`core_profile` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `targeted_marketing_pt_3`.`email`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing_pt_3`.`email` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing_pt_3`.`email` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `core_id` INT NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `core_id` (`core_id` ASC) VISIBLE,
  CONSTRAINT `email_ibfk_1`
    FOREIGN KEY (`core_id`)
    REFERENCES `targeted_marketing_pt_3`.`core_profile` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `targeted_marketing_pt_3`.`social_media_platform`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing_pt_3`.`social_media_platform` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing_pt_3`.`social_media_platform` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `platform` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `targeted_marketing_pt_3`.`social_media`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing_pt_3`.`social_media` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing_pt_3`.`social_media` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `core_id` INT NOT NULL,
  `sm_platform_id` INT NOT NULL,
  `user_guid` VARCHAR(255) NOT NULL,
  `url` VARCHAR(255) NULL,
  `last_active` DATE NULL,
  PRIMARY KEY (`id`),
  INDEX `core_id` (`core_id` ASC) VISIBLE,
  INDEX `sm_platform_id` (`sm_platform_id` ASC) VISIBLE,
  CONSTRAINT `social_media_ibfk_1`
    FOREIGN KEY (`core_id`)
    REFERENCES `targeted_marketing_pt_3`.`core_profile` (`id`),
  CONSTRAINT `social_media_ibfk_2`
    FOREIGN KEY (`sm_platform_id`)
    REFERENCES `targeted_marketing_pt_3`.`social_media_platform` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `targeted_marketing_pt_3`.`friend`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing_pt_3`.`friend` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing_pt_3`.`friend` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `social_media_id` INT NOT NULL,
  `core_profile_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_friend_social_media1_idx` (`social_media_id` ASC) VISIBLE,
  INDEX `fk_friend_core_profile1_idx` (`core_profile_id` ASC) VISIBLE,
  CONSTRAINT `fk_friend_core_profile1`
    FOREIGN KEY (`core_profile_id`)
    REFERENCES `targeted_marketing_pt_3`.`core_profile` (`id`),
  CONSTRAINT `fk_friend_social_media1`
    FOREIGN KEY (`social_media_id`)
    REFERENCES `targeted_marketing_pt_3`.`social_media` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `targeted_marketing_pt_3`.`group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing_pt_3`.`group` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing_pt_3`.`group` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `social_media_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(144) NULL DEFAULT NULL,
  `group_url` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`, `social_media_id`),
  INDEX `fk_group_social_media1_idx` (`social_media_id` ASC) VISIBLE,
  CONSTRAINT `fk_group_social_media1`
    FOREIGN KEY (`social_media_id`)
    REFERENCES `targeted_marketing_pt_3`.`social_media` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `targeted_marketing_pt_3`.`ip`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing_pt_3`.`ip` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing_pt_3`.`ip` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `core_id` INT NOT NULL,
  `ip_address` VARCHAR(45) NOT NULL,
  `is_v4` BIT(1) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_url_core_profile1_idx` (`core_id` ASC) VISIBLE,
  CONSTRAINT `fk_url_core_profile1`
    FOREIGN KEY (`core_id`)
    REFERENCES `targeted_marketing_pt_3`.`core_profile` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `targeted_marketing_pt_3`.`ip_location`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing_pt_3`.`ip_location` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing_pt_3`.`ip_location` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `ip_id` INT NOT NULL,
  `city` VARCHAR(45) NULL DEFAULT NULL,
  `state` VARCHAR(45) NULL DEFAULT NULL,
  `zip` VARCHAR(45) NULL DEFAULT NULL,
  `country` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_ip_location_ip1_idx` (`ip_id` ASC) VISIBLE,
  CONSTRAINT `fk_ip_location_ip1`
    FOREIGN KEY (`ip_id`)
    REFERENCES `targeted_marketing_pt_3`.`ip` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `targeted_marketing_pt_3`.`like`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing_pt_3`.`like` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing_pt_3`.`like` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `social_media_id` INT NOT NULL,
  `content` VARCHAR(144) NOT NULL,
  `liked_url` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_like_social_media1_idx` (`social_media_id` ASC) VISIBLE,
  CONSTRAINT `fk_like_social_media1`
    FOREIGN KEY (`social_media_id`)
    REFERENCES `targeted_marketing_pt_3`.`social_media` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `targeted_marketing_pt_3`.`phone`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing_pt_3`.`phone` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing_pt_3`.`phone` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `core_id` INT NOT NULL,
  `country_code` VARCHAR(5) NOT NULL,
  `area_code` INT NOT NULL,
  `extension` INT NOT NULL,
  `line_number` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `core_id` (`core_id` ASC) VISIBLE,
  CONSTRAINT `phone_ibfk_1`
    FOREIGN KEY (`core_id`)
    REFERENCES `targeted_marketing_pt_3`.`core_profile` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `targeted_marketing_pt_3`.`post`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing_pt_3`.`post` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing_pt_3`.`post` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `social_media_id` INT NOT NULL,
  `content` VARCHAR(144) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_post_social_media1_idx` (`social_media_id` ASC) VISIBLE,
  CONSTRAINT `fk_post_social_media1`
    FOREIGN KEY (`social_media_id`)
    REFERENCES `targeted_marketing_pt_3`.`social_media` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `targeted_marketing_pt_3`.`product_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing_pt_3`.`product_type` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing_pt_3`.`product_type` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `targeted_marketing_pt_3`.`product`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing_pt_3`.`product` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing_pt_3`.`product` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `product_name` VARCHAR(255) NOT NULL,
  `product_type_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `product_type_id` (`product_type_id` ASC) VISIBLE,
  CONSTRAINT `products_ibfk_1`
    FOREIGN KEY (`product_type_id`)
    REFERENCES `targeted_marketing_pt_3`.`product_type` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 31
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `targeted_marketing_pt_3`.`seller`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing_pt_3`.`seller` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing_pt_3`.`seller` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `seller` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `targeted_marketing_pt_3`.`product_by_seller`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing_pt_3`.`product_by_seller` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing_pt_3`.`product_by_seller` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `product_id` INT NOT NULL,
  `seller_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_product_has_seller_seller1_idx` (`seller_id` ASC) VISIBLE,
  INDEX `fk_product_has_seller_product1_idx` (`product_id` ASC) VISIBLE,
  CONSTRAINT `fk_product_has_seller_product1`
    FOREIGN KEY (`product_id`)
    REFERENCES `targeted_marketing_pt_3`.`product` (`id`),
  CONSTRAINT `fk_product_has_seller_seller1`
    FOREIGN KEY (`seller_id`)
    REFERENCES `targeted_marketing_pt_3`.`seller` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `targeted_marketing_pt_3`.`gender_look_up`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing_pt_3`.`gender_look_up` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing_pt_3`.`gender_look_up` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `identity` VARCHAR(45) NOT NULL,
  `acronym` VARCHAR(4) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `targeted_marketing_pt_3`.`profile_data`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing_pt_3`.`profile_data` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing_pt_3`.`profile_data` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `core_id` INT NOT NULL,
  `gender_id` INT NOT NULL,
  `ethnicity` VARCHAR(45) NULL DEFAULT NULL,
  `birthdate` DATE NULL DEFAULT NULL,
  `marital_status` ENUM('Single', 'Separated', 'Divorced', 'Married', 'Widowed') NULL DEFAULT NULL,
  `education` VARCHAR(144) NULL,
  `occupation` VARCHAR(144) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_meta_data_core_profile1_idx` (`core_id` ASC) VISIBLE,
  INDEX `fk_profile_data_gender_look_up1_idx` (`gender_id` ASC) VISIBLE,
  CONSTRAINT `fk_meta_data_core_profile1`
    FOREIGN KEY (`core_id`)
    REFERENCES `targeted_marketing_pt_3`.`core_profile` (`id`),
  CONSTRAINT `fk_profile_data_gender_look_up1`
    FOREIGN KEY (`gender_id`)
    REFERENCES `targeted_marketing_pt_3`.`gender_look_up` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `targeted_marketing_pt_3`.`profile_product`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing_pt_3`.`profile_product` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing_pt_3`.`profile_product` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `core_id` INT NOT NULL,
  `product_by_seller_id` INT NOT NULL,
  `rating` INT NOT NULL,
  `last_purchased` DATE NOT NULL,
  `price_paid` DECIMAL(10,2) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `core_id` (`core_id` ASC) VISIBLE,
  INDEX `fk_profile_product_product_by_seller1_idx` (`product_by_seller_id` ASC) VISIBLE,
  CONSTRAINT `fk_profile_product_product_by_seller1`
    FOREIGN KEY (`product_by_seller_id`)
    REFERENCES `targeted_marketing_pt_3`.`product_by_seller` (`id`),
  CONSTRAINT `profile_products_ibfk_1`
    FOREIGN KEY (`core_id`)
    REFERENCES `targeted_marketing_pt_3`.`core_profile` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `targeted_marketing_pt_3`.`service_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing_pt_3`.`service_type` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing_pt_3`.`service_type` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `category` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `targeted_marketing_pt_3`.`service`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing_pt_3`.`service` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing_pt_3`.`service` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `category_id` INT NOT NULL,
  `service` VARCHAR(144) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `category_id` (`category_id` ASC) VISIBLE,
  CONSTRAINT `services_ibfk_1`
    FOREIGN KEY (`category_id`)
    REFERENCES `targeted_marketing_pt_3`.`service_type` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `targeted_marketing_pt_3`.`profile_service`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing_pt_3`.`profile_service` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing_pt_3`.`profile_service` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `core_id` INT NOT NULL,
  `service_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `core_id` (`core_id` ASC) VISIBLE,
  INDEX `services_id` (`service_id` ASC) VISIBLE,
  CONSTRAINT `profile_services_ibfk_1`
    FOREIGN KEY (`core_id`)
    REFERENCES `targeted_marketing_pt_3`.`core_profile` (`id`),
  CONSTRAINT `profile_services_ibfk_2`
    FOREIGN KEY (`service_id`)
    REFERENCES `targeted_marketing_pt_3`.`service` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `targeted_marketing_pt_3`.`sm_item_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing_pt_3`.`sm_item_type` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing_pt_3`.`sm_item_type` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `targeted_marketing_pt_3`.`sm_item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing_pt_3`.`sm_item` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing_pt_3`.`sm_item` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `type_id` INT NOT NULL,
  `item` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`, `type_id`),
  INDEX `fk_sm_item_sm_item_type1_idx` (`type_id` ASC) VISIBLE,
  CONSTRAINT `fk_sm_item_sm_item_type1`
    FOREIGN KEY (`type_id`)
    REFERENCES `targeted_marketing_pt_3`.`sm_item_type` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `targeted_marketing_pt_3`.`sm_transaction`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing_pt_3`.`sm_transaction` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing_pt_3`.`sm_transaction` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `core_id` INT NOT NULL,
  `smp_id` INT NOT NULL,
  `price_paid` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Transactions_core_profile1_idx` (`core_id` ASC) VISIBLE,
  INDEX `fk_Transactions_social_media_platforms1_idx` (`smp_id` ASC) VISIBLE,
  CONSTRAINT `fk_Transactions_core_profile1`
    FOREIGN KEY (`core_id`)
    REFERENCES `targeted_marketing_pt_3`.`core_profile` (`id`),
  CONSTRAINT `fk_Transactions_social_media_platforms1`
    FOREIGN KEY (`smp_id`)
    REFERENCES `targeted_marketing_pt_3`.`social_media_platform` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `targeted_marketing_pt_3`.`sm_seller`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing_pt_3`.`sm_seller` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing_pt_3`.`sm_seller` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `seller` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `targeted_marketing_pt_3`.`sm_item_by_seller`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing_pt_3`.`sm_item_by_seller` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing_pt_3`.`sm_item_by_seller` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `sm_transaction_id` INT NOT NULL,
  `sm_seller_id` INT NOT NULL,
  `sm_item_id` INT NOT NULL,
  `price` DECIMAL(10,2) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_sm_seller_has_sm_item_sm_item1_idx` (`sm_item_id` ASC) VISIBLE,
  INDEX `fk_sm_seller_has_sm_item_sm_seller1_idx` (`sm_seller_id` ASC) VISIBLE,
  INDEX `fk_sm_seller_has_item_sm_transaction1_idx` (`sm_transaction_id` ASC) VISIBLE,
  CONSTRAINT `fk_sm_seller_has_item_sm_transaction1`
    FOREIGN KEY (`sm_transaction_id`)
    REFERENCES `targeted_marketing_pt_3`.`sm_transaction` (`id`),
  CONSTRAINT `fk_sm_seller_has_sm_item_sm_item1`
    FOREIGN KEY (`sm_item_id`)
    REFERENCES `targeted_marketing_pt_3`.`sm_item` (`id`),
  CONSTRAINT `fk_sm_seller_has_sm_item_sm_seller1`
    FOREIGN KEY (`sm_seller_id`)
    REFERENCES `targeted_marketing_pt_3`.`sm_seller` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `targeted_marketing_pt_3`.`occupation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing_pt_3`.`occupation` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing_pt_3`.`occupation` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `core_profile_id` INT NOT NULL,
  `job_title` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_occupation_core_profile1_idx` (`core_profile_id` ASC) VISIBLE,
  CONSTRAINT `fk_occupation_core_profile1`
    FOREIGN KEY (`core_profile_id`)
    REFERENCES `targeted_marketing_pt_3`.`core_profile` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `targeted_marketing_pt_3`.`social_mate_preference`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing_pt_3`.`social_mate_preference` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing_pt_3`.`social_mate_preference` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `core_profile_id` INT NOT NULL,
  `gender_id` INT NOT NULL,
  `political_affiliation` VARCHAR(45) NULL,
  `religious_affiliation` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_social_mate_preference_core_profile1_idx` (`core_profile_id` ASC) VISIBLE,
  INDEX `fk_social_mate_preference_gender_look_up1_idx` (`gender_id` ASC) VISIBLE,
  CONSTRAINT `fk_social_mate_preference_core_profile1`
    FOREIGN KEY (`core_profile_id`)
    REFERENCES `targeted_marketing_pt_3`.`core_profile` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_social_mate_preference_gender_look_up1`
    FOREIGN KEY (`gender_id`)
    REFERENCES `targeted_marketing_pt_3`.`gender_look_up` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `targeted_marketing_pt_3`.`bendover_data_feed`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing_pt_3`.`bendover_data_feed` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing_pt_3`.`bendover_data_feed` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `bendover_id` VARCHAR(144) NULL,
  `first_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `political_affiliation` VARCHAR(45) NULL,
  `political_intensity` INT NULL,
  `religious_affiliation` VARCHAR(45) NULL,
  `religious_intensity` INT NULL,
  `social_issue_views` VARCHAR(200) NULL,
  `social_issue_post_date` VARCHAR(200) NULL,
  `social_issue_view_intensity` VARCHAR(200) NULL,
  `social_mate_preference` VARCHAR(200) NULL,
  `gender` VARCHAR(3) NULL,
  `birthdate` DATE NULL,
  `location` VARCHAR(45) NULL,
  `education` VARCHAR(144) NULL,
  `occupation` VARCHAR(144) NULL,
  `hobbies` VARCHAR(200) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `targeted_marketing_pt_3`.`hobby_look_up`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing_pt_3`.`hobby_look_up` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing_pt_3`.`hobby_look_up` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `hobby_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `targeted_marketing_pt_3`.`profile_hobby`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing_pt_3`.`profile_hobby` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing_pt_3`.`profile_hobby` (
  `core_id` INT NOT NULL,
  `hobby_id` INT NOT NULL,
  INDEX `fk_profile_hobby_core_profile1_idx` (`core_id` ASC) VISIBLE,
  INDEX `fk_profile_hobby_hobby1_idx` (`hobby_id` ASC) VISIBLE,
  CONSTRAINT `fk_profile_hobby_core_profile1`
    FOREIGN KEY (`core_id`)
    REFERENCES `targeted_marketing_pt_3`.`core_profile` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_profile_hobby_hobby1`
    FOREIGN KEY (`hobby_id`)
    REFERENCES `targeted_marketing_pt_3`.`hobby_look_up` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `targeted_marketing_pt_3`.`social_issue_view_type_look_up`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing_pt_3`.`social_issue_view_type_look_up` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing_pt_3`.`social_issue_view_type_look_up` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `targeted_marketing_pt_3`.`social_issue_view_look_up`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing_pt_3`.`social_issue_view_look_up` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing_pt_3`.`social_issue_view_look_up` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `view` VARCHAR(144) NOT NULL,
  `view_type_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_social_issue_view_look_up_social_issue_view_type_look_up_idx` (`view_type_id` ASC) VISIBLE,
  CONSTRAINT `fk_social_issue_view_look_up_social_issue_view_type_look_up1`
    FOREIGN KEY (`view_type_id`)
    REFERENCES `targeted_marketing_pt_3`.`social_issue_view_type_look_up` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `targeted_marketing_pt_3`.`social_issue_view_by_platform`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing_pt_3`.`social_issue_view_by_platform` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing_pt_3`.`social_issue_view_by_platform` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `social_media_platform_id` INT NOT NULL,
  `social_issue_view_type_look_up_id` INT NOT NULL,
  INDEX `fk_social_media_platform_has_social_issue_view_look_up_soci_idx1` (`social_media_platform_id` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  INDEX `fk_social_issue_view_by_platform_social_issue_view_type_loo_idx` (`social_issue_view_type_look_up_id` ASC) VISIBLE,
  CONSTRAINT `fk_social_media_platform_has_social_issue_view_look_up_social1`
    FOREIGN KEY (`social_media_platform_id`)
    REFERENCES `targeted_marketing_pt_3`.`social_media_platform` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_social_issue_view_by_platform_social_issue_view_type_look_1`
    FOREIGN KEY (`social_issue_view_type_look_up_id`)
    REFERENCES `targeted_marketing_pt_3`.`social_issue_view_type_look_up` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `targeted_marketing_pt_3`.`core_profile_has_social_issue_view`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing_pt_3`.`core_profile_has_social_issue_view` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing_pt_3`.`core_profile_has_social_issue_view` (
  `id` INT NOT NULL,
  `core_profile_id` INT NOT NULL,
  `social_issue_view_look_up_id` INT NOT NULL,
  `intensity` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_core_profile_has_social_issue_view_look_up_social_issue__idx` (`social_issue_view_look_up_id` ASC) VISIBLE,
  INDEX `fk_core_profile_has_social_issue_view_look_up_core_profile1_idx` (`core_profile_id` ASC) VISIBLE,
  CONSTRAINT `fk_core_profile_has_social_issue_view_look_up_core_profile1`
    FOREIGN KEY (`core_profile_id`)
    REFERENCES `targeted_marketing_pt_3`.`core_profile` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_core_profile_has_social_issue_view_look_up_social_issue_vi1`
    FOREIGN KEY (`social_issue_view_look_up_id`)
    REFERENCES `targeted_marketing_pt_3`.`social_issue_view_look_up` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `targeted_marketing_pt_3`.`social_issue_view_transaction`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing_pt_3`.`social_issue_view_transaction` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing_pt_3`.`social_issue_view_transaction` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `core_profile_has_social_issue_view_id` INT NOT NULL,
  `timestamp` DATE NOT NULL,
  `prev_intensity` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_social_issue_view_transaction_core_profile_has_social_is_idx` (`core_profile_has_social_issue_view_id` ASC) VISIBLE,
  CONSTRAINT `fk_social_issue_view_transaction_core_profile_has_social_issu1`
    FOREIGN KEY (`core_profile_has_social_issue_view_id`)
    REFERENCES `targeted_marketing_pt_3`.`core_profile_has_social_issue_view` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `targeted_marketing_pt_3`.`political_affiliation_look_up`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing_pt_3`.`political_affiliation_look_up` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing_pt_3`.`political_affiliation_look_up` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `affiliation` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `targeted_marketing_pt_3`.`core_profile_has_political_affiliation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing_pt_3`.`core_profile_has_political_affiliation` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing_pt_3`.`core_profile_has_political_affiliation` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `core_profile_id` INT NOT NULL,
  `political_affiliation_look_up_id` INT NOT NULL,
  `intensity` INT NOT NULL,
  INDEX `fk_core_profile_has_political_affiliation_look_up_political_idx` (`political_affiliation_look_up_id` ASC) VISIBLE,
  INDEX `fk_core_profile_has_political_affiliation_look_up_core_prof_idx` (`core_profile_id` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_core_profile_has_political_affiliation_look_up_core_profile1`
    FOREIGN KEY (`core_profile_id`)
    REFERENCES `targeted_marketing_pt_3`.`core_profile` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_core_profile_has_political_affiliation_look_up_political_a1`
    FOREIGN KEY (`political_affiliation_look_up_id`)
    REFERENCES `targeted_marketing_pt_3`.`political_affiliation_look_up` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `targeted_marketing_pt_3`.`political_transaction`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing_pt_3`.`political_transaction` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing_pt_3`.`political_transaction` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `core_profile_has_political_affiliation_id` INT NOT NULL,
  `timestamp` DATE NOT NULL,
  `prev_intensity` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_political_transaction_core_profile_has_political_affilia_idx` (`core_profile_has_political_affiliation_id` ASC) VISIBLE,
  CONSTRAINT `fk_political_transaction_core_profile_has_political_affiliati1`
    FOREIGN KEY (`core_profile_has_political_affiliation_id`)
    REFERENCES `targeted_marketing_pt_3`.`core_profile_has_political_affiliation` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `targeted_marketing_pt_3`.`religious_affiliation_look_up`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing_pt_3`.`religious_affiliation_look_up` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing_pt_3`.`religious_affiliation_look_up` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `affiliation` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `targeted_marketing_pt_3`.`core_profile_has_religious_affiliation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing_pt_3`.`core_profile_has_religious_affiliation` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing_pt_3`.`core_profile_has_religious_affiliation` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `religious_affiliation_look_up_id` INT NOT NULL,
  `core_profile_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_core_profile_has_religious_affiliation_religious_affilia_idx` (`religious_affiliation_look_up_id` ASC) VISIBLE,
  INDEX `fk_core_profile_has_religious_affiliation_core_profile1_idx` (`core_profile_id` ASC) VISIBLE,
  CONSTRAINT `fk_core_profile_has_religious_affiliation_religious_affiliati1`
    FOREIGN KEY (`religious_affiliation_look_up_id`)
    REFERENCES `targeted_marketing_pt_3`.`religious_affiliation_look_up` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_core_profile_has_religious_affiliation_core_profile1`
    FOREIGN KEY (`core_profile_id`)
    REFERENCES `targeted_marketing_pt_3`.`core_profile` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `targeted_marketing_pt_3`.`religious_transaction`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing_pt_3`.`religious_transaction` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing_pt_3`.`religious_transaction` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `core_profile_has_religious_affiliation_id` INT NOT NULL,
  `timestamp` DATE NOT NULL,
  `prev_intensity` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_religious_transaction_core_profile_has_religious_affilia_idx` (`core_profile_has_religious_affiliation_id` ASC) VISIBLE,
  CONSTRAINT `fk_religious_transaction_core_profile_has_religious_affiliati1`
    FOREIGN KEY (`core_profile_has_religious_affiliation_id`)
    REFERENCES `targeted_marketing_pt_3`.`core_profile_has_religious_affiliation` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
