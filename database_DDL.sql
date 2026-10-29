-- =====================================================================
-- Taller SQL - Teoría de Bases de Datos (UMB)
-- 01_ddl.sql : creación de tablas (PostgreSQL 10 o superior)
-- El orden importa: primero las tablas padre, luego las que tienen FK.
-- =====================================================================
 
-- (Opcional) limpiar para volver a ejecutar desde cero:
-- DROP TABLE IF EXISTS AUDITORIA_PEDIDOS, HISTORICO_PRECIOS, DETALLE_PEDIDO,
--                      PEDIDO, PRODUCTO, CLIENTE, CATEGORIA CASCADE;
 
CREATE TABLE CATEGORIA (
    id_categoria   INTEGER PRIMARY KEY,
    nombre         VARCHAR(50) NOT NULL
);
 
CREATE TABLE CLIENTE (
    id_cliente     INTEGER PRIMARY KEY,
    nombre         VARCHAR(100) NOT NULL,
    email          VARCHAR(100) UNIQUE,
    fecha_registro DATE DEFAULT CURRENT_DATE
);
 
CREATE TABLE PRODUCTO (
    id_producto    INTEGER PRIMARY KEY,
    nombre         VARCHAR(100) NOT NULL,
    precio         NUMERIC(10,2),
    stock          INTEGER,
    id_categoria   INTEGER,
    CONSTRAINT fk_prod_cat FOREIGN KEY (id_categoria) REFERENCES CATEGORIA(id_categoria)
);
 
CREATE TABLE PEDIDO (
    id_pedido      INTEGER PRIMARY KEY,
    id_cliente     INTEGER,
    fecha_pedido   DATE DEFAULT CURRENT_DATE,
    estado         VARCHAR(20) DEFAULT 'PENDIENTE',
    CONSTRAINT fk_ped_cli FOREIGN KEY (id_cliente) REFERENCES CLIENTE(id_cliente)
);
 
CREATE TABLE DETALLE_PEDIDO (
    id_pedido      INTEGER,
    id_producto    INTEGER,
    cantidad       INTEGER,
    precio_unit    NUMERIC(10,2),
    CONSTRAINT pk_detalle  PRIMARY KEY (id_pedido, id_producto),
    CONSTRAINT fk_det_ped  FOREIGN KEY (id_pedido)   REFERENCES PEDIDO(id_pedido),
    CONSTRAINT fk_det_prod FOREIGN KEY (id_producto) REFERENCES PRODUCTO(id_producto)
);
 
CREATE TABLE HISTORICO_PRECIOS (
    id_producto     INTEGER,
    precio_anterior NUMERIC(10,2),
    precio_nuevo    NUMERIC(10,2),
    fecha_cambio    DATE,
    CONSTRAINT fk_hist_prod FOREIGN KEY (id_producto) REFERENCES PRODUCTO(id_producto)
);
 
CREATE TABLE AUDITORIA_PEDIDOS (
    id_auditoria   INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_pedido      INTEGER,
    usuario_bd     VARCHAR(50),
    fecha_evento   TIMESTAMP,
    accion         VARCHAR(20),
    CONSTRAINT fk_aud_ped FOREIGN KEY (id_pedido) REFERENCES PEDIDO(id_pedido)
);