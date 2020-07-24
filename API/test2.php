<?php

$name = $_FILES['file_a']['name'];
$target_dir = "upload/";
$target_file = $target_dir . basename($name);

// Select file type
$imageFileType = strtolower(pathinfo($target_file,PATHINFO_EXTENSION));

// Valid file extensions
$extensions_arr = array("jpg","jpeg","png","gif","pdf");

// Check extension
if( in_array($imageFileType,$extensions_arr) ){

   
   move_uploaded_file($_FILES['file_a']['tmp_name'],$target_dir.$name);

}

?>