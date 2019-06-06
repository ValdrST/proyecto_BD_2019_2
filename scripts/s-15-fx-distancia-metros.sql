--@Autores: Mario Garrido, Vicente Romero
--@Fecha creación: 26/05/2019
--@Descripción: Funcion que devuelve la distancia entre dos coordenadas
connect gr_proy_admin/bravo123
create or replace function fx-distancia-metros(p_lat1 in numeric(11,8),p_lon1 in numeric(11,8),p_lat2 in numeric(11,8),p_lon2 in numeric(11,8))
return number is
v_r number;
v_fi1 number;
v_fi2 number;
v_deltafi number;
v_deltalambda number;
v_a number;
v_c number;
v_d number;
begin
  v_r:=6371000;
  v_fi1:=radians(p_lat1);
  v_fi1:=radians(p_lat2);
  v_deltafi:=radians(p_lat2-p_lat1);
  v_deltalambda:=radians(p_lon2-p_lon1);
  v_a:= power(sin(deltafi/2),2) + cos(fi1) * cos(fi2) * power(sin(deltalambda/2));
  v_c:= 2* atan2(sqrt(v_a),sqrt(1-v_a));
  v_d:=v_r*v_c;
  return v_d;
end;
/
show errors

