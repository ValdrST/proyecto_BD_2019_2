<?php
    session_start();
    require_once("../model/Conexion_BD.php");
    require_once("../model/Usuario.php");
    $Usuario = new Usuario();
    $email = $_POST['email'];
    $nombre = $_POST['nombre'];
    $apellidos = $_POST['apellidos'];
    $contraseña = password_hash($_POST['contraseña'], PASSWORD_DEFAULT);
    $res=$Usuario->set_usuario($email,$nombre,$apellidos,$contraseña);
    echo(json_encode(array('resultado'=>$res)));
