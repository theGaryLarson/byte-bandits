-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema targeted_marketing
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `targeted_marketing` ;

-- -----------------------------------------------------
-- Schema targeted_marketing
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `targeted_marketing` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `targeted_marketing` ;

-- -----------------------------------------------------
-- Table `targeted_marketing`.`core_profile`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing`.`core_profile` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing`.`core_profile` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `f_name` VARCHAR(255) NULL,
  `l_name` VARCHAR(255) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `targeted_marketing`.`address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing`.`address` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing`.`address` (
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
    REFERENCES `targeted_marketing`.`core_profile` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `targeted_marketing`.`alias`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing`.`alias` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing`.`alias` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `core_id` INT NOT NULL,
  `f_name` VARCHAR(45) NULL DEFAULT NULL,
  `l_name` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_alias_core_profile1_idx` (`core_id` ASC) VISIBLE,
  CONSTRAINT `fk_alias_core_profile1`
    FOREIGN KEY (`core_id`)
    REFERENCES `targeted_marketing`.`core_profile` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `targeted_marketing`.`email`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing`.`email` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing`.`email` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `core_id` INT NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `core_id` (`core_id` ASC) VISIBLE,
  CONSTRAINT `email_ibfk_1`
    FOREIGN KEY (`core_id`)
    REFERENCES `targeted_marketing`.`core_profile` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `targeted_marketing`.`social_media_platform`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing`.`social_media_platform` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing`.`social_media_platform` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `platform` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `targeted_marketing`.`social_media`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing`.`social_media` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing`.`social_media` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `core_id` INT NOT NULL,
  `sm_platform_id` INT NOT NULL,
  `url` VARCHAR(255) NOT NULL,
  `last_active` DATE NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `core_id` (`core_id` ASC) VISIBLE,
  INDEX `sm_platform_id` (`sm_platform_id` ASC) VISIBLE,
  CONSTRAINT `social_media_ibfk_1`
    FOREIGN KEY (`core_id`)
    REFERENCES `targeted_marketing`.`core_profile` (`id`),
  CONSTRAINT `social_media_ibfk_2`
    FOREIGN KEY (`sm_platform_id`)
    REFERENCES `targeted_marketing`.`social_media_platform` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `targeted_marketing`.`friend`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing`.`friend` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing`.`friend` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `social_media_id` INT NOT NULL,
  `core_profile_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_friend_social_media1_idx` (`social_media_id` ASC) VISIBLE,
  INDEX `fk_friend_core_profile1_idx` (`core_profile_id` ASC) VISIBLE,
  CONSTRAINT `fk_friend_core_profile1`
    FOREIGN KEY (`core_profile_id`)
    REFERENCES `targeted_marketing`.`core_profile` (`id`),
  CONSTRAINT `fk_friend_social_media1`
    FOREIGN KEY (`social_media_id`)
    REFERENCES `targeted_marketing`.`social_media` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `targeted_marketing`.`group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing`.`group` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing`.`group` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `social_media_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(144) NULL DEFAULT NULL,
  `url` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`, `social_media_id`),
  INDEX `fk_group_social_media1_idx` (`social_media_id` ASC) VISIBLE,
  CONSTRAINT `fk_group_social_media1`
    FOREIGN KEY (`social_media_id`)
    REFERENCES `targeted_marketing`.`social_media` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `targeted_marketing`.`ip`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing`.`ip` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing`.`ip` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `core_id` INT NOT NULL,
  `ip_address` VARCHAR(45) NOT NULL,
  `is_v4` BIT(1) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_url_core_profile1_idx` (`core_id` ASC) VISIBLE,
  CONSTRAINT `fk_url_core_profile1`
    FOREIGN KEY (`core_id`)
    REFERENCES `targeted_marketing`.`core_profile` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `targeted_marketing`.`ip_location`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing`.`ip_location` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing`.`ip_location` (
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
    REFERENCES `targeted_marketing`.`ip` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `targeted_marketing`.`like`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing`.`like` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing`.`like` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `social_media_id` INT NOT NULL,
  `content` VARCHAR(144) NOT NULL,
  `url` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_like_social_media1_idx` (`social_media_id` ASC) VISIBLE,
  CONSTRAINT `fk_like_social_media1`
    FOREIGN KEY (`social_media_id`)
    REFERENCES `targeted_marketing`.`social_media` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `targeted_marketing`.`sm_opinion_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing`.`sm_opinion_type` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing`.`sm_opinion_type` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `targeted_marketing`.`opinion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing`.`opinion` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing`.`opinion` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `smo_type_id` INT NOT NULL,
  `opinion` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `smo_type_id` (`smo_type_id` ASC) VISIBLE,
  CONSTRAINT `opinions_ibfk_1`
    FOREIGN KEY (`smo_type_id`)
    REFERENCES `targeted_marketing`.`sm_opinion_type` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `targeted_marketing`.`phone`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing`.`phone` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing`.`phone` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `core_id` INT NOT NULL,
  `phone_num` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `core_id` (`core_id` ASC) VISIBLE,
  CONSTRAINT `phone_ibfk_1`
    FOREIGN KEY (`core_id`)
    REFERENCES `targeted_marketing`.`core_profile` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `targeted_marketing`.`post`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing`.`post` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing`.`post` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `social_media_id` INT NOT NULL,
  `content` VARCHAR(144) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_post_social_media1_idx` (`social_media_id` ASC) VISIBLE,
  CONSTRAINT `fk_post_social_media1`
    FOREIGN KEY (`social_media_id`)
    REFERENCES `targeted_marketing`.`social_media` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `targeted_marketing`.`product_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing`.`product_type` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing`.`product_type` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `targeted_marketing`.`product`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing`.`product` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing`.`product` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `product_name` VARCHAR(255) NOT NULL,
  `product_type_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `product_type_id` (`product_type_id` ASC) VISIBLE,
  CONSTRAINT `products_ibfk_1`
    FOREIGN KEY (`product_type_id`)
    REFERENCES `targeted_marketing`.`product_type` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 31
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `targeted_marketing`.`seller`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing`.`seller` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing`.`seller` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `seller` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `targeted_marketing`.`product_by_seller`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing`.`product_by_seller` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing`.`product_by_seller` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `product_id` INT NOT NULL,
  `seller_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_product_has_seller_seller1_idx` (`seller_id` ASC) VISIBLE,
  INDEX `fk_product_has_seller_product1_idx` (`product_id` ASC) VISIBLE,
  CONSTRAINT `fk_product_has_seller_product1`
    FOREIGN KEY (`product_id`)
    REFERENCES `targeted_marketing`.`product` (`id`),
  CONSTRAINT `fk_product_has_seller_seller1`
    FOREIGN KEY (`seller_id`)
    REFERENCES `targeted_marketing`.`seller` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `targeted_marketing`.`profile_data`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing`.`profile_data` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing`.`profile_data` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `core_id` INT NOT NULL,
  `gender` VARCHAR(20) NULL DEFAULT NULL,
  `ethnicity` VARCHAR(45) NULL DEFAULT NULL,
  `birthdate` DATE NULL DEFAULT NULL,
  `marital_status` ENUM('Single', 'Separated', 'Divorced', 'Married', 'Widowed') NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_meta_data_core_profile1_idx` (`core_id` ASC) VISIBLE,
  CONSTRAINT `fk_meta_data_core_profile1`
    FOREIGN KEY (`core_id`)
    REFERENCES `targeted_marketing`.`core_profile` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `targeted_marketing`.`profile_opinion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing`.`profile_opinion` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing`.`profile_opinion` (
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
    REFERENCES `targeted_marketing`.`core_profile` (`id`),
  CONSTRAINT `profile_opinions_ibfk_2`
    FOREIGN KEY (`opinion_id`)
    REFERENCES `targeted_marketing`.`opinion` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `targeted_marketing`.`profile_product`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing`.`profile_product` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing`.`profile_product` (
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
    REFERENCES `targeted_marketing`.`product_by_seller` (`id`),
  CONSTRAINT `profile_products_ibfk_1`
    FOREIGN KEY (`core_id`)
    REFERENCES `targeted_marketing`.`core_profile` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `targeted_marketing`.`service_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing`.`service_type` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing`.`service_type` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `category` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `targeted_marketing`.`service`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing`.`service` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing`.`service` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `category_id` INT NOT NULL,
  `service` VARCHAR(144) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `category_id` (`category_id` ASC) VISIBLE,
  CONSTRAINT `services_ibfk_1`
    FOREIGN KEY (`category_id`)
    REFERENCES `targeted_marketing`.`service_type` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `targeted_marketing`.`profile_service`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing`.`profile_service` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing`.`profile_service` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `core_id` INT NOT NULL,
  `service_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `core_id` (`core_id` ASC) VISIBLE,
  INDEX `services_id` (`service_id` ASC) VISIBLE,
  CONSTRAINT `profile_services_ibfk_1`
    FOREIGN KEY (`core_id`)
    REFERENCES `targeted_marketing`.`core_profile` (`id`),
  CONSTRAINT `profile_services_ibfk_2`
    FOREIGN KEY (`service_id`)
    REFERENCES `targeted_marketing`.`service` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `targeted_marketing`.`sm_item_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing`.`sm_item_type` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing`.`sm_item_type` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `targeted_marketing`.`sm_item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing`.`sm_item` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing`.`sm_item` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `type_id` INT NOT NULL,
  `item` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`, `type_id`),
  INDEX `fk_sm_item_sm_item_type1_idx` (`type_id` ASC) VISIBLE,
  CONSTRAINT `fk_sm_item_sm_item_type1`
    FOREIGN KEY (`type_id`)
    REFERENCES `targeted_marketing`.`sm_item_type` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `targeted_marketing`.`sm_transaction`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing`.`sm_transaction` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing`.`sm_transaction` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `core_id` INT NOT NULL,
  `smp_id` INT NOT NULL,
  `price_paid` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Transactions_core_profile1_idx` (`core_id` ASC) VISIBLE,
  INDEX `fk_Transactions_social_media_platforms1_idx` (`smp_id` ASC) VISIBLE,
  CONSTRAINT `fk_Transactions_core_profile1`
    FOREIGN KEY (`core_id`)
    REFERENCES `targeted_marketing`.`core_profile` (`id`),
  CONSTRAINT `fk_Transactions_social_media_platforms1`
    FOREIGN KEY (`smp_id`)
    REFERENCES `targeted_marketing`.`social_media_platform` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `targeted_marketing`.`sm_seller`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing`.`sm_seller` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing`.`sm_seller` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `seller` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `targeted_marketing`.`sm_item_by_seller`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing`.`sm_item_by_seller` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing`.`sm_item_by_seller` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `sm_transaction_id` INT NOT NULL,
  `sm_seller_id` INT NOT NULL,
  `sm_item_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_sm_seller_has_sm_item_sm_item1_idx` (`sm_item_id` ASC) VISIBLE,
  INDEX `fk_sm_seller_has_sm_item_sm_seller1_idx` (`sm_seller_id` ASC) VISIBLE,
  INDEX `fk_sm_seller_has_item_sm_transaction1_idx` (`sm_transaction_id` ASC) VISIBLE,
  CONSTRAINT `fk_sm_seller_has_item_sm_transaction1`
    FOREIGN KEY (`sm_transaction_id`)
    REFERENCES `targeted_marketing`.`sm_transaction` (`id`),
  CONSTRAINT `fk_sm_seller_has_sm_item_sm_item1`
    FOREIGN KEY (`sm_item_id`)
    REFERENCES `targeted_marketing`.`sm_item` (`id`),
  CONSTRAINT `fk_sm_seller_has_sm_item_sm_seller1`
    FOREIGN KEY (`sm_seller_id`)
    REFERENCES `targeted_marketing`.`sm_seller` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `targeted_marketing`.`sm_opinion_type_by_platform`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing`.`sm_opinion_type_by_platform` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing`.`sm_opinion_type_by_platform` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `sm_opinion_type_id` INT NOT NULL,
  `social_media_platform_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_sm_opinions_category_has_social_media_platform_social_me_idx` (`social_media_platform_id` ASC) VISIBLE,
  INDEX `fk_sm_opinions_category_has_social_media_platform_sm_opinio_idx` (`sm_opinion_type_id` ASC) VISIBLE,
  CONSTRAINT `fk_sm_opinions_category_has_social_media_platform_sm_opinions1`
    FOREIGN KEY (`sm_opinion_type_id`)
    REFERENCES `targeted_marketing`.`sm_opinion_type` (`id`),
  CONSTRAINT `fk_sm_opinions_category_has_social_media_platform_social_medi1`
    FOREIGN KEY (`social_media_platform_id`)
    REFERENCES `targeted_marketing`.`social_media_platform` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `targeted_marketing`.`occupation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing`.`occupation` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing`.`occupation` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `core_profile_id` INT NOT NULL,
  `job_title` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_occupation_core_profile1_idx` (`core_profile_id` ASC) VISIBLE,
  CONSTRAINT `fk_occupation_core_profile1`
    FOREIGN KEY (`core_profile_id`)
    REFERENCES `targeted_marketing`.`core_profile` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `targeted_marketing`.`social_mate_preference`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing`.`social_mate_preference` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing`.`social_mate_preference` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `core_profile_id` INT NOT NULL,
  `political_affiliation` VARCHAR(45) NULL,
  `religious_affiliation` VARCHAR(45) NULL,
  `gender` VARCHAR(4) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_social_mate_preference_core_profile1_idx` (`core_profile_id` ASC) VISIBLE,
  CONSTRAINT `fk_social_mate_preference_core_profile1`
    FOREIGN KEY (`core_profile_id`)
    REFERENCES `targeted_marketing`.`core_profile` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `targeted_marketing`.`bendover_data_feed`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `targeted_marketing`.`bendover_data_feed` ;

CREATE TABLE IF NOT EXISTS `targeted_marketing`.`bendover_data_feed` (
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
  `age` INT NULL,
  `location` VARCHAR(45) NULL,
  `education` VARCHAR(144) NULL,
  `occupation` VARCHAR(144) NULL,
  `hobbies` VARCHAR(200) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
