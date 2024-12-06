<html lang="fr">
  <head>
    <link rel="stylesheet" type="text/css" href="../Style/style.css" />
    <meta charset="utf-8" />
    <title>MarieTeam</title>
    <script src="../JavaScript/validConnexion.js" defer></script> <!-- Inclure le fichier JavaScript -->
  </head>

  <body>

    <?php
    include '../Fonctions/scriptConnexion.php'; // Inclure le fichier PHP
    ?>

    <!-- Barre de navigation -->
    <nav class="menu">
      <ul>
        <li class="titre-marieteam"><a href="index.php"><b>MarieTeam</b></a></li>
        <div class="nav-buttons">
          <li><a href="reserver.php">Réserver</a></li>
          <li><a href="index.php">À propos</a></li>
          <li><a href="connexion.php"><b class="connexion-btn">Connexion</b></a></li>
        </div>
      </ul>
    </nav>

    <!-- Section principale de connexion -->
    <br><br><br><br>
    <section class="connexion">
        <h1>Connexion à votre <span class="titre1">Compte</span></h1>
        <br><br>
        <form action="traitement_connexion.php" method="POST" id="connexionForm">
            <div class="form-group">
                <label for="email">Adresse e-mail :</label>
                <input type="email" id="email" name="email" required />
                <div id="errorEmailExist"></div> <!-- Zone d'erreur pour l'email -->
            </div>
            <div class="form-group">
                <label for="password">Mot de passe :</label>
                <input type="password" id="password" name="password" required />
                <div id="errorPwd"></div> <!-- Zone d'erreur pour le mot de passe -->
            </div>
            <button type="submit" class="btn-connexion">Connexion</button>
            <br><br>
            <p class="inscription">Si vous n'avez pas de compte, <a href="inscription.php">cliquez ici pour vous inscrire</a>.</p>
        </form>
    </section>
  </body>
</html>
