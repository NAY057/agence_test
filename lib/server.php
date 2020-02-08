<?php

$dns = 'mysql:host=https://bdagencetest.000webhostapp.com;dbname=id12502561_agence';
$user = 'agence';
$pass = '111111';

try{
    $db = new PDO($dns, $user, $pass);
    echo 'connected';
}catch(PDOExeption $e) {
    $error = $e->getMessage();
    echo $error;
}