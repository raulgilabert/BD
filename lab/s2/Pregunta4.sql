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

create table comandes
		( numComanda INTEGER,
	instantComanda INTEGER not null,
	client CHAR(30) not null,
	encarregat INTEGER not null,
	supervisor 	INTEGER,
	
	primary key (numComanda),
	unique (instantComanda, client),
	foreign key (encarregat) references empleats (num_empl),
	foreign key (supervisor) references empleats (num_empl));

create table productesComprats
		( numComanda INTEGER,
	producte CHAR(20),
	quantitat INTEGER not null default 1,
	preu INTEGER,
	
	primary key (numComanda, producte),
	foreign key (numComanda) references comandes (numComanda));






















