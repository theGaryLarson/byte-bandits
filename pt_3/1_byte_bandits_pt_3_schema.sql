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
  `f_name` VARCHAR(255) NULL DEFAULT NULL,
  `l_name` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 20
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
AUTO_INCREMENT = 17
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
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `targeted_marketing_pt_3`.`bendover_data_feed`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing_pt_3`.`bendover_data_feed` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing_pt_3`.`bendover_data_feed` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `bendover_id` VARCHAR(144) NULL DEFAULT NULL,
  `first_name` VARCHAR(45) NULL DEFAULT NULL,
  `last_name` VARCHAR(45) NULL DEFAULT NULL,
  `email` VARCHAR(45) NULL DEFAULT NULL,
  `political_affiliation` VARCHAR(45) NULL DEFAULT NULL,
  `political_intensity` INT NULL DEFAULT NULL,
  `religious_affiliation` VARCHAR(45) NULL DEFAULT NULL,
  `religious_intensity` INT NULL DEFAULT NULL,
  `social_issue_views` VARCHAR(200) NULL DEFAULT NULL,
  `social_issue_post_date` VARCHAR(200) NULL DEFAULT NULL,
  `social_issue_view_intensity` VARCHAR(200) NULL DEFAULT NULL,
  `social_mate_preference` VARCHAR(200) NULL DEFAULT NULL,
  `gender` VARCHAR(3) NULL DEFAULT NULL,
  `birthdate` DATE NULL DEFAULT NULL,
  `location` VARCHAR(45) NULL DEFAULT NULL,
  `education` VARCHAR(144) NULL DEFAULT NULL,
  `occupation` VARCHAR(144) NULL DEFAULT NULL,
  `hobbies` VARCHAR(200) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
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
AUTO_INCREMENT = 20
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
AUTO_INCREMENT = 16
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
  `url` VARCHAR(255) NULL DEFAULT NULL,
  `last_active` DATE NULL DEFAULT NULL,
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
AUTO_INCREMENT = 16
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
AUTO_INCREMENT = 6
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
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `targeted_marketing_pt_3`.`hobby`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing_pt_3`.`hobby` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing_pt_3`.`hobby` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `hobby_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
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
AUTO_INCREMENT = 6
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
AUTO_INCREMENT = 6
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
AUTO_INCREMENT = 6
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
    REFERENCES `targeted_marketing_pt_3`.`core_profile` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `targeted_marketing_pt_3`.`sm_opinion_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing_pt_3`.`sm_opinion_type` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing_pt_3`.`sm_opinion_type` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 19
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `targeted_marketing_pt_3`.`opinion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing_pt_3`.`opinion` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing_pt_3`.`opinion` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `smo_type_id` INT NOT NULL,
  `opinion` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `smo_type_id` (`smo_type_id` ASC) VISIBLE,
  CONSTRAINT `opinions_ibfk_1`
    FOREIGN KEY (`smo_type_id`)
    REFERENCES `targeted_marketing_pt_3`.`sm_opinion_type` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 23
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `targeted_marketing_pt_3`.`phone`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing_pt_3`.`phone` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing_pt_3`.`phone` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `core_id` INT NOT NULL,
  `phone_num` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `core_id` (`core_id` ASC) VISIBLE,
  CONSTRAINT `phone_ibfk_1`
    FOREIGN KEY (`core_id`)
    REFERENCES `targeted_marketing_pt_3`.`core_profile` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 16
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
AUTO_INCREMENT = 6
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
AUTO_INCREMENT = 16
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
AUTO_INCREMENT = 36
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
AUTO_INCREMENT = 6
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
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `targeted_marketing_pt_3`.`profile_data`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing_pt_3`.`profile_data` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing_pt_3`.`profile_data` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `core_id` INT NOT NULL,
  `gender` VARCHAR(20) NULL DEFAULT NULL,
  `ethnicity` VARCHAR(45) NULL DEFAULT NULL,
  `birthdate` DATE NULL DEFAULT NULL,
  `marital_status` ENUM('Single', 'Separated', 'Divorced', 'Married', 'Widowed') NULL DEFAULT NULL,
  `education` VARCHAR(144) NULL DEFAULT NULL,
  `occupation` VARCHAR(144) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_meta_data_core_profile1_idx` (`core_id` ASC) VISIBLE,
  CONSTRAINT `fk_meta_data_core_profile1`
    FOREIGN KEY (`core_id`)
    REFERENCES `targeted_marketing_pt_3`.`core_profile` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 9
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


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
    REFERENCES `targeted_marketing_pt_3`.`core_profile` (`id`),
  CONSTRAINT `fk_profile_hobby_hobby1`
    FOREIGN KEY (`hobby_id`)
    REFERENCES `targeted_marketing_pt_3`.`hobby` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `targeted_marketing_pt_3`.`profile_opinion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing_pt_3`.`profile_opinion` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing_pt_3`.`profile_opinion` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `core_id` INT NOT NULL,
  `opinion_id` INT NOT NULL,
  `date` DATE NOT NULL,
  `intensity` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `core_id` (`core_id` ASC) VISIBLE,
  INDEX `opinion_id` (`opinion_id` ASC) VISIBLE,
  CONSTRAINT `profile_opinions_ibfk_1`
    FOREIGN KEY (`core_id`)
    REFERENCES `targeted_marketing_pt_3`.`core_profile` (`id`),
  CONSTRAINT `profile_opinions_ibfk_2`
    FOREIGN KEY (`opinion_id`)
    REFERENCES `targeted_marketing_pt_3`.`opinion` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 24
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
AUTO_INCREMENT = 16
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
AUTO_INCREMENT = 10
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
AUTO_INCREMENT = 20
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
AUTO_INCREMENT = 17
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
AUTO_INCREMENT = 6
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
AUTO_INCREMENT = 6
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
AUTO_INCREMENT = 6
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
AUTO_INCREMENT = 6
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
  `price` DECIMAL(10,2) NULL DEFAULT NULL,
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
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `targeted_marketing_pt_3`.`sm_opinion_type_by_platform`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing_pt_3`.`sm_opinion_type_by_platform` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing_pt_3`.`sm_opinion_type_by_platform` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `sm_opinion_type_id` INT NOT NULL,
  `social_media_platform_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_sm_opinions_category_has_social_media_platform_social_me_idx` (`social_media_platform_id` ASC) VISIBLE,
  INDEX `fk_sm_opinions_category_has_social_media_platform_sm_opinio_idx` (`sm_opinion_type_id` ASC) VISIBLE,
  CONSTRAINT `fk_sm_opinions_category_has_social_media_platform_sm_opinions1`
    FOREIGN KEY (`sm_opinion_type_id`)
    REFERENCES `targeted_marketing_pt_3`.`sm_opinion_type` (`id`),
  CONSTRAINT `fk_sm_opinions_category_has_social_media_platform_social_medi1`
    FOREIGN KEY (`social_media_platform_id`)
    REFERENCES `targeted_marketing_pt_3`.`social_media_platform` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 26
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `targeted_marketing_pt_3`.`social_mate_preference`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing_pt_3`.`social_mate_preference` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing_pt_3`.`social_mate_preference` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `core_profile_id` INT NOT NULL,
  `political_affiliation` VARCHAR(45) NULL DEFAULT NULL,
  `religious_affiliation` VARCHAR(45) NULL DEFAULT NULL,
  `gender` VARCHAR(4) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_social_mate_preference_core_profile1_idx` (`core_profile_id` ASC) VISIBLE,
  CONSTRAINT `fk_social_mate_preference_core_profile1`
    FOREIGN KEY (`core_profile_id`)
    REFERENCES `targeted_marketing_pt_3`.`core_profile` (`id`))
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
-- Table `targeted_marketing_pt_3`.`political_transaction`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing_pt_3`.`political_transaction` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing_pt_3`.`political_transaction` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `profile_opinion_has_political_affiliation_id` INT NOT NULL,
  `time_stamp` DATE NOT NULL,
  `prev_intensity` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_political_transactions_profile_opinion_has_political_aff_idx` (`profile_opinion_has_political_affiliation_id` ASC) VISIBLE,
  CONSTRAINT `fk_political_transactions_profile_opinion_has_political_affil1`
    FOREIGN KEY (`profile_opinion_has_political_affiliation_id`)
    REFERENCES `targeted_marketing`.`profile_opinion_has_political_affiliation` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `targeted_marketing_pt_3`.`religious_transactions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing_pt_3`.`religious_transactions` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing_pt_3`.`religious_transactions` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `profile_opinion_has_religious_affiliation_id` INT NOT NULL,
  `time_stamp` DATE NOT NULL,
  `prev_intensity` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_religious_transactions_profile_opinion_has_religious_aff_idx` (`profile_opinion_has_religious_affiliation_id` ASC) VISIBLE,
  CONSTRAINT `fk_religious_transactions_profile_opinion_has_religious_affil1`
    FOREIGN KEY (`profile_opinion_has_religious_affiliation_id`)
    REFERENCES `targeted_marketing`.`profile_opinion_has_religious_affiliation` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `targeted_marketing_pt_3`.`social_issue_transaction`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing_pt_3`.`social_issue_transaction` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing_pt_3`.`social_issue_transaction` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `profile_opinion_has_social_issue_view_id` INT NOT NULL,
  `time_stamp` DATE NOT NULL,
  `prev_intensity` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_social_issue_transactions_profile_opinion_has_social_iss_idx` (`profile_opinion_has_social_issue_view_id` ASC) VISIBLE,
  CONSTRAINT `fk_social_issue_transactions_profile_opinion_has_social_issue1`
    FOREIGN KEY (`profile_opinion_has_social_issue_view_id`)
    REFERENCES `targeted_marketing`.`profile_opinion_has_social_issue_view` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `targeted_marketing_pt_3` ;

-- -----------------------------------------------------
-- Placeholder table for view `targeted_marketing_pt_3`.`profile_data_view`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `targeted_marketing_pt_3`.`profile_data_view` (`Core id` INT, `f_name` INT, `l_name` INT, `Profile Data id` INT, `gender` INT, `Age` INT, `Latest Education` INT, `Current Occupation` INT);

-- -----------------------------------------------------
-- Placeholder table for view `targeted_marketing_pt_3`.`profile_opinion_view`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `targeted_marketing_pt_3`.`profile_opinion_view` (`Core id` INT, `f_name` INT, `l_name` INT, `Category` INT, `opinion_id` INT, `opinion` INT, `intensity` INT, `Post-date` INT);

-- -----------------------------------------------------
-- procedure bendover_driver
-- -----------------------------------------------------

USE `targeted_marketing_pt_3`;
DROP procedure IF EXISTS `targeted_marketing_pt_3`.`bendover_driver`;

DELIMITER $$
USE `targeted_marketing_pt_3`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `bendover_driver`()
BEGIN
-- each field from bendover_data_feed_table needed to store fetch from cursor data
DECLARE curr_primary_key					INT;
DECLARE curr_bendover_id					VARCHAR(200);
DECLARE curr_f_name							VARCHAR(45);
DECLARE curr_l_name							VARCHAR(45);
DECLARE curr_email							VARCHAR(45);
DECLARE curr_political_affil				VARCHAR(45);
DECLARE curr_political_intensity			INT;
DECLARE curr_religious_affil				VARCHAR(45);
DECLARE curr_religious_intensity			INT;
DECLARE curr_social_issue_views				VARCHAR(200);
DECLARE curr_social_issue_date				VARCHAR(200);
DECLARE curr_social_issue_view_intensity	VARCHAR(200);
DECLARE curr_social_mate_pref				VARCHAR(200);
DECLARE curr_gender							VARCHAR(3);
DECLARE curr_birthdate						DATE;
DECLARE curr_location						VARCHAR(45);
DECLARE curr_education						VARCHAR(144);
DECLARE curr_occupation						VARCHAR(144);
DECLARE curr_hobbies						VARCHAR(200);

-- fields needed for inserts into tables
DECLARE platform_id						INT; # BENDOVER
DECLARE curr_opinion_type_id			INT; # POLITICS, CLIMATE-CHANGE, RELIGION, etc.
DECLARE curr_profile_id					INT; # CORE PROFILE PRIMARY KEY
DECLARE curr_opinion_id					INT; # OPINION ID TO BE USED IN PROFILE_OPINION SO AN INTENSITY CAN BE ASSOCIATED

DECLARE cur CURSOR FOR
SELECT *
FROM bendover_data_feed;

DECLARE CONTINUE HANDLER FOR NOT FOUND
    SET @done = TRUE;

# initialize variables that will be used for scope of driver call
# todo: create a method that checks if platform exists, if not adds it then returns PK
SELECT id INTO platform_id
FROM social_media_platform
WHERE platform = 'BENDOVER';

# populate core profile names first to generate needed primary keys for FK dependencies
-- todo: this method will handle duplicates and aliases ... eventually
CALL insert_bendover_names_into_core_profile();

OPEN cur;
insertion_loop: LOOP
	# for each row of bendover_data_feed parse data into appropriate table
	FETCH cur INTO 	curr_primary_key,
					curr_bendover_id,
					curr_f_name,
                    curr_l_name,
                    curr_email,
                    curr_political_affil,
                    curr_political_intensity,
                    curr_religious_affil,
                    curr_religious_intensity,
                    curr_social_issue_views,
                    curr_social_issue_date,
                    curr_social_issue_view_intensity,
                    curr_social_mate_pref,
                    curr_gender,
                    curr_birthdate,
                    curr_location,
                    curr_education,
                    curr_occupation,
                    curr_hobbies;
                    
	####################################################################################################            
	# main work is done here at each pass through the loop will insert data into the appropriate table #
    ####################################################################################################
    
    -- retrieve current profile_id
    SELECT get_profile_id_by_name(curr_f_name, curr_l_name)
    INTO curr_profile_id;
    
    -- insert into email table from current bendover_data_feed record
    CALL insert_email(curr_profile_id, curr_email);


	# select politic category ----------------------------------------------------------------
	-- insert political affiliation and political intensity into profile_opinion
	-- adds 'Politics' if not found then returns the id. (have to be really careful about typos)
    SELECT get_current_opinion_type_id('Politics')
    -- store the opinion type for the current political_affiliation in curr_opinion_type_id
    INTO curr_opinion_type_id;

    SELECT get_opinion_id(curr_opinion_type_id, curr_political_affil)
    INTO curr_opinion_id;

	-- fixme: transaction assignment - add some logic to see if there already is a profile opinion for this opinion_id
	--  if so transfer current record to transaction table and insert new intensity & date (even if intensity is the same)
    CALL insert_profile_opinion
    (
        curr_profile_id,
        curr_opinion_id,
        CURDATE(),
        curr_political_intensity
	);
    # ----------------------------------------------------------------------------------------

	-- change to religion category -----------------------------------------------------------
    SELECT get_current_opinion_type_id('Religion')
    INTO curr_opinion_type_id;

	-- get or create an id for the opinion on religion and store it in curr_opinion_id
	SELECT get_opinion_id(curr_opinion_type_id, curr_religious_affil)
    INTO curr_opinion_id;

	-- fixme: transaction assignment - add some logic to see if there already is a profile opinion for this opinion_id
	--  if so transfer current record to transaction table and insert new intensity & date (even if intensity is the same)
	CALL insert_profile_opinion
    (
        curr_profile_id,
        curr_opinion_id,
        CURDATE(),
        curr_religious_intensity
	);
	# ----------------------------------------------------------------------------------------

	-- fixme: transaction assignment - add some logic to see if there already is a profile opinion for this opinion_id
	--  if so transfer current record to transaction table and insert new intensity & date (even if intensity is the same)
	# todo: social issue views       (json)  ---
	# todo: social issue post date   (json)    --> all 3 associated
	# todo: social issue intensity   (json)  ---

	# todo: social mate preference   (json) - has its own table
	# todo: hobbies                  (json) - hobby table, profile_hobby table

	-- profile_data table inserts ------------------------------------------------------------
	CALL insert_profile_data
	(
	    curr_profile_id,
	    curr_gender,
	    curr_birthdate,
	    curr_education,
	    curr_occupation
	);
    # ----------------------------------------------------------------------------------------
	# todo: location


    -- leave loop if next item is not found
    IF @done THEN
		LEAVE insertion_loop;
	END IF;
END LOOP;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- function check_exists_email
-- -----------------------------------------------------

USE `targeted_marketing_pt_3`;
DROP function IF EXISTS `targeted_marketing_pt_3`.`check_exists_email`;

DELIMITER $$
USE `targeted_marketing_pt_3`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `check_exists_email`(
	email_var			VARCHAR(255)
) RETURNS tinyint(1)
    READS SQL DATA
    DETERMINISTIC
BEGIN
DECLARE found_email		VARCHAR(255);

SELECT email.email INTO found_email
FROM email
WHERE email.email = email_var;

IF found_email IS NULL THEN
    # fixme: hack solution to my main driver procedure quitting early
    SET @done = FALSE;
	RETURN FALSE;
ELSE
	RETURN TRUE;
END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- function check_exists_profile_opinion
-- -----------------------------------------------------

USE `targeted_marketing_pt_3`;
DROP function IF EXISTS `targeted_marketing_pt_3`.`check_exists_profile_opinion`;

DELIMITER $$
USE `targeted_marketing_pt_3`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `check_exists_profile_opinion`(
    core_profile_id_arg         INT,
    opinion_id_arg              INT
) RETURNS tinyint(1)
    READS SQL DATA
    DETERMINISTIC
BEGIN
    DECLARE profile_opinion_id    INT;

    SELECT id
    INTO profile_opinion_id
    FROM profile_opinion
    WHERE core_profile_id_arg = core_id AND opinion_id_arg = opinion_id;
    IF profile_opinion_id IS  NULL THEN
        # fixme: hack solution to my main driver procedure quitting early
	    SET @done = FALSE;
        RETURN FALSE;
    ELSE
        RETURN TRUE;
    END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- function check_platform_exists
-- -----------------------------------------------------

USE `targeted_marketing_pt_3`;
DROP function IF EXISTS `targeted_marketing_pt_3`.`check_platform_exists`;

DELIMITER $$
USE `targeted_marketing_pt_3`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `check_platform_exists`(
	platform VARCHAR(255)
) RETURNS tinyint(1)
    READS SQL DATA
    DETERMINISTIC
BEGIN
DECLARE found_platform VARCHAR(255);

SELECT `targeted_marketing`.social_media_platform.platform
INTO found_platform
FROM social_media_platform
WHERE `social_media_platform`.platform = platform;

IF found_platform IS NULL THEN
    # fixme: hack solution to my main driver procedure quitting early
	SET @done = FALSE;

	RETURN FALSE;
ELSE
	RETURN TRUE;
END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- function get_current_opinion_type_id
-- -----------------------------------------------------

USE `targeted_marketing_pt_3`;
DROP function IF EXISTS `targeted_marketing_pt_3`.`get_current_opinion_type_id`;

DELIMITER $$
USE `targeted_marketing_pt_3`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `get_current_opinion_type_id`(
	opinion_type_var VARCHAR(45)
) RETURNS tinyint(1)
    READS SQL DATA
    DETERMINISTIC
BEGIN
DECLARE found_id		INT;
DECLARE found_type		VARCHAR(45);

SELECT id , `type`
INTO found_id, found_type
FROM sm_opinion_type
WHERE sm_opinion_type.`type` = opinion_type_var;

IF found_type IS NULL THEN
	INSERT INTO sm_opinion_type
    VALUES (opinion_type_var);

    SELECT id
    INTO found_id
    FROM sm_opinion_type
    WHERE sm_opinion_type.`type` = opinion_type_var;
	# fixme: hack solution to my main driver procedure quitting early
	SET @done = FALSE;
    RETURN found_id;
ELSE
	RETURN found_id;
END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- function get_opinion_id
-- -----------------------------------------------------

USE `targeted_marketing_pt_3`;
DROP function IF EXISTS `targeted_marketing_pt_3`.`get_opinion_id`;

DELIMITER $$
USE `targeted_marketing_pt_3`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `get_opinion_id`(
	smo_type_id_var		INT,
	opinion_var 		VARCHAR(255)
) RETURNS int
    READS SQL DATA
    DETERMINISTIC
BEGIN
DECLARE found_opinion_id 	INT;
DECLARE found_opinion 		VARCHAR(255);

SELECT opinion.id, opinion.opinion
INTO found_opinion_id, found_opinion
FROM opinion
WHERE opinion.opinion = opinion_var;

IF found_opinion_id IS NULL THEN
	INSERT INTO opinion (smo_type_id, opinion)
    VALUES(smo_type_id_var, opinion_var);

    SELECT opinion.id
    INTO found_opinion_id
	FROM opinion
	WHERE opinion.opinion = opinion_var;

	# fixme: hack solution to my main driver procedure quitting early
	SET @done = FALSE;

    RETURN found_opinion_id;
ELSE
	RETURN found_opinion_id;
END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- function get_profile_id_by_name
-- -----------------------------------------------------

USE `targeted_marketing_pt_3`;
DROP function IF EXISTS `targeted_marketing_pt_3`.`get_profile_id_by_name`;

DELIMITER $$
USE `targeted_marketing_pt_3`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `get_profile_id_by_name`(
	first_name VARCHAR(255),
    last_name VARCHAR(255)
) RETURNS int
    READS SQL DATA
    DETERMINISTIC
BEGIN
  DECLARE result INT;
  SELECT id INTO result
  FROM targeted_marketing.core_profile
  WHERE f_name = first_name AND l_name = last_name;
  IF result IS NULL THEN
      # fixme: hack solution to my main driver procedure quitting early
      SET @done = FALSE;
  END IF;
  RETURN result;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- function get_sm_platform_id
-- -----------------------------------------------------

USE `targeted_marketing_pt_3`;
DROP function IF EXISTS `targeted_marketing_pt_3`.`get_sm_platform_id`;

DELIMITER $$
USE `targeted_marketing_pt_3`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `get_sm_platform_id`(
	platform VARCHAR(255)
) RETURNS int
    READS SQL DATA
    DETERMINISTIC
BEGIN
DECLARE result_id INT;

SELECT id INTO result_id
FROM social_media_platform
WHERE social_media_platform.platform = platform;

IF result_id IS NULL THEN
    SET @done = FALSE;
END IF;

RETURN result_id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure insert_bendover_names_into_core_profile
-- -----------------------------------------------------

USE `targeted_marketing_pt_3`;
DROP procedure IF EXISTS `targeted_marketing_pt_3`.`insert_bendover_names_into_core_profile`;

DELIMITER $$
USE `targeted_marketing_pt_3`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_bendover_names_into_core_profile`()
BEGIN
	DECLARE f_name_var 		VARCHAR(45);
	DECLARE l_name_var 		VARCHAR(45);
    DECLARE row_not_found 	TINYINT DEFAULT FALSE;
    DECLARE present_id		INT;

	DECLARE cur CURSOR FOR
		SELECT first_name, last_name
		FROM bendover_data_feed;
    DECLARE CONTINUE HANDLER FOR NOT FOUND
		SET row_not_found = TRUE;
    OPEN cur;

    WHILE row_not_found = FALSE DO
		FETCH cur INTO f_name_var, l_Name_var;
        SELECT id
        INTO present_id
        FROM core_profile
        WHERE f_name = f_name_var AND l_name = l_name_var;

		IF present_id IS NULL THEN
			INSERT INTO core_profile(f_name, l_name)
			VALUES (f_name_var, l_name_var);
            # fixme: hack solution to prevent short circuiting of loop iteration
            SET row_not_found = FALSE;
		#ELSE
			-- todo: handle people with same name and aliases
			-- leverage bendover tables unique bendover_id, url of social media table and/or email?
		END IF;
	END WHILE;
        CLOSE cur;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure insert_core_profile_name
-- -----------------------------------------------------

USE `targeted_marketing_pt_3`;
DROP procedure IF EXISTS `targeted_marketing_pt_3`.`insert_core_profile_name`;

DELIMITER $$
USE `targeted_marketing_pt_3`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_core_profile_name`(
	f_name_var VARCHAR(45),
	l_name_var VARCHAR(45)
)
BEGIN
IF get_profile_id_by_name(f_name_var, l_name_var) IS NULL THEN
	INSERT INTO core_profile(f_name, l_name)
    VALUES (f_name_var, l_name_var);
	# fixme: hack solution to my main driver procedure quitting early
	SET @done = FALSE;
	#ELSE
		-- todo: handle people with same name and aliases
		-- leverage bendover tables unique bendover_id, url of social media table and/or email?
END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure insert_education
-- -----------------------------------------------------

USE `targeted_marketing_pt_3`;
DROP procedure IF EXISTS `targeted_marketing_pt_3`.`insert_education`;

DELIMITER $$
USE `targeted_marketing_pt_3`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_education`(
	profile_id_var	 	INT,
    education_var		VARCHAR(144)
)
    READS SQL DATA
    DETERMINISTIC
BEGIN
DECLARE found_edu		VARCHAR(144);

SELECT education INTO found_edu
FROM profile_data
WHERE profile_data.education = education_var;

-- todo: some logic could be done here in an else statement to store previous education as a transaction in a transaction table.
-- if we do not end up splitting education into it's own table.
IF found_edu IS NULL THEN
	INSERT INTO profile_data(core_id, education)
    VALUES (profile_id_var, education_var);
	# fixme: hack solution to my main driver procedure quitting early
	SET @done = FALSE;
END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure insert_email
-- -----------------------------------------------------

USE `targeted_marketing_pt_3`;
DROP procedure IF EXISTS `targeted_marketing_pt_3`.`insert_email`;

DELIMITER $$
USE `targeted_marketing_pt_3`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_email`(
	profile_id_var		INT,
    email_var			VARCHAR(255)
)
BEGIN
IF NOT check_exists_email(email_var) THEN
	INSERT INTO email (core_id, email)
	VALUES(profile_id_var, email_var);
END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure insert_occupation
-- -----------------------------------------------------

USE `targeted_marketing_pt_3`;
DROP procedure IF EXISTS `targeted_marketing_pt_3`.`insert_occupation`;

DELIMITER $$
USE `targeted_marketing_pt_3`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_occupation`(
	profile_id_var	 	INT,
    job_var				VARCHAR(144)
)
    READS SQL DATA
    DETERMINISTIC
BEGIN
DECLARE found_job		VARCHAR(144);

SELECT occupation INTO found_job
FROM profile_data
WHERE profile_data.occupation = job_var;

-- todo: some logic could be done here in an else statement to store previous occupation as a transaction in a transaction table.
-- if we do not end up splitting occupation into it's own table.
IF found_job IS NULL THEN
	INSERT INTO profile_data(core_id, occupation)
    VALUES (profile_id_var, job_var);
	# fixme: hack solution to my main driver procedure quitting early
	SET @done = FALSE;
END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure insert_platform
-- -----------------------------------------------------

USE `targeted_marketing_pt_3`;
DROP procedure IF EXISTS `targeted_marketing_pt_3`.`insert_platform`;

DELIMITER $$
USE `targeted_marketing_pt_3`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_platform`(
	platform VARCHAR(255)
)
BEGIN
IF NOT check_platform_exists(platform) THEN
	INSERT INTO `social_media_platform` (platform)
    VALUES (platform);
END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure insert_profile_data
-- -----------------------------------------------------

USE `targeted_marketing_pt_3`;
DROP procedure IF EXISTS `targeted_marketing_pt_3`.`insert_profile_data`;

DELIMITER $$
USE `targeted_marketing_pt_3`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_profile_data`(
    core_id_var         INT,
    gender_var          VARCHAR(3),
    birthdate_var       DATE,
    education_var       VARCHAR(144),
    occupation_var      VARCHAR(144)
)
BEGIN
    DECLARE curr_id     INT;

    SELECT targeted_marketing.profile_data.core_id
    INTO curr_id
    FROM profile_data
    WHERE core_id = core_id_var;

    IF curr_id IS NULL THEN
        INSERT INTO profile_data(core_id, gender, birthdate, education, occupation)
        VALUES(core_id_var, gender_var, birthdate_var, education_var, occupation_var);
        # fixme: hack to prevent the main driver loop from short circuiting
        SET @done = FALSE;
    END IF;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure insert_profile_opinion
-- -----------------------------------------------------

USE `targeted_marketing_pt_3`;
DROP procedure IF EXISTS `targeted_marketing_pt_3`.`insert_profile_opinion`;

DELIMITER $$
USE `targeted_marketing_pt_3`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_profile_opinion`(
    core_profile_id_arg         INT,
    opinion_id_arg              INT,
    date_arg                    DATE,
    intensity_arg               INT
)
BEGIN
    IF NOT check_exists_profile_opinion(core_profile_id_arg, opinion_id_arg) THEN
        INSERT INTO profile_opinion (core_id, opinion_id, date, intensity)
            VALUES (core_profile_id_arg, opinion_id_arg, date_arg, intensity_arg);
        # return true if is inserted
    # ELSE
        # return false letting us know it exists and need to transfer to opinion transaction table
    END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure json_convert
-- -----------------------------------------------------

USE `targeted_marketing_pt_3`;
DROP procedure IF EXISTS `targeted_marketing_pt_3`.`json_convert`;

DELIMITER $$
USE `targeted_marketing_pt_3`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `json_convert`()
BEGIN
DECLARE json_string	VARCHAR(255);
# need to iterate over because more than one. (USE CURSOR)
SELECT concat('[', social_issue_views, ']') INTO json_string FROM bendover_data_feed LIMIT 1;

SELECT JSON_EXTRACT(json_string, '$[0].immigration') AS 'climate change';
END$$

DELIMITER ;

-- -----------------------------------------------------
-- View `targeted_marketing_pt_3`.`profile_data_view`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing_pt_3`.`profile_data_view`;
DROP VIEW IF EXISTS `targeted_marketing_pt_3`.`profile_data_view` ;
USE `targeted_marketing_pt_3`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `targeted_marketing`.`profile_data_view` AS select `targeted_marketing`.`core_profile`.`id` AS `Core id`,`targeted_marketing`.`core_profile`.`f_name` AS `f_name`,`targeted_marketing`.`core_profile`.`l_name` AS `l_name`,`targeted_marketing`.`profile_data`.`id` AS `Profile Data id`,`targeted_marketing`.`profile_data`.`gender` AS `gender`,round(((to_days(curdate()) - to_days(`targeted_marketing`.`profile_data`.`birthdate`)) / 365.25),0) AS `Age`,`targeted_marketing`.`profile_data`.`education` AS `Latest Education`,`targeted_marketing`.`profile_data`.`occupation` AS `Current Occupation` from (`targeted_marketing`.`core_profile` join `targeted_marketing`.`profile_data` on((`targeted_marketing`.`core_profile`.`id` = `targeted_marketing`.`profile_data`.`core_id`))) order by 'Core id';

-- -----------------------------------------------------
-- View `targeted_marketing_pt_3`.`profile_opinion_view`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing_pt_3`.`profile_opinion_view`;
DROP VIEW IF EXISTS `targeted_marketing_pt_3`.`profile_opinion_view` ;
USE `targeted_marketing_pt_3`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `targeted_marketing`.`profile_opinion_view` AS select `targeted_marketing`.`profile_opinion`.`id` AS `Core id`,`targeted_marketing`.`core_profile`.`f_name` AS `f_name`,`targeted_marketing`.`core_profile`.`l_name` AS `l_name`,`targeted_marketing`.`sm_opinion_type`.`type` AS `Category`,`targeted_marketing`.`profile_opinion`.`opinion_id` AS `opinion_id`,`targeted_marketing`.`opinion`.`opinion` AS `opinion`,`targeted_marketing`.`profile_opinion`.`intensity` AS `intensity`,`targeted_marketing`.`profile_opinion`.`date` AS `Post-date` from (((`targeted_marketing`.`profile_opinion` join `targeted_marketing`.`core_profile` on((`targeted_marketing`.`core_profile`.`id` = `targeted_marketing`.`profile_opinion`.`core_id`))) join `targeted_marketing`.`opinion` on((`targeted_marketing`.`opinion`.`id` = `targeted_marketing`.`profile_opinion`.`opinion_id`))) join `targeted_marketing`.`sm_opinion_type` on((`targeted_marketing`.`opinion`.`smo_type_id` = `targeted_marketing`.`sm_opinion_type`.`id`))) order by `targeted_marketing`.`sm_opinion_type`.`type`,`targeted_marketing`.`profile_opinion`.`intensity` desc,`targeted_marketing`.`core_profile`.`l_name`,`targeted_marketing`.`core_profile`.`f_name`;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
