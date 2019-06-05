<?php
    class Usuario{
        private $db;
        function __construct(){
            $this->db = new Conexion();
        }

        function set_usuario($email,$nombre,$apellidos,$contraseña){
            $query = "INSERT INTO usuario (usuario_id, email, nombre, apellidos,contraseña, puntos, es_socio) VALUES (usuario_seq.nextval,:email,:nombre,:apellidos,:contraseña, 0,0)";
            $stmt = $this->db->prepare($query);
            $stmt->bindParam(':email',$email);
            $stmt->bindParam(':nombre',$nombre);
            $stmt->bindParam(':apellidos',$apellidos);
            $stmt->bindParam(':contraseña',$contraseña);
            $res = $stmt->execute();
            return $res;
        }

        function check_login_email($email,$contraseña){
            $query = "SELECT * FROM usuario WHERE email=:email";
            $stmt = $this->db->prepare($query);
            $stmt->bindParam(':email',$email);
            $stmt->execute();
            $usuario = $stmt->fetch();
            if($usuario){
                if(password_verify($contraseña,$usuario['CONTRASEÑA'])){
                    return True;
                }else{
                    return false;
                }
            }else{
                return False;
            }
        }

        function get_usuario($email){
            $query = "SELECT * FROM usuario WHERE email=:email";
            $stmt = $this->db->prepare($query);
            $stmt->bindParam(':email',$email);
            $stmt->execute();
            $usuario = $stmt->fetch();
            return $usuario;
        }

        function get_usuario_by_id($usuario_id){
            $query = "SELECT * FROM usuario WHERE usuario_id=:usuario_id";
            $stmt = $this->db->prepare($query);
            $stmt->bindParam(':usuario_id',$usuario_id);
            $stmt->execute();
            $usuario = $stmt->fetch();
            return $usuario;
        }

        function get_usuarios_all(){
            $query = "SELECT * FROM usuario";
            $stmt = $this->db->prepare($query);
            $stmt->execute();
            return $stmt->fetchAll();
        }
    }
?>