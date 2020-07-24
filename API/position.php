<?php
    require 'connect.php' ;
    require 'utills.php' ;

    class PositionModifier{
        private $db = null;
        public function __construct() {
            $this->db = (new DataBaseConnector())->get_connection();
        }


        public function get_all_records($order){
            $tsql = "EXEC get_all_ranks @order = ?" ;
            $getResults= sqlsrv_query($this->db, $tsql , array($order));
            if ($getResults == FALSE)
                die(FormatErrors(sqlsrv_errors()));

            $output = array();
            while ($row = sqlsrv_fetch_array($getResults, SQLSRV_FETCH_ASSOC)) {
                $obj["name"] = $row['name'];
                $obj["rank"] = $row['rank'];
                $output[] = $obj;
            }
            sqlsrv_free_stmt($getResults);
            print_output(200 , true , $output);

        }

        public function get_records_by_rank($rank){
            $tsql = "EXEC get_position_by_rank @rank = ?" ;
            $getResults = sqlsrv_query($this->db,$tsql,array($rank)) ;
            if ($getResults == FALSE)
                die(FormatErrors(sqlsrv_errors()));

            $output = array();
            while ($row = sqlsrv_fetch_array($getResults, SQLSRV_FETCH_ASSOC)) {
                $obj["name"] = $row['name'];
                $obj["rank"] = $row['rank'];
                $output[] = $obj;
            }
            sqlsrv_free_stmt($getResults);
            print_output(200 , true , $output);
        }

        public function get_records_by_name($name){
            $tsql = "EXEC get_position_by_name @name = ?" ;
            $getResults = sqlsrv_query($this->db,$tsql,array($name)) ;
            if ($getResults == FALSE)
                die(FormatErrors(sqlsrv_errors()));

            $output = array();
            while ($row = sqlsrv_fetch_array($getResults, SQLSRV_FETCH_ASSOC)) {
                $obj["name"] = $row['name'];
                $obj["rank"] = $row['rank'];
                $output[] = $obj;
            }
            sqlsrv_free_stmt($getResults);
            print_output(200 , true , $output);
        }

        public function insert_record($name,$rank){
            $tsql = "EXEC insert_position @name = ?, @rank = ? " ;
            $getResults = sqlsrv_query($this->db,$tsql,array($name,$rank)) ;
            $rowsAffected = sqlsrv_rows_affected($getResults);
            if ($getResults == FALSE or $rowsAffected == FALSE)
                die(FormatErrors(sqlsrv_errors()));

            print_output(201 , true , $name ." added successfully");

            sqlsrv_free_stmt($getResults);

        }


        public function delete_all_records(){
            $tsql = "EXEC delete_all_positions" ;
            $getResults = sqlsrv_query($this->db,$tsql) ;
            $rowsAffected = sqlsrv_rows_affected($getResults);
            if ($getResults == FALSE or $rowsAffected == FALSE)
                die(FormatErrors(sqlsrv_errors()));

            print_output(200 , true ,"all positions were removed successfully");

            sqlsrv_free_stmt($getResults);

        }

        public function delete_records_by_name($name){
            $tsql = "EXEC delete_position_by_name @name = ?" ;
            $getResults = sqlsrv_query($this->db,$tsql , array($name)) ;
            $rowsAffected = sqlsrv_rows_affected($getResults);
            if ($getResults == FALSE or $rowsAffected == FALSE)
                die(FormatErrors(sqlsrv_errors()));

            print_output(200 , true ,"positions with name=". $name ." were removed successfully");

            sqlsrv_free_stmt($getResults);

        }

        public function delete_records_by_rank($rank){
            $tsql = "EXEC delete_position_by_rank @rank = ?" ;
            $getResults = sqlsrv_query($this->db,$tsql , array($rank)) ;
            $rowsAffected = sqlsrv_rows_affected($getResults);
            if ($getResults == FALSE or $rowsAffected == FALSE)
                die(FormatErrors(sqlsrv_errors()));

            print_output(200 , true ,"positions with rank=". $rank ." were removed successfully");

            sqlsrv_free_stmt($getResults);

        }

        public function update_position_name_by_rank($new_name ,$rank){
           
            $tsql = "EXEC update_position_name_by_rank @new_name =?, @rank =? " ;
            $getResults = sqlsrv_query($this->db,$tsql , array($new_name,$rank)) ;
            $rowsAffected = sqlsrv_rows_affected($getResults);
            if ($getResults == FALSE or $rowsAffected == FALSE)
                die(FormatErrors(sqlsrv_errors()));

            print_output(200 , true , "positions with rank=". $rank ." were updated successfully");

            sqlsrv_free_stmt($getResults);

        }

        public function update_position_rank_by_name($name ,$new_rank){
           
            $tsql = "EXEC update_position_rank_by_name @name =?, @new_rank =?" ;
            $getResults = sqlsrv_query($this->db,$tsql , array($name,$new_rank)) ;
            $rowsAffected = sqlsrv_rows_affected($getResults);
            if ($getResults == FALSE or $rowsAffected == FALSE)
                die(FormatErrors(sqlsrv_errors()));

            print_output(200 , true , "positions with name=". $name ." were updated successfully");

            sqlsrv_free_stmt($getResults);

        }
    }


    switch ($_SERVER["REQUEST_METHOD"]) 
    {
        case "GET" :
            header('Content-Type: application/json');
            if(htmlspecialchars($_GET[name]) == "" && htmlspecialchars($_GET[rank]) == "" && htmlspecialchars($_GET[order]) == "")
                print_output(400 , false , "no entery");
            else
            {
                if(htmlspecialchars($_GET[name]) == "" && htmlspecialchars($_GET[rank]) == "" && htmlspecialchars($_GET[order]) != "")
                    (new PositionModifier())->get_all_records($_GET[order]);
                else  if(htmlspecialchars($_GET[name]) != "" && htmlspecialchars($_GET[rank]) == "" && htmlspecialchars($_GET[order]) == "")
                    (new PositionModifier())->get_records_by_name($_GET[name]);
                else  if(htmlspecialchars($_GET[name]) == "" && htmlspecialchars($_GET[rank]) != "" && htmlspecialchars($_GET[order]) == "")
                    (new PositionModifier())->get_records_by_rank($_GET[rank]);
                else
                    print_output(400 , false , "no such request available");
            }
        break;
        case "POST":
            header('Content-Type: application/json');
            if($_POST[name]!="" && $_POST[rank] !="")
                (new PositionModifier())->insert_record($_POST[name] , $_POST[rank]);
            else
                print_output(400 , false , "no entery");
        break;

        case "DELETE" :
            header('Content-Type: application/json');
            $_DELETE = Array();
            parse_str(file_get_contents('php://input') , $_DELETE);
            
            if($_DELETE[name] == ""  && $_DELETE[rank] == "" )
                (new PositionModifier())->delete_all_records();
            else
            {
                if($_DELETE[name] != ""  && $_DELETE[rank] == "" )
                    (new PositionModifier())->delete_records_by_name($_DELETE[name]);
                else if($_DELETE[name] == ""  && $_DELETE[rank] != "" )
                    (new PositionModifier())->delete_records_by_rank($_DELETE[rank]);
                else
                    print_output(400 , false , "both rank and name are not allowed");
            }
        break;
        case "PUT" :
            header('Content-Type: application/json');
            $_PUT = Array();
            parse_str(file_get_contents('php://input') , $_PUT);
        

            if($_PUT[name] == "" && $_PUT[rank] == "")
                print_output(400 , false , "no entery");
            else
            {
                
                if($_PUT[name] != "" && $_PUT[rank] == "")
                {
                    if($_PUT[new_rank]!="")
                        (new PositionModifier())->update_position_rank_by_name($_PUT[name] , $_PUT[new_rank]);
                    else
                        print_output(400 , false , "new_rank is not allowed");
                }
                else if($_PUT[name] == "" && $_PUT[rank] != "")
                {
                    if($_PUT[new_rank]!="")
                        (new PositionModifier())->update_position_name_by_rank($_PUT[new_name] , $_PUT[rank]);
                    else
                        print_output(400 , false , "new_rank is not allowed");
                }
                else
                   print_output(400 , false , "both rank and name are not allowed");
                

            }
        break ;
    }


?>