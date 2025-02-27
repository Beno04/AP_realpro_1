<?php

function connexionBase($servername, $username, $password, $dbname) {
    try {
        return new PDO("mysql:host=$servername;dbname=$dbname", $username, $password, [
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
        ]);
    } catch (PDOException $e) {
        echo "Erreur de connexion : " . $e->getMessage();
        return null;
    }
}



// Fonction pour récupérer les secteurs
function getSecteurs() {
    $servername = "127.0.0.1";
    $username = "root";
    $password = "";
    $dbname = "marieteam";
    $sql = "SELECT nom_secteur 
            FROM secteur 
            INNER JOIN liaison ON liaison.id_secteur = secteur.id_secteur
            INNER JOIN traversée ON traversée.id_travers = liaison.id_travers
            WHERE traversée.date_travers > CURRENT_DATE
            GROUP BY secteur.nom_secteur";
    
    $pdo = connexionBase($servername, $username, $password, $dbname);

    $stmt = $pdo->prepare($sql);
    $stmt->execute();

    return $stmt->fetchAll();
}

function getIdSecteurs($nom_secteur) {
    $servername = "127.0.0.1";
    $username = "root";
    $password = "";
    $dbname = "marieteam";
    $sql = "SELECT id_secteur 
            FROM secteur
            WHERE nom_secteur=:nom_secteur";
    
    $pdo = connexionBase($servername, $username, $password, $dbname);

    $stmt = $pdo->prepare($sql);
    $stmt->bindParam(':nom_secteur', $nom_secteur, PDO::PARAM_STR);
    $stmt->execute();

    return $stmt->fetchAll();
}


// Fonction pour récupérer les descriptions des traversées
function getDescTraversées($nom_secteur) {
    $servername = "127.0.0.1";
    $username = "root";
    $password = "";
    $dbname = "marieteam";

    $pdo = connexionBase($servername, $username, $password, $dbname);

    $sql = "SELECT DISTINCT traversée.desc_travers
            FROM liaison
            INNER JOIN traversée ON liaison.id_travers = traversée.id_travers
            INNER JOIN secteur ON liaison.id_secteur = secteur.id_secteur
            WHERE secteur.nom_secteur = :nom_secteur 
            AND traversée.date_travers > CURRENT_DATE
            AND traversée.desc_travers IS NOT NULL";

    $stmt = $pdo->prepare($sql);
    $stmt->bindParam(':nom_secteur', $nom_secteur, PDO::PARAM_STR);
    $stmt->execute();

    return $stmt->fetchAll(PDO::FETCH_COLUMN);
}

function GetDateTravers($desc_travers) {
    $servername = "localhost"; 
    $username = "root";
    $password = "";
    $dbname = "marieteam";

    $pdo = connexionBase($servername, $username, $password, $dbname);

    $sql = "SELECT DISTINCT traversée.date_travers
            FROM liaison
            INNER JOIN traversée ON liaison.id_travers = traversée.id_travers
            WHERE traversée.desc_travers = :desc_travers
            AND traversée.date_travers > CURRENT_DATE";

    $stmt = $pdo->prepare($sql);
    $stmt->bindParam(':desc_travers', $desc_travers, PDO::PARAM_STR);
    $stmt->execute();

    return $stmt->fetchAll(PDO::FETCH_COLUMN);
}


// Récupere les secteurs qui ont des traversers après la date du jour
$sql = "SELECT nom_secteur 
FROM secteur
INNER JOIN liaison ON liaison.id_secteur = secteur.id_secteur
INNER JOIN traversée ON traversée.id_travers = liaison.id_travers
WHERE traversée.date_travers > CURRENT_DATE
GROUP BY secteur.nom_secteur";


//Récupere les descriptions des traversers après la date du jour par rapport au secteurs choisis
$sql = "SELECT  traversée.desc_travers
FROM liaison
INNER JOIN traversée ON liaison.id_travers = traversée.id_travers
WHERE id_secteur = 1 AND traversée.date_travers > CURRENT_DATE
GROUP BY traversée.desc_travers";


//Récupere les dates des traversers après la date du jour par rapport a la description des traversers choisis
$sql = "SELECT  traversée.date_travers
FROM liaison
INNER JOIN traversée ON liaison.id_travers = traversée.id_travers
WHERE traversée.desc_travers = 'Quiberon-Le Palais' AND traversée.date_travers > CURRENT_DATE
GROUP BY traversée.date_travers";


$sql = "SELECT id_travers, heure_travers, bateau.nom_bateau , contenir.capac_bateau_pass - COUNT()
FROM traversée
INNER JOIN bateau ON traversée.id_bateau = bateau.id_bateau
WHERE heure_travers = '07:45:00'";

$sql = "SELECT COUNT(quantité)
FROM enregistrer
INNER JOIN reservation ON enregistrer.id_resa = reservation.id_resa
INNER JOIN traversée ON reservation.id_travers = traversée.id_travers
WHERE traversée.date_travers =";

?>