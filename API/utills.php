<?php


function FormatErrors( $errors )
{
    /* Display errors. */

    $output = array() ;
    foreach ( $errors as $error )
    {
        $obj["SQLSTATE"] = $error['SQLSTATE'];
        $obj["Code"] = $error['code'];
        $obj["Message"] = $error['message'];

        $output[] = $obj ;
    }
    echo json_encode($output) ;
    http_response_code(400);
}


function print_output($response_code , $status , $message)
    {
        $obj->status = $status;
        if($status)
            $obj->data =  $message;        
        else
            $obj->error =  $message;        
        echo json_encode($obj);
        http_response_code($response_code);
    }

?>