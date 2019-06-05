<?php
    session_start();
    if($_SESSION['loggedin']!= True || $_SESSION['expire'] < time()){
        http_response_code(401);
        echo json_encode(array('status'=>'sesion expirada o no iniciada'));
    }else{
        http_response_code(200);
    }
?>