# Taller Final – Parte 1, Sesión 1
## Modelo, datos y consultas básicas

**Asignatura:** Teoría de Bases de Datos  
**Docente:** Armando Ricardo Medina Nieto  
**Grupo:** A3  

### Integrante

- Wilmer Andrés Capera Hernandez

**Programa académico:** Ingeniería de Software  
**Universidad:** Universidad Manuela Beltrán  
**Fecha:** 29 de octubre de 2026

---

## 1. Descripción del proyecto

Este proyecto corresponde al Taller Final, Parte 1, Sesión 1, de la asignatura Teoría de Bases de Datos. Su propósito es diseñar e implementar una base de datos relacional para gestionar información relacionada con categorías, clientes, productos, pedidos, detalles de pedidos, históricos de precios y auditoría de pedidos.

El proyecto utiliza PostgreSQL como sistema gestor de bases de datos y aplica conceptos fundamentales del modelo relacional, definición de estructuras mediante SQL, integridad referencial y consultas básicas para la manipulación y recuperación de información.

## 2. Objetivos

### Objetivo general

Diseñar e implementar una base de datos relacional que permita organizar y administrar información de productos, clientes y pedidos mediante PostgreSQL, aplicando los fundamentos teóricos y prácticos de las bases de datos.

### Objetivos específicos

- Definir las tablas y sus atributos de acuerdo con los requisitos del sistema.
- Establecer claves primarias y foráneas para garantizar la integridad referencial.
- Implementar relaciones entre las entidades del modelo.
- Definir restricciones para mantener la consistencia de los datos.
- Preparar la estructura para insertar, actualizar, eliminar y consultar información.
- Elaborar el modelo relacional mediante una herramienta de diagramación.

## 3. Tecnologías y herramientas

- **PostgreSQL:** sistema gestor de bases de datos relacionales.
- **SQL:** lenguaje utilizado para definir y manipular los datos.
- **DBML:** lenguaje empleado para representar el modelo relacional en dbdiagram.io.
- **dbdiagram.io:** herramienta en línea para generar y visualizar el diagrama de la base de datos.

## 4. Modelo relacional

La base de datos está compuesta por siete tablas relacionadas entre sí mediante claves primarias y foráneas.

| Tabla | Descripción |
|---|---|
| `CATEGORIA` | Almacena las categorías de los productos. |
| `CLIENTE` | Registra la información de los clientes. |
| `PRODUCTO` | Contiene los productos, sus precios, existencias y categoría asociada. |
| `PEDIDO` | Registra los pedidos realizados por los clientes. |
| `DETALLE_PEDIDO` | Relaciona los pedidos con los productos e indica las cantidades y precios unitarios. |
| `HISTORICO_PRECIOS` | Registra los cambios de precio de los productos. |
| `AUDITORIA_PEDIDOS` | Almacena eventos de auditoría asociados a los pedidos. |

### Relaciones principales

- Una categoría puede estar asociada con varios productos.
- Un cliente puede tener varios pedidos.
- Un pedido puede contener varios productos mediante `DETALLE_PEDIDO`.
- Un producto puede aparecer en varios detalles de pedido.
- Un producto puede tener varios registros históricos de precios.
- Un pedido puede tener varios registros de auditoría.

La tabla `DETALLE_PEDIDO` utiliza una clave primaria compuesta por `id_pedido` e `id_producto`, lo que permite identificar cada producto dentro de un pedido.

Las claves foráneas de `PRODUCTO` y `PEDIDO` que hacen referencia a `CATEGORIA` y `CLIENTE`, respectivamente, admiten valores nulos, de acuerdo con la definición original del esquema SQL.

## 5. Estructura del proyecto

La organización sugerida para los archivos del proyecto es la siguiente:

```text
taller-final-bases-de-datos/
├── README.md
├── 01_ddl.sql
├── 02_dml.sql
├── 03_consultas.sql
└── modelo_relacional.png
```

**Descripción de los archivos:**

- `README.md`: documentación general del proyecto.
- `01_ddl.sql`: creación de las tablas, claves y restricciones.
- `02_dml.sql`: inserción y manipulación de datos de prueba.
- `03_consultas.sql`: consultas SQL básicas para recuperar información.
- `modelo_relacional.png`: representación visual del modelo relacional.

Los nombres de los archivos de datos y consultas son sugeridos; pueden ajustarse a los nombres reales de los archivos entregados.

## 6. Requisitos previos

Para ejecutar el proyecto se requiere:

- PostgreSQL 10 o superior.
- Una herramienta de administración de PostgreSQL, como pgAdmin, o acceso a `psql`.
- Los scripts SQL correspondientes al proyecto.

## 7. Instalación y ejecución

### Paso 1. Crear la base de datos

Desde pgAdmin o mediante `psql`, crea una base de datos para el taller. Por ejemplo:

```sql
CREATE DATABASE taller_bases_datos;
```

Conéctate a la base de datos recién creada antes de ejecutar los scripts.

### Paso 2. Crear las tablas

Ejecuta el archivo `01_ddl.sql`. Este script crea las siete tablas y establece las claves primarias y foráneas correspondientes.

```bash
psql -U postgres -d taller_bases_datos -f 01_ddl.sql
```

### Paso 3. Insertar los datos

Si el proyecto incluye un archivo de inserción de datos, ejecútalo después de crear las tablas:

```bash
psql -U postgres -d taller_bases_datos -f 02_dml.sql
```

Los registros deben insertarse respetando las dependencias entre las tablas y las restricciones de integridad referencial.

### Paso 4. Ejecutar las consultas

Para ejecutar las consultas básicas, utiliza:

```bash
psql -U postgres -d taller_bases_datos -f 03_consultas.sql
```

También puedes abrir los archivos SQL desde pgAdmin y ejecutarlos mediante el editor de consultas.

> **Nota:** los comandos anteriores son ejemplos. Es necesario contar con los archivos correspondientes y adaptar el usuario y los nombres según la configuración local.

## 8. Conceptos de bases de datos aplicados

Durante el desarrollo del proyecto se aplican los siguientes conceptos:

- **Modelo relacional:** organización de los datos en tablas relacionadas.
- **Clave primaria (PK):** identificación única de los registros.
- **Clave foránea (FK):** establecimiento de relaciones entre tablas.
- **Clave primaria compuesta:** identificación de registros mediante más de una columna.
- **Restricción `NOT NULL`:** obligatoriedad de determinados atributos.
- **Restricción `UNIQUE`:** prevención de valores duplicados en columnas sujetas a esta restricción.
- **Valores predeterminados (`DEFAULT`):** asignación automática de valores cuando no se especifican.
- **Integridad referencial:** mantenimiento de la coherencia entre las tablas relacionadas.
- **Consultas SQL:** recuperación y análisis de información almacenada.

## 9. Resultados esperados

Al ejecutar correctamente los scripts, se espera disponer de una base de datos funcional con las siete tablas definidas, sus relaciones y restricciones correspondientes.

La estructura permitirá almacenar información de clientes, categorías, productos y pedidos, además de registrar detalles de compra, cambios históricos de precios y eventos de auditoría. Sobre esta estructura podrán realizarse consultas para verificar y analizar la información registrada.

## 10. Conclusiones

El desarrollo de este taller permite aplicar los fundamentos del diseño de bases de datos relacionales mediante la definición de entidades, atributos, claves y relaciones. Asimismo, fortalece el manejo de SQL en PostgreSQL y la comprensión de los mecanismos que contribuyen a mantener la integridad y consistencia de la información.

La documentación del esquema y su representación gráfica facilitan la comprensión de la estructura de la base de datos, su implementación y su posterior mantenimiento.

---

**Universidad Manuela Beltrán**  
Ingeniería de Software  
Asignatura: Teoría de Bases de Datos  
Grupo A3 – 2026
