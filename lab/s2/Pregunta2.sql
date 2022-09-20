-- Sentències de preparació de la base de dades:
CREATE TABLE DEPARTAMENTS
         (	NUM_DPT INTEGER,
	NOM_DPT CHAR(20),
	PLANTA INTEGER,
	EDIFICI CHAR(30),
	CIUTAT_DPT CHAR(20),
	PRIMARY KEY (NUM_DPT));

CREATE TABLE PROJECTES
         (	NUM_PROJ INTEGER,
	NOM_PROJ CHAR(10),
	PRODUCTE CHAR(20),
	PRESSUPOST INTEGER,
	PRIMARY KEY (NUM_PROJ));

CREATE TABLE EMPLEATS
         (	NUM_EMPL INTEGER,
	NOM_EMPL CHAR(30),
	SOU INTEGER,
	CIUTAT_EMPL CHAR(20),
	NUM_DPT INTEGER,
	NUM_PROJ INTEGER,
	PRIMARY KEY (NUM_EMPL),
	FOREIGN KEY (NUM_DPT) REFERENCES DEPARTAMENTS (NUM_DPT),
	FOREIGN KEY (NUM_PROJ) REFERENCES PROJECTES (NUM_PROJ));

-- Sentències d'esborrat de la base de dades:
DROP TABLE empleats;
DROP TABLE projectes;
DROP TABLE departaments;

--------------------------
-- Joc de proves Public
--------------------------

-- Sentències d'inicialització:
INSERT INTO  DEPARTAMENTS VALUES (
5,'VENDES',3,'CASTELLANA','MADRID');

INSERT INTO  EMPLEATS VALUES (1,'MANEL',250000,'MADRID',5,null);

INSERT INTO  EMPLEATS VALUES (3,'JOAN',25000,'GIRONA',5,null);

-- Sentències de neteja de les taules:
DELETE FROM empleats;
DELETE FROM Projectes;
DELETE FROM departaments;


select distinct e.ciutat_empl from empleats e where not exists (select d.ciutat_dpt from departaments d where e.ciutat_empl=d.ciutat_dpt);




