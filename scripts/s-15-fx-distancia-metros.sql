--@Autores: Mario Garrido, Vicente Romero
--@Fecha creación: 26/05/2019
--@Descripción: Funcion que devuelve la distancia entre dos coordenadas
connect gr_proy_admin/bravo123
create or replace function fx_distancia_metros(p_lat1 in numeric,p_lon1 in numeric,p_lat2 in numeric,p_lon2 in numeric)
return numeric is
v_r numeric(20,10);
v_fi1 numeric(20,10);
v_fi2 numeric(20,10);
v_deltafi numeric(20,10);
v_deltalambda numeric(20,10);
v_a numeric(20,10);
v_c numeric(20,10);
v_d numeric(20,10);
begin
  v_r := 6371000;
  v_fi1 := p_lat1 * 3.141592654/180;
  v_fi2 := p_lat2 * 3.141592654/180;
  v_deltafi := (p_lat2 - p_lat1) * 3.141592654/180;
  v_deltalambda := (p_lon2 - p_lon1) * 3.141592654/180;
  v_a := power(sin(v_deltafi/2),2) + (cos(v_fi1) * cos(v_fi2) * power(sin(v_deltalambda/2),2));
  v_c := 2 * atan2(sqrt(v_a),sqrt(1 - v_a));
  v_d := v_r * v_c;
  return v_d;
end;
/
show errors

