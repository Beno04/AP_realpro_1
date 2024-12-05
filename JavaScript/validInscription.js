const myForm = document.getElementById('leForm');
const myRegexUser  = /^[a-zA-Z]+$/; // Vérifie qu'il n'y a que des lettres dans le nom et le prénom
const myRegexEmail = /^[^\s@]+@[^\s@]+\.[^\s@]+$/; // Vérifie le format de l'adresse e-mail
const myRegexPwd = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&]).{12,}$/; // Vérifie le mot de passe
const myNom = document.getElementById('nom'); // Récupère le nom
const myPrenom = document.getElementById('prenom'); // Récupère le prénom
const myEmail = document.getElementById('email'); // Récupère l'adresse e-mail
const myPwd = document.getElementById('password'); // Récupère le mot de passe
const myErrorNom = document.getElementById('errorNom'); // Récupère l'endroit où le message d'erreur doit être affiché pour le nom
const myErrorPrenom = document.getElementById('errorPrenom'); // Récupère l'endroit où le message d'erreur doit être affiché pour le prénom
const myErrorEmail = document.getElementById('errorEmail'); // Récupère l'endroit où le message d'erreur doit être affiché pour l'email
const myErrorPwd = document.getElementById('errorPwd'); // Récupère l'endroit où le message d'erreur doit être affiché pour le mot de passe
const myErrorInscription = document.getElementById('errorInscription'); //
const myMsgInscription = document.getElementById('messageInscription'); //

myErrorNom.style.color = "red"; // Met la couleur de l'erreur du nom en rouge
myErrorPrenom.style.color = "red"; // Met la couleur de l'erreur du prénom en rouge
myErrorEmail.style.color = "red"; // Met la couleur de l'erreur de l'email en rouge
myErrorPwd.style.color = "red"; // Met la couleur de l'erreur du mot de passe en rouge
myErrorInscription.style.color = "red"; // Met la couleur de l'erreur de l'inscription en rouge
myMsgInscription.style.color = "green"; // Met la couleur du message d'inscription en vert

function validationForm() {
  // Validation du nom
  if (myNom.value.trim() === "") {
    myErrorNom.innerHTML = "Un nom est requis.";
  } else if (!myRegexUser .test(myNom.value)) {
    myErrorNom.innerHTML = "Le nom doit contenir seulement des lettres.";
  } else {
    myErrorNom.innerHTML = ""; // Pas d'erreur
  }

  // Validation du prénom
  if (myPrenom.value.trim() === "") {
    myErrorPrenom.innerHTML = "Un prénom est requis.";
  } else if (!myRegexUser .test(myPrenom.value)) {
    myErrorPrenom.innerHTML = "Le prénom doit contenir seulement des lettres.";
  } else {
    myErrorPrenom.innerHTML = ""; // Pas d'erreur
  }

  // Validation de l'email
  if (myEmail.value.trim() === "") {
    myErrorEmail.innerHTML = "Une adresse e-mail est requise.";
  } else if (!myRegexEmail.test(myEmail.value)) {
    myErrorEmail.innerHTML = "L'adresse e-mail n'est pas valide.";
  } else {
    myErrorEmail.innerHTML = ""; // Pas d'erreur
  }

  // Validation du mot de passe
  if (myPwd.value.trim() === "") {
    myErrorPwd.innerHTML = "Un mot de passe est requis.";
  } else if (!myRegexPwd.test(myPwd.value)) {
    myErrorPwd.innerHTML = "Le mot de passe doit faire au moins 12 caractères et contenir au moins une minuscule, une majuscule, un chiffre et un caractère spécial."; 
  } else {
    myErrorPwd.innerHTML = ""; // Pas d'erreur
  }
}

myForm.addEventListener('submit', function(e) {
  validationForm(); // Appelle la fonction qui permet de valider le formulaire
  // Si des erreurs sont présentes, empêcher l'envoi du formulaire
  if (myErrorNom.innerHTML || myErrorPrenom.innerHTML || myErrorEmail.innerHTML || myErrorPwd.innerHTML) {
    e.preventDefault();
  }else {
    myMsgInscription.innerHTML = "Inscription réussie !!";
    }
});