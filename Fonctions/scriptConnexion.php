<?php
session_start(); // Démarrer la session

// Fonction pour se connecter à la base de données
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

// Fonction pour valider l'adresse e-mail
function validEmail($email) {
    if (trim(htmlspecialchars($email)) == "") {
        return "Une adresse e-mail est requise.";
    } elseif (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        return "L'adresse e-mail n'est pas valide.";
    }
    return true;
}

// Fonction pour valider le mot de passe
function validPwd($password) {
    if (trim(htmlspecialchars($password)) == "") {
        return "Un mot de passe est requis.";
    }
    return true;
}

// Fonction pour vérifier les identifiants dans la base de données
function verifyCredentials($connexion, $email, $password) {
    $query = $connexion->prepare("SELECT mdp_user FROM Utilisateur WHERE mail_user = :email");
    $query->bindValue(':email', $email, PDO::PARAM_STR);
    $query->execute();
    $result = $query->fetch();

    if ($result) {
        // Vérifier si le mot de passe correspond (haché)
        if (password_verify($password, $result['mdp_user'])) {
            return true;
        }
    }
    return false;
}

// Récupération des erreurs
$errorMessages = [];

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $servername = "127.0.0.1";
    $username = "marieteam";
    $password = "marieteam";
    $dbname = "marieteam";

    // Connexion à la base de données
    $connexion = connexionBase($servername, $username, $password, $dbname);

    if ($connexion) {
        $email = $_POST["email"] ?? "";
        $password = $_POST["password"] ?? "";

        // Validation des champs
        $validEmail = validEmail($email);
        $validPwd = validPwd($password);

        if ($validEmail !== true) {
            $errorMessages['email'] = $validEmail;
        }

        if ($validPwd !== true) {
            $errorMessages['password'] = $validPwd;
        }

        // Si aucune erreur de validation
        if (empty($errorMessages)) {
            if (verifyCredentials($connexion, $email, $password)) {
                $_SESSION['user'] = $email; // Enregistrer l'utilisateur dans la session
                echo json_encode(['success' => true, 'message' => "Connexion réussie."]);
                exit;
            } else {
                $errorMessages['general'] = "Identifiants incorrects.";
            }
        }
    } else {
        $errorMessages['general'] = "Impossible de se connecter à la base de données.";
    }

    // Retourner les erreurs au format JSON
    echo json_encode(['success' => false, 'errors' => $errorMessages]);
    exit;
}
?>
