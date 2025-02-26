<?php
session_start();
include '../Fonctions/Script.php';

header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['nom_secteur'])) {
    $secteur = $_POST['nom_secteur'];
    $idSecteur = getIdSecteurs($secteur);

    if (is_array($idSecteur) && isset($idSecteur[0])) {
        $idSecteur = $idSecteur[0];
    }

    $traversees = $idSecteur ? getDescTraversées($idSecteur) : [];

    echo json_encode($traversees);
    exit;
}
echo json_encode([]);
?>
