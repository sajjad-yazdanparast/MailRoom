<?php

    class DataBaseConnector{
        private $serverName = "localhost";
        private $connectionOptions = array(
            "Database" => "MailRoom",
            "Uid" => "sa",
            "PWD" => "s@j1563j@d"
        );
        private $conn = null ;   // using SINGELTON design pattern
        
        public function __construct(){
            $this->conn = sqlsrv_connect($this->serverName, $this->connectionOptions);
            if ($this->conn) 
                echo "Connected!".PHP_EOL ;
        }
        public function get_connection() {
            return $this->conn ;
        }

    }

?>
