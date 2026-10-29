-- Ejercicio 1
--------------------------------------------
SELECT
    c.nombre AS categoria,
    CASE EXTRACT(MONTH FROM p.fecha_pedido)
        WHEN 1 THEN 'Enero'
        WHEN 2 THEN 'Febrero'
        WHEN 3 THEN 'Marzo'
        WHEN 4 THEN 'Abril'
        WHEN 5 THEN 'Mayo'
        WHEN 6 THEN 'Junio'
        WHEN 7 THEN 'Julio'
        WHEN 8 THEN 'Agosto'
        WHEN 9 THEN 'Septiembre'
        WHEN 10 THEN 'Octubre'
        WHEN 11 THEN 'Noviembre'
        WHEN 12 THEN 'Diciembre'
    END AS mes,
    SUM(dp.cantidad * dp.precio_unit) AS total_ventas,
    SUM(dp.cantidad) AS cantidad_productos_vendidos
FROM CATEGORIA c
JOIN PRODUCTO pr
    ON c.id_categoria = pr.id_categoria
JOIN DETALLE_PEDIDO dp
    ON pr.id_producto = dp.id_producto
JOIN PEDIDO p
    ON dp.id_pedido = p.id_pedido
GROUP BY
    c.nombre,
    EXTRACT(MONTH FROM p.fecha_pedido)
ORDER BY
    EXTRACT(MONTH FROM p.fecha_pedido),
    c.nombre;
--------------------------------------------

-- Ejercicio 5
--------------------------------------------
SELECT
    id_cliente,
    fecha_pedido,
    COUNT(*) AS cantidad_pedidos
FROM PEDIDO
WHERE id_cliente IS NOT NULL
GROUP BY
    id_cliente,
    fecha_pedido
HAVING COUNT(*) > 1
ORDER BY
    fecha_pedido,
    id_cliente;
--------------------------------------------

-- Ejercicio 6
--------------------------------------------
SELECT
    pr.nombre AS producto
FROM PRODUCTO pr
WHERE pr.stock = 0
  AND EXISTS (
      SELECT 1
      FROM DETALLE_PEDIDO dp
      JOIN PEDIDO p
          ON dp.id_pedido = p.id_pedido
      WHERE dp.id_producto = pr.id_producto
        AND p.estado = 'PENDIENTE'
  );
--------------------------------------------

-- Ejercicio 8
--------------------------------------------
SELECT DISTINCT ON (hp.id_producto)
    hp.id_producto,
    hp.precio_anterior,
    hp.precio_nuevo
FROM HISTORICO_PRECIOS hp
WHERE hp.fecha_cambio > CURRENT_DATE - 30
ORDER BY
    hp.id_producto,
    hp.fecha_cambio DESC;
--------------------------------------------

-- Ejercicio 11
--------------------------------------------
SELECT
    pr.nombre AS producto,
    COUNT(*) AS cantidad_cambios
FROM PRODUCTO pr
JOIN HISTORICO_PRECIOS hp
    ON pr.id_producto = hp.id_producto
GROUP BY
    pr.id_producto,
    pr.nombre
HAVING COUNT(*) > 1
ORDER BY cantidad_cambios DESC;
--------------------------------------------

-- Ejercicio 14
--------------------------------------------
SELECT
    email,
    COUNT(*) AS cantidad_registros
FROM CLIENTE
WHERE email IS NOT NULL
GROUP BY email
HAVING COUNT(*) > 1
ORDER BY cantidad_registros DESC;
--------------------------------------------

-- Ejercicio 16
--------------------------------------------
SELECT
    pr.nombre AS producto
FROM PRODUCTO pr
WHERE NOT EXISTS (
    SELECT 1
    FROM DETALLE_PEDIDO dp
    WHERE dp.id_producto = pr.id_producto
)
ORDER BY pr.nombre;
--------------------------------------------

-- Ejercicio 17
--------------------------------------------
SELECT
    pr.nombre AS producto,
    COALESCE(
        ROUND(
            SUM(
                dp.cantidad * dp.precio_unit
                - dp.cantidad * dp.precio_unit * 0.80
            ),
            2
        ),
        0
    ) AS margen_neto_total
FROM PRODUCTO pr
LEFT JOIN DETALLE_PEDIDO dp
    ON pr.id_producto = dp.id_producto
GROUP BY
    pr.id_producto,
    pr.nombre
ORDER BY margen_neto_total DESC;
--------------------------------------------

-- Ejercicio 21
--------------------------------------------
SELECT
    id_pedido,
    fecha_evento,
    accion
FROM AUDITORIA_PEDIDOS
WHERE usuario_bd = 'SYSTEM'
ORDER BY fecha_evento DESC;
--------------------------------------------

-- Ejercicio 22
--------------------------------------------
SELECT
    usuario_bd,
    COUNT(*) AS total_acciones
FROM AUDITORIA_PEDIDOS
GROUP BY usuario_bd
HAVING COUNT(*) > 10
ORDER BY total_acciones DESC;
--------------------------------------------
