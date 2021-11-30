-- -----------------------------------------------------
-- Schema GolfTävling
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `GolfTävling` ;
CREATE SCHEMA IF NOT EXISTS `GolfTävling` DEFAULT CHARACTER SET utf8 ;
USE `GolfTävling` ;

-- -----------------------------------------------------
-- Table `GolfTävling`.`Spelare`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `GolfTävling`.`Spelare` ;
CREATE TABLE IF NOT EXISTS `GolfTävling`.`Spelare` (
  `PersonNr` VARCHAR(13) NOT NULL,
  `Namn` VARCHAR(45) NULL,
  `Ålder` INT NULL,
  `id` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`PersonNr`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `GolfTävling`.`Jacka`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `GolfTävling`.`Jacka` ;
CREATE TABLE IF NOT EXISTS `GolfTävling`.`Jacka` (
  `idJacka` INT NOT NULL AUTO_INCREMENT,
  `Storlek` ENUM('x-small', 'small', 'medium', 'large', 'x-large') NULL,
  `Material` VARCHAR(45) NULL,
  `Spelare_PersonNr` VARCHAR(13) NOT NULL,
  `Initialer` VARCHAR(3) NOT NULL,
  PRIMARY KEY(`Spelare_PersonNr`,`Initialer`),
  INDEX `fk_Jacka_Spelare1_idx` (`Spelare_PersonNr` ASC) INVISIBLE,
  UNIQUE INDEX `idJacka_UNIQUE` (`idJacka` ASC) VISIBLE,
  CONSTRAINT `fk_Jacka_Spelare`
    FOREIGN KEY (`Spelare_PersonNr`)
    REFERENCES `GolfTävling`.`Spelare` (`PersonNr`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `GolfTävling`.`Konstruktion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `GolfTävling`.`Konstruktion` ;
CREATE TABLE IF NOT EXISTS `GolfTävling`.`Konstruktion` (
  `SerialNR` INT NOT NULL AUTO_INCREMENT,
  `Hårdhet` INT NULL,
  PRIMARY KEY (`SerialNR`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `GolfTävling`.`Regn`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `GolfTävling`.`Regn` ;
CREATE TABLE IF NOT EXISTS `GolfTävling`.`Regn` (
  `Typ` VARCHAR(45) NOT NULL,
  `Vindstyrka` VARCHAR(45) NULL,
  `id` INT NULL AUTO_INCREMENT,
  PRIMARY KEY (`Typ`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `GolfTävling`.`Tävling`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `GolfTävling`.`Tävling` ;
CREATE TABLE IF NOT EXISTS `GolfTävling`.`Tävling` (
  `Tävlingsnamn` VARCHAR(45) NOT NULL,
  `Datum` DATE NULL,
  `id` INT NULL AUTO_INCREMENT,
  PRIMARY KEY (`Tävlingsnamn`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GolfTävling`.`Delta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `GolfTävling`.`Delta` ;
CREATE TABLE IF NOT EXISTS `GolfTävling`.`Delta` (
  `Spelare_PersonNr` VARCHAR(13) NOT NULL,
  `Tävling_Tävlingsnamn` VARCHAR(45) NOT NULL,
  `id` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`Spelare_PersonNr`, `Tävling_Tävlingsnamn`),
  INDEX `fk_Spelare_has_Tävling_Tävling1_idx` (`Tävling_Tävlingsnamn` ASC) VISIBLE,
  INDEX `fk_Spelare_has_Tävling_Spelare_idx` (`Spelare_PersonNr` ASC) VISIBLE,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  CONSTRAINT `fk_Spelare_has_Tävling_Spelare`
    FOREIGN KEY (`Spelare_PersonNr`)
    REFERENCES `GolfTävling`.`Spelare` (`PersonNr`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Spelare_has_Tävling_Tävling`
    FOREIGN KEY (`Tävling_Tävlingsnamn`)
    REFERENCES `GolfTävling`.`Tävling` (`Tävlingsnamn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `GolfTävling`.`Har`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `GolfTävling`.`Har` ;
CREATE TABLE IF NOT EXISTS `GolfTävling`.`Har` (
  `Tävling_Tävlingsnamn` VARCHAR(45) NOT NULL,
  `Regn_Typ` VARCHAR(45) NOT NULL,
  `Tidpunkt` TIME NULL,
  `id` INT NULL AUTO_INCREMENT,
  PRIMARY KEY (`Tävling_Tävlingsnamn`, `Regn_Typ`),
  INDEX `fk_Tävling_has_Regn_Regn1_idx` (`Regn_Typ` ASC) VISIBLE,
  INDEX `fk_Tävling_has_Regn_Tävling1_idx` (`Tävling_Tävlingsnamn` ASC) VISIBLE,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  CONSTRAINT `fk_Tävling_has_Regn_Tävling`
    FOREIGN KEY (`Tävling_Tävlingsnamn`)
    REFERENCES `GolfTävling`.`Tävling` (`Tävlingsnamn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Tävling_has_Regn_Regn`
    FOREIGN KEY (`Regn_Typ`)
    REFERENCES `GolfTävling`.`Regn` (`Typ`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GolfTävling`.`Klubba`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `GolfTävling`.`Klubba` ;
CREATE TABLE IF NOT EXISTS `GolfTävling`.`Klubba` (
  `Material` VARCHAR(45) NULL,
  `Nr` INT NOT NULL AUTO_INCREMENT,
  `Spelare_PersonNr` VARCHAR(13) NOT NULL,
  `Konstruktion_SerialNR` INT NOT NULL,
  PRIMARY KEY (`Spelare_PersonNr`,`Konstruktion_SerialNR`),
  INDEX `fk_Klubba_Spelare1_idx` (`Spelare_PersonNr` ASC) VISIBLE,
  INDEX `fk_Klubba_Konstruktion1_idx` (`Konstruktion_SerialNR` ASC) VISIBLE,
  UNIQUE INDEX `Nr_UNIQUE` (`Nr` ASC) VISIBLE,
  CONSTRAINT `fk_Klubba_Spelare`
    FOREIGN KEY (`Spelare_PersonNr`)
    REFERENCES `GolfTävling`.`Spelare` (`PersonNr`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Klubba_Konstruktion`
    FOREIGN KEY (`Konstruktion_SerialNR`)
    REFERENCES `GolfTävling`.`Konstruktion` (`SerialNR`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_SAFE_UPDATES = 0;
-- -----------------------------------------------------
-- Lägg till data:
-- -----------------------------------------------------

SET @JohanAnderssonPersonNr = '19961012-5931';
SET @NicklasJanssonPersonNr = '19900112-5753';
SET @AnnikaPerssonPersonNr = '20000520-7282';

-- Spelare:
INSERT INTO spelare VALUES (@JohanAnderssonPersonNr,'Johan Andersson',25,0);
INSERT INTO spelare VALUES (@NicklasJanssonPersonNr,'Nicklas Jansson',41,0);
INSERT INTO spelare VALUES (@AnnikaPerssonPersonNr,'Annika Persson',21,0);

-- Tävlingar:
INSERT INTO tävling (Tävlingsnamn, Datum) VALUES ('Big Golf Cup Skövde','2021-06-10');

-- Deltagare i tävling 'Big Golf Cup Skövde':
INSERT INTO delta (Spelare_PersonNr,Tävling_Tävlingsnamn) VALUES (@JohanAnderssonPersonNr,'Big Golf Cup Skövde');
INSERT INTO delta (Spelare_PersonNr,Tävling_Tävlingsnamn) VALUES (@NicklasJanssonPersonNr,'Big Golf Cup Skövde');
INSERT INTO delta (Spelare_PersonNr,Tävling_Tävlingsnamn) VALUES (@AnnikaPerssonPersonNr,'Big Golf Cup Skövde');

-- Väder:
INSERT INTO regn (Typ, Vindstyrka) VALUES ('hagel', '10m/s');
INSERT INTO har (Tävling_Tävlingsnamn,Regn_Typ,Tidpunkt) VALUES ('Big Golf Cup Skövde','hagel','12:00');

-- Jackor:
INSERT INTO jacka (Storlek,Material,Spelare_PersonNr,Initialer) VALUES ('large','fleece',@JohanAnderssonPersonNr,'JA');
INSERT INTO jacka (Storlek,Material,Spelare_PersonNr,Initialer) VALUES ('large','goretex',@JohanAnderssonPersonNr,'JA');
INSERT INTO jacka (Storlek,Material,Spelare_PersonNr,Initialer) VALUES ('x-large','fleece',@NicklasJanssonPersonNr,'NJ');
INSERT INTO jacka (Storlek,Material,Spelare_PersonNr,Initialer) VALUES ('small','goretex',@AnnikaPerssonPersonNr,'AP');

-- Klubbor:
INSERT INTO konstruktion (Hårdhet) VALUES (10);
INSERT INTO konstruktion (Hårdhet) VALUES (5);
INSERT INTO konstruktion (Hårdhet) VALUES (8);

SET @konstruktion_10_SerialNR = (SELECT SerialNR FROM konstruktion WHERE Hårdhet=10);
SET @konstruktion_5_SerialNR = (SELECT SerialNR FROM konstruktion WHERE Hårdhet=5);
SET @konstruktion_8_SerialNR = (SELECT SerialNR FROM konstruktion WHERE Hårdhet=8);

INSERT INTO klubba (Material,Spelare_PersonNr,Konstruktion_SerialNR) VALUES ('Trä',@NicklasJanssonPersonNr,@konstruktion_10_SerialNR);
INSERT INTO klubba (Material,Spelare_PersonNr,Konstruktion_SerialNR) VALUES ('Trä',@AnnikaPerssonPersonNr,@konstruktion_5_SerialNR);
INSERT INTO klubba (Material,Spelare_PersonNr,Konstruktion_SerialNR) VALUES ('Järn',@JohanAnderssonPersonNr,@konstruktion_8_SerialNR);

-- Operationer:

-- 1:
SELECT Ålder FROM spelare WHERE Namn='Johan Andersson'; 

-- 2:
SELECT Datum FROM tävling WHERE Tävlingsnamn='Big Golf Cup Skövde'; 

-- 3:
SELECT Material FROM klubba,spelare WHERE klubba.Spelare_PersonNr=spelare.PersonNr AND spelare.Namn='Johan Andersson';

-- 4:
SELECT jacka.* FROM jacka,spelare WHERE spelare.Namn='Johan Andersson' AND jacka.Spelare_PersonNr=spelare.PersonNr;

-- 5:
SELECT spelare.* FROM spelare,delta,tävling WHERE spelare.PersonNr=delta.Spelare_PersonNr AND delta.Tävling_Tävlingsnamn=tävling.Tävlingsnamn AND tävling.Tävlingsnamn='Big Golf Cup Skövde';

-- 6:
SELECT regn.Vindstyrka FROM regn,har,tävling WHERE regn.Typ=har.Regn_Typ and har.Tävling_Tävlingsnamn=tävling.Tävlingsnamn AND tävling.Tävlingsnamn='Big Golf Cup Skövde';

-- 7:
SELECT * FROM spelare WHERE Ålder < 30;

-- 8:
DELETE FROM jacka WHERE jacka.Spelare_PersonNr=@JohanAnderssonPersonNr;

-- 9:
DELETE FROM delta WHERE delta.Spelare_PersonNr=@NicklasJanssonPersonNr;
DELETE FROM jacka WHERE jacka.Spelare_PersonNr=@NicklasJanssonPersonNr;
DELETE FROM klubba WHERE klubba.Spelare_PersonNr=@NicklasJanssonPersonNr;
DELETE FROM spelare WHERE Namn='Nicklas Jansson';

-- 10:
SELECT avg(Ålder) AS Medelålder FROM spelare;

