<?php
    session_start();
    if(isset($_GET['sesion'])){
        if(isset($_SESSION['email']) && $_SESSION['email']!='' && $_SESSION['expire'] > time()){
            echo(json_encode(array("status_sesion"=>True)));
        }else{
            echo(json_encode(array("status_sesion"=>False)));
        }
    }else{
        require_once("core/view/panel.html");
    }
?>