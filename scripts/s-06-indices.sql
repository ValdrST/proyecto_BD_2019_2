--@Autor(es): Mario Garrido, Vicente Romero
--@Fecha creación: 25/05/2019
--@Descripción: Creacion de indices
create unique index zona_aparato_zona_aparato_id_iux on zona_aparato(zona_id,aparato_id);
create unique index usuario_email_iux on usuario(lower(email));
create index servicio_usuario_id_ix on servicio(usuario_id);
create index viaje_aparato_id_ix on viaje(aparato_id);
create index renta_aparato_id_ix on renta(aparato_id);
create index ubicacion_aparato_id_ix on ubicacion(aparato_id);
create index aparato_numero_matricula_ix on aparato(upper(numero_matricula));
