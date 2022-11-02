# BD

[web (no se usa el Racó)](https://learnsql2.fib.upc.edu)

## Profe teoría

jordi.casanovas@upc.edu

No tiene llaves del despacho xd

flexea de trabajar en el lidl, recoger motos y follar (tiene un hijo)

## Nota

0.45 * Parcial + 0.45 * Final + 0.1 * Lab

- Lab: Cuestionarios y pregunta durante clase
- Parcial: Temas 1, 2, 3, 4 y 7
- Final: Temas 5, 6, 8 y 9


## Tema 1: Introducción

El icono de base de datos es por los discos magnéticos donde se guardaba datos.

### SGBD

Sistema gestor de bases de datos.

- Acceso multi-usuario

    Debe permitir acceder concurremntemente sin dar problemas de persistencia e
    integridad.

    Se puede acabar la operación de dos maneras:
    - COMMIT: operación correcta
    - ROLLBACK: operación errónea, deshace la operación

- Seguridad
    Atenticación: permiso de acceso con identificación (HTTP 401).

    Autorización: una vez autentificado se permiten las operaciones (HTTP 403).

- Fiabilidad
    Reglas de integridad de los datos.

    No se deben de perder datos en mitad de las operaciones. En caso de fallo
    retroceso en la operación. En caso de fallo se puede tratar de recuperar la
    inforación gracias a los logs.

- Conveniencia
    Se debe de permitir la adición o supresión de atributos, clases de objetos
    o asociaciones entre datos, además de permitir cambiar el registro físico
    de los datos.

### Arquitectura ANSI/SPARC

La arquitectura ANSI/SPARC está oriendada a la obtención de la independencia
física y lógica de los datos:

- Nivel interno: almacenamiento de los datos.
- Nivel conceptual: estrcutura de la base de datos para toda la comunidad
  de usuarios.
- Nivel externo: Diferentes visiones de los diferentes tipos de usuario o
  aplicación que usen la base de datos.

La relación entre el nivel interno y conceptual define la independencia
física.

La relación entre el nivel conceptual y externo define la independencia
lógica.

Esquema conceptual: Tiene la descripción de los elementos que pertenecen a un
nivel determinado, en este caso: las clases de los objetos, los atributos, las
asociaciones y las restricciones de integridad.

Esquema interno: Contiene la descripción de la organización de los ficheros
que almacenan la base de datos y las estructuras de datos auxiliares que
agilizan el acceso.

Esquema externo: Contiene el subconjuntos de datos del esquema conceptual y los
datos calculables a partir del esquema conceptual que interesan a un
determinado tipo de usuario o aplicación.

#### Independencia de los datos

##### Física

La independencia física de los datos permite que cualquier cambio en el modo de
organización de los archivos no afecte al esquema conceptual ni a los esquemas
externos, cualquier cambio en el esquema interno como puede ser un cambio en
los métodos de acceso a los datos o el tamaño de las páginas. Estos cambios a
nivel de usuario no afectan pero sí que será necesario rehacer las
correspondencias entre el esquema conceptual y el interno y seguramente tener
que rehacer la base de datos física.

##### Lógica

Cualquier cambio en el esquema conceptual de los datos no afectará a los
esquemas externos que no hagan referencia a las clases, atributos o
asociaciones modificados. Además, cualquier cambio en los esquemas externos no
afectará ni a los otros esquemas externos, ni al esquema conceptual ni al
esquema interno.


## Modelo relacional

Informálmente cada relación en el modelo relacionar se puede visualizar como
una tabla, de forma que cada fila sería una colección de datos que tienen
relación entre ellos. El nombre de la tabla y de las columnas sirve para
interpretar el significado de los valores. Todos los valores de la misma
columna son de la misma clase.

- Fila <-> Tupla
- Columna <-> Atributo
- Tabla <-> Relación

Una relación se compone de un esquema de esta (cabecera) y el contenido de
esta.

El esquema se compone del nombre de este y el conjunto de atributos.

Un atributo es el rol que ejerce un dominio en un esquema.

El dominio es el conjunto de valores del mismo tipo.

Dominios:

- Texto:
    - Char(x) // Espacio fijo de chars
    - Varchar(x) // Espacio de chars que se libera lo no usado al hacer el
      commit
- Números:
    - Int
    - Bigint
    - Tinyint
- Booleanos
- Timestamp
    Guarda la cantidad de segundos que han pasado desde el 01/01/1970 00:00
- Null
    En caso de no conocer el valor que se quiere guardar se usa NULL

La extensión de una relación es un conjunto de tuplas donde cualquiero elemento

La cardinalidad es la cantidad de tuplas de la extensión y el grado el número
de atributos.

Una superclave es un subconjunto de atributos que permiten identificar cada
tupla.

Ejemplo: 

```
EMPLEADO: (DNI, NSS, Nombre, Teléfono, Sueldo)

Superclaves:

{DNI, NSS, Nombre, Teléfono, Sou}
{DNI, Nombre}
{DNI}
etc.

```

La clave es el conjunto mínimo que sea superclave.

La clave primaria es aquel valor que se usa como identificador dentro de la
base de datos, declarado como `UNIQUE` en la definición de la tabla.

Una clave alternativa es una clave no designada como primaria.

/!\ Se subrallan los atributos que forman la clave primaria.

### Operaciones

Las operaciones del modelo relacional deben permitir manipular los datos
almacenados en la base de datos.

#### Actualización

- Insertar tuplas
- Borrar tuplas
- Modificar tuplas

#### Consulta

Obtener los datos deducibles a partir de las relaciones.

---

### Reglas de integridad

#### Regla de indentidad

Todos los atributos de la clave primaria deben ser únicos dentro de los valores
de la relación, es decir, no se puede repetir ese valor y, además, no puede ser
nulo.

#### Regla de dominio

Un valor no nulo debe pertenecer al dominio del atributo.

#### Regla de referencialidad

Ayuda a definir las relaciones entre tablas.

En la situación que pase esto, por ejemplo:

```
DEPARTAMENTOS(Nombre)
		Producción
		Ventas

EMPLEADOS(DNI; Departamento)
		4043904390	Producción
		4839058096	Producción
		6546984694	Ventas
		2958340583	NULL
		3455396504	Marketing	// Este no puede existir por no
						// estar Marketing en los
						// departamentos
```

Al momento de modificar un elemento de la relación DEPARTAMENTOS del ejemplo
anterior hay varias reglas que pueden ejecutarse y que se definen al crear la
tabla pero usando un ALTERN TABLE ...:

- RESTRICT
    No permite la modificación si este dato está referenciado en otra tabla.
- CASCADE
    Si se cambia el nombre o se elimina se hace la++ misma acción en cascada en
    cualquier otra tambla donde esté referenciado el elemento.

## Componentes lógicos

### Esquemas

Se agrupa los comnentes de datos (tablas, vistas, etc.) y los componentes de
control (procedimientos, disparadores, etc.). Permite la gestión más simple de
la base de datos con el esquema de información.

### Conexiones, sesiones y transacciones

Una conexión se puede definir como la asociación entre un cliente SQL y un
servidor SQL cuando el cliente manifiesta la intención de trabajar con la base
de datos.

```SQL
CONNECT TO nombre_servidor [AS nombre_conexión] [USER identificador_usuario]
SET_SCHEMA esquema
```

(Mirar temario)

Las restricciones solo se comprobarán en caso de que la tabla tengan datos.

#### Aserciones

Restricciones de integridad que afectan a más de una tabla. A diferencia de las
restricciones de columna o de tabla se comprieban siempre. No se pueden definir
en la matoría de los sistemas actuales, de forma que hay que usar otros
mecanismos: los disparadores.

```SQL
CREATE ASSERTION nombre CHECK (condición);
```

Ejemplo:

```SQL
CREATE ASSERTION foo CHECK(
    (SELECT val FROM (1)) = (SELECT val FROM (2))
    )
```

Ejercicios

1.- Mío
```SQL
CREATE ASSERTION foo CHECK(
    NOT EXISTS(SELECT * from categorias c, empleats e WHERE e.categoria =
    c.categoria and e.sou < c.soumínim)
    );
```

1.- Profesor
```SQL
CREATE ASSERTION foo CHECK(
    NOT EXISTS(SELECT * from empleats e JOIN categories c ON e.categoria =
    c.categoria WHERE e.sou < c.soumínim)
    );
```
2.-
```SQL
CREATE ASSERTION bar CHECK(
    (SELECT COUNT(*) FROM Empleats_adm) <= (SELECT COUNT(*) FROM Empleats_prod)
	);
```

### Vistas

Permite guardar queries como un proceso que se ejecuta, de forma que en lugar
de ejecutar un `select` enorme se usar un `select` únicamente de la vista.

```SQL
CREATE VIEW empate AS (
    SELECT *
    FROM partits
    where golsElocal = golsevisitant
	) WHITH CHECK OPTION;
```

### Privilegios

Un privilegio es un rol/usuario que permite realizar ciertas operaciones sobre
algún objeto del esquema. Se asignan usando `GRANT` y para eliminarlos usando
`REVOKE`. Tener permisos de admin es dar la totalidad del control de la base de
datos a ese usuario.

Se definen 9 privilegios:

- Select
- Insert
- Update
- Delete

Permite acceder a ciertas tablas e incluso a ciertas columnas de la tabla
limitando el acceso.

- References
    Privilegio de crear nuvas claves ajenas y referencias
- Usage
    Permite utilizar otros objetos
- Trigger
    Definir disparadores
- Execute
    Derecho a ejecutar piezas de código como pueden ser los procedimientos
- Under
    Crear subtipos
- All
    Todo

Cuando un usuario crea un esquema se identifica con la cláusula `AUTHORIZATION`
y tiene todos los privilegios sobre este. Será inaccesible para cualquier
usuario a menos que sea añadido con la cláusula `GRANT`. Si se añade `WITH
GRANT OPTION` se permite que este usuario le dé permisos a otros más.

A la hora de revocar los permisos a algún usuario añadiendo `CASCADE` se
eliminan también los permisos que este usuario ha dado. Usando `RESTRICT` se
evita que en caso de que `CASCADE` fuera a eliminar algo más se haga.

### Cosa importante: Ley Orgánica de Protección de Datos personales (LOPD)

Ley orgánica 15/1999
Real decreto 994/1999

Modificado en el BOU 55/2011 para redefinir los niveles de gravedad de las
infracciones y cambios en las sanciones.

Ley catalana 32/2010

Se creó un nuevo reglamento de la UE del 27 de abril al 2016 que entró en vigor
el 25 de mayo de 2018. General Data Protection Regulation (GDPR).

Se aplica a cualquier organización registrada en la UE o con sede en la UE o
que procesa datos peronales de ciudadanos europeos.

Qué son datos personales?

- Nombre
- Correo
- Dirección
- Identificadores como DNI
- Localización
- IP
- Cookies
- RFID
- Salud
- Genética
- Datks biométricos
- Datos raciales o étnicos
- Opiniones políticas
- etc.

Lo que hay que hacer es guardar los datos encriptados, se tienen que comprobar
y evaluar las políticas de seguridad, se tiene que grantizar la
confidencialidad, intefrodad, disponibilidad y resiliencia de los sistemas, se
tiene que dotar a la organización con los recursos necesarios para devolver la
disponibilidad y acceso a los datos e ncaso de incidencia física o técnica en
un tiempo razonable.

Se debe de garantizar:

- Obtener consentimiento de manera clara y sencilla y obtener baja
- Notificar a tiempo una fuga de datos.
- Derecho al acceso a una copoa gratuita de los datos de un usuario cuando se
  pida.
- Derecho al olvido de los datos del servidor, pudiendo pedir la eliminación de
  todos los datos de un usuario.
- Portabilidad de los datos a otra organización si el usuario lo pide.
- Privacidad implícita en el diseño del sistema.
- Data Protection Officer en caso de que la empresa cumpla ciertos requisitos.

Para mirar multas por GDPR [enformcementtracker.com](www.enforcementtracker.com)

## Diseño de bases de datos relacionales

EL diseño de una bas de datos relacional consiste en definir la estructura de
los datos que debe tener esta abse de datos de un sistema de información
determinado.

En el caso de las bases de datos relacionales esta estructura será un conjunto
de esquemas en relación a sus atributos, claves, índices, etc.

### Etapas del diseño

1. Diseño conceptual
    
    Se obtiene una estructura de la información de la futura base de datos
    independiente de la tecnología uqe s eutilizará y se hace un equema en un
    lenguaje como UML, ERC, etc.

2. Diseño lógico

    El resultado del diseño conceptual se adapta al model del software gestor
    de bases de datos con el que se desee implementar la base de datos. En el
    caso de que sea un modelo relacional se obtienen las relaciones con sus
    atribtos, claves primarias y claves externas.

3. Diseño físico

    Se transforma la estructura obtenida en la etapa del diseño ñógico con el
    objetivo de conseguir una amyor eficiencia y, además, se complementa con
    los aspectos de implementación física que dependerán del software gestor.

### Diseño conceptual en UML

#### Clases de objetos y atributos

Las clases de objeto describen un conjunto de objetos similares de los cuales
interesan las mismas propiedades. Los objetos tienen una identidad y son
distinguibles entre ellos. Los atributos son aquellas propiedades compartidas
por los objetos de una clase. La clave exerna son aquellos atributos mínimos
que permiten la identificación de los objetos de una clase. Aunque UML no dé
una notación gráfica para identificar las claves externas de las clases de
objetos se pueden describir con restricciones textuales.

#### Asociaciones

Una asociación es la representación de na relación entre dos o más objetos.
Pueden ser binarias o de un orden superior a dos.

La multiplicidad de las asociaciones binarias definen cuántas instalcias de una
clase B se pueden asociaciar con una clase b, de forma que si el máximo es *
significa que este no está limitado. Si el mínimo es igual que el máximo esto
se puede indicar poniendo únicamente una vez el valor, al giaul que una
multiplicidad 0..\* se indica brevemente como \*. Por ejemplo los siguientes
casos:

Departamento 1 tiene asignado -> * Empleado

Profesor 0..1 Tutoriza -> * Estudiante

Delegación 0..1 Se situa en -> 0..1 Ciudad

Producto \* se guarda en \* Almacén

El cambio, la multiplicidad de las asociaciones ternarias es, teniendo una
instancia a de A y una instancia b de B la multiplicidad al lado de C define
cuántas insdtancias de C se pueden asociar por la pareja de a y b.

Además, hay asociaciones recursivas en las que una misa clase de objetos
participa más de una vez.

Además de todo esto, hay clases asociaciatovas, donde una asociaciones de
clases de objetos se puede caracterizar como una clase.

#### Generalización o especialización

Permite reflejar el hehco de que hya una clase de objetos general que s epeude
llamar superclase que s epuede especializar en entidades subclase, algo así
como la herencia de clases en lenguajes de programación como C++ o Python, de
forma que la superclase representa las características comunes de todas las
subclases y las subclases representan las características propias de las
especializaciones.

### Diseño lógico: transformación al modelo relacional

Para poder aplicar las transformaciones el modelo de partida debe de cumplir
ciertos requisitos, siendo estos que todas las clases de objetos no
asociatinvas ni subclases deben de tener restricciones de clave externa y que
todos los atributos han de ser univalorados. En caso de que alguno de estos
requisitos no se cumpla hay que transformar el modelo de forma que se cumpla
añadiendo atributos con restricciones de clave exte: transformación al modelo
relacional

Para poder aplicar las transformaciones el modelo de partida debe de cumplir
ciertos requisitos, siendo estos que todas las clases de objetos no
asociatinvas ni subclases deben de tener restricciones de clave externa y que
todos los atributos han de ser univalorados. En caso de que alguno de estos
requisitos no se cumpla hay que transformar el modelo de forma que se cumpla
añadiendo atributos con restricciones de clave externa y/o transformando los
atributos multivalorados en asociaciones.
