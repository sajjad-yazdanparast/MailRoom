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
}

?>