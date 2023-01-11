# BD lab

## SQL

### Crear tabla

```SQL
CREATE TABLE <nombre>
    (<nombre columna> <tipo datos> [<restricciones>] [<valor por defecto>] [,
    <nombre columna> <tipo datos> [<restricciones>] [<valor por defecto>] ...
    ]
	[<restricciones tabla>]);
```

Tipos de datos:
- INTEGER
- FLOAT(precisión)
- REAL
- CHAR(N)
- NUMERIC(precisión, escala)
- DECIMAL(precisión, escala)
- SMALLINT
- DOUBLE PRECISION
- VARCHAR(n)
- DATE
- etc.

Valor por defecto:

```SQL
DEFAULT {<literal> | NULL},
```


## PL/pgSQL

### Funciones

```SQL
CREATE FUNCTION nom_proc (param_entrada tipo) RETURNS tipo_retorno AS $$
    ...
    RETURN valor_retorno;
END;
$$LANGUAGE plpgsql
```

Para devolver varios valores


```SQL
CREATE FUNCTION nom_proc (param_entrada tipo) RETURNS SETOF tipo_retorno AS $$
    ...
    RETURN NEXT valor_1_retorno;
END;
$$LANGUAGE plpgsql
```

Se pueden declarar variables dentro del espacio `DECLARE` y se puede usar
`columna%TYPE` para declarar una variable como el tipo de una columna de una
tabla.

Se puede crear un nuevo tipo usando 

```SQL
CREATE TYPE nuevo_tipo AS (
    nombre tipo,
    nombre tipo,
    ...
);
```

Se pueden asignar valores usado `SELECT valor INTO variable` y también `:=`

Hay condicionales con

```SLQ
IF condición THEN sentencias
ELSEIF condición THEN sentencias
ELSE sentencias
END IF;
```

Variable `FOUND`

Se pone a true si en un `SELECT ... INTO` saca algún valor. en INSERT, UPDATE o
DELETE se pone a true si ha modificado algo

Bucles

```SQL
FOR target IN query
LOOP

END LOOP
```

```SQL
WHILE condición

LOOP

END LOOP
```

Gestión de errores

Cuando se produce un error dentro de un proceso se puede o no capturarlo o
capturarlo y tratarlo

1. Se retorna una excepción para el programador en un nivel superior
2. 


```SQL
EXCEPTION -- tratamiento

RAISE EXCEPTION -- Crear excepción
```




