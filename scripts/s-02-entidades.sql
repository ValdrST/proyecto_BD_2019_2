--@Autor(es): Mario Garrido, Vicente Romero
--@Fecha creación: 25/05/2019
--@Descripción: codigo DDL del caso de estudio donde se crean las tablas


CREATE TABLE MARCA(
    MARCA_ID NUMBER(10,0) CONSTRAINT MARCA_PK PRIMARY KEY,
    NOMBRE VARCHAR(60) NOT NULL CONSTRAINT MARCA_NOMBRE_UK UNIQUE,
    TELEFONO CHAR(10) NOT NULL
);

CREATE TABLE ESTADO(
    ESTADO_ID NUMBER(10,0) CONSTRAINT ESTADO_PK PRIMARY KEY,
    CLAVE CHAR(4) NOT NULL CONSTRAINT ESTADO_CLAVE_UK UNIQUE,
    NOMBRE VARCHAR(50) NOT NULL CONSTRAINT ESTADO_NOMBRE_UK UNIQUE,
    DESCRIPCION VARCHA(150) NOT NULL
);

CREATE TABLE USUARIO(
    USUARIO_ID NUMBER(10,0) CONSTRAINT USUARIO_PK PRIMARY KEY,
    EMAIL VARCHAR(60) NOT NULL CONSTRAINT USUARIO_EMAIL_UK UNIQUE,
    NOMBRE VARCHAR(50) NOT NULL,
    APELLIDOS VARCHAR(60) NOT NULL,
    CONTRASEÑA CHAR(60) NOT NULL,
    PUNTOS NUMBER(10,0) NOT NULL,
    ES_SOCIO NUMBER(1,0) NOT NULL
);

CREATE TABLE SERVICIO(
    SERVICIO_ID NUMBER(10,0) CONSTRAINT SERVICIO_PK PRIMARY KEY,
    USUARIO_ID NUMBER(10,0) NOT NULL,
    TIPO CHAR(1) NOT NULL,
    CONSTRAINT SERVICIO_USUARIO_ID_FK FOREIGN KEY (USUARIO_ID) REFERENCES USUARIO(USUARIO_ID),
    CONSTRAINT SERVICIO_TIPO_CHK CHECK( TIPO IN ('C','V','R'))
);

CREATE TABLE RECARGA(
    SERVICIO_ID NUMBER(10,0) CONSTRAINT RECARGA_PK PRIMARY KEY,
    CLABE CHAR(18) NOT NULL,
    NOMBRE_BANCO VARCHAR(60) NOT NULL,
    CONSTRAINT RECARGA_SERVICIO_ID_FK FOREIGN KEY (SERVICIO_ID) REFERENCES SERVICIO(SERVICIO_ID)
);

CREATE TABLE APARATO(
    APARATO_ID NUMBER(10,0) CONSTRAINT APARATO_PK PRIMARY KEY,
    NUMERO_SERIE CHAR(18) NOT NULL CONSTRAINT APARATO_NUMERO_SERIE_UK UNIQUE,
    NUMERO_MATRICULA CHAR(6) NOT NULL CONSTRAINT APARATO_NUMERO_MATRICULA_UK UNIQUE,
    CODIGO_ACCESO VARCHAR(32) NOT NULL CONSTRAINT APARATO_CODIGO_ACCESO_UK UNIQUE,
    CAPACIDAD NUMBER(3,2) NOT NULL,
    PORCENTAJE_CARGA NUMBER(3,0) NOT NULL,
    ESTADO_ID NUMBER(10,0) NOT NULL,
    RECARGA_ID NUMBER(10,0) NOT NULL,
    MARCA_ID NUMBER(10,0) NOT NULL,
    CONSTRAINT APARATO_PORCENTAJE_CARGA_CHK CHECK (PORCENTAJE_CARGA <= 100 AND PORCENTAJE_CARGA >= 0),
    CONSTRAINT APARATO_CAPACIDAD_CHK CHECK (CAPACIDAD > 0),
    CONSTRAINT APARATO_ESTADO_ID_FK FOREIGN KEY(ESTADO_ID) REFERENCES ESTADO(ESTAOD_ID),
    CONSTRAINT APARATO_MARCA_ID_FK FOREIGN KEY(MARCA_ID) REFERENCES MARCA(MARCA_ID),
    CONSTRAINT APARATO_RECARGA_ID_FK FOREIGN KEY(RECARGA_ID) REFERENCES RECARGA(SERVICIO_ID)
);

CREATE TABLE ESTADO_HISTORICO(
    ESTADO_HISTORICO_ID NUMBER(10,0) CONSTRAINT ESTADO_HISTORICO_PK PRIMARY KEY,
    ESTADO_ID NUMBER(10,0) NOT NULL,
    FECHA_ESTADO DATE DEFAULT SYSDATE,
    APARATO_ID NUMBER(10,0) NOT NULL,
    CONSTRAINT ESTADO_HISTORICO_ESTADO_ID_FK FOREIGN KEY(ESTADO_ID) REFERENCES ESTADO(ESTADO_ID),
    CONSTRAINT ESTADO_HISTORICO_APARATO_ID_FK FOREIGN KEY(APARATO_ID) REFERENCES APARATO(APARATO_ID)
);

CREATE TABLE ZONA(
    ZONA_ID NUMBER(10,0) CONSTRAINT ZONA_PK PRIMARY KEY,
    NOMBRE VARCHAR(50) NOT NULL CONSTRAINT ZONA_NOMBRE_UK UNIQUE,
    VERTICES CLOB NOT NULL
);

CREATE TABLE ZONA_APARATO(
    ZONA_APARATO_ID NUMBER(10,0) CONSTRAINT ZONA_APARATO_PK PRIMARY KEY,
    ZONA_ID NUMBER(10,0) NOT NULL,
    APARATO_ID NUMBER(10,0) NOT NULL,
    CONSTRAINT ZONA_APARATO_ZONA_ID_FK FOREIGN KEY(ZONA_ID) REFERENCES ZONA(ZONA_ID),
    CONSTRAINT ZONA_APARATO_APARATO_ID_FK FOREIGN KEY(APARATO_ID) REFERENCES APARATO(APARATO_ID)
);

CREATE TABLE UBICACION(
    UBICACION_ID NUMBER(10,0) CONSTRAINT UBICACION_PK PRIMARY KEY,
    LATITUD NUMBER(11,8) NOT NULL,
    LONGITUD NUMBER(11,8) NOT NULL,
    FECHA_HORA DATE NOT NULL DEFAULT SYSDATE,
    APARATO_ID NUMBER(10,0) NOT NULL,
    COORDENADAS VARCHAR2(24) GENERATED ALWAYS AS (TO_CHAR(LATITUD)||','||TO_CHAR(LONGITUD)) VIRTUAL,
    CONSTRAINT UBICACION_LATITUD_CHK CHECK (LATITUD <= 180 AND LATITUD >= 0),
    CONSTRAINT UBICACION_LONGITUD_CHK CHECK (LONGITUD <= 180 AND LONGITUD >= 0),
    CONSTRAINT UBICACION_APRATO_ID_FK FOREIGN KEY(APARATO_ID) REFERENCES APARATO(APARATO_ID)
);

CREATE TABLE REEMPLAZO(
    REEMPLAZO_ID NUMBER(10,0) CONSTRAINT REEMPLAZO_PK PRIMARY KEY,
    APARATO_VIEJO NUMBER(10,0) NOT NULL CONSTRAINT APARATO_APARATO_VIEJO_UK UNIQUE,
    APARATO_NUEVO NUMBER(10,0) NOT NULL CONSTRAINT APARATO_APARATO_NUEVO_UK UNIQUE,
    CONSTRAINT REEMPLAZO_APARATO_VIEJO_FK FOREIGN KEY(APARATO_VIEJO) REFERENCES APARATO(APARATO_ID),
    CONSTRAINT REEMPLAZO_APARATO_NUEVO_FK FOREIGN KEY(APARATO_NUEVO) REFERENCES APARATO(APARATO_ID)
);

CREATE TABLE TARJETA(
    USUARIO_ID NUMBER(10,0) CONSTRAINT TARJETA_PK PRIMARY KEY,
    NUMERO CHAR(16) NOT NULL CONSTRAINT TARJETA_NUMERO_UK UNIQUE,
    AÑO_EXPIRACION CHAR(2) NOT NULL,
    MES_EXPIRACION CHAR(2) NOT NULL,
    CONSTRAINT TARJETA_MES_EXPIRACION_CHK CHECK (TO_NUMBER(MES_EXPIRACION) <= 12 AND TO_NUMBER(MES_EXPIRACION) > 0),
    CONSTRAINT TARJETA_USUARIO_ID FOREIGN KEY (USUARIO_ID) REFERENCES USUARIO(USUARIO_ID)
);

CREATE TABLE TARJETA_PREPAGO(
    TARJETA_PREPAGO_ID NUMBER(10,0) CONSTRAINT TARJETA_PREPAGO_PK PRIMARY KEY,
    USUARIO_ID NUMERIC(10,0) NOT NULL,
    CODIGO_DE_BARRAS CHAR(21) NOT NULL CONSTRAINT TARJETA_PREPAGO_CODIGO_DE_BARRAS_UK UNIQUE,
    FECHA_REGISTRO DATE NOT NULL DEFAULT SYSDATE,
    FECHA_EXPIRACION DATE NOT NULL,
    IMPORTE NUMBER(16,2) NOT NULL DEFAULT 0,
    CONSTRAINT TARJETA_PREPAGO_USUARIO_ID_FK FOREIGN KEY (USUARIO_ID) REFERENCES USUARIO(USUARIO_ID)
);

CREATE TABLE REPORTE(
    REPORTE_ID NUMBER(10,0) CONSTRAINT REPORTE_PK PRIMARY KEY,
    USUARIO_ID NUMBER(10,0) NOT NULL,
    APARATO_ID NUMBER(10,0) NOT NULL,
    FECHA DATE NOT NULL DEFAULT SYSDATE,
    LATITUD NUMBER(11,8) NULL,
    LONGITUD NUMBER(11,8) NULL,
    DESCRIPCION VARCHAR(200) NOT NULL
);

CREATE TABLE IMAGEN_REPORTE(
    IMAGEN_REPORTE_ID NUMBER(10,0) CONSTRAINT IMAGEN_REPORTE_PK PRIMARY KEY,
    REPORTE_ID NUMBER(10,0) NOT NULL,
    IMAGEN BLOB NOT NULL,
    CONSTRAINT IMAGEN_REPORTE_REPORTE_ID_FK FOREIGN KEY (REPORTE_ID) REFERENCES REPORTE(REPORTE_ID)
);

CREATE TABLE VIAJE(
    SERVICIO_ID NUMBER(10,0) CONSTRAINT VIAJE_PK PRIMARY KEY,
    INICIO DATE NOT NULL,
    FIN DATE NOT NULL,
    FOLIO CHAR(13) NOT NULL,
    APARATO_ID NUMBER(10,0) NOT NULL,
    DURACION_VIAJE DATE GENERATED ALWAYS AS (FIN - INICIO) VIRTUAL,
    CONSTRAINT VIAJE_SERVICIO_ID_FK FOREIGN KEY (SERVICIO_ID) REFERENCES SERVICIO(SERVICIO_ID),
    CONSTRAINT VIAJE_APARATO_ID_FK FOREIGN KEY (APARATO_ID) REFERENCES APARATO(APARATO_ID)
);

CREATE TABLE RENTA(
    SERVICIO_ID NUMBER(10,0) CONSTRAINT RENTA_PK PRIMARY KEY,
    INICIO DATE NOT NULL,
    DIAS_CUSTODIO NUMBER(10,0) NOT NULL,
    DIRECCION VARCHAR(100) NOT NULL,
    APARATO_ID NUMBER(10,0) NOT NULL,
    CONSTRAINT RENTA_SERVICIO_ID_FK FOREIGN KEY (SERVICIO_ID) REFERENCES SERVICIO(SERVICIO_ID),
    CONSTRAINT RENTA_APARATO_ID_FK FOREIGN KEY (APARATO_ID) REFERENCES APARATO(APARATO_ID)
);