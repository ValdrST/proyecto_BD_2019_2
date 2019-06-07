--@Autores: Mario Garrido, Vicente Romero
--@Fecha creación: 02/06/2019
--@Descripción: Programa que prueba la funcion de distancias.
connect gr_proy_admin/bravo123
set serveroutput on
declare 
    v_longitud numeric(11,8);
    v_latitud numeric(11,8);
begin
  v_longitud:=dbms_random.value(-180,180);
  v_latitud:=dbms_random.value(-90,90);
  dbms_output.put_line('La distancia de (' || v_latitud || ','|| v_longitud || ') a (0,0) es de: '|| fx_distancia_metros(0,0,v_latitud,v_longitud) || ' metros.');
end;
/
