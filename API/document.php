<?php
    require 'connect.php' ;
    require 'utills.php' ;

    class DocumentModifier{
        private $db = null;
        public function __construct() {
            $this->db = (new DataBaseConnector())->get_connection();
        }

        public function create_by_organ_id($organ_id , $type, $text, $letter_to_be_attached , $doc_to_be_attached , $file_to_be_attached){
            $tsql = "EXEC organization_create_doc @organ_id =?, @type =?, @text =?, @letter_to_be_attached =?, @doc_to_be_attached =? , @file_to_be_attached =?" ;
            $getResults = sqlsrv_query($this->db,$tsql,array($organ_id , $type, $text, $letter_to_be_attached , $doc_to_be_attached , $file_to_be_attached)) ;
            $rowsAffected = sqlsrv_rows_affected($getResults);
            if ($getResults == FALSE or $rowsAffected == FALSE)
                die(FormatErrors(sqlsrv_errors()));

            print_output(201 , true , $name ." added successfully");

            sqlsrv_free_stmt($getResults);

        }

        public function create_by_employee_id($employee_id , $type, $text, $letter_to_be_attached , $doc_to_be_attached , $file_to_be_attached){
            $tsql = "EXEC employee_create_doc @employee_id =?, @type =?, @text =?, @letter_to_be_attached =?, @doc_to_be_attached =? , @file_to_be_attached =?" ;
            $getResults = sqlsrv_query($this->db,$tsql,array($organ_id , $type, $text, $letter_to_be_attached , $doc_to_be_attached , $file_to_be_attached)) ;
            $rowsAffected = sqlsrv_rows_affected($getResults);
            if ($getResults == FALSE or $rowsAffected == FALSE)
                die(FormatErrors(sqlsrv_errors()));

            print_output(201 , true , $name ." added successfully");

            sqlsrv_free_stmt($getResults);

        }
    }


    switch ($_SERVER["REQUEST_METHOD"]) 
    {
        case "POST":
            header('Content-Type: application/json');
            $name = $_FILES['file_to_be_attached']['name'];
            $target_dir = "upload/";
            $target_file = $target_dir . basename($name);

            // Select file type
            $imageFileType = strtolower(pathinfo($target_file,PATHINFO_EXTENSION));

            // Valid file extensions
            $extensions_arr = array("jpg","jpeg","png","gif","pdf");

            if($name=="")
            {
                if($_POST[employee_id!=""])
                    (new DocumentModifier()).send($_POST[employee_id],$_POST[type],$_POST[text],$_POST[letter_to_be_attached],$_POST[doc_to_be_attached],"");
                else if ($_POST[organ_id]!="")
                    (new DocumentModifier()).send($_POST[organ_id],$_POST[type],$_POST[text],$_POST[letter_to_be_attached],$_POST[doc_to_be_attached],"");
            }
            else
            {
                // Check extension
                if( in_array($imageFileType,$extensions_arr) ){
                    move_uploaded_file($_FILES['file_to_be_attached']['tmp_name'],$target_dir.$name);
                    if($_POST[employee_id!=""])
                        (new DocumentModifier()).send($_POST[employee_id],$_POST[type],$_POST[text],$_POST[letter_to_be_attached],$_POST[doc_to_be_attached],$target_dir.$name);
                    else if ($_POST[organ_id]!="")
                        (new DocumentModifier()).send($_POST[organ_id],$_POST[type],$_POST[text],$_POST[letter_to_be_attached],$_POST[doc_to_be_attached],$target_dir.$name);

                }
                else
                {
                    print_output(400,false ,"sent file is available");
                }
            }
        break;
    }

?>