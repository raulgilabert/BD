-- Sentències de neteja de les taules:
drop table assignacions;
drop table despatxos;
drop table professors;

-- Sentències de preparació de la base de dades:
create table professors
(dni char(50),
nomProf char(50) unique,
telefon char(15),
sou integer not null check(sou>0),
primary key (dni));

create table despatxos
(modul char(5), 
numero char(5), 
superficie integer not null check(superficie>12),
primary key (modul,numero));

create table assignacions
(dni char(50), 
modul char(5), 
numero char(5), 
instantInici integer, 
instantFi integer,
primary key (dni, modul, numero, instantInici),
foreign key (dni) references professors,
foreign key (modul,numero) references despatxos);
-- instantFi te valor null quan una assignacio es encara vigent.

--------------------------
-- Joc de proves Public
--------------------------

-- Sentències d'inicialització:
insert into professors values ('999', 'DOLORS', '323323323', 100000);

insert into despatxos values ('Omega','128',30);

insert into assignacions values ('999', 'Omega', '128',1,null);

-- Necesitamoh pillah Modulo y numero de despachos ocupados por profesor salario = 100000

#P=PROFESSORS(sou=100000)
N=PROFESSORS(sou<>100000)
A=P*ASSIGNACIONS
B=N*ASSIGNACIONS
C=A[modul, numero]
D=B[modul, numero]
E=C-D








