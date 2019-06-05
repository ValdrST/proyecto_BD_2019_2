<?php
        error_reporting(E_ALL);
        ini_set("display_errors", 1);
        session_start();
        require_once("../model/Conexion_BD.php");
        require_once("../model/Aparato.php");
        $aparato_id = $_GET['aparato_id'];
        $Aparato = new Aparato();
        $row = $Aparato->get_aparato($aparato_id);
        echo(json_encode($row));
