#  OLTP y OLAP

## 1. ¿Qué es OLTP?

**OLTP (Online Transaction Processing)** significa *Procesamiento de Transacciones en Línea*.

Es un sistema diseñado para registrar, procesar y administrar las operaciones diarias de una organización en tiempo real.

Su objetivo principal es garantizar que las transacciones se ejecuten correctamente, de manera rápida, segura y confiable.

### Ejemplo práctico

Imaginemos que tenemos un supermercado.

Cuando un cliente compra productos:

1. El cajero registra los productos.
2. El sistema calcula el total de la compra.
3. Se registra el pago.
4. Se actualiza el inventario.
5. Se almacena la información de la venta.

Todas estas operaciones son transacciones que deben ejecutarse correctamente.

Por ejemplo, si un cliente compra una unidad de un producto, el sistema debe registrar la venta y descontar esa unidad del inventario.

### Características principales de OLTP

- **Operaciones frecuentes:** recibe muchas transacciones durante el día.
- **Tiempo real:** procesa operaciones a medida que ocurren.
- **Consultas rápidas:** generalmente trabaja con operaciones pequeñas y específicas.
- **Integridad de los datos:** debe garantizar que la información sea correcta.
- **Alta concurrencia:** muchos usuarios pueden realizar operaciones simultáneamente.
- **Transacciones ACID:** busca garantizar la confiabilidad de las operaciones.

### ¿Qué operaciones realiza?

| Operación | Descripción | Ejemplo |
|---|---|---|
| INSERT | Insertar información | Registrar una venta. |
| UPDATE | Actualizar información | Modificar el inventario. |
| DELETE | Eliminar información | Eliminar un registro autorizado. |
| SELECT | Consultar información | Consultar los datos de un cliente. |

---

## 2. ¿Qué son las transacciones ACID?

Este concepto es muy importante cuando estudiamos OLTP.

ACID representa cuatro propiedades que ayudan a garantizar la confiabilidad de las transacciones en una base de datos.

| Propiedad | Significado | Explicación |
|---|---|---|
| Atomicity | Atomicidad | Una transacción se completa totalmente o no se aplica. |
| Consistency | Consistencia | La transacción mantiene las reglas e integridad de los datos. |
| Isolation | Aislamiento | Las transacciones concurrentes no deben interferir incorrectamente entre sí. |
| Durability | Durabilidad | Una vez confirmada, la transacción debe permanecer guardada. |

### Ejemplo: transferencia bancaria

Imagina que una persona transfiere $100.000 de una cuenta a otra.

La operación tiene dos acciones:

1. Descontar $100.000 de la cuenta A.
2. Agregar $100.000 a la cuenta B.

Si el sistema descuenta el dinero de la cuenta A, pero ocurre un error antes de agregarlo a la cuenta B, la operación quedaría incompleta.

Gracias a las propiedades ACID, el sistema puede revertir la transacción para evitar que el dinero desaparezca.

---

## 3. ¿Qué es OLAP?

**OLAP (Online Analytical Processing)** significa *Procesamiento Analítico en Línea*.

Es un sistema diseñado para analizar grandes cantidades de información y obtener datos útiles para la toma de decisiones.

A diferencia de OLTP, su objetivo principal no es registrar las operaciones diarias, sino analizar información histórica y encontrar patrones, tendencias y comportamientos.

### Ejemplo práctico

Continuemos con el supermercado.

La gerencia quiere conocer:

- ¿Cuáles fueron los productos más vendidos durante el año?
- ¿Qué mes tuvo mayores ventas?
- ¿Qué sucursal generó más ingresos?
- ¿Cómo se comportaron las ventas durante los últimos cinco años?
- ¿Qué productos tienen menor demanda?

Para responder estas preguntas, el sistema debe consultar y analizar grandes cantidades de información.

Este tipo de trabajo corresponde a OLAP.

### Características principales de OLAP

- **Análisis de grandes volúmenes:** trabaja con cantidades importantes de información.
- **Datos históricos:** utiliza información almacenada durante meses o años.
- **Consultas complejas:** combina diferentes tablas y dimensiones.
- **Análisis multidimensional:** permite analizar información desde diferentes perspectivas.
- **Toma de decisiones:** ayuda a identificar tendencias y oportunidades.
- **Lectura intensiva:** generalmente realiza más consultas de lectura que operaciones de escritura.

### Ejemplos de análisis OLAP

| Análisis | Pregunta que permite responder |
|---|---|
| Por tiempo | ¿Cuánto vendimos durante 2025? |
| Por producto | ¿Cuál fue el producto más vendido? |
| Por ubicación | ¿Qué ciudad generó más ingresos? |
| Por sucursal | ¿Qué sucursal tuvo mejores resultados? |
| Por categoría | ¿Qué categoría produjo mayores ganancias? |

---

## 4. Diferencias entre OLTP y OLAP

Aunque ambos trabajan con bases de datos, tienen objetivos diferentes.

| Característica | OLTP | OLAP |
|---|---|---|
| Objetivo | Registrar operaciones | Analizar información |
| Tipo de datos | Actuales y operativos | Históricos y consolidados |
| Operaciones | INSERT, UPDATE, DELETE, SELECT | Principalmente SELECT |
| Consultas | Simples y rápidas | Complejas |
| Usuarios | Empleados, clientes, aplicaciones | Analistas, gerentes, directivos |
| Volumen por consulta | Generalmente pequeño | Puede ser muy grande |
| Frecuencia | Muchas transacciones | Consultas analíticas |
| Diseño | Optimizado para transacciones | Optimizado para análisis |

### Forma sencilla de recordarlo

- **OLTP:** registrar lo que está sucediendo.
- **OLAP:** analizar lo que ha sucedido.

---

## 5. ¿Qué es un Data Warehouse?

Para comprender OLAP, necesitamos conocer otro concepto: **Data Warehouse (almacén de datos)**.

Un Data Warehouse es un repositorio centralizado que almacena información procedente de diferentes fuentes para facilitar su análisis y la toma de decisiones.

Por ejemplo, una empresa puede tener información en diferentes sistemas:

- Sistema de ventas.
- Sistema de inventario.
- Sistema de clientes.
- Sistema de contabilidad.

El Data Warehouse permite integrar información de estos sistemas para realizar análisis generales del negocio.

### ¿Cómo funciona?

Generalmente, el proceso sigue estos pasos:

1. **Extracción:** se obtiene información de diferentes fuentes.
2. **Transformación:** se limpia, organiza y adapta la información.
3. **Carga:** se almacena en el Data Warehouse.
4. **Análisis:** se realizan consultas, reportes y análisis.

Este proceso se conoce como **ETL (Extract, Transform, Load)**.

### Las tres etapas de ETL

| Etapa | Nombre | Descripción |
|---|---|---|
| 1 | Extract | Extraer información de diferentes fuentes. |
| 2 | Transform | Limpiar, validar y transformar los datos. |
| 3 | Load | Cargar los datos en el Data Warehouse. |

**Importante:** OLAP es el enfoque de procesamiento analítico, mientras que Data Warehouse es una estructura de almacenamiento que frecuentemente lo soporta. No son lo mismo.

---

## 6. ¿Qué es un modelo multidimensional?

En OLAP, la información puede analizarse desde diferentes perspectivas o dimensiones.

Imaginemos que una empresa quiere analizar sus ventas.

Puede analizar la información por:

- Tiempo: día, mes, trimestre o año.
- Producto: nombre o categoría.
- Ubicación: ciudad o país.
- Cliente: tipo de cliente o segmento.

Estas perspectivas se conocen como **dimensiones**.

También existen las **medidas**, que son los valores numéricos que queremos analizar.

Por ejemplo:

- Total de ventas.
- Cantidad de productos vendidos.
- Ingresos.
- Ganancias.

### Ejemplo

| Año | Ciudad | Producto | Total ventas |
|---|---|---|---:|
| 2024 | Bogotá | Computador | 50 |
| 2024 | Medellín | Computador | 30 |
| 2025 | Bogotá | Computador | 80 |
| 2025 | Medellín | Computador | 45 |

Con esta información podemos responder preguntas como:

- ¿Cuántos computadores se vendieron en 2025?
- ¿Qué ciudad vendió más?
- ¿Cómo evolucionaron las ventas entre 2024 y 2025?

Esto es análisis multidimensional.

---

## 7. ¿Qué es un esquema estrella (Star Schema)?

Es uno de los modelos de diseño más utilizados en Data Warehouses.

Se caracteriza por tener una tabla central llamada **tabla de hechos (Fact Table)** y varias tablas relacionadas llamadas **tablas de dimensiones (Dimension Tables)**.

### 7.1. Tabla de hechos (Fact Table)

Almacena los eventos o registros que queremos analizar, junto con sus medidas y referencias a las dimensiones.

Ejemplo: `fact_ventas`.

| id_fecha | id_producto | id_ciudad | cantidad | total_venta |
|---|---|---|---:|---:|
| 1 | 10 | 5 | 2 | 3000000 |
| 2 | 11 | 6 | 1 | 1500000 |

### 7.2. Tablas de dimensiones (Dimension Tables)

Contienen información descriptiva que permite clasificar y analizar los hechos.

Ejemplos:

- `dim_fecha`
- `dim_producto`
- `dim_ciudad`

La estructura permite consultar las ventas por producto, ciudad, fecha y otras perspectivas.

### Diferencia importante

- La tabla de hechos contiene medidas y referencias.
- Las tablas de dimensiones contienen información descriptiva.

---

## 8. ¿Qué relación tienen OLTP y OLAP con un DBA?

Un DBA debe conocer ambos enfoques porque administrar una base de datos transaccional no es exactamente lo mismo que administrar una plataforma analítica.

### 8.1. Responsabilidades en OLTP

- Garantizar la disponibilidad del sistema.
- Administrar conexiones concurrentes.
- Optimizar consultas transaccionales.
- Gestionar índices.
- Controlar bloqueos y concurrencia.
- Garantizar la integridad de los datos.
- Administrar respaldos y recuperación.

### 8.2. Responsabilidades en OLAP

- Administrar grandes volúmenes de información.
- Optimizar consultas analíticas.
- Gestionar almacenamiento.
- Mejorar el rendimiento de consultas complejas.
- Administrar procesos de carga de información.
- Monitorear procesos ETL.
- Garantizar la calidad y consistencia de los datos.

---

## 9. Ejemplo práctico: OLTP y OLAP en una empresa

Imaginemos nuevamente un supermercado.

| Situación | Tipo de sistema |
|---|---|
| Registrar una venta | OLTP |
| Actualizar el inventario | OLTP |
| Registrar un nuevo cliente | OLTP |
| Consultar el total de ventas del año | OLAP |
| Comparar las ventas entre sucursales | OLAP |
| Identificar los productos más vendidos | OLAP |
| Analizar las ganancias de los últimos cinco años | OLAP |

Una misma empresa puede utilizar ambos sistemas.

El sistema OLTP registra las operaciones diarias y posteriormente esa información puede integrarse en un Data Warehouse para realizar análisis OLAP.

---

## 10. Resumen general

| Concepto | Definición |
|---|---|
| OLTP | Procesamiento de transacciones en línea. |
| OLAP | Procesamiento analítico en línea. |
| ACID | Propiedades que garantizan la confiabilidad de las transacciones. |
| Data Warehouse | Repositorio centralizado de información para análisis. |
| ETL | Proceso de extracción, transformación y carga de datos. |
| Fact Table | Tabla que almacena hechos, medidas y referencias. |
| Dimension Table | Tabla que almacena información descriptiva. |
| Star Schema | Modelo con una tabla de hechos central y dimensiones relacionadas. |

---

## 11. Preguntas de repaso

Intenta responderlas sin consultar los apuntes.

1. ¿Qué significa OLTP?
2. ¿Cuál es el objetivo principal de un sistema OLTP?
3. ¿Qué significa OLAP?
4. ¿Cuál es la principal diferencia entre OLTP y OLAP?
5. ¿Qué son las propiedades ACID?
6. ¿Por qué es importante ACID en las transacciones bancarias?
7. ¿Qué es un Data Warehouse?
8. ¿Qué significa ETL y cuáles son sus tres etapas?
9. ¿Qué son las dimensiones en un modelo multidimensional?
10. ¿Qué diferencia existe entre una tabla de hechos y una tabla de dimensiones?
11. ¿Qué es un esquema estrella?
12. ¿Por qué un DBA debe conocer OLTP y OLAP?

---
