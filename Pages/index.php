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
          <?php if (isset($typerUser) && $typerUser === 'Gestionnaire'): ?>
          <li class="titre-marieteam"><a href="accueilAdmin.php"><b>MarieTeam</b></a></li>
          <?php else: ?>
              <li class="titre-marieteam"><a href="index.php"><b>MarieTeam</b></a></li>
          <?php endif; ?>
        <div class="nav-buttons">

        <?php if (isset($prenom) && isset($nom)): ?>
            <li><a href="reserver.php">Réserver</a></li>
          <?php else: ?>
            <li><a href="connexion.php">Réserver</a></li>
          <?php endif; ?>
          <li><a class="active" href="index.php">À propos</a></li>

          <?php if (isset($prenom) && isset($nom)): ?>
            <li><a href="profile.php"><b class="connexion-btn"><?php echo $prenom . ' ' . $nom; ?></b></a></li>
          <?php else: ?>
            <li><a href="connexion.php"><b class="connexion-btn">Connexion</b></a></li>
          <?php endif; ?>
        </div>
      </ul>
    </nav>

    <!-- Section principale de bienvenue -->
    <br><br><br><br>
    <section class="intro">
      <h1>Bienvenue chez <span class="titre1">MarieTeam</span></h1>
      <h2>Votre Transport Maritime de Confiance</h2>
      <p>
        MarieTeam est le leader du transport maritime sur le littoral français, 
        offrant des liaisons vers des destinations magnifiques telles que Belle-Île-en-Mer, Ouessant, et l’île de Groix. 
        Grâce à notre engagement envers la qualité et le service, 
        nous vous garantissons une expérience de voyage fluide et agréable.
      </p>
    </section>

    <!-- Ligne de séparation -->
    <hr class="separator" />

<!-- Section de réservation -->
<section class="reservation">
  <h1>Réservation en Ligne <span class="titre2">Simplifiée</span></h1>
  <p>
    Notre interface de réservation en ligne vous permet de planifier vos traversées en toute simplicité. 
    Consultez les horaires, découvrez nos tarifs et réservez votre place en quelques clics. 
    Nous mettons à jour en temps réel le nombre de places disponibles pour vous éviter tout désagrément.
  </p>
  <button class="btn-reserver" id="reservationBtn">Réserver</button>
</section>

<script>
// Ajouter un gestionnaire d'événements au bouton
document.getElementById('reservationBtn').addEventListener('click', function() {
  <?php if (isset($prenom) && isset($nom)): ?>
    window.location.href = 'reserver.php'; // Redirige vers la page de réservation si connecté
  <?php else: ?>
    window.location.href = 'connexion.php'; // Redirige vers la page de connexion si non connecté
  <?php endif; ?>
});
</script>

  </body>
</html>
