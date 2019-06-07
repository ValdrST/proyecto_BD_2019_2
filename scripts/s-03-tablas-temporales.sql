--@Autores: Mario Garrido, Vicente Romero
--@Fecha creación: 26/05/2019
--@Descripción: Script encargado de generar tabla temporal. Le da al usuario los 20 scooters con carga baja más cercanos para el servicio de recarga
connect gr_proy_admin/bravo123
create global temporary table temporal_servicios_recarga(
  aparato_id numeric(10,0) not null,
  numero_matricula char(6) not null,
  latitud numeric(11,8) not null,
  longitud numeric(11,8) not null
)
on commit preserve rows;
