--@Autor(es): Mario Garrido, Vicente Romero
--@Fecha creación: 26/05/2019
--@Descripción: Creacion de tablas externas

!mkdir -p /tmp/bases
!chmod 777 /tmp/bases
!cp aparato_ext.csv /tmp/bases
create or replace directory data_dir as '/tmp/bases';
create table aparato_ext(
    numero_serie char(18),
    numero_matricula char(6),
    codigo_acceso varchar(32),
    capacidad number(5,2),
    porcentaje_carga number(3,0)
)
organization external(
    type oracle_loader
    default directory data_dir
    access parameters(
        records delimited by newline
        badfile data_dir:'aparato_ext_bad.log'
        logfile data_dir:'aparato_ext.log'
        fields terminated by ','
        lrtrim
        missing field values are null
        (
            numero_serie, numero_matricula,codigo_acceso,capacidad,
            porcentaje_carga
        )
    )
    location ('aparato_ext.csv')
)
reject limit unlimited;
