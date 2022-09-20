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
