--@Autores: Mario Garrido, Vicente Romero
--@Fecha creación: 02/06/2019
--@Descripción: Programa que prueba la funcion de los folios
connect gr_proy_admin/bravo123
set serveroutput on
declare 
    v_servicio_id char;
begin
  select servicio_id
  into v_servicio_id
  from viaje
  where rownum <2;
  dbms_output.put_line('Folio del viaje ' || v_servicio_id || ' es: '|| fx-folio(v_servicio_id));
end;
/
