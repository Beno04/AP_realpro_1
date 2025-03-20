<?php
include '../Fonctions/Script.php';

header('Content-Type: application/json');

if (isset($_GET['nom_secteur']) && !empty($_GET['nom_secteur'])) {
    $nom_secteur = htmlspecialchars($_GET['nom_secteur'], ENT_QUOTES, 'UTF-8');

    if (isset($_GET['desc_travers']) && !empty($_GET['desc_travers'])) {
        $desc_travers = htmlspecialchars($_GET['desc_travers'], ENT_QUOTES, 'UTF-8');

        // 🔍 Log PHP au lieu d'afficher directement
        error_log("Secteur sélectionné: " . $nom_secteur);
        error_log("Traversée sélectionnée: " . $desc_travers);

        $start_time = microtime(true);
        $infos = GetInfo2Option($nom_secteur, $desc_travers);
        $end_time = microtime(true);

        error_log("Résultat SQL: " . print_r($infos, true));
    } else {
        $start_time = microtime(true);
        $infos = GetInfo1Option($nom_secteur);
        $end_time = microtime(true);
    }

    // Calcul du temps d'exécution
    $execution_time = $end_time - $start_time;
    error_log("Temps d'exécution SQL: " . $execution_time . " secondes");

    // Vérification et retour des données JSON valides
    echo json_encode($infos ?: []); // Retourne un tableau vide si aucune donnée
} else {
    echo json_encode(["error" => "Nom du secteur manquant"]);
}
?>
