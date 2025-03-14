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

<script>
// Fonction pour récupérer les informations en fonction des choix
function afficherInfo(nomSecteur = '', descTravers = '', dateTravers = '') {
    let url = 'get_info.php';
    
    if (!nomSecteur) {
        url += '?all=true'; // Charge toutes les traversées
    } else if (!descTravers) {
        url += `?nom_secteur=${encodeURIComponent(nomSecteur)}`;
    } else if (!dateTravers) {
        url += `?nom_secteur=${encodeURIComponent(nomSecteur)}&desc_travers=${encodeURIComponent(descTravers)}`;
    } else {
        url += `?nom_secteur=${encodeURIComponent(nomSecteur)}&desc_travers=${encodeURIComponent(descTravers)}&date_travers=${encodeURIComponent(dateTravers)}`;
    }

    fetch(url)
        .then(response => response.json())
        .then(data => {
            let tableBody = document.getElementById('infoTable').getElementsByTagName('tbody')[0];
            tableBody.innerHTML = ''; // Effacer le contenu précédent

            data.forEach(row => {
                let tr = document.createElement('tr');
                tr.innerHTML = `
                    <td>${row.id_travers}</td>
                    <td>${row.heure_travers}</td>
                    <td>${row.nom_bateau}</td>
                    <td>${row.Passager}</td>
                    <td>${row['véhicule inf2m']}</td>
                    <td>${row['véhicule sup2m']}</td>
                    <td><input type="radio" name="selectedTravers" value="${row.id_travers}" data-desc="${descTravers}" data-date="${dateTravers}" data-heure="${row.heure_travers}" onclick="updateHiddenFields()"></td>
                `;
                tableBody.appendChild(tr);
            });
        })
        .catch(error => console.error('Erreur AJAX:', error));
}

// Fonction pour sélectionner un secteur
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
            
            document.getElementById('date_traversee').innerHTML = '<option value="">Sélectionner une date</option>';
            afficherInfo(nomSecteur); // Affiche les traversées du secteur sélectionné
        })
        .catch(error => console.error('Erreur AJAX:', error));
}

// Fonction pour sélectionner une traversée
function selectionnerTraversee(descTravers) {
    const nomSecteur = document.querySelector('li button[disabled]')?.textContent || '';
    
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
            
            afficherInfo(nomSecteur, descTravers); // Affiche les traversées selon le secteur et la traversée
        })
        .catch(error => console.error('Erreur AJAX:', error));
}

// Fonction pour sélectionner une date
function selectionnerDate() {
    const nomSecteur = document.querySelector('li button[disabled]')?.textContent || '';
    const descTravers = document.getElementById('traversee').value;
    const dateTravers = document.getElementById('date_traversee').value;
    
    if (!descTravers || !dateTravers) {
        return;
    }
    
    afficherInfo(nomSecteur, descTravers, dateTravers);
}

// Fonction pour mettre à jour les champs cachés avant soumission
function updateHiddenFields() {
    let selectedRadio = document.querySelector('input[name="selectedTravers"]:checked');
    if (selectedRadio) {
        document.getElementById('travers_id').value = selectedRadio.value;
        document.getElementById('travers_desc').value = selectedRadio.getAttribute('data-desc');
        document.getElementById('travers_date').value = selectedRadio.getAttribute('data-date');
        document.getElementById('travers_heure').value = selectedRadio.getAttribute('data-heure');
    }
}

// Fonction pour soumettre le formulaire
function submitForm() {
    let selectedRadio = document.querySelector('input[name="selectedTravers"]:checked');

    if (selectedRadio) {
        document.getElementById('selectionForm').submit();
    } else {
        alert("Veuillez sélectionner une traversée.");
    }
}

// Chargement initial : afficher toutes les traversées
window.onload = function () {
    afficherInfo();
};
</script>

