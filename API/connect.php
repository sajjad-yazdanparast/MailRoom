<?php

    class DataBaseConnector{
        
        private $serverName = "localhost";
        //s@j1563j@d
        private $connectionOptions = array(
            "Database" => "MailRoom",
            "Uid" => "sa",
            "PWD" => "2711378Hossein"
        );
        private $conn = null ;   // using SINGELTON design pattern
        
        public function __construct(){
            $this->conn = sqlsrv_connect($this->serverName, $this->connectionOptions);
        }
        public function get_connection() {
            return $this->conn ;
        }

    }

?>
