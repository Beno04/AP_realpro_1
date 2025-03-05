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
          <?php if ($_SESSION['typer_user'] === 'Gestionnaire'): ?>
          <li class="titre-marieteam"><a href="accueilAdmin.php"><b>MarieTeam</b></a></li>
          <?php else: ?>
              <li class="titre-marieteam"><a href="index.php"><b>MarieTeam</b></a></li>
          <?php endif; ?>        
          
          <div class="nav-buttons">

        <?php if (isset($prenom) && isset($nom)): ?>
            <li><a class="active" href="adminStats.php">Statistiques réservation</a></li>
          <?php else: ?>
            <li><a href="connexion.php">Réserver</a></li>
          <?php endif; ?>

          <li><a href="addLiaison.php">Gestion des liaisons</a></li>

          <?php if (isset($prenom) && isset($nom)): ?>
            <li><a href="profile.php"><b class="connexion-btn"><?php echo $prenom . ' ' . $nom; ?></b></a></li>
          <?php else: ?>
            <li><a href="connexion.php"><b class="connexion-btn">Connexion</b></a></li>
          <?php endif; ?>
        </div>
      </ul>
    </nav>

        <div class="blockR">
            <div class="destination">
                <lu>
                    <li>Belle-Île-en-mer</li>
                    <li>Houat</li>
                    <li>Ile de Groix</li>
                    <li>Ouessant</li>
                    <li>Molène</li>
                    <li>Sein</li>
                    <li>Bréhat</li>
                    <li>Batz</li>
                    <li>Aix</li>
                    <li>Yeu</li>
                </lu>
            </div>
            <div class="tableauReservation">
                <table>
                    <tr>
                    </tr>
                </table>
            </div>










        </div>
    </body>
</html>