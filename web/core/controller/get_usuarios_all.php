<?php
        error_reporting(E_ALL);
        ini_set("display_errors", 1);
        session_start();
        require_once("../model/Conexion_BD.php");
        require_once("../model/Usuario.php");
        $Usuario = new Usuario();
        $row = $Usuario->get_usuarios_all();
        echo(json_encode($row));
