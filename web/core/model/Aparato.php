<?php
    class Aparato{
        private $db;
        function __construct(){
            $this->db = new Conexion();
        }

        function set_aparato($numero_serie,$numero_matricula,$codigo_acceso,$capacidad,$porcentaje_carga,$recarga_id,$marca_id,$aparato_viejo){
            $query = "INSERT INTO aparato (aparato_id,numero_serie,numero_matricula,codigo_acceso,capacidad,porcentaje_carga,marca_id,estado_id,recarga_id) VALUES (aparato_seq.nextval,:numero_serie,:numero_matricula,:codigo_acceso,:capacidad,:porcentaje_carga,:marca_id,33,:recarga_id)";
            $stmt = $this->db->prepare($query);
            $stmt->bindParam(':$numero_serie',$numero_serie);
            $stmt->bindParam(':numero_matricula',$numero_matricula);
            $stmt->bindParam(':codigo_acceso',$codigo_acceso);
            $stmt->bindParam(':capacidad',$capacidad);
            $stmt->bindParam(':porcentaje_carga',$porcentaje_carga);
            $stmt->bindParam(':marca_id',$marca_id);
            $stmt->bindParam(':recarga_id',$recarga_id);
            if($stmt->execute()){
                if($aparato_viejo != Null){
                    $query = "INSERT INTO reemplazo(reemplazo_id, aparato_viejo,aparato_nuevo) values (reemplazo_seq.nextval, :aparato_viejo, aparato_seq.currval);";
                    $stmt = $this->db->prepare($query);
                    $stmt->bindParam(':aparato_viejo',$aparato_viejo);
                    return $stmt->execute();
                }else{
                    return true;
                }
            }
            return False;
        }

        function get_aparato($aparato_id){
            $query = "SELECT * from aparato a join estado e on a.estado_id = e.estado_id where a.aparato_id = :aparato_id";
            $stmt = $this->db->prepare($query);
            $stmt->bindParam(':aparato_id',$aparato_id);
            $stmt->execute();
            return $stmt->fetch();
        }

        function get_aparatos_all(){
            $query = "SELECT * from aparato a join estado e on a.estado_id = e.estado_id";
            $stmt = $this->db->prepare($query);
            $stmt->execute();
            return $stmt->fetchAll();
        }

        function get_historico_aparato($aparato_id){
            $query = "SELECT * from estado_historico eh join estado e on eh.estado_id = e.estado_id where eh.aparato_id=:aparato_id";
            $stmt = $this->db->prepare($query);
            $stmt->bindParam(':aparato_id',$aparato_id);
            $stmt->execute();
            return $stmt->fetchAll();
        }
    }
?>