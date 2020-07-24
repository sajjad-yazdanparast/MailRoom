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
                $obj->telephone = $row['telephone'] ;
                
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
                $obj->telephone = $row['telephone'] ;


                $output[] = $obj;
            }
            sqlsrv_free_stmt($getResults);
            print_output(200 , true , $output);
        }


        public function insert_record($organ_id , $personel_number , $name , $rank , $boss_id , $telephone){

        
            if($boss_id == -1)
            {
            
                $tsql = "EXEC insert_high_level_employee @organ_id = ? , @personel_number = ? , @name = ? , @rank = ? , @telephone = ?" ;
                $getResults = sqlsrv_query($this->db,$tsql,array($organ_id , $personel_number ,$name ,$rank, $telephone)) ;
            }
            else
            {
                $tsql = "EXEC insert_low_level_employee @organ_id = ? , @personel_number = ? , @name = ? , @rank = ? , @boss_id = ? , @telephone = ? " ;
                $getResults = sqlsrv_query($this->db,$tsql,array($organ_id , $personel_number,$name,$rank , $boss_id, $telephone)) ;
            }
        
            $rowsAffected = sqlsrv_rows_affected($getResults);
            if ($getResults == FALSE or $rowsAffected == FALSE)
                die(FormatErrors(sqlsrv_errors()));

            print_output(201 , true , $name ." added successfully");

            sqlsrv_free_stmt($getResults);

        }

        public function delete_records_by_id($id){
            $tsql = "EXEC delete_employee_by_id @id = ?" ;
            $getResults = sqlsrv_query($this->db,$tsql , array($id)) ;
            $rowsAffected = sqlsrv_rows_affected($getResults);
            if ($getResults == FALSE or $rowsAffected == FALSE)
                die(FormatErrors(sqlsrv_errors()));

            print_output(200 , true , "employee with id=". $id ." was removed successfully");

            sqlsrv_free_stmt($getResults);

        }

        public function delete_records_by_organ_id($organ_id){
            $tsql = "EXEC delete_all_employees_of_a_organization @organ_id = ?" ;
            $getResults = sqlsrv_query($this->db,$tsql , array($organ_id)) ;
            $rowsAffected = sqlsrv_rows_affected($getResults);
            if ($getResults == FALSE or $rowsAffected == FALSE)
                die(FormatErrors(sqlsrv_errors()));

            print_output(200 , true , "employees with organ_id=". $organ_id ." were removed successfully");

            sqlsrv_free_stmt($getResults);

        }

        public function delete_records_by_organ_id_and_personal_number($organ_id , $personal_number){
            $tsql = "EXEC delete_employee_by_organ_id_and_personel_number @organ_id = ? , @personel_number = ?" ;
            $getResults = sqlsrv_query($this->db,$tsql , array($organ_id , $personal_number)) ;
            $rowsAffected = sqlsrv_rows_affected($getResults);
            if ($getResults == FALSE or $rowsAffected == FALSE)
                die(FormatErrors(sqlsrv_errors()));

            print_output(200 , true , "employees with organ_id=". $organ_id . " and personel_number = "  . $personal_number ." were removed successfully");

            sqlsrv_free_stmt($getResults);

        }

        public function delete_all_records(){
            $tsql = "EXEC delete_all_employees" ;
            $getResults = sqlsrv_query($this->db,$tsql) ;
            $rowsAffected = sqlsrv_rows_affected($getResults);
            if ($getResults == FALSE or $rowsAffected == FALSE)
                die(FormatErrors(sqlsrv_errors()));

            print_output(200 , true ,"all employees were removed successfully");

            sqlsrv_free_stmt($getResults);

        }

        public function update_records_by_id($id ,$new_name){
            $tsql = "EXEC update_employee_name_by_id @id = ? , @new_name = ?" ;
            $getResults = sqlsrv_query($this->db,$tsql , array($id,$new_name)) ;
            $rowsAffected = sqlsrv_rows_affected($getResults);
            if ($getResults == FALSE or $rowsAffected == FALSE)
                die(FormatErrors(sqlsrv_errors()));

            print_output(200 , true , "employees with ID=". $id ." was updated successfully");

            sqlsrv_free_stmt($getResults);

        }

        public function update_records_by_organ_id_and_personal_number($organ_id , $personal_number ,$new_name){
            echo $old_name ."   ". $new_name;
            $tsql = "EXEC update_employee_name_by_organ_id_and_personel_number @organ_id =?, @personel_number =?, @new_name = ?" ;
            $getResults = sqlsrv_query($this->db,$tsql , array($organ_id , $personal_number ,$new_name)) ;
            $rowsAffected = sqlsrv_rows_affected($getResults);
            if ($getResults == FALSE or $rowsAffected == FALSE)
                die(FormatErrors(sqlsrv_errors()));

            print_output(200 , true , "oraganizations with name=". $old_name ." were updated successfully");

            sqlsrv_free_stmt($getResults);

        }
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
            (new EmployeeModifier())->insert_record($_POST[organ_id],$_POST[personel_number],$_POST[name],$_POST[rank],$boss_id,$_POST[telephone]) ;
        break;

        case "DELETE" :
            header('Content-Type: application/json');
            $_DELETE = Array();
            parse_str(file_get_contents('php://input') , $_DELETE);


            if($_DELETE[id] == "" && $_DELETE[organ_id] == "" && $_DELETE[personel_number] == "" )
                (new EmployeeModifier)->delete_all_records();
            else
            {
                if($_DELETE[id] != ""  && $_DELETE[organ_id] == "" && $_DELETE[personel_number] == "" )
                    (new EmployeeModifier)->delete_records_by_id($_DELETE[id]);
                else if($_DELETE[id] == "" && $_DELETE[organ_id] != "" && $_DELETE[personel_number] == "")
                    (new EmployeeModifier)->delete_records_by_organ_id($_DELETE[organ_id]);
                else if($_DELETE[id] == "" && $_DELETE[organ_id] != "" && $_DELETE[personel_number] != "")
                    (new EmployeeModifier)->delete_records_by_organ_id_and_personal_number($_DELETE[organ_id] , $_DELETE[personel_number]);
                else
                    print_output(400 , false , "both id and name are not allowed");

            }
        break ;

        case "PUT" :
            header('Content-Type: application/json');
            $_PUT = Array();
            parse_str(file_get_contents('php://input') , $_PUT);
        

            if($_PUT[id] == "" && $_PUT[personal_number] == ""  && $_PUT[organ_id] == "")
                print_output(400 , false , "no entery");
            else
            {
                if($_PUT[new_name] =="")
                {
                    print_output(400 , false , "no new name");
                }
                else
                {
                    if($_PUT[id] != "" && $_PUT[personal_number] == ""  && $_PUT[organ_id] == "")
                        (new EmployeeModifier)->update_records_by_id($_PUT[id] , $_PUT[new_name]);
                    else if($_PUT[id] == "" && $_PUT[personal_number] != ""  && $_PUT[organ_id] != "")
                        (new OrganizationModifier)->update_records_by_organ_id_and_personal_number($_PUT[organ_id] ,$_PUT[personal_number] ,$_PUT[new_name]);
                    else
                       print_output(400 , false , "both id and name are not allowed");
                }

            }
        break ;

    }



?>