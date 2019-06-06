<?php
        error_reporting(E_ALL);
        ini_set("display_errors", 1);
        session_start();
        require_once("../model/Conexion_BD.php");
        require_once("../model/Servicio.php");
        $servicio_id = $_POST['servicio_id'];
        $tipo = $_POST['tipo'];
        $Servicio = new Servicio();
        if($tipo == 'V'){
            $row = $Servicio->terminar_servicio_viaje($servicio_id);
        echo(json_encode(array('resultado'=>$row)));    
        }
        if($tipo == 'R'){
            $row = $Servicio->terminar_servicio_renta($servicio_id);
        echo(json_encode(array('resultado'=>$row)));    
        }
