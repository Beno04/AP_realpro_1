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
        </tr>
    </thead>
    <tbody>
        <!-- Les données du tableau seront insérées ici -->
    </tbody>
</table>

<script>
// Fonction pour récupérer les informations et afficher le tableau
function afficherInfo(descTravers, dateTravers) {
    fetch('get_info.php?desc_travers=' + encodeURIComponent(descTravers) + '&date_travers=' + encodeURIComponent(dateTravers))
        .then(response => response.json())
        .then(data => {
            let tableBody = document.getElementById('infoTable').getElementsByTagName('tbody')[0];
            tableBody.innerHTML = ''; // Effacer le contenu précédent

            data.forEach(row => {
                let tr = document.createElement('tr');
                
                let tdId = document.createElement('td');
                tdId.textContent = row.id_travers;
                tr.appendChild(tdId);
                
                let tdHeure = document.createElement('td');
                tdHeure.textContent = row.heure_travers;
                tr.appendChild(tdHeure);
                
                let tdNomBateau = document.createElement('td');
                tdNomBateau.textContent = row.nom_bateau;
                tr.appendChild(tdNomBateau);
                
                let tdPassager = document.createElement('td');
                tdPassager.textContent = row.Passager;
                tr.appendChild(tdPassager);
                
                let tdVehiculeInf2m = document.createElement('td');
                tdVehiculeInf2m.textContent = row['véhicule inf2m'];
                tr.appendChild(tdVehiculeInf2m);
                
                let tdVehiculeSup2m = document.createElement('td');
                tdVehiculeSup2m.textContent = row['véhicule sup2m'];
                tr.appendChild(tdVehiculeSup2m);

                tableBody.appendChild(tr);
            });
        })
        .catch(error => console.error('Erreur AJAX:', error));
}
</script>


<script>
// Fonction pour récupérer les traversées selon le secteur sélectionné
function selectionnerSecteur(nomSecteur) {
    fetch('get_traversees.php?nom_secteur=' + encodeURIComponent(nomSecteur))
        .then(response => response.json())
        .then(data => {
            let select = document.getElementById('traversee');
            select.innerHTML = '<option value="">Sélectionner une traversée</option>';

            data.forEach(desc => {
                let option = document.createElement('option');
                option.value = desc;
                option.textContent = desc;
                select.appendChild(option);
            });

            // On vide la liste des dates si le secteur change
            document.getElementById('date_traversee').innerHTML = '<option value="">Sélectionner une date</option>';
        })
        .catch(error => console.error('Erreur AJAX:', error));
}

// Fonction pour récupérer les dates selon la traversée sélectionnée
function selectionnerTraversee(descTravers) {
    if (!descTravers) {
        document.getElementById('date_traversee').innerHTML = '<option value="">Sélectionner une date</option>';
        return;
    }

    fetch('get_dates.php?desc_travers=' + encodeURIComponent(descTravers))
        .then(response => response.json())
        .then(data => {
            let select = document.getElementById('date_traversee');
            select.innerHTML = '<option value="">Sélectionner une date</option>';

            data.forEach(date => {
                let option = document.createElement('option');
                option.value = date;
                option.textContent = date;
                select.appendChild(option);
            });

            // Afficher les informations de la traversée pour la première date disponible
            if (data.length > 0) {
                afficherInfo(descTravers, data[0]);  // Appel de la fonction pour afficher les infos dans le tableau
            }
        })
        .catch(error => console.error('Erreur AJAX:', error));
}
function selectionnerDate() {
    const descTravers = document.getElementById('traversee').value;
    const dateTravers = document.getElementById('date_traversee').value;

    if (!descTravers || !dateTravers) {
        return;  // Si l'une des valeurs n'est pas définie, on ne fait rien
    }

    afficherInfo(descTravers, dateTravers);
}

</script>


