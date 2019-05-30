--@Autor(es): Mario Garrido, Vicente Romero
--@Fecha creación: 25/05/2019
--@Descripción: Definicion de los usuarios invitado y admin y su asignacion de permisos

create user gr_proy_invitado identified by bravo123 quota 1024 m on users;
create user gr_proy_admin identified by bravo123 quota 1024 m on users;
create role rol_admin;
create role rol_invitado;
grant create session, create table, create any directory, create view, create public synonym, create synonym, create sequence, create procedure, create trigger to rol_admin;
grant create session to rol_invitado;
grant rol_admin to gr_proy_admin;
grant rol_invitado to gr_proy_invitado;
grant create synonym to gr_proy_invitado;