document.addEventListener("DOMContentLoaded", function () {

    // Récupération des valeurs depuis le HTML
    const dataElement = document.getElementById("reservation-data");
    const maxP = parseInt(dataElement.dataset.maxp, 10) || 0;
    const maxVi = parseInt(dataElement.dataset.maxvi, 10) || 0;
    const maxVs = parseInt(dataElement.dataset.maxvs, 10) || 0;

    console.log("Valeurs max récupérées:", { maxP, maxVi, maxVs });

    const categories = {
        passagers: {
            max: maxP,
            inputs: document.querySelectorAll("._reservation-table tbody tr:nth-child(-n+3) input"),
        },
        vehiculesInf2m: {
            max: maxVi,
            inputs: document.querySelectorAll("._reservation-table tbody tr:nth-child(4) input, ._reservation-table tbody tr:nth-child(5) input"),
        },
        vehiculesSup2m: {
            max: maxVs,
            inputs: document.querySelectorAll("._reservation-table tbody tr:nth-child(n+6) input"),
        }
    };

    console.log("Catégories détectées :", categories);

    function updateLimits(category) {
        let total = 0;

        category.inputs.forEach(input => {
            let value = input.value.trim();
            total += value ? parseInt(value, 10) : 0;
        });

        console.log(`Total utilisé pour la catégorie : ${total} / ${category.max}`);

        category.inputs.forEach(input => {
            let currentValue = input.value.trim() ? parseInt(input.value, 10) : 0;
            input.max = category.max - total + currentValue;
            console.log(`Nouvelle limite pour input : ${input.max}`);
        });
    }

    // Fonction pour valider l'entrée utilisateur et éviter les valeurs hors limites
    function validateInput(input, category) {
        let value = input.value.trim() ? parseInt(input.value, 10) : 0;

        if (isNaN(value) || value < 0) {
            input.value = 0;
        } else if (value > parseInt(input.max, 10)) {
            input.value = input.max;
        }

        updateLimits(category);
    }

    // Ajout des écouteurs d'événements sur les inputs
    Object.values(categories).forEach(category => {
        category.inputs.forEach(input => {
            console.log("Ajout d'un event listener sur un input");

            let oldValue = input.value.trim() ? parseInt(input.value, 10) : 0;

            function handleInputChange() {
                validateInput(input, category);
            }

            // On écoute les événements clavier, clics et pertes de focus
            input.addEventListener("input", handleInputChange);
            input.addEventListener("change", handleInputChange);
            input.addEventListener("blur", handleInputChange);
        });
    });
});
document.getElementById("_reservation-form").addEventListener("submit", function () {
    document.getElementById('desc_travers_field').value = selectTraversee.value || "";
    document.getElementById('date_travers_field').value = selectDate.value || "";
});