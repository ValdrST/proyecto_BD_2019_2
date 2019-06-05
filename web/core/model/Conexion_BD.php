<?php
    class Conexion{
    private $result;
    public $conn;
    function __construct(){
        $tns="(DESCRIPTION =
        (ADDRESS = (PROTOCOL = TCP)(HOST = VenganzaDeHitler)(PORT = 1521))
        (CONNECT_DATA =
          (SERVER = DEDICATED)
          (SERVICE_NAME = cursobd.fi.unam)
        )
      )";
        //try{
            $this->conn = oci_connect('gr_proy_admin','bravo123',$tns,'UTF8');

        //}catch(PDOException $ex){
          //  http_response_code(500);
            //echo json_encode($ex);
        //}
    }

    function prepare($sql){
      $stmt = oci_parse($this->conn,$sql);
      $stmt = new Statement($stmt);
      return $stmt;
    }

}

class Statement{
  private $stmt;
  function __construct($stmt){
    $this->stmt = $stmt;
  }

  function execute(){
    return oci_execute($this->stmt);
  }

  function bindParam($str,$param){
    oci_bind_by_name($this->stmt,$str,$param);
  }

  function fetch(){
    return oci_fetch_assoc($this->stmt);
  }

  function fetchAll(){
    oci_fetch_all($this->stmt,$res,null,null,OCI_FETCHSTATEMENT_BY_ROW);
    return $res;
  }

  function getError(){
    return oci_error($this->stmt);
  }
}
?>