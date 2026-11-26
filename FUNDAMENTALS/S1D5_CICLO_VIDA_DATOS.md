# Ciclo de vida de los datos (Data Lifecycle)

## 1. ¿Qué es el ciclo de vida de los datos?

El ciclo de vida de los datos (*Data Lifecycle*) es el conjunto de etapas por las que pasan los datos desde que se generan hasta que dejan de ser necesarios y se eliminan o archivan.

Los datos no permanecen simplemente guardados en una base de datos. Durante su existencia pueden ser creados, almacenados, consultados, modificados, compartidos, archivados y finalmente eliminados.

**Ejemplo:**

Un cliente realiza una compra en un supermercado:

1. Se genera información sobre la compra.
2. La información se registra en una base de datos.
3. El sistema consulta los datos para mostrar la venta.
4. La información se utiliza para generar reportes.
5. Después de un tiempo, la venta puede trasladarse a un almacenamiento histórico.
6. Finalmente, los datos pueden eliminarse cuando termina su período de conservación y no existe obligación de mantenerlos.

## 2. Etapas del ciclo de vida de los datos

Para estudiar el tema desde el punto de vista de un DBA, utilizaremos seis etapas principales.

### 2.1. Creación o generación (Data Creation)

Es el momento en que los datos aparecen por primera vez.

Pueden generarse de diferentes maneras:

- Un usuario registra sus datos en un formulario.
- Un cliente realiza una compra.
- Un sistema recibe información de otra aplicación.
- Un dispositivo genera información automáticamente.
- Un proceso importa datos desde un archivo.

**Ejemplo SQL:**

Primero creamos una tabla de clientes:

```sql
CREATE TABLE clientes (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

Ahora registramos un cliente:

```sql
INSERT INTO clientes (nombre, email)
VALUES ('Carlos', 'carlos@email.com');
```

En este momento se están generando nuevos datos y registrándolos en la base de datos.

**Responsabilidades del DBA:**

- Diseñar estructuras para almacenar los datos.
- Definir tipos de datos adecuados.
- Establecer restricciones de integridad.
- Evitar registros incorrectos o duplicados mediante controles apropiados.

### 2.2. Almacenamiento (Data Storage)

Una vez generados, los datos deben guardarse en algún lugar para que puedan recuperarse posteriormente.

Pueden almacenarse en:

- Bases de datos relacionales: PostgreSQL, Oracle, MySQL y SQL Server.
- Bases de datos NoSQL: MongoDB y Cassandra.
- Archivos: CSV, JSON y XML.
- Servicios de almacenamiento en la nube.
- Data Warehouses.

**Ejemplo:**

La información de los clientes se almacena en una tabla llamada `clientes`.

Podemos consultar los registros:

```sql
SELECT *
FROM clientes;
```

También podemos consultar la cantidad de clientes registrados:

```sql
SELECT COUNT(*) AS total_clientes
FROM clientes;
```

**Responsabilidades del DBA:**

- Administrar el espacio de almacenamiento.
- Configurar las bases de datos.
- Supervisar el crecimiento de los datos.
- Administrar archivos y estructuras físicas.
- Configurar mecanismos de respaldo.

### 2.3. Uso y procesamiento (Data Usage)

En esta etapa los datos son consultados, modificados y utilizados por las aplicaciones o los usuarios.

Por ejemplo:

- Consultar información de clientes.
- Actualizar datos personales.
- Registrar ventas.
- Calcular inventarios.
- Generar reportes.
- Ejecutar procesos de negocio.

**Ejemplo SQL:**

Consultar todos los clientes:

```sql
SELECT *
FROM clientes;
```

Consultar un cliente específico:

```sql
SELECT nombre, email
FROM clientes
WHERE id = 1;
```

Actualizar su correo electrónico:

```sql
UPDATE clientes
SET email = 'carlos.nuevo@email.com'
WHERE id = 1;
```

**Responsabilidades del DBA:**

- Optimizar las consultas.
- Administrar índices.
- Supervisar el rendimiento.
- Controlar el acceso a los datos.
- Evitar operaciones que afecten la disponibilidad de la base de datos.

### 2.4. Compartición o distribución (Data Sharing)

Los datos pueden necesitar ser compartidos entre diferentes usuarios, sistemas o departamentos.

Por ejemplo, en una empresa:

- Ventas consulta información de clientes.
- Contabilidad consulta información de facturación.
- Gerencia consulta reportes de ventas.
- Otro sistema recibe información mediante una API.

No significa que todos deban tener acceso a toda la información.

**Ejemplo SQL:**

Podemos crear un usuario para el departamento de ventas:

```sql
CREATE ROLE usuario_ventas
LOGIN
PASSWORD 'CambiarEstaClave';
```

Le otorgamos permiso para consultar la tabla de clientes:

```sql
GRANT SELECT ON TABLE clientes TO usuario_ventas;
```

Si posteriormente necesita registrar clientes, podemos otorgarle también permiso de inserción:

```sql
GRANT INSERT ON TABLE clientes TO usuario_ventas;
```

Para consultar los permisos concedidos en PostgreSQL podemos utilizar:

```sql
SELECT grantee, privilege_type, table_name
FROM information_schema.role_table_grants
WHERE table_name = 'clientes';
```

**Responsabilidades del DBA:**

- Administrar usuarios y permisos.
- Controlar quién puede consultar o modificar información.
- Proteger los datos sensibles.
- Configurar mecanismos seguros de comunicación.
- Supervisar accesos y conexiones.

### 2.5. Archivo y conservación (Data Archiving)

Con el paso del tiempo, algunos datos dejan de utilizarse frecuentemente, pero todavía deben conservarse.

En lugar de mantener toda la información histórica en las tablas operativas principales, una organización puede trasladarla a un almacenamiento histórico.

**Ejemplo:**

Un supermercado necesita consultar frecuentemente las ventas del mes actual, pero las ventas de hace cinco años casi nunca se consultan.

Puede mantener:

- Ventas actuales en la base de datos operacional.
- Ventas antiguas en una tabla histórica o en un Data Warehouse.

Esto puede ayudar a reducir la carga de las bases de datos operacionales y facilitar el análisis histórico.

**Importante:** Archivar no significa eliminar. Los datos siguen existiendo y pueden recuperarse cuando sea necesario.

**Ejemplo SQL:**

Creamos una tabla de ventas:

```sql
CREATE TABLE ventas (
    id SERIAL PRIMARY KEY,
    cliente_id INTEGER,
    total NUMERIC(10,2),
    fecha_venta DATE NOT NULL
);
```

Creamos una tabla para conservar las ventas históricas:

```sql
CREATE TABLE ventas_historicas (
    id INTEGER PRIMARY KEY,
    cliente_id INTEGER,
    total NUMERIC(10,2),
    fecha_venta DATE NOT NULL
);
```

Supongamos que queremos archivar las ventas anteriores al año 2023.

Primero podemos consultar cuáles cumplen la condición:

```sql
SELECT *
FROM ventas
WHERE fecha_venta < DATE '2023-01-01';
```

Después podemos trasladarlas utilizando una transacción:

```sql
BEGIN;

INSERT INTO ventas_historicas (
    id,
    cliente_id,
    total,
    fecha_venta
)
SELECT
    id,
    cliente_id,
    total,
    fecha_venta
FROM ventas
WHERE fecha_venta < DATE '2023-01-01';

DELETE FROM ventas
WHERE fecha_venta < DATE '2023-01-01';

COMMIT;
```

La transacción permite ejecutar el traslado y la eliminación como una unidad de trabajo: si ocurre un error antes del `COMMIT`, se puede cancelar con `ROLLBACK`.

**Precauciones:**

- Verificar que los registros se hayan copiado correctamente.
- Revisar las claves foráneas y dependencias entre tablas.
- Comprobar que no existan registros duplicados en el destino.
- Realizar un respaldo antes de ejecutar operaciones importantes.
- Probar el procedimiento antes de aplicarlo en producción.

**Responsabilidades del DBA:**

- Definir estrategias de archivado.
- Verificar que los datos históricos estén completos.
- Mantener mecanismos para recuperar información.
- Garantizar la conservación durante el tiempo requerido.

### 2.6. Eliminación o destrucción (Data Deletion / Destruction)

Es la etapa en la que los datos dejan de ser necesarios y se eliminan de manera controlada.

Por ejemplo:

- Registros temporales que ya no se necesitan.
- Información duplicada cuya eliminación fue autorizada.
- Datos personales cuyo período de conservación terminó.
- Archivos que ya no tienen obligación de conservarse.

**Ejemplo SQL:**

Eliminar un cliente específico:

```sql
DELETE FROM clientes
WHERE id = 1;
```

Eliminar todos los registros de una tabla:

```sql
DELETE FROM clientes;
```

**Cuidado:** La segunda sentencia elimina todos los registros de la tabla. No debe ejecutarse sin verificar previamente que esa sea la operación deseada.

Podemos comprobar qué registros se eliminarían antes de ejecutar el `DELETE`:

```sql
SELECT *
FROM clientes
WHERE id = 1;
```

**Responsabilidades del DBA:**

- Ejecutar eliminaciones controladas.
- Evitar pérdidas accidentales.
- Respetar las políticas de conservación.
- Verificar las dependencias.
- Aplicar procedimientos seguros de eliminación.

**Importante:** Eliminar un registro de una tabla no garantiza que todas sus copias hayan desaparecido. Pueden existir respaldos, réplicas, exportaciones u otros sistemas que todavía contengan la información.

---

## 3. Resumen de las etapas

| Etapa | ¿Qué sucede? | Ejemplo |
|---|---|---|
| Creación | Se generan nuevos datos. | Registrar un cliente. |
| Almacenamiento | Se guardan los datos. | Insertar información en PostgreSQL. |
| Uso | Se consultan y procesan. | Consultar ventas. |
| Compartición | Se distribuyen entre usuarios o sistemas. | Dar acceso a contabilidad. |
| Archivo | Se conservan datos históricos. | Guardar ventas antiguas. |
| Eliminación | Se destruyen datos que ya no se necesitan. | Eliminar registros vencidos. |

## 4. ¿Qué relación tiene el ciclo de vida con el DBA?

El DBA participa en prácticamente todas las etapas del ciclo de vida.

Su responsabilidad no consiste solamente en crear bases de datos o solucionar errores. También debe garantizar que los datos estén disponibles, protegidos, íntegros y correctamente administrados durante toda su existencia.

| Responsabilidad | ¿Qué busca garantizar? |
|---|---|
| Diseño de bases de datos | Que los datos estén correctamente estructurados. |
| Almacenamiento | Que exista espacio y capacidad suficiente. |
| Rendimiento | Que las consultas y operaciones funcionen eficientemente. |
| Seguridad | Que solo usuarios autorizados accedan a los datos. |
| Integridad | Que la información sea consistente y confiable. |
| Backup | Que existan copias para recuperar información. |
| Recuperación | Que los datos puedan restaurarse ante fallos. |
| Archivado | Que la información histórica se conserve adecuadamente. |
| Eliminación | Que los datos se eliminen de forma controlada. |

## 5. Conceptos importantes relacionados

### 5.1. Backup (Respaldo)

Es una copia de los datos que permite recuperarlos cuando ocurre algún problema.

Por ejemplo, si una persona elimina accidentalmente una tabla importante, un respaldo puede permitir recuperar la información.

En PostgreSQL podemos utilizar:

- `pg_dump`: permite realizar respaldos lógicos de bases de datos.
- `pg_restore`: permite restaurar respaldos generados en formatos compatibles, como el formato personalizado.
- `pg_basebackup`: permite realizar respaldos físicos de una instancia PostgreSQL.

**Ejemplo de respaldo lógico:**

Desde la terminal del sistema operativo:

```bash
pg_dump -U postgres -d spring_demo -F c -f spring_demo.backup
```

Este comando genera un respaldo de la base de datos `spring_demo` en formato personalizado.

**Ejemplo de restauración:**

```bash
pg_restore -U postgres -d spring_demo_restaurada spring_demo.backup
```

La base de datos de destino debe existir previamente.

**Recuerda:**

- Backup: permite recuperar información ante fallos o pérdidas.
- Archivo: permite conservar información antigua que ya no se utiliza frecuentemente.

Un respaldo no sustituye una estrategia de archivado.

### 5.2. Recovery (Recuperación)

Es el proceso de recuperar una base de datos después de un fallo.

Ejemplos:

- Recuperar una base de datos después de un daño.
- Restaurar información eliminada accidentalmente.
- Recuperar una base de datos después de un fallo del servidor.

En PostgreSQL existen mecanismos como los respaldos físicos y los archivos WAL (*Write-Ahead Logging*) que permiten implementar estrategias de recuperación.

El WAL registra información sobre los cambios realizados en la base de datos y puede utilizarse junto con respaldos físicos para realizar recuperación a un punto en el tiempo (*Point-in-Time Recovery* o PITR).

### 5.3. Data Retention (Retención de datos)

Es el período durante el cual una organización debe conservar determinados datos.

Por ejemplo:

Una empresa puede establecer que determinados registros deben conservarse durante cinco años, dependiendo de sus obligaciones legales y políticas internas.

El DBA debe conocer estas políticas porque no puede eliminar información arbitrariamente.

**Ejemplo SQL:**

Consultar registros con más de cinco años:

```sql
SELECT *
FROM ventas
WHERE fecha_venta < CURRENT_DATE - INTERVAL '5 years';
```

Esta consulta identifica registros antiguos, pero no los elimina.

Una eliminación, si está autorizada, podría realizarse así:

```sql
DELETE FROM ventas
WHERE fecha_venta < CURRENT_DATE - INTERVAL '5 years';
```

Antes de ejecutarla deben verificarse las políticas de conservación, dependencias, respaldos y posibles obligaciones legales.

### 5.4. Data Governance (Gobernanza de datos)

Es el conjunto de políticas, reglas y responsabilidades que establecen cómo deben administrarse los datos dentro de una organización.

Incluye aspectos como:

- Quién es responsable de los datos.
- Quién puede acceder a ellos.
- Cómo deben protegerse.
- Cuánto tiempo deben conservarse.
- Cómo deben utilizarse.
- Cuándo pueden eliminarse.

La gobernanza de datos involucra a diferentes áreas de la organización, no solamente al DBA.

### 5.5. Data Security (Seguridad de datos)

Consiste en proteger los datos contra accesos no autorizados, modificaciones indebidas, pérdidas o divulgación de información.

Algunas medidas son:

- Usuarios y contraseñas.
- Roles y permisos.
- Cifrado.
- Auditorías.
- Copias de seguridad.
- Control de conexiones.

**Ejemplo SQL:**

Crear un rol de solo lectura:

```sql
CREATE ROLE consulta_lectura;
```

Permitir que el rol consulte una tabla:

```sql
GRANT SELECT ON TABLE clientes TO consulta_lectura;
```

Revocar el permiso:

```sql
REVOKE SELECT ON TABLE clientes FROM consulta_lectura;
```

En PostgreSQL, los permisos de conexión a la base de datos y los permisos sobre esquemas, tablas y secuencias deben administrarse según las necesidades del usuario.

---

## 6. Ejemplo práctico: ciclo de vida de una venta

Imaginemos que tenemos un supermercado que utiliza PostgreSQL para administrar sus ventas.

| Etapa | Situación |
|---|---|
| 1. Creación | Un cajero registra una venta. |
| 2. Almacenamiento | La venta se guarda en PostgreSQL. |
| 3. Uso | El sistema consulta la venta y actualiza el inventario. |
| 4. Compartición | Contabilidad recibe la información de la venta. |
| 5. Archivo | Después de varios años, la venta se conserva en un sistema histórico. |
| 6. Eliminación | Cuando termina el período de conservación aplicable, se elimina de acuerdo con las políticas de la empresa. |

Observa que la información puede pasar por varios sistemas durante su existencia. Por eso, administrar datos requiere planificación.

## 7. Diferencia entre ciclo de vida de datos y ciclo de vida de una base de datos

Son conceptos relacionados, pero no significan lo mismo.

| Ciclo de vida de los datos | Ciclo de vida de una base de datos |
|---|---|
| Se enfoca en la información. | Se enfoca en el sistema que almacena la información. |
| Comienza cuando se generan los datos. | Comienza cuando se planifica y diseña la base de datos. |
| Incluye almacenamiento, uso, archivo y eliminación. | Incluye diseño, implementación, operación, mantenimiento y retiro. |
| Puede continuar aunque cambie el sistema que almacena los datos. | Puede terminar cuando la base de datos deja de utilizarse. |

**Ejemplo:**

Una empresa puede migrar sus datos desde Oracle hacia PostgreSQL. Aunque cambie la base de datos, la información puede continuar existiendo y conservando su historia.

---

## 9. Preguntas de repaso

Intenta responderlas sin mirar las explicaciones anteriores.

1. ¿Qué es el ciclo de vida de los datos?
2. ¿Cuáles son sus seis etapas principales?
3. ¿Cuál es la diferencia entre almacenar y archivar datos?
4. ¿Qué responsabilidad tiene el DBA durante la etapa de almacenamiento?
5. ¿Qué significa Data Retention?
6. ¿Cuál es la diferencia entre Backup y Archiving?
7. ¿Por qué no se deben eliminar datos sin verificar las políticas de conservación?
8. ¿Qué es Data Governance?
9. ¿Qué herramientas de PostgreSQL permiten realizar respaldos?
10. ¿Cuál es la diferencia entre el ciclo de vida de los datos y el ciclo de vida de una base de datos?


**Idea clave:** El trabajo del DBA no termina cuando los datos se guardan en una tabla. Debe garantizar que puedan utilizarse, protegerse, recuperarse, conservarse y eliminarse correctamente durante todo su ciclo de vida.
