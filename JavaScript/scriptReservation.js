document.addEventListener("DOMContentLoaded", function () {
    alert("Script JS chargé !");

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
            total += parseInt(input.value) || 0;
        });

        console.log(`Total utilisé pour la catégorie : ${total} / ${category.max}`);

        category.inputs.forEach(input => {
            input.max = Math.max(0, category.max - total + (parseInt(input.value) || 0));
            console.log(`Nouvelle limite pour input : ${input.max}`);
        });
    }

    Object.values(categories).forEach(category => {
        category.inputs.forEach(input => {
            console.log("Ajout d'un event listener sur un input");
            input.addEventListener("input", () => {
                console.log(`Valeur modifiée : ${input.value}`);
                updateLimits(category);
            });
        });
    });
});
