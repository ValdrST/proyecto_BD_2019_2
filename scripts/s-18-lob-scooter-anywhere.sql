--PASAR ESTO A MAIN
create or replace directory data_dir as '/tmp/bd';
grant read, write on directory data_dir to gr_proy_invitado;
--PASAR ESTO A MAIN
show errors
nombre varchar(200):= 'prueba.png';
reporte_id numeric(10,0) := 4;
exec p_actualiza_imagen(nombre,reporte_id)
commit;
Prompt Mostrando resultados
col nombre_archivo format a30
select libro_id,nombre_archivo,dbms_lob.getlength(imagen) as longitud_imagen
from libro_imagen;
Prompt Listo!
