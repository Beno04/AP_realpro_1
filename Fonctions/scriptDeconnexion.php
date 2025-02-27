<?php
session_start(); // Démarrer la session pour avoir accès aux données de session

// Supprime toutes les variables de session
$_SESSION = [];

// Supprime la session en cours
session_unset(); 
session_destroy();

// Supprime le cookie de session si il existe
if (ini_get("session.use_cookies")) {
    $params = session_get_cookie_params();
    setcookie(session_name(), '', time() - 42000, 
        $params["path"], $params["domain"], 
        $params["secure"], $params["httponly"]
    );
}

// Redirection vers la page d'accueil (index.php par exemple)
header("Location: index.php");
exit(); // Ne pas oublier d'ajouter exit() après header() pour arrêter le script
?>
