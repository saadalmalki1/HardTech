-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Aug 09, 2026 at 12:29 PM
-- Server version: 5.6.17
-- PHP Version: 5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `hardtech`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE IF NOT EXISTS `admins` (
  `Admin_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Username` varchar(100) COLLATE utf8_bin NOT NULL,
  `Email` varchar(150) COLLATE utf8_bin NOT NULL,
  `Password_Hash` varchar(255) COLLATE utf8_bin NOT NULL,
  `Role` varchar(50) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`Admin_ID`),
  UNIQUE KEY `Username` (`Username`),
  UNIQUE KEY `Email` (`Email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE IF NOT EXISTS `cart` (
  `Cart_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Customer_ID` int(11) NOT NULL,
  `Created_At` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Cart_ID`),
  KEY `Customer_ID` (`Customer_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `cart_items`
--

CREATE TABLE IF NOT EXISTS `cart_items` (
  `Cart_Item_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Cart_ID` int(11) NOT NULL,
  `Item_ID` int(11) NOT NULL,
  `Quantity` int(11) NOT NULL,
  `Price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`Cart_Item_ID`),
  KEY `Cart_ID` (`Cart_ID`),
  KEY `Item_ID` (`Item_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE IF NOT EXISTS `categories` (
  `Category_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Category_Name` varchar(100) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`Category_ID`),
  UNIQUE KEY `Category_Name` (`Category_Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE IF NOT EXISTS `customers` (
  `Customer_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Customer_Name` varchar(100) COLLATE utf8_bin NOT NULL,
  `Mobile` varchar(20) COLLATE utf8_bin NOT NULL,
  `Email` varchar(150) COLLATE utf8_bin NOT NULL,
  `Password_Hash` varchar(255) COLLATE utf8_bin NOT NULL,
  `IBAN` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `Location` text COLLATE utf8_bin,
  `Profile_Picture` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `Account_Status` varchar(50) COLLATE utf8_bin DEFAULT 'Active',
  `Registration_Date` datetime DEFAULT CURRENT_TIMESTAMP,
  `Last_Login` datetime DEFAULT NULL,
  PRIMARY KEY (`Customer_ID`),
  UNIQUE KEY `Email` (`Email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `delivery`
--

CREATE TABLE IF NOT EXISTS `delivery` (
  `Delivery_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Order_ID` int(11) NOT NULL,
  `Method` varchar(100) COLLATE utf8_bin NOT NULL,
  `Company` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `Tracking_Number` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `Status` varchar(50) COLLATE utf8_bin DEFAULT 'Processing',
  PRIMARY KEY (`Delivery_ID`),
  KEY `Order_ID` (`Order_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `favorites`
--

CREATE TABLE IF NOT EXISTS `favorites` (
  `Favorite_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Customer_ID` int(11) NOT NULL,
  `Item_ID` int(11) NOT NULL,
  PRIMARY KEY (`Favorite_ID`),
  KEY `Customer_ID` (`Customer_ID`),
  KEY `Item_ID` (`Item_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `items`
--

CREATE TABLE IF NOT EXISTS `items` (
  `Item_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Seller_ID` int(11) NOT NULL,
  `Category_ID` int(11) NOT NULL,
  `Item_Name` varchar(150) COLLATE utf8_bin NOT NULL,
  `Description` text COLLATE utf8_bin NOT NULL,
  `Brand` varchar(100) COLLATE utf8_bin NOT NULL,
  `Model` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `Price` decimal(10,2) NOT NULL,
  `Quantity` int(11) NOT NULL,
  `Condition_Status` varchar(50) COLLATE utf8_bin NOT NULL,
  `Warranty` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `Status` varchar(50) COLLATE utf8_bin DEFAULT 'Available',
  `Created_At` datetime DEFAULT CURRENT_TIMESTAMP,
  `Updated_At` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Item_ID`),
  KEY `Seller_ID` (`Seller_ID`),
  KEY `Category_ID` (`Category_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE IF NOT EXISTS `messages` (
  `Message_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Sender_ID` int(11) NOT NULL,
  `Receiver_ID` int(11) NOT NULL,
  `Message_Text` text COLLATE utf8_bin NOT NULL,
  `Is_Read` tinyint(1) DEFAULT '0',
  `Attachments` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `Message_Time` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Message_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE IF NOT EXISTS `orders` (
  `Order_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Customer_ID` int(11) NOT NULL,
  `Seller_ID` int(11) NOT NULL,
  `Status` varchar(50) COLLATE utf8_bin DEFAULT 'Pending',
  `Payment_Method` varchar(100) COLLATE utf8_bin NOT NULL,
  `Delivery_Method` varchar(100) COLLATE utf8_bin NOT NULL,
  `Shipping_Address` text COLLATE utf8_bin NOT NULL,
  `Total` decimal(10,2) NOT NULL,
  `Order_Date` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Order_ID`),
  KEY `Customer_ID` (`Customer_ID`),
  KEY `Seller_ID` (`Seller_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE IF NOT EXISTS `order_items` (
  `Order_Item_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Order_ID` int(11) NOT NULL,
  `Item_ID` int(11) NOT NULL,
  `Quantity` int(11) NOT NULL,
  `Price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`Order_Item_ID`),
  KEY `Order_ID` (`Order_ID`),
  KEY `Item_ID` (`Item_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE IF NOT EXISTS `payments` (
  `Payment_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Order_ID` int(11) NOT NULL,
  `Method` varchar(50) COLLATE utf8_bin NOT NULL,
  `Amount` decimal(10,2) NOT NULL,
  `Status` varchar(50) COLLATE utf8_bin DEFAULT 'Processing',
  `Transaction_ID` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`Payment_ID`),
  UNIQUE KEY `Transaction_ID` (`Transaction_ID`),
  KEY `Order_ID` (`Order_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

CREATE TABLE IF NOT EXISTS `reviews` (
  `Review_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Seller_ID` int(11) NOT NULL,
  `Customer_ID` int(11) NOT NULL,
  `Rating` int(11) NOT NULL,
  `Comment` text COLLATE utf8_bin,
  `Review_Date` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Review_ID`),
  KEY `Seller_ID` (`Seller_ID`),
  KEY `Customer_ID` (`Customer_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `sellers`
--

CREATE TABLE IF NOT EXISTS `sellers` (
  `Seller_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Seller_Name` varchar(100) COLLATE utf8_bin NOT NULL,
  `Mobile` varchar(20) COLLATE utf8_bin NOT NULL,
  `ID_Number` varchar(50) COLLATE utf8_bin NOT NULL,
  `ID_Photo` varchar(255) COLLATE utf8_bin NOT NULL,
  `Location` text COLLATE utf8_bin,
  `Email` varchar(150) COLLATE utf8_bin NOT NULL,
  `Password_Hash` varchar(255) COLLATE utf8_bin NOT NULL,
  `IBAN` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `Account_Status` varchar(50) COLLATE utf8_bin DEFAULT 'Pending',
  `Registration_Date` datetime DEFAULT CURRENT_TIMESTAMP,
  `Avg_Rating` decimal(3,2) DEFAULT '0.00',
  `Verification_Status` varchar(50) COLLATE utf8_bin DEFAULT 'Unverified',
  PRIMARY KEY (`Seller_ID`),
  UNIQUE KEY `ID_Number` (`ID_Number`),
  UNIQUE KEY `Email` (`Email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `support_tickets`
--

CREATE TABLE IF NOT EXISTS `support_tickets` (
  `Ticket_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Customer_ID` int(11) NOT NULL,
  `Subject` varchar(255) COLLATE utf8_bin NOT NULL,
  `Message` text COLLATE utf8_bin NOT NULL,
  `Status` varchar(50) COLLATE utf8_bin DEFAULT 'Open',
  PRIMARY KEY (`Ticket_ID`),
  KEY `Customer_ID` (`Customer_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=1 ;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`Customer_ID`) REFERENCES `customers` (`Customer_ID`) ON DELETE CASCADE;

--
-- Constraints for table `cart_items`
--
ALTER TABLE `cart_items`
  ADD CONSTRAINT `cart_items_ibfk_1` FOREIGN KEY (`Cart_ID`) REFERENCES `cart` (`Cart_ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `cart_items_ibfk_2` FOREIGN KEY (`Item_ID`) REFERENCES `items` (`Item_ID`) ON DELETE CASCADE;

--
-- Constraints for table `delivery`
--
ALTER TABLE `delivery`
  ADD CONSTRAINT `delivery_ibfk_1` FOREIGN KEY (`Order_ID`) REFERENCES `orders` (`Order_ID`) ON DELETE CASCADE;

--
-- Constraints for table `favorites`
--
ALTER TABLE `favorites`
  ADD CONSTRAINT `favorites_ibfk_1` FOREIGN KEY (`Customer_ID`) REFERENCES `customers` (`Customer_ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `favorites_ibfk_2` FOREIGN KEY (`Item_ID`) REFERENCES `items` (`Item_ID`) ON DELETE CASCADE;

--
-- Constraints for table `items`
--
ALTER TABLE `items`
  ADD CONSTRAINT `items_ibfk_1` FOREIGN KEY (`Seller_ID`) REFERENCES `sellers` (`Seller_ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `items_ibfk_2` FOREIGN KEY (`Category_ID`) REFERENCES `categories` (`Category_ID`);

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`Customer_ID`) REFERENCES `customers` (`Customer_ID`),
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`Seller_ID`) REFERENCES `sellers` (`Seller_ID`);

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`Order_ID`) REFERENCES `orders` (`Order_ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`Item_ID`) REFERENCES `items` (`Item_ID`);

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`Order_ID`) REFERENCES `orders` (`Order_ID`) ON DELETE CASCADE;

--
-- Constraints for table `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`Seller_ID`) REFERENCES `sellers` (`Seller_ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`Customer_ID`) REFERENCES `customers` (`Customer_ID`) ON DELETE CASCADE;

--
-- Constraints for table `support_tickets`
--
ALTER TABLE `support_tickets`
  ADD CONSTRAINT `support_tickets_ibfk_1` FOREIGN KEY (`Customer_ID`) REFERENCES `customers` (`Customer_ID`) ON DELETE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
