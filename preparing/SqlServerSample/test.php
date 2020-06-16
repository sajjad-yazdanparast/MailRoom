
<?php

$serverName = "localhost";
$connectionOptions = array(
    "Database" => "TestPhpDB",
    "Uid" => "sa",
    "PWD" => "2711378Hossein"
);
//Establishes the connection
$conn = sqlsrv_connect($serverName, $connectionOptions);

/*if($conn)
    echo "Connected!\n";*/

//Insert Query
/*echo ("Inserting a new row into table test");
$tsql= "insert into test (ID,firstname,lastname) VALUES (?,?,?);";
$params = array(3,'sajjad','yazdanparast');
$getResults= sqlsrv_query($conn, $tsql, $params);
$rowsAffected = sqlsrv_rows_affected($getResults);
if ($getResults == FALSE or $rowsAffected == FALSE)
    die(FormatErrors(sqlsrv_errors()));
echo ($rowsAffected. " row(s) inserted: " . PHP_EOL);

sqlsrv_free_stmt($getResults);*/


//Read Query
$tsql= "SELECT ID, firstname, lastname FROM test;";
$getResults= sqlsrv_query($conn, $tsql);
//echo ("</br>"."Reading data from table test");
if ($getResults == FALSE)
    die(FormatErrors(sqlsrv_errors()));

$output = array();
while ($row = sqlsrv_fetch_array($getResults, SQLSRV_FETCH_ASSOC)) {
    //echo ("</br>".$row['ID'] . " " . $row['firstname'] . " " . $row['lastname']);
    $obj->ID = $row['ID'];
    $obj->firstname = $row['firstname'];
    $obj->lastname = $row['lastname'];

    $output[] = $obj;
}

$myJSON = json_encode($output);

echo $myJSON;
sqlsrv_free_stmt($getResults);


function FormatErrors( $errors )
{
    /* Display errors. */
    echo "Error information: ";

    foreach ( $errors as $error )
    {
        echo "SQLSTATE: ".$error['SQLSTATE']."";
        echo "Code: ".$error['code']."";
        echo "Message: ".$error['message']."";
    }
}

?>


