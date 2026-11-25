# Arquitectura cliente-servidor

## 1. ¿Qué es la arquitectura cliente-servidor?

La arquitectura cliente-servidor es un modelo de comunicación en el que dos o más componentes trabajan juntos para proporcionar un servicio.

En este modelo existen dos elementos principales:

- **Cliente:** solicita información o servicios.
- **Servidor:** recibe las solicitudes, las procesa y devuelve una respuesta.

En palabras sencillas, el cliente pide algo y el servidor se encarga de atender esa petición.

### Ejemplo cotidiano

Cuando ingresas a una página web:

1. Abres el navegador de tu computador.
2. Escribes la dirección de una página.
3. El navegador solicita información al servidor.
4. El servidor procesa la solicitud.
5. El servidor devuelve la información.
6. Tu navegador muestra el contenido.

---

## 2. ¿Qué es un cliente?

Un cliente es un dispositivo o programa que solicita un servicio a otro sistema.

Puede ser:

- Un computador.
- Un teléfono celular.
- Un navegador web (Chrome, Firefox).
- Una aplicación de escritorio.
- Una aplicación móvil.
- Un sistema empresarial.

### Ejemplo

Cuando utilizas DBeaver para conectarte a PostgreSQL, DBeaver actúa como cliente porque solicita información al servidor de bases de datos.

---

## 3. ¿Qué es un servidor?

Un servidor es un equipo o programa que proporciona servicios a los clientes.

Puede encargarse de:

- Recibir solicitudes.
- Procesar información.
- Ejecutar aplicaciones.
- Consultar bases de datos.
- Almacenar información.
- Devolver resultados.

Un servidor no necesariamente es un computador físico especial. También puede ser un programa que se ejecuta en un equipo.

Por ejemplo, PostgreSQL es un sistema gestor de bases de datos que puede funcionar como servidor.

---

## 4. ¿Cómo funciona la comunicación cliente-servidor?

La comunicación normalmente sigue un ciclo:

1. **Solicitud (Request):** el cliente solicita información o un servicio.
2. **Recepción:** el servidor recibe la solicitud.
3. **Procesamiento:** el servidor analiza y procesa la petición.
4. **Respuesta (Response):** el servidor devuelve el resultado.
5. **Presentación:** el cliente recibe y muestra la información.

### Ejemplo práctico

Cuando consultas los datos de una persona en una aplicación:

1. El usuario solicita consultar una persona.
2. La aplicación cliente envía una petición.
3. El servidor recibe la petición.
4. El servidor consulta la base de datos.
5. La base de datos devuelve los registros.
6. El servidor entrega la respuesta al cliente.

---

## 5. Arquitectura de dos capas (2-Tier)

Es una arquitectura donde el cliente se comunica directamente con el servidor de bases de datos.

### Funcionamiento

1. El cliente ejecuta una aplicación.
2. La aplicación se conecta directamente a la base de datos.
3. Envía consultas SQL.
4. El servidor de base de datos procesa las consultas.
5. Devuelve los resultados al cliente.

### Ejemplo

Cuando utilizas DBeaver para conectarte directamente a PostgreSQL, estás utilizando una comunicación cliente-servidor de dos capas.

### Ventajas

- Arquitectura sencilla.
- Comunicación directa.
- Fácil de implementar en sistemas pequeños.

### Desventajas

- Puede ser difícil de administrar cuando existen muchos clientes.
- La lógica de negocio puede quedar distribuida entre los clientes.
- Se debe controlar cuidadosamente la seguridad de las conexiones a la base de datos.

---

## 6. Arquitectura de tres capas (3-Tier)

Es una arquitectura que divide el sistema en tres componentes independientes:

1. Capa de presentación.
2. Capa de aplicación o lógica de negocio.
3. Capa de datos.

### 6.1. Primera capa: presentación (Presentation Layer)

Es la parte con la que interactúa el usuario.

Ejemplos:

- Página web.
- Aplicación móvil.
- Interfaz de escritorio.

Su responsabilidad es mostrar información y recibir las acciones del usuario.

### 6.2. Segunda capa: aplicación (Application Layer)

Es donde se ejecuta la lógica de negocio.

Se encarga de:

- Recibir solicitudes del cliente.
- Validar información.
- Ejecutar reglas de negocio.
- Comunicarse con la base de datos.
- Preparar las respuestas.

Ejemplos de tecnologías:

- Java / Spring Boot.
- Node.js.
- .NET.
- Python.

### 6.3. Tercera capa: datos (Data Layer)

Es donde se almacena y administra la información.

Se encarga de:

- Almacenar registros.
- Ejecutar consultas SQL.
- Administrar transacciones.
- Controlar accesos.
- Garantizar la integridad de los datos.

Ejemplos de sistemas gestores de bases de datos:

- PostgreSQL.
- Oracle Database.
- SQL Server.
- MySQL.

---

## 7. Ejemplo práctico: aplicación con Spring Boot y PostgreSQL

Imaginemos una aplicación que permite consultar personas registradas.

La arquitectura estaría organizada de la siguiente manera:

| Capa | Componente | Función |
|---|---|---|
| Presentación | Navegador | Permite al usuario interactuar con la aplicación. |
| Aplicación | Java + Spring Boot | Procesa las solicitudes y ejecuta la lógica de negocio. |
| Datos | PostgreSQL | Almacena y administra la información. |

### ¿Qué sucede cuando el usuario consulta una persona?

1. El navegador solicita consultar una persona.
2. Spring Boot recibe la petición HTTP.
3. El controlador recibe y dirige la solicitud.
4. El servicio ejecuta la lógica de negocio.
5. El repositorio solicita los datos a PostgreSQL.
6. PostgreSQL ejecuta la consulta SQL.
7. Spring Boot recibe y prepara los resultados.
8. El navegador muestra la información.

En este tipo de arquitectura, cada capa tiene una responsabilidad específica.

**Dato importante:** Spring Boot y PostgreSQL pueden ejecutarse en el mismo computador, pero son servicios diferentes y cumplen funciones distintas.

Por ejemplo, en tu proyecto anterior:

- Spring Boot utilizaba el puerto 8081.
- PostgreSQL utilizaba el puerto 5432.

---

## 8. Conceptos importantes relacionados con la arquitectura cliente-servidor

Para comprender correctamente esta arquitectura, también es necesario conocer los siguientes conceptos:

| Concepto | Explicación |
|---|---|
| Red | Permite la comunicación entre dispositivos. |
| Dirección IP | Identifica un dispositivo dentro de una red. |
| Puerto | Identifica un servicio o punto de comunicación. |
| Protocolo | Define las reglas para intercambiar información. |
| TCP/IP | Conjunto de protocolos fundamentales para la comunicación en redes. |
| HTTP | Protocolo utilizado para la comunicación web. |
| HTTPS | Versión de HTTP que utiliza cifrado para proteger la comunicación. |
| JDBC | Tecnología Java para conectarse a bases de datos. |
| Firewall | Controla el tráfico de red permitido o bloqueado. |
| Latencia | Tiempo que tarda la información en viajar entre dos puntos. |

### 8.1. ¿Qué es un puerto?

Un puerto permite identificar a qué servicio se quiere acceder dentro de un equipo.

Por ejemplo:

| Servicio | Puerto habitual |
|---|---:|
| HTTP | 80 |
| HTTPS | 443 |
| PostgreSQL | 5432 |
| MySQL | 3306 |
| Oracle Database | 1521 |
| SQL Server | 1433 |

Los puertos pueden modificarse según la configuración del servicio.

---

## 9. Relación entre la arquitectura cliente-servidor y el DBA

Un DBA (Database Administrator o administrador de bases de datos) debe comprender la arquitectura cliente-servidor porque la base de datos no funciona de manera aislada: forma parte de un sistema que recibe solicitudes de diferentes aplicaciones y usuarios.

Entre sus responsabilidades se encuentran:

### 9.1. Conectividad

Verificar que las aplicaciones puedan conectarse correctamente al servidor de bases de datos.

### 9.2. Seguridad

Administrar usuarios, permisos, roles y accesos a la información.

### 9.3. Rendimiento

Optimizar consultas y evitar sobrecargas en el servidor de bases de datos.

### 9.4. Disponibilidad

Procurar que el servicio de base de datos permanezca operativo y accesible.

### 9.5. Respaldo y recuperación

Realizar copias de seguridad y recuperar información ante fallos o pérdidas de datos.

### 9.6. Monitoreo

Revisar conexiones, consumo de recursos, consultas y actividad del servidor.

### 9.7. Diagnóstico

Identificar problemas de comunicación entre clientes, servidores de aplicaciones y bases de datos.

---

## 11. Preguntas de repaso

1. ¿Qué es la arquitectura cliente-servidor?
2. ¿Cuál es la diferencia entre un cliente y un servidor?
3. ¿Cómo funciona el proceso de solicitud y respuesta?
4. ¿Qué caracteriza a una arquitectura de dos capas?
5. ¿Qué caracteriza a una arquitectura de tres capas?
6. ¿Cuáles son las tres capas de una arquitectura 3-Tier?
7. ¿Qué función cumple Spring Boot dentro de esta arquitectura?
8. ¿Qué función cumple PostgreSQL?
9. ¿Qué es una dirección IP?
10. ¿Qué es un puerto y para qué sirve?
11. ¿Qué diferencia existe entre HTTP y HTTPS?
12. ¿Por qué un DBA necesita comprender la arquitectura cliente-servidor?

---