<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="../Style/style.css">
    <title>MarieTeam</title>
</head>
<body>


    <?php
    // Inclure le fichier qui vérifie si l'utilisateur est connecté et récupère son prénom et nom
    include '../Fonctions/scriptUserConnecte.php'; 
    ?>

    
    <!-- Barre de navigation -->
    <nav class="menu">
      <ul>
        <?php if ($_SESSION['typer_user'] === 'Gestionnaire'): ?>
          <li class="titre-marieteam"><a href="accueilAdmin.php"><b>MarieTeam</b></a></li>
          <?php else: ?>
              <li class="titre-marieteam"><a href="index.php"><b>MarieTeam</b></a></li>
          <?php endif; ?>        <div class="nav-buttons">

        <?php if (isset($prenom) && isset($nom)): ?>
            <li><a class='active' href="reserver.php">Réserver</a></li>
          <?php else: ?>
            <li><a href="connexion.php">Réserver</a></li>
          <?php endif; ?>

          <li><a href="index.php">À propos</a></li>

          <?php if (isset($prenom) && isset($nom)): ?>
            <li><a href="profile.php"><b class="connexion-btn"><?php echo $prenom . ' ' . $nom; ?></b></a></li>
          <?php else: ?>
            <li><a href="connexion.php"><b class="connexion-btn">Connexion</b></a></li>
          <?php endif; ?>
        </div>
      </ul>
    </nav>
<body>
    


<div class="_reservation-container">
<?php
include '../Fonctions/scriptReservation.php';

if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $id_travers = isset($_POST['id_travers']) ? htmlspecialchars($_POST['id_travers']) : null;
    $desc_travers = isset($_POST['desc_travers']) ? htmlspecialchars($_POST['desc_travers']) : "";
    $date_travers = isset($_POST['date_travers']) ? htmlspecialchars($_POST['date_travers']) : "";
    $heure_travers = isset($_POST['heure_travers']) ? htmlspecialchars($_POST['heure_travers']) : "Non spécifiée";

    // Si desc_travers ou date_travers sont vides, récupérer les infos via la BDD
    if (empty($desc_travers) || empty($date_travers)) {
        if ($id_travers) {
            $reservationInfo = getReservationInfo($id_travers);

            // Vérifier si la requête a retourné un résultat
            if ($reservationInfo) {
                $desc_travers = $reservationInfo['desc_travers'] ?? "Non spécifiée";
                $date_travers = $reservationInfo['date_travers'] ?? "Non spécifiée";
            }
        }
    }

    if ($id_travers) {
        echo "<h2>$desc_travers</h2>";
        echo "<p>Traversée n°$id_travers le $date_travers à $heure_travers</p>";
    } else {
        echo "<h2>Aucune traversée sélectionnée</h2>";
    }
} else {
    echo "<h2>Accès interdit</h2>";
}
?>
<form class="_reservation-form">
            <input type="text" placeholder="Nom" class="_reservation-input">
            <input type="text" placeholder="Adresse" class="_reservation-input">
            <input type="text" placeholder="CP" class="_reservation-input">
            <input type="text" placeholder="Ville" class="_reservation-input">
        </form>

        <table class="_reservation-table">
            <thead>
                <tr>
                    <th>Catégorie</th>
                    <th>Tarif en €</th>
                    <th>Quantité</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>Adulte</td>
                    <td>20.00</td>
                    <td><input type="number" value="" min="0" class="_reservation-quantity"></td>
                </tr>
                <tr>
                    <td>Junior 8 à 18 ans</td>
                    <td>13.10</td>
                    <td><input type="number" value="" min="0" class="_reservation-quantity"></td>
                </tr>
                <tr>
                    <td>Enfant 0 à 7 ans</td>
                    <td>7.00</td>
                    <td><input type="number" value="" min="0" class="_reservation-quantity"></td>
                </tr>
                <tr>
                    <td>Voiture long. inf. 4m</td>
                    <td>95.00</td>
                    <td><input type="number" value="" min="0" class="_reservation-quantity"></td>
                </tr>
                <tr>
                    <td>Voiture long. inf. 5m</td>
                    <td>142.00</td>
                    <td><input type="number" value="" min="0" class="_reservation-quantity"></td>
                </tr>
                <tr>
                    <td>Fourgon</td>
                    <td>208.00</td>
                    <td><input type="number" value="" min="0" class="_reservation-quantity"></td>
                </tr>
                <tr>
                    <td>Camping Car</td>
                    <td>226.00</td>
                    <td><input type="number" value="" min="0" class="_reservation-quantity"></td>
                </tr>
                <tr>
                    <td>Camion</td>
                    <td>295.00</td>
                    <td><input type="number" value="" min="0" class="_reservation-quantity"></td>
                </tr>
            </tbody>
        </table>
        <button class="_reservation-button" type="submit">Enregistrer la réservation</button>
    </div>

</body>