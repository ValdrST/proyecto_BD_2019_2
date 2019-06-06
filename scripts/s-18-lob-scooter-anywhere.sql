set serveroutput on
declare
    v_nombre varchar(200):= 'prueba.png';
    v_reporte_id number;
    v_tamaño number;
begin
    select reporte_id into v_reporte_Id from reporte;
    p_inserta_imagen(v_reporte_id,v_nombre);
    select dbms_lob.getlength(imagen) as longitud_imagen into v_tamaño from imagen_reporte where reporte_id = v_reporte_id and rownum=1;
    dbms_output.put_line('El tamaño de '|| v_nombre || ' es ' || v_tamaño);
end;
/
show errors