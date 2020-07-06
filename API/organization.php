<?php
    require 'connect.php' ;
    require 'utills.php' ;

    class OrganizationModifier{
        private $db = null;
        public function __construct() {
            $this->db = (new DataBaseConnector())->get_connection();
        }
        public function get_all_records(){
            $tsql = "SELECT name FROM Organization" ;
            $getResults= sqlsrv_query($this->db, $tsql);
            if ($getResults == FALSE)
                die(FormatErrors(sqlsrv_errors()));

            $output = array();
            while ($row = sqlsrv_fetch_array($getResults, SQLSRV_FETCH_ASSOC)) {
                $obj["name"] = $row['name'];
            
                $output[] = $obj;
            }
            
            $myJSON = json_encode($output);
            echo $myJSON;

        }
        public function insert_record($name){
            $tsql = "INSERT INTO Organization (name) VALUES (?) ;" ;
            $getResults = sqlsrv_query($this->db,$tsql,array($name)) ;
            $rowsAffected = sqlsrv_rows_affected($getResults);
            if ($getResults == FALSE or $rowsAffected == FALSE)
                die(FormatErrors(sqlsrv_errors()));
            echo ($rowsAffected. " row(s) inserted: " . PHP_EOL);

            sqlsrv_free_stmt($getResults);

        }

    }

    switch ($_SERVER["REQUEST_METHOD"]) 
    {
        case "GET" :
            header('Content-Type: application/json');
            ( new OrganizationModifier())->get_all_records();
        break ;
        case "POST" :
            $name = $_POST["name"] ;
            header('Content-Type: application/json');
           ( new OrganizationModifier())->insert_record($name) ;
        break ;

    }

?>

