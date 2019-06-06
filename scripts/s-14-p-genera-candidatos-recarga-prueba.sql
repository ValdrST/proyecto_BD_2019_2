--@Autores: Mario Garrido, Vicente Romero
--@Fecha creación: 02/06/2019
--@Descripción: Programa que prueba el procedimiento de generacion de lista de recarga.
connect gr_proy_admin/bravo123
set serveroutput on
begin
  p-genera-candidatos-recarga(dbms_random.value(-180,180),latitud-dbms_random.value(-90,90));
  select *
  from temporal_servicios_recarga;
end;
/
