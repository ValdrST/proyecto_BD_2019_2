<?php
        error_reporting(E_ALL);
        ini_set("display_errors", 1);
        session_start();
        require_once("../model/Conexion_BD.php");
        require_once("../model/Servicio.php");
        $usuario_id = $_POST['usuario_id'];
        $dias_custodio = $_POST['dias_custodio'];
        $direccion = $_POST['direccion'];
        $aparato_id = $_POST['aparato_id'];
        $Servicio = new Servicio();
        $row = $Servicio->set_servicio_renta($usuario_id,$dias_custodio,$direccion,$aparato_id);
        echo(json_encode(array('resultado'=>$row)));
