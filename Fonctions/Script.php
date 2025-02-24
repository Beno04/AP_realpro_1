<?php

// Récupere les secteurs qui ont des traversers après la date du jour
$sql = "SELECT nom_secteur 
FROM `secteur` 
INNER JOIN liaison ON liaison.id_secteur = secteur.id_secteur
INNER JOIN traversée ON traversée.id_travers = liaison.id_travers
WHERE traversée.date_travers > CURRENT_DATE
GROUP BY secteur.nom_secteur"


//Récupere les descriptions des traversers après la date du jour par rapport au secteurs choisis
$sql = "SELECT  traversée.desc_travers
FROM `liaison` 
INNER JOIN traversée ON liaison.id_travers = traversée.id_travers
WHERE id_secteur = 1 AND traversée.date_travers > CURRENT_DATE
GROUP BY traversée.desc_travers"


//Récupere les dates des traversers après la date du jour par rapport a la description des traversers choisis
$sql = "SELECT  traversée.date_travers
FROM `liaison` 
INNER JOIN traversée ON liaison.id_travers = traversée.id_travers
WHERE traversée.desc_travers = 'Quiberon-Le Palais' AND traversée.date_travers > CURRENT_DATE
GROUP BY traversée.date_travers"


$sql = "SELECT id_travers, heure_travers, bateau.nom_bateau , contenir.capac_bateau_pass - COUNT()
FROM `traversée`
INNER JOIN bateau ON traversée.id_bateau = bateau.id_bateau
WHERE heure_travers = '07:45:00'"