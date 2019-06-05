<?php
session_start();
unset ($SESSION['username']);
session_destroy();
http_response_code(200);
header('Location: ../../index.php');
?>