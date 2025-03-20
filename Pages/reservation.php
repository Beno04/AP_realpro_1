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

    <?php
include '../Fonctions/scriptReservation.php';

if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $id_travers = isset($_POST['id_travers']) ? htmlspecialchars($_POST['id_travers']) : null;
    $desc_travers = isset($_POST['desc_travers']) ? htmlspecialchars($_POST['desc_travers']) : "Non spécifié";
    $date_travers = isset($_POST['date_travers']) ? htmlspecialchars($_POST['date_travers']) : "Non spécifiée";
    $heure_travers = isset($_POST['heure_travers']) ? htmlspecialchars($_POST['heure_travers']) : "Non spécifiée";

    if ($id_travers) {
        echo "<h2>Réservation pour la traversée n° $id_travers</h2>";
        echo "<p>Description : $desc_travers</p>";
        echo "<p>Date : $date_travers</p>";
        echo "<p>Heure : $heure_travers</p>";

        // Ici, tu peux récupérer les infos détaillées de la traversée depuis la BDD
    } else {
        echo "<h2>Aucune traversée sélectionnée</h2>";
    }
} else {
    echo "<h2>Accès interdit</h2>";
}
?>

