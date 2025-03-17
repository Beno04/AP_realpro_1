<?php
        include '../Fonctions/Script.php';

        // Récupérer tous les secteurs
        $id_secteur = 2; // À remplacer par la vraie valeur
        $descriptions = getDescTraversées($id_secteur);
        $secteurs = getSecteurs();
    ?>

    <div class="blockR">
        <div class="destination">
            <ul>
            <?php foreach ($secteurs as $secteurItem): ?>
                    <?php echo htmlspecialchars($secteurItem['nom_secteur']); ?>
                    <button type="button" onclick="selectionnerSecteur('<?php echo htmlspecialchars($secteurItem['nom_secteur']); ?>')">
                        Sélectionner
                    </button>
            <?php endforeach; ?>
            </ul>
        </div>

        <div class="tableauReservation">
            <select name="traversee" onchange="selectionnerTraversee(this.value)">
                <option value="">Sélectionner une traversée</option>
                <?php foreach ($descriptions as $desc) : ?>
                    <option value="<?= htmlspecialchars($desc) ?>"><?= htmlspecialchars($desc) ?></option>
                <?php endforeach; ?>
            </select>
            <select name="date_traversee" id="date_traversee">
                <option value="">Sélectionner une date</option>
            </select>
        </div>
    </div>

    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid black;
            padding: 8px;
            text-align: center;
        }
        th {
            background-color: #f2f2f2;
        }
    </style>
    <table>
        <thead>
            <tr>
                <th colspan="3">Traversée</th>
                <th colspan="3">Places disponibles</th>
                <th>Sélectionner</th>
            </tr>
            <tr>
                <th>N°</th>
                <th>Heure</th>
                <th>Bateau</th>
                <th>Passager</th>
                <th>Véhicule Inf 2m</th>
                <th>Véhicule Sup 2m</th>
                <th></th>
            </tr>
        </thead>
        <tbody>
        </tbody>
    </table>

    
    <script src="../JavaScript/ScriptRéserver.js"></script>