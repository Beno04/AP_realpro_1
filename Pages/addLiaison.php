<html lang="fr">
  <head>
    <link rel="stylesheet" type="text/css" href="../Style/style.css" />
    <meta charset="utf-8" />
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
        <li class="titre-marieteam"><a href="accueilAdmin.php"><b>MarieTeam</b></a></li>
        <div class="nav-buttons">

        <?php if (isset($prenom) && isset($nom)): ?>
            <li><a href="adminStats.php">Statistiques réservation</a></li>
          <?php else: ?>
            <li><a href="connexion.php">Réserver</a></li>
          <?php endif; ?>

          <li><a class="active" href="addLiaison.php">Gestion des liaisons</a></li>

          <?php if (isset($prenom) && isset($nom)): ?>
            <li><a href="profile.php"><b class="connexion-btn"><?php echo $nom . ' ' . $prenom; ?></b></a></li>
          <?php else: ?>
            <li><a href="connexion.php"><b class="connexion-btn">Connexion</b></a></li>
          <?php endif; ?>
        </div>
      </ul>
    </nav>

  </body>
</html>
