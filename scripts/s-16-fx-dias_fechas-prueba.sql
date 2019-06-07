--@Autores: Mario Garrido, Vicente Romero
--@Fecha creación: 02/06/2019
--@Descripción: Programa que prueba la funcion de fechas.
connect gr_proy_admin/bravo123
set serveroutput on
declare 
    v_f1 date;
    v_f2 date;
begin
  v_f1:=to_date('2010-01-01', 'yyyy-mm-dd')+trunc(dbms_random.value(1,1000));
  v_f2:=to_date('2010-01-01', 'yyyy-mm-dd')+trunc(dbms_random.value(1,1000));
  dbms_output.put_line('Entre las fechas ' || to_char(v_f1,'YYYY/MM/DD') || ' y '|| to_char(v_f2,'YYYY/MM/DD') || ' hay '|| dias_fechas(v_f1,v_f2) || ' días.');
end;
/
