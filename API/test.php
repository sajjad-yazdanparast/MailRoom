<?php
$serverName = "localhost";
$connectionOptions = array(
    "Database" => "MailRoom",
    "Uid" => "sa",
    "PWD" => "s@j1563j@d"
);
//Establishes the connection
$conn = sqlsrv_connect($serverName, $connectionOptions);

//Insert Query
echo ("Inserting a new row into table" . PHP_EOL);
$tsql= "
INSERT INTO Attachment (document_belong_to_id,letter_attached_id,file_a) VALUES
(null,null,?)
";
// $params = array('Tehran University');
$name = $_FILES['file_a']['name'];
$target_dir = "upload/";
$target_file = $target_dir . basename($name);

// Select file type
$imageFileType = strtolower(pathinfo($target_file,PATHINFO_EXTENSION));

// Valid file extensions
$extensions_arr = array("jpg","jpeg","png","gif","pdf");

// Check extension
if( in_array($imageFileType,$extensions_arr) ){

   // Insert record

   $getResults= sqlsrv_query($conn, $tsql, array($name));
   $rowsAffected = sqlsrv_rows_affected($getResults);
   if ($getResults == FALSE or $rowsAffected == FALSE)
       echo ('Oh no ');
   echo ($rowsAffected. " row(s) inserted: " . PHP_EOL);
   
   sqlsrv_free_stmt($getResults);
   // Upload file
   move_uploaded_file($_FILES['file_a']['tmp_name'],$target_dir.$name);

}

?>