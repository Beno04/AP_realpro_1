<?php

function connexionBase($servername, $username, $password, $dbname) {
    try {
        return new PDO("mysql:host=$servername;dbname=$dbname;charset=utf8", $username, $password, [
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
            PDO::ATTR_EMULATE_PREPARES => false
        ]);
    } catch (PDOException $e) {
        die("Erreur : " . $e->getMessage());
    }
}

$test = connexionBase("127.0.0.1", "marieteam", "marieteam", "marieteam");

var_dump($test);

?>
