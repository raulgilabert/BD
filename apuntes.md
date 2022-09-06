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

    (Revisar presentación después)
