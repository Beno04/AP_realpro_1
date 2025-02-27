<?php
include '../Fonctions/Script.php';

if (isset($_GET['nom_secteur'])) {
    $nom_secteur = $_GET['nom_secteur'];
    $descriptions = getDescTraversées($nom_secteur);
    echo json_encode($descriptions);
} else {
    echo json_encode([]);
}
?>
