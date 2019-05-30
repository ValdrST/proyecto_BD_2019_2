--@Autores: Mario Garrido, Vicente Romero
--@Fecha creación: 26/05/2019
--@Descripción: Script encargado de generar sinónimos.
connect gr_proy_admin/bravo123
create or replace public synonym estado for estado;
create or replace public synonym zona_aparato for zona_aparato;
create or replace public synonym zona for zona;
grant select on estado to gr_proy_invitado;
grant select on zona_aparato to gr_proy_invitado;
grant select on zona to gr_proy_invitado;
connect gr_proy_invitado/bravo123
create or replace synonym estado for gr_proy_admin.estado;
create or replace synonym zona_aparato for gr_proy_admin.zona_aparato;
create or replace synonym zona for gr_proy_admin.zona;
connect gr_proy_admin/bravo123
begin
  set echo off
  set pagesize 0
  set linesize 1000
  execute immediate spool s-07-2-sinonimos.sql;
  select 'create public synonym XX_' || table_name || ' for ' || owner || '.' || table_name || ';'
  from all_tables where owner='gr_proy_admin';
  spool off
  @s-07-2-sinonimos.sql
end;
/
