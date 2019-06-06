--@Autores: Mario Garrido, Vicente Romero
--@Fecha creación: 02/06/2019
--@Descripción: Programa que prueba el trigger de cambio de bateria.
connect gr_proy_admin/bravo123
set serveroutput on
define
v_estado_espera_id aparato.estado_id%type;
v_index aparato.aparato_id%type;
begin
  select estado_id
  into v_estado_espera_id
  from estado
  where estado.nombre='EN ESPERA';
  
  select aparato_id
  into v_index
  from aparato
  where estado_id=v_estado_espera_id and rownum < 2;
  dbms_output.put_line('Probando el aparato' || v_index || ' para el cambio de porcentaje de batería.');
dbms_output.put_line('Datos previos:');
  select *
  from aparato
  where aparato_id=v_index;

  update aparato
  set porcentaje_carga = 12.00
  where v_index = aparato_id;
dbms_output.put_line('Datos posteriores:');
  select *
  from aparato
  where aparato_id=v_index;

end;
/
