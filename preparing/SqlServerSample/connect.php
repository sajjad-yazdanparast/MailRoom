<?php
    $serverName = "localhost";
    $connectionOptions = array(
        "Database" => "TestPhpDB",
        "Uid" => "sa",
        "PWD" => "2711378Hossein"
    );
    //Establishes the connection
    $conn = sqlsrv_connect($serverName, $connectionOptions);
    if($conn)
        echo "Connected!"
?>
