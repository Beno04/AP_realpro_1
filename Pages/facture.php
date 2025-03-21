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



<?php
// Récupere les infos
$prix = Prix($id_travers);
$max = MaxPlace($id_travers);


// Récupérer les Prix
$prixA   = $prix['Adulte'] ?? 0;
$prixJ   = $prix['Junior 8 à 18 ans'] ?? 0;
$prixE   = $prix['Enfant 0 à 7'] ?? 0;
$prixVi4 = $prix['Voiture long.inf.4m'] ?? 0;
$prixVi5 = $prix['Voiture long.inf.5m'] ?? 0;
$prixF   = $prix['Fourgon'] ?? 0;
$prixCc  = $prix['Camping Car'] ?? 0;
$prixC   = $prix['Camion'] ?? 0;

// Récupérer les quantités maximales
$maxP = $max['PlaceDispoPassagers'] ?? 0;
$maxVi = $max['PlaceDispoVehiculesInf2m'] ?? 0;
$maxVs = $max['PlaceDispoVehiculesSup2m'] ?? 0;


?>

        <button class="_reservation-button" type="submit">Payer</button>
    </div>
</body>