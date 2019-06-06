--@Autor(es): Mario Garrido, Vicente Romero
--@Fecha creación: 26/05/2019
--@Descripción: Script encargado de cargar una imagen a la BD.Z
connect gr_proy_admin/bravo123
create or replace procedure p_inserta_imagen(a_reporte_id in number, a_nombre_archivo in varchar2) is
  v_bfile bfile;
  v_src_offset number := 1;
  v_dest_offset number := 1;
  v_dest_blob blob;
  v_op_id number;
begin 
  v_bfile := bfilename('DATA_DIR', a_nombre_archivo);                                                                        
  if dbms_lob.fileexists(v_bfile) = 1 and not dbms_lob.isopen(v_bfile) = 1 then 
    dbms_lob.open(v_bfile, dbms_lob.lob_readonly);
  else
    raise_application_error(-20001, 'El archivo ' || a_nombre_archivo||' no existe en el directorio DATA_DIR o el archivo esta abierto');
  end if;
  v_op_id := imagen_reporte_seq.nextval;
  insert into imagen_reporte (imagen_reporte_id, reporte_id, imagen) values(v_op_id,a_reporte_id,empty_blob());
  select imagen into v_dest_blob from imagen_reporte where imagen_reporte_id = v_op_id for update;
  dbms_lob.loadblobfromfile(dest_lob => v_dest_blob,src_bfile => v_bfile,amount => dbms_lob.getlength(v_bfile),dest_offset => v_dest_offset,src_offset => v_src_offset);
  dbms_lob.close(v_bfile);
  update imagen_reporte set imagen = v_dest_blob where imagen_reporte_id = v_op_id;
end;
/
show errors
