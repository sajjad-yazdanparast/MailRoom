<?php
    require 'connect.php' ;
    require 'utills.php' ;

    class LetterModifier{
        private $db = null;
        public function __construct() {
            $this->db = (new DataBaseConnector())->get_connection();
        }

        public function send($sender,$reciever,$intermediate_interactor ,$is_sender_organ ,$is_reciever_organ ,$is_intermediate_interactor_organ ,$text ,$type ,$letter_to_be_attached ,$doc_to_be_attached ,$file_to_be_attached){
            $tsql = "EXEC send_letter @sender =?, @reciever =?, @intermediate_interactor =? , @is_sender_organ =?, @is_reciever_organ =?, @is_intermediate_interactor_organ =?, @text =?, @type =?,  @letter_to_be_attached =?, @doc_to_be_attached =? , @file_to_be_attached = ?" ;
            $getResults = sqlsrv_query($this->db,$tsql,array($name,$address,$telephone)) ;
            $rowsAffected = sqlsrv_rows_affected($getResults);
            if ($getResults == FALSE or $rowsAffected == FALSE)
                die(FormatErrors(sqlsrv_errors()));

            print_output(201 , true , $name ." added successfully");

            sqlsrv_free_stmt($getResults);

        }
    }

    switch ($_SERVER["REQUEST_METHOD"]) 
    {
        case "GET" :
        break;
        case "POST":
        break;
    }
?>