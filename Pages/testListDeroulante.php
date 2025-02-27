
<?php
include '../Fonctions/Script.php';

$secteurs = getSecteurs();
$id_secteur = 2; // Exemple, remplace par la vraie valeur
$descriptions = getDescTraversées($id_secteur);
var_dump($descriptions);
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

<select name="traversee">
    <option value="">Sélectionner un traversée</option>
    <?php foreach ($descriptions as $desc) : ?>
        <option value="<?= htmlspecialchars($desc) ?>"><?= htmlspecialchars($desc) ?></option>
    <?php endforeach; ?>
</select>
<select name="traversee" onchange="selectionnerTraversee(this.value)">
    <option value="">Sélectionner une traversée</option>
    <?php foreach ($descriptions as $desc) : ?>
        <option value="<?= htmlspecialchars($desc) ?>"><?= htmlspecialchars($desc) ?></option>
    <?php endforeach; ?>
</select>

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
<script>
function selectionnerTraversée(descTravers) {
    if (!descTravers) {
        // Si aucune traversée n'est sélectionnée, vider la liste des dates
        document.querySelector('select[name="date_traversee"]').innerHTML = '<option value="">Sélectionner une date</option>';
        return;
    }

    fetch('get_dates.php?desc_travers=' + encodeURIComponent(descTravers))
        .then(response => response.json())
        .then(data => {
            let select = document.querySelector('select[name="date_traversee"]');
            select.innerHTML = '<option value="">Sélectionner une date</option>';

            data.forEach(date => {
                let option = document.createElement('option');
                option.value = date;
                option.textContent = date;
                select.appendChild(option);
            });
        })
        .catch(error => console.error('Erreur AJAX:', error));
}
</script>

