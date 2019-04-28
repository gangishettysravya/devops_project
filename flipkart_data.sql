-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema flipkartdb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema flipkartdb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `flipkartdb` DEFAULT CHARACTER SET utf8 ;
USE `flipkartdb` ;

-- -----------------------------------------------------
-- Table `flipkartdb`.`Buyer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flipkartdb`.`Buyer` (
  `buyer_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(80) NOT NULL,
  `email` VARCHAR(50) NOT NULL,
  `phone_no` VARCHAR(10) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `pic_location` VARCHAR(80) NULL,
  `gender` ENUM('F', 'M', 'others') NOT NULL,
  `dob` DATE NULL,
  PRIMARY KEY (`buyer_id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC),
  UNIQUE INDEX `phone_no_UNIQUE` (`phone_no` ASC),
  UNIQUE INDEX `pic_location_UNIQUE` (`pic_location` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flipkartdb`.`BuyerAddress`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flipkartdb`.`BuyerAddress` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `buyer_id` INT NOT NULL,
  `address` VARCHAR(100) NOT NULL,
  `name` VARCHAR(45) NOT NULL DEFAULT 'home',
  `type` ENUM('DEFAULT', 'GENERAL') NOT NULL DEFAULT 'GENERAL',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_BuyerAddress_1`
    FOREIGN KEY (`buyer_id`)
    REFERENCES `flipkartdb`.`Buyer` (`buyer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flipkartdb`.`Category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flipkartdb`.`Category` (
  `category_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `cat_img` VARCHAR(90) NULL,
  PRIMARY KEY (`category_id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flipkartdb`.`SubCategory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flipkartdb`.`SubCategory` (
  `subcategory_id` INT NOT NULL AUTO_INCREMENT,
  `category_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `subcat_img` VARCHAR(90) NULL,
  PRIMARY KEY (`subcategory_id`),
  CONSTRAINT `fk_SubCategory_1`
    FOREIGN KEY (`category_id`)
    REFERENCES `flipkartdb`.`Category` (`category_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flipkartdb`.`Seller`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flipkartdb`.`Seller` (
  `seller_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(80) NOT NULL,
  `email` VARCHAR(50) NOT NULL,
  `phone_no` VARCHAR(10) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `pic_location` VARCHAR(80) NULL,
  `gst_info` VARCHAR(45) NOT NULL,
  `address` VARCHAR(100) NOT NULL,
  `gender` ENUM('F', 'M', 'others') NULL,
  PRIMARY KEY (`seller_id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC),
  UNIQUE INDEX `phone_no_UNIQUE` (`phone_no` ASC),
  UNIQUE INDEX `pic_location_UNIQUE` (`pic_location` ASC),
  UNIQUE INDEX `gst_info_UNIQUE` (`gst_info` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flipkartdb`.`Brand`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flipkartdb`.`Brand` (
  `brand` VARCHAR(50) NOT NULL,
  `subcategory_id` INT NOT NULL,
  `brand_img` VARCHAR(90) NULL,
  INDEX `fk_Brand_1_idx` (`subcategory_id` ASC),
  PRIMARY KEY (`brand`, `subcategory_id`),
  CONSTRAINT `fk_Brand_1`
    FOREIGN KEY (`subcategory_id`)
    REFERENCES `flipkartdb`.`SubCategory` (`subcategory_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flipkartdb`.`Item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flipkartdb`.`Item` (
  `item_id` INT NOT NULL AUTO_INCREMENT,
  `id` VARCHAR(10) NOT NULL,
  `name` VARCHAR(90) NOT NULL,
  `subcategory_id` INT NOT NULL,
  `quantity` INT NOT NULL,
  `price` FLOAT NOT NULL,
  `brand` VARCHAR(50) NOT NULL,
  `description` VARCHAR(90) NULL,
  `attribute1` VARCHAR(45) NULL,
  `manufacture_date` DATE NOT NULL,
  `color` VARCHAR(45) NULL,
  `discount` FLOAT NULL DEFAULT 0,
  `seller_id` INT NULL,
  `status` ENUM('EXISTS', 'DELETED') NOT NULL DEFAULT 'EXISTS',
  PRIMARY KEY (`item_id`),
  INDEX `fk_Item_1_idx` (`subcategory_id` ASC),
  INDEX `fk_Item_2_idx` (`seller_id` ASC),
  UNIQUE INDEX `index4` (`id` ASC, `seller_id` ASC),
  INDEX `fk_Item_3_idx` (`brand` ASC),
  CONSTRAINT `fk_Item_1`
    FOREIGN KEY (`subcategory_id`)
    REFERENCES `flipkartdb`.`SubCategory` (`subcategory_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Item_2`
    FOREIGN KEY (`seller_id`)
    REFERENCES `flipkartdb`.`Seller` (`seller_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Item_3`
    FOREIGN KEY (`brand`)
    REFERENCES `flipkartdb`.`Brand` (`brand`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flipkartdb`.`ItemImages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flipkartdb`.`ItemImages` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `item_id` INT NOT NULL,
  `image_location` VARCHAR(90) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_ItemImages_1`
    FOREIGN KEY (`item_id`)
    REFERENCES `flipkartdb`.`Item` (`item_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flipkartdb`.`ItemDetails`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flipkartdb`.`ItemDetails` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `item_id` INT NOT NULL,
  `item_key` VARCHAR(75) NOT NULL,
  `item_value` VARCHAR(75) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_ItemDetails_1`
    FOREIGN KEY (`item_id`)
    REFERENCES `flipkartdb`.`Item` (`item_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flipkartdb`.`OrderItem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flipkartdb`.`OrderItem` (
  `order_id` INT NOT NULL AUTO_INCREMENT,
  `item_id` INT NOT NULL,
  `seller_id` INT NOT NULL,
  `buyer_id` INT NOT NULL,
  `address_id` INT NOT NULL,
  `quantity` INT NOT NULL DEFAULT 1,
  `amount_paid` FLOAT NOT NULL,
  `status` ENUM('paymentdone', 'shipped', 'delivered', 'paymentsent', 'cancelled') NOT NULL,
  `order_date` DATETIME NOT NULL,
  INDEX `fk_OrderItem_2_idx` (`item_id` ASC),
  INDEX `fk_OrderItem_3_idx` (`seller_id` ASC),
  PRIMARY KEY (`order_id`),
  INDEX `fk_OrderItem_4_idx` (`address_id` ASC),
  INDEX `fk_OrderItem_5_idx` (`buyer_id` ASC),
  CONSTRAINT `fk_OrderItem_2`
    FOREIGN KEY (`item_id`)
    REFERENCES `flipkartdb`.`Item` (`item_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_OrderItem_3`
    FOREIGN KEY (`seller_id`)
    REFERENCES `flipkartdb`.`Seller` (`seller_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_OrderItem_4`
    FOREIGN KEY (`address_id`)
    REFERENCES `flipkartdb`.`BuyerAddress` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_OrderItem_5`
    FOREIGN KEY (`buyer_id`)
    REFERENCES `flipkartdb`.`Buyer` (`buyer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flipkartdb`.`Review`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flipkartdb`.`Review` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `orderItem_id` INT NOT NULL,
  `buyer_id` INT NOT NULL,
  `item_id` INT NOT NULL,
  `seller_id` INT NOT NULL,
  `rating` ENUM('1', '2', '3', '4', '5') NOT NULL,
  `review` VARCHAR(90) NULL,
  INDEX `fk_Review_2_idx` (`item_id` ASC),
  INDEX `fk_Review_3_idx` (`seller_id` ASC),
  PRIMARY KEY (`id`),
  INDEX `fk_Review_4_idx` (`orderItem_id` ASC),
  CONSTRAINT `fk_Review_1`
    FOREIGN KEY (`buyer_id`)
    REFERENCES `flipkartdb`.`Buyer` (`buyer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Review_2`
    FOREIGN KEY (`item_id`)
    REFERENCES `flipkartdb`.`Item` (`item_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Review_3`
    FOREIGN KEY (`seller_id`)
    REFERENCES `flipkartdb`.`Seller` (`seller_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Review_4`
    FOREIGN KEY (`orderItem_id`)
    REFERENCES `flipkartdb`.`OrderItem` (`order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flipkartdb`.`Deal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flipkartdb`.`Deal` (
  `deal_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(90) NOT NULL,
  `deal_discount` FLOAT NOT NULL DEFAULT 0,
  `date_added` DATETIME NOT NULL,
  `date_ended` DATETIME NOT NULL,
  `deal_img` VARCHAR(80) NULL,
  PRIMARY KEY (`deal_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flipkartdb`.`DealItem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flipkartdb`.`DealItem` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `deal_id` INT NOT NULL,
  `item_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_DealItem_2_idx` (`item_id` ASC),
  CONSTRAINT `fk_DealItem_1`
    FOREIGN KEY (`deal_id`)
    REFERENCES `flipkartdb`.`Deal` (`deal_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_DealItem_2`
    FOREIGN KEY (`item_id`)
    REFERENCES `flipkartdb`.`Item` (`item_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flipkartdb`.`BuyerAccount`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flipkartdb`.`BuyerAccount` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `accountno` VARCHAR(12) NOT NULL,
  `buyer_id` INT NOT NULL,
  `pin` VARCHAR(4) NOT NULL,
  `balance` FLOAT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  INDEX `fk_BuyerAccount_1_idx` (`buyer_id` ASC),
  UNIQUE INDEX `accountno_UNIQUE` (`accountno` ASC),
  CONSTRAINT `fk_BuyerAccount_1`
    FOREIGN KEY (`buyer_id`)
    REFERENCES `flipkartdb`.`Buyer` (`buyer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flipkartdb`.`SellerAccount`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flipkartdb`.`SellerAccount` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `accountno` VARCHAR(12) NOT NULL,
  `seller_id` INT NOT NULL,
  `pin` VARCHAR(4) NOT NULL,
  `balance` FLOAT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  INDEX `fk_SellerAccount_1_idx` (`seller_id` ASC),
  UNIQUE INDEX `accountno_UNIQUE` (`accountno` ASC),
  CONSTRAINT `fk_SellerAccount_1`
    FOREIGN KEY (`seller_id`)
    REFERENCES `flipkartdb`.`Seller` (`seller_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flipkartdb`.`WishlistItem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flipkartdb`.`WishlistItem` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `buyer_id` INT NOT NULL,
  `item_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_WishlistItem_1_idx` (`buyer_id` ASC),
  CONSTRAINT `fk_WishlistItem_1`
    FOREIGN KEY (`buyer_id`)
    REFERENCES `flipkartdb`.`Buyer` (`buyer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_WishlistItem_2`
    FOREIGN KEY (`item_id`)
    REFERENCES `flipkartdb`.`Item` (`item_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flipkartdb`.`Cart`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flipkartdb`.`Cart` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `buyer_id` INT NOT NULL,
  `item_id` INT NOT NULL,
  `quantity` INT NOT NULL DEFAULT 1,
  `deal_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Cart_2_idx` (`item_id` ASC),
  CONSTRAINT `fk_Cart_1`
    FOREIGN KEY (`buyer_id`)
    REFERENCES `flipkartdb`.`Buyer` (`buyer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cart_2`
    FOREIGN KEY (`item_id`)
    REFERENCES `flipkartdb`.`Item` (`item_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flipkartdb`.`FlipkartAccount`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flipkartdb`.`FlipkartAccount` (
  `accountno` VARCHAR(12) NOT NULL,
  `balance` FLOAT NOT NULL DEFAULT 0,
  PRIMARY KEY (`accountno`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flipkartdb`.`FixedAttribute`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flipkartdb`.`FixedAttribute` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `subcategory_id` INT NOT NULL,
  `value` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_FixedAttribute_1_idx` (`subcategory_id` ASC),
  UNIQUE INDEX `index3` (`name` ASC, `subcategory_id` ASC, `value` ASC),
  CONSTRAINT `fk_FixedAttribute_1`
    FOREIGN KEY (`subcategory_id`)
    REFERENCES `flipkartdb`.`SubCategory` (`subcategory_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flipkartdb`.`Color`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flipkartdb`.`Color` (
  `color_id` INT NOT NULL AUTO_INCREMENT,
  `color` VARCHAR(45) NOT NULL,
  `subcategory_id` INT NOT NULL,
  INDEX `fk_Color_1_idx` (`subcategory_id` ASC),
  PRIMARY KEY (`color_id`),
  CONSTRAINT `fk_Color_1`
    FOREIGN KEY (`subcategory_id`)
    REFERENCES `flipkartdb`.`SubCategory` (`subcategory_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `flipkartdb`.`Buyer`
-- -----------------------------------------------------
START TRANSACTION;
USE `flipkartdb`;
INSERT INTO `flipkartdb`.`Buyer` (`buyer_id`, `name`, `email`, `phone_no`, `password`, `pic_location`, `gender`, `dob`) VALUES (1, 'Deepika Alavala', 'Deepika.Alavala@iiitb.org', '9611529722', '12345', 'images/buyer/1.jpg', 'F', '1997-10-25');
INSERT INTO `flipkartdb`.`Buyer` (`buyer_id`, `name`, `email`, `phone_no`, `password`, `pic_location`, `gender`, `dob`) VALUES (2, 'Sravya Gangishetty', 'G.Sravya@iiitb.org', '7730069061', '12345', 'images/buyer/2.jpg', 'F', '1997-06-11');
INSERT INTO `flipkartdb`.`Buyer` (`buyer_id`, `name`, `email`, `phone_no`, `password`, `pic_location`, `gender`, `dob`) VALUES (3, 'Mahith Bhima', 'Mahith.Bhima@iiitb.org', '7022386529', '12345', 'images/buyer/3.jpg', 'M', '1997-04-18');
INSERT INTO `flipkartdb`.`Buyer` (`buyer_id`, `name`, `email`, `phone_no`, `password`, `pic_location`, `gender`, `dob`) VALUES (4, 'Pranith Reddy', 'Pranith.Reddy@iiitb.org', '8121390529', '12345', 'images/buyer/4.jpg', 'M', '1996-08-25');
INSERT INTO `flipkartdb`.`Buyer` (`buyer_id`, `name`, `email`, `phone_no`, `password`, `pic_location`, `gender`, `dob`) VALUES (5, 'Karthikeya Reddy', 'Karthikeya.Reddy@iiitb.org', '8722356778', '12345', 'images/buyer/5.jpg', 'M', '1997-11-17');
INSERT INTO `flipkartdb`.`Buyer` (`buyer_id`, `name`, `email`, `phone_no`, `password`, `pic_location`, `gender`, `dob`) VALUES (6, 'Venkateswara Rao', 'Raghavarapu.Venkateswararao@iiitb.org', '7899003569', '12345', 'images/buyer/6.jpg', 'M', '1997-06-19');
INSERT INTO `flipkartdb`.`Buyer` (`buyer_id`, `name`, `email`, `phone_no`, `password`, `pic_location`, `gender`, `dob`) VALUES (7, 'Sowmya Dasari', 'Sowmya.Dasari', '7795268399', '12345', 'images/buyer/7.jpg', 'F', '1996-10-26');
INSERT INTO `flipkartdb`.`Buyer` (`buyer_id`, `name`, `email`, `phone_no`, `password`, `pic_location`, `gender`, `dob`) VALUES (8, 'Praneeth Reddy', 'Praneeth.Reddy@iiitb.org', '8309939709', '12345', 'images/buyer/8.jpg', 'M', '1996-11-11');

COMMIT;


-- -----------------------------------------------------
-- Data for table `flipkartdb`.`BuyerAddress`
-- -----------------------------------------------------
START TRANSACTION;
USE `flipkartdb`;
INSERT INTO `flipkartdb`.`BuyerAddress` (`id`, `buyer_id`, `address`, `name`, `type`) VALUES (1, 1, 'IIIT Bangalore', 'College', 'DEFAULT');
INSERT INTO `flipkartdb`.`BuyerAddress` (`id`, `buyer_id`, `address`, `name`, `type`) VALUES (2, 2, 'IIIT Bangalore', 'College', 'DEFAULT');
INSERT INTO `flipkartdb`.`BuyerAddress` (`id`, `buyer_id`, `address`, `name`, `type`) VALUES (3, 3, 'IIIT Bangalore', 'Home', 'GENERAL');
INSERT INTO `flipkartdb`.`BuyerAddress` (`id`, `buyer_id`, `address`, `name`, `type`) VALUES (4, 4, 'IIITB', 'Home', 'GENERAL');

COMMIT;


-- -----------------------------------------------------
-- Data for table `flipkartdb`.`Category`
-- -----------------------------------------------------
START TRANSACTION;
USE `flipkartdb`;
INSERT INTO `flipkartdb`.`Category` (`category_id`, `name`, `cat_img`) VALUES (1, 'Men', 'images/category/1.jpeg');
INSERT INTO `flipkartdb`.`Category` (`category_id`, `name`, `cat_img`) VALUES (2, 'Women', 'images/category/2.jpeg');
INSERT INTO `flipkartdb`.`Category` (`category_id`, `name`, `cat_img`) VALUES (3, 'Furniture', 'images/category/3.jpeg');
INSERT INTO `flipkartdb`.`Category` (`category_id`, `name`, `cat_img`) VALUES (4, 'Stationary', 'images/category/4.jpeg');
INSERT INTO `flipkartdb`.`Category` (`category_id`, `name`, `cat_img`) VALUES (5, 'Electronics', 'images/category/5.jpeg');

COMMIT;


-- -----------------------------------------------------
-- Data for table `flipkartdb`.`SubCategory`
-- -----------------------------------------------------
START TRANSACTION;
USE `flipkartdb`;
INSERT INTO `flipkartdb`.`SubCategory` (`subcategory_id`, `category_id`, `name`, `subcat_img`) VALUES (1, 1, 'Clothing', 'images/subcategory/1.jpeg');
INSERT INTO `flipkartdb`.`SubCategory` (`subcategory_id`, `category_id`, `name`, `subcat_img`) VALUES (2, 1, 'Footwear', 'images/subcategory/2.jpeg');
INSERT INTO `flipkartdb`.`SubCategory` (`subcategory_id`, `category_id`, `name`, `subcat_img`) VALUES (3, 1, 'Watches', 'images/subcategory/3.jpeg');
INSERT INTO `flipkartdb`.`SubCategory` (`subcategory_id`, `category_id`, `name`, `subcat_img`) VALUES (4, 2, 'Clothing', 'images/subcategory/4.jpeg');
INSERT INTO `flipkartdb`.`SubCategory` (`subcategory_id`, `category_id`, `name`, `subcat_img`) VALUES (5, 2, 'Footwear', 'images/subcategory/5.jpeg');
INSERT INTO `flipkartdb`.`SubCategory` (`subcategory_id`, `category_id`, `name`, `subcat_img`) VALUES (6, 2, 'Beauty', 'images/subcategory/6.jpeg');
INSERT INTO `flipkartdb`.`SubCategory` (`subcategory_id`, `category_id`, `name`, `subcat_img`) VALUES (7, 3, 'Kitchen', 'images/subcategory/7.jpeg');
INSERT INTO `flipkartdb`.`SubCategory` (`subcategory_id`, `category_id`, `name`, `subcat_img`) VALUES (8, 3, 'Home decor', 'images/subcategory/8.jpeg');
INSERT INTO `flipkartdb`.`SubCategory` (`subcategory_id`, `category_id`, `name`, `subcat_img`) VALUES (9, 3, 'Tools', 'images/subcategory/9.jpeg');
INSERT INTO `flipkartdb`.`SubCategory` (`subcategory_id`, `category_id`, `name`, `subcat_img`) VALUES (10, 4, 'Books', 'images/subcategory/10.jpeg');
INSERT INTO `flipkartdb`.`SubCategory` (`subcategory_id`, `category_id`, `name`, `subcat_img`) VALUES (11, 4, 'Pens', 'images/subcategory/11.jpeg');
INSERT INTO `flipkartdb`.`SubCategory` (`subcategory_id`, `category_id`, `name`, `subcat_img`) VALUES (12, 4, 'Desk Organisers', 'images/subcategory/12.jpeg');
INSERT INTO `flipkartdb`.`SubCategory` (`subcategory_id`, `category_id`, `name`, `subcat_img`) VALUES (13, 5, 'Mobiles', 'images/subcategory/13.jpeg');
INSERT INTO `flipkartdb`.`SubCategory` (`subcategory_id`, `category_id`, `name`, `subcat_img`) VALUES (14, 5, 'Laptops', 'images/subcategory/14.jpeg');
INSERT INTO `flipkartdb`.`SubCategory` (`subcategory_id`, `category_id`, `name`, `subcat_img`) VALUES (15, 5, 'Televisions', 'images/subcategory/15.jpeg');
INSERT INTO `flipkartdb`.`SubCategory` (`subcategory_id`, `category_id`, `name`, `subcat_img`) VALUES (16, 1, 'Others', 'images/subcategory/16.jpeg');
INSERT INTO `flipkartdb`.`SubCategory` (`subcategory_id`, `category_id`, `name`, `subcat_img`) VALUES (17, 2, 'Others', 'images/subcategory/17.jpeg');
INSERT INTO `flipkartdb`.`SubCategory` (`subcategory_id`, `category_id`, `name`, `subcat_img`) VALUES (18, 3, 'Others', 'images/subcategory/18.jpeg');
INSERT INTO `flipkartdb`.`SubCategory` (`subcategory_id`, `category_id`, `name`, `subcat_img`) VALUES (19, 4, 'Others', 'images/subcategory/19.jpeg');
INSERT INTO `flipkartdb`.`SubCategory` (`subcategory_id`, `category_id`, `name`, `subcat_img`) VALUES (20, 5, 'Others', 'images/subcategory/20.jpeg');

COMMIT;


-- -----------------------------------------------------
-- Data for table `flipkartdb`.`Seller`
-- -----------------------------------------------------
START TRANSACTION;
USE `flipkartdb`;
INSERT INTO `flipkartdb`.`Seller` (`seller_id`, `name`, `email`, `phone_no`, `password`, `pic_location`, `gst_info`, `address`, `gender`) VALUES (1, 'Kiran', 'kiran@gmail.com', '7865412345', '12345', 'images/seller/1.jpg', 'GST123456', 'Flat no. 545, Mumbai', 'M');
INSERT INTO `flipkartdb`.`Seller` (`seller_id`, `name`, `email`, `phone_no`, `password`, `pic_location`, `gst_info`, `address`, `gender`) VALUES (2, 'Mohan', 'mohan@gmail.com', '5641323551', '12345', 'images/seller/2.jpg', 'GST234561', 'Flat no. 10, Bangalore', 'M');

COMMIT;


-- -----------------------------------------------------
-- Data for table `flipkartdb`.`Brand`
-- -----------------------------------------------------
START TRANSACTION;
USE `flipkartdb`;
INSERT INTO `flipkartdb`.`Brand` (`brand`, `subcategory_id`, `brand_img`) VALUES ('Wrangler', 1, 'images/brand/1.jpeg');
INSERT INTO `flipkartdb`.`Brand` (`brand`, `subcategory_id`, `brand_img`) VALUES ('Arrow', 1, 'images/brand/2.jpeg');
INSERT INTO `flipkartdb`.`Brand` (`brand`, `subcategory_id`, `brand_img`) VALUES ('Reebok', 1, 'images/brand/3.jpeg');
INSERT INTO `flipkartdb`.`Brand` (`brand`, `subcategory_id`, `brand_img`) VALUES ('Adidas', 2, 'images/brand/4.jpeg');
INSERT INTO `flipkartdb`.`Brand` (`brand`, `subcategory_id`, `brand_img`) VALUES ('Puma', 2, 'images/brand/5.jpeg');
INSERT INTO `flipkartdb`.`Brand` (`brand`, `subcategory_id`, `brand_img`) VALUES ('Sparks', 2, 'images/brand/6.jpeg');
INSERT INTO `flipkartdb`.`Brand` (`brand`, `subcategory_id`, `brand_img`) VALUES ('Titan', 3, 'images/brand/7.jpeg');
INSERT INTO `flipkartdb`.`Brand` (`brand`, `subcategory_id`, `brand_img`) VALUES ('Fastrack', 3, 'images/brand/8.jpeg');
INSERT INTO `flipkartdb`.`Brand` (`brand`, `subcategory_id`, `brand_img`) VALUES ('Casio', 3, 'images/brand/9.jpeg');
INSERT INTO `flipkartdb`.`Brand` (`brand`, `subcategory_id`, `brand_img`) VALUES ('Biba', 4, 'images/brand/10.jpeg');
INSERT INTO `flipkartdb`.`Brand` (`brand`, `subcategory_id`, `brand_img`) VALUES ('W', 4, 'images/brand/11.jpeg');
INSERT INTO `flipkartdb`.`Brand` (`brand`, `subcategory_id`, `brand_img`) VALUES ('Aureila', 4, 'images/brand/12.jpeg');
INSERT INTO `flipkartdb`.`Brand` (`brand`, `subcategory_id`, `brand_img`) VALUES ('Catwalk', 5, 'images/brand/13.jpeg');
INSERT INTO `flipkartdb`.`Brand` (`brand`, `subcategory_id`, `brand_img`) VALUES ('Flipside', 5, 'images/brand/14.jpeg');
INSERT INTO `flipkartdb`.`Brand` (`brand`, `subcategory_id`, `brand_img`) VALUES ('Skechers', 5, 'images/brand/15.jpeg');
INSERT INTO `flipkartdb`.`Brand` (`brand`, `subcategory_id`, `brand_img`) VALUES ('Lakme', 6, 'images/brand/16.jpeg');
INSERT INTO `flipkartdb`.`Brand` (`brand`, `subcategory_id`, `brand_img`) VALUES ('Ponds', 6, 'images/brand/17.jpeg');
INSERT INTO `flipkartdb`.`Brand` (`brand`, `subcategory_id`, `brand_img`) VALUES ('Nivea', 6, 'images/brand/18.jpeg');
INSERT INTO `flipkartdb`.`Brand` (`brand`, `subcategory_id`, `brand_img`) VALUES ('Laopala', 7, 'images/brand/19.jpeg');
INSERT INTO `flipkartdb`.`Brand` (`brand`, `subcategory_id`, `brand_img`) VALUES ('Haffle', 7, 'images/brand/20.jpeg');
INSERT INTO `flipkartdb`.`Brand` (`brand`, `subcategory_id`, `brand_img`) VALUES ('Bajaj', 7, 'images/brand/21.jpeg');
INSERT INTO `flipkartdb`.`Brand` (`brand`, `subcategory_id`, `brand_img`) VALUES ('Abstract', 8, 'images/brand/22.jpeg');
INSERT INTO `flipkartdb`.`Brand` (`brand`, `subcategory_id`, `brand_img`) VALUES ('Absorbia', 8, 'images/brand/23.jpeg');
INSERT INTO `flipkartdb`.`Brand` (`brand`, `subcategory_id`, `brand_img`) VALUES ('Sathrangi', 8, 'images/brand/24.jpeg');
INSERT INTO `flipkartdb`.`Brand` (`brand`, `subcategory_id`, `brand_img`) VALUES ('Bosch', 9, 'images/brand/25.jpeg');
INSERT INTO `flipkartdb`.`Brand` (`brand`, `subcategory_id`, `brand_img`) VALUES ('Aeronocs', 9, 'images/brand/26.jpeg');
INSERT INTO `flipkartdb`.`Brand` (`brand`, `subcategory_id`, `brand_img`) VALUES ('Bathla', 9, 'images/brand/27.jpeg');
INSERT INTO `flipkartdb`.`Brand` (`brand`, `subcategory_id`, `brand_img`) VALUES ('Classmate', 10, 'images/brand/28.jpeg');
INSERT INTO `flipkartdb`.`Brand` (`brand`, `subcategory_id`, `brand_img`) VALUES ('Oxford', 10, 'images/brand/29.jpeg');
INSERT INTO `flipkartdb`.`Brand` (`brand`, `subcategory_id`, `brand_img`) VALUES ('Lepakshi', 10, 'images/brand/30.jpeg');
INSERT INTO `flipkartdb`.`Brand` (`brand`, `subcategory_id`, `brand_img`) VALUES ('Cello', 11, 'images/brand/31.jpeg');
INSERT INTO `flipkartdb`.`Brand` (`brand`, `subcategory_id`, `brand_img`) VALUES ('Park Avenue', 11, 'images/brand/32.jpeg');
INSERT INTO `flipkartdb`.`Brand` (`brand`, `subcategory_id`, `brand_img`) VALUES ('Pilot', 11, 'images/brand/33.jpeg');
INSERT INTO `flipkartdb`.`Brand` (`brand`, `subcategory_id`, `brand_img`) VALUES ('Apex', 12, 'images/brand/34.jpeg');
INSERT INTO `flipkartdb`.`Brand` (`brand`, `subcategory_id`, `brand_img`) VALUES ('Chumbak', 12, 'images/brand/35.jpeg');
INSERT INTO `flipkartdb`.`Brand` (`brand`, `subcategory_id`, `brand_img`) VALUES ('Cello', 12, 'images/brand/36.jpeg');
INSERT INTO `flipkartdb`.`Brand` (`brand`, `subcategory_id`, `brand_img`) VALUES ('Samsung', 13, 'images/brand/37.jpeg');
INSERT INTO `flipkartdb`.`Brand` (`brand`, `subcategory_id`, `brand_img`) VALUES ('Oppo', 13, 'images/brand/38.jpeg');
INSERT INTO `flipkartdb`.`Brand` (`brand`, `subcategory_id`, `brand_img`) VALUES ('Apple', 13, 'images/brand/39.jpeg');
INSERT INTO `flipkartdb`.`Brand` (`brand`, `subcategory_id`, `brand_img`) VALUES ('Dell', 14, 'images/brand/40.jpeg');
INSERT INTO `flipkartdb`.`Brand` (`brand`, `subcategory_id`, `brand_img`) VALUES ('Lenovo', 14, 'images/brand/41.jpeg');
INSERT INTO `flipkartdb`.`Brand` (`brand`, `subcategory_id`, `brand_img`) VALUES ('HP', 14, 'images/brand/42.jpeg');
INSERT INTO `flipkartdb`.`Brand` (`brand`, `subcategory_id`, `brand_img`) VALUES ('LG', 15, 'images/brand/43.jpeg');
INSERT INTO `flipkartdb`.`Brand` (`brand`, `subcategory_id`, `brand_img`) VALUES ('Sony', 15, 'images/brand/44.jpeg');
INSERT INTO `flipkartdb`.`Brand` (`brand`, `subcategory_id`, `brand_img`) VALUES ('Panasonic', 15, 'images/brand/45.jpeg');

COMMIT;


-- -----------------------------------------------------
-- Data for table `flipkartdb`.`Item`
-- -----------------------------------------------------
START TRANSACTION;
USE `flipkartdb`;
INSERT INTO `flipkartdb`.`Item` (`item_id`, `id`, `name`, `subcategory_id`, `quantity`, `price`, `brand`, `description`, `attribute1`, `manufacture_date`, `color`, `discount`, `seller_id`, `status`) VALUES (1, 'KC01', 'Skinny Men Jeans', 1, 12, 1200, 'Wrangler', 'Free size', NULL, '2019-02-11', 'Blue', 12, 1, 'EXISTS');
INSERT INTO `flipkartdb`.`Item` (`item_id`, `id`, `name`, `subcategory_id`, `quantity`, `price`, `brand`, `description`, `attribute1`, `manufacture_date`, `color`, `discount`, `seller_id`, `status`) VALUES (2, 'KC02', 'Stripes Shirt', 1, 13, 1000, 'Arrow', 'Formal Shirt', NULL, '2018-07-12', 'Black', 9, 1, 'EXISTS');
INSERT INTO `flipkartdb`.`Item` (`item_id`, `id`, `name`, `subcategory_id`, `quantity`, `price`, `brand`, `description`, `attribute1`, `manufacture_date`, `color`, `discount`, `seller_id`, `status`) VALUES (3, 'KC03', 'Summer T Shirt', 1, 10, 3000, 'Reebok', 'Exclusive Summer Special Shirt', NULL, '2018-09-12', 'Pink', 13, 1, 'EXISTS');
INSERT INTO `flipkartdb`.`Item` (`item_id`, `id`, `name`, `subcategory_id`, `quantity`, `price`, `brand`, `description`, `attribute1`, `manufacture_date`, `color`, `discount`, `seller_id`, `status`) VALUES (4, 'KC04', 'Solid Men Polo Neck', 1, 9, 800, 'Reebok', 'Has Polo Neck', NULL, '2018-07-11', 'Green', 24, 1, 'EXISTS');
INSERT INTO `flipkartdb`.`Item` (`item_id`, `id`, `name`, `subcategory_id`, `quantity`, `price`, `brand`, `description`, `attribute1`, `manufacture_date`, `color`, `discount`, `seller_id`, `status`) VALUES (5, 'KC05', 'Track Pant', 1, 14, 900, 'Wrangler', 'Free size', NULL, '2018-07-09', 'Yellow', 13, 1, 'EXISTS');
INSERT INTO `flipkartdb`.`Item` (`item_id`, `id`, `name`, `subcategory_id`, `quantity`, `price`, `brand`, `description`, `attribute1`, `manufacture_date`, `color`, `discount`, `seller_id`, `status`) VALUES (6, 'M06', 'Checkered Shirt', 1, 18, 1900, 'Arrow', 'Fit men solid checked shirt', NULL, '2018-07-07', 'Green', 12, 2, 'EXISTS');
INSERT INTO `flipkartdb`.`Item` (`item_id`, `id`, `name`, `subcategory_id`, `quantity`, `price`, `brand`, `description`, `attribute1`, `manufacture_date`, `color`, `discount`, `seller_id`, `status`) VALUES (7, 'MC07', 'Flying Machine T Shirt', 1, 12, 2000, 'Arrow', 'Plain Shirt', NULL, '2018-06-19', 'Pink', 29, 2, 'EXISTS');
INSERT INTO `flipkartdb`.`Item` (`item_id`, `id`, `name`, `subcategory_id`, `quantity`, `price`, `brand`, `description`, `attribute1`, `manufacture_date`, `color`, `discount`, `seller_id`, `status`) VALUES (8, 'MC08', 'Slim Jeans', 1, 13, 5000, 'Wrangler', 'Slim and fit', NULL, '2018-07-10', 'Black', 12, 2, 'EXISTS');
INSERT INTO `flipkartdb`.`Item` (`item_id`, `id`, `name`, `subcategory_id`, `quantity`, `price`, `brand`, `description`, `attribute1`, `manufacture_date`, `color`, `discount`, `seller_id`, `status`) VALUES (9, 'MC09', 'Flexy Jeans', 1, 12, 400, 'Reebok', 'Flexible and Free size', NULL, '2018-07-09', 'Black', 9, 2, 'EXISTS');
INSERT INTO `flipkartdb`.`Item` (`item_id`, `id`, `name`, `subcategory_id`, `quantity`, `price`, `brand`, `description`, `attribute1`, `manufacture_date`, `color`, `discount`, `seller_id`, `status`) VALUES (10, 'MC10', 'Sweater', 1, 10, 5000, 'Reebok', 'Woolen Clothing', NULL, '2018-07-10', 'Pink', 10, 2, 'EXISTS');
INSERT INTO `flipkartdb`.`Item` (`item_id`, `id`, `name`, `subcategory_id`, `quantity`, `price`, `brand`, `description`, `attribute1`, `manufacture_date`, `color`, `discount`, `seller_id`, `status`) VALUES (11, 'KC011', 'Perfect Walking Shoes', 2, 23, 2300, 'Adidas', 'All sizes available', NULL, '2018-06-09', 'Gray', 11, 1, 'EXISTS');
INSERT INTO `flipkartdb`.`Item` (`item_id`, `id`, `name`, `subcategory_id`, `quantity`, `price`, `brand`, `description`, `attribute1`, `manufacture_date`, `color`, `discount`, `seller_id`, `status`) VALUES (12, 'KC012', 'Running Shoes', 2, 34, 4500, 'Sparks', 'Used for fast running', NULL, '2018-07-10', 'Green', 12, 1, 'EXISTS');
INSERT INTO `flipkartdb`.`Item` (`item_id`, `id`, `name`, `subcategory_id`, `quantity`, `price`, `brand`, `description`, `attribute1`, `manufacture_date`, `color`, `discount`, `seller_id`, `status`) VALUES (13, 'MC001', 'Casual Shoes', 2, 12, 5600, 'Puma', 'Party wear', NULL, '2018-07-09', 'Black', 10, 2, 'EXISTS');
INSERT INTO `flipkartdb`.`Item` (`item_id`, `id`, `name`, `subcategory_id`, `quantity`, `price`, `brand`, `description`, `attribute1`, `manufacture_date`, `color`, `discount`, `seller_id`, `status`) VALUES (14, 'MC011', 'Titan Watch', 3, 10, 8900, 'Titan', 'Diamond Available inside', NULL, '2018-07-10', 'Gold', 13, 2, 'EXISTS');
INSERT INTO `flipkartdb`.`Item` (`item_id`, `id`, `name`, `subcategory_id`, `quantity`, `price`, `brand`, `description`, `attribute1`, `manufacture_date`, `color`, `discount`, `seller_id`, `status`) VALUES (15, 'MC0122', 'Casio Cheap Watch', 3, 12, 670, 'Casio', 'No diamond available', NULL, '2018-07-14', 'Silver', 4, 2, 'EXISTS');
INSERT INTO `flipkartdb`.`Item` (`item_id`, `id`, `name`, `subcategory_id`, `quantity`, `price`, `brand`, `description`, `attribute1`, `manufacture_date`, `color`, `discount`, `seller_id`, `status`) VALUES (16, 'KC110', 'Fastrack Band Watch', 3, 13, 1900, 'Fastrack', 'Super quality band ', NULL, '2018-07-26', 'Red', 3, 1, 'EXISTS');
INSERT INTO `flipkartdb`.`Item` (`item_id`, `id`, `name`, `subcategory_id`, `quantity`, `price`, `brand`, `description`, `attribute1`, `manufacture_date`, `color`, `discount`, `seller_id`, `status`) VALUES (17, 'KC290', 'Biba Straight Kurti', 4, 3, 2300, 'Biba', 'Cotton party wear ', NULL, '2018-07-13', 'Brown', 5, 1, 'EXISTS');
INSERT INTO `flipkartdb`.`Item` (`item_id`, `id`, `name`, `subcategory_id`, `quantity`, `price`, `brand`, `description`, `attribute1`, `manufacture_date`, `color`, `discount`, `seller_id`, `status`) VALUES (18, 'KC291', 'Biba Leggings', 4, 4, 450, 'Biba', 'Free size', NULL, '2018-07-01', 'Green', 12, 1, 'EXISTS');
INSERT INTO `flipkartdb`.`Item` (`item_id`, `id`, `name`, `subcategory_id`, `quantity`, `price`, `brand`, `description`, `attribute1`, `manufacture_date`, `color`, `discount`, `seller_id`, `status`) VALUES (19, 'KC292', 'Skirt', 4, 16, 790, 'W', 'Free size', NULL, '2018-07-19', 'White', 13, 1, 'EXISTS');
INSERT INTO `flipkartdb`.`Item` (`item_id`, `id`, `name`, `subcategory_id`, `quantity`, `price`, `brand`, `description`, `attribute1`, `manufacture_date`, `color`, `discount`, `seller_id`, `status`) VALUES (20, 'KC293', 'Palazzo', 4, 13, 760, 'Aureila', 'Free size', NULL, '2018-07-18', 'Yellow', 12, 1, 'EXISTS');
INSERT INTO `flipkartdb`.`Item` (`item_id`, `id`, `name`, `subcategory_id`, `quantity`, `price`, `brand`, `description`, `attribute1`, `manufacture_date`, `color`, `discount`, `seller_id`, `status`) VALUES (21, 'KC294', 'Anarkali full length', 4, 14, 895, 'Biba', 'Full length', NULL, '2018-09-11', 'Black', 13, 1, 'EXISTS');
INSERT INTO `flipkartdb`.`Item` (`item_id`, `id`, `name`, `subcategory_id`, `quantity`, `price`, `brand`, `description`, `attribute1`, `manufacture_date`, `color`, `discount`, `seller_id`, `status`) VALUES (22, 'MC80', 'Anarkali Short', 4, 12, 978, 'W', 'Knee Length', NULL, '2018-09-29', 'Red', 34, 2, 'EXISTS');
INSERT INTO `flipkartdb`.`Item` (`item_id`, `id`, `name`, `subcategory_id`, `quantity`, `price`, `brand`, `description`, `attribute1`, `manufacture_date`, `color`, `discount`, `seller_id`, `status`) VALUES (23, 'MC802', 'Anarkali Short Length', 4, 12, 357, 'Aureila', 'Knee Length', NULL, '2018-09-29', 'Black', 34, 2, 'EXISTS');
INSERT INTO `flipkartdb`.`Item` (`item_id`, `id`, `name`, `subcategory_id`, `quantity`, `price`, `brand`, `description`, `attribute1`, `manufacture_date`, `color`, `discount`, `seller_id`, `status`) VALUES (24, 'MC801', 'Anarkali Short', 4, 12, 567, 'Biba', 'Knee Length', NULL, '2018-09-29', 'Red', 34, 2, 'EXISTS');
INSERT INTO `flipkartdb`.`Item` (`item_id`, `id`, `name`, `subcategory_id`, `quantity`, `price`, `brand`, `description`, `attribute1`, `manufacture_date`, `color`, `discount`, `seller_id`, `status`) VALUES (25, 'MC803', 'Long Skirt', 4, 12, 897, 'Aureila', 'Below Knee', NULL, '2018-09-27', 'Black', 34, 2, 'EXISTS');
INSERT INTO `flipkartdb`.`Item` (`item_id`, `id`, `name`, `subcategory_id`, `quantity`, `price`, `brand`, `description`, `attribute1`, `manufacture_date`, `color`, `discount`, `seller_id`, `status`) VALUES (26, 'MC804', 'Short Skirt', 4, 12, 980, 'W', 'Above Knee Length', NULL, '2018-09-29', 'Red', 34, 2, 'EXISTS');
INSERT INTO `flipkartdb`.`Item` (`item_id`, `id`, `name`, `subcategory_id`, `quantity`, `price`, `brand`, `description`, `attribute1`, `manufacture_date`, `color`, `discount`, `seller_id`, `status`) VALUES (27, 'KC390', 'High Heels', 5, 13, 1800, 'Catwalk', 'Strong heels', NULL, '2018-12-12', 'Brown', 12, 1, 'EXISTS');
INSERT INTO `flipkartdb`.`Item` (`item_id`, `id`, `name`, `subcategory_id`, `quantity`, `price`, `brand`, `description`, `attribute1`, `manufacture_date`, `color`, `discount`, `seller_id`, `status`) VALUES (28, 'KC391', 'Washroom Slippers', 5, 14, 299, 'Flipside', 'Non slippery', NULL, '2019-01-12', 'Yellow', 13, 1, 'EXISTS');
INSERT INTO `flipkartdb`.`Item` (`item_id`, `id`, `name`, `subcategory_id`, `quantity`, `price`, `brand`, `description`, `attribute1`, `manufacture_date`, `color`, `discount`, `seller_id`, `status`) VALUES (29, 'KC392', 'Flats', 5, 13, 1200, 'Catwalk', 'Flat chappals', NULL, '2018-12-12', 'White', 12, 1, 'EXISTS');
INSERT INTO `flipkartdb`.`Item` (`item_id`, `id`, `name`, `subcategory_id`, `quantity`, `price`, `brand`, `description`, `attribute1`, `manufacture_date`, `color`, `discount`, `seller_id`, `status`) VALUES (30, 'KC393', 'Wedges', 5, 14, 789, 'Catwalk', 'Awesome Chappals', NULL, '2019-01-12', 'Brown', 13, 1, 'EXISTS');
INSERT INTO `flipkartdb`.`Item` (`item_id`, `id`, `name`, `subcategory_id`, `quantity`, `price`, `brand`, `description`, `attribute1`, `manufacture_date`, `color`, `discount`, `seller_id`, `status`) VALUES (31, 'KC394', 'Running shoes', 5, 14, 4509, 'Skechers', 'Used for running', NULL, '2019-01-12', 'Gray', 13, 1, 'EXISTS');
INSERT INTO `flipkartdb`.`Item` (`item_id`, `id`, `name`, `subcategory_id`, `quantity`, `price`, `brand`, `description`, `attribute1`, `manufacture_date`, `color`, `discount`, `seller_id`, `status`) VALUES (32, 'MC390', 'Ballenos', 5, 10, 1200, 'Catwalk', 'Awesome product', NULL, '2018-12-18', 'Black', 12, 2, 'EXISTS');
INSERT INTO `flipkartdb`.`Item` (`item_id`, `id`, `name`, `subcategory_id`, `quantity`, `price`, `brand`, `description`, `attribute1`, `manufacture_date`, `color`, `discount`, `seller_id`, `status`) VALUES (33, 'MC391', 'Slippers', 5, 3, 299, 'Flipside', 'Non slippery', NULL, '2019-01-12', 'Yellow', 13, 2, 'EXISTS');
INSERT INTO `flipkartdb`.`Item` (`item_id`, `id`, `name`, `subcategory_id`, `quantity`, `price`, `brand`, `description`, `attribute1`, `manufacture_date`, `color`, `discount`, `seller_id`, `status`) VALUES (34, 'MC392', 'Fancy Flats', 5, 13, 1100, 'Catwalk', 'Flat chappals', NULL, '2018-12-12', 'Brown', 12, 2, 'EXISTS');
INSERT INTO `flipkartdb`.`Item` (`item_id`, `id`, `name`, `subcategory_id`, `quantity`, `price`, `brand`, `description`, `attribute1`, `manufacture_date`, `color`, `discount`, `seller_id`, `status`) VALUES (35, 'MC393', 'Fancy Wedges', 5, 14, 999, 'Catwalk', 'Awesome Chappals', NULL, '2019-01-12', 'Brown', 13, 2, 'EXISTS');
INSERT INTO `flipkartdb`.`Item` (`item_id`, `id`, `name`, `subcategory_id`, `quantity`, `price`, `brand`, `description`, `attribute1`, `manufacture_date`, `color`, `discount`, `seller_id`, `status`) VALUES (36, 'MC394', 'Walking shoes', 5, 14, 5590, 'Skechers', 'Used for running', NULL, '2019-01-12', 'Gray', 13, 2, 'EXISTS');
INSERT INTO `flipkartdb`.`Item` (`item_id`, `id`, `name`, `subcategory_id`, `quantity`, `price`, `brand`, `description`, `attribute1`, `manufacture_date`, `color`, `discount`, `seller_id`, `status`) VALUES (37, 'MC492', 'Lakme Face Cream', 6, 13, 1100, 'Lakme', 'Fair and beautiful face', NULL, '2018-12-12', 'White', 12, 2, 'EXISTS');
INSERT INTO `flipkartdb`.`Item` (`item_id`, `id`, `name`, `subcategory_id`, `quantity`, `price`, `brand`, `description`, `attribute1`, `manufacture_date`, `color`, `discount`, `seller_id`, `status`) VALUES (38, 'MC456', 'Nivea Body Lotion', 6, 14, 230, 'Nivea', 'Tan removal', NULL, '2019-01-12', 'Blue', 12, 2, 'EXISTS');
INSERT INTO `flipkartdb`.`Item` (`item_id`, `id`, `name`, `subcategory_id`, `quantity`, `price`, `brand`, `description`, `attribute1`, `manufacture_date`, `color`, `discount`, `seller_id`, `status`) VALUES (39, 'KC670', 'Ponds Face cream', 6, 9, 550, 'Ponds', 'Fair face', NULL, '2019-01-12', 'Pink', 13, 1, 'EXISTS');
INSERT INTO `flipkartdb`.`Item` (`item_id`, `id`, `name`, `subcategory_id`, `quantity`, `price`, `brand`, `description`, `attribute1`, `manufacture_date`, `color`, `discount`, `seller_id`, `status`) VALUES (40, 'KC2901', 'Dinner set', 7, 3, 2300, 'Laopala', 'Awesome dinner set', NULL, '2018-07-13', 'White', 5, 1, 'EXISTS');
INSERT INTO `flipkartdb`.`Item` (`item_id`, `id`, `name`, `subcategory_id`, `quantity`, `price`, `brand`, `description`, `attribute1`, `manufacture_date`, `color`, `discount`, `seller_id`, `status`) VALUES (41, 'KC2911', '12 plate dinner set', 7, 4, 4500, 'Laopala', '12 different size available', NULL, '2018-07-01', 'Green', 12, 1, 'EXISTS');
INSERT INTO `flipkartdb`.`Item` (`item_id`, `id`, `name`, `subcategory_id`, `quantity`, `price`, `brand`, `description`, `attribute1`, `manufacture_date`, `color`, `discount`, `seller_id`, `status`) VALUES (42, 'MC2921', 'Induction stove', 7, 12, 3000, 'Haffle', 'Super induction coil', NULL, '2018-07-19', 'Black', 13, 1, 'EXISTS');
INSERT INTO `flipkartdb`.`Item` (`item_id`, `id`, `name`, `subcategory_id`, `quantity`, `price`, `brand`, `description`, `attribute1`, `manufacture_date`, `color`, `discount`, `seller_id`, `status`) VALUES (43, 'MC2931', 'Stove', 7, 13, 1760, 'Bajaj', 'Glass stove', NULL, '2018-07-18', 'Black', 12, 1, 'EXISTS');
INSERT INTO `flipkartdb`.`Item` (`item_id`, `id`, `name`, `subcategory_id`, `quantity`, `price`, `brand`, `description`, `attribute1`, `manufacture_date`, `color`, `discount`, `seller_id`, `status`) VALUES (44, 'KC2941', 'Toaster', 7, 14, 2300, 'Bajaj', '4 breads at a time', NULL, '2018-09-11', 'Gray', 13, 1, 'EXISTS');
INSERT INTO `flipkartdb`.`Item` (`item_id`, `id`, `name`, `subcategory_id`, `quantity`, `price`, `brand`, `description`, `attribute1`, `manufacture_date`, `color`, `discount`, `seller_id`, `status`) VALUES (45, 'MC8011', '12 step Ladder', 9, 12, 3400, 'Bathla', '12 steps', NULL, '2018-09-29', 'Gray', 34, 2, 'EXISTS');
INSERT INTO `flipkartdb`.`Item` (`item_id`, `id`, `name`, `subcategory_id`, `quantity`, `price`, `brand`, `description`, `attribute1`, `manufacture_date`, `color`, `discount`, `seller_id`, `status`) VALUES (46, 'MC8022', '24 Hour Clock', 8, 12, 357, 'Bosch', 'Wall clock or table clock', NULL, '2018-09-29', 'Brown', 34, 2, 'EXISTS');
INSERT INTO `flipkartdb`.`Item` (`item_id`, `id`, `name`, `subcategory_id`, `quantity`, `price`, `brand`, `description`, `attribute1`, `manufacture_date`, `color`, `discount`, `seller_id`, `status`) VALUES (47, 'MC8901', 'Alarm Clock', 8, 12, 567, 'Bosch', 'Great sound ', NULL, '2018-09-29', 'Red', 34, 2, 'EXISTS');
INSERT INTO `flipkartdb`.`Item` (`item_id`, `id`, `name`, `subcategory_id`, `quantity`, `price`, `brand`, `description`, `attribute1`, `manufacture_date`, `color`, `discount`, `seller_id`, `status`) VALUES (48, 'MC8031', 'PVC Wallpaper', 8, 12, 897, 'Sathrangi', 'Nice wallpaper', NULL, '2018-09-27', 'Black', 34, 2, 'EXISTS');
INSERT INTO `flipkartdb`.`Item` (`item_id`, `id`, `name`, `subcategory_id`, `quantity`, `price`, `brand`, `description`, `attribute1`, `manufacture_date`, `color`, `discount`, `seller_id`, `status`) VALUES (49, 'MC8041', '10 step ladder', 9, 12, 2400, 'Bathla', '10 steps', NULL, '2018-09-29', 'Gray', 34, 2, 'EXISTS');
INSERT INTO `flipkartdb`.`Item` (`item_id`, `id`, `name`, `subcategory_id`, `quantity`, `price`, `brand`, `description`, `attribute1`, `manufacture_date`, `color`, `discount`, `seller_id`, `status`) VALUES (50, 'KC8031', 'Screw Driver', 9, 12, 897, 'Bosch', 'Nice quality steel', NULL, '2018-09-27', 'Green', 34, 1, 'EXISTS');
INSERT INTO `flipkartdb`.`Item` (`item_id`, `id`, `name`, `subcategory_id`, `quantity`, `price`, `brand`, `description`, `attribute1`, `manufacture_date`, `color`, `discount`, `seller_id`, `status`) VALUES (51, 'KC765', 'Notebooks ', 10, 4, 200, 'Classmate', 'Set of 4', NULL, '2019-04-11', 'White', 12, 1, 'EXISTS');
INSERT INTO `flipkartdb`.`Item` (`item_id`, `id`, `name`, `subcategory_id`, `quantity`, `price`, `brand`, `description`, `attribute1`, `manufacture_date`, `color`, `discount`, `seller_id`, `status`) VALUES (52, 'KC766', 'Dictionary', 10, 4, 400, 'Oxford', 'English Dictionary', NULL, '2019-04-11', 'Blue', 9, 1, 'EXISTS');
INSERT INTO `flipkartdb`.`Item` (`item_id`, `id`, `name`, `subcategory_id`, `quantity`, `price`, `brand`, `description`, `attribute1`, `manufacture_date`, `color`, `discount`, `seller_id`, `status`) VALUES (53, 'KC767', 'Ruled Notebook', 10, 5, 100, 'Lepakshi', 'Set of 2', NULL, '2019-04-11', 'White', 10, 1, 'EXISTS');
INSERT INTO `flipkartdb`.`Item` (`item_id`, `id`, `name`, `subcategory_id`, `quantity`, `price`, `brand`, `description`, `attribute1`, `manufacture_date`, `color`, `discount`, `seller_id`, `status`) VALUES (54, 'MC765', 'Diary', 10, 4, 200, 'Lepakshi', '300 pages', NULL, '2019-04-11', 'Gray', 12, 2, 'EXISTS');
INSERT INTO `flipkartdb`.`Item` (`item_id`, `id`, `name`, `subcategory_id`, `quantity`, `price`, `brand`, `description`, `attribute1`, `manufacture_date`, `color`, `discount`, `seller_id`, `status`) VALUES (55, 'MC766', 'Design Patterns', 10, 4, 400, 'Oxford', 'Nice summary of all patterns', NULL, '2019-04-11', 'Green', 9, 2, 'EXISTS');
INSERT INTO `flipkartdb`.`Item` (`item_id`, `id`, `name`, `subcategory_id`, `quantity`, `price`, `brand`, `description`, `attribute1`, `manufacture_date`, `color`, `discount`, `seller_id`, `status`) VALUES (56, 'MC767', 'Check-Ruled Notebook', 10, 5, 100, 'Lepakshi', 'Set of 2', NULL, '2019-04-11', 'White', 10, 2, 'EXISTS');
INSERT INTO `flipkartdb`.`Item` (`item_id`, `id`, `name`, `subcategory_id`, `quantity`, `price`, `brand`, `description`, `attribute1`, `manufacture_date`, `color`, `discount`, `seller_id`, `status`) VALUES (57, 'KC7765', 'Blue ink pen', 11, 4, 20, 'Cello', 'Blue color', NULL, '2019-04-11', 'Blue', 2, 1, 'EXISTS');
INSERT INTO `flipkartdb`.`Item` (`item_id`, `id`, `name`, `subcategory_id`, `quantity`, `price`, `brand`, `description`, `attribute1`, `manufacture_date`, `color`, `discount`, `seller_id`, `status`) VALUES (58, 'KC7766', 'Black ink pen', 11, 4, 20, 'Cello', 'Black color', NULL, '2019-04-11', 'Black', 9, 1, 'EXISTS');
INSERT INTO `flipkartdb`.`Item` (`item_id`, `id`, `name`, `subcategory_id`, `quantity`, `price`, `brand`, `description`, `attribute1`, `manufacture_date`, `color`, `discount`, `seller_id`, `status`) VALUES (59, 'KC7767', 'Red ink pen', 11, 5, 20, 'Cello', 'Red color', NULL, '2019-04-11', 'Red', 3, 1, 'EXISTS');
INSERT INTO `flipkartdb`.`Item` (`item_id`, `id`, `name`, `subcategory_id`, `quantity`, `price`, `brand`, `description`, `attribute1`, `manufacture_date`, `color`, `discount`, `seller_id`, `status`) VALUES (60, 'MC7765', 'Blue Marker', 11, 4, 50, 'Pilot', 'Blue color', NULL, '2019-04-11', 'Blue', 2, 2, 'EXISTS');
INSERT INTO `flipkartdb`.`Item` (`item_id`, `id`, `name`, `subcategory_id`, `quantity`, `price`, `brand`, `description`, `attribute1`, `manufacture_date`, `color`, `discount`, `seller_id`, `status`) VALUES (61, 'MC7766', 'Fountain pen', 11, 4, 200, 'Park Avenue', 'Fancy pen', NULL, '2019-04-11', 'Gray', 9, 2, 'EXISTS');
INSERT INTO `flipkartdb`.`Item` (`item_id`, `id`, `name`, `subcategory_id`, `quantity`, `price`, `brand`, `description`, `attribute1`, `manufacture_date`, `color`, `discount`, `seller_id`, `status`) VALUES (62, 'MC7767', 'Black Marker', 11, 5, 40, 'Pilot', 'Black color', NULL, '2019-04-11', 'Black', 4, 2, 'EXISTS');
INSERT INTO `flipkartdb`.`Item` (`item_id`, `id`, `name`, `subcategory_id`, `quantity`, `price`, `brand`, `description`, `attribute1`, `manufacture_date`, `color`, `discount`, `seller_id`, `status`) VALUES (63, 'KC8865', 'Invisible Tape', 12, 4, 20, 'Cello', 'Transparent', NULL, '2019-04-11', 'White', 2, 1, 'EXISTS');
INSERT INTO `flipkartdb`.`Item` (`item_id`, `id`, `name`, `subcategory_id`, `quantity`, `price`, `brand`, `description`, `attribute1`, `manufacture_date`, `color`, `discount`, `seller_id`, `status`) VALUES (64, 'KC8866', 'Pen stand', 12, 4, 200, 'Chumbak', 'Fancy pen stand', NULL, '2019-04-11', 'Black', 9, 1, 'EXISTS');
INSERT INTO `flipkartdb`.`Item` (`item_id`, `id`, `name`, `subcategory_id`, `quantity`, `price`, `brand`, `description`, `attribute1`, `manufacture_date`, `color`, `discount`, `seller_id`, `status`) VALUES (65, 'MC8867', 'Sticky notes', 12, 5, 90, 'Apex', '200 notes', NULL, '2019-04-11', 'Yellow', 3, 2, 'EXISTS');
INSERT INTO `flipkartdb`.`Item` (`item_id`, `id`, `name`, `subcategory_id`, `quantity`, `price`, `brand`, `description`, `attribute1`, `manufacture_date`, `color`, `discount`, `seller_id`, `status`) VALUES (66, 'MC8965', 'Paper clips', 12, 4, 50, 'Cello', '20 clips', NULL, '2019-04-11', 'Black', 2, 2, 'EXISTS');
INSERT INTO `flipkartdb`.`Item` (`item_id`, `id`, `name`, `subcategory_id`, `quantity`, `price`, `brand`, `description`, `attribute1`, `manufacture_date`, `color`, `discount`, `seller_id`, `status`) VALUES (67, 'K0001', 'Samsung A100', 13, 2, 12000, 'Samsung', 'Notch available', NULL, '2019-02-01', 'Gray', 12, 1, 'EXISTS');
INSERT INTO `flipkartdb`.`Item` (`item_id`, `id`, `name`, `subcategory_id`, `quantity`, `price`, `brand`, `description`, `attribute1`, `manufacture_date`, `color`, `discount`, `seller_id`, `status`) VALUES (68, 'M0001', 'Iphone XS', 13, 3, 190909, 'Apple', 'Back Cover in the box', NULL, '2019-02-01', 'Black', 9, 2, 'EXISTS');
INSERT INTO `flipkartdb`.`Item` (`item_id`, `id`, `name`, `subcategory_id`, `quantity`, `price`, `brand`, `description`, `attribute1`, `manufacture_date`, `color`, `discount`, `seller_id`, `status`) VALUES (69, 'M0002', 'Samsung B100', 13, 10, 10000, 'Samsung', 'Without Notch available', NULL, '2019-02-01', 'Blue', 10, 2, 'EXISTS');
INSERT INTO `flipkartdb`.`Item` (`item_id`, `id`, `name`, `subcategory_id`, `quantity`, `price`, `brand`, `description`, `attribute1`, `manufacture_date`, `color`, `discount`, `seller_id`, `status`) VALUES (70, 'K0002', 'Oppo A11', 13, 2, 14000, 'Oppo', 'Sliding Camera', NULL, '2019-02-01', 'Red', 12, 1, 'EXISTS');
INSERT INTO `flipkartdb`.`Item` (`item_id`, `id`, `name`, `subcategory_id`, `quantity`, `price`, `brand`, `description`, `attribute1`, `manufacture_date`, `color`, `discount`, `seller_id`, `status`) VALUES (71, 'K00011', 'Lenovo Thinkpad', 14, 2, 26000, 'Lenovo', '15-inch laptop', NULL, '2019-02-01', 'Gray', 12, 1, 'EXISTS');
INSERT INTO `flipkartdb`.`Item` (`item_id`, `id`, `name`, `subcategory_id`, `quantity`, `price`, `brand`, `description`, `attribute1`, `manufacture_date`, `color`, `discount`, `seller_id`, `status`) VALUES (72, 'M00011', 'Dell Hersheys', 14, 3, 190909, 'Dell', 'Super fast laptop', NULL, '2019-02-01', 'Black', 9, 2, 'EXISTS');
INSERT INTO `flipkartdb`.`Item` (`item_id`, `id`, `name`, `subcategory_id`, `quantity`, `price`, `brand`, `description`, `attribute1`, `manufacture_date`, `color`, `discount`, `seller_id`, `status`) VALUES (73, 'M00021', 'HP notebook', 14, 10, 23000, 'HP', 'Touch screen', NULL, '2019-02-01', 'Red', 10, 2, 'EXISTS');
INSERT INTO `flipkartdb`.`Item` (`item_id`, `id`, `name`, `subcategory_id`, `quantity`, `price`, `brand`, `description`, `attribute1`, `manufacture_date`, `color`, `discount`, `seller_id`, `status`) VALUES (74, 'K00021', 'Lenovo Ideapad', 14, 2, 56000, 'Lenovo', 'HD Camera available', NULL, '2019-02-01', 'Black', 12, 1, 'EXISTS');
INSERT INTO `flipkartdb`.`Item` (`item_id`, `id`, `name`, `subcategory_id`, `quantity`, `price`, `brand`, `description`, `attribute1`, `manufacture_date`, `color`, `discount`, `seller_id`, `status`) VALUES (75, 'K00012', 'LG LED TV', 15, 2, 56000, 'LG', 'Internet connection can be done', NULL, '2019-02-01', 'Black', 12, 1, 'EXISTS');
INSERT INTO `flipkartdb`.`Item` (`item_id`, `id`, `name`, `subcategory_id`, `quantity`, `price`, `brand`, `description`, `attribute1`, `manufacture_date`, `color`, `discount`, `seller_id`, `status`) VALUES (76, 'M00012', 'Sony Bravia', 15, 3, 190909, 'Sony', 'Free Amazon fire stick', NULL, '2019-02-01', 'Black', 9, 2, 'EXISTS');
INSERT INTO `flipkartdb`.`Item` (`item_id`, `id`, `name`, `subcategory_id`, `quantity`, `price`, `brand`, `description`, `attribute1`, `manufacture_date`, `color`, `discount`, `seller_id`, `status`) VALUES (77, 'M00022', 'Panasonic Smart TV', 15, 10, 100009, 'Panasonic', 'LED screen', NULL, '2019-02-01', 'Gray', 10, 2, 'EXISTS');
INSERT INTO `flipkartdb`.`Item` (`item_id`, `id`, `name`, `subcategory_id`, `quantity`, `price`, `brand`, `description`, `attribute1`, `manufacture_date`, `color`, `discount`, `seller_id`, `status`) VALUES (78, 'K00022', 'Sony U TV', 15, 2, 190000, 'Sony', 'Web Cam Available', NULL, '2019-02-01', 'Gray', 12, 1, 'EXISTS');

COMMIT;


-- -----------------------------------------------------
-- Data for table `flipkartdb`.`ItemImages`
-- -----------------------------------------------------
START TRANSACTION;
USE `flipkartdb`;
INSERT INTO `flipkartdb`.`ItemImages` (`id`, `item_id`, `image_location`) VALUES (1, 1, 'images/catalog/1/0.jpeg');
INSERT INTO `flipkartdb`.`ItemImages` (`id`, `item_id`, `image_location`) VALUES (2, 2, 'images/catalog/2/0.jpeg');
INSERT INTO `flipkartdb`.`ItemImages` (`id`, `item_id`, `image_location`) VALUES (3, 3, 'images/catalog/3/0.jpeg');
INSERT INTO `flipkartdb`.`ItemImages` (`id`, `item_id`, `image_location`) VALUES (4, 4, 'images/catalog/4/0.jpeg');
INSERT INTO `flipkartdb`.`ItemImages` (`id`, `item_id`, `image_location`) VALUES (5, 5, 'images/catalog/5/0.jpeg');
INSERT INTO `flipkartdb`.`ItemImages` (`id`, `item_id`, `image_location`) VALUES (6, 6, 'images/catalog/6/0.jpeg');
INSERT INTO `flipkartdb`.`ItemImages` (`id`, `item_id`, `image_location`) VALUES (7, 7, 'images/catalog/7/0.jpeg');
INSERT INTO `flipkartdb`.`ItemImages` (`id`, `item_id`, `image_location`) VALUES (8, 8, 'images/catalog/8/0.jpeg');
INSERT INTO `flipkartdb`.`ItemImages` (`id`, `item_id`, `image_location`) VALUES (9, 9, 'images/catalog/9/0.jpeg');
INSERT INTO `flipkartdb`.`ItemImages` (`id`, `item_id`, `image_location`) VALUES (10, 10, 'images/catalog/10/0.jpeg');
INSERT INTO `flipkartdb`.`ItemImages` (`id`, `item_id`, `image_location`) VALUES (11, 11, 'images/catalog/11/0.jpeg');
INSERT INTO `flipkartdb`.`ItemImages` (`id`, `item_id`, `image_location`) VALUES (12, 12, 'images/catalog/12/0.jpeg');
INSERT INTO `flipkartdb`.`ItemImages` (`id`, `item_id`, `image_location`) VALUES (13, 13, 'images/catalog/13/0.jpeg');
INSERT INTO `flipkartdb`.`ItemImages` (`id`, `item_id`, `image_location`) VALUES (14, 14, 'images/catalog/14/0.jpeg');
INSERT INTO `flipkartdb`.`ItemImages` (`id`, `item_id`, `image_location`) VALUES (15, 15, 'images/catalog/15/0.jpeg');
INSERT INTO `flipkartdb`.`ItemImages` (`id`, `item_id`, `image_location`) VALUES (16, 16, 'images/catalog/16/0.jpeg');
INSERT INTO `flipkartdb`.`ItemImages` (`id`, `item_id`, `image_location`) VALUES (17, 17, 'images/catalog/17/0.jpeg');
INSERT INTO `flipkartdb`.`ItemImages` (`id`, `item_id`, `image_location`) VALUES (18, 18, 'images/catalog/18/0.jpeg');
INSERT INTO `flipkartdb`.`ItemImages` (`id`, `item_id`, `image_location`) VALUES (19, 19, 'images/catalog/19/0.jpeg');
INSERT INTO `flipkartdb`.`ItemImages` (`id`, `item_id`, `image_location`) VALUES (20, 20, 'images/catalog/20/0.jpeg');
INSERT INTO `flipkartdb`.`ItemImages` (`id`, `item_id`, `image_location`) VALUES (21, 21, 'images/catalog/21/0.jpeg');
INSERT INTO `flipkartdb`.`ItemImages` (`id`, `item_id`, `image_location`) VALUES (22, 22, 'images/catalog/22/0.jpeg');
INSERT INTO `flipkartdb`.`ItemImages` (`id`, `item_id`, `image_location`) VALUES (23, 23, 'images/catalog/23/0.jpeg');
INSERT INTO `flipkartdb`.`ItemImages` (`id`, `item_id`, `image_location`) VALUES (24, 24, 'images/catalog/24/0.jpeg');
INSERT INTO `flipkartdb`.`ItemImages` (`id`, `item_id`, `image_location`) VALUES (25, 25, 'images/catalog/25/0.jpeg');
INSERT INTO `flipkartdb`.`ItemImages` (`id`, `item_id`, `image_location`) VALUES (26, 26, 'images/catalog/26/0.jpeg');
INSERT INTO `flipkartdb`.`ItemImages` (`id`, `item_id`, `image_location`) VALUES (27, 27, 'images/catalog/27/0.jpeg');
INSERT INTO `flipkartdb`.`ItemImages` (`id`, `item_id`, `image_location`) VALUES (28, 28, 'images/catalog/28/0.jpeg');
INSERT INTO `flipkartdb`.`ItemImages` (`id`, `item_id`, `image_location`) VALUES (29, 29, 'images/catalog/29/0.jpeg');
INSERT INTO `flipkartdb`.`ItemImages` (`id`, `item_id`, `image_location`) VALUES (30, 30, 'images/catalog/30/0.jpeg');
INSERT INTO `flipkartdb`.`ItemImages` (`id`, `item_id`, `image_location`) VALUES (31, 31, 'images/catalog/31/0.jpeg');
INSERT INTO `flipkartdb`.`ItemImages` (`id`, `item_id`, `image_location`) VALUES (32, 32, 'images/catalog/32/0.jpeg');
INSERT INTO `flipkartdb`.`ItemImages` (`id`, `item_id`, `image_location`) VALUES (33, 33, 'images/catalog/33/0.jpeg');
INSERT INTO `flipkartdb`.`ItemImages` (`id`, `item_id`, `image_location`) VALUES (34, 34, 'images/catalog/34/0.jpeg');
INSERT INTO `flipkartdb`.`ItemImages` (`id`, `item_id`, `image_location`) VALUES (35, 35, 'images/catalog/35/0.jpeg');
INSERT INTO `flipkartdb`.`ItemImages` (`id`, `item_id`, `image_location`) VALUES (36, 36, 'images/catalog/36/0.jpeg');
INSERT INTO `flipkartdb`.`ItemImages` (`id`, `item_id`, `image_location`) VALUES (37, 37, 'images/catalog/37/0.jpeg');
INSERT INTO `flipkartdb`.`ItemImages` (`id`, `item_id`, `image_location`) VALUES (38, 38, 'images/catalog/38/0.jpeg');
INSERT INTO `flipkartdb`.`ItemImages` (`id`, `item_id`, `image_location`) VALUES (39, 39, 'images/catalog/39/0.jpeg');
INSERT INTO `flipkartdb`.`ItemImages` (`id`, `item_id`, `image_location`) VALUES (40, 40, 'images/catalog/40/0.jpeg');
INSERT INTO `flipkartdb`.`ItemImages` (`id`, `item_id`, `image_location`) VALUES (41, 41, 'images/catalog/41/0.jpeg');
INSERT INTO `flipkartdb`.`ItemImages` (`id`, `item_id`, `image_location`) VALUES (42, 42, 'images/catalog/42/0.jpeg');
INSERT INTO `flipkartdb`.`ItemImages` (`id`, `item_id`, `image_location`) VALUES (43, 43, 'images/catalog/43/0.jpeg');
INSERT INTO `flipkartdb`.`ItemImages` (`id`, `item_id`, `image_location`) VALUES (44, 44, 'images/catalog/44/0.jpeg');
INSERT INTO `flipkartdb`.`ItemImages` (`id`, `item_id`, `image_location`) VALUES (45, 45, 'images/catalog/45/0.jpeg');
INSERT INTO `flipkartdb`.`ItemImages` (`id`, `item_id`, `image_location`) VALUES (46, 46, 'images/catalog/46/0.jpeg');
INSERT INTO `flipkartdb`.`ItemImages` (`id`, `item_id`, `image_location`) VALUES (47, 47, 'images/catalog/47/0.jpeg');
INSERT INTO `flipkartdb`.`ItemImages` (`id`, `item_id`, `image_location`) VALUES (48, 48, 'images/catalog/48/0.jpeg');
INSERT INTO `flipkartdb`.`ItemImages` (`id`, `item_id`, `image_location`) VALUES (49, 49, 'images/catalog/49/0.jpeg');
INSERT INTO `flipkartdb`.`ItemImages` (`id`, `item_id`, `image_location`) VALUES (50, 50, 'images/catalog/50/0.jpeg');
INSERT INTO `flipkartdb`.`ItemImages` (`id`, `item_id`, `image_location`) VALUES (51, 51, 'images/catalog/51/0.jpeg');
INSERT INTO `flipkartdb`.`ItemImages` (`id`, `item_id`, `image_location`) VALUES (52, 52, 'images/catalog/52/0.jpeg');
INSERT INTO `flipkartdb`.`ItemImages` (`id`, `item_id`, `image_location`) VALUES (53, 53, 'images/catalog/53/0.jpeg');
INSERT INTO `flipkartdb`.`ItemImages` (`id`, `item_id`, `image_location`) VALUES (54, 54, 'images/catalog/54/0.jpeg');
INSERT INTO `flipkartdb`.`ItemImages` (`id`, `item_id`, `image_location`) VALUES (55, 55, 'images/catalog/55/0.jpeg');
INSERT INTO `flipkartdb`.`ItemImages` (`id`, `item_id`, `image_location`) VALUES (56, 56, 'images/catalog/56/0.jpeg');
INSERT INTO `flipkartdb`.`ItemImages` (`id`, `item_id`, `image_location`) VALUES (57, 57, 'images/catalog/57/0.jpeg');
INSERT INTO `flipkartdb`.`ItemImages` (`id`, `item_id`, `image_location`) VALUES (58, 58, 'images/catalog/58/0.jpeg');
INSERT INTO `flipkartdb`.`ItemImages` (`id`, `item_id`, `image_location`) VALUES (59, 59, 'images/catalog/59/0.jpeg');
INSERT INTO `flipkartdb`.`ItemImages` (`id`, `item_id`, `image_location`) VALUES (60, 60, 'images/catalog/60/0.jpeg');
INSERT INTO `flipkartdb`.`ItemImages` (`id`, `item_id`, `image_location`) VALUES (61, 61, 'images/catalog/61/0.jpeg');
INSERT INTO `flipkartdb`.`ItemImages` (`id`, `item_id`, `image_location`) VALUES (62, 62, 'images/catalog/62/0.jpeg');
INSERT INTO `flipkartdb`.`ItemImages` (`id`, `item_id`, `image_location`) VALUES (63, 63, 'images/catalog/63/0.jpeg');
INSERT INTO `flipkartdb`.`ItemImages` (`id`, `item_id`, `image_location`) VALUES (64, 64, 'images/catalog/64/0.jpeg');
INSERT INTO `flipkartdb`.`ItemImages` (`id`, `item_id`, `image_location`) VALUES (65, 65, 'images/catalog/65/0.jpeg');
INSERT INTO `flipkartdb`.`ItemImages` (`id`, `item_id`, `image_location`) VALUES (66, 66, 'images/catalog/66/0.jpeg');
INSERT INTO `flipkartdb`.`ItemImages` (`id`, `item_id`, `image_location`) VALUES (67, 67, 'images/catalog/67/0.jpeg');
INSERT INTO `flipkartdb`.`ItemImages` (`id`, `item_id`, `image_location`) VALUES (68, 68, 'images/catalog/68/0.jpeg');
INSERT INTO `flipkartdb`.`ItemImages` (`id`, `item_id`, `image_location`) VALUES (69, 69, 'images/catalog/69/0.jpeg');
INSERT INTO `flipkartdb`.`ItemImages` (`id`, `item_id`, `image_location`) VALUES (70, 70, 'images/catalog/70/0.jpeg');
INSERT INTO `flipkartdb`.`ItemImages` (`id`, `item_id`, `image_location`) VALUES (71, 71, 'images/catalog/71/0.jpeg');
INSERT INTO `flipkartdb`.`ItemImages` (`id`, `item_id`, `image_location`) VALUES (72, 72, 'images/catalog/72/0.jpeg');
INSERT INTO `flipkartdb`.`ItemImages` (`id`, `item_id`, `image_location`) VALUES (73, 73, 'images/catalog/73/0.jpeg');
INSERT INTO `flipkartdb`.`ItemImages` (`id`, `item_id`, `image_location`) VALUES (74, 74, 'images/catalog/74/0.jpeg');
INSERT INTO `flipkartdb`.`ItemImages` (`id`, `item_id`, `image_location`) VALUES (75, 75, 'images/catalog/75/0.jpeg');
INSERT INTO `flipkartdb`.`ItemImages` (`id`, `item_id`, `image_location`) VALUES (76, 76, 'images/catalog/76/0.jpeg');
INSERT INTO `flipkartdb`.`ItemImages` (`id`, `item_id`, `image_location`) VALUES (77, 77, 'images/catalog/77/0.jpeg');
INSERT INTO `flipkartdb`.`ItemImages` (`id`, `item_id`, `image_location`) VALUES (78, 78, 'images/catalog/78/0.jpeg');

COMMIT;


-- -----------------------------------------------------
-- Data for table `flipkartdb`.`ItemDetails`
-- -----------------------------------------------------
START TRANSACTION;
USE `flipkartdb`;
INSERT INTO `flipkartdb`.`ItemDetails` (`id`, `item_id`, `item_key`, `item_value`) VALUES (1, 1, 'Size', 'S');
INSERT INTO `flipkartdb`.`ItemDetails` (`id`, `item_id`, `item_key`, `item_value`) VALUES (2, 2, 'Size ', 'M');
INSERT INTO `flipkartdb`.`ItemDetails` (`id`, `item_id`, `item_key`, `item_value`) VALUES (3, 68, 'RAM', '8GB');
INSERT INTO `flipkartdb`.`ItemDetails` (`id`, `item_id`, `item_key`, `item_value`) VALUES (4, 67, 'Memory', '64GB');

COMMIT;


-- -----------------------------------------------------
-- Data for table `flipkartdb`.`BuyerAccount`
-- -----------------------------------------------------
START TRANSACTION;
USE `flipkartdb`;
INSERT INTO `flipkartdb`.`BuyerAccount` (`id`, `accountno`, `buyer_id`, `pin`, `balance`) VALUES (1, '123456789012', 1, '1234', 10000);
INSERT INTO `flipkartdb`.`BuyerAccount` (`id`, `accountno`, `buyer_id`, `pin`, `balance`) VALUES (2, '123456789013', 2, '1234', 10000);
INSERT INTO `flipkartdb`.`BuyerAccount` (`id`, `accountno`, `buyer_id`, `pin`, `balance`) VALUES (3, '123456789014', 3, '1234', 10000);
INSERT INTO `flipkartdb`.`BuyerAccount` (`id`, `accountno`, `buyer_id`, `pin`, `balance`) VALUES (4, '123456789015', 4, '1234', 10000);
INSERT INTO `flipkartdb`.`BuyerAccount` (`id`, `accountno`, `buyer_id`, `pin`, `balance`) VALUES (5, '123456789016', 5, '1234', 10000);
INSERT INTO `flipkartdb`.`BuyerAccount` (`id`, `accountno`, `buyer_id`, `pin`, `balance`) VALUES (6, '123456789017', 6, '1234', 10000);
INSERT INTO `flipkartdb`.`BuyerAccount` (`id`, `accountno`, `buyer_id`, `pin`, `balance`) VALUES (7, '123456789018', 7, '1234', 10000);
INSERT INTO `flipkartdb`.`BuyerAccount` (`id`, `accountno`, `buyer_id`, `pin`, `balance`) VALUES (8, '123456789019', 8, '1234', 10000);

COMMIT;


-- -----------------------------------------------------
-- Data for table `flipkartdb`.`SellerAccount`
-- -----------------------------------------------------
START TRANSACTION;
USE `flipkartdb`;
INSERT INTO `flipkartdb`.`SellerAccount` (`id`, `accountno`, `seller_id`, `pin`, `balance`) VALUES (1, '987678645121', 1, '1234', 1000);
INSERT INTO `flipkartdb`.`SellerAccount` (`id`, `accountno`, `seller_id`, `pin`, `balance`) VALUES (2, '987678645122', 2, '1234', 1000);

COMMIT;


-- -----------------------------------------------------
-- Data for table `flipkartdb`.`FlipkartAccount`
-- -----------------------------------------------------
START TRANSACTION;
USE `flipkartdb`;
INSERT INTO `flipkartdb`.`FlipkartAccount` (`accountno`, `balance`) VALUES ('334455667788', 1000);

COMMIT;


-- -----------------------------------------------------
-- Data for table `flipkartdb`.`FixedAttribute`
-- -----------------------------------------------------
START TRANSACTION;
USE `flipkartdb`;
INSERT INTO `flipkartdb`.`FixedAttribute` (`id`, `name`, `subcategory_id`, `value`) VALUES (1, 'Size', 4, 'S');
INSERT INTO `flipkartdb`.`FixedAttribute` (`id`, `name`, `subcategory_id`, `value`) VALUES (2, 'Size', 4, 'M');

COMMIT;


-- -----------------------------------------------------
-- Data for table `flipkartdb`.`Color`
-- -----------------------------------------------------
START TRANSACTION;
USE `flipkartdb`;
INSERT INTO `flipkartdb`.`Color` (`color_id`, `color`, `subcategory_id`) VALUES (DEFAULT, 'Blue', 1);
INSERT INTO `flipkartdb`.`Color` (`color_id`, `color`, `subcategory_id`) VALUES (DEFAULT, 'Black', 1);
INSERT INTO `flipkartdb`.`Color` (`color_id`, `color`, `subcategory_id`) VALUES (DEFAULT, 'Pink', 1);
INSERT INTO `flipkartdb`.`Color` (`color_id`, `color`, `subcategory_id`) VALUES (DEFAULT, 'Green', 1);
INSERT INTO `flipkartdb`.`Color` (`color_id`, `color`, `subcategory_id`) VALUES (DEFAULT, 'Yellow', 1);
INSERT INTO `flipkartdb`.`Color` (`color_id`, `color`, `subcategory_id`) VALUES (DEFAULT, 'Gray', 2);
INSERT INTO `flipkartdb`.`Color` (`color_id`, `color`, `subcategory_id`) VALUES (DEFAULT, 'Green', 2);
INSERT INTO `flipkartdb`.`Color` (`color_id`, `color`, `subcategory_id`) VALUES (DEFAULT, 'Black', 2);
INSERT INTO `flipkartdb`.`Color` (`color_id`, `color`, `subcategory_id`) VALUES (DEFAULT, 'Gold', 3);
INSERT INTO `flipkartdb`.`Color` (`color_id`, `color`, `subcategory_id`) VALUES (DEFAULT, 'Silver', 3);
INSERT INTO `flipkartdb`.`Color` (`color_id`, `color`, `subcategory_id`) VALUES (DEFAULT, 'Red', 3);
INSERT INTO `flipkartdb`.`Color` (`color_id`, `color`, `subcategory_id`) VALUES (DEFAULT, 'Brown', 4);
INSERT INTO `flipkartdb`.`Color` (`color_id`, `color`, `subcategory_id`) VALUES (DEFAULT, 'Green', 4);
INSERT INTO `flipkartdb`.`Color` (`color_id`, `color`, `subcategory_id`) VALUES (DEFAULT, 'White', 4);
INSERT INTO `flipkartdb`.`Color` (`color_id`, `color`, `subcategory_id`) VALUES (DEFAULT, 'Yellow', 4);
INSERT INTO `flipkartdb`.`Color` (`color_id`, `color`, `subcategory_id`) VALUES (DEFAULT, 'Black', 4);

insert into Deal values(deal_id,"Clearance Sale","Clearance Sale",50,NOW(),"2020-06-30 12:00:00","images/deal_images/deal3.jpeg");
insert into Deal values(deal_id,"Buy 1 Get 1","Buy1 and get 1 Free",50,NOW(),"2020-06-30 12:00:00","images/deal_images/deal2.jpeg");
insert into Deal values(deal_id,"Birthday Offer","Happy Birthday. Here is your offer", 30,NOW(),"2020-06-30 12:00:00","images/deal_images/deal1.jpeg");

COMMIT;

