--@Autores: Mario Garrido, Vicente Romero
--@Fecha creación: 02/06/2019
--@Descripción: Programa que prueba el trigger del servicio de recarga
connect gr_proy_admin/bravo123
set serveroutput on
declare 
    v_reporte_id number;
    v_num_aparatos number;
    v_servicio_id number;
    v_marca_id number;
    v_estado_id number;
begin
    select servicio_id into v_servicio_id from recarga where rownum=1;
    select marca_id into v_marca_id from marca where rownum=1;
    select estado_id into v_estado_id from estado where clave = 'ENSP';
    for i in 100 .. 120 loop
        select count(recarga_id) into v_num_aparatos from aparato where recarga_id = v_servicio_id;
        insert into aparato(aparato_id,numero_serie,numero_matricula,codigo_acceso,capacidad,porcentaje_carga,estado_id,recarga_id,marca_id) 
        values (aparato_seq.nextval,'798217392873927'||i,i||'NNU','98173216'||i||'163921512374293715423',100.23,80,v_estado_id,v_servicio_id,v_marca_id);
        dbms_output.put_line('El servicio: ' || v_servicio_id || ' tiene ' ||v_num_aparatos || ' aparatos');
    end loop;
end;
/