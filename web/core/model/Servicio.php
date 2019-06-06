<?php
    class Servicio{
        private $db;
        function __construct(){
            $this->db = new Conexion();
        }

        function set_servicio_viaje($usuario_id,$fin,$folio,$aparato_id){
            $query = "INSERT INTO servicio (servicio_id, usuario_id, tipo) VALUES (servicio_seq.nextval, :usuario_id, 'V')";
            $stmt = $this->db->prepare($query);
            $stmt->bindParam(':usuario_id',$usuario_id);
            if($stmt->execute()){
                $query = "INSERT INTO viaje (servicio_id, inicio, fin, folio, aparato_id) VALUES (servicio_seq.currval, sysdate,to_date(:fin,'yyyy-mm-dd hh24:mi'), :folio,:aparato_id)";
                $stmt = $this->db->prepare($query);
                $stmt->bindParam(':fin',$fin);
                $stmt->bindParam(':folio',$folio);
                $stmt->bindParam(':aparato_id',$aparato_id);
                if($stmt->execute()){
                    $query = "UPDATE aparato set estado_id=(select estado_id from estado where clave='ENSV') where aparato_id = :aparato_id";    
                    $stmt = $this->db->prepare($query);
                    $stmt->bindParam(':aparato_id',$aparato_id);
                    return $stmt->execute();
                }
            }else{
                return False;
            }
            return False;
        }

        function terminar_servicio_viaje($servicio_id){
            $query = "UPDATE aparato set estado_id=(select estado_id from estado where clave='ENSP') where aparato_id = (SELECT aparato_id from viaje where servicio_id = :servicio_id)";
            $stmt = $this->db->prepare($query);
            $stmt->bindParam(':servicio_id',$servicio_id);
            $res = $stmt->execute();
            $query = "UPDATE viaje set fin=sysdate where servicio_id = :servicio_id";
            $stmt = $this->db->prepare($query);
            $stmt->bindParam(':servicio_id',$servicio_id);
            $res2 = $stmt->execute();
            if($res && $res2)
                return TRUE;
            return False;
        }

        function terminar_servicio_renta($servicio_id){
            $query = "UPDATE aparato set estado_id=(select estado_id from estado where clave='ENSP') where aparato_id = (SELECT aparato_id from renta where servicio_id = :servicio_id)";
            $stmt = $this->db->prepare($query);
            $stmt->bindParam(':servicio_id',$servicio_id);
            $res = $stmt->execute();
            $query = "UPDATE renta set dias_custodio=dias_fechas(sysdate,inicio) where servicio_id = :servicio_id";
            $stmt = $this->db->prepare($query);
            $stmt->bindParam(':servicio_id',$servicio_id);
            $res2 = $stmt->execute();
            if($res && $res2)
                return TRUE;
            return False;
        }

        function set_servicio_renta($usuario_id,$dias_custodio,$direccion,$aparato_id){
            $query = "INSERT INTO servicio (servicio_id, usuario_id, tipo) VALUES (servicio_seq.nextval, :usuario_id, 'R')";
            $stmt = $this->db->prepare($query);
            $stmt->bindParam(':usuario_id',$usuario_id);
            if($stmt->execute()){
                $query = "INSERT INTO renta(servicio_id, inicio, dias_custodio, direccion, aparato_id) VALUES (servicio_seq.currval, sysdate, :dias_custodio, :direccion,:aparato_id)";
                $stmt = $this->db->prepare($query);
                $stmt->bindParam(':dias_custodio',$dias_custodio);
                $stmt->bindParam(':direccion',$direccion);
                $stmt->bindParam(':aparato_id',$aparato_id);
                if($stmt->execute()){
                    $query = "UPDATE aparato set estado_id=(select estado_id from estado where clave='ENSR') where aparato_id = :aparato_id";    
                    $stmt = $this->db->prepare($query);
                    $stmt->bindParam(':aparato_id',$aparato_id);
                    return $stmt->execute();
                }
            }else{
                return False;
            }
            return False;
        }


        function get_servicios_viaje_usuario($usuario_id){
            $query = "SELECT v.servicio_id, to_char(v.inicio,'dd-mm-yy hh24:mi') inicio, to_char(v.fin,'dd-mm-yy hh24:mi') fin, v.folio, v.aparato_id from servicio s join viaje v on s.servicio_id = v.servicio_id where s.usuario_id=:usuario_id";
            $stmt = $this->db->prepare($query);
            $stmt->bindParam(':usuario_id',$usuario_id);
            $stmt->execute();
            return $stmt->fetchAll();
        }

        function get_servicios_renta_usuario($usuario_id){
            $query = "SELECT r.servicio_id, to_char(r.inicio,'dd-mm-yy hh24:mi') inicio, r.dias_custodio, r.direccion, r.aparato_id from servicio s join renta r on s.servicio_id = r.servicio_id where s.usuario_id=:usuario_id";
            $stmt = $this->db->prepare($query);
            $stmt->bindParam(':usuario_id',$usuario_id);
            $stmt->execute();
            return $stmt->fetchAll();
        }

        function get_servicios_renta_id($servicio_id){
            $query = "SELECT r.servicio_id, to_char(r.inicio,'dd-mm-yy hh24:mi') inicio, r.dias_custodio, r.direccion, r.aparato_id, a.numero_matricula, m.nombre, e.nombre estado from servicio s join renta r on s.servicio_id = r.servicio_id join aparato a on r.aparato_id = a.aparato_id join marca m on a.marca_id = m.marca_id join estado e on a.estado_id = e.estado_id  where s.servicio_id=:servicio_id";
            $stmt = $this->db->prepare($query);
            $stmt->bindParam(':servicio_id',$servicio_id);
            $stmt->execute();
            return $stmt->fetchAll();
        }

        function get_servicios_viaje_id($servicio_id){
            $query = "SELECT v.servicio_id, to_char(v.inicio,'dd-mm-yy hh24:mi') inicio, to_char(v.fin,'dd-mm-yy hh24:mi') fin, v.folio, v.aparato_id, a.numero_matricula, m.nombre, e.nombre estado from servicio s join viaje v on s.servicio_id = v.servicio_id join aparato a on v.aparato_id = a.aparato_id join marca m on a.marca_id = m.marca_id join estado e on a.estado_id = e.estado_id where s.servicio_id=:servicio_id";
            $stmt = $this->db->prepare($query);
            $stmt->bindParam(':servicio_id',$servicio_id);
            $stmt->execute();
            return $stmt->fetchAll();
        }
        
    }
?>