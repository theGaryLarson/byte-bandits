-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema votemate
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `votemate` ;

-- -----------------------------------------------------
-- Schema votemate
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `votemate` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `votemate` ;

-- -----------------------------------------------------
-- Table `votemate`.`core_profile`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `votemate`.`core_profile` ;

CREATE TABLE IF NOT EXISTS `votemate`.`core_profile` (
  `id` INT NOT NULL,
  `f_name` VARCHAR(255) NULL,
  `l_name` VARCHAR(255) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `votemate`.`address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `votemate`.`address` ;

CREATE TABLE IF NOT EXISTS `votemate`.`address` (
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
    REFERENCES `votemate`.`core_profile` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `votemate`.`alias`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `votemate`.`alias` ;

CREATE TABLE IF NOT EXISTS `votemate`.`alias` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `core_id` INT NOT NULL,
  `f_name` VARCHAR(45) NULL DEFAULT NULL,
  `l_name` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_alias_core_profile1_idx` (`core_id` ASC) VISIBLE,
  CONSTRAINT `fk_alias_core_profile1`
    FOREIGN KEY (`core_id`)
    REFERENCES `votemate`.`core_profile` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `votemate`.`email`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `votemate`.`email` ;

CREATE TABLE IF NOT EXISTS `votemate`.`email` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `core_id` INT NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `core_id` (`core_id` ASC) VISIBLE,
  CONSTRAINT `email_ibfk_1`
    FOREIGN KEY (`core_id`)
    REFERENCES `votemate`.`core_profile` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `votemate`.`social_media_platform`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `votemate`.`social_media_platform` ;

CREATE TABLE IF NOT EXISTS `votemate`.`social_media_platform` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `platform` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `votemate`.`social_media`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `votemate`.`social_media` ;

CREATE TABLE IF NOT EXISTS `votemate`.`social_media` (
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
    REFERENCES `votemate`.`core_profile` (`id`),
  CONSTRAINT `social_media_ibfk_2`
    FOREIGN KEY (`sm_platform_id`)
    REFERENCES `votemate`.`social_media_platform` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `votemate`.`friend`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `votemate`.`friend` ;

CREATE TABLE IF NOT EXISTS `votemate`.`friend` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `social_media_id` INT NOT NULL,
  `core_profile_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_friend_social_media1_idx` (`social_media_id` ASC) VISIBLE,
  INDEX `fk_friend_core_profile1_idx` (`core_profile_id` ASC) VISIBLE,
  CONSTRAINT `fk_friend_core_profile1`
    FOREIGN KEY (`core_profile_id`)
    REFERENCES `votemate`.`core_profile` (`id`),
  CONSTRAINT `fk_friend_social_media1`
    FOREIGN KEY (`social_media_id`)
    REFERENCES `votemate`.`social_media` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `votemate`.`group_lookup`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `votemate`.`group_lookup` ;

CREATE TABLE IF NOT EXISTS `votemate`.`group_lookup` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(144) NOT NULL,
  `description` VARCHAR(255) NOT NULL,
  `group_url` VARCHAR(144) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `votemate`.`group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `votemate`.`group` ;

CREATE TABLE IF NOT EXISTS `votemate`.`group` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `social_media_id` INT NOT NULL,
  `group_lookup_id` INT NOT NULL,
  PRIMARY KEY (`id`, `social_media_id`),
  INDEX `fk_group_social_media1_idx` (`social_media_id` ASC) VISIBLE,
  INDEX `fk_group_group_lookup1_idx` (`group_lookup_id` ASC) VISIBLE,
  CONSTRAINT `fk_group_social_media1`
    FOREIGN KEY (`social_media_id`)
    REFERENCES `votemate`.`social_media` (`id`),
  CONSTRAINT `fk_group_group_lookup1`
    FOREIGN KEY (`group_lookup_id`)
    REFERENCES `votemate`.`group_lookup` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `votemate`.`marketing_agency`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `votemate`.`marketing_agency` ;

CREATE TABLE IF NOT EXISTS `votemate`.`marketing_agency` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `url` VARCHAR(255) NOT NULL,
  `headquarters` VARCHAR(144) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `votemate`.`political_affiliation_lookup`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `votemate`.`political_affiliation_lookup` ;

CREATE TABLE IF NOT EXISTS `votemate`.`political_affiliation_lookup` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `affiliation` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `votemate`.`ad`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `votemate`.`ad` ;

CREATE TABLE IF NOT EXISTS `votemate`.`ad` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `marketing_agency_id` INT NOT NULL,
  `political_affiliation_id` INT NULL,
  `ad_title` VARCHAR(255) NOT NULL,
  `start_airtime` DATETIME NOT NULL,
  `end_airtime` DATETIME NOT NULL,
  `networks` JSON NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `ads_name` (`ad_title` ASC) VISIBLE,
  INDEX `fk_ads_marketing_agency1_idx` (`marketing_agency_id` ASC) VISIBLE,
  INDEX `fk_ad_political_affiliation1_idx` (`political_affiliation_id` ASC) VISIBLE,
  UNIQUE INDEX `name_UNIQUE` (`ad_title` ASC) VISIBLE,
  CONSTRAINT `fk_ads_marketing_agency1`
    FOREIGN KEY (`marketing_agency_id`)
    REFERENCES `votemate`.`marketing_agency` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ad_political_affiliation1`
    FOREIGN KEY (`political_affiliation_id`)
    REFERENCES `votemate`.`political_affiliation_lookup` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `votemate`.`podcast`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `votemate`.`podcast` ;

CREATE TABLE IF NOT EXISTS `votemate`.`podcast` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `political_affiliation_id` INT NULL,
  `name` VARCHAR(45) NOT NULL,
  `podcast_url` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `podcast_name` (`name` ASC) INVISIBLE,
  INDEX `fk_podcast_political_affiliation1_idx` (`political_affiliation_id` ASC) VISIBLE,
  CONSTRAINT `fk_podcast_political_affiliation1`
    FOREIGN KEY (`political_affiliation_id`)
    REFERENCES `votemate`.`political_affiliation_lookup` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `votemate`.`web_broadcast`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `votemate`.`web_broadcast` ;

CREATE TABLE IF NOT EXISTS `votemate`.`web_broadcast` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `political_affiliation_id` INT NULL,
  `name` VARCHAR(45) NOT NULL,
  `broadcast_url` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `broadcast_name` (`name` ASC) VISIBLE,
  INDEX `fk_web_broadcast_political_affiliation1_idx` (`political_affiliation_id` ASC) VISIBLE,
  CONSTRAINT `fk_web_broadcast_political_affiliation1`
    FOREIGN KEY (`political_affiliation_id`)
    REFERENCES `votemate`.`political_affiliation_lookup` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `votemate`.`website`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `votemate`.`website` ;

CREATE TABLE IF NOT EXISTS `votemate`.`website` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `political_affiliation_id` INT NULL,
  `name` VARCHAR(45) NOT NULL,
  `website_url` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `url` (`website_url` ASC) VISIBLE,
  INDEX `fk_websites_political_affiliation1_idx` (`political_affiliation_id` ASC) VISIBLE,
  CONSTRAINT `fk_websites_political_affiliation1`
    FOREIGN KEY (`political_affiliation_id`)
    REFERENCES `votemate`.`political_affiliation_lookup` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `votemate`.`web_media`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `votemate`.`web_media` ;

CREATE TABLE IF NOT EXISTS `votemate`.`web_media` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `core_id` INT NOT NULL,
  `click_timestamp` DATETIME NOT NULL,
  `ad_id` INT NULL,
  `podcast_id` INT NULL,
  `web_broadcast_id` INT NULL,
  `website_id` INT NULL,
  `length_of_stay_seconds` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_user_clicks_core_profile1_idx` (`core_id` ASC) VISIBLE,
  INDEX `fk_user_clicks_ads1_idx` (`ad_id` ASC) VISIBLE,
  INDEX `fk_user_clicks_podcast1_idx` (`podcast_id` ASC) VISIBLE,
  INDEX `fk_user_clicks_web_broadcast1_idx` (`web_broadcast_id` ASC) VISIBLE,
  INDEX `fk_user_clicks_websites1_idx` (`website_id` ASC) VISIBLE,
  CONSTRAINT `fk_user_clicks_core_profile1`
    FOREIGN KEY (`core_id`)
    REFERENCES `votemate`.`core_profile` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_clicks_ads1`
    FOREIGN KEY (`ad_id`)
    REFERENCES `votemate`.`ad` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_clicks_podcast1`
    FOREIGN KEY (`podcast_id`)
    REFERENCES `votemate`.`podcast` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_clicks_web_broadcast1`
    FOREIGN KEY (`web_broadcast_id`)
    REFERENCES `votemate`.`web_broadcast` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_clicks_websites1`
    FOREIGN KEY (`website_id`)
    REFERENCES `votemate`.`website` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `votemate`.`ip`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `votemate`.`ip` ;

CREATE TABLE IF NOT EXISTS `votemate`.`ip` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_clicks_id` INT NOT NULL,
  `ip_address` VARCHAR(45) NOT NULL,
  `is_v4` BIT(1) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_ip_user_clicks1_idx` (`user_clicks_id` ASC) VISIBLE,
  CONSTRAINT `fk_ip_user_clicks1`
    FOREIGN KEY (`user_clicks_id`)
    REFERENCES `votemate`.`web_media` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `votemate`.`ip_location`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `votemate`.`ip_location` ;

CREATE TABLE IF NOT EXISTS `votemate`.`ip_location` (
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
    REFERENCES `votemate`.`ip` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `votemate`.`like`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `votemate`.`like` ;

CREATE TABLE IF NOT EXISTS `votemate`.`like` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `social_media_id` INT NOT NULL,
  `content` VARCHAR(144) NOT NULL,
  `liked_url` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_like_social_media1_idx` (`social_media_id` ASC) VISIBLE,
  CONSTRAINT `fk_like_social_media1`
    FOREIGN KEY (`social_media_id`)
    REFERENCES `votemate`.`social_media` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `votemate`.`phone`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `votemate`.`phone` ;

CREATE TABLE IF NOT EXISTS `votemate`.`phone` (
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
    REFERENCES `votemate`.`core_profile` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `votemate`.`post`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `votemate`.`post` ;

CREATE TABLE IF NOT EXISTS `votemate`.`post` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `social_media_id` INT NOT NULL,
  `content` VARCHAR(144) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_post_social_media1_idx` (`social_media_id` ASC) VISIBLE,
  CONSTRAINT `fk_post_social_media1`
    FOREIGN KEY (`social_media_id`)
    REFERENCES `votemate`.`social_media` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `votemate`.`gender_lookup`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `votemate`.`gender_lookup` ;

CREATE TABLE IF NOT EXISTS `votemate`.`gender_lookup` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `identity` VARCHAR(45) NOT NULL,
  `acronym` VARCHAR(4) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `votemate`.`profile_demographic`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `votemate`.`profile_demographic` ;

CREATE TABLE IF NOT EXISTS `votemate`.`profile_demographic` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `core_id` INT NOT NULL,
  `gender_id` INT NOT NULL,
  `ethnicity` VARCHAR(45) NULL DEFAULT NULL,
  `birthdate` DATE NULL DEFAULT NULL,
  `marital_status` ENUM('Single', 'Separated', 'Divorced', 'Married', 'Widowed') NULL DEFAULT NULL,
  `most_recent_education` VARCHAR(144) NULL,
  `current_occupation` VARCHAR(144) NULL,
  `annual_income` DECIMAL(10,2) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_meta_data_core_profile1_idx` (`core_id` ASC) VISIBLE,
  INDEX `fk_profile_data_gender_look_up1_idx` (`gender_id` ASC) VISIBLE,
  CONSTRAINT `fk_meta_data_core_profile1`
    FOREIGN KEY (`core_id`)
    REFERENCES `votemate`.`core_profile` (`id`),
  CONSTRAINT `fk_profile_data_gender_look_up1`
    FOREIGN KEY (`gender_id`)
    REFERENCES `votemate`.`gender_lookup` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `votemate`.`service_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `votemate`.`service_type` ;

CREATE TABLE IF NOT EXISTS `votemate`.`service_type` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `category` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `votemate`.`service`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `votemate`.`service` ;

CREATE TABLE IF NOT EXISTS `votemate`.`service` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `category_id` INT NOT NULL,
  `service` VARCHAR(144) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `category_id` (`category_id` ASC) VISIBLE,
  CONSTRAINT `services_ibfk_1`
    FOREIGN KEY (`category_id`)
    REFERENCES `votemate`.`service_type` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `votemate`.`profile_service`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `votemate`.`profile_service` ;

CREATE TABLE IF NOT EXISTS `votemate`.`profile_service` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `core_id` INT NOT NULL,
  `service_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `core_id` (`core_id` ASC) VISIBLE,
  INDEX `services_id` (`service_id` ASC) VISIBLE,
  CONSTRAINT `profile_services_ibfk_1`
    FOREIGN KEY (`core_id`)
    REFERENCES `votemate`.`core_profile` (`id`),
  CONSTRAINT `profile_services_ibfk_2`
    FOREIGN KEY (`service_id`)
    REFERENCES `votemate`.`service` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `votemate`.`past_occupation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `votemate`.`past_occupation` ;

CREATE TABLE IF NOT EXISTS `votemate`.`past_occupation` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `core_profile_id` INT NOT NULL,
  `job_title` VARCHAR(144) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_occupation_core_profile1_idx` (`core_profile_id` ASC) VISIBLE,
  CONSTRAINT `fk_occupation_core_profile1`
    FOREIGN KEY (`core_profile_id`)
    REFERENCES `votemate`.`core_profile` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `votemate`.`religious_affiliation_lookup`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `votemate`.`religious_affiliation_lookup` ;

CREATE TABLE IF NOT EXISTS `votemate`.`religious_affiliation_lookup` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `affiliation` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `votemate`.`social_mate_preference`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `votemate`.`social_mate_preference` ;

CREATE TABLE IF NOT EXISTS `votemate`.`social_mate_preference` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `core_profile_id` INT NOT NULL,
  `gender_id` INT NOT NULL,
  `political_affiliation_id` INT NOT NULL,
  `religious_affiliation_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_social_mate_preference_core_profile1_idx` (`core_profile_id` ASC) VISIBLE,
  INDEX `fk_social_mate_preference_gender_look_up1_idx` (`gender_id` ASC) VISIBLE,
  INDEX `fk_social_mate_preference_political_affiliation_look_up1_idx` (`political_affiliation_id` ASC) VISIBLE,
  INDEX `fk_social_mate_preference_religious_affiliation_look_up1_idx` (`religious_affiliation_id` ASC) VISIBLE,
  CONSTRAINT `fk_social_mate_preference_core_profile1`
    FOREIGN KEY (`core_profile_id`)
    REFERENCES `votemate`.`core_profile` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_social_mate_preference_gender_look_up1`
    FOREIGN KEY (`gender_id`)
    REFERENCES `votemate`.`gender_lookup` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_social_mate_preference_political_affiliation_look_up1`
    FOREIGN KEY (`political_affiliation_id`)
    REFERENCES `votemate`.`political_affiliation_lookup` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_social_mate_preference_religious_affiliation_look_up1`
    FOREIGN KEY (`religious_affiliation_id`)
    REFERENCES `votemate`.`religious_affiliation_lookup` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `votemate`.`bendover_data_feed`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `votemate`.`bendover_data_feed` ;

CREATE TABLE IF NOT EXISTS `votemate`.`bendover_data_feed` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `bendover_id` VARCHAR(144) NULL,
  `first_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `political_affiliation` VARCHAR(45) NULL,
  `political_intensity` INT NULL,
  `religious_affiliation` VARCHAR(45) NULL,
  `religious_intensity` INT NULL,
  `social_issue_views` JSON NULL,
  `social_mate_preference` JSON NULL,
  `gender` VARCHAR(3) NULL,
  `birthdate` DATE NULL,
  `location` VARCHAR(45) NULL,
  `education` VARCHAR(144) NULL,
  `occupation` VARCHAR(144) NULL,
  `hobbies` JSON NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `votemate`.`hobby_lookup`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `votemate`.`hobby_lookup` ;

CREATE TABLE IF NOT EXISTS `votemate`.`hobby_lookup` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `hobby_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `votemate`.`profile_hobby`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `votemate`.`profile_hobby` ;

CREATE TABLE IF NOT EXISTS `votemate`.`profile_hobby` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `core_id` INT NOT NULL,
  `hobby_id` INT NOT NULL,
  `hours_spent_weekly` DECIMAL(3,2) NOT NULL,
  INDEX `fk_profile_hobby_core_profile1_idx` (`core_id` ASC) VISIBLE,
  INDEX `fk_profile_hobby_hobby1_idx` (`hobby_id` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_profile_hobby_core_profile1`
    FOREIGN KEY (`core_id`)
    REFERENCES `votemate`.`core_profile` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_profile_hobby_hobby1`
    FOREIGN KEY (`hobby_id`)
    REFERENCES `votemate`.`hobby_lookup` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `votemate`.`social_issue_view_type_lookup`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `votemate`.`social_issue_view_type_lookup` ;

CREATE TABLE IF NOT EXISTS `votemate`.`social_issue_view_type_lookup` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `category` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `votemate`.`social_issue_view_lookup`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `votemate`.`social_issue_view_lookup` ;

CREATE TABLE IF NOT EXISTS `votemate`.`social_issue_view_lookup` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `view` VARCHAR(144) NOT NULL,
  `view_type_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_social_issue_view_look_up_social_issue_view_type_look_up_idx` (`view_type_id` ASC) VISIBLE,
  CONSTRAINT `fk_social_issue_view_look_up_social_issue_view_type_look_up1`
    FOREIGN KEY (`view_type_id`)
    REFERENCES `votemate`.`social_issue_view_type_lookup` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `votemate`.`social_issue_view_by_platform`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `votemate`.`social_issue_view_by_platform` ;

CREATE TABLE IF NOT EXISTS `votemate`.`social_issue_view_by_platform` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `social_media_platform_id` INT NOT NULL,
  `social_issue_view_type_lookup_id` INT NOT NULL,
  INDEX `fk_social_media_platform_has_social_issue_view_look_up_soci_idx1` (`social_media_platform_id` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  INDEX `fk_social_issue_view_by_platform_social_issue_view_type_loo_idx` (`social_issue_view_type_lookup_id` ASC) VISIBLE,
  CONSTRAINT `fk_social_media_platform_has_social_issue_view_look_up_social1`
    FOREIGN KEY (`social_media_platform_id`)
    REFERENCES `votemate`.`social_media_platform` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_social_issue_view_by_platform_social_issue_view_type_look_1`
    FOREIGN KEY (`social_issue_view_type_lookup_id`)
    REFERENCES `votemate`.`social_issue_view_type_lookup` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `votemate`.`core_profile_has_social_issue_view`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `votemate`.`core_profile_has_social_issue_view` ;

CREATE TABLE IF NOT EXISTS `votemate`.`core_profile_has_social_issue_view` (
  `id` INT NOT NULL,
  `core_profile_id` INT NOT NULL,
  `social_issue_view_look_up_id` INT NOT NULL,
  `intensity` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_core_profile_has_social_issue_view_look_up_social_issue__idx` (`social_issue_view_look_up_id` ASC) VISIBLE,
  INDEX `fk_core_profile_has_social_issue_view_look_up_core_profile1_idx` (`core_profile_id` ASC) VISIBLE,
  CONSTRAINT `fk_core_profile_has_social_issue_view_look_up_core_profile1`
    FOREIGN KEY (`core_profile_id`)
    REFERENCES `votemate`.`core_profile` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_core_profile_has_social_issue_view_look_up_social_issue_vi1`
    FOREIGN KEY (`social_issue_view_look_up_id`)
    REFERENCES `votemate`.`social_issue_view_lookup` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `votemate`.`social_issue_view_transaction`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `votemate`.`social_issue_view_transaction` ;

CREATE TABLE IF NOT EXISTS `votemate`.`social_issue_view_transaction` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `core_profile_has_social_issue_view_id` INT NOT NULL,
  `timestamp` DATE NOT NULL,
  `prev_intensity` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_social_issue_view_transaction_core_profile_has_social_is_idx` (`core_profile_has_social_issue_view_id` ASC) VISIBLE,
  CONSTRAINT `fk_social_issue_view_transaction_core_profile_has_social_issu1`
    FOREIGN KEY (`core_profile_has_social_issue_view_id`)
    REFERENCES `votemate`.`core_profile_has_social_issue_view` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `votemate`.`core_profile_has_political_affiliation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `votemate`.`core_profile_has_political_affiliation` ;

CREATE TABLE IF NOT EXISTS `votemate`.`core_profile_has_political_affiliation` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `core_profile_id` INT NOT NULL,
  `political_affiliation_id` INT NOT NULL,
  `intensity` INT NOT NULL,
  INDEX `fk_core_profile_has_political_affiliation_look_up_political_idx` (`political_affiliation_id` ASC) VISIBLE,
  INDEX `fk_core_profile_has_political_affiliation_look_up_core_prof_idx` (`core_profile_id` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_core_profile_has_political_affiliation_look_up_core_profile1`
    FOREIGN KEY (`core_profile_id`)
    REFERENCES `votemate`.`core_profile` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_core_profile_has_political_affiliation_look_up_political_a1`
    FOREIGN KEY (`political_affiliation_id`)
    REFERENCES `votemate`.`political_affiliation_lookup` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `votemate`.`political_transaction`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `votemate`.`political_transaction` ;

CREATE TABLE IF NOT EXISTS `votemate`.`political_transaction` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `core_profile_has_political_affiliation_id` INT NOT NULL,
  `timestamp` DATE NOT NULL,
  `prev_intensity` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_political_transaction_core_profile_has_political_affilia_idx` (`core_profile_has_political_affiliation_id` ASC) VISIBLE,
  CONSTRAINT `fk_political_transaction_core_profile_has_political_affiliati1`
    FOREIGN KEY (`core_profile_has_political_affiliation_id`)
    REFERENCES `votemate`.`core_profile_has_political_affiliation` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `votemate`.`core_profile_has_religious_affiliation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `votemate`.`core_profile_has_religious_affiliation` ;

CREATE TABLE IF NOT EXISTS `votemate`.`core_profile_has_religious_affiliation` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `religious_affiliation_look_up_id` INT NOT NULL,
  `core_profile_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_core_profile_has_religious_affiliation_religious_affilia_idx` (`religious_affiliation_look_up_id` ASC) VISIBLE,
  INDEX `fk_core_profile_has_religious_affiliation_core_profile1_idx` (`core_profile_id` ASC) VISIBLE,
  CONSTRAINT `fk_core_profile_has_religious_affiliation_religious_affiliati1`
    FOREIGN KEY (`religious_affiliation_look_up_id`)
    REFERENCES `votemate`.`religious_affiliation_lookup` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_core_profile_has_religious_affiliation_core_profile1`
    FOREIGN KEY (`core_profile_id`)
    REFERENCES `votemate`.`core_profile` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `votemate`.`religious_transaction`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `votemate`.`religious_transaction` ;

CREATE TABLE IF NOT EXISTS `votemate`.`religious_transaction` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `core_profile_has_religious_affiliation_id` INT NOT NULL,
  `timestamp` DATE NOT NULL,
  `prev_intensity` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_religious_transaction_core_profile_has_religious_affilia_idx` (`core_profile_has_religious_affiliation_id` ASC) VISIBLE,
  CONSTRAINT `fk_religious_transaction_core_profile_has_religious_affiliati1`
    FOREIGN KEY (`core_profile_has_religious_affiliation_id`)
    REFERENCES `votemate`.`core_profile_has_religious_affiliation` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `votemate`.`hobby_transaction`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `votemate`.`hobby_transaction` ;

CREATE TABLE IF NOT EXISTS `votemate`.`hobby_transaction` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `timestamp` DATE NOT NULL,
  `profile_hobby_id` INT NOT NULL,
  `prev_hours_spent_weekly` DECIMAL(3,2) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_hobby_transaction_profile_hobby1_idx` (`profile_hobby_id` ASC) VISIBLE,
  CONSTRAINT `fk_hobby_transaction_profile_hobby1`
    FOREIGN KEY (`profile_hobby_id`)
    REFERENCES `votemate`.`profile_hobby` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `votemate`.`past_education`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `votemate`.`past_education` ;

CREATE TABLE IF NOT EXISTS `votemate`.`past_education` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `core_id` INT NOT NULL,
  `credentials` VARCHAR(144) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_past_education_core_profile1_idx` (`core_id` ASC) VISIBLE,
  CONSTRAINT `fk_past_education_core_profile1`
    FOREIGN KEY (`core_id`)
    REFERENCES `votemate`.`core_profile` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `votemate`.`district_lookup`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `votemate`.`district_lookup` ;

CREATE TABLE IF NOT EXISTS `votemate`.`district_lookup` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `district` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `votemate`.`voter_profile`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `votemate`.`voter_profile` ;

CREATE TABLE IF NOT EXISTS `votemate`.`voter_profile` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `core_id` INT NOT NULL,
  `district_lookup_id` INT NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `salt` VARCHAR(45) NOT NULL,
  `email` VARCHAR(144) NOT NULL,
  `device_id` VARCHAR(45) NOT NULL,
  `login_date` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE,
  UNIQUE INDEX `password_UNIQUE` (`password` ASC) VISIBLE,
  INDEX `fk_voter_profile_core_profile1_idx` (`core_id` ASC) VISIBLE,
  INDEX `fk_voter_profile_district_lookup1_idx` (`district_lookup_id` ASC) VISIBLE,
  CONSTRAINT `fk_voter_profile_core_profile1`
    FOREIGN KEY (`core_id`)
    REFERENCES `votemate`.`core_profile` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_voter_profile_district_lookup1`
    FOREIGN KEY (`district_lookup_id`)
    REFERENCES `votemate`.`district_lookup` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `votemate`.`primary_address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `votemate`.`primary_address` ;

CREATE TABLE IF NOT EXISTS `votemate`.`primary_address` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `voter_profile_id` INT NOT NULL,
  `street` VARCHAR(45) NOT NULL,
  `street_2` VARCHAR(45) NULL,
  `city` VARCHAR(144) NOT NULL,
  `state` VARCHAR(2) NOT NULL,
  `zip` INT NOT NULL,
  `date` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_primary_address_voter_profile1_idx` (`voter_profile_id` ASC) VISIBLE,
  CONSTRAINT `fk_primary_address_voter_profile1`
    FOREIGN KEY (`voter_profile_id`)
    REFERENCES `votemate`.`voter_profile` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `votemate`.`voter_log`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `votemate`.`voter_log` ;

CREATE TABLE IF NOT EXISTS `votemate`.`voter_log` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `voter_profile_id` INT NOT NULL,
  `last_login` DATETIME NOT NULL,
  `last_device_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_voter_log_voter_profile1_idx` (`voter_profile_id` ASC) VISIBLE,
  CONSTRAINT `fk_voter_log_voter_profile1`
    FOREIGN KEY (`voter_profile_id`)
    REFERENCES `votemate`.`voter_profile` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `votemate`.`party_lookup`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `votemate`.`party_lookup` ;

CREATE TABLE IF NOT EXISTS `votemate`.`party_lookup` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `party` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `votemate`.`party_registration`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `votemate`.`party_registration` ;

CREATE TABLE IF NOT EXISTS `votemate`.`party_registration` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `voter_profile_id` INT NOT NULL,
  `party_lookup_id` INT NOT NULL,
  `date` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_party_registration_voter_profile1_idx` (`voter_profile_id` ASC) VISIBLE,
  INDEX `fk_party_registration_party_lookup1_idx` (`party_lookup_id` ASC) VISIBLE,
  CONSTRAINT `fk_party_registration_voter_profile1`
    FOREIGN KEY (`voter_profile_id`)
    REFERENCES `votemate`.`voter_profile` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_party_registration_party_lookup1`
    FOREIGN KEY (`party_lookup_id`)
    REFERENCES `votemate`.`party_lookup` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `votemate`.`2FA`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `votemate`.`2FA` ;

CREATE TABLE IF NOT EXISTS `votemate`.`2FA` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `voter_profile_id` INT NOT NULL,
  `secret` VARCHAR(255) NOT NULL,
  `recover_code_1` VARCHAR(45) NOT NULL,
  `recover_code_2` VARCHAR(45) NOT NULL,
  `recover_code_3` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_2FA_voter_profile1_idx` (`voter_profile_id` ASC) VISIBLE,
  CONSTRAINT `fk_2FA_voter_profile1`
    FOREIGN KEY (`voter_profile_id`)
    REFERENCES `votemate`.`voter_profile` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `votemate`.`magazine`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `votemate`.`magazine` ;

CREATE TABLE IF NOT EXISTS `votemate`.`magazine` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `political_affiliation_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_magazine_political_affiliation1_idx` (`political_affiliation_id` ASC) VISIBLE,
  CONSTRAINT `fk_magazine_political_affiliation1`
    FOREIGN KEY (`political_affiliation_id`)
    REFERENCES `votemate`.`political_affiliation_lookup` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `votemate`.`newspaper`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `votemate`.`newspaper` ;

CREATE TABLE IF NOT EXISTS `votemate`.`newspaper` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `political_affiliation_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_newspaper_political_affiliation_look_up1_idx` (`political_affiliation_id` ASC) VISIBLE,
  CONSTRAINT `fk_newspaper_political_affiliation_look_up1`
    FOREIGN KEY (`political_affiliation_id`)
    REFERENCES `votemate`.`political_affiliation_lookup` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `votemate`.`printed_media_subscription`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `votemate`.`printed_media_subscription` ;

CREATE TABLE IF NOT EXISTS `votemate`.`printed_media_subscription` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `core_id` INT NOT NULL,
  `newspaper_id` INT NULL,
  `magazine_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_subscriptions_core_profile1_idx` (`core_id` ASC) VISIBLE,
  INDEX `fk_subscriptions_newspaper1_idx` (`newspaper_id` ASC) VISIBLE,
  INDEX `fk_subscriptions_magazine1_idx` (`magazine_id` ASC) VISIBLE,
  CONSTRAINT `fk_subscriptions_core_profile1`
    FOREIGN KEY (`core_id`)
    REFERENCES `votemate`.`core_profile` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_subscriptions_newspaper1`
    FOREIGN KEY (`newspaper_id`)
    REFERENCES `votemate`.`newspaper` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_subscriptions_magazine1`
    FOREIGN KEY (`magazine_id`)
    REFERENCES `votemate`.`magazine` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `votemate`.`election`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `votemate`.`election` ;

CREATE TABLE IF NOT EXISTS `votemate`.`election` (
  `id` INT NOT NULL,
  `election_type` VARCHAR(45) NOT NULL,
  `election_start_date` DATETIME NOT NULL,
  `election_end_date` DATETIME NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `votemate`.`ballot`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `votemate`.`ballot` ;

CREATE TABLE IF NOT EXISTS `votemate`.`ballot` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `election_id` INT NOT NULL,
  `district_lookup_id` INT NOT NULL,
  `ballot_title` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_ballot_election1_idx` (`election_id` ASC) VISIBLE,
  INDEX `fk_ballot_district_lookup1_idx` (`district_lookup_id` ASC) VISIBLE,
  CONSTRAINT `fk_ballot_election1`
    FOREIGN KEY (`election_id`)
    REFERENCES `votemate`.`election` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ballot_district_lookup1`
    FOREIGN KEY (`district_lookup_id`)
    REFERENCES `votemate`.`district_lookup` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `votemate`.`candidate`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `votemate`.`candidate` ;

CREATE TABLE IF NOT EXISTS `votemate`.`candidate` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `fname` VARCHAR(45) NOT NULL,
  `lname` VARCHAR(45) NOT NULL,
  `party_lookup_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_candidate_party_lookup1_idx` (`party_lookup_id` ASC) VISIBLE,
  CONSTRAINT `fk_candidate_party_lookup1`
    FOREIGN KEY (`party_lookup_id`)
    REFERENCES `votemate`.`party_lookup` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `votemate`.`ballot_question`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `votemate`.`ballot_question` ;

CREATE TABLE IF NOT EXISTS `votemate`.`ballot_question` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `ballot_id` INT NOT NULL,
  `question` VARCHAR(144) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_ballot_choice_ballot1_idx` (`ballot_id` ASC) VISIBLE,
  CONSTRAINT `fk_ballot_choice_ballot1`
    FOREIGN KEY (`ballot_id`)
    REFERENCES `votemate`.`ballot` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `votemate`.`ballot_question_has_candidate`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `votemate`.`ballot_question_has_candidate` ;

CREATE TABLE IF NOT EXISTS `votemate`.`ballot_question_has_candidate` (
  `id` VARCHAR(45) NOT NULL,
  `ballot_question_id` INT NOT NULL,
  `candidate_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_ballot_choice_has_candidate_candidate1_idx` (`candidate_id` ASC) VISIBLE,
  INDEX `fk_ballot_choice_has_candidate_ballot_choice1_idx` (`ballot_question_id` ASC) VISIBLE,
  CONSTRAINT `fk_ballot_choice_has_candidate_ballot_choice1`
    FOREIGN KEY (`ballot_question_id`)
    REFERENCES `votemate`.`ballot_question` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ballot_choice_has_candidate_candidate1`
    FOREIGN KEY (`candidate_id`)
    REFERENCES `votemate`.`candidate` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `votemate`.`voter_ballot_started`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `votemate`.`voter_ballot_started` ;

CREATE TABLE IF NOT EXISTS `votemate`.`voter_ballot_started` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `ballot_id` INT NOT NULL,
  `voter_profile_id` INT NOT NULL,
  `ballot_question_has_candidate_id` VARCHAR(45) NOT NULL,
  `start` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_voter_ballot_started_voter_profile1_idx` (`voter_profile_id` ASC) VISIBLE,
  INDEX `fk_voter_ballot_started_ballot_question_has_candidate1_idx` (`ballot_question_has_candidate_id` ASC) VISIBLE,
  INDEX `fk_voter_ballot_started_ballot1_idx` (`ballot_id` ASC) VISIBLE,
  CONSTRAINT `fk_voter_ballot_started_voter_profile1`
    FOREIGN KEY (`voter_profile_id`)
    REFERENCES `votemate`.`voter_profile` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_voter_ballot_started_ballot_question_has_candidate1`
    FOREIGN KEY (`ballot_question_has_candidate_id`)
    REFERENCES `votemate`.`ballot_question_has_candidate` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_voter_ballot_started_ballot1`
    FOREIGN KEY (`ballot_id`)
    REFERENCES `votemate`.`ballot` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `votemate`.`voter_ballot_finished`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `votemate`.`voter_ballot_finished` ;

CREATE TABLE IF NOT EXISTS `votemate`.`voter_ballot_finished` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `time_submitted` DATETIME NOT NULL,
  `start_time` DATETIME NOT NULL,
  `finish_time` DATETIME NOT NULL,
  `voter_profile_id` INT NOT NULL,
  `ballot_question_has_candidate_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_voter_ballot_finished_voter_profile1_idx` (`voter_profile_id` ASC) VISIBLE,
  INDEX `fk_voter_ballot_finished_ballot_question_has_candidate1_idx` (`ballot_question_has_candidate_id` ASC) VISIBLE,
  CONSTRAINT `fk_voter_ballot_finished_voter_profile1`
    FOREIGN KEY (`voter_profile_id`)
    REFERENCES `votemate`.`voter_profile` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_voter_ballot_finished_ballot_question_has_candidate1`
    FOREIGN KEY (`ballot_question_has_candidate_id`)
    REFERENCES `votemate`.`ballot_question_has_candidate` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
