--@Autores: Mario Garrido, Vicente Romero
--@Fecha creación: 02/06/2019
--@Descripción: Programa que prueba el trigger de los reportes
connect gr_proy_admin/bravo123
set serveroutput on
declare 
    v_reporte_id number;
    v_puntos number;
    v_usuario_id number;

begin
    select reporte_id, usuario_id into v_reporte_id, v_usuario_id from reporte where rownum=1;
    select puntos into v_puntos from usuario where usuario_id = v_usuario_id;
    dbms_output.put_line('El usuario: ' || v_usuario_id || ' tiene ' ||v_puntos || ' puntos');
    update reporte set aceptado = 1 where reporte_id = v_reporte_id;
    select puntos into v_puntos from usuario where usuario_id = v_usuario_id;
    dbms_output.put_line('El usuario: ' || v_usuario_id || ' tiene ' ||v_puntos || ' puntos');
end;
/