<?php
    $serverName = "localhost";
    $connectionOptions = array(
        "Database" => "MailRoom",
        "Uid" => "sa",
        "PWD" => "s@j1563j@d"
    );
    //Establishes the connection
    $conn = sqlsrv_connect($serverName, $connectionOptions);
    if($conn)
        echo "Connected!"
?>
