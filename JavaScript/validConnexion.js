const myForm = document.getElementById('leForm');
const myRegexEmail = /^[^\s@]+@[^\s@]+\.[^\s@]+$/; // Vérifie le format de l'adresse e-mail
const myRegexPwd = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&]).{12,}$/; // Vérifie le mot de passe
const myEmail = document.getElementById('email');
const myPwd = document.getElementById('password');
const myErrorEmailInvalid = document.getElementById('errorEmailInvalid');
const myErrorPwd = document.getElementById('errorPwd');
const myErrorConnexion = document.getElementById('erreurConnexion'); // Div pour une erreur générale

// Initialiser la couleur des messages
myErrorEmailInvalid.style.color = "red";
myErrorPwd.style.color = "red";
myErrorConnexion.style.color = "red";

function validationConnexion() {
  let isValid = true;

  // Validation de l'email
  if (myEmail.value.trim() === "") {
    myErrorEmailInvalid.innerHTML = "Une adresse e-mail est requise.";
    isValid = false;
  } else if (!myRegexEmail.test(myEmail.value)) {
    myErrorEmailInvalid.innerHTML = "L'adresse e-mail n'est pas valide.";
    isValid = false;
  } else {
    myErrorEmailInvalid.innerHTML = ""; // Pas d'erreur
  }

  // Validation du mot de passe
  if (myPwd.value.trim() === "") {
    myErrorPwd.innerHTML = "Un mot de passe est requis.";
    isValid = false;
  } else if (!myRegexPwd.test(myPwd.value)) {
    myErrorPwd.innerHTML = "Le mot de passe doit contenir au moins 12 caractères, une minuscule, une majuscule, un chiffre et un caractère spécial.";
    isValid = false;
  } else {
    myErrorPwd.innerHTML = ""; // Pas d'erreur
  }

  return isValid;
}

myForm.addEventListener('submit', async function (e) {
  e.preventDefault(); // Empêche le rechargement de la page

  // Réinitialiser les messages
  myErrorConnexion.innerHTML = "";
  myMsgConnexion.innerHTML = "";

  if (validationConnexion()) {
    // Préparer les données à envoyer
    const email = myEmail.value.trim();
    const password = myPwd.value.trim();

    try {
      // Envoyer les données au serveur
      const response = await fetch('traitement_connexion.php', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: `email=${encodeURIComponent(email)}&password=${encodeURIComponent(password)}`,
      });

      const result = await response.json();

      if (result.success) {
        myMsgConnexion.innerHTML = "Connexion réussie ! Redirection...";
        setTimeout(() => {
          window.location.href = "dashboard.php"; // Exemple de redirection après connexion
        }, 2000);
      } else {
        // Afficher les erreurs spécifiques renvoyées par le serveur
        if (result.errors.email) {
          myErrorEmailInvalid.innerHTML = result.errors.email;
        }
        if (result.errors.password) {
          myErrorPwd.innerHTML = result.errors.password;
        }
      }
    } catch (error) {
      console.error("Erreur de connexion :", error);
      myErrorConnexion.innerHTML = "Une erreur s'est produite. Veuillez réessayer.";
    }
  }
});

