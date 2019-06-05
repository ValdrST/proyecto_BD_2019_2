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
declare 
  cursor cur_user_table is
    select table_name from user_tables;
  v_table_name user_tables.table_name%type;

begin
  open cur_user_table;
  loop
    fetch cur_user_table into 
      v_table_name;
    exit when cur_user_table%notfound;
    execute immediate 'create synonym XX_'||v_table_name||' for '||v_table_name;
  end loop;
  close cur_user_table;
end;
/