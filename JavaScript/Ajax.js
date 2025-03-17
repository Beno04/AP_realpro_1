$(document).ready(function () {
    function afficherInfo(nomSecteur = '', descTravers = '', dateTravers = '') {
        let url = 'get_info.php';
        
        if (!nomSecteur) {
            url += '?all=true';
        } else if (!descTravers) {
            url += `?nom_secteur=${encodeURIComponent(nomSecteur)}`;
        } else if (!dateTravers) {
            url += `?nom_secteur=${encodeURIComponent(nomSecteur)}&desc_travers=${encodeURIComponent(descTravers)}`;
        } else {
            url += `?nom_secteur=${encodeURIComponent(nomSecteur)}&desc_travers=${encodeURIComponent(descTravers)}&date_travers=${encodeURIComponent(dateTravers)}`;
        }

        $.getJSON(url, function (data) {
            let tableBody = $('#infoTable tbody');
            tableBody.empty();

            $.each(data, function (index, row) {
                let tr = $('<tr>').html(`
                    <td>${row.id_travers}</td>
                    <td>${row.heure_travers}</td>
                    <td>${row.nom_bateau}</td>
                    <td>${row.Passager}</td>
                    <td>${row['véhicule inf2m']}</td>
                    <td>${row['véhicule sup2m']}</td>
                    <td><input type="radio" name="selectedTravers" value="${row.id_travers}" data-desc="${descTravers}" data-date="${dateTravers}" data-heure="${row.heure_travers}" onclick="updateHiddenFields()"></td>
                `);
                tableBody.append(tr);
            });
        }).fail(function () {
            console.error('Erreur AJAX');
        });
    }

    function selectionnerSecteur(nomSecteur) {
        $.getJSON('get_traversees.php?nom_secteur=' + encodeURIComponent(nomSecteur), function (data) {
            let select = $('#traversee');
            select.html('<option value="">Sélectionner une traversée</option>');

            $.each(data, function (index, desc) {
                select.append($('<option>').val(desc).text(desc));
            });

            $('#date_traversee').html('<option value="">Sélectionner une date</option>');
            afficherInfo(nomSecteur);
        }).fail(function () {
            console.error('Erreur AJAX');
        });
    }

    function selectionnerTraversee(descTravers) {
        let nomSecteur = $('li button[disabled]').text() || '';
        
        if (!descTravers) {
            $('#date_traversee').html('<option value="">Sélectionner une date</option>');
            return;
        }

        $.getJSON('get_dates.php?desc_travers=' + encodeURIComponent(descTravers), function (data) {
            let select = $('#date_traversee');
            select.html('<option value="">Sélectionner une date</option>');
            
            $.each(data, function (index, date) {
                select.append($('<option>').val(date).text(date));
            });

            afficherInfo(nomSecteur, descTravers);
        }).fail(function () {
            console.error('Erreur AJAX');
        });
    }

    function selectionnerDate() {
        let nomSecteur = $('li button[disabled]').text() || '';
        let descTravers = $('#traversee').val();
        let dateTravers = $('#date_traversee').val();
        
        if (!descTravers || !dateTravers) {
            return;
        }

        afficherInfo(nomSecteur, descTravers, dateTravers);
    }

    function updateHiddenFields() {
        let selectedRadio = $('input[name="selectedTravers"]:checked');
        if (selectedRadio.length) {
            $('#travers_id').val(selectedRadio.val());
            $('#travers_desc').val(selectedRadio.data('desc'));
            $('#travers_date').val(selectedRadio.data('date'));
            $('#travers_heure').val(selectedRadio.data('heure'));
        }
    }

    function submitForm() {
        if ($('input[name="selectedTravers"]:checked').length) {
            $('#selectionForm').submit();
        } else {
            alert("Veuillez sélectionner une traversée.");
        }
    }

    // Initialisation
    afficherInfo();

    // Attachement des événements
    $('#traversee').change(function () {
        selectionnerTraversee($(this).val());
    });

    $('#date_traversee').change(selectionnerDate);

    $('li button').click(function () {
        $('li button').removeAttr('disabled');
        $(this).attr('disabled', 'disabled');
        selectionnerSecteur($(this).text());
    });
});
