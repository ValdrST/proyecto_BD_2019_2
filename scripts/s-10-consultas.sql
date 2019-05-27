--@Autores: Mario Garrido, Vicente Romero
--@Fecha creación: 26/05/2019
--@Descripción: Script encargado de realizar consultas.
connect gr_proy_admin/bravo123
--Consulta que muestra todos los usuarios y el numero de servicios (x servicio)
select *
from(
  (select usuario_id, count(*) as cuenta_recarga
  from servicio
  where tipo='C'
  group by usuario_id) c
  join (
  select usuario_id, count(*) as cuenta_viaje
  from servicio
  where tipo='V'
  group by usuario_id) v
  on c.usuario_id=v.usuario_id
  join (
  select usuario_id, count(*) as cuenta_renta
  from servicio
  where tipo='R'
  group by usuario_id) r
  on c.usuario_id=r.usuario_id
);
--Consulta que muestra todos los servicios del usuario (con detalles)
select *
from servicio
left outer join recarga using(servicio_id)
left outer join viaje using(servicio_id)
left outer join renta using(servicio_id);
connect gr_proy_invitado/bravo123
--Consulta que da al usuario los datos del scooter disponible más cercano con la capacidad de carga requerida por el usuario. Nota: En este caso de estudio se aleatorizará la capacidad y localización del usuario.
select *
from(
  select aparato_id, numero_matriculo, latitud, longitud, (sqrt(longitud-dbms_random.value(-180,180))
  + sqrt(latitud-dbms_random.value(-90,90))) as distancia_cuadrada
  from(
    aparatos_disponibles a
    right join(
      select aparato_id
      from aparato_info_publica
      where capacidad >= floor(dbms_random.value(1, 999))
      intersect
      select aparato_id
      from aparatos_disponibles) b
    on a.aparato_id = b.aparato_id)
)order by distancia_cuadrada asc;

