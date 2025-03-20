let secteurSelectionne = null;

function selectionnerSecteur(nomSecteur) {
    secteurSelectionne = nomSecteur; // Enregistre le secteur sélectionné
    console.log("Secteur sélectionné :", secteurSelectionne); // Vérification

    // Réinitialisation des listes
    let selectTraversee = document.querySelector('select[name="traversee"]');
    selectTraversee.innerHTML = '<option value="">Sélectionner une traversée</option>';

    let selectDate = document.getElementById('date_traversee');
    selectDate.innerHTML = '<option value="">Sélectionner une date</option>';

    // Mise à jour des traversées
    fetch('get_traversees.php?nom_secteur=' + encodeURIComponent(nomSecteur))
        .then(response => response.json())
        .then(data => {
            data.forEach(desc => {
                let option = document.createElement('option');
                option.value = desc;
                option.textContent = desc;
                selectTraversee.appendChild(option);
            });
        })
        .catch(error => console.error('Erreur AJAX (traversées) :', error));

    // Mise à jour de la table avec les traversées
    fetch('get_infos.php?nom_secteur=' + encodeURIComponent(nomSecteur))
        .then(response => response.json())
        .then(data => {
            let tbody = document.querySelector('tbody');
            tbody.innerHTML = ""; // Nettoie l'ancienne table

            if (data.length === 0) {
                tbody.innerHTML = "<tr><td colspan='7'>Aucune traversée disponible</td></tr>";
                return;
            }

            data.forEach(info => {
                let row = `<tr>
                    <td>${info.id_travers}</td>
                    <td>${info.heure_travers}</td>
                    <td>${info.nom_bateau}</td>
                    <td>${info.Passager}</td>
                    <td>${info["véhicule inf2m"]}</td>
                    <td>${info["véhicule sup2m"]}</td>
                    <td><input type="radio" name="id_travers" value="${info.id_travers}"></td>
                </tr>`;
                tbody.innerHTML += row;
            });
        })
        .catch(error => console.error('Erreur AJAX (infos) :', error));
}





function selectionnerTraversee(descTravers) {
    if (!descTravers) {
        document.getElementById('date_traversee').innerHTML = '<option value="">Sélectionner une date</option>';
        return;
    }

    // Vérifier si un secteur est bien sélectionné
    if (!secteurSelectionne) {
        console.error("Erreur : Aucun secteur sélectionné !");
        return;
    }

    // Mise à jour de la liste des dates
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
        })
        .catch(error => console.error('Erreur AJAX (dates) :', error));

    // Mettre à jour la table avec les infos
    fetch('get_infos.php?nom_secteur=' + encodeURIComponent(secteurSelectionne) + '&desc_travers=' + encodeURIComponent(descTravers))
        .then(response => response.json())
        .then(data => {
            let tbody = document.querySelector('tbody');
            tbody.innerHTML = ""; // Nettoie l'ancienne table

            if (data.length === 0) {
                tbody.innerHTML = "<tr><td colspan='7'>Aucune traversée disponible</td></tr>";
                return;
            }

            data.forEach(info => {
                let row = `<tr>
                    <td>${info.id_travers}</td>
                    <td>${info.heure_travers}</td>
                    <td>${info.nom_bateau}</td>
                    <td>${info.Passager}</td>
                    <td>${info["véhicule inf2m"]}</td>
                    <td>${info["véhicule sup2m"]}</td>
                    <td><input type="radio" name="id_travers" value="${info.id_travers}"></td>
                </tr>`;
                tbody.innerHTML += row;
            });
        })
        .catch(error => console.error('Erreur AJAX (infos) :', error));
}
