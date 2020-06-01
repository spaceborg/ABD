-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema supermercado_ahumada
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema supermercado_ahumada
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `supermercado_ahumada` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `supermercado_ahumada` ;

-- -----------------------------------------------------
-- Table `supermercado_ahumada`.`categorias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `supermercado_ahumada`.`categorias` (
  `ide_cat` INT NOT NULL,
  `nom_cat` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ide_cat`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `supermercado_ahumada`.`regiones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `supermercado_ahumada`.`regiones` (
  `ide_reg` INT NOT NULL,
  `nom_reg` VARCHAR(45) NULL,
  PRIMARY KEY (`ide_reg`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `supermercado_ahumada`.`comunas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `supermercado_ahumada`.`comunas` (
  `ide_com` INT NOT NULL,
  `nom_com` VARCHAR(45) NULL,
  `ide_reg` INT NOT NULL,
  PRIMARY KEY (`ide_com`),
  INDEX `fk_comunas_regiones1_idx` (`ide_reg` ASC) VISIBLE,
  UNIQUE INDEX `nom_com_UNIQUE` (`nom_com` ASC) VISIBLE,
  CONSTRAINT `fk_comunas_regiones1`
    FOREIGN KEY (`ide_reg`)
    REFERENCES `supermercado_ahumada`.`regiones` (`ide_reg`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `supermercado_ahumada`.`clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `supermercado_ahumada`.`clientes` (
  `ide_cli` INT NOT NULL,
  `rut_cli` VARCHAR(10) NOT NULL,
  `nom_cli` VARCHAR(45) NOT NULL,
  `ape_cli` VARCHAR(45) NOT NULL,
  `dir_cli` VARCHAR(45) NOT NULL,
  `tel_cli` VARCHAR(10) NOT NULL,
  `ide_com` INT NOT NULL,
  PRIMARY KEY (`ide_cli`),
  INDEX `fk_clientes_comunas1_idx` (`ide_com` ASC) VISIBLE,
  CONSTRAINT `fk_clientes_comunas1`
    FOREIGN KEY (`ide_com`)
    REFERENCES `supermercado_ahumada`.`comunas` (`ide_com`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `supermercado_ahumada`.`marcas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `supermercado_ahumada`.`marcas` (
  `ide_mar` INT NOT NULL,
  `nom_mar` VARCHAR(45) NULL,
  PRIMARY KEY (`ide_mar`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `supermercado_ahumada`.`subcategoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `supermercado_ahumada`.`subcategoria` (
  `ide_sub` INT NOT NULL,
  `nom_sub` VARCHAR(45) NULL,
  `ide_cat` INT NOT NULL,
  PRIMARY KEY (`ide_sub`),
  INDEX `fk_subcategoria_categorias1_idx` (`ide_cat` ASC) VISIBLE,
  CONSTRAINT `fk_subcategoria_categorias1`
    FOREIGN KEY (`ide_cat`)
    REFERENCES `supermercado_ahumada`.`categorias` (`ide_cat`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `supermercado_ahumada`.`productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `supermercado_ahumada`.`productos` (
  `ide_prd` INT NOT NULL,
  `nom_prd` VARCHAR(45) NULL DEFAULT NULL,
  `pre_prd` INT NULL DEFAULT NULL,
  `ide_mar` INT NOT NULL,
  `ide_sub` INT NOT NULL,
  PRIMARY KEY (`ide_prd`),
  INDEX `fk_productos_marcas1_idx` (`ide_mar` ASC) VISIBLE,
  INDEX `fk_productos_subcategoria1_idx` (`ide_sub` ASC) VISIBLE,
  CONSTRAINT `fk_productos_marcas1`
    FOREIGN KEY (`ide_mar`)
    REFERENCES `supermercado_ahumada`.`marcas` (`ide_mar`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_productos_subcategoria1`
    FOREIGN KEY (`ide_sub`)
    REFERENCES `supermercado_ahumada`.`subcategoria` (`ide_sub`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `supermercado_ahumada`.`ventas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `supermercado_ahumada`.`ventas` (
  `ide_vta` INT NOT NULL,
  `fch_vta` DATE NOT NULL,
  `tot_vta` INT NOT NULL,
  `ide_cli` INT NOT NULL,
  PRIMARY KEY (`ide_vta`),
  INDEX `fk_Ventas_Clientes1_idx` (`ide_cli` ASC) VISIBLE,
  CONSTRAINT `fk_Ventas_Clientes1`
    FOREIGN KEY (`ide_cli`)
    REFERENCES `supermercado_ahumada`.`clientes` (`ide_cli`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `supermercado_ahumada`.`detalle_ventas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `supermercado_ahumada`.`detalle_ventas` (
  `ide_det_vta` INT NOT NULL,
  `ctd_det_vta` INT NULL DEFAULT NULL,
  `pre_det_vta` INT NULL DEFAULT NULL,
  `tot_det_vta` INT NULL DEFAULT NULL,
  `ide_prd` INT NOT NULL,
  `ide_vta` INT NOT NULL,
  PRIMARY KEY (`ide_det_vta`),
  INDEX `fk_Detalle_Ventas_Productos1_idx` (`ide_prd` ASC) VISIBLE,
  INDEX `fk_Detalle_Ventas_Ventas1_idx` (`ide_vta` ASC) VISIBLE,
  CONSTRAINT `fk_Detalle_Ventas_Productos1`
    FOREIGN KEY (`ide_prd`)
    REFERENCES `supermercado_ahumada`.`productos` (`ide_prd`),
  CONSTRAINT `fk_Detalle_Ventas_Ventas1`
    FOREIGN KEY (`ide_vta`)
    REFERENCES `supermercado_ahumada`.`ventas` (`ide_vta`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
