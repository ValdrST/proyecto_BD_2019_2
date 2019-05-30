--@Autores: Mario Garrido, Vicente Romero
--@Fecha creación: 26/05/2019
--@Descripción: Script encargado de generar vistas
connect gr_proy_admin/bravo123
create or replace view aparatos_disponibles as--Vista de aparatos disponibles/ubi
select aparato_id, u.latitud, u.longitud
from aparato a
join ubicacion u using(aparato_id)
join estado e using(estado_id)
where e.clave='ENSP';
create or replace view aparato_info_publica as--Vista de informacion publica de aparatos
select a.aparato_id, a.capacidad, a.numero_matricula, a.porcentaje_carga, m.nombre as marca
from aparato a
join marca m using(marca_id);
create or replace view aparatos_recarga as--Vista de ubicacion de aparatos que necesitan recarga/ubi
select a.aparato_id, u.latitud, u.longitud
from aparato a
join ubicacion u using(aparato_id)
join estado e using(estado_id)
where e.clave='BATB';
