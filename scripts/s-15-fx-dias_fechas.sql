--@Autores: Mario Garrido, Vicente Romero
--@Fecha creación: 26/05/2019
--@Descripción: Funcion que resta dos fechas y devuelve los dias que hay entre ellas
connect gr_proy_admin/bravo123
create or replace function dias_fechas(p_fecha_1 in date, p_fecha_2 in date)
return integer is
v_dias number;
begin
    v_dias := abs(trunc(p_fecha_2 - p_fecha_1));
  return v_dias;
end;
/
show errors