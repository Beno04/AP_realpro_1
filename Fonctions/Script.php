<?php

// Récupere les secteurs qui ont des traverser après la date du jour
$sql = "SELECT nom_secteur 
FROM `secteur` 
INNER JOIN liaison ON liaison.id_secteur = secteur.id_secteur
INNER JOIN traversée ON traversée.id_travers = liaison.id_travers
WHERE traversée.date_travers > CURRENT_DATE
GROUP BY secteur.nom_secteur"



$sql = ""

