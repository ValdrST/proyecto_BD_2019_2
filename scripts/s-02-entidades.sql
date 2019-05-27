--@Autor(es): Mario Garrido, Vicente Romero
--@Fecha creación: 25/05/2019
--@Descripción: codigo DDL del caso de estudio donde se crean las tablas


create table marca(
    marca_id number(10,0) constraint marca_pk primary key,
    nombre varchar(60) not null constraint marca_nombre_uk unique,
    telefono char(10) not null
);

create table estado(
    estado_id number(10,0) constraint estado_pk primary key,
    clave char(4) not null constraint estado_clave_uk unique,
    nombre varchar(50) not null constraint estado_nombre_uk unique,
    descripcion varchar(150) not null
);

create table usuario(
    usuario_id number(10,0) constraint usuario_pk primary key,
    email varchar(60) not null constraint usuario_email_uk unique,
    nombre varchar(50) not null,
    apellidos varchar(60) not null,
    contraseña char(60) not null,
    puntos number(10,0) not null,
    es_socio number(1,0) not null
);

create table servicio(
    servicio_id number(10,0) constraint servicio_pk primary key,
    usuario_id number(10,0) not null,
    tipo char(1) not null,
    constraint servicio_usuario_id_fk foreign key (usuario_id) references usuario(usuario_id),
    constraint servicio_tipo_chk check( tipo in ('c','v','r'))
);

create table recarga(
    servicio_id number(10,0) constraint recarga_pk primary key,
    clabe char(18) not null,
    nombre_banco varchar(60) not null,
    constraint recarga_servicio_id_fk foreign key (servicio_id) references servicio(servicio_id)
);

create table aparato(
    aparato_id number(10,0) constraint aparato_pk primary key,
    numero_serie char(18) not null constraint aparato_numero_serie_uk unique,
    numero_matricula char(6) not null constraint aparato_numero_matricula_uk unique,
    codigo_acceso varchar(32) not null constraint aparato_codigo_acceso_uk unique,
    capacidad number(3,2) not null,
    porcentaje_carga number(3,0) not null,
    estado_id number(10,0) not null,
    recarga_id number(10,0) not null,
    marca_id number(10,0) not null,
    constraint aparato_porcentaje_carga_chk check (porcentaje_carga <= 100 and porcentaje_carga >= 0),
    constraint aparato_capacidad_chk check (capacidad > 0),
    constraint aparato_estado_id_fk foreign key(estado_id) references estado(estaod_id),
    constraint aparato_marca_id_fk foreign key(marca_id) references marca(marca_id),
    constraint aparato_recarga_id_fk foreign key(recarga_id) references recarga(servicio_id)
);

create table estado_historico(
    estado_historico_id number(10,0) constraint estado_historico_pk primary key,
    estado_id number(10,0) not null,
    fecha_estado date default sysdate,
    aparato_id number(10,0) not null,
    constraint estado_historico_estado_id_fk foreign key(estado_id) references estado(estado_id),
    constraint estado_historico_aparato_id_fk foreign key(aparato_id) references aparato(aparato_id)
);

create table zona(
    zona_id number(10,0) constraint zona_pk primary key,
    nombre varchar(50) not null constraint zona_nombre_uk unique,
    vertices clob not null
);

create table zona_aparato(
    zona_aparato_id number(10,0) constraint zona_aparato_pk primary key,
    zona_id number(10,0) not null,
    aparato_id number(10,0) not null,
    constraint zona_aparato_zona_id_fk foreign key(zona_id) references zona(zona_id),
    constraint zona_aparato_aparato_id_fk foreign key(aparato_id) references aparato(aparato_id)
);

create table ubicacion(
    ubicacion_id number(10,0) constraint ubicacion_pk primary key,
    latitud number(11,8) not null,
    longitud number(11,8) not null,
    fecha_hora date not null default sysdate,
    aparato_id number(10,0) not null,
    coordenadas varchar2(24) generated always as (to_char(latitud)||','||to_char(longitud)) virtual,
    constraint ubicacion_latitud_chk check (latitud <= 180 and latitud >= 0),
    constraint ubicacion_longitud_chk check (longitud <= 180 and longitud >= 0),
    constraint ubicacion_aprato_id_fk foreign key(aparato_id) references aparato(aparato_id)
);

create table reemplazo(
    reemplazo_id number(10,0) constraint reemplazo_pk primary key,
    aparato_viejo number(10,0) not null constraint aparato_aparato_viejo_uk unique,
    aparato_nuevo number(10,0) not null constraint aparato_aparato_nuevo_uk unique,
    constraint reemplazo_aparato_viejo_fk foreign key(aparato_viejo) references aparato(aparato_id),
    constraint reemplazo_aparato_nuevo_fk foreign key(aparato_nuevo) references aparato(aparato_id)
);

create table tarjeta(
    usuario_id number(10,0) constraint tarjeta_pk primary key,
    numero char(16) not null constraint tarjeta_numero_uk unique,
    año_expiracion char(2) not null,
    mes_expiracion char(2) not null,
    constraint tarjeta_mes_expiracion_chk check (to_number(mes_expiracion) <= 12 and to_number(mes_expiracion) > 0),
    constraint tarjeta_usuario_id foreign key (usuario_id) references usuario(usuario_id)
);

create table tarjeta_prepago(
    tarjeta_prepago_id number(10,0) constraint tarjeta_prepago_pk primary key,
    usuario_id numeric(10,0) not null,
    codigo_de_barras char(21) not null constraint tarjeta_prepago_codigo_de_barras_uk unique,
    fecha_registro date not null default sysdate,
    fecha_expiracion date not null,
    importe number(16,2) not null default 0,
    constraint tarjeta_prepago_usuario_id_fk foreign key (usuario_id) references usuario(usuario_id)
);

create table reporte(
    reporte_id number(10,0) constraint reporte_pk primary key,
    usuario_id number(10,0) not null,
    aparato_id number(10,0) not null,
    fecha date not null default sysdate,
    latitud number(11,8) null,
    longitud number(11,8) null,
    descripcion varchar(200) not null
);

create table imagen_reporte(
    imagen_reporte_id number(10,0) constraint imagen_reporte_pk primary key,
    reporte_id number(10,0) not null,
    imagen blob not null,
    constraint imagen_reporte_reporte_id_fk foreign key (reporte_id) references reporte(reporte_id)
);

create table viaje(
    servicio_id number(10,0) constraint viaje_pk primary key,
    inicio date not null,
    fin date not null,
    folio char(13) not null,
    aparato_id number(10,0) not null,
    duracion_viaje date generated always as (fin - inicio) virtual,
    constraint viaje_servicio_id_fk foreign key (servicio_id) references servicio(servicio_id),
    constraint viaje_aparato_id_fk foreign key (aparato_id) references aparato(aparato_id)
);

create table renta(
    servicio_id number(10,0) constraint renta_pk primary key,
    inicio date not null,
    dias_custodio number(10,0) not null,
    direccion varchar(100) not null,
    aparato_id number(10,0) not null,
    constraint renta_servicio_id_fk foreign key (servicio_id) references servicio(servicio_id),
    constraint renta_aparato_id_fk foreign key (aparato_id) references aparato(aparato_id)
);
