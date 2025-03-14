<?php
include '../Fonctions/Script.php';

$nom_secteur = isset($_GET['nom_secteur']) ? $_GET['nom_secteur'] : '';
$desc_travers = isset($_GET['desc_travers']) ? $_GET['desc_travers'] : '';
$date_travers = isset($_GET['date_travers']) ? $_GET['date_travers'] : '';

if ($nom_secteur && $desc_travers && $date_travers) {
    $traversees = GetInfo3option($nom_secteur, $desc_travers, $date_travers);
} elseif ($nom_secteur && $desc_travers) {
    $traversees = GetInfo2option($nom_secteur, $desc_travers);
} elseif ($nom_secteur) {
    $traversees = GetInfo1Option($nom_secteur);
} else {
    $traversees = GetInfo();
}

header('Content-Type: application/json');
echo json_encode($traversees);
