<?php
include '../Fonctions/Script.php'; // Assurez-vous que ce chemin est correct

$desc_travers = $_GET['desc_travers'];
$date_travers = $_GET['date_travers'];

$info = GetInfo($desc_travers, $date_travers);

echo json_encode($info);
?>
