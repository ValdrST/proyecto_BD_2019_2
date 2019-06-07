--@Autores: Mario Garrido, Vicente Romero
--@Fecha creación: 26/05/2019
--@Descripción: Procedimiento que llena la tabla temporal del usuario de los 20 scooters más cercanos con batería baja.
connect gr_proy_admin/bravo123
create or replace procedure p_genera_candidatos_recarga(p_longitud in numeric, p_latitud in numeric)
is
v_estado_bat_baja_id aparato.estado_id%type;
begin
  select estado_id
  into v_estado_bat_baja_id
  from estado
  where estado.nombre='BATERIA BAJA';

  insert into temporal_servicios_recarga (aparato_id,numero_matricula,latitud,longitud)
  select * from (
    select aparato_id, numero_matricula,latitud,longitud
    from(
      select aparato_id, numero_matricula, latitud, longitud, 
      fx_distancia_metros(p_latitud,p_longitud,latitud,longitud) as distancia
      from aparato a
      join ubicacion using(aparato_id)
      where estado_id = v_estado_bat_baja_id
     ) order by distancia asc
  )where rownum <21;
end;
/
show errors
