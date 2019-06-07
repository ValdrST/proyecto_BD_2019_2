--@Autores: Mario Garrido, Vicente Romero
--@Fecha creación: 02/06/2019
--@Descripción: Programa que prueba el trigger de cambio de bateria.
connect gr_proy_admin/bravo123
set serveroutput on
declare
v_estado_espera_id aparato.estado_id%type;
v_index aparato.aparato_id%type;
v_estado_lectura aparato.estado_id%type;
v_porcentaje_carga aparato.porcentaje_carga%type;
begin
  select estado_id
  into v_estado_espera_id
  from estado
  where estado.nombre='EN ESPERA';
  select aparato_id
  into v_index
  from aparato
  where estado_id=v_estado_espera_id and rownum < 2;
  select porcentaje_carga
  into v_porcentaje_carga
  from aparato
  where aparato_id=v_index;


  dbms_output.put_line('Se encontró el aparato  ' || v_index || ' , con porcentaje de batería '|| v_porcentaje_carga ||' y estado en espera. Cambiando su porcentaje de bateria a 12%.');
  update aparato
  set porcentaje_carga = 12.00
  where v_index = aparato_id;

  select porcentaje_carga
  into v_porcentaje_carga
  from aparato
  where aparato_id=v_index;
  select estado_id
  into v_estado_lectura
  from aparato
  where aparato_id=v_index;

dbms_output.put_line('El aparato '||v_index||' ahora cuenta con un porcentaje de bateria de '||v_porcentaje_carga ||' y el id de estado '||v_estado_lectura);

end;
/
