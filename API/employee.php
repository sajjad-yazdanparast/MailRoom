<?php
    require 'connect.php' ;
    require 'utills.php' ;

    class EmployeeModifier
    {
        private $db = null;
        public function __construct() {
            $this->db = (new DataBaseConnector())->get_connection();
            sqlsrv_configure("WarningsReturnAsErrors" , 0);
        }

        public function get_records_by_id($id){
            $tsql = "EXEC get_employee_by_id @id = ?" ;
            $getResults = sqlsrv_query($this->db,$tsql,array($id)) ;
            if ($getResults == FALSE)
                die(FormatErrors(sqlsrv_errors()));

            $output = array();
            while ($row = sqlsrv_fetch_array($getResults, SQLSRV_FETCH_ASSOC)) {
                $obj->id= $row['ID'];
                $obj->name = $row['name'];
                $obj->organ_id = $row['organ_id'];
                $obj->personel_number = $row['personel_number'];
                $obj->rank = $row['rank'];
                $obj->boss_id = $row['boss_id'];
                
                $output[] = $obj;
            }
            sqlsrv_free_stmt($getResults);
            print_output(200 , true , $output);
        }

        public function get_records_by_personal_number_and_organ_id($personal_number , $organ_id){
           
            $tsql = "EXEC get_employee_by_organ_id_and_personel_number @organ_id = ? , @personel_number = ?" ;
            $getResults = sqlsrv_query($this->db,$tsql,array($organ_id , $personal_number)) ;
            if ($getResults == FALSE)
                die(FormatErrors(sqlsrv_errors()));

            $output = array();
            while ($row = sqlsrv_fetch_array($getResults, SQLSRV_FETCH_ASSOC)) {
                $obj->id= $row['ID'];
                $obj->name = $row['name'];
                $obj->organ_id = $row['organ_id'];
                $obj->personel_number = $row['personel_number'];
                $obj->rank = $row['rank'];
                $obj->boss_id = $row['boss_id'];

                $output[] = $obj;
            }
            sqlsrv_free_stmt($getResults);
            print_output(200 , true , $output);
        }


        public function insert_record($organ_id , $personel_number , $name , $rank , $boss_id){

        
            if($boss_id == -1)
            {
            
                $tsql = "EXEC insert_high_level_employee @organ_id = ? , @personel_number = ? , @name = ? , @rank = ?" ;
                $getResults = sqlsrv_query($this->db,$tsql,array($organ_id , $personel_number ,$name ,$rank)) ;
            }
            else
            {
                $tsql = "EXEC insert_low_level_employee @organ_id = ? , @personel_number = ? , @name = ? , @rank = ? , @boss_id = ?" ;
                $getResults = sqlsrv_query($this->db,$tsql,array($organ_id , $personel_number,$name,$rank , $boss_id)) ;
            }
        
            $rowsAffected = sqlsrv_rows_affected($getResults);
            if ($getResults == FALSE or $rowsAffected == FALSE)
                die(FormatErrors(sqlsrv_errors()));

            print_output(201 , true , $name ." added successfully");

            sqlsrv_free_stmt($getResults);

        }

        /*public function insert_record($name){
            $tsql = "EXEC insert_organization @name = ?" ;
            $getResults = sqlsrv_query($this->db,$tsql,array($name)) ;
            $rowsAffected = sqlsrv_rows_affected($getResults);
            if ($getResults == FALSE or $rowsAffected == FALSE)
                die(FormatErrors(sqlsrv_errors()));

            print_output(201 , true , $name ." added successfully");

            sqlsrv_free_stmt($getResults);

        }*/
    }



    switch ($_SERVER["REQUEST_METHOD"]) 
    {
        case "GET" :
            header('Content-Type: application/json');
            if(htmlspecialchars($_GET[id]) == "" && htmlspecialchars($_GET[personal_number]) == "" && htmlspecialchars($_GET[organ_id]) == "")
                print_output(400 , false , "no parameter");
            else
            {
                if(htmlspecialchars($_GET[id]) != "" && htmlspecialchars($_GET[personal_number]) == "" && htmlspecialchars($_GET[organ_id]) == "")
                    (new EmployeeModifier())->get_records_by_id($_GET[id]);
                else if(htmlspecialchars($_GET[id]) == "" && htmlspecialchars($_GET[personal_number]) != "" && htmlspecialchars($_GET[organ_id]) != "")
                    (new EmployeeModifier())->get_records_by_personal_number_and_organ_id($_GET[personal_number] ,$_GET[organ_id] );
                else
                    print_output(400 , false , "bad entery");
            }
        
        break ;

        case "POST":
            $name = $_POST["name"] ;
            header('Content-Type: application/json');
            $boss_id = -1;
            if($_POST[boss_id]!="")
            {
                $boss_id = $_POST[boss_id];
            }
            (new EmployeeModifier())->insert_record($_POST[organ_id],$_POST[personel_number],$_POST[name],$_POST[rank],$boss_id) ;
        break;
    }



?>