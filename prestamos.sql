DROP DATABASE IF EXISTS PRESTAMOS_BCS;

-- CREAR BASE DE DATOS

CREATE DATABASE PRESTAMOS_BCS;

USE PRESTAMOS_BCS;


-- TABLA PERSONA

CREATE TABLE personas(

	curp CHAR(13) NOT NULL PRIMARY KEY,
    nombre VARCHAR(45) NOT NULL,
    primer_ap VARCHAR(45) NOT NULL,
    segundo_ap VARCHAR(45),
    calle_principal VARCHAR(45) NOT NULL,
    colonia VARCHAR(45) NOT NULL,
    cp CHAR(5) NOT NULL,
    calle_secundaria VARCHAR(45),
    num_ext CHAR(8) NOT NULL,
    num_int CHAR(8),
    ciudad VARCHAR(45) NOT NULL,
    telefono CHAR(10) NOT NULL,
    email VARCHAR(45) NOT NULL UNIQUE,
	password CHAR(40) NOT NULL

)ENGINE=INNODB;

-- modificar tabla persona, se agrega columna password

-- ALTER TABLE personas ADD COLUMN password CHAR(40) NOT NULL;



CREATE TABLE prestamos(
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    plazos SMALLINT NOT NULL,
    persona_curp CHAR(13) NOT NULL,
    autorizado BOOLEAN NOT NULL,
    fecha DATETIME DEFAULT NOW(),
    CONSTRAINT FK_PRESTAMO_PERSONA FOREIGN KEY(persona_curp)
    REFERENCES personas(curp) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=INNODB;

 ALTER TABLE prestamos ADD COLUMN cantidad DOUBLE NOT NULL AFTER id;

-- Tabla abono

CREATE TABLE abonos(

	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    abono DOUBLE NOT NULL,
    fecha DATETIME NOT NULL DEFAULT NOW(),
    prestamo_id INT NOT NULL,

    -- AGREGAR RESTRICCIÓN

    CONSTRAINT FK_ABONOS_PRESTAMO FOREIGN KEY(prestamo_id)

    REFERENCES prestamos(id) ON DELETE CASCADE ON UPDATE CASCADE

)ENGINE=INNODB;


-- AGREGAR DATOS => INSTRUCCIÓN INSERT

INSERT INTO personas VALUE('AA', 'Ana', 'Cota', 'López', 'Forjadore', 

'Puesta del Sol', '23090', NULL, '4444', NULL, 'La Paz', '6122016925', 'ana@mail.com', SHA1('123'));

SELECT * FROM personas; 


INSERT INTO personas VALUE('BB', 'Juan', 'Pérez', NULL, 'Santa Fé', 

'Roma', '23091', NULL, '4444', NULL, 'La Paz', '6122016926', 'juan@mail.com', SHA1('123'));

INSERT INTO personas VALUE('CC', 'Alicia', 'Torres', NULL, 'Santa Fé', 

'Roma', '23091', NULL, '4444', NULL, 'La Paz', '6122016926', 'alicia@mail.com', SHA1('123'));

INSERT INTO personas VALUE('DD', 'Jorge', 'Cota', NULL, 'Santa Fé', 

'Roma', '23091', NULL, '4444', NULL, 'La Paz', '6122016926', 'jorge@mail.com', SHA1('123'));

SELECT * FROM personas;
SELECT curp, nombre, primer_ap FROM personas;

INSERT INTO prestamos(cantidad, autorizado, plazos, persona_curp) VALUE(40000, true, 6, 'AA');
INSERT INTO prestamos(cantidad, autorizado, plazos, persona_curp) VALUE(50000, true, 12, 'AA');
INSERT INTO prestamos(cantidad, autorizado, plazos, persona_curp) VALUE(5000, true, 12, 'BB');
SELECT * FROM prestamos;

INSERT INTO abonos(abono, prestamo_id) VALUES(1000, 2);

SELECT * FROM abonos;
SELECT CONCAT_WS(' ',nombre, primer_ap, segundo_ap)  AS "nombre completo", 
cantidad, 
CASE

WHEN plazos = 6 THEN 'Seis Meses'
WHEN plazos = 12 THEN 'Doce Meses'
WHEN plazos = 18 THEN 'Dieciocho Meses'
WHEN plazos = 24 THEN 'Veinticuatro Meses'

END AS Plazos, 

CASE 

WHEN autorizado = 0 THEN 'Préstamos no autorizado'
WHEN autorizado = 1 THEN 'Préstamos autorizado'
END AS "Estatus Préstamos",

CASE
WHEN abonos.abono IS NULL THEN 'No se ha realizado abono'
ELSE abonos.abono
END AS 'Abonos'
FROM personas
INNER JOIN prestamos ON prestamos.persona_curp = personas.curp
LEFT OUTER JOIN abonos ON abonos.prestamo_id = prestamos.id;

SELECT * FROM personas;

SELECT * FROM abonos;

SELECT * FROM prestamos;

UPDATE prestamos set autorizado = 0 WHERE id = 2