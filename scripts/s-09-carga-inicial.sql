--@Autor(es): Mario Garrido, Vicente Romero
--@Fecha creación: 25/05/2019
--@Descripción: Script que genera una carga inicial de datos
declare

begin
    insert into zona(zona_id, nombre, vertices) values (zona_seq.nextval,'zona 1','123243oij123.213321.123213.213123.123.1233213123');
    insert into zona(zona_id, nombre, vertices) values (zona_seq.nextval,'zona 2','123243oij123.213321.123213.213123.123.1233213123');
    insert into zona(zona_id, nombre, vertices) values (zona_seq.nextval,'zona 3','123243oij123.213321.123213.213123.123.1233213123');
    
    insert into estado(estado_id,clave,nombre,descripcion) values (estado_seq.nextval,'APGD','APAGADO','EL APARATO ESTA APAGADO');
    insert into estado(estado_id,clave,nombre,descripcion) values (estado_seq.nextval,'ENSP','EN ESPERA','EL APARATO ESTA EN ESPERA DE SERVICIO');
    insert into estado(estado_id,clave,nombre,descripcion) values (estado_seq.nextval,'ENSV','EN SERVICIO VIAJE','EL APARATO ESTA HACIENDO UN VIAJE DE SERVICIO');
    insert into estado(estado_id,clave,nombre,descripcion) values (estado_seq.nextval,'BATB','BATERIA BAJA','EL APARATO ESTA CON BATERIA BAJA');
    insert into estado(estado_id,clave,nombre,descripcion) values (estado_seq.nextval,'CNFL','CON FALLAS','EL APARATO TIENE FALLAS');
    insert into estado(estado_id,clave,nombre,descripcion) values (estado_seq.nextval,'ENSR','EN SERVICIO RENTA','EL APARATO ESTA RENTADO BAJO SERVICIO');
    insert into estado(estado_id,clave,nombre,descripcion) values (estado_seq.nextval,'ANSC','EN SERVICIO CARGA','EL APARATO ESTA EN SERVICIO DE CARGA DE BATERIA');

    insert into ubicacion(ubicacion_id,latitud,longitud,fecha_hora,aparato_id)
    insert into zona_aparato(zona_aparato_id,zona_id,aparato_id) values (zona_aparato_seq.nextval,zona_seq.currval,)
    
end;
/