--@Autores: Mario Garrido, Vicente Romero
--@Fecha creación: 02/06/2019
--@Descripción: Programa que prueba el procedimiento de generacion de lista de recarga.
connect gr_proy_admin/bravo123
set serveroutput on
define
v_count numeric(4,0);
begin
  select count(*)
  into v_count
  from temporal_servicios_recarga;
  dbms_output.put_line('La tabla temporal tiene '||v_count||' registros.');
  p_genera_candidatos_recarga(dbms_random.value(-180,180),dbms_random.value(-90,90));
  dbms_output.put_line('Listo. La tabla temporal tiene ahora '||v_count||' registros.');
end;
/
