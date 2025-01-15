-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost
-- Généré le : mer. 15 jan. 2025 à 09:39
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
-- Structure de la table `Bateau`
--

CREATE TABLE `Bateau` (
  `id_bateau` int(11) NOT NULL,
  `nom_bateau` varchar(50) DEFAULT NULL,
  `long_bateau` decimal(4,2) DEFAULT NULL,
  `larg_bateau` decimal(4,2) DEFAULT NULL,
  `vitesse_bateau` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `Catégorie`
--

CREATE TABLE `Catégorie` (
  `id_cat` int(11) NOT NULL,
  `desc_cat` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `Choisir`
--

CREATE TABLE `Choisir` (
  `id_client` int(11) NOT NULL,
  `id_resa` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `Classer`
--

CREATE TABLE `Classer` (
  `id_type` int(11) NOT NULL,
  `id_cat` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `Client`
--

CREATE TABLE `Client` (
  `id_client` int(11) NOT NULL,
  `nom_client` varchar(50) DEFAULT NULL,
  `prenom_client` varchar(50) DEFAULT NULL,
  `adresse_client` varchar(50) DEFAULT NULL,
  `tel_client` varchar(50) DEFAULT NULL,
  `mail_client` varchar(50) DEFAULT NULL,
  `id_utilisateur` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `Contenir`
--

CREATE TABLE `Contenir` (
  `id_bateau` int(11) NOT NULL,
  `id_cat` int(11) NOT NULL,
  `capac_bateau_pass` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `Enregistrer`
--

CREATE TABLE `Enregistrer` (
  `id_resa` int(11) NOT NULL,
  `id_type` int(11) NOT NULL,
  `quantité` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `Equipement`
--

CREATE TABLE `Equipement` (
  `id_equip` int(11) NOT NULL,
  `desc_equip` varchar(150) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `Liaison`
--

CREATE TABLE `Liaison` (
  `id_liaison` int(11) NOT NULL,
  `dist_milles` decimal(4,2) DEFAULT NULL,
  `id_port` int(11) NOT NULL,
  `id_port_1` int(11) NOT NULL,
  `id_secteur` int(11) NOT NULL,
  `id_travers` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `Port`
--

CREATE TABLE `Port` (
  `id_port` int(11) NOT NULL,
  `nom_port` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `Période`
--

CREATE TABLE `Période` (
  `date_debut` date NOT NULL,
  `date_fin` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `Reservation`
--

CREATE TABLE `Reservation` (
  `id_resa` int(11) NOT NULL,
  `date_resa` date DEFAULT NULL,
  `id_travers` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `Secteur`
--

CREATE TABLE `Secteur` (
  `id_secteur` int(11) NOT NULL,
  `nom_secteur` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `Tarifer`
--

CREATE TABLE `Tarifer` (
  `id_liaison` int(11) NOT NULL,
  `id_type` int(11) NOT NULL,
  `date_debut` date NOT NULL,
  `Tarif` decimal(5,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `Traversée`
--

CREATE TABLE `Traversée` (
  `id_travers` int(11) NOT NULL,
  `date_travers` date DEFAULT NULL,
  `heure_travers` datetime DEFAULT NULL,
  `id_bateau` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `Type`
--

CREATE TABLE `Type` (
  `id_type` int(11) NOT NULL,
  `desc_type` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `Utilisateur`
--

CREATE TABLE `Utilisateur` (
  `id_utilisateur` int(11) NOT NULL,
  `nom_user` varchar(50) DEFAULT NULL,
  `prenom_user` varchar(50) DEFAULT NULL,
  `mail_user` varchar(50) DEFAULT NULL,
  `mdp_user` varchar(50) DEFAULT NULL,
  `typer_user` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `Être_équipé`
--

CREATE TABLE `Être_équipé` (
  `id_bateau` int(11) NOT NULL,
  `id_equip` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `Bateau`
--
ALTER TABLE `Bateau`
  ADD PRIMARY KEY (`id_bateau`);

--
-- Index pour la table `Catégorie`
--
ALTER TABLE `Catégorie`
  ADD PRIMARY KEY (`id_cat`);

--
-- Index pour la table `Choisir`
--
ALTER TABLE `Choisir`
  ADD PRIMARY KEY (`id_client`,`id_resa`),
  ADD KEY `id_resa` (`id_resa`);

--
-- Index pour la table `Classer`
--
ALTER TABLE `Classer`
  ADD PRIMARY KEY (`id_type`,`id_cat`),
  ADD KEY `id_cat` (`id_cat`);

--
-- Index pour la table `Client`
--
ALTER TABLE `Client`
  ADD PRIMARY KEY (`id_client`),
  ADD UNIQUE KEY `id_utilisateur` (`id_utilisateur`);

--
-- Index pour la table `Contenir`
--
ALTER TABLE `Contenir`
  ADD PRIMARY KEY (`id_bateau`,`id_cat`),
  ADD KEY `id_cat` (`id_cat`);

--
-- Index pour la table `Enregistrer`
--
ALTER TABLE `Enregistrer`
  ADD PRIMARY KEY (`id_resa`,`id_type`),
  ADD KEY `id_type` (`id_type`);

--
-- Index pour la table `Equipement`
--
ALTER TABLE `Equipement`
  ADD PRIMARY KEY (`id_equip`);

--
-- Index pour la table `Liaison`
--
ALTER TABLE `Liaison`
  ADD PRIMARY KEY (`id_liaison`),
  ADD KEY `id_port` (`id_port`),
  ADD KEY `id_port_1` (`id_port_1`),
  ADD KEY `id_secteur` (`id_secteur`),
  ADD KEY `id_travers` (`id_travers`);

--
-- Index pour la table `Port`
--
ALTER TABLE `Port`
  ADD PRIMARY KEY (`id_port`);

--
-- Index pour la table `Période`
--
ALTER TABLE `Période`
  ADD PRIMARY KEY (`date_debut`);

--
-- Index pour la table `Reservation`
--
ALTER TABLE `Reservation`
  ADD PRIMARY KEY (`id_resa`),
  ADD KEY `id_travers` (`id_travers`);

--
-- Index pour la table `Secteur`
--
ALTER TABLE `Secteur`
  ADD PRIMARY KEY (`id_secteur`);

--
-- Index pour la table `Tarifer`
--
ALTER TABLE `Tarifer`
  ADD PRIMARY KEY (`id_liaison`,`id_type`,`date_debut`),
  ADD KEY `id_type` (`id_type`),
  ADD KEY `date_debut` (`date_debut`);

--
-- Index pour la table `Traversée`
--
ALTER TABLE `Traversée`
  ADD PRIMARY KEY (`id_travers`),
  ADD KEY `id_bateau` (`id_bateau`);

--
-- Index pour la table `Type`
--
ALTER TABLE `Type`
  ADD PRIMARY KEY (`id_type`);

--
-- Index pour la table `Utilisateur`
--
ALTER TABLE `Utilisateur`
  ADD PRIMARY KEY (`id_utilisateur`);

--
-- Index pour la table `Être_équipé`
--
ALTER TABLE `Être_équipé`
  ADD PRIMARY KEY (`id_bateau`,`id_equip`),
  ADD KEY `id_equip` (`id_equip`);

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `Choisir`
--
ALTER TABLE `Choisir`
  ADD CONSTRAINT `choisir_ibfk_1` FOREIGN KEY (`id_client`) REFERENCES `Client` (`id_client`),
  ADD CONSTRAINT `choisir_ibfk_2` FOREIGN KEY (`id_resa`) REFERENCES `Reservation` (`id_resa`);

--
-- Contraintes pour la table `Classer`
--
ALTER TABLE `Classer`
  ADD CONSTRAINT `classer_ibfk_1` FOREIGN KEY (`id_type`) REFERENCES `Type` (`id_type`),
  ADD CONSTRAINT `classer_ibfk_2` FOREIGN KEY (`id_cat`) REFERENCES `Catégorie` (`id_cat`);

--
-- Contraintes pour la table `Client`
--
ALTER TABLE `Client`
  ADD CONSTRAINT `client_ibfk_1` FOREIGN KEY (`id_utilisateur`) REFERENCES `Utilisateur` (`id_utilisateur`);

--
-- Contraintes pour la table `Contenir`
--
ALTER TABLE `Contenir`
  ADD CONSTRAINT `contenir_ibfk_1` FOREIGN KEY (`id_bateau`) REFERENCES `Bateau` (`id_bateau`),
  ADD CONSTRAINT `contenir_ibfk_2` FOREIGN KEY (`id_cat`) REFERENCES `Catégorie` (`id_cat`);

--
-- Contraintes pour la table `Enregistrer`
--
ALTER TABLE `Enregistrer`
  ADD CONSTRAINT `enregistrer_ibfk_1` FOREIGN KEY (`id_resa`) REFERENCES `Reservation` (`id_resa`),
  ADD CONSTRAINT `enregistrer_ibfk_2` FOREIGN KEY (`id_type`) REFERENCES `Type` (`id_type`);

--
-- Contraintes pour la table `Liaison`
--
ALTER TABLE `Liaison`
  ADD CONSTRAINT `liaison_ibfk_1` FOREIGN KEY (`id_port`) REFERENCES `Port` (`id_port`),
  ADD CONSTRAINT `liaison_ibfk_2` FOREIGN KEY (`id_port_1`) REFERENCES `Port` (`id_port`),
  ADD CONSTRAINT `liaison_ibfk_3` FOREIGN KEY (`id_secteur`) REFERENCES `Secteur` (`id_secteur`),
  ADD CONSTRAINT `liaison_ibfk_4` FOREIGN KEY (`id_travers`) REFERENCES `Traversée` (`id_travers`);

--
-- Contraintes pour la table `Reservation`
--
ALTER TABLE `Reservation`
  ADD CONSTRAINT `reservation_ibfk_1` FOREIGN KEY (`id_travers`) REFERENCES `Traversée` (`id_travers`);

--
-- Contraintes pour la table `Tarifer`
--
ALTER TABLE `Tarifer`
  ADD CONSTRAINT `tarifer_ibfk_1` FOREIGN KEY (`id_liaison`) REFERENCES `Liaison` (`id_liaison`),
  ADD CONSTRAINT `tarifer_ibfk_2` FOREIGN KEY (`id_type`) REFERENCES `Type` (`id_type`),
  ADD CONSTRAINT `tarifer_ibfk_3` FOREIGN KEY (`date_debut`) REFERENCES `Période` (`date_debut`);

--
-- Contraintes pour la table `Traversée`
--
ALTER TABLE `Traversée`
  ADD CONSTRAINT `traversée_ibfk_1` FOREIGN KEY (`id_bateau`) REFERENCES `Bateau` (`id_bateau`);

--
-- Contraintes pour la table `Être_équipé`
--
ALTER TABLE `Être_équipé`
  ADD CONSTRAINT `être_équipé_ibfk_1` FOREIGN KEY (`id_bateau`) REFERENCES `Bateau` (`id_bateau`),
  ADD CONSTRAINT `être_équipé_ibfk_2` FOREIGN KEY (`id_equip`) REFERENCES `Equipement` (`id_equip`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
