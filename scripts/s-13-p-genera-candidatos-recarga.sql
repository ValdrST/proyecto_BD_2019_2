--@Autores: Mario Garrido, Vicente Romero
--@Fecha creación: 26/05/2019
--@Descripción: Procedimiento que llena la tabla temporal del usuario de los 20 scooters más cercanos con batería baja.
connect gr_proy_admin/bravo123
create or replace procedure p-genera-candidatos-recarga(p_longitud in numeric(11,8), p_latitud in numeric(11,8))
is
  type scooter_type is record (
  aparato_id numeric(10,0),
  numero_matricula char(6),
  latitud numeric(3,8),
  longitud numeric(3,8)
  );
v_estado_bat_baja_id aparato.estado_id%type;
begin
  select estado_id
  into v_estado_bat_baja_id
  from estado
  where estado.nombre='BATERIA BAJA';
  insert into temporal_servicios_recarga
  select aparato_id, numero_matricula, latitud, longitud
  from(
  select a.aparato_id, numero_matricula, latitud, longitud, (power(longitud-p_longitud,2)
  + power(latitud-p_latitud,2)) as distancia_cuadrada
  from(
    select *
    from aparato
    where estado_id = v_estado_bat_baja_id
    join ubicacion using(aparato_id)
  ) a order by distancia_cuadrada asc
  where rownum < 21;
end;
/
show errors
