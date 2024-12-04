<?php


function connexionBDD() {
    $servername = "localhost";
    $username = "marieteam";
    $password = "marieteam";
    $dbname = "marieteam";

    try {
        $pdo = new PDO("mysql:host=$servername;dbname=$dbname", $username, $password);
        $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        return $pdo;
    } catch (PDOException $e) {
        echo "Erreur de connexion : " . $e->getMessage();
        return null;
    }
}

?>
