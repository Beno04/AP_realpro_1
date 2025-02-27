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
        <li class="titre-marieteam"><a href="index.php"><b>MarieTeam</b></a></li>
        <div class="nav-buttons">

        <?php if (isset($prenom) && isset($nom)): ?>
            <li><a href="reserver.php">Réserver</a></li>
          <?php else: ?>
            <li><a href="connexion.php">Réserver</a></li>
          <?php endif; ?>

          <li><a class="active" href="index.php">À propos</a></li>

          <?php if (isset($prenom) && isset($nom)): ?>
            <li><a href="profile.php"><b class="connexion-btn"><?php echo $nom . ' ' . $prenom; ?></b></a></li>
          <?php else: ?>
            <li><a href="connexion.php"><b class="connexion-btn">Connexion</b></a></li>
          <?php endif; ?>
        </div>
      </ul>
    </nav>

    <?php
        session_start();
        include '../Fonctions/Script.php';

        // Récupérer tous les secteurs
        $secteurs = getSecteurs();
    ?>

    <div class="blockR">
        <div class="destination">
            <ul>
                <?php foreach ($secteurs as $secteurItem): ?>
                    <li>
                        <?php echo htmlspecialchars($secteurItem['nom_secteur']); ?>
                        <button type="button" onclick="selectionnerSecteur('<?php echo htmlspecialchars($secteurItem['nom_secteur']); ?>')">
                            Sélectionner
                        </button>
                    </li>
                <?php endforeach; ?>
            </ul>
        </div>

        <div class="tableauReservation">
            <p id="secteur-selectionne">Aucun secteur sélectionné.</p>

            <!-- Liste déroulante -->
            <label for="traversees">Choisissez une traversée :</label>
            <select id="traversees" name="traversees">
                <option value="">Sélectionnez un secteur d'abord</option>
            </select>
        </div>
    </div>

    <script>
        function selectionnerSecteur(nomSecteur) {
            // Envoyer la requête AJAX
            fetch('get_traversees.php', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: 'nom_secteur=' + encodeURIComponent(nomSecteur)
            })
            .then(response => response.json()) // Récupérer la réponse JSON
            .then(data => {
                // Mettre à jour l'affichage du secteur sélectionné
                document.getElementById("secteur-selectionne").innerHTML = "Secteur sélectionné : " + nomSecteur;

                // Mettre à jour la liste déroulante
                let select = document.getElementById("traversees");
                select.innerHTML = ""; // Vider les anciennes options

                if (data.length > 0) {
                    data.forEach(traversee => {
                        let option = document.createElement("option");
                        option.value = traversee.desc_travers;
                        option.textContent = traversee.desc_travers;
                        select.appendChild(option);
                    });
                } else {
                    let option = document.createElement("option");
                    option.value = "";
                    option.textContent = "Aucune traversée disponible";
                    select.appendChild(option);
                }
            });
        }
    </script>

</body>
</html>
