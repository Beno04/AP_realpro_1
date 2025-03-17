function selectionnerSecteur(nomSecteur) {
    // Réinitialiser la liste des traversées et des dates
    let selectTraversee = document.querySelector('select[name="traversee"]');
    selectTraversee.innerHTML = '<option value="">Sélectionner une traversée</option>';
    
    let selectDate = document.getElementById('date_traversee');
    selectDate.innerHTML = '<option value="">Sélectionner une date</option>';

    // Envoi de la requête AJAX
    fetch('get_traversees.php?nom_secteur=' + encodeURIComponent(nomSecteur))
        .then(response => response.json())
        .then(data => {
            // Ajouter les nouvelles options
            data.forEach(desc => {
                let option = document.createElement('option');
                option.value = desc;
                option.textContent = desc;
                selectTraversee.appendChild(option);
            });
        })
        .catch(error => console.error('Erreur AJAX:', error));
}
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
    })
    .catch(error => console.error('Erreur AJAX:', error));
}
