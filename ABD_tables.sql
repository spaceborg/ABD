/*
drop table Ventas;
drop table clientes;
drop table categorias;

show tables;

*/
-- MySQL Workbench Forward Engineering
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema abd_sup_mer
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema abd_sup_mer
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `abd_sup_mer` DEFAULT CHARACTER SET utf8 ;
USE `abd_sup_mer` ;

-- -----------------------------------------------------
-- Table `abd_sup_mer`.`categorias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `abd_sup_mer`.`categorias` (
  `idCategoria` INT NOT NULL,
  `descCategoria` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCategoria`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `abd_sup_mer`.`regiones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `abd_sup_mer`.`regiones` (
  `idRegion` INT NOT NULL,
  `nomRegion` VARCHAR(45) NULL,
  PRIMARY KEY (`idRegion`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `abd_sup_mer`.`comunas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `abd_sup_mer`.`comunas` (
  `idComuna` INT NOT NULL,
  `nomComuna` VARCHAR(45) NULL,
  `idRegion` INT NOT NULL,
  PRIMARY KEY (`idComuna`),
  INDEX `fk_Comunas_Regiones1_idx` (`idRegion` ASC) VISIBLE,
  CONSTRAINT `fk_Comunas_Regiones1`
    FOREIGN KEY (`idRegion`)
    REFERENCES `abd_sup_mer`.`regiones` (`idRegion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `abd_sup_mer`.`clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `abd_sup_mer`.`clientes` (
  `idCliente` INT NOT NULL,
  `rutCliente` VARCHAR(10) NULL DEFAULT NULL,
  `nomCliente` VARCHAR(45) NOT NULL,
  `apeCliente` VARCHAR(45) NULL DEFAULT NULL,
  `emailCliente` VARCHAR(45) NULL DEFAULT NULL,
  `telCliente` VARCHAR(20) NULL DEFAULT NULL,
  `dirCliente` VARCHAR(45) NULL DEFAULT NULL,
  `idComuna` INT NOT NULL,
  PRIMARY KEY (`idCliente`),
  INDEX `fk_clientes_Comunas1_idx` (`idComuna` ASC) VISIBLE,
  CONSTRAINT `fk_clientes_Comunas1`
    FOREIGN KEY (`idComuna`)
    REFERENCES `abd_sup_mer`.`comunas` (`idComuna`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `abd_sup_mer`.`marcas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `abd_sup_mer`.`marcas` (
  `idMarca` INT NOT NULL,
  `nomMarca` VARCHAR(45) NULL,
  PRIMARY KEY (`idMarca`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `abd_sup_mer`.`productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `abd_sup_mer`.`productos` (
  `idProducto` INT NOT NULL,
  `nomProducto` VARCHAR(45) NOT NULL,
  `precioProducto` INT NOT NULL,
  `idCategoria` INT NOT NULL,
  `idMarca` INT NOT NULL,
  PRIMARY KEY (`idProducto`),
  INDEX `fk_Productos_Categoria1_idx` (`idCategoria` ASC) VISIBLE,
  INDEX `fk_productos_marcas1_idx` (`idMarca` ASC) VISIBLE,
  CONSTRAINT `fk_Productos_Categoria1`
    FOREIGN KEY (`idCategoria`)
    REFERENCES `abd_sup_mer`.`categorias` (`idCategoria`),
  CONSTRAINT `fk_productos_marcas1`
    FOREIGN KEY (`idMarca`)
    REFERENCES `abd_sup_mer`.`marcas` (`idMarca`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `abd_sup_mer`.`ventas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `abd_sup_mer`.`ventas` (
  `idVenta` INT NOT NULL,
  `fecVenta` DATE NOT NULL,
  `totVenta` INT NOT NULL,
  `idCliente` INT NOT NULL,
  PRIMARY KEY (`idVenta`),
  INDEX `fk_Ventas_Cliente1_idx` (`idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_Ventas_Cliente1`
    FOREIGN KEY (`idCliente`)
    REFERENCES `abd_sup_mer`.`clientes` (`idCliente`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `abd_sup_mer`.`detalleventas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `abd_sup_mer`.`detalleventas` (
  `idDetVenta` INT NOT NULL,
  `cantDetVenta` INT NOT NULL,
  `precioDetVenta` INT NOT NULL,
  `totalDetVenta` INT NOT NULL,
  `idVenta` INT NOT NULL,
  `idProducto` INT NOT NULL,
  PRIMARY KEY (`idDetVenta`),
  INDEX `fk_DetalleVenta_Ventas1_idx` (`idVenta` ASC) VISIBLE,
  INDEX `fk_DetalleVenta_Productos1_idx` (`idProducto` ASC) VISIBLE,
  CONSTRAINT `fk_DetalleVenta_Productos1`
    FOREIGN KEY (`idProducto`)
    REFERENCES `abd_sup_mer`.`productos` (`idProducto`),
  CONSTRAINT `fk_DetalleVenta_Ventas1`
    FOREIGN KEY (`idVenta`)
    REFERENCES `abd_sup_mer`.`ventas` (`idVenta`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `abd_sup_mer`.`proveedores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `abd_sup_mer`.`proveedores` (
  `idProveedor` INT NOT NULL,
  `rutProveedor` VARCHAR(10) NULL,
  `nomProveedor` VARCHAR(45) NULL,
  `dirProveedor` VARCHAR(45) NULL,
  `idComuna` INT NOT NULL,
  PRIMARY KEY (`idProveedor`),
  INDEX `fk_proveedores_comunas1_idx` (`idComuna` ASC) VISIBLE,
  CONSTRAINT `fk_proveedores_comunas1`
    FOREIGN KEY (`idComuna`)
    REFERENCES `abd_sup_mer`.`comunas` (`idComuna`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `abd_sup_mer`.`adquisiciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `abd_sup_mer`.`adquisiciones` (
  `idAdqui` INT NOT NULL,
  `fecAdqui` DATETIME NULL,
  `cantAdqui` INT NULL,
  `totalAdqui` INT NULL,
  `idProveedor` INT NOT NULL,
  `idProducto` INT NOT NULL,
  PRIMARY KEY (`idAdqui`),
  INDEX `fk_adquisiciones_productos1_idx` (`idProducto` ASC) VISIBLE,
  INDEX `fk_adquisiciones_proveedores1_idx` (`idProveedor` ASC) VISIBLE,
  CONSTRAINT `fk_adquisiciones_productos1`
    FOREIGN KEY (`idProducto`)
    REFERENCES `abd_sup_mer`.`productos` (`idProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_adquisiciones_proveedores1`
    FOREIGN KEY (`idProveedor`)
    REFERENCES `abd_sup_mer`.`proveedores` (`idProveedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
