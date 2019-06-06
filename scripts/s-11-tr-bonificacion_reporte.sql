--@Autores: Mario Garrido, Vicente Romero
--@Fecha creación: 02/06/2019
--@Descripción: Trigger encargado de bonificar al usuario en caso de aceptar reporte
connect gr_proy_admin/bravo123
set serveroutput on
create or replace trigger trg_bonificacion_reporte
    before update of aceptado on reporte
    for each row
    declare 
        cursor cur_usuario is
            select puntos from usuario where usuario_id = :new.usuario_id;
        v_puntos usuario.puntos%type;
    begin
        open cur_usuario;
        loop
            fetch cur_usuario into
                v_puntos;
            exit when cur_usuario%notfound;
            if :new.aceptado = 1 and :old.aceptado = 0 then
                update usuario set puntos = v_puntos + 1000 where usuario_id = :new.usuario_id;
                dbms_output.put_line('usuario bonificado');
            end if;
        end loop;
        close cur_usuario;
    end;
/
show errors