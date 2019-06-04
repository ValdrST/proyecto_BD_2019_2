--@Autores: Mario Garrido, Vicente Romero
--@Fecha creación: 02/06/2019
--@Descripción: Trigger encargado de validar que el servicio de recarga se asigne a un socio y no sean mas de 20 scooters
create or replace trigger trg_bonificacion_reporte
    after update of aceptado on reporte
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
            if :new.aceptado = 1 then
                update usuario set puntos = v_puntos + 1000 where usuario_id = :new.usuario_id;
                dbms_output.put_line('usuario bonificado');
            end if;
        end loop;
        close cur_usuario;
    end;
/
show errors