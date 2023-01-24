-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';


-- -----------------------------------------------------
-- Schema targeted_marketing
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `targeted_marketing`;
CREATE SCHEMA `targeted_marketing` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `targeted_marketing`;

########################################################
#                   PERSONAL INFO                      #
#                       ROBEL                          #
########################################################
-- -----------------------------------------------------
-- Table `core_profile`
-- -----------------------------------------------------
CREATE TABLE `core_profile` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `f_name` VARCHAR(255),
  `l_name` VARCHAR(255),
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `phone`
-- -----------------------------------------------------
CREATE TABLE `phone` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `core_id` INT NOT NULL,
  `phone_num` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `core_id` (`core_id` ASC) VISIBLE,
  CONSTRAINT `phone_ibfk_1`
    FOREIGN KEY (`core_id`)
    REFERENCES `core_profile` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `address`
-- -----------------------------------------------------
CREATE TABLE `address` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `core_id` INT NOT NULL,
  `street` VARCHAR(45) NOT NULL,
  `apt` VARCHAR(45) NULL,
  `city` VARCHAR(45) NOT NULL,
  `state` VARCHAR(45) NOT NULL,
  `zip` VARCHAR(45) NOT NULL,
  `country` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `core_id` (`core_id` ASC) VISIBLE,
  CONSTRAINT `address_ibfk_1`
    FOREIGN KEY (`core_id`)
    REFERENCES `core_profile` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `email`
-- -----------------------------------------------------
CREATE TABLE `email` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `core_id` INT NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `core_id` (`core_id` ASC) VISIBLE,
  CONSTRAINT `email_ibfk_1`
    FOREIGN KEY (`core_id`)
    REFERENCES `core_profile` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `ip`
-- -----------------------------------------------------
CREATE TABLE `ip` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `core_id` INT NOT NULL,
  `ip_address` VARCHAR(45) NULL,
  `is_v4` BIT(1) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_url_core_profile1_idx` (`core_id` ASC) VISIBLE,
  CONSTRAINT `fk_url_core_profile1`
    FOREIGN KEY (`core_id`)
    REFERENCES `targeted_marketing`.`core_profile` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `ip_location`
-- -----------------------------------------------------
CREATE TABLE `ip_location` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `ip_id` INT NOT NULL,
  `city` VARCHAR(45) NULL,
  `state` VARCHAR(45) NULL,
  `zip` VARCHAR(45) NULL,
  `country` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_ip_location_ip1_idx` (`ip_id` ASC) VISIBLE,
  CONSTRAINT `fk_ip_location_ip1`
    FOREIGN KEY (`ip_id`)
    REFERENCES `ip` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `profile_data`
-- -----------------------------------------------------
CREATE TABLE `profile_data` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `core_id` INT NOT NULL,
  `gender` VARCHAR(20) NULL,
  `ethnicity` VARCHAR(45) NULL,
  `birthdate` DATE NULL,
  `marital_status` ENUM("Single", "Separated", "Divorced", "Married", "Widowed") NULL,
  INDEX `fk_meta_data_core_profile1_idx` (`core_id` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_meta_data_core_profile1`
    FOREIGN KEY (`core_id`)
    REFERENCES `targeted_marketing`.`core_profile` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `alias`
-- -----------------------------------------------------
CREATE TABLE `alias` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `core_id` INT NOT NULL,
  `f_name` VARCHAR(45) NULL,
  `l_name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_alias_core_profile1_idx` (`core_id` ASC) VISIBLE,
  CONSTRAINT `fk_alias_core_profile1`
    FOREIGN KEY (`core_id`)
    REFERENCES `targeted_marketing`.`core_profile` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

########################################################
#                      PRODUCTS                        #
#						 NICK			               #
########################################################

-- -----------------------------------------------------
-- Table `product_type`
-- -----------------------------------------------------
CREATE TABLE `product_type` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `product`
-- -----------------------------------------------------
CREATE TABLE `product` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `product_name` VARCHAR(255) NOT NULL,
  `product_type_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `product_type_id` (`product_type_id` ASC) VISIBLE,
  CONSTRAINT `products_ibfk_1`
    FOREIGN KEY (`product_type_id`)
    REFERENCES `product_type` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 31
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `seller`
-- -----------------------------------------------------
CREATE TABLE `seller` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `seller` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `product_by_seller`
-- -----------------------------------------------------
CREATE TABLE `product_by_seller` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `product_id` INT NOT NULL,
  `seller_id` INT NOT NULL,
  INDEX `fk_product_has_seller_seller1_idx` (`seller_id` ASC) VISIBLE,
  INDEX `fk_product_has_seller_product1_idx` (`product_id` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_product_has_seller_product1`
    FOREIGN KEY (`product_id`)
    REFERENCES `product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_has_seller_seller1`
    FOREIGN KEY (`seller_id`)
    REFERENCES `seller` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `profile_product`
-- -----------------------------------------------------
CREATE TABLE `profile_product` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `core_id` INT NOT NULL,
  `product_by_seller_id` INT NOT NULL,
  `rating` INT NOT NULL,
  `last_purchased` DATE NOT NULL,
  `price_paid` DECIMAL(10,2) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `core_id` (`core_id` ASC) VISIBLE,
  INDEX `fk_profile_product_product_by_seller1_idx` (`product_by_seller_id` ASC) VISIBLE,
  CONSTRAINT `profile_products_ibfk_1`
    FOREIGN KEY (`core_id`)
    REFERENCES `core_profile` (`id`),
  CONSTRAINT `fk_profile_product_product_by_seller1`
    FOREIGN KEY (`product_by_seller_id`)
    REFERENCES `product_by_seller` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

########################################################
#                     SERVICES                         #
#                       NICK                           #
########################################################

-- -----------------------------------------------------
-- Table `service_type`
-- -----------------------------------------------------
CREATE TABLE  `service_type` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `category` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `service`
-- -----------------------------------------------------
CREATE TABLE `service` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `category_id` INT NOT NULL,
  `service` VARCHAR(144) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `category_id` (`category_id` ASC) VISIBLE,
  CONSTRAINT `service_ibfk_1`
    FOREIGN KEY (`category_id`)
    REFERENCES `service_type` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `profile_service`
-- -----------------------------------------------------
CREATE TABLE `profile_service` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `core_id` INT NOT NULL,
  `service_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `core_id` (`core_id` ASC) VISIBLE,
  INDEX `services_id` (`service_id` ASC) VISIBLE,
  CONSTRAINT `profile_service_ibfk_1`
    FOREIGN KEY (`core_id`)
    REFERENCES `core_profile` (`id`),
  CONSTRAINT `profile_service_ibfk_2`
    FOREIGN KEY (`service_id`)
    REFERENCES `service` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

########################################################
#                      OPINIONS                        #
#                    BRINK  BRINK                      #
########################################################

-- -----------------------------------------------------
-- Table `sm_opinions_type`
-- -----------------------------------------------------
CREATE TABLE `sm_opinion_type` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `opinion`
-- -----------------------------------------------------
CREATE TABLE `opinion` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `smo_type_id` INT NOT NULL,
  `opinion` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `smo_type_id` (`smo_type_id` ASC) VISIBLE,
  CONSTRAINT `opinions_ibfk_1`
    FOREIGN KEY (`smo_type_id`)
    REFERENCES `sm_opinions_type` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 10
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `profile_opinion`
-- -----------------------------------------------------
CREATE TABLE `profile_opinion` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `core_id` INT NOT NULL,
  `opinion_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `core_id` (`core_id` ASC) VISIBLE,
  INDEX `opinion_id` (`opinion_id` ASC) VISIBLE,
  CONSTRAINT `profile_opinions_ibfk_1`
    FOREIGN KEY (`core_id`)
    REFERENCES `core_profile` (`id`),
  CONSTRAINT `profile_opinions_ibfk_2`
    FOREIGN KEY (`opinion_id`)
    REFERENCES `opinion` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

########################################################
#                    SOCIAL MEDIA                      #
#                        GARY                          #
########################################################

-- -----------------------------------------------------
-- Table `social_media_platform`
-- -----------------------------------------------------
CREATE TABLE  `social_media_platform` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `platform` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `sm_transaction`
-- -----------------------------------------------------
CREATE TABLE  `sm_transaction` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `core_id` INT NOT NULL,
  `smp_id` INT NOT NULL,
  `price_paid` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Transactions_core_profile1_idx` (`core_id` ASC) VISIBLE,
  INDEX `fk_Transactions_social_media_platforms1_idx` (`smp_id` ASC) VISIBLE,
  CONSTRAINT `fk_Transactions_core_profile1`
    FOREIGN KEY (`core_id`)
    REFERENCES `targeted_marketing`.`core_profile` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Transactions_social_media_platforms1`
    FOREIGN KEY (`smp_id`)
    REFERENCES `targeted_marketing`.`social_media_platform` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `sm_item_type`
-- -----------------------------------------------------
CREATE TABLE `sm_item_type` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `sm_item`
-- -----------------------------------------------------
CREATE TABLE `sm_item` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `type_id` INT NOT NULL,
  `item` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`, `type_id`),
  INDEX `fk_sm_item_sm_item_type1_idx` (`type_id` ASC) VISIBLE,
  CONSTRAINT `fk_sm_item_sm_item_type1`
    FOREIGN KEY (`type_id`)
    REFERENCES `sm_item_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `sm_seller`
-- -----------------------------------------------------
CREATE TABLE `sm_seller` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `seller` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `sm_item_by_seller`
-- -----------------------------------------------------
CREATE TABLE `sm_item_by_seller` (
  `id` INT NOT NULL,
  `sm_transaction_id` INT NOT NULL,
  `sm_seller_id` INT NOT NULL,
  `sm_item_id` INT NOT NULL,
  INDEX `fk_sm_seller_has_sm_item_sm_item1_idx` (`sm_item_id` ASC) VISIBLE,
  INDEX `fk_sm_seller_has_sm_item_sm_seller1_idx` (`sm_seller_id` ASC) VISIBLE,
  INDEX `fk_sm_seller_has_item_sm_transaction1_idx` (`sm_transaction_id` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_sm_seller_has_sm_item_sm_seller1`
    FOREIGN KEY (`sm_seller_id`)
    REFERENCES `sm_seller` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sm_seller_has_sm_item_sm_item1`
    FOREIGN KEY (`sm_item_id`)
    REFERENCES `sm_item` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sm_seller_has_item_sm_transaction1`
    FOREIGN KEY (`sm_transaction_id`)
    REFERENCES `sm_transaction` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `social_media`
-- -----------------------------------------------------
CREATE TABLE `social_media` (
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
    REFERENCES `core_profile` (`id`),
  CONSTRAINT `social_media_ibfk_2`
    FOREIGN KEY (`sm_platform_id`)
    REFERENCES `social_media_platform` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `post`
-- -----------------------------------------------------
CREATE TABLE `post` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `social_media_id` INT NOT NULL,
  `content` VARCHAR(45) NOT NULL,
  INDEX `fk_post_social_media1_idx` (`social_media_id` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_post_social_media1`
    FOREIGN KEY (`social_media_id`)
    REFERENCES `targeted_marketing`.`social_media` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `like`
-- -----------------------------------------------------
CREATE TABLE `like` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `social_media_id` INT NOT NULL,
  `content` VARCHAR(45) NOT NULL,
  `url` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_like_social_media1_idx` (`social_media_id` ASC) VISIBLE,
  CONSTRAINT `fk_like_social_media1`
    FOREIGN KEY (`social_media_id`)
    REFERENCES `targeted_marketing`.`social_media` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `friend`
-- -----------------------------------------------------
CREATE TABLE `friend` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `social_media_id` INT NOT NULL,
  `core_profile_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_friend_social_media1_idx` (`social_media_id` ASC) VISIBLE,
  INDEX `fk_friend_core_profile1_idx` (`core_profile_id` ASC) VISIBLE,
  CONSTRAINT `fk_friend_social_media1`
    FOREIGN KEY (`social_media_id`)
    REFERENCES `targeted_marketing`.`social_media` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_friend_core_profile1`
    FOREIGN KEY (`core_profile_id`)
    REFERENCES `targeted_marketing`.`core_profile` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `group`
-- -----------------------------------------------------
CREATE TABLE `group` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NULL,
  `url` VARCHAR(45) NOT NULL,
  `social_media_id` INT NOT NULL,
  PRIMARY KEY (`id`, `social_media_id`),
  INDEX `fk_group_social_media1_idx` (`social_media_id` ASC) VISIBLE,
  CONSTRAINT `fk_group_social_media1`
    FOREIGN KEY (`social_media_id`)
    REFERENCES `targeted_marketing`.`social_media` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `sm_opinion_type_by_platform`
-- -----------------------------------------------------
CREATE TABLE `sm_opinion_type_by_platform` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `sm_opinion_type_id` INT NOT NULL,
  `social_media_platform_id` INT NOT NULL,
  INDEX `fk_sm_opinion_category_has_social_media_platform_social_me_idx` (`social_media_platform_id` ASC) VISIBLE,
  INDEX `fk_sm_opinion_category_has_social_media_platform_sm_opinio_idx` (`sm_opinion_type_id` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_sm_opinion_category_has_social_media_platform_sm_opinions1`
    FOREIGN KEY (`sm_opinion_type_id`)
    REFERENCES `sm_opinion_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sm_opinion_category_has_social_media_platform_social_medi1`
    FOREIGN KEY (`social_media_platform_id`)
    REFERENCES `social_media_platform` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
