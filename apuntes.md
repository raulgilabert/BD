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

    La arquitectura ANSI/SPARC está oriendada a la obtención de la
    independencia física y lógica de los datos:
    - Nivel interno: almacenamiento de los datos.
    - Nivel conceptual: estrcutura de la base de datos para toda la comunidad
      de usuarios.
    - Nivel externo: Diferentes visiones de los diferentes tipos de usuario o
      aplicación que usen la base de datos.

    La relación entre el nivel interno y conceptual define la independencia
    física.

    La relación entre el nivel conceptual y externo define la independencia
    lógica.

    Esquema conceptual: Tiene la descripción de

    (Revisar presentación después) (se me ha olvidado)

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

