-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost
-- Généré le : mer. 04 déc. 2024 à 11:04
-- Version du serveur : 10.4.28-MariaDB
-- Version de PHP : 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `marieteam`
--

-- --------------------------------------------------------

--
-- Structure de la table `Affecter`
--

CREATE TABLE `Affecter` (
  `id_travers` int(11) NOT NULL,
  `id_bateau` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `Affecter`
--

INSERT INTO `Affecter` (`id_travers`, `id_bateau`) VALUES
(1, 1),
(2, 2);

-- --------------------------------------------------------

--
-- Structure de la table `Bateau`
--

CREATE TABLE `Bateau` (
  `id_bateau` int(11) NOT NULL,
  `nom_bateau` varchar(255) DEFAULT NULL,
  `long_bateau` decimal(10,2) DEFAULT NULL,
  `larg_bateau` decimal(10,2) DEFAULT NULL,
  `vitesse_bateau` decimal(10,2) DEFAULT NULL,
  `id_cat` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `Bateau`
--

INSERT INTO `Bateau` (`id_bateau`, `nom_bateau`, `long_bateau`, `larg_bateau`, `vitesse_bateau`, `id_cat`) VALUES
(1, 'Luce Isle', 37.20, 8.60, 26.00, NULL),
(2, 'Al\'xi', 25.00, 7.00, 16.00, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `Categorie`
--

CREATE TABLE `Categorie` (
  `id_cat` int(11) NOT NULL,
  `desc_cat` varchar(255) DEFAULT NULL,
  `id_type` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `Client`
--

CREATE TABLE `Client` (
  `id_client` int(11) NOT NULL,
  `nom_client` varchar(100) DEFAULT NULL,
  `prenom_client` varchar(100) DEFAULT NULL,
  `adresse_client` varchar(255) DEFAULT NULL,
  `tel_client` varchar(15) DEFAULT NULL,
  `mail_client` varchar(100) DEFAULT NULL,
  `id_user` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `Client`
--

INSERT INTO `Client` (`id_client`, `nom_client`, `prenom_client`, `adresse_client`, `tel_client`, `mail_client`, `id_user`) VALUES
(1, 'Dupont', 'Jean', '12 rue de Paris', '0601234567', 'jean.dupont@example.com', NULL),
(2, 'Martin', 'Sophie', '8 avenue de Lyon, 69001 Lyon', '0612345678', 'sophie.martin@example.com', 2),
(3, 'Durand', 'Paul', '14 boulevard des Champs, 31000 Toulouse', '0623456789', 'paul.durand@example.com', 3),
(4, 'Bernard', 'Lucie', '5 impasse des Lilas, 44000 Nantes', '0634567890', 'lucie.bernard@example.com', 4),
(5, 'Moreau', 'Emma', '10 place de l\'Eglise, 33000 Bordeaux', '0645678901', 'emma.moreau@example.com', 5);

-- --------------------------------------------------------

--
-- Structure de la table `Contenir`
--

CREATE TABLE `Contenir` (
  `id_bateau` int(11) NOT NULL,
  `capac_bateau_pass` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `Equipement`
--

CREATE TABLE `Equipement` (
  `id_equip` int(11) NOT NULL,
  `desc_equip` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `Equipement`
--

INSERT INTO `Equipement` (`id_equip`, `desc_equip`) VALUES
(1, 'Accès Handicapé'),
(2, 'Bar'),
(3, 'Pont Promenade'),
(4, 'Salon Vidéo');

-- --------------------------------------------------------

--
-- Structure de la table `Etre_Equipe`
--

CREATE TABLE `Etre_Equipe` (
  `id_bateau` int(11) NOT NULL,
  `id_equip` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `Etre_Equipe`
--

INSERT INTO `Etre_Equipe` (`id_bateau`, `id_equip`) VALUES
(1, 1),
(1, 2),
(2, 1),
(2, 3);

-- --------------------------------------------------------

--
-- Structure de la table `Liaison`
--

CREATE TABLE `Liaison` (
  `id_liaison` int(11) NOT NULL,
  `dist_milles` decimal(10,2) DEFAULT NULL,
  `id_secteur` int(11) DEFAULT NULL,
  `id_port_depart` int(11) DEFAULT NULL,
  `id_port_arrivee` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `Liaison`
--

INSERT INTO `Liaison` (`id_liaison`, `dist_milles`, `id_secteur`, `id_port_depart`, `id_port_arrivee`) VALUES
(1, 8.30, 1, 1, 2),
(2, 8.00, 1, 1, 3),
(3, 7.70, 3, 4, 5);

-- --------------------------------------------------------

--
-- Structure de la table `Liaison_Type_Tarif`
--

CREATE TABLE `Liaison_Type_Tarif` (
  `id_tarif` int(11) NOT NULL,
  `id_type` int(11) NOT NULL,
  `id_liaison` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `Liaison_Type_Tarif`
--

INSERT INTO `Liaison_Type_Tarif` (`id_tarif`, `id_type`, `id_liaison`) VALUES
(1, 1, 1),
(2, 1, 1),
(3, 1, 1);

-- --------------------------------------------------------

--
-- Structure de la table `Periode`
--

CREATE TABLE `Periode` (
  `id_periode` int(11) NOT NULL,
  `date_debut` date DEFAULT NULL,
  `date_fin` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `Periode`
--

INSERT INTO `Periode` (`id_periode`, `date_debut`, `date_fin`) VALUES
(1, '2024-01-01', '2024-06-15'),
(2, '2024-06-16', '2024-09-15'),
(3, '2024-09-16', '2024-12-31');

-- --------------------------------------------------------

--
-- Structure de la table `Port`
--

CREATE TABLE `Port` (
  `id_port` int(11) NOT NULL,
  `nom_port` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `Port`
--

INSERT INTO `Port` (`id_port`, `nom_port`) VALUES
(1, 'Quiberon'),
(2, 'Le Palais'),
(3, 'Sauzon'),
(4, 'Lorient'),
(5, 'Port-Tudy');

-- --------------------------------------------------------

--
-- Structure de la table `Reservation`
--

CREATE TABLE `Reservation` (
  `id_resa` int(11) NOT NULL,
  `date_resa` date DEFAULT NULL,
  `id_client` int(11) DEFAULT NULL,
  `id_type` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `Reservation`
--

INSERT INTO `Reservation` (`id_resa`, `date_resa`, `id_client`, `id_type`) VALUES
(1, '2024-07-01', 1, 1);

-- --------------------------------------------------------

--
-- Structure de la table `Secteur`
--

CREATE TABLE `Secteur` (
  `id_secteur` int(11) NOT NULL,
  `nom_secteur` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `Secteur`
--

INSERT INTO `Secteur` (`id_secteur`, `nom_secteur`) VALUES
(1, 'Belle-Ile-en-Mer'),
(2, 'Houat'),
(3, 'Ile de Groix');

-- --------------------------------------------------------

--
-- Structure de la table `Tarifer`
--

CREATE TABLE `Tarifer` (
  `id_tarif` int(11) NOT NULL,
  `tarif` decimal(10,2) DEFAULT NULL,
  `id_periode` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `Tarifer`
--

INSERT INTO `Tarifer` (`id_tarif`, `tarif`, `id_periode`) VALUES
(1, 18.00, 1),
(2, 20.00, 2),
(3, 19.00, 3);

-- --------------------------------------------------------

--
-- Structure de la table `Traversee`
--

CREATE TABLE `Traversee` (
  `id_travers` int(11) NOT NULL,
  `date_travers` date DEFAULT NULL,
  `heure_travers` time DEFAULT NULL,
  `id_liaison` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `Traversee`
--

INSERT INTO `Traversee` (`id_travers`, `date_travers`, `heure_travers`, `id_liaison`) VALUES
(1, '2024-07-10', '07:45:00', 1),
(2, '2024-07-10', '09:15:00', 1);

-- --------------------------------------------------------

--
-- Structure de la table `Type`
--

CREATE TABLE `Type` (
  `id_type` int(11) NOT NULL,
  `desc_type` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `Type`
--

INSERT INTO `Type` (`id_type`, `desc_type`) VALUES
(1, 'Adulte'),
(2, 'Junior 8 à 18 ans'),
(3, 'Enfant 0 à 7 ans '),
(4, 'Voiture long.inf.4m'),
(5, 'Voiture long.inf.5m'),
(6, 'Fourgon'),
(7, 'Camping Car'),
(8, 'Camion');

-- --------------------------------------------------------

--
-- Structure de la table `Utilisateur`
--

CREATE TABLE `Utilisateur` (
  `id_user` int(11) NOT NULL,
  `nom_user` varchar(100) DEFAULT NULL,
  `prenom_user` varchar(100) DEFAULT NULL,
  `mail_user` varchar(100) DEFAULT NULL,
  `mdp_user` varchar(255) DEFAULT NULL,
  `type_user` enum('client','gestionnaire') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `Utilisateur`
--

INSERT INTO `Utilisateur` (`id_user`, `nom_user`, `prenom_user`, `mail_user`, `mdp_user`, `type_user`) VALUES
(1, 'Dupont', 'Jean', 'jean.dupont@example.com', 'hashedpassword1', 'client'),
(2, 'Martin', 'Sophie', 'sophie.martin@example.com', 'hashedpassword2', 'client'),
(3, 'Durand', 'Paul', 'paul.durand@example.com', 'hashedpassword3', 'client'),
(4, 'Bernard', 'Lucie', 'lucie.bernard@example.com', 'hashedpassword4', 'client'),
(5, 'Moreau', 'Emma', 'emma.moreau@example.com', 'hashedpassword5', 'client'),
(6, 'Lucas', 'Beno', 'lucas.benault@example.com', 'hashedpassword7', 'gestionnaire');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `Affecter`
--
ALTER TABLE `Affecter`
  ADD PRIMARY KEY (`id_travers`,`id_bateau`),
  ADD KEY `id_bateau` (`id_bateau`);

--
-- Index pour la table `Bateau`
--
ALTER TABLE `Bateau`
  ADD PRIMARY KEY (`id_bateau`),
  ADD KEY `fk_bateau_categorie` (`id_cat`);

--
-- Index pour la table `Categorie`
--
ALTER TABLE `Categorie`
  ADD PRIMARY KEY (`id_cat`),
  ADD KEY `fk_categorie_type` (`id_type`);

--
-- Index pour la table `Client`
--
ALTER TABLE `Client`
  ADD PRIMARY KEY (`id_client`),
  ADD UNIQUE KEY `mail_client` (`mail_client`),
  ADD KEY `fk_client_utilisateur` (`id_user`);

--
-- Index pour la table `Contenir`
--
ALTER TABLE `Contenir`
  ADD PRIMARY KEY (`id_bateau`);

--
-- Index pour la table `Equipement`
--
ALTER TABLE `Equipement`
  ADD PRIMARY KEY (`id_equip`);

--
-- Index pour la table `Etre_Equipe`
--
ALTER TABLE `Etre_Equipe`
  ADD PRIMARY KEY (`id_bateau`,`id_equip`),
  ADD KEY `id_equip` (`id_equip`);

--
-- Index pour la table `Liaison`
--
ALTER TABLE `Liaison`
  ADD PRIMARY KEY (`id_liaison`),
  ADD KEY `id_secteur` (`id_secteur`),
  ADD KEY `id_port_depart` (`id_port_depart`),
  ADD KEY `id_port_arrivee` (`id_port_arrivee`);

--
-- Index pour la table `Liaison_Type_Tarif`
--
ALTER TABLE `Liaison_Type_Tarif`
  ADD PRIMARY KEY (`id_tarif`,`id_type`,`id_liaison`),
  ADD KEY `id_type` (`id_type`),
  ADD KEY `id_liaison` (`id_liaison`);

--
-- Index pour la table `Periode`
--
ALTER TABLE `Periode`
  ADD PRIMARY KEY (`id_periode`);

--
-- Index pour la table `Port`
--
ALTER TABLE `Port`
  ADD PRIMARY KEY (`id_port`);

--
-- Index pour la table `Reservation`
--
ALTER TABLE `Reservation`
  ADD PRIMARY KEY (`id_resa`),
  ADD KEY `id_client` (`id_client`),
  ADD KEY `fk_reservation_type` (`id_type`);

--
-- Index pour la table `Secteur`
--
ALTER TABLE `Secteur`
  ADD PRIMARY KEY (`id_secteur`);

--
-- Index pour la table `Tarifer`
--
ALTER TABLE `Tarifer`
  ADD PRIMARY KEY (`id_tarif`),
  ADD KEY `id_periode` (`id_periode`);

--
-- Index pour la table `Traversee`
--
ALTER TABLE `Traversee`
  ADD PRIMARY KEY (`id_travers`),
  ADD KEY `id_liaison` (`id_liaison`);

--
-- Index pour la table `Type`
--
ALTER TABLE `Type`
  ADD PRIMARY KEY (`id_type`);

--
-- Index pour la table `Utilisateur`
--
ALTER TABLE `Utilisateur`
  ADD PRIMARY KEY (`id_user`),
  ADD UNIQUE KEY `mail_user` (`mail_user`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `Bateau`
--
ALTER TABLE `Bateau`
  MODIFY `id_bateau` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `Categorie`
--
ALTER TABLE `Categorie`
  MODIFY `id_cat` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `Client`
--
ALTER TABLE `Client`
  MODIFY `id_client` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `Equipement`
--
ALTER TABLE `Equipement`
  MODIFY `id_equip` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `Liaison`
--
ALTER TABLE `Liaison`
  MODIFY `id_liaison` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `Periode`
--
ALTER TABLE `Periode`
  MODIFY `id_periode` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `Port`
--
ALTER TABLE `Port`
  MODIFY `id_port` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `Reservation`
--
ALTER TABLE `Reservation`
  MODIFY `id_resa` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `Secteur`
--
ALTER TABLE `Secteur`
  MODIFY `id_secteur` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `Tarifer`
--
ALTER TABLE `Tarifer`
  MODIFY `id_tarif` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `Traversee`
--
ALTER TABLE `Traversee`
  MODIFY `id_travers` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `Type`
--
ALTER TABLE `Type`
  MODIFY `id_type` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT pour la table `Utilisateur`
--
ALTER TABLE `Utilisateur`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `Affecter`
--
ALTER TABLE `Affecter`
  ADD CONSTRAINT `affecter_ibfk_1` FOREIGN KEY (`id_travers`) REFERENCES `Traversee` (`id_travers`),
  ADD CONSTRAINT `affecter_ibfk_2` FOREIGN KEY (`id_bateau`) REFERENCES `Bateau` (`id_bateau`);

--
-- Contraintes pour la table `Bateau`
--
ALTER TABLE `Bateau`
  ADD CONSTRAINT `fk_bateau_categorie` FOREIGN KEY (`id_cat`) REFERENCES `Categorie` (`id_cat`);

--
-- Contraintes pour la table `Categorie`
--
ALTER TABLE `Categorie`
  ADD CONSTRAINT `fk_categorie_type` FOREIGN KEY (`id_type`) REFERENCES `Type` (`id_type`);

--
-- Contraintes pour la table `Client`
--
ALTER TABLE `Client`
  ADD CONSTRAINT `fk_client_utilisateur` FOREIGN KEY (`id_user`) REFERENCES `Utilisateur` (`id_user`);

--
-- Contraintes pour la table `Contenir`
--
ALTER TABLE `Contenir`
  ADD CONSTRAINT `contenir_ibfk_1` FOREIGN KEY (`id_bateau`) REFERENCES `Bateau` (`id_bateau`);

--
-- Contraintes pour la table `Etre_Equipe`
--
ALTER TABLE `Etre_Equipe`
  ADD CONSTRAINT `etre_equipe_ibfk_1` FOREIGN KEY (`id_bateau`) REFERENCES `Bateau` (`id_bateau`),
  ADD CONSTRAINT `etre_equipe_ibfk_2` FOREIGN KEY (`id_equip`) REFERENCES `Equipement` (`id_equip`);

--
-- Contraintes pour la table `Liaison`
--
ALTER TABLE `Liaison`
  ADD CONSTRAINT `liaison_ibfk_1` FOREIGN KEY (`id_secteur`) REFERENCES `Secteur` (`id_secteur`),
  ADD CONSTRAINT `liaison_ibfk_2` FOREIGN KEY (`id_port_depart`) REFERENCES `Port` (`id_port`),
  ADD CONSTRAINT `liaison_ibfk_3` FOREIGN KEY (`id_port_arrivee`) REFERENCES `Port` (`id_port`);

--
-- Contraintes pour la table `Liaison_Type_Tarif`
--
ALTER TABLE `Liaison_Type_Tarif`
  ADD CONSTRAINT `liaison_type_tarif_ibfk_1` FOREIGN KEY (`id_tarif`) REFERENCES `Tarifer` (`id_tarif`),
  ADD CONSTRAINT `liaison_type_tarif_ibfk_2` FOREIGN KEY (`id_type`) REFERENCES `Type` (`id_type`),
  ADD CONSTRAINT `liaison_type_tarif_ibfk_3` FOREIGN KEY (`id_liaison`) REFERENCES `Liaison` (`id_liaison`);

--
-- Contraintes pour la table `Reservation`
--
ALTER TABLE `Reservation`
  ADD CONSTRAINT `fk_reservation_type` FOREIGN KEY (`id_type`) REFERENCES `Type` (`id_type`),
  ADD CONSTRAINT `reservation_ibfk_1` FOREIGN KEY (`id_client`) REFERENCES `Client` (`id_client`);

--
-- Contraintes pour la table `Tarifer`
--
ALTER TABLE `Tarifer`
  ADD CONSTRAINT `tarifer_ibfk_1` FOREIGN KEY (`id_periode`) REFERENCES `Periode` (`id_periode`);

--
-- Contraintes pour la table `Traversee`
--
ALTER TABLE `Traversee`
  ADD CONSTRAINT `traversee_ibfk_1` FOREIGN KEY (`id_liaison`) REFERENCES `Liaison` (`id_liaison`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
