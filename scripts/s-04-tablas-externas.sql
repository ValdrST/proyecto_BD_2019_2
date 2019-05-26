--@Autor(es): Mario Garrido, Vicente Romero
--@Fecha creación: 26/05/2019
--@Descripción: Creacion de tablas externas

!mkdir -p /tmp/bases
!chmod 777 /tml/bases
!cp empleado_ext.csv /tml/bases

CREATE OR REPLACE DIRECTORY TMP_DIR AS '/tmp/bases';
GRANT READ, WRITE ON DIRECTORY TMP_DIR TO gr_proy_admin;
CREATE TABLE APARATO_EXT(
    NUMERO_SERIE CHAR(18),
    NUMERO_MATRICULA CHAR(6),
    CODIGO_ACCESO VARCHAR(32),
    CAPACIDAD NUMBER(3,2),
    PORCENTAJE_CARGA NUMBER(3,0)
)
ORGANIZATION EXTERNAL(
    TYPE ORACLE_LOADER
    DEFAULT DIRECTORY TMP_DIR
    ACCESS PARAMETERS(
        RECORDS DELIMITED BY NEWLINE
        BADFILE TMP_DIR:'aparato_ext_bad.log'
        LOGFILE TMP_DIR:'empleado_ext.log'
        FIELDS TERMINATED BY ','
        LRTRIM
        MISSING FIELD VALUES ARE NULL
        (
            NUMMERO_SERIE, NUMERO_MATRICULA,CODIGO_ACCESO,CAPACIDAD,
            PORCENTAJE_CARGA
        )
    )
    LOCATION ('aparato_ex.csv')
)
REJECT LIMIT UNLIMITED;