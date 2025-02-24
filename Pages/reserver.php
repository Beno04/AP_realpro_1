<!DOCTYPE html>
<html lang="fr">
    <head>
        <meta charset="UTF-8">
        <link rel="stylesheet" href="../Style/style.css">
        <title>MarieTeam</title>
    </head>
    <body>
        <!-- Barre de navigation -->
        <nav class="menu">
            <ul>
                <li class="titre-marieteam" ><a href="index.php"><b>MarieTeam</b></a></li>
                    <div class="nav-buttons">
                <li><a class="active" href="reserver.php">Réserver</a></li>
                <li><a href="index.php">À propos</a></li>
                <li><a href="connexion.php"><b class="connexion-btn">Connexion</b></a></li>
                </div>
            </ul>
        </nav>
        <?php
        $servername = "localhost"; 
        $username = "votre_utilisateur";
        $password = "votre_mot_de_passe";
        $dbname = "votre_base_de_donnees";

        $pdo = connexionBase($servername, $username, $password, $dbname);

        // Vérifie si la connexion est réussie avant d'exécuter la requête
        if ($pdo) {
            $secteurs = getSecteurs($pdo);
        } else {
            $secteurs = []; // En cas d'erreur, on retourne une liste vide
        }
        ?>
        <div class="blockR">
            <div class="destination">
                <ul>
                    <?php foreach ($secteurs as $secteur): ?>
                        <li><?php echo htmlspecialchars($secteur['nom_secteur']); ?></li>
                    <?php endforeach; ?>
                </ul>
            </div>
            <div class="tableauReservation">
                <?php
                $traversees = $pdo ? getDescTraversées($pdo, $secteur) : [];
                ?>

                <!-- Liste déroulante -->
                <label for="traversees">Choisissez une traversée :</label>
                <select id="traversees" name="traversees">
                    <?php if (!empty($traversees)): ?>
                        <?php foreach ($traversees as $traversee): ?>
                            <option value="<?php echo htmlspecialchars($traversee['desc_travers']); ?>">
                                <?php echo htmlspecialchars($traversee['desc_travers']); ?>
                            </option>
                        <?php endforeach; ?>
                    <?php else: ?>
                        <option value="">Aucune traversée disponible</option>
                    <?php endif; ?>
                </select>
                <table>
                    <tr>
                    </tr>
                </table>
            </div>










        </div>
    </body>
</html>