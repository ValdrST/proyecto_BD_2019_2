--@Autores: Mario Garrido, Vicente Romero
--@Fecha creación: 26/05/2019
--@Descripción: Funcion que genera el folio de un servicio de viaje.
connect gr_proy_admin/bravo123
create or replace function fx-folio(p_servicio_id in date)
return char is
v_folio char(13);
v_random char(3);
begin
  select dbms.random_string('A', 3)
  into v_random
  from dual;
  v_folio := (p_servicio_id || v_random);
  return v_folio;
end;
/
show errors


