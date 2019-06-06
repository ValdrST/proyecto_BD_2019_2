--@Autores: Mario Garrido, Vicente Romero
--@Fecha creación: 26/05/2019
--@Descripción: Funcion que retorna el folio unico generado para el viaje
connect gr_proy_admin/bravo123
create or replace function folio_viaje
return varchar is
v_folio varchar(13);
begin
    v_folio := (to_char(sysdate,'yymmddHH24MISS')||trunc(dbms_random.value(1,10)));
  return v_folio;
end;
/
show errors