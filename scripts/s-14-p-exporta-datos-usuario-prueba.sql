--@Autores: Mario Garrido, Vicente Romero
--@Fecha creación: 02/06/2019
--@Descripción: Programa que prueba el procedimiento de exportacion de datos de usuario.
connect gr_proy_admin/bravo123
set serveroutput on
declare 
    v_usuario_id numeric(10);
begin
  select usuario_id
  into v_usuario_id
  from usuario
  where rownum <2;
  p_exporta_datos_usuario(v_usuario_id);
  dbms_output.put_line('Listo. Revisar el archivo generado.');
end;
/
