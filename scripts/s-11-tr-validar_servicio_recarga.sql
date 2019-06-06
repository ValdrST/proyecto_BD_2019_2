--@Autores: Mario Garrido, Vicente Romero
--@Fecha creación: 02/06/2019
--@Descripción: Trigger encargado de validar que el servicio no sean de mas de 20 scooters
connect gr_proy_admin/bravo123
create or replace trigger validar_servicio_recarga
    before update or insert of recarga_id on aparato
    for each row
    declare 
        cursor cur_num_aparatos_servicio_carga is
            select count(recarga_id) from aparato where recarga_id = :new.recarga_id;
        v_num_aparatos number;
    begin
        open cur_num_aparatos_servicio_carga;
        loop
            fetch cur_num_aparatos_servicio_carga into
                v_num_aparatos;
            exit when cur_num_aparatos_servicio_carga%notfound;
            if v_num_aparatos > 20 then
                raise_application_error(-20011, 'El servicio ya tiene su maxima capacidad de aparatos');
            end if;
        end loop;
        close cur_num_aparatos_servicio_carga;
    end;
/
show errors