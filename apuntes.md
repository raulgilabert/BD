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

## Procedimientos en PL/pgSQL

PL/pgSQL es un lenguaje que ofrece PostfreSQL para implementar procesos
almacenados en la base de datos. Estas sentencias de iusan dentro del cuerpo
del procedimiento, es decir, entre las sentencias `CREATE FUNCTION` y `END` de
esta función.

El lenguaje ofrece dos tipos de sentencias:

- Sentencias `DECLARE` para definir y asignar valores a variables.

- Sentencias de control de flujo como los `IF`, `LOOP`, `FOR`, `WHILE`,
  `EXCEPTION`  y `RAISE EXCEPTION`.

Estas funciones cuando se llaman pueden devolver valores, tanto uno único como
un conjunto de estos. Esto se declara al momento de crear la función en la
sentencia `CREATE FUNCTION` donde, después de darle el nombre a la función y
marcar los parámetros de entrada con su tipo (primero el nombre y después el
tipo) se escribe un `RETURNS` y después de esto el tipo del dato que se
devuelve. En caso de no devolver nada el tipo que se devuelve tiene que estar
marcado como `void`. En caso de devolver múltiples datos después del `RETURNS`
y antes del tipo del dato que se devuelve se tiene que escribir un `SETOF`, de
forma que queda un `RETURNS SETOF`.

Para devolver los valores se usa `RETURN` y en caso de estar en una función
declarada con un `RETURNS SETOF` habrá que usar un `RETURN NEXT`. En caso de
que se esté devolviendo un conjutno de tuplas y no una sola si se ejecuta un
`RETURN` sin el `NEXT` se interpreta como el final del procedimiento. Esto
también se interpreta en caso de llegar al final de este.

### Variables

Las variables al almacenarse en memoria volátil no son consideradas objetos de
la base de datos, además qiue son locales del procedimiento en el que han sido
declaradas. El tipo de la variable se puede declarar tanto de forma explícita
como enlazándola al tipo de datos de una determinada columna de una tabla a
partir de la cláusula `TYPE`

Estas variables se pueden usar dentro de sentencias SQL o dentro de sentencias
de PL/pgSQL para asignar valores dentro de estas, calcular valores o controlar
el flujo de ejecución de un procedimiento.

Además en algunos casos puede venir bien definir nuevos tipos de datos como si
fueran un `struct` de C. con la sentencia `CREATE TYPE (nombre) as (...);` esto
permite que a la hora de devolver datos de un procedimiento se puede hacer con
un conjunto de distintos tipos de datos.

Para asignar valores a las variables se puede hacer con una sentencia de
asignación del propio lenguaje que tiene la sintaxis `(nombre) := (valor);`,
con una sentencia `SELECT ... INTO` o asignando la variable del retorno de otro
procedimiento usando cualquiera de los dos métodos antes mencionados.

## Condicionales

Los condicionales en PL/pgSQL tienen la sintaxis siguiente

```SQL
IF condición THEN
	...
ELSEIF condición THEN
	...
ELSE
	...
END IF;
```

Además dentro de cada procedimiento hay una variable implícita a este que es
`FOUND`. Esta en un principio tiene como valor False. Se pone a True en una
sentencia `SELECT ... INTO` si esta ha obtenido una fila o False si no. En un
sentencia `UPDATE`, `INSERT` o `DELETE` se pone a True si se ha modificado una
fila como mínimo o a False si no. En una sentencia `FOR` se pone a True al
acabar si se ha iterado mínimo una vez, si no se pone a False.

## Sentencias iterativas

La sentencia `FOR` se usa para iterar sobre un conjunto de tuplas recibidas por
una consulta SQL con un

```SQL
FOR target IN query
LOOP
	...
END LOOP;
```

Y también para iterar si se sabe a priori el número de iteraciones:

```SQL
FOR name IN expression .. expression
LOOP
	...
END LOOP;
```

Las sentencias `WHILE` y `LOOP` se usan para definir bucles para cuando su
terminación depende de una expresión condicional, usándose de la siguiente
forma:

```SQL
LOOP
	...
	EXIT WHEN expression;
	...
END LOOP;
```

```SQL
WHILE expression
LOOP 
	...
END LOOP;
```

### Manejo de errores

Con la sentencia `RAISE EXCEPTION` se puede lanzar una excepción dentro del
código del procedimiento y se pueden no tratar, provocando la interrupción del
código o tratarlas dentro del bloque `EXCEPTION` usando el conjunto de
sentencias

```SQL
	EXCEPTION
		WHEN raise_exception THEN
			tratamiento
		WHEN más_excepciones THEN
			tratamiento
		WHEN OTHERS THEN
			tratamiento
```

## Triggers

Un trigger es una sentencia que se ejecuta  en una situación determinada y que
hace que se trate un procedimiento.

Se declaran con la siguiente sintáxis:

`CREATE TRIGGER nombre {BEFORE | AFTER} {suceso [OR ...]} ON tabla [FOR [EACH] {ROW | STATEMENT}] EXECUTE PROCEDURE función`

De esta manera se pueden definir 4 casos por orden de ejecución y visibilidad
de datos:

1. `BEFORE STATEMENT`
	La acción se ejecuta 1 vez antes de la ejecución de la sentencia que
	ejecuta el trigger

2. `BEFORE ROW`
	la acción se ejecuta 1 vez antes de cada cambio de fila.

3. `AFTER STATEMENT`
	La acción se ejecuta 1 vez al final de la ejecución de la sentencia y
	con los valores cambiados.

4. `AFTER ROW`
	La acción se ejecuta 1 vez después de cada cambio de fila.

El procedimiento que se usa para los triggers no recibe ningún parámetro y
tiene que devolver un tipo `trigger`, de forma que el `RETURN` es sí o sí o
`NULL`, `NEW` u `OLD`.

De esta forma tenemos diferentes variables a las que podemos acceder dentro de
los procedimientos: `TG_OP` contiene el nombre de la sentencia que ha lanzado
el trigger. También están `NEW` y `OLD` que tienen valor para sentencias `FOR
EACH ROW` y son `NULL` para sentencia `FOR EACH STATEMENT`. De esta forma `NEW`
contiene el valor que se asigna y no tiene valor en sentencias `DELETE`. `OLD`
contiene el valor de la fila previo a la asignación y no tiene valor en
sentencias `INSERT`.

Con las variables `NEW` y `OLD` se tiene el control del resultado del trigger a
partir del `RETURN`, de forma que si se devuelve `NEW` se indica que el
procedimiento tiene que acabar normalmente y que la operación que dispara el
disparador se tiene que ejecutar. Si se modifica el valor de la variable NEW se
está modificando el valor que se va a colocar en la tabla con la ejecución de
esa sentencia. Si se devuelve `OLD` se indica la ejecución del procedimiento
para la fila actual y que la operación se tiene que ejecutar. En las sentencias
`UPDATE` si se devuelve `OLD` se indica que no se hace la modificación en la
tabla. En caso de devolver `NULL` se indica que la ejecución del procedimiento
tiene que acabar sin errores pero que la operación no se ejecuta.

Todo lo anteriormente dicho solo se puede hacer en sentencias `BEFORE ROW`, en
el resto el valor de retorno es ignorado y, por tanto, es mejor usar un `RETURN
NULL`.

La cosa es que en disparadores `BEFORE` se ejecuta este antes de la operación y
comprobar las restricciones. En los disparadores `AFTER` se hace después de
ejecutar la operacioón y comprobar las restricciones.

Para actualizar vistas se usa un trigger `INSTEAD OF`.

## Programación usando SQL

JDBC es una API que define los métodos para conectarse y acceder a bases de
datos remotas dentro de un programa escrito en Java. Estos métodos se
implementan en driver específicos para cada SGBD, siendo estos drivers un
conjunto de librerías que dependen del SGBD que implementan los métodos
definidos en la API. Hay dos tipos de drivers, los que son un puente a un
driver ODBC, teniendo que ser este específico para el SGBD al que se quiere
aceder y el otro tipo es el driver JDBC con una librería de implementación
proporcionada por el fabricante del SGBD. También están los drivers que
traducen a un protocolo del red que permite la comunicación con la base de
datos y, por último está el driver JDBC puero que da acceso al SGBD y es
específico de este.

Para registrar los drivers hay que usar `Class.forName("nombre");`. Después hay
que especficar ciertas propiedades como el nombre de usuario y la contraseña de
la siguiente forma:

```Java
Properties props = new Properties();
props.setProperty("user", "username");
props.setProperty("password", "password");
```


Después de esto hay que definir la conexión de la siguiente forma:

```Java
Connection c = DriverManager.getConnection("url", props);
```

Está la opción de decidir si activar o no el autocommit, que hace que al acabar
cada sentencia se ejecute un commit y no sea necesario ponerlo a mano. Esto se
hace con la sentencia `c.setAutoCommit(boolean)`, siendo `c` la clase
`Connection`. Para seleccionar el esquema hay que ejecutar la sentencia SQL
`SET SCHEMA nombre`

Para comunicarse con la base de datos se usan tanto `Statement` que compila la
sentencia SQL a cada ejecución y viene bien si se ejecuta esta pocas veces y
los `PreparedStatement` que se precompilan y permiten modificar ciertos datos
de estas pero aceleran la ejecución del código, por lo que es preferible
usarlos en casos donde la sentencia se vaya a ejecutar múltiples veces como
puede ser en un bucle.

Un `Statement` se declara usando la función `createStatement()` y se añade la
consulta con un `ResultSet executeQuery(String sql)`/`int executeUpdate(String
sql)`. En cambio con los `PreparedStatement` se declaran con
`prepareStatement(String sql)` y la ejecución se produce con `ResultSet
executeQuery()`/`int executeUpdate()`.

En los `PreparedStatement` los parámetros se especifican con un signo `?`
dentro del String que forma la sentencia. Para darle valores a estos parámetros
se usan los métodos `setString`, `setInt`, `setNull`.

Una vez que se tiene el resultado en un `ResultSet` con el método `next()` se
avanza a la siguiente fila que devuelve `true` en caso de que haya podido. Para
recibir los datos se usa el método `getXXX` con un int en caso de querer
acceder por la posición o con un Strign para acceder a partir del nombre de la
columna. Estos valores si se tratan de clases de Java se puede comprobara si
son `NULL` comparando con un `== null`. En caso de que no lo sea habría que
usar el método `wasNull()` de la clase `ResultSet`.

Una vez que s eha acabado el procesamiento de un `Statement` o un
`PreparedStatement` se tiene que cerrar usando el método `close()`, al igual
que con un `ResultSet`.

Una vez hechas todas las sentencias hay que cerrar la conexión haciendo antes
un `commit` o `rollback` usando los métodos con es enombre y finalmente
cerrar.

El manejo de excepciones se hace usando un `try-catch` y para obtener la
información del error en Java para tener el código de estado de SQL hay que
usar el método `getSQLState()` que en caso de dar `00000` es que todo ha ido
bien, `01XXX` si hay un aviso y >`02XXX` si hay un error grave que impide la
ejecución.





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

#### Clase de objetos

De esta manera cada clase de objetos se transforma en una relación, de forma
que la clave primaria será la clave externa de la clase de objeos y los
atributos de la relación serán los atributos de la clase de objetos.

#### Asociaciones binarias

##### Caso uno a muchos

La multiplicidad 0..1 o 1 en un extremo y * en el otro se tranforma en añadir
una clave externa a la relación que corresponde a la clase del extremo de
muchos de la asociación  y referenciar a la otra de la relación.

##### Claso uno a uno

A diferencia del anterior la referencia de un atributo de una clase a otroa
pude ser de cualquiera de una a la otra.

##### Caso muchos a muchos

En este caso donde la multiplicidad es * en ambos casos se tranforma definiendo
una nueva relación donde la clave primaria estará formada por los atributos de
la clave primaria de las relaciones corresponidentes a las clases de los dos
extremos de la asociación.

#### Asociaciones n-árias

Las asociaciones n-árias se transforman en una nueva relación que contiene los
atributos que forman la clave de las clases asociadas. Si todas las clases
están conectadas con * la clave primaria estará formada por todos los atributos
que forman las claves de las clases asociadas. Si, en cambio, las clases están
conectadas con un 1 la clave primaria de la nueva relación estará formada por
las claves de las clases excepto esta ya que solo habría un valor de esta y no
sería necesaria para identificar al objeto.

#### Asociaciones recursivas

Las asociaciones recursivas se transforman igla que el resto de asociaciones,
teniendo en cuenta si son binarias o n-arias, además de su multiplicidad y
aplicando las transformaciones correspondientes.

#### Transformaciones de clases asociativas

La transformación de la asociación es a la vez la transformación de la clase
asociativas, de forma que si la clase asociativa tiene atributos estos se
agregan como atributos de la relación correspondiente a la transformación.

#### Transformación de la generalización/especialización

Cada una de las clases de objetos que forman parte de una generalización se
transforma en una relación donde la relación correspondiente a la superclase
tiene como clave primaria la clave de la superclase y contiene todos los
atributos de esta y las relaciones correspondientes a las subclases tienen como
clave primaria la clave de la superclase y contienen los atributos específicos
de la subclase.

## Transacciones

Las transacciones cumplen las propiedades ACID:

- Atomicidad: Se ejecuta o todo o nada.
- Consistencia: Todos los datos deben cumplir ciertas condiciones tanto antes
  como después de las transacciones aunque en medio pueda no haber
  consistencia.
- Aislamiento: Las transacciones deben de ejecutarse como si estuvieran solas
  de forma que no deben de haber errores en este acceso concurrente de los
  datos.
- Definitividad: 

### Problemas del aislamiento

Al tener transacciones que accedan a los mismos datos a la vez se pueden
generar problemas en los que los datos puedan acabar siendo erróneos. Estos
problemas tienen el nombre de interferencias.

#### Actualización perdida

Cuando dos transacciones se producen a la vez y una operación de escritura se
pierde.

#### Lectura no confirmada

Se produce cuando una transacciones lee un dato que ha sido modificado por otra
transacción que después es abortada o vuelve a modificar el dato.

#### Lectura no repetible

Se produce cuando una transacción lee dos veces el mismo dato pero se dan
valores distintos porque entre medio de las dos lecturas otra transacción ha
modificado el dato.

#### Análisis inconsistente

Cuando una actualización de datos se produce antes de su lectura pero después
del inisio de la transacción desde otra distinta.

#### Fantasmas

Cuando una transacción lee primero unos datos y al volver a leer otros de la
misma tabla aparecen datos nuevos debido a un insert o update de otra
transacción.

### Serializabilidad
    
Define de manera precisa las condiciones para considerar que las transacciones
está aisladas entre sí de manera correcta.

La serializabilidad considera que las transacciones está formadas por acciones
que actúan sobre datos elementales llamados glánulos teniendo acciones de
lectura (R(G), RU(G)) i escritura (W(G)), siendo G el gránulo,es decir, la
unidad del dato controlado individualmente por el SGBD: página de disco,
tub¡pla, etc.

#### Operaciones

Un `SELECT` de SQL se traduce en un `R(G)`. Los `INSERT`, `UPDATE` y `DELETE`
se traducen en `RU(G)` que es una lectura con intención de modificación
posterior del gránulo y `W(G)` que es en sí la escritura del gránulo.

De esta maner,a la ejecución con currente de transacciones tiene el nombre de
horario. Un horaro serial es aquel en el que no hay encabalgamiento entre
transacciones. En horarios no seriales pueden hacer acciones conflictivas que
son aquellas que operan sobre el mismo gránulo en distintas transacciones
simultáneas.

De esta forma se ve que hay horarios seriezable que son esos no seriales pero
que las acciones conflictivas están colocadas de tal forma que no hay errores.

#### Recuperabilidad

Algunas interferencias se producen por la cancelaciónde una trnasacción. Esta
cancelación supone deshacer todos los cambios y recuperar los valores
anteriores del gránulo. Como la serializabilidad infonra la posibilidad de
cancelaciones habrá que exigir nuevas condiciones a la ejecución de las
transacciones, de forma que un horario cumple el criterio de recuperabilidad si
niguna transacción que escribe o lee en un gránulo escrito por otra transacción
confirma sin que antes lo haya hecho esta.

Se pueden resolver las interferencias entre transacciones de dos formas
distintas:

- Cancelando automáticamente las transacciones problemáticas y deshaciendo los
  cambios

- Suspendiendo la ejecución temporalmente y reponiéndola cuando desparezca el
  peligro de interferencia.

Con esto se puede definir el nivel de paralelismo en base al trabajo efectivo
realizado entre unidad de tiempo.

Un SGBD puede controlar las concurrencias con un sistema de reservado de
gránulos, puediend reservar de forma compartida (solo lectura) o exclusiva
(lectura y escritura) con las acciones`LOCK(G, m)` y `UNLOCK(G)`. Aun así si se
aborta una transacción se pueden seguir produciendo errores por lo que la
reserva se tiene que mantener hasta el final de las transacciones.

Si una de estas reservas no se puede conceder se suspende la ejecución de la
transacción a la espera de la liberación del gránulo para ejecutarla.

Aun así para conseguir el aislamiento de las transacciones estas tienen que
seguir ciertas normas a la hora de pedir y liberar reservas, de forma que se
tiene que seguir el protocolo de reserva en dos fasesque se produce si se
reserva un gránulo en la modalidad adecuada  antes de operar y nunca adquiere
una reserva de cualquier gránulo desde de liberar cualquier otro antes.

Esto aun así produce una sobrecarga en el SBGD y una bajada del nivel de
paralelismo. En determinadas operaciones es conveniente relajar el nivel de
aislamiento en el caso de que se sepa que estas interferencias no se
producirán o que no son importantes en caso de que sucedan.

Se hace con la instrucción SQL

```SQL
SET TRANSACTION modo
ISOLATION LEVEL nivel
```

Donde modo es `READ ONLY` o `READ WRITE` y nivel es `READ UNCOMMITTED`, `READ
COMMITED`, `REPEATABLE READ` o `SERIALIZABLE`.

- `READ UNCOMMITTED` protege los datos actualizados evitando una nueva
  actualización hasta que acabe la transacción.

  Reserva X hasta el final de la transacción sin reserva S para lectura.

- `READ COMMITED` proteje temporalmente las lecturas impidiendo la lectura de
  datos no confirmados.
  
  Rserva X hasta el final de la transacción y S hasta después de la lectura.

- `REPEATEBLE READ` impide que una transacción actualice datos que se han
  leídos desde otra.

  Reservas X i S hasta el final de la transacción.

- `SERIAZABLE` implide cualquier intereferencia

  Todas las reservas hasta el final de las transacciones incluyendo de
  información de control.

El SGBD tiene que evitar los abrazos mortales usando una de tres posibilidades:

- Prevenirlas antes de que sucedan.

- Detectarlas y resolverlas cuando sucedam.

- Definir un tiempo de espera máximo y cancelando la transacicón si se supera.

Estos abrazos mortales se detectan buscando ciclos en el grafo de espera que se
puede hacer siempre que una transacción pida una reserva y no la obtenga al
momento, cada cierto tiempo o cuando tenermos transacciones que tardan mucho en
acabar.

Una vez que se detecta hay que romper el ciclo cancelando una o diversas
transacciones.

### Recuperación

Se tiene que garantizar la atomicidad y definitividad de las transacciones, de
forma que no s epueden perder los cambios efectuados por transacciones
confirmadas y no se pueden guadar los de transacciones abortadas.

Hay dos formas de recuperación:

- Restauración: garantiza la atomicidad y definitividad antes cancelación de
  transacciones y caídas del sistema

- Reconstrucción: recuera el estado de la base de datos ante una pérdida total
  o parcial de la información almacenada en el disco en caso de fallos o
  desastres.

La restauración se hace a partir de un log que guarda la información de los
cambios pudiendo deshacer y rehacer.

La reconstrucción se hace con una copia de seguridad y el log desde esta copia.

## Almacenamiento y métodos de acceso

Laas ventajas de la memoria externa sobre la interna es el bajo precio de esta
en comparación con la interna, una capacidad virtualmente ilimitada y la no
volatilidad de los datos al perder la corriente pero tiene la desventaja de ser
mucho más lenta.

### Componentes que ayudan a guardar los datos en el disco

Estos componentes deben ser estándar.

#### Nivel físico

Los datos se almacenan en discos duros controlados por el sistema operativo que
es quién ejecuta las lecturas y escrituras de los archivos aunque es el SGBD el
que decide qué hay que leer específicamente.

Estos datos están guardados en formato de páginas, siendo estas la medida
estándar para controlar el guardado y lectura de datos con una estructura
física de un tamaño determinado.

Una página consiste en una cabecera (header) al inicio de la página y después
filas de datos. Al final hay un vector de direcciones de las filas. Las filas
están ordenadas en orden ascendente y el vector en orden descendente.


Cada fila contiene una cabecera que tiene la información de la longitud de la
fila y el identificador de la tabla a la que pertenece. Además contiene todos
los campos de datos.

Cada campo tiene también una cabecera que dice si el campo es NULL o NOT NULL y
la longitud del campo. Si este campo es de una longitud fija y es NOT NULL no
tiene cabecera.

##### Gestión de la página

Empieza formateando la página y hace una carga inicial de las filas, yendo la
primera después de la cabecera la segunda después de la primera, etc. Esto
siempre dejando un porcentaje del espacio libre.

La carga posterior de una nueva fila empieza localizando la página en la que se
va a guardar y se usa el espacio libre.

La bajada de una fila libera el espacio ocupado y reorganiza internamente la
página.

El cambio de longitud de filas se comporta de diferentes maneras dependiendo
del cambio: si disminuye se comporta de forma similar a la bajada de datos, si
aumenta y el espacio es suficiente solo desplaza las filas de la página y en
caso de que no tenga espacio se cambia el contenido de la fila por la nueva
dirección de esta en una página donde quepa.

### Métodos de acceso

Siempre que s elee o actualiza una base de datos se hace a través de
determinados métodos de acceso disponibles en el SGBD.

#### Acceso por posición

Permite acceder a una página con un número determinado y permite un acceso
secuencial. Este acceso tiene cierto coste dependiendo de si se hace uno
directo o secuencial. Un acceso directo tiene un coste de cargar una página del
SO y uno secuencial tiene el coste del número N de páginas que se quiere
acceder.

#### Acceso por valor

Permite un acceso directo a todas las filas con determinado valor y uno
secuancial con las filas por el orden de los valores de un atributo.

Para implementar estos accesos tanto por un valor como por múltiples hay que
hacerlo a partir de estructuras de datos auxiliares llamadas índices que
almacenan punteros a la información ordenados en base a determinados valores.

Se implementan a partir de Árboles B⁺

##### Árbol B⁺

Es un árbol de de altura fija donde todos los nodos intermedios están
representados en nodos inferiores.

Hay dos tipos de nodos que son internos y hojas.

EN un árbol de órden `d` los nodos contienen como mucho `2d` valores.

Todos los nodos están ordenados en un orden creciente.

Estos nodos internos tienen como objetivo dirigir la búsqueda de la información
que está almacenada en los nodos hoja finales con los punteros a la
información, además que los nodos hoja están conectados por punteros dobles
para permitir el movimiento entre ellos.

Cada nodo interno contiene valores y punteroa a los nodos hijos, teniendo estos
valores ordenados en un orden creciente.

Se puede mejorar el rendimiento de estos árboles teniendo todos los nodos
excepto la raíz como mínimo en un 50%, por ejemplo: en un árbol de orden d debe
de haber al menos d valores por nodo. Además todas las hojas tienen que estar
al mismo nivel para que el nombre de nodos a recorrer sea siempre el mismo.

El tamaño de los nodos depende del orden y el tamaño de los valores y punteros,
de forma que si los nodos son muy grandes un árbol tendrá pocos niveles pero
puede ser que tenga que hacer más de una operación I/O. En caso de que la raíz
esté en memoria habrá que hacer un acceo menos.

###### Índice agrupado

Un índice agrupado es aquel en el que los datos que se indexan están ordenados
físicamente en base al acceso secuencial por valor que proporciona este.

---

Para acceder mediante diversos valores se hace la estrategia de intersección
pero que puede ser ineficiente para casos donde haya muchos que cumplan una
condición y poco que la otra. De esta manera está la estrategia de índice
multiatributo donde estos índes en lugar de tener un único valor serán listas
de elementos que son estos multiatributos. Estos tienen una relación lineal en
el ordenamiento, de forma que se ordena en base al primero elemento, dentro de
estos por el segundo, ...

### Coste de acceso

#### Coste acceso secuencial por valor árbol B⁺ no agrupado

El coste es el coste de acceso al índice + coste de acceso al fichero de datos
= (h + F) + |R(a >= X)|

h = altura, F = nodos hoja adicionales, |R(a>=X)| nombre de filas de la tabla R
que cumplen la condición a >= X de la consulta.

Este coste puede disminuir en 1 unidad si la raíz está en memoria.

#### Coste acceso secuencial por valor árbol B⁺ agrupado

El coste h + D, siendo h la altura del árbol y D = |R(a>=X)|/f siendo f el
números de registros de la tabla por página (Tamaño de página / tamaño de
registro)

#### Coste de acceso directo por valor árbol B⁺ valores no repetidos

Tiene un coste h + 1

#### Coste acceso directo por valor árbol B⁺ no agrupado con posibilidad de
valores repetidos

Coste = (h + F) + |R(b=Y)|


