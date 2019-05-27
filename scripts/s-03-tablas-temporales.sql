--@Autores: Mario Garrido, Vicente Romero
--@Fecha creación: 26/05/2019
--@Descripción: Script encargado de generar tabla temporal. Le da al usuario los 20 scooters con carga baja más cercanos para el servicio de recarga
create global temporary table temporal_servicios_recarga(
  aparato_id numeric(10,0) not null,
  numero_matriculo char(6) not null,
  latitud numeric(3,8) not null,
  longitud numeric(3,8) not null,
  constraint temporal_servicios_recarga_pk primary key (aparato_id),
  constraint temp_serv_rec_aparato_id_fk foreign key (aparato_id)
  references aparato(aparato_id)
)
on commit preserve rows;
