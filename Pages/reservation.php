<?php
if (isset($_GET['id_travers'])) {
    $id_travers = htmlspecialchars($_GET['id_travers']);

    echo "<h2>Réservation pour la traversée n° $id_travers</h2>";

    // Ici, tu peux récupérer les infos détaillées de la traversée depuis la BDD
} else {
    echo "<h2>Aucune traversée sélectionnée</h2>";
}
?>
