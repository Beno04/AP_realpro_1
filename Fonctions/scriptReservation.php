<?php

function getReservationInfo($id) {
    $servername = "localhost"; 
    $username = "root";
    $password = "";
    $dbname = "marieteam";

    $pdo = connexionBase($servername, $username, $password, $dbname);
    $sql = "SELECT desc_travers, date_travers FROM `traversée` WHERE id_travers= :id";

    $stmt = $pdo->prepare($sql);
    $stmt->bindParam(':nom_secteur', $nom_secteur, PDO::PARAM_STR);
    $stmt->bindParam(':desc_travers', $desc_travers, PDO::PARAM_STR);
    $stmt->execute();

    return $stmt->fetchAll(PDO::FETCH_ASSOC);
}