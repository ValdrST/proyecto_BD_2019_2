--@Autores: Mario Garrido, Vicente Romero
--@Fecha creación: 26/05/2019
--@Descripción: Funcion que exporta los datos de un usuario a un archivo de texto.
connect gr_proy_admin/bravo123
create or replace procedure p-exporta-datos(p_usuario_id in numeric(10,0))
is
v_file utl_file.file_type;
v_email usuario.email%type;
v_nombre usuario.nombre%type;
v_apellidos usuario.apellidos%type;
v_contraseña usuario.contraseña%type;
v_puntos usuario.puntos%type;
v_es_socio usuario.es_socio%type;
v_clabe recarga.clabe%type;
v_nombre_banco recarga.nombre_banco%type;
v_inicio datetime;
v_fin datetime;
v_folio viaje.folio%type;
v_aparato_id aparato.aparato_id%type;
v_dias_custodio renta.dias_custodio%type;
v_direccion renta.direccion%type;
cursor c_servicios_usuario is
select *
from servicio
where usuario_id=p_usuario_id;
begin
  v_file := utl_file.fopen(data_dir,('rep-'||p_usuario_id),'w');
  utl_file.put_line*(v_file,'----Reporte de usuario----')
  utl_file.put_line*(v_file,'ID: '||p_usuario_id);
  select email
  into v_email
  from usuario
  where usuario_id=p_usuario_id;
  utl_file.put_line*(v_file,'email: '||v_email);
  select nombre
  into v_nombre
  from usuario
  where usuario_id=p_usuario_id;
  utl_file.put_line*(v_file,'nombre: '||v_nombre);
  select apellidos
  into v_apellidos
  from usuario
  where usuario_id=p_usuario_id;
  utl_file.put_line*(v_file,'apellidos: '||v_apellidos);
  select contraseña
  into v_contraseña
  from usuario
  where usuario_id=p_usuario_id;
  utl_file.put_line*(v_file,'contraseña: '||v_contraseña);
  select puntos
  into v_puntos
  from usuario
  where usuario_id=p_usuario_id;
  utl_file.put_line*(v_file,'puntos: '||v_puntos);
  select es_socio
  into v_es_socio
  from usuario
  where usuario_id=p_usuario_id;
    utl_file.put_line*(v_file,'apellidos: '||v_apellidos);
  for i in c_servicios_usuario
  loop
    utl_file.put_line*(v_file,'----------------');
    utl_file.put_line*(v_file,'id servicio: '||i.servicio_id);
    utl_file.put_line*(v_file,'tipo: '||i.tipo);
    switch i.tipo
      do
        case 'C':
          select clabe
          into v_clabe
          from recarga
          where recarga.servicio_id=i.servicio_id;
          utl_file.put_line*(v_file,'clabe: '||v_clabe);
          select nombre_banco
          into v_nombre_banco
          from recarga
          where recarga.servicio_id=i.servicio_id;
          utl_file.put_line*(v_file,'nombre banco: '||v_nombre_banco);
        break
        case 'V':
          select inicio
          into v_inicio
          from viaje
          where viaje.servicio_id=i.servicio_id;
          utl_file.put_line*(v_file,'inicio: '||to_char(v_inicio,'YYYY/MM/DD HH24:MI'));
          select fin
          into v_fin
          from viaje
          where viaje.servicio_id=i.servicio_id;
          utl_file.put_line*(v_file,'fin: '||to_char(v_fin,'YYYY/MM/DD HH24:MI'));
          select folio
          into v_folio
          from viaje
          where viaje.servicio_id=i.servicio_id;
          utl_file.put_line*(v_file,'folio: '||v_folio);
          select aparato_id
          into v_aparato_id
          from viaje
          where viaje.servicio_id=i.servicio_id;
          utl_file.put_line*(v_file,'id aparato: '||v_aparato_id);
        break
        default:
          select inicio
          into v_inicio
          from renta
          where renta.servicio_id=i.servicio_id;
          utl_file.put_line*(v_file,'inicio: '||to_char(v_inicio,'YYYY/MM/DD HH24:MI'));
          select dias_custodio
          into v_dias_custodio
          from renta
          where renta.servicio_id=i.servicio_id;
          utl_file.put_line*(v_file,'dias custodio: '||to_char(v_fin,'YYYY/MM/DD HH24:MI'));
          select direccion
          into v_direccion
          from renta
          where renta.servicio_id=i.servicio_id;
          utl_file.put_line*(v_file,'direccion: '||v_direccion);
          select aparato_id
          into v_aparato_id
          from renta
          where renta.servicio_id=i.servicio_id;
          utl_file.put_line*(v_file,'id aparato: '||v_aparato_id);
        break
      doend
  end loop;
  utl_file.close(v_file);
end;
/
show errors
