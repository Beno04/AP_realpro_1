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
            <select name="traversee">
                <option value="">Sélectionner une traversée</option>
                <?php foreach ($descriptions as $desc) : ?>
                    <option value="<?= htmlspecialchars($desc) ?>"><?= htmlspecialchars($desc) ?></option>
                <?php endforeach; ?>
            </select>
        </div>
    </div>

    <script>
    function selectionnerSecteur(nomSecteur) {
        // Envoi de la requête AJAX
        fetch('get_traversees.php?nom_secteur=' + encodeURIComponent(nomSecteur))
            .then(response => response.json())
            .then(data => {
                // Récupérer la liste déroulante
                let select = document.querySelector('select[name="traversee"]');
                select.innerHTML = '<option value="">Sélectionner une traversée</option>';
                
                // Ajouter les nouvelles options
                data.forEach(desc => {
                    let option = document.createElement('option');
                    option.value = desc;
                    option.textContent = desc;
                    select.appendChild(option);
                });
            })
            .catch(error => console.error('Erreur AJAX:', error));
    }
    </script>

</body>
</html>
