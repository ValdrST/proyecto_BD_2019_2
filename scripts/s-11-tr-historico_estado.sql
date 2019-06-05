--@Autores: Mario Garrido, Vicente Romero
--@Fecha creación: 02/06/2019
--@Descripción: Trigger encargado de bonificar al usuario en caso de aceptar reporte
create or replace trigger trg_historico_estado
    after insert or update of estado_id or delete on aparato
    for each row
    begin
        case 
            when inserting then 
                insert into estado_historico(estado_historico_id,estado_id,aparato_id) values (estado_historico_seq.nextval,:new.estado_id,:new.aparato_id);
            when updating('estado_id') then
                insert into estado_historico(estado_historico_id,estado_id,aparato_id) values (estado_historico_seq.nextval,:new.estado_id,:new.aparato_id);
            when deleting then
                delete from estado_historico where aparato_id = :old.aparato_id;
        end case; 
    end;
/
show errors