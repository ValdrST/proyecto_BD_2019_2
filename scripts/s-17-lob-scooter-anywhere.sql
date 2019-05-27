--@Autor(es): Mario Garrido, Vicente Romero
--@Fecha creación: 26/05/2019
--@Descripción: Script encargado de cargar una imagen a la BD.Z
connect gr_proy_admin/bravo123
create or replace directory data_dir as '/tmp/bd';
grant read,write on directory data_dir to gr_proy_invitado;
create or replace procedure p_actualiza_imagen(a_nombre_archivo varchar(200)) is
v_bfile bfile;
v_src_offset number := 1;
v_dest_offset number := 1;
v_dest_blob blob;
v_src_length number;
v_dest_length number;
v_nombre_archivo varchar2(1000);
cursor cur_imagen is
select imagen_reporte_id,reporte_id,imagen
from imagen_reporte;
begin
for r in cur_imagen loop
v_src_offset := 1;
v_dest_offset := 1;
v_bfile := bfilename('DATA_DIR', a_nombre_archivo);
if dbms_lob.fileexists(v_bfile) = 1 and not dbms_lob.isopen(v_bfile) = 1 then dbms_lob.open(
v_bfile, dbms_lob.lob_readonly);
else raise_application_error(-20001, 'El archivo '
|| r.nombre_archivo
||' no existe en el directorio DATA_DIR'
|| ' o el archivo esta abierto');
end if;
select imagen into v_dest_blob
from imagen_reporte
where reporte_id = r.reporte_id
for update;
dbms_lob.loadblobfromfile(
dest_lob => v_dest_blob,
src_bfile => v_bfile,
amount => dbms_lob.getlength(v_bfile),
dest_offset => v_dest_offset,
src_offset => v_src_offset);
dbms_lob.close(v_bfile);
v_src_length := dbms_lob.getlength(v_bfile);
v_dest_length := dbms_lob.getlength(v_dest_blob);
if v_src_length = v_dest_length then
dbms_output.put_line('Escritura correcta, bytes escritos: '
|| v_src_length);
else raise_application_error(-20002, 'Error al escribir datos.\n'
|| ' Se esperaba escribir '
|| v_src_length
|| ' Pero solo se escribio '
|| v_dest_length);
end if;
end loop;
end;
