--@Autores: Mario Garrido, Vicente Romero
--@Fecha creación: 02/06/2019
--@Descripción: Trigger encargado de avisar al sistema que la bateria es baja y pone el estado correspondiente
set serveroutput on
create or replace trigger tr_cambio_bateria
for insert or update of porcentaje_carga on aparato
compound trigger

type aparatos_lista_baja is table of aparato.aparato_id%type;
v_lista aparatos_lista_baja := aparatos_lista_baja();
v_estado_espera_id aparato.estado_id%type;
v_estado_bat_baja_id aparato.estado_id%type;

before statement is

select estado_id
into v_estado_espera_id
from estado
where estado.nombre='EN ESPERA';
select estado_id
into v_estado_bat_baja_id
from estado
where estado.nombre='BATERIA BAJA';

end before statement;

before each row is
v_index number;
begin
if(:new.porcentaje_carga <= 15.00 and :new.estado_id = v_estado_espera_id)
{
  v_lista.extend;
  v_index := v_lista.last;
  v_lista(v_index) := :new.aparato_id;
}
dbms_output.put_line('SYSTEM: Aparato con bateria baja encontrado.');
end before each row;

after statement is
begin
  for i in v_lista.first .. v_lista.last loop
    update aparato
    set estado_id = v_estado_bat_baja_id
    where aparato_id=i;
  end loop;
end after statement;
end;
/
show errors
