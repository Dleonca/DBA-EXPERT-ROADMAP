select version(); --muestra version PostgreSQL 17.10 on x86_64-windows, compiled by msvc-19.44.35226, 64-bit
select current_database(); --postgres
select current_user; --postgres

CREATE DATABASE empresa_dba; - crea un base de datos.

CREATE TABLE departamentos (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE empleados (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    salario NUMERIC(10,2),
    departamento_id INTEGER,
    FOREIGN KEY (departamento_id)
    REFERENCES departamentos(id)
);

INSERT INTO departamentos (nombre)
VALUES
('Sistemas'),
('Finanzas'),
('Recursos Humanos');

INSERT INTO empleados
(nombre, salario, departamento_id)
VALUES
('Carlos', 3000, 1),
('Ana', 3500, 2),
('Pedro', 2800, 1);

SELECT
    e.nombre,
    e.salario,
    d.nombre AS departamento
FROM empleados e
JOIN departamentos d
ON e.departamento_id = d.id;

CREATE TABLE productos (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100),
    caracteristicas JSONB
);
INSERT INTO productos
(nombre, caracteristicas)
VALUES
(
    'Laptop',
    '{"marca":"Lenovo","ram":"16GB","precio":2500}'
);
SELECT
    nombre,
    caracteristicas ->> 'marca' AS marca,
    caracteristicas ->> 'ram' AS memoria
FROM productos;