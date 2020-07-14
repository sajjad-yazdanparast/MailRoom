<?php
    require 'connect.php' ;
    require 'utills.php' ;

    class OrganizationModifier{
        private $db = null;
        public function __construct() {
            $this->db = (new DataBaseConnector())->get_connection();
        }
        public function get_all_records(){
            $tsql = "EXEC get_all_organizations" ;
            $getResults= sqlsrv_query($this->db, $tsql);
            if ($getResults == FALSE)
                die(FormatErrors(sqlsrv_errors()));

            $output = array();
            while ($row = sqlsrv_fetch_array($getResults, SQLSRV_FETCH_ASSOC)) {
                $obj["name"] = $row['name'];
                $output[] = $obj;
            }
            sqlsrv_free_stmt($getResults);
            print_output(200 , true , $output);

        }

        public function get_records_by_name($name){
            $tsql = "EXEC get_organization_by_name @name = ?" ;
            $getResults = sqlsrv_query($this->db,$tsql,array($name)) ;
            if ($getResults == FALSE)
                die(FormatErrors(sqlsrv_errors()));

            $output = array();
            while ($row = sqlsrv_fetch_array($getResults, SQLSRV_FETCH_ASSOC)) {
                $obj->id= $row['ID'];
                $obj->name = $row['name'];
                $output[] = $obj;
            }
            sqlsrv_free_stmt($getResults);
            print_output(200 , true , $output);
        }
        public function get_records_by_id($id){
            $tsql = "EXEC get_organization_by_id @id = ?" ;
            $getResults = sqlsrv_query($this->db,$tsql,array($id)) ;
            if ($getResults == FALSE)
                die(FormatErrors(sqlsrv_errors()));

            $output = array();
            while ($row = sqlsrv_fetch_array($getResults, SQLSRV_FETCH_ASSOC)) {
                $obj->id= $row['ID'];
                $obj->name = $row['name'];
                $output[] = $obj;
            }
            sqlsrv_free_stmt($getResults);
            print_output(200 , true , $output);
        }
        public function insert_record($name){
            $tsql = "EXEC insert_organization @name = ?" ;
            $getResults = sqlsrv_query($this->db,$tsql,array($name)) ;
            $rowsAffected = sqlsrv_rows_affected($getResults);
            if ($getResults == FALSE or $rowsAffected == FALSE)
                die(FormatErrors(sqlsrv_errors()));

            print_output(201 , true , $name ." added successfully");

            sqlsrv_free_stmt($getResults);

        }

        public function delete_all_records(){
            $tsql = "EXEC delete_all_organizations" ;
            $getResults = sqlsrv_query($this->db,$tsql) ;
            $rowsAffected = sqlsrv_rows_affected($getResults);
            if ($getResults == FALSE or $rowsAffected == FALSE)
                die(FormatErrors(sqlsrv_errors()));

            print_output(200 , true ,"all organizations were removed successfully");

            sqlsrv_free_stmt($getResults);

        }

        public function delete_records_by_name($name){
            $tsql = "EXEC delete_organization_by_name @name = ?" ;
            $getResults = sqlsrv_query($this->db,$tsql , array($name)) ;
            $rowsAffected = sqlsrv_rows_affected($getResults);
            if ($getResults == FALSE or $rowsAffected == FALSE)
                die(FormatErrors(sqlsrv_errors()));

            print_output(200 , true ,"oraganizations with name=". $name ." were removed successfully");

            sqlsrv_free_stmt($getResults);

        }

        public function delete_records_by_id($id){
            $tsql = "EXEC delete_organization_by_id @id = ?" ;
            $getResults = sqlsrv_query($this->db,$tsql , array($id)) ;
            $rowsAffected = sqlsrv_rows_affected($getResults);
            if ($getResults == FALSE or $rowsAffected == FALSE)
                die(FormatErrors(sqlsrv_errors()));

            print_output(200 , true , "oraganization with id=". $id ." was removed successfully");

            sqlsrv_free_stmt($getResults);

        }

        public function update_records_by_name($old_name ,$new_name){
            echo $old_name ."   ". $new_name;
            $tsql = "EXEC update_organization_by_name @old_name = ? , @new_name = ?" ;
            $getResults = sqlsrv_query($this->db,$tsql , array($old_name,$new_name)) ;
            $rowsAffected = sqlsrv_rows_affected($getResults);
            if ($getResults == FALSE or $rowsAffected == FALSE)
                die(FormatErrors(sqlsrv_errors()));

            print_output(200 , true , "oraganizations with name=". $old_name ." were updated successfully");

            sqlsrv_free_stmt($getResults);

        }
        public function update_records_by_id($id ,$new_name){
            $tsql = "EXEC update_organization_by_id @id = ? , @new_name = ?" ;
            $getResults = sqlsrv_query($this->db,$tsql , array($id,$new_name)) ;
            $rowsAffected = sqlsrv_rows_affected($getResults);
            if ($getResults == FALSE or $rowsAffected == FALSE)
                die(FormatErrors(sqlsrv_errors()));

            print_output(200 , true , "oraganization with ID=". $id ." was updated successfully");

            sqlsrv_free_stmt($getResults);

        }

    }

    

    switch ($_SERVER["REQUEST_METHOD"]) 
    {
        case "GET" :
            header('Content-Type: application/json');
            if(htmlspecialchars($_GET[name]) == "" && htmlspecialchars($_GET[id]) == "")
                ( new OrganizationModifier())->get_all_records();
            else
            {
                if(htmlspecialchars($_GET[name]) != "" && htmlspecialchars($_GET[id]) == "")
                    (new OrganizationModifier())->get_records_by_name($_GET[name]);
                else if(htmlspecialchars($_GET[name]) == "" && htmlspecialchars($_GET[id]) != "")
                    (new OrganizationModifier())->get_records_by_id($_GET[id]);
                else
                    print_output(400 , false , "both id and name are not allowed");
            }
        
        break ;
        case "POST" :
            $name = $_POST["name"] ;
            header('Content-Type: application/json');
           ( new OrganizationModifier())->insert_record($name) ;
        break ;
        case "DELETE" :
            header('Content-Type: application/json');
            $_DELETE = Array();
            parse_str(file_get_contents('php://input') , $_DELETE);

        


            if($_DELETE[name] == "" && $_DELETE[id] == "")
                (new OrganizationModifier)->delete_all_records();
            else
            {
                if($_DELETE[name] != "" && $_DELETE[id] == "")
                    (new OrganizationModifier)->delete_records_by_name($_DELETE[name]);
                else if($_DELETE[name] == "" && $_DELETE[id] != "")
                    (new OrganizationModifier)->delete_records_by_id($_DELETE[id]);
                else
                    print_output(400 , false , "both id and name are not allowed");

            }
        break ;
        case "PUT" :
            header('Content-Type: application/json');
            $_PUT = Array();
            parse_str(file_get_contents('php://input') , $_PUT);
        

            if($_PUT[old_name] == "" && $_PUT[id] == "")
                print_output(400 , false , "no entery");
            else
            {
                if($_PUT[new_name] =="")
                {
                    print_output(400 , false , "no new name");
                }
                else
                {
                    if($_PUT[old_name] != "" && $_PUT[id] == "")
                        (new OrganizationModifier)->update_records_by_name($_PUT[old_name] , $_PUT[new_name]);
                    else if($_PUT[old_name] == "" && $_PUT[id] != "")
                        (new OrganizationModifier)->update_records_by_id($_PUT[id] , $_PUT[new_name]);
                    else
                       print_output(400 , false , "both id and name are not allowed");
                }

            }
        break ;

    }


    function getContent()
    {
        if (null === $this->content)
        {
            if (0 === strlen(trim($this->content = file_get_contents('php://input'))))
            {
                $this->content = false;
            }
        }
        return $this->content;
    }   
?>

