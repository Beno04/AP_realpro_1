<?php
session_start();

// Vérifier si l'utilisateur est connecté
if (isset($_SESSION['user_id'])) {
    // Paramètres de connexion à la base de données
    $servername = "127.0.0.1";
    $username = "root";
    $password = "";
    $dbname = "marieteam";

    try {
        // Créer une connexion à la base de données avec PDO
        $connexion = new PDO("mysql:host=$servername;dbname=$dbname;charset=utf8", $username, $password, [
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
            PDO::ATTR_EMULATE_PREPARES => false
        ]);
        
        // Récupérer l'ID utilisateur de la session
        $idUtilisateur = $_SESSION['user_id'];

        // Traitement du formulaire lorsque l'utilisateur soumet ses nouvelles informations
        if ($_SERVER['REQUEST_METHOD'] == 'POST') {
            // Récupérer les données du formulaire
            $nouveauNom = $_POST['nom'];
            $nouveauPrenom = $_POST['prenom'];
            $nouvelEmail = $_POST['email'];
            $motDePasse = $_POST['password'];

            // Vérifier le mot de passe actuel de l'utilisateur
            $query = "SELECT mdp_user FROM utilisateur WHERE id = :id";
            $stmt = $connexion->prepare($query);
            $stmt->bindParam(':id', $idUtilisateur, PDO::PARAM_INT);
            $stmt->execute();

            // Vérifier si le mot de passe correspond
            if ($password_verify($motDePasse)) {
                // Le mot de passe est correct, on peut procéder à la mise à jour des informations
                $updateQuery = "UPDATE utilisateur SET nom_user = :nom_user, prenom_user = :prenom_user, mail_user = :mail_user WHERE id = :id";
                $updateStmt = $connexion->prepare($updateQuery);
                $updateStmt->bindParam(':nom_user', $nouveauNom, PDO::PARAM_STR);
                $updateStmt->bindParam(':prenom_user', $nouveauPrenom, PDO::PARAM_STR);
                $updateStmt->bindParam(':mail_user', $nouvelEmail, PDO::PARAM_STR);
                $updateStmt->bindParam(':id', $idUtilisateur, PDO::PARAM_INT);

                // Exécuter la mise à jour
                if ($updateStmt->execute()) {
                    // Succès, afficher un message
                    echo "<div class='success'>Les informations ont été mises à jour avec succès.</div>";
                } else {
                    echo "<div class='error'>Une erreur est survenue lors de la mise à jour des informations.</div>";
                }
            } else {
                // Mot de passe incorrect
                echo "<div class='error'>Le mot de passe actuel est incorrect.</div>";
            }
        }
    } catch (PDOException $e) {
        // En cas d'erreur de connexion à la base de données
        echo "Erreur de connexion à la base de données : " . $e->getMessage();
    }
} else {
    echo "Vous devez être connecté pour modifier vos informations.";
}
?>
