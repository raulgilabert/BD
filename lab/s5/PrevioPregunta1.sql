-- Sentències d'esborrat de la base de dades:
DROP TABLE empleats;
DROP TABLE departaments;
DROP TABLE projectes;

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

--------------------------
-- Joc de proves Public
--------------------------

-- Sentències d'inicialització:
INSERT INTO  DEPARTAMENTS VALUES (3,'MARKETING',3,'RIOS ROSAS','MADRID');

INSERT INTO  EMPLEATS VALUES (3,'ROBERTO',25000,'BARCELONA',3,null);
INSERT INTO  EMPLEATS VALUES (5,'EULALIA',150000,'BARCELONA',3,null);

select distinct d.num_dpt, d.nom_dpt 
	from departaments d, empleats e 
	where 
		e.num_dpt = d.num_dpt and
		e.ciutat_empl in (select 
								e1.ciutat_empl from empleats e1
								where
									e1.num_empl <> e.num_empl and 
									e1.num_dpt = e.num_dpt
								);








