<?php
include '../Fonctions/Script.php';

function getReservationInfo($id) {
    $servername = "localhost"; 
    $username = "root";
    $password = "";
    $dbname = "marieteam";

    $pdo = connexionBase($servername, $username, $password, $dbname);
    $sql = "SELECT desc_travers, date_travers FROM `traversée` WHERE id_travers = :id";

    $stmt = $pdo->prepare($sql);
    $stmt->bindParam(':id', $id, PDO::PARAM_INT);
    $stmt->execute();

    return $stmt->fetch(PDO::FETCH_ASSOC);
}
