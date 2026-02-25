SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema aquarium_store_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `aquarium_store_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `aquarium_store_db` ;

-- -----------------------------------------------------
-- Table `aquarium_store_db`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aquarium_store_db`.`category` (
  `category_id` INT NOT NULL AUTO_INCREMENT,
  `category_name` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`category_id`),
  UNIQUE INDEX `category_name_UNIQUE` (`category_name` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `aquarium_store_db`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aquarium_store_db`.`customer` (
  `customer_id` INT NOT NULL AUTO_INCREMENT,
  `full_name` VARCHAR(100) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `phone` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`customer_id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `aquarium_store_db`.`store`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aquarium_store_db`.`store` (
  `store_id` INT NOT NULL AUTO_INCREMENT,
  `store_name` VARCHAR(100) NOT NULL,
  `phone` VARCHAR(20) NOT NULL,
  `location` VARCHAR(100) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`store_id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  UNIQUE INDEX `phone_UNIQUE` (`phone` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `aquarium_store_db`.`employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aquarium_store_db`.`employee` (
  `employee_id` INT NOT NULL AUTO_INCREMENT,
  `full_name` VARCHAR(100) NOT NULL,
  `role` VARCHAR(30) NOT NULL,
  `birth_date` DATE NOT NULL,
  `store_id` INT NOT NULL,
  PRIMARY KEY (`employee_id`),
  INDEX `fk_employee_store_idx` (`store_id` ASC) VISIBLE,
  CONSTRAINT `fk_employee_store`
    FOREIGN KEY (`store_id`)
    REFERENCES `aquarium_store_db`.`store` (`store_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `aquarium_store_db`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aquarium_store_db`.`orders` (
  `order_id` INT NOT NULL AUTO_INCREMENT,
  `customer_id` INT NOT NULL,
  `employee_id` INT NOT NULL,
  `order_date` DATE NOT NULL,
  PRIMARY KEY (`order_id`),
  INDEX `fk_orders_customers_idx` (`customer_id` ASC) VISIBLE,
  INDEX `fk_orders_employee_id_idx` (`employee_id` ASC) VISIBLE,
  CONSTRAINT `fk_orders_customers`
    FOREIGN KEY (`customer_id`)
    REFERENCES `aquarium_store_db`.`customer` (`customer_id`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_orders_employee_id`
    FOREIGN KEY (`employee_id`)
    REFERENCES `aquarium_store_db`.`employee` (`employee_id`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `aquarium_store_db`.`supplier`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aquarium_store_db`.`supplier` (
  `supplier_id` INT NOT NULL AUTO_INCREMENT,
  `supplier_name` VARCHAR(100) NOT NULL,
  `supplier_email` VARCHAR(100) NOT NULL,
  `supplier_phone` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`supplier_id`),
  UNIQUE INDEX `supplier_email_UNIQUE` (`supplier_email` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `aquarium_store_db`.`product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aquarium_store_db`.`product` (
  `product_id` INT NOT NULL AUTO_INCREMENT,
  `supplier_id` INT NOT NULL,
  `category_id` INT NOT NULL,
  `product_name` VARCHAR(100) NOT NULL,
  `price` DECIMAL(10,2) NOT NULL,
  `in_stock` TINYINT(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`product_id`),
  INDEX `fk_product_supplier_idx` (`supplier_id` ASC) VISIBLE,
  INDEX `fk_product_category_idx` (`category_id` ASC) VISIBLE,
  CONSTRAINT `fk_product_category`
    FOREIGN KEY (`category_id`)
    REFERENCES `aquarium_store_db`.`category` (`category_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_product_supplier`
    FOREIGN KEY (`supplier_id`)
    REFERENCES `aquarium_store_db`.`supplier` (`supplier_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `aquarium_store_db`.`order_item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aquarium_store_db`.`order_item` (
  `order_item_id` INT NOT NULL AUTO_INCREMENT,
  `order_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `quantity` INT NOT NULL DEFAULT '1',
  `unit_price` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`order_item_id`),
  INDEX `fk_order_item_orders_idx` (`order_id` ASC) VISIBLE,
  INDEX `fk_order_item_prodcut_idx` (`product_id` ASC) VISIBLE,
  CONSTRAINT `fk_order_item_orders`
    FOREIGN KEY (`order_id`)
    REFERENCES `aquarium_store_db`.`orders` (`order_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_order_item_prodcut`
    FOREIGN KEY (`product_id`)
    REFERENCES `aquarium_store_db`.`product` (`product_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
