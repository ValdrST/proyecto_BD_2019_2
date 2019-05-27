--@Autor(es): Mario Garrido, Vicente Romero
--@Fecha creación: 26/05/2019
--@Descripción: Creacion de tablas externas

!mkdir -p /tmp/bases
!chmod 777 /tml/bases
!cp empleado_ext.csv /tml/bases

create or replace directory tmp_dir as '/tmp/bases';
grant read, write on directory tmp_dir to gr_proy_admin;
create table aparato_ext(
    numero_serie char(18),
    numero_matricula char(6),
    codigo_acceso varchar(32),
    capacidad number(3,2),
    porcentaje_carga number(3,0)
)
organization external(
    type oracle_loader
    default directory tmp_dir
    access parameters(
        records delimited by newline
        badfile tmp_dir:'aparato_ext_bad.log'
        logfile tmp_dir:'empleado_ext.log'
        fields terminated by ','
        lrtrim
        missing field values are null
        (
            nummero_serie, numero_matricula,codigo_acceso,capacidad,
            porcentaje_carga
        )
    )
    location ('aparato_ex.csv')
)
reject limit unlimited;
