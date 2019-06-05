<?php
        error_reporting(E_ALL);
        ini_set("display_errors", 1);
        session_start();
        require_once("../model/Conexion_BD.php");
        require_once("../model/Servicio.php");
        $usuario_id = $_POST['usuario_id'];
        $fin = $_POST['fin'];
        $folio = $_POST['folio'];
        $aparato_id = $_POST['aparato_id'];
        $Servicio = new Servicio();
        $row = $Servicio->set_servicio_viaje($usuario_id,$fin,$folio,$aparato_id);
        echo(json_encode(array('resultado'=>$row)));
