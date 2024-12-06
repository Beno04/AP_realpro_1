<html lang="fr">
<head>
    <link rel="stylesheet" type="text/css" href="../Style/style.css" />
    <meta charset="utf-8" />
    <title>MarieTeam - Inscription</title>
    <script src="../JavaScript/validInscription.js" defer></script> <!-- Inclure le fichier JavaScript -->
</head>
<body>
    <?php
    include '../Fonctions/script.php'; // Inclure le fichier PHP
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

    <!-- Section principale d'inscription -->
    <br><br><br><br>
    <section class="connexion">
        <h1>Créer votre <span class="titre1">Compte</span></h1>
        <br><br>
        <form action="inscription.php" method="POST" id="leForm"> <!-- Action vers le même fichier pour traitement -->
            <div class="form-group">
                <label for="nom">Nom :</label>
                <input type="text" id="nom" name="nom" required />
                <div id="errorNom"></div> <!-- Zone d'erreur pour le nom -->
            </div>
            <div class="form-group">
                <label for="prenom">Prénom :</label>
                <input type="text" id="prenom" name="prenom" required />
                <div id="errorPrenom"></div> <!-- Zone d'erreur pour le prénom -->
            </div>
            <div class="form-group">
                <label for="email">Adresse mail :</label>
                <input type="email" id="email" name="email" required />
                <div id="errorEmailExist" class="error"></div>
                <div id="errorEmailInvalid" class="error"></div> <!-- Zones d'erreur pour email -->
            </div>
            <div class="form-group">
                <label for="password">Mot de passe :</label>
                <input type="password" id="password" name="password" required />
                <div id="errorPwd"></div> <!-- Zone d'erreur pour le mot de passe -->
            </div>
            <button type="submit" class="btn-connexion">Inscription</button>
            <div id="erreurInscription"></div> <!-- Zone d'erreur pour l'inscription -->
            <div id="messageInscription"></div> <!-- Zone de message de succès -->
        </form>
    </section>
</body>
</html>
