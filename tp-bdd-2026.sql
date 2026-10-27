--tp
USE GD2C_2026
GO

CREATE SCHEMA ESTRESHADAS;
go


-- TABLAS
create table ESTRESHADAS.provincia ( 
	id_provincia BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	nom_provincia varchar(255) NULL
)

create table ESTRESHADAS.localidad ( 
	id_localidad BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	id_provincia BIGINT NOT NULL REFERENCES ESTRESHADAS.provincia(id_provincia),
	nom_localidad varchar(255) NULL
)

CREATE TABLE ESTRESHADAS.local ( 
    id_local BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	id_localidad BIGINT NOT NULL REFERENCES ESTRESHADAS.localidad(id_localidad),
    nom_local VARCHAR(255) NULL,
    dir_local VARCHAR(255) NULL,
    tel_local VARCHAR(255) NULL,
    email_local VARCHAR(255) NULL
)

CREATE TABLE ESTRESHADAS.proveedor ( 
    id_proveedor BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	id_localidad BIGINT NOT NULL REFERENCES ESTRESHADAS.localidad(id_localidad),
    cuit_proveedor VARCHAR(255) NULL,
    raz_soc_proveedor VARCHAR(255) NULL,
    dir_proveedor VARCHAR(255) NULL,
    tel_proveedor VARCHAR(255) NULL,
    email_proveedor VARCHAR(255) NULL
)

create table ESTRESHADAS.cliente ( 
    id_cliente BIGINT IDENTITY(1,1) PRIMARY KEY,
    id_localidad BIGINT REFERENCES ESTRESHADAS.localidad(id_localidad),
    dni_cliente varchar(255) NULL,
    fec_nac_cliente datetime2(6) NULL,
    nom_cliente varchar(255) NULL,
    ape_cliente varchar(255) NULL,
    dir_cliente varchar(255) NULL,
    tel_cliente varchar(255) NULL,
    email_cliente varchar(255) NULL
)

create table ESTRESHADAS.empleado ( 
	id_empleado BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	id_localidad BIGINT NOT NULL REFERENCES ESTRESHADAS.localidad(id_localidad),
	id_local BIGINT NOT NULL REFERENCES ESTRESHADAS.local(id_local),
	dni_empleado varchar(255) NULL,
	fec_nac_empleado datetime2(6) NULL,
	fec_ingr_empleado datetime2(6) NULL,
	puesto_empleado varchar(255) NULL,
	nom_empleado varchar(255) NULL,
	ape_empleado varchar(255) NULL,
	domc_empleado varchar(255) NULL,
	tell_empleado varchar(255) NULL,
	email_empleado varchar(255) NULL
)

CREATE TABLE ESTRESHADAS.compra ( 
    id_compra BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    id_empleado BIGINT NOT NULL REFERENCES ESTRESHADAS.empleado(id_empleado),
    id_proveedor BIGINT NOT NULL REFERENCES ESTRESHADAS.proveedor(id_proveedor),
    nro_compra int NULL,
    total_compra numeric(38,2) NULL,
    fecha_compra datetime2(6) NULL
)

create table ESTRESHADAS.forma_pago ( 
	id_forma_pago BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	dscr_forma_pago varchar(255) NULL
)

create table ESTRESHADAS.venta ( 
    id_venta BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    id_empleado BIGINT NOT NULL REFERENCES ESTRESHADAS.empleado(id_empleado),
    id_cliente BIGINT NOT NULL REFERENCES ESTRESHADAS.cliente(id_cliente),
    id_forma_pago BIGINT NOT NULL REFERENCES ESTRESHADAS.forma_pago(id_forma_pago),
    nro_venta int NULL,
    fecha_venta datetime2(6) NULL,
    total_venta numeric(38,2) NULL
)

create table ESTRESHADAS.marca ( 
	id_marca BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	dscr_marca varchar(255) NULL
)

create table ESTRESHADAS.tipo_producto ( 
	id_tipo_producto BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	dscr_tipo_producto varchar(255) NULL
)

create table ESTRESHADAS.producto ( 
	id_producto BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	id_marca BIGINT NOT NULL REFERENCES ESTRESHADAS.marca(id_marca),
	id_tipo_producto BIGINT NOT NULL REFERENCES ESTRESHADAS.tipo_producto(id_tipo_producto),
	cod_producto varchar(255) NULL,
	nom_producto varchar(255) NULL,
	dscr_producto varchar(255) NULL,
	prec_producto numeric(38,2) NULL
)

CREATE TABLE ESTRESHADAS.detalle_compra ( 
    id_det_compra BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    id_compra BIGINT NOT NULL REFERENCES ESTRESHADAS.compra(id_compra),
    id_producto BIGINT NOT NULL REFERENCES ESTRESHADAS.producto(id_producto),
    cant_det_compra int NULL,
    precio_unitario numeric(38,2) NULL,
    subtotal_det_compra numeric(38,2) NULL
)

create table ESTRESHADAS.detalle_venta ( 
    id_det_venta BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    id_venta BIGINT NOT NULL REFERENCES ESTRESHADAS.venta(id_venta),
    id_producto BIGINT NOT NULL REFERENCES ESTRESHADAS.producto(id_producto),
    cant_det_venta int NULL,
    precio_unitario numeric(38,2) NULL,
    subtot_det_venta numeric(38,2) NULL
)

CREATE TABLE ESTRESHADAS.estado_bicicleta ( 
    id_est_bicicleta BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    desc_est_bici VARCHAR(255) NULL
)

CREATE TABLE ESTRESHADAS.estado_alquiler ( 
    id_est_alquiler BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    desc_est_alquiler VARCHAR(255) NULL
)

CREATE TABLE ESTRESHADAS.categoria_bicicleta ( 
    id_cat_bicicleta BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    dscr_cat_bici VARCHAR(255) NULL
)

CREATE TABLE ESTRESHADAS.modelo ( 
    id_modelo BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    id_cat_bicicleta BIGINT NOT NULL REFERENCES ESTRESHADAS.categoria_bicicleta(id_cat_bicicleta),
    nom_modelo VARCHAR(255) NULL,
    rodado_modelo VARCHAR(255) NULL,
    cuadro_modelo VARCHAR(255) NULL,
    color_modelo VARCHAR(255) NULL
)

CREATE TABLE ESTRESHADAS.categoria_accesorio ( 
    id_cat_accesorio BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    dscr_cat_accesorio VARCHAR(255) NULL
)

CREATE TABLE ESTRESHADAS.accesorio ( 
    id_producto BIGINT NOT NULL REFERENCES ESTRESHADAS.producto(id_producto),
    id_cat_accesorio BIGINT NOT NULL REFERENCES ESTRESHADAS.categoria_accesorio(id_cat_accesorio),
    talle_accesorio VARCHAR(255) NULL,
    color_accesorio VARCHAR(255) NULL,
    
    -- Clave Primaria Compuesta para que identifique univocamente un producto de tipo accesorio
    PRIMARY KEY (id_producto, id_cat_accesorio)
);

CREATE TABLE ESTRESHADAS.bicicleta_venta ( 
    id_producto BIGINT NOT NULL REFERENCES ESTRESHADAS.producto(id_producto),
    id_modelo BIGINT NOT NULL REFERENCES ESTRESHADAS.modelo(id_modelo),
    meses_garantia int NULL,
    
    -- Clave Primaria Compuesta para que identifique univocamente un producto de tipo bici_venta
    PRIMARY KEY (id_producto, id_modelo)
);

CREATE TABLE ESTRESHADAS.bicicleta_alquiler ( 
    id_bici_alquiler BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    nro_serie_bici_alquiler VARCHAR(255) NOT NULL UNIQUE,
    id_marca BIGINT NOT NULL REFERENCES ESTRESHADAS.marca(id_marca),
    id_modelo BIGINT NOT NULL REFERENCES ESTRESHADAS.modelo(id_modelo),
	id_local BIGINT NOT NULL REFERENCES ESTRESHADAS.local(id_local),
	id_est_bicicleta BIGINT NOT NULL REFERENCES ESTRESHADAS.estado_bicicleta(id_est_bicicleta),
    precio_hora numeric(38,2) NULL,
    precio_dia numeric(38,2) NULL
)

CREATE TABLE ESTRESHADAS.alquiler ( 
    id_alquiler BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    id_empleado BIGINT NOT NULL REFERENCES ESTRESHADAS.empleado(id_empleado),
    id_cliente BIGINT NOT NULL REFERENCES ESTRESHADAS.cliente(id_cliente),
    id_bici_alquiler BIGINT NOT NULL REFERENCES ESTRESHADAS.bicicleta_alquiler(id_bici_alquiler),
	id_forma_pago BIGINT NOT NULL REFERENCES ESTRESHADAS.forma_pago(id_forma_pago),
	id_est_alquiler BIGINT NOT NULL REFERENCES ESTRESHADAS.estado_alquiler(id_est_alquiler),
    fec_init datetime2(6) NULL,
    fec_devolucion datetime2(6) NULL,
    fec_real_devolucion datetime2(6) NULL,
    nro_alquiler int NULL,
    importe_alquiler NUMERIC(38,2) NULL
)

create table ESTRESHADAS.estado_reparacion ( 
    id_est_reparacion BIGINT IDENTITY(1,1) PRIMARY KEY,
    desc_est_reparacion varchar(255) NULL
)

create table ESTRESHADAS.reparacion ( 
    id_reparacion BIGINT IDENTITY(1,1) PRIMARY KEY,
    id_cliente BIGINT REFERENCES ESTRESHADAS.cliente(id_cliente),
    id_empleado BIGINT REFERENCES ESTRESHADAS.empleado(id_empleado),
    id_modelo BIGINT NOT NULL REFERENCES ESTRESHADAS.modelo(id_modelo),
    id_est_reparacion BIGINT REFERENCES ESTRESHADAS.estado_reparacion(id_est_reparacion),
    nro_reparacion int NULL,
    nro_serie_bici_cli varchar(255) NULL,
    fecha_ingreso datetime2(6) NULL,
    fecha_entrega_estm datetime2(6) NULL,
    fecha_entrega_real datetime2(6) NULL,
    diagnostico varchar(255) NULL,
    precio_mano_obra numeric(38,2) NULL,
    precio_repuestos numeric(38,2) NULL,
    precio_total numeric(38,2) NULL
)

create table ESTRESHADAS.categoria_repuesto ( 
    id_categoria BIGINT IDENTITY(1,1) PRIMARY KEY,
    desc_categoria varchar(255) NULL
)

create table ESTRESHADAS.Repuesto ( 
    id_repuesto BIGINT IDENTITY(1,1) PRIMARY KEY,
    id_categoria BIGINT REFERENCES ESTRESHADAS.categoria_repuesto(id_categoria),
    cod_repuesto varchar(255) NULL,
    precio_repuesto numeric(38,2) NULL,
    desc_repuesto varchar(255) NULL,
    compatibilidad varchar(255) NULL
)

create table ESTRESHADAS.detalle_reparacion ( 
    id_detReparacion BIGINT IDENTITY(1,1) PRIMARY KEY,
    id_reparacion BIGINT REFERENCES ESTRESHADAS.reparacion(id_Reparacion),
    id_repuesto BIGINT REFERENCES ESTRESHADAS.repuesto(id_repuesto),
    subtotal numeric(38,2) NULL,
    precio_unitario numeric(38,2) NULL,
    cantidad int NULL
)
GO

-- MIGRACIONES
CREATE PROCEDURE ESTRESHADAS.migracion_provincia
AS
BEGIN
    --cargo las provincias de los clientes
    INSERT INTO ESTRESHADAS.provincia (nom_provincia)
    select distinct cliente_provincia from gd_esquema.Maestra
    where cliente_provincia is not null

    -- al cargar las de empleado, pregunto si no existe 1 fila con ese nombre provincia ya asignado
    INSERT INTO ESTRESHADAS.provincia (nom_provincia)
    SELECT DISTINCT empleado_provincia FROM gd_esquema.Maestra
    WHERE empleado_provincia IS NOT NULL
        AND NOT EXISTS (
          SELECT 1
          FROM ESTRESHADAS.provincia
          WHERE provincia.nom_provincia = empleado_provincia
        )

    INSERT INTO ESTRESHADAS.provincia (nom_provincia)
    SELECT DISTINCT proveedor_provincia FROM gd_esquema.Maestra
    WHERE proveedor_provincia IS NOT NULL
        AND NOT EXISTS (
          SELECT 1
          FROM ESTRESHADAS.provincia
          WHERE provincia.nom_provincia = proveedor_provincia
        )

    INSERT INTO ESTRESHADAS.provincia (nom_provincia)
    SELECT DISTINCT local_provincia FROM gd_esquema.Maestra
    WHERE local_provincia IS NOT NULL
        AND NOT EXISTS (
          SELECT 1
          FROM ESTRESHADAS.provincia
          WHERE provincia.nom_provincia = local_provincia
        )
END;
GO

CREATE PROCEDURE ESTRESHADAS.migracion_localidad
AS
BEGIN
    INSERT INTO ESTRESHADAS.localidad (id_provincia, nom_localidad)
    SELECT DISTINCT provincia.id_provincia, cliente_localidad
    FROM gd_esquema.Maestra
    INNER JOIN ESTRESHADAS.provincia
        ON provincia.nom_provincia = cliente_provincia
    WHERE cliente_localidad IS NOT NULL
        AND NOT EXISTS (
            SELECT 1
            FROM ESTRESHADAS.localidad
            WHERE localidad.id_provincia = provincia.id_provincia
            AND localidad.nom_localidad = cliente_localidad
        )

    INSERT INTO ESTRESHADAS.localidad (id_provincia, nom_localidad)
    SELECT DISTINCT provincia.id_provincia, empleado_localidad
    FROM gd_esquema.Maestra
    INNER JOIN ESTRESHADAS.provincia
        ON provincia.nom_provincia = empleado_provincia
    WHERE empleado_localidad IS NOT NULL
        AND NOT EXISTS (
            SELECT 1
            FROM ESTRESHADAS.localidad
            WHERE localidad.id_provincia = provincia.id_provincia
            AND localidad.nom_localidad = empleado_localidad
        )

    INSERT INTO ESTRESHADAS.localidad (id_provincia, nom_localidad)
    SELECT DISTINCT provincia.id_provincia, proveedor_localidad
    FROM gd_esquema.Maestra
    INNER JOIN ESTRESHADAS.provincia
        ON provincia.nom_provincia = proveedor_provincia
    WHERE proveedor_localidad IS NOT NULL
        AND NOT EXISTS (
            SELECT 1
            FROM ESTRESHADAS.localidad
            WHERE localidad.id_provincia = provincia.id_provincia
            AND localidad.nom_localidad = proveedor_localidad
        )

    INSERT INTO ESTRESHADAS.localidad (id_provincia, nom_localidad)
    SELECT DISTINCT provincia.id_provincia, local_localidad
    FROM gd_esquema.Maestra
    INNER JOIN ESTRESHADAS.provincia
        ON provincia.nom_provincia = local_provincia
    WHERE local_localidad IS NOT NULL
        AND NOT EXISTS (
            SELECT 1
            FROM ESTRESHADAS.localidad
            WHERE localidad.id_provincia = provincia.id_provincia
            AND localidad.nom_localidad = local_localidad
        )
END;
GO

CREATE PROCEDURE ESTRESHADAS.migracion_cliente
AS
BEGIN
    INSERT INTO ESTRESHADAS.Cliente (id_localidad, dni_cliente, fec_nac_cliente, nom_cliente, ape_cliente, dir_cliente, tel_cliente, email_cliente)
    SELECT DISTINCT
        L.id_localidad,
        M.Cliente_Dni_Cliente,
        M.Cliente_Fecha_Nacimiento_Cliente,
        M.Cliente_Nombre_Cliente,
        M.Cliente_Apellido_Cliente,
        M.Cliente_Direccion_Cliente,
        M.Cliente_Telefono_Cliente,
        M.Cliente_Email_Cliente
    FROM gd_esquema.Maestra M
    INNER JOIN ESTRESHADAS.Localidad L
        ON L.nom_localidad = M.Cliente_Localidad
    INNER JOIN ESTRESHADAS.Provincia PR
        ON PR.id_provincia = L.id_provincia
        AND PR.nom_provincia = M.Cliente_Provincia
    WHERE M.Cliente_Dni_Cliente IS NOT NULL;
END;
GO

CREATE PROCEDURE ESTRESHADAS.migracion_empleado
AS
BEGIN
    INSERT INTO ESTRESHADAS.empleado (id_localidad, id_local, dni_empleado, fec_nac_empleado,
        fec_ingr_empleado, puesto_empleado, nom_empleado, ape_empleado, domc_empleado, tell_empleado, email_empleado)
    SELECT DISTINCT
        L.id_localidad,
        LO.id_local,
        M.Empleado_Dni_Empleado,
        M.Empleado_Fecha_Nac_Empleado,
        M.Empleado_Fecha_Ingreso_Empleado,
        M.Empleado_Puesto_Empleado,
        M.Empleado_Nombre_Empleado,
        M.Empleado_Apellido_Empleado,
        M.Empleado_Domicilio_Empleado,
        M.Empleado_Telefono_Empleado,
        M.Empleado_Email_Empleado
    FROM gd_esquema.Maestra M
    INNER JOIN ESTRESHADAS.Localidad L
        ON L.nom_localidad = M.Empleado_Localidad
    INNER JOIN ESTRESHADAS.Provincia PR
        ON PR.id_provincia = L.id_provincia
        AND PR.nom_provincia = M.Empleado_Provincia
    INNER JOIN ESTRESHADAS.Local LO
        ON LO.nom_local = M.Local_Nombre_Local
    INNER JOIN ESTRESHADAS.Localidad LL
        ON LL.id_localidad = LO.id_localidad
        AND LL.nom_localidad = M.Local_Localidad
    INNER JOIN ESTRESHADAS.Provincia PL
        ON PL.id_provincia = LL.id_provincia
        AND PL.nom_provincia = M.Local_Provincia
    WHERE M.Empleado_Dni_Empleado IS NOT NULL;
END;
GO

CREATE PROCEDURE ESTRESHADAS.migracion_estado_reparacion
AS
BEGIN
    INSERT INTO ESTRESHADAS.Estado_Reparacion (desc_est_reparacion)
    SELECT DISTINCT M.Estado_Reparacion_Estado_Reparacion
    FROM gd_esquema.Maestra M
    WHERE M.Estado_Reparacion_Estado_Reparacion IS NOT NULL;
END;
GO

CREATE PROCEDURE ESTRESHADAS.migracion_reparacion
AS
BEGIN
    INSERT INTO ESTRESHADAS.Reparacion (id_cliente, id_empleado, id_modelo,
        id_est_reparacion, nro_reparacion, nro_serie_bici_cli, fecha_ingreso,
        fecha_entrega_estm, fecha_entrega_real, diagnostico,
        precio_mano_obra, precio_repuestos, precio_total)
    SELECT DISTINCT
        C.id_cliente,
        E.id_empleado,
        MO.id_modelo,
        EP.id_est_reparacion,
        M.Reparacion_Nro_Reparacion,
        M.Reparacion_Numero_Serie_Bici_Reparacion,
        M.Reparacion_Fecha_Ingreso_Reparacion,
        M.Reparacion_Fecha_Entrega_Estimada_Reparacion,
        M.Reparacion_Fecha_Entrega_Real_Reparacion,
        M.Reparacion_Diagnostico_Reparacion,
        M.Reparacion_Precio_Mano_Obra_Reparacion,
        M.Reparacion_Precio_Repuestos_Reparacion,
        M.Reparacion_Precio_Total_Reparacion
    FROM gd_esquema.Maestra M
    INNER JOIN ESTRESHADAS.Cliente C
        ON C.dni_cliente = M.Cliente_Dni_Cliente
    INNER JOIN ESTRESHADAS.Empleado E
        ON E.dni_empleado = M.Empleado_Dni_Empleado
    INNER JOIN ESTRESHADAS.Modelo MO
        ON MO.nom_modelo = M.Modelo_Bicicleta_Modelo_Bicicleta
        AND (MO.rodado_modelo = M.Modelo_Bicicleta_Rodado_Modelo_Bicicleta
            OR (MO.rodado_modelo IS NULL AND M.Modelo_Bicicleta_Rodado_Modelo_Bicicleta IS NULL))
        AND (MO.cuadro_modelo = M.Modelo_Bicicleta_Cuadro_Modelo_Bicicleta
            OR (MO.cuadro_modelo IS NULL AND M.Modelo_Bicicleta_Cuadro_Modelo_Bicicleta IS NULL))
        AND (MO.color_modelo = M.Modelo_Bicicleta_Color_Modelo_Bicicleta
            OR (MO.color_modelo IS NULL AND M.Modelo_Bicicleta_Color_Modelo_Bicicleta IS NULL))
    INNER JOIN ESTRESHADAS.Categoria_Bicicleta CB
        ON CB.id_cat_bicicleta = MO.id_cat_bicicleta
        AND CB.dscr_cat_bici = M.Categoria_Bicicleta_Categoria_Bicicleta
    INNER JOIN ESTRESHADAS.Estado_Reparacion EP
        ON EP.desc_est_reparacion = M.Estado_Reparacion_Estado_Reparacion
    WHERE M.Reparacion_Nro_Reparacion IS NOT NULL
        AND M.Modelo_Bicicleta_Modelo_Bicicleta IS NOT NULL;
END;
GO

CREATE PROCEDURE ESTRESHADAS.migracion_categoria_repuesto
AS
BEGIN
    INSERT INTO ESTRESHADAS.Categoria_Repuesto (desc_categoria)
    SELECT DISTINCT M.Categoria_Repuestos_Categoria_Respuesto
    FROM gd_esquema.Maestra M
    WHERE M.Categoria_Repuestos_Categoria_Respuesto IS NOT NULL;
END;
GO

CREATE PROCEDURE ESTRESHADAS.migracion_repuesto
AS
BEGIN
    INSERT INTO ESTRESHADAS.Repuesto (id_categoria, cod_repuesto, precio_repuesto, desc_repuesto, compatibilidad)
    SELECT DISTINCT
        CR.id_categoria,
        M.Repuesto_Cod_Repuesto,
        M.Repuesto_Precio_Repuesto,
        M.Repuesto_Desc_Repuesto,
        M.Repuesto_Compatibilidad_Repuesto
    FROM gd_esquema.Maestra M
    INNER JOIN ESTRESHADAS.Categoria_Repuesto CR
        ON CR.desc_categoria = M.Categoria_Repuestos_Categoria_Respuesto
    WHERE M.Repuesto_Cod_Repuesto IS NOT NULL;
END;
GO

CREATE PROCEDURE ESTRESHADAS.migracion_detalle_reparacion
AS
BEGIN
    INSERT INTO ESTRESHADAS.Detalle_Reparacion (id_reparacion, id_repuesto, subtotal, precio_unitario, cantidad)
    SELECT DISTINCT
        R.id_reparacion,
        REPU.id_repuesto,
        M.Detalle_Reparacion_Subtotal_Repuesto,
        M.Detalle_Reparacion_Precio_Unitario_Repuesto,
        M.Detalle_Reparacion_Cantidad_Repuesto
    FROM gd_esquema.Maestra M
    INNER JOIN ESTRESHADAS.Reparacion R
        ON R.nro_reparacion = M.Reparacion_Nro_Reparacion
    INNER JOIN ESTRESHADAS.Repuesto REPU
        ON REPU.cod_repuesto = M.Repuesto_Cod_Repuesto
    WHERE M.Detalle_Reparacion_Subtotal_Repuesto IS NOT NULL
        AND M.Detalle_Reparacion_Precio_Unitario_Repuesto IS NOT NULL
        AND M.Detalle_Reparacion_Cantidad_Repuesto IS NOT NULL;
END;
GO

CREATE PROCEDURE ESTRESHADAS.migracion_proveedor
AS
BEGIN
    INSERT INTO ESTRESHADAS.Proveedor (id_localidad, cuit_proveedor, raz_soc_proveedor, dir_proveedor, tel_proveedor, email_proveedor)
    SELECT DISTINCT
        L.id_localidad,
        M.Proveedor_Cuit_Proveedor,
        M.Proveedor_Razon_Social_Proveedor,
        M.Proveedor_Direccion_Proveedor,
        M.Proveedor_Telefono_Proveedor,
        M.Proveedor_Email_Proveedor
    FROM gd_esquema.Maestra M
    INNER JOIN ESTRESHADAS.Localidad L
        ON L.nom_localidad = M.Proveedor_Localidad
    INNER JOIN ESTRESHADAS.Provincia PR
        ON PR.id_provincia = L.id_provincia
        AND PR.nom_provincia = M.Proveedor_Provincia
    WHERE M.Proveedor_Cuit_Proveedor IS NOT NULL;
END;
GO

CREATE PROCEDURE ESTRESHADAS.migracion_compra
AS
BEGIN
    INSERT INTO ESTRESHADAS.Compra (id_empleado, id_proveedor, nro_compra, total_compra, fecha_compra)
    SELECT DISTINCT
        E.id_empleado,
        P.id_proveedor,
        M.Compra_Nro_Compra,
        M.Compra_Total_Compra,
        M.Compra_Fecha_Compra
    FROM gd_esquema.Maestra M
    INNER JOIN ESTRESHADAS.Empleado E
        ON E.dni_empleado = M.Empleado_Dni_Empleado
    INNER JOIN ESTRESHADAS.Proveedor P
        ON P.cuit_proveedor = M.Proveedor_Cuit_Proveedor
    WHERE M.Compra_Nro_Compra IS NOT NULL;
END;
GO

CREATE PROCEDURE ESTRESHADAS.migracion_detalle_compra
AS
BEGIN
    INSERT INTO ESTRESHADAS.Detalle_Compra (id_compra, id_producto, precio_unitario, cant_det_compra, subtotal_det_compra)
    SELECT DISTINCT
        C.id_compra,
        PR.id_producto,
        M.Detalle_Compra_Precio_Unitario_Prod_Compra,
        M.Detalle_Compra_Cantidad_Prod_Compra,
        M.Detalle_Compra_Precio_Unitario_Prod_Compra * M.Detalle_Compra_Cantidad_Prod_Compra
    FROM gd_esquema.Maestra M
    INNER JOIN ESTRESHADAS.Compra C
        ON C.nro_compra = M.Compra_Nro_Compra
    INNER JOIN ESTRESHADAS.Producto PR
        ON PR.cod_producto = M.Producto_Cod_Producto
    WHERE M.Compra_Nro_Compra IS NOT NULL
        AND M.Producto_Cod_Producto IS NOT NULL
        AND M.Detalle_Compra_Precio_Unitario_Prod_Compra IS NOT NULL
        AND M.Detalle_Compra_Cantidad_Prod_Compra IS NOT NULL;
END;
GO

CREATE PROCEDURE ESTRESHADAS.migracion_local
AS
BEGIN
    INSERT INTO ESTRESHADAS.Local (id_localidad, nom_local, dir_local, tel_local, email_local)
    SELECT DISTINCT
        L.id_localidad,
        M.Local_Nombre_Local,
        M.Local_Direccion_Local,
        M.Local_Telefono_Local,
        M.Local_Email_Local
    FROM gd_esquema.Maestra M
    INNER JOIN ESTRESHADAS.Localidad L
        ON L.nom_localidad = M.Local_Localidad
    INNER JOIN ESTRESHADAS.Provincia PR
        ON PR.id_provincia = L.id_provincia
        AND PR.nom_provincia = M.Local_Provincia
    WHERE M.Local_Nombre_Local IS NOT NULL;
END;
GO

CREATE PROCEDURE ESTRESHADAS.migracion_estado_bicicleta
AS
BEGIN
    INSERT INTO ESTRESHADAS.Estado_Bicicleta (desc_est_bici)
    SELECT DISTINCT M.Estado_Bici_Alquiler_Estado_Bici_Alquiler
    FROM gd_esquema.Maestra M
    WHERE M.Estado_Bici_Alquiler_Estado_Bici_Alquiler IS NOT NULL;
END;
GO

CREATE PROCEDURE ESTRESHADAS.migracion_estado_alquiler
AS
BEGIN
    INSERT INTO ESTRESHADAS.Estado_Alquiler (desc_est_alquiler)
    SELECT DISTINCT M.Estado_Alquiler_Estado_Alquiler
    FROM gd_esquema.Maestra M
    WHERE M.Estado_Alquiler_Estado_Alquiler IS NOT NULL;
END;
GO

CREATE PROCEDURE ESTRESHADAS.migracion_marca
AS
BEGIN
    INSERT INTO ESTRESHADAS.Marca (dscr_marca)
    SELECT DISTINCT M.Marca_Marca
    FROM gd_esquema.Maestra M
    WHERE M.Marca_Marca IS NOT NULL;
END;
GO

CREATE PROCEDURE ESTRESHADAS.migracion_tipo_producto
AS
BEGIN
    INSERT INTO ESTRESHADAS.Tipo_Producto (dscr_tipo_producto)
    SELECT DISTINCT M.Tipo_Producto_Tipo_Producto
    FROM gd_esquema.Maestra M
    WHERE M.Tipo_Producto_Tipo_Producto IS NOT NULL;
END;
GO

CREATE PROCEDURE ESTRESHADAS.migracion_producto
AS
BEGIN
    INSERT INTO ESTRESHADAS.Producto (id_marca, id_tipo_producto, cod_producto, nom_producto, dscr_producto, prec_producto)
    SELECT DISTINCT
        MA.id_marca,
        TP.id_tipo_producto,
        M.Producto_Cod_Producto,
        M.Producto_Nombre_Producto,
        M.Producto_Descripcion_Producto,
        M.Producto_Precio_Venta_Producto
    FROM gd_esquema.Maestra M
    INNER JOIN ESTRESHADAS.Marca MA
        ON MA.dscr_marca = M.Marca_Marca
    INNER JOIN ESTRESHADAS.Tipo_Producto TP
        ON TP.dscr_tipo_producto = M.Tipo_Producto_Tipo_Producto
    WHERE M.Producto_Cod_Producto IS NOT NULL;
END;
GO

CREATE PROCEDURE ESTRESHADAS.migracion_categoria_accesorio
AS
BEGIN
    INSERT INTO ESTRESHADAS.Categoria_Accesorio (dscr_cat_accesorio)
    SELECT DISTINCT M.Categoria_Accesorios_Categoria_Accesorio
    FROM gd_esquema.Maestra M
    WHERE M.Categoria_Accesorios_Categoria_Accesorio IS NOT NULL;
END;
GO

CREATE PROCEDURE ESTRESHADAS.migracion_categoria_bicicleta
AS
BEGIN
    INSERT INTO ESTRESHADAS.Categoria_Bicicleta (dscr_cat_bici)
    SELECT DISTINCT M.Categoria_Bicicleta_Categoria_Bicicleta
    FROM gd_esquema.Maestra M
    WHERE M.Categoria_Bicicleta_Categoria_Bicicleta IS NOT NULL;
END;
GO

CREATE PROCEDURE ESTRESHADAS.migracion_forma_pago
AS
BEGIN
    INSERT INTO ESTRESHADAS.forma_pago (dscr_forma_pago)
    SELECT DISTINCT M.Forma_Pago_Forma_Pago
    FROM gd_esquema.Maestra M
    WHERE M.Forma_Pago_Forma_Pago IS NOT NULL;
END;
GO

CREATE PROCEDURE ESTRESHADAS.migracion_venta
AS
BEGIN
    INSERT INTO ESTRESHADAS.Venta (
        id_empleado, id_cliente, id_forma_pago,
        nro_venta, fecha_venta, total_venta
    )
    SELECT DISTINCT
        E.id_empleado,
        C.id_cliente,
        FP.id_forma_pago,
        M.Venta_Nro_Venta,
        M.Venta_Fecha_Hora_Venta,
        M.Venta_Total_Venta
    FROM gd_esquema.Maestra M
    INNER JOIN ESTRESHADAS.Empleado E
        ON E.dni_empleado = M.Empleado_Dni_Empleado
    INNER JOIN ESTRESHADAS.Cliente C
        ON C.dni_cliente = M.Cliente_Dni_Cliente
    INNER JOIN ESTRESHADAS.Forma_Pago FP
        ON FP.dscr_forma_pago = M.Forma_Pago_Forma_Pago
    WHERE M.Venta_Nro_Venta IS NOT NULL;
END;
GO

CREATE PROCEDURE ESTRESHADAS.migracion_det_venta
AS
BEGIN
    INSERT INTO ESTRESHADAS.detalle_venta(
        id_venta, id_producto, cant_det_venta, precio_unitario, subtot_det_venta
    )
    SELECT DISTINCT
        V.id_venta,
        P.id_producto,
        M.Detalle_Venta_Cantidad_Prod_Venta,
        M.Detalle_Venta_Precio_Unitario_Prod_Venta,
        M.Detalle_Venta_Subtotal_Prod_Venta
    FROM gd_esquema.Maestra M
    INNER JOIN ESTRESHADAS.venta V
        ON V.nro_venta = M.Venta_Nro_Venta
    INNER JOIN ESTRESHADAS.producto P
        ON P.cod_producto = M.Producto_Cod_Producto
    WHERE M.Venta_Nro_Venta IS NOT NULL
        AND M.Producto_Cod_Producto IS NOT NULL;
END;
GO

CREATE PROCEDURE ESTRESHADAS.migracion_accesorio
AS
BEGIN
    INSERT INTO ESTRESHADAS.Accesorio (id_producto, id_cat_accesorio, talle_accesorio, color_accesorio)
    SELECT DISTINCT
        P.id_producto,
        CA.id_cat_accesorio,
        M.Accesorio_Talle_Accesorio,
        M.Accesorio_Color_Accesorio
    FROM gd_esquema.Maestra M
    INNER JOIN ESTRESHADAS.Producto P
        ON P.cod_producto = M.Producto_Cod_Producto
    INNER JOIN ESTRESHADAS.Categoria_Accesorio CA
        ON CA.dscr_cat_accesorio = M.Categoria_Accesorios_Categoria_Accesorio
    WHERE M.Producto_Cod_Producto IS NOT NULL
        AND M.Categoria_Accesorios_Categoria_Accesorio IS NOT NULL;
END;
GO

CREATE PROCEDURE ESTRESHADAS.migracion_modelo
AS
BEGIN
    INSERT INTO ESTRESHADAS.Modelo (id_cat_bicicleta, nom_modelo, rodado_modelo, cuadro_modelo, color_modelo)
    SELECT DISTINCT
        CB.id_cat_bicicleta,
        M.Modelo_Bicicleta_Modelo_Bicicleta,
        M.Modelo_Bicicleta_Rodado_Modelo_Bicicleta,
        M.Modelo_Bicicleta_Cuadro_Modelo_Bicicleta,
        M.Modelo_Bicicleta_Color_Modelo_Bicicleta
    FROM gd_esquema.Maestra M
    INNER JOIN ESTRESHADAS.Categoria_Bicicleta CB
        ON CB.dscr_cat_bici = M.Categoria_Bicicleta_Categoria_Bicicleta
    WHERE M.Modelo_Bicicleta_Modelo_Bicicleta IS NOT NULL;
END;
GO

CREATE PROCEDURE ESTRESHADAS.migracion_bicicleta_venta
AS
BEGIN
    INSERT INTO ESTRESHADAS.bicicleta_venta (id_producto, id_modelo, meses_garantia)
    SELECT DISTINCT
        P.id_producto,
        MO.id_modelo,
        M.Bicicleta_Venta_Meses_Garantia_Bici_Venta
    FROM gd_esquema.Maestra M
    INNER JOIN ESTRESHADAS.Producto P
        ON P.cod_producto = M.Producto_Cod_Producto
    INNER JOIN ESTRESHADAS.modelo MO
        ON MO.nom_modelo = M.Modelo_Bicicleta_Modelo_Bicicleta
        AND (MO.rodado_modelo = M.Modelo_Bicicleta_Rodado_Modelo_Bicicleta
            OR (MO.rodado_modelo IS NULL AND M.Modelo_Bicicleta_Rodado_Modelo_Bicicleta IS NULL))
        AND (MO.cuadro_modelo = M.Modelo_Bicicleta_Cuadro_Modelo_Bicicleta
            OR (MO.cuadro_modelo IS NULL AND M.Modelo_Bicicleta_Cuadro_Modelo_Bicicleta IS NULL))
        AND (MO.color_modelo = M.Modelo_Bicicleta_Color_Modelo_Bicicleta
            OR (MO.color_modelo IS NULL AND M.Modelo_Bicicleta_Color_Modelo_Bicicleta IS NULL))
    INNER JOIN ESTRESHADAS.Categoria_Bicicleta CB
        ON CB.id_cat_bicicleta = MO.id_cat_bicicleta
        AND CB.dscr_cat_bici = M.Categoria_Bicicleta_Categoria_Bicicleta
    WHERE M.Producto_Cod_Producto IS NOT NULL
        AND M.Modelo_Bicicleta_Modelo_Bicicleta IS NOT NULL
        AND M.Categoria_Bicicleta_Categoria_Bicicleta IS NOT NULL;
END;
GO

CREATE PROCEDURE ESTRESHADAS.migracion_bicicleta_alquiler
AS
BEGIN
    INSERT INTO ESTRESHADAS.Bicicleta_Alquiler (nro_serie_bici_alquiler, id_marca, id_modelo, id_local, id_est_bicicleta, precio_hora, precio_dia)
    SELECT DISTINCT
        M.Bicicleta_Alquiler_Nro_Serie_Bici_Alquiler,
        MA.id_marca,
        MO.id_modelo,
        L.id_local,
        EB.id_est_bicicleta,
        M.Bicicleta_Alquiler_Precio_Bici_Alquiler_Hora,
        M.Bicicleta_Alquiler_Precio_Bici_Alquiler_Dia
    FROM gd_esquema.Maestra M
    INNER JOIN ESTRESHADAS.Marca MA
        ON MA.dscr_marca = M.Marca_Marca
    INNER JOIN ESTRESHADAS.Modelo MO
        ON MO.nom_modelo = M.Modelo_Bicicleta_Modelo_Bicicleta
        AND (MO.rodado_modelo = M.Modelo_Bicicleta_Rodado_Modelo_Bicicleta
            OR (MO.rodado_modelo IS NULL AND M.Modelo_Bicicleta_Rodado_Modelo_Bicicleta IS NULL))
        AND (MO.cuadro_modelo = M.Modelo_Bicicleta_Cuadro_Modelo_Bicicleta
            OR (MO.cuadro_modelo IS NULL AND M.Modelo_Bicicleta_Cuadro_Modelo_Bicicleta IS NULL))
        AND (MO.color_modelo = M.Modelo_Bicicleta_Color_Modelo_Bicicleta
            OR (MO.color_modelo IS NULL AND M.Modelo_Bicicleta_Color_Modelo_Bicicleta IS NULL))
    INNER JOIN ESTRESHADAS.Categoria_Bicicleta CB
        ON CB.id_cat_bicicleta = MO.id_cat_bicicleta
        AND CB.dscr_cat_bici = M.Categoria_Bicicleta_Categoria_Bicicleta
    INNER JOIN ESTRESHADAS.Local L
        ON L.nom_local = M.Local_Nombre_Local
    INNER JOIN ESTRESHADAS.Localidad LOC
        ON LOC.id_localidad = L.id_localidad
        AND LOC.nom_localidad = M.Local_Localidad
    INNER JOIN ESTRESHADAS.Provincia PROV
        ON PROV.id_provincia = LOC.id_provincia
        AND PROV.nom_provincia = M.Local_Provincia
    INNER JOIN ESTRESHADAS.Estado_Bicicleta EB
        ON EB.desc_est_bici = M.Estado_Bici_Alquiler_Estado_Bici_Alquiler
    WHERE M.Bicicleta_Alquiler_Nro_Serie_Bici_Alquiler IS NOT NULL;
END;
GO

CREATE PROCEDURE ESTRESHADAS.migracion_alquiler
AS
BEGIN
    INSERT INTO ESTRESHADAS.Alquiler (id_empleado, id_cliente, id_bici_alquiler, id_forma_pago, id_est_alquiler, fec_init, fec_devolucion, fec_real_devolucion, importe_alquiler, nro_alquiler)
    SELECT DISTINCT
        E.id_empleado,
        C.id_cliente,
        BA.id_bici_alquiler,
        FP.id_forma_pago,
        EA.id_est_alquiler,
        M.Alquiler_Fecha_Inicio_Alquiler,
        M.Alquiler_Fecha_Fin_Pactada_Alquiler,
        M.Alquiler_Fecha_Devolucion_Real_Alquiler,
        M.Alquiler_Importe_Total_Alquiler,
        M.Alquiler_Nro_Alquiler
    FROM gd_esquema.Maestra M
    INNER JOIN ESTRESHADAS.Empleado E
        ON E.dni_empleado = M.Empleado_Dni_Empleado
    INNER JOIN ESTRESHADAS.Cliente C
        ON C.dni_cliente = M.Cliente_Dni_Cliente
    INNER JOIN ESTRESHADAS.Bicicleta_Alquiler BA
        ON BA.nro_serie_bici_alquiler = M.Bicicleta_Alquiler_Nro_Serie_Bici_Alquiler
    INNER JOIN ESTRESHADAS.Forma_Pago FP
        ON FP.dscr_forma_pago = M.Forma_Pago_Forma_Pago
    INNER JOIN ESTRESHADAS.Estado_Alquiler EA
        ON EA.desc_est_alquiler = M.Estado_Alquiler_Estado_Alquiler
    WHERE M.Alquiler_Nro_Alquiler IS NOT NULL;
END;
GO

-- EJECUCION DE MIGRACIONES (ejecutar una sola vez)
EXEC ESTRESHADAS.migracion_provincia;
EXEC ESTRESHADAS.migracion_localidad;
EXEC ESTRESHADAS.migracion_local;
EXEC ESTRESHADAS.migracion_cliente;
EXEC ESTRESHADAS.migracion_empleado;
EXEC ESTRESHADAS.migracion_proveedor;
EXEC ESTRESHADAS.migracion_marca;
EXEC ESTRESHADAS.migracion_tipo_producto;
EXEC ESTRESHADAS.migracion_categoria_accesorio;
EXEC ESTRESHADAS.migracion_categoria_bicicleta;
EXEC ESTRESHADAS.migracion_forma_pago;
EXEC ESTRESHADAS.migracion_estado_bicicleta;
EXEC ESTRESHADAS.migracion_estado_alquiler;
EXEC ESTRESHADAS.migracion_estado_reparacion;
EXEC ESTRESHADAS.migracion_producto;
EXEC ESTRESHADAS.migracion_modelo;
EXEC ESTRESHADAS.migracion_accesorio;
EXEC ESTRESHADAS.migracion_bicicleta_venta;
EXEC ESTRESHADAS.migracion_bicicleta_alquiler;
EXEC ESTRESHADAS.migracion_compra;
EXEC ESTRESHADAS.migracion_detalle_compra;
EXEC ESTRESHADAS.migracion_venta;
EXEC ESTRESHADAS.migracion_det_venta;
EXEC ESTRESHADAS.migracion_categoria_repuesto;
EXEC ESTRESHADAS.migracion_repuesto;
EXEC ESTRESHADAS.migracion_reparacion;
EXEC ESTRESHADAS.migracion_detalle_reparacion;
EXEC ESTRESHADAS.migracion_alquiler;
GO
