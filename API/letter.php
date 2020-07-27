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

        public function organization_get_its_sent_letters($organ_id)
        {
            $tsql = "EXEC organization_get_its_sent_letters @organ_id = ?" ;
            $getResults = sqlsrv_query($this->db,$tsql,array($organ_id)) ;
            if ($getResults == FALSE)
                die(FormatErrors(sqlsrv_errors()));

            $output = array();
            while ($row = sqlsrv_fetch_array($getResults, SQLSRV_FETCH_ASSOC)) {
                $obj->id= $row['ID'];
                $obj->sender = $row['sender'];
                $obj->reciever = $row['reciever'];
                $obj->intermediate_interactor = $row['intermediate_interactor'];
                $obj->test = $row['text_l'];
                $obj->date = $row['date_l'];
                $output[] = $obj;
            }
            sqlsrv_free_stmt($getResults);
            print_output(200 , true , $output);
        }
        public function organization_get_its_recieved_letters($organ_id)
        {
            $tsql = "EXEC organization_get_its_recieved_letters @organ_id = ?" ;
            $getResults = sqlsrv_query($this->db,$tsql,array($organ_id)) ;
            if ($getResults == FALSE)
                die(FormatErrors(sqlsrv_errors()));

            $output = array();
            while ($row = sqlsrv_fetch_array($getResults, SQLSRV_FETCH_ASSOC)) {
                $obj->id= $row['ID'];
                $obj->sender = $row['sender'];
                $obj->reciever = $row['reciever'];
                $obj->intermediate_interactor = $row['intermediate_interactor'];
                $obj->test = $row['text_l'];
                $obj->date = $row['date_l'];
                $output[] = $obj;
            }
            sqlsrv_free_stmt($getResults);
            print_output(200 , true , $output);
        }
        public function employee_get_its_sent_letters($employee_id)
        {
            $tsql = "EXEC organization_get_its_recieved_letters @employee_id = ?" ;
            $getResults = sqlsrv_query($this->db,$tsql,array($employee_id)) ;
            if ($getResults == FALSE)
                die(FormatErrors(sqlsrv_errors()));

            $output = array();
            while ($row = sqlsrv_fetch_array($getResults, SQLSRV_FETCH_ASSOC)) {
                $obj->id= $row['ID'];
                $obj->sender = $row['sender'];
                $obj->reciever = $row['reciever'];
                $obj->intermediate_interactor = $row['intermediate_interactor'];
                $obj->test = $row['text_l'];
                $obj->date = $row['date_l'];
                $output[] = $obj;
            }
            sqlsrv_free_stmt($getResults);
            print_output(200 , true , $output);
        }

        public function employee_get_its_recieved_letters($employee_id)
        {
            $tsql = "EXEC employee_get_its_recieved_letters @employee_id = ?" ;
            $getResults = sqlsrv_query($this->db,$tsql,array($employee_id)) ;
            if ($getResults == FALSE)
                die(FormatErrors(sqlsrv_errors()));

            $output = array();
            while ($row = sqlsrv_fetch_array($getResults, SQLSRV_FETCH_ASSOC)) {
                $obj->id= $row['ID'];
                $obj->sender = $row['sender'];
                $obj->reciever = $row['reciever'];
                $obj->intermediate_interactor = $row['intermediate_interactor'];
                $obj->test = $row['text_l'];
                $obj->date = $row['date_l'];
                $output[] = $obj;
            }
            sqlsrv_free_stmt($getResults);
            print_output(200 , true , $output);
        }

        public function filter_letters($sender, $reciever ,$type , $date)
        {
            $tsql = "EXEC filter_letters @sender = ?, @reciever = ? ,@type = ? , @date = ?" ;
            $getResults = sqlsrv_query($this->db,$tsql,array($sender, $reciever ,$type , $date)) ;
            if ($getResults == FALSE)
                die(FormatErrors(sqlsrv_errors()));

            $output = array();
            while ($row = sqlsrv_fetch_array($getResults, SQLSRV_FETCH_ASSOC)) {
                $obj->id= $row['ID'];
                $obj->sender = $row['sender'];
                $obj->reciever = $row['reciever'];
                $obj->intermediate_interactor = $row['intermediate_interactor'];
                $obj->test = $row['text_l'];
                $obj->date = $row['date_l'];
                $output[] = $obj;
            }
            sqlsrv_free_stmt($getResults);
            print_output(200 , true , $output);
        }
        
    }

    switch ($_SERVER["REQUEST_METHOD"]) 
    {
        case "GET" :
            header('Content-Type: application/json');
            if(htmlspecialchars($_GET[request_type]) != "" )
            {
                switch($_GET[request_type])
                {
                    case "organ_sent_letters":
                        (new LetterModifier()).organization_get_its_sent_letters($_GET[organ_id]);
                    break;
                    case "organ_recieved_letters":
                        (new LetterModifier()).organization_get_its_recieved_letters($_GET[organ_id]);
                    break;
                    case "employee_sent_letters":
                        (new LetterModifier()).employee_get_its_sent_letters($_GET[employe_id]);
                    break;
                    case "employee_recieved_letters":
                        (new LetterModifier()).employee_get_its_recieved_letters($_GET[employe_id]);
                    break;
                    case "filter":
                        $sender = -1;
                        $reciever = -1;
                        $type = -1;
                        $date = '%';
                        if(htmlspecialchars($_GET[sender]) != "")
                            $sender = $_GET[sender];
                        if(htmlspecialchars($_GET[reciever]) != "")
                            $reciever = $_GET[reciever];
                        if(htmlspecialchars($_GET[type]) != "")
                            $type = $_GET[type];
                        if(htmlspecialchars($_GET[date]) != "")
                            $date = $_GET[date];
                                
                        (new LetterModifier()).employee_get_its_recieved_letters($_GET[sender] , $_GET[reciever] , $_GET[type] , $_GET[date]);
                    break;
                }
            }
            else
                print_output(400 , false , "type is empty");
        break;
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
                (new LetterModifier()).send($_POST[sender],$_POST[reciever],$_POST[intermediate_interactor],$_POST[is_sender_organ],$_POST[is_reciever_organ],$_POST[is_intermediate_interactor_organ],$_POST[text],$_POST[type],$_POST[letter_to_be_attached],$_POST[doc_to_be_attached],"");
            }
            else
            {
                // Check extension
                if( in_array($imageFileType,$extensions_arr) ){
                    move_uploaded_file($_FILES['file_to_be_attached']['tmp_name'],$target_dir.$name);
                    (new LetterModifier()).send($_POST[sender],$_POST[reciever],$_POST[intermediate_interactor],$_POST[is_sender_organ],$_POST[is_reciever_organ],$_POST[is_intermediate_interactor_organ],$_POST[text],$_POST[type],$_POST[letter_to_be_attached],$_POST[doc_to_be_attached],$target_dir.$name);

                }
                else
                {
                    print_output(400,false ,"sent file is available");
                }
            }
        break;
    }
?>