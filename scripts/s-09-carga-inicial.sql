--@Autor(es): Mario Garrido, Vicente Romero
--@Fecha creación: 25/05/2019
--@Descripción: Script que genera una carga inicial de datos
declare
    type int_varray is varray(10) of number;
    
    v_estado int_varray;
    v_servicio int_varray;
    v_marca int_varray;
    v_zona int_varray;
    v_aparato int_varray;
    v_usuario int_varray;
begin
    v_estado := int_varray();
    v_marca := int_varray();
    v_zona := int_varray();
    v_aparato := int_varray();
    v_usuario := int_varray();
    v_servicio := int_varray();
    insert into zona(zona_id, nombre, vertices)
        values (zona_seq.nextval,'zona 1','123243oij123.213321.123213.213123.123.1233213123');
    v_zona.extend;
    v_zona(0) := zona_seq.currval;
    insert into zona(zona_id, nombre, vertices)
        values (zona_seq.nextval,'zona 2','123243oij123.213321.123213.213123.123.1233213123');
    v_zona.extend;
    v_zona(1) := zona_seq.currval;
    insert into zona(zona_id, nombre, vertices)
        values (zona_seq.nextval,'zona 3','123243oij123.213321.123213.213123.123.1233213123');
    v_zona.extend;
    v_zona(2) := zona_seq.currval;

    insert into estado(estado_id,clave,nombre,descripcion)
        values (estado_seq.nextval,'APGD','APAGADO','EL APARATO ESTA APAGADO');
    v_estado.extend;
    v_estado(0) := estado_seq.currval;
    insert into estado(estado_id,clave,nombre,descripcion)
        values (estado_seq.nextval,'ENSP','EN ESPERA','EL APARATO ESTA EN ESPERA DE SERVICIO');
    v_estado.extend;
    v_estado(1) := estado_seq.currval;
    insert into estado(estado_id,clave,nombre,descripcion)
        values (estado_seq.nextval,'ENSV','EN SERVICIO VIAJE','EL APARATO ESTA HACIENDO UN VIAJE DE SERVICIO');
    v_estado.extend;
    v_estado(2) := estado_seq.currval;
    insert into estado(estado_id,clave,nombre,descripcion)
        values (estado_seq.nextval,'BATB','BATERIA BAJA','EL APARATO ESTA CON BATERIA BAJA');
    v_estado.extend;
    v_estado(3) := estado_seq.currval;
    insert into estado(estado_id,clave,nombre,descripcion)
        values (estado_seq.nextval,'CNFL','CON FALLAS','EL APARATO TIENE FALLAS');
    v_estado.extend;
    v_estado(4) := estado_seq.currval;
    insert into estado(estado_id,clave,nombre,descripcion)
        values (estado_seq.nextval,'ENSR','EN SERVICIO RENTA','EL APARATO ESTA RENTADO BAJO SERVICIO');
    v_estado.extend;
    v_estado(5) := estado_seq.currval;
    insert into estado(estado_id,clave,nombre,descripcion)
        values (estado_seq.nextval,'ANSC','EN SERVICIO CARGA','EL APARATO ESTA EN SERVICIO DE CARGA DE BATERIA');
    v_estado.extend;
    v_estado(6) := estado_seq.currval;

    insert into marca(marca_id,nombre,telefono)
        values (marca_seq.nextval,'China scoot','5542383712');
    v_marca.extend;
    v_marca(0) := marca_seq.currval; 
    insert into marca(marca_id,nombre,telefono)
        values (marca_seq.nextval,'Korea mob','4342383712');
    v_marca.extend;
    v_marca(1) := marca_seq.currval;
    insert into marca(marca_id,nombre,telefono)
        values (marca_seq.nextval,'American electric','1423812176');
    v_marca.extend;
    v_marca(2) := marca_seq.currval;

    insert into usuario(usuario_id,email,nombre,apellidos,contraseña,puntos,es_socio) 
        values (usuario_seq.nextval,'usuario2@chinamail.com','Wey2','huang wo','$2y$10$WnH6o/Lp6RGXJPDXoDAh.eSukwP3G7TS1HfebKqbg1L5fHOR60cn2',0,1);
    insert into tarjeta(usuario_id,numero,mes_expiracion,año_expiracion) 
        values (usuario_seq.currval,'1233456789023221','20','03');
    v_usuario.extend;
    v_usuario(0) := usuario_seq.currval;
    insert into servicio(servicio_id,usuario_id,tipo) 
        values (servicio_seq.nextval,usuario_seq.currval,'C');
    insert into recarga(servicio_id,clabe,nombre_banco) 
        values (servicio_seq.currval,'312341232135657512','banco interacciones');
    v_servicio.extend;
    v_servicio(0) := servicio_seq.currval;

    insert into aparato(aparato_id,numero_serie,numero_matricula,codigo_acceso,capacidad,porcentaje_carga,estado_id,recarga_id,marca_id) 
        values (aparato_seq.nextval,'798217392873927323','764NNU','98173216492163921512374293715423',100.23,80,v_estado(0),v_servicio(0),v_marca(0));
    v_aparato.extend;
    v_aparato(0) := aparato_seq.currval;
    insert into aparato(aparato_id,numero_serie,numero_matricula,codigo_acceso,capacidad,porcentaje_carga,estado_id,recarga_id,marca_id) 
        values (aparato_seq.nextval,'798217392123927321','765NNU','98173216492163921242671293715423',78.23,80,v_estado(1),v_servicio(0),v_marca(1));
    v_aparato.extend;
    v_aparato(1) := aparato_seq.currval;
    insert into aparato(aparato_id,numero_serie,numero_matricula,codigo_acceso,capacidad,porcentaje_carga,estado_id,recarga_id,marca_id) 
        values (aparato_seq.nextval,'798217457287392732','766NNU','98173216492163543512371293715423',99.23,80,v_estado(1),v_servicio(0),v_marca(2));
    v_aparato.extend;
    v_aparato(2) := aparato_seq.currval;
    insert into usuario(usuario_id,email,nombre,apellidos,contraseña,puntos,es_socio)
        values (usuario_seq.nextval,'usuario@gmail.com','Wey1','huang li','$2y$10$O.VlBmZpTzPYNERjz/UCnO.zF5g8iBMtcuYfEyhnE9fj4adV.LuDC',0,0);
    insert into tarjeta(usuario_id,numero,mes_expiracion,año_expiracion)
        values (usuario_seq.currval,'1233456789023221','19','03');
    v_usuario.extend;
    v_usuario(1) := usuario_seq.currval;
    insert into servicio(servicio_id,usuario_id,tipo)
        values (servicio_seq.nextval,usuario_seq.currval,'V');
    insert into viaje(servicio_id,inicio,fin,folio,aparato_id)
        values (servicio_seq.currval,to_date('30-05-2019 12:00:33','dd-mm-yyyy hh24:mi:ss'),to_date('30-05-2019 12:00:33','dd-mm-yyyy hh24:mi:ss'),'1324123451293',v_aparato(1));
    v_servicio.extend;
    v_servicio(1) := servicio_seq.currval;
    

    insert into usuario(usuario_id,email,nombre,apellidos,contraseña,puntos,es_socio) 
        values (usuario_seq.nextval,'usuario@hotmail.com','Li','shin gon','$2y$10$O.VlBmZpTzPYNERjz/UCnO.zF5g8iBMtcuYfEyhnE9fj4adV.LuDC',10,0);
    insert into tarjeta_prepago(tarjeta_prepago_id,usuario_id,codigo_de_barras,fecha_registro,fecha_expiracion,importe) 
        values (tarjeta_prepago_seq.nextval,usuario_seq.currval,'223149981230971027321',to_date('03-03-2015','dd-mm-yyyy'),to_date('03-03-2020','dd-mm-yyyy'),3000.00);
    v_usuario.extend;
    v_usuario(2) := usuario_seq.currval;
    insert into servicio(servicio_id,usuario_id,tipo) 
        values (servicio_seq.nextval,usuario_seq.currval,'R');
    v_servicio.extend;
    v_servicio(2) := servicio_seq.currval;

    
    insert into ubicacion(ubicacion_id,latitud,longitud,fecha_hora,aparato_id)
        values (ubicacion_seq.nextval,130.000000,30.002300,sysdate,v_aparato(0));
    insert into ubicacion(ubicacion_id,latitud,longitud,fecha_hora,aparato_id)
        values (ubicacion_seq.nextval,130.000000,30.002300,sysdate,v_aparato(1));
    insert into ubicacion(ubicacion_id,latitud,longitud,fecha_hora,aparato_id)
        values (ubicacion_seq.nextval,130.000000,30.002300,sysdate,v_aparato(2));
    insert into zona_aparato(zona_aparato_id,zona_id,aparato_id)
        values (zona_aparato_seq.nextval,v_zona(2),v_aparato(0));
    insert into zona_aparato(zona_aparato_id,zona_id,aparato_id)
        values (zona_aparato_seq.nextval,v_zona(1),v_aparato(1));
    insert into zona_aparato(zona_aparato_id,zona_id,aparato_id)
        values (zona_aparato_seq.nextval,v_zona(2),v_aparato(2));
    
end;
/