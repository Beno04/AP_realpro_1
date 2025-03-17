<?php
include '../Fonctions/Script.php';

$secteurs = getSecteurs();
$id_secteur = 2; // Exemple, remplace par la vraie valeur
$descriptions = getDescTraversées($id_secteur);
?>

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

<!-- Liste déroulante pour la traversée -->
<select name="traversee" id="traversee" onchange="selectionnerTraversee(this.value)">
    <option value="">Sélectionner une traversée</option>
</select>

<!-- Liste déroulante pour la date -->
<select name="date_traversee" id="date_traversee" onchange="selectionnerDate()">
    <option value="">Sélectionner une date</option>
</select>

<!-- Tableau pour afficher les informations de la traversée -->
<table id="infoTable" border="1" style="width: 100%; margin-top: 20px;">
    <thead>
        <tr>
            <th>ID Traversée</th>
            <th>Heure Traversée</th>
            <th>Nom Bateau</th>
            <th>Passager</th>
            <th>Véhicule Inf2m</th>
            <th>Véhicule Sup2m</th>
            <th>Sélection</th>
        </tr>
    </thead>
    <tbody>
        <!-- Les données du tableau seront insérées ici -->
    </tbody>
</table>

<!-- Formulaire caché pour soumettre la traversée sélectionnée -->
<form id="selectionForm" action="nouvelle_page.php" method="POST">
    <input type="hidden" name="travers_id" id="travers_id">
    <input type="hidden" name="travers_desc" id="travers_desc">
    <input type="hidden" name="travers_date" id="travers_date">
    <input type="hidden" name="travers_heure" id="travers_heure">
    <button type="button" onclick="submitForm()">Sélectionner cette traversée</button>
</form>

<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script src="../JavaScript/Ajax.js"></script>
