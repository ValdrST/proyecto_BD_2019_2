<?php
error_reporting(E_ALL);
ini_set("display_errors", 1);
session_start();
require_once("../model/Conexion_BD.php");
require_once("../model/Usuario.php");
require_once("../controller/get_real_ip.php");
    try {
        $Usuario = new Usuario();
        if((!isset($_SESSION['loggedin']) || $_SESSION['expire'] < time() || $_SESSION['email'] == '')){
            $email = strtolower($_POST['email']);
            $password = $_POST['password'];
            if($Usuario->check_login_email($email,$password)){
                $_SESSION['loggedin'] = True;
                $_SESSION['ip'] = getRealIP();
                $_SESSION['email'] = $email;
                $_SESSION['start'] = time();
                $_SESSION['expire'] = $_SESSION['start'] + (15 * 60);
                $usuario = $Usuario->get_usuario($email);
                $_SESSION['id'] = $usuario['USUARIO_ID'];
                $_SESSION['es_socio'] = $usuario['ES_SOCIO'];
                $session = array('id'=>$_SESSION['id'], 'email'=>$_SESSION['email'], 'tipo' => $_SESSION['es_socio']);
                echo json_encode($session);
            }else{
                $_SESSION['email'] = "";
                $session = array('email'=>"",'tipo' => -1);
                http_response_code(403);
                echo json_encode($session);
            }
        }
    } catch (Exception $e) {
        echo("Error {$e->getCode()}: {$e->getMessage()}");
    }