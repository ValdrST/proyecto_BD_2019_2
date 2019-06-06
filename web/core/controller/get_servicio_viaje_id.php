<?php
        error_reporting(E_ALL);
        ini_set("display_errors", 1);
        session_start();
        require_once("../model/Conexion_BD.php");
        require_once("../model/Servicio.php");
        $servicio_id = $_GET['servicio_id'];
        $Servicio = new Servicio();
        $row = $Servicio->get_servicios_viaje_id($servicio_id);
        echo(json_encode($row));
