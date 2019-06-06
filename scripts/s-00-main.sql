--@Autor(es): Mario Garrido, Vicente Romero
--@Fecha creación: 29/05/2019
--@Descripción: Script invoca a los otros scripts
connect sys/system as sysdba
declare
    v_count number := 0;
begin
    select count(1) into v_count from dba_users where username = upper('gr_proy_invitado');
    if v_count != 0 then
        EXECUTE IMMEDIATE('drop user gr_proy_invitado cascade');
    end if;
    select count(1) into v_count from dba_users where username = upper('gr_proy_admin');
    if v_count != 0 then
         EXECUTE IMMEDIATE('drop user gr_proy_admin cascade');
    end if;
    
end;
/
connect sys/system as sysdba

create or replace directory data_dir as '/tmp/bases';
grant read, write on directory data_dir to rol_admin;
@s-01-usuarios.sql
connect gr_proy_admin/bravo123
@s-02-entidades.sql
@s-03-tablas-temporales.sql
@s-04-tablas-externas.sql
@s-05-secuencias.sql
@s-06-indices.sql
@s-07-sinonimos.sql
@s-08-vistas.sql
connect gr_proy_admin/bravo123
@s-10-consultas.sql
@s-11-tr-historico_estado.sql
@s-09-carga-inicial.sql
@s-11-tr-bonificacion_reporte.sql
@s-11-tr-validar_servicio_recarga.sql
@s-15-fx-dias_fechas.sql
grant read,write on directory data_dir to gr_proy_invitado;
@s-17-lob-scooter-anywhere.sql
