<?php
        session_start();
        require_once("../model/Conexion_BD.php");
        require_once("../model/Usuario.php");
        $usuario_id = $_GET['usuario_id'];
        $Usuario = new Usuario();
        $row = $Usuario->get_usuario_by_id($usuario_id);
        echo(json_encode($row));