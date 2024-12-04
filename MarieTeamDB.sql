-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost
-- Généré le : mer. 04 déc. 2024 à 09:09
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
-- Base de données : `MarieTeamDB`
--

-- --------------------------------------------------------

--
-- Structure de la table `Affecter`
--

CREATE TABLE `Affecter` (
  `id_travers` int(11) NOT NULL,
  `id_bateau` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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

-- --------------------------------------------------------

--
-- Structure de la table `Etre_Equipe`
--

CREATE TABLE `Etre_Equipe` (
  `id_bateau` int(11) NOT NULL,
  `id_equip` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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

-- --------------------------------------------------------

--
-- Structure de la table `Liaison_Type_Tarif`
--

CREATE TABLE `Liaison_Type_Tarif` (
  `id_tarif` int(11) NOT NULL,
  `id_type` int(11) NOT NULL,
  `id_liaison` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `Periode`
--

CREATE TABLE `Periode` (
  `id_periode` int(11) NOT NULL,
  `date_debut` date DEFAULT NULL,
  `date_fin` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `Port`
--

CREATE TABLE `Port` (
  `id_port` int(11) NOT NULL,
  `nom_port` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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

-- --------------------------------------------------------

--
-- Structure de la table `Secteur`
--

CREATE TABLE `Secteur` (
  `id_secteur` int(11) NOT NULL,
  `nom_secteur` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `Tarifer`
--

CREATE TABLE `Tarifer` (
  `id_tarif` int(11) NOT NULL,
  `tarif` decimal(10,2) DEFAULT NULL,
  `id_periode` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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

-- --------------------------------------------------------

--
-- Structure de la table `Type`
--

CREATE TABLE `Type` (
  `id_type` int(11) NOT NULL,
  `desc_type` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
  MODIFY `id_bateau` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `Categorie`
--
ALTER TABLE `Categorie`
  MODIFY `id_cat` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `Client`
--
ALTER TABLE `Client`
  MODIFY `id_client` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `Equipement`
--
ALTER TABLE `Equipement`
  MODIFY `id_equip` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `Liaison`
--
ALTER TABLE `Liaison`
  MODIFY `id_liaison` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `Periode`
--
ALTER TABLE `Periode`
  MODIFY `id_periode` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `Port`
--
ALTER TABLE `Port`
  MODIFY `id_port` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `Reservation`
--
ALTER TABLE `Reservation`
  MODIFY `id_resa` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `Secteur`
--
ALTER TABLE `Secteur`
  MODIFY `id_secteur` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `Tarifer`
--
ALTER TABLE `Tarifer`
  MODIFY `id_tarif` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `Traversee`
--
ALTER TABLE `Traversee`
  MODIFY `id_travers` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `Type`
--
ALTER TABLE `Type`
  MODIFY `id_type` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `Utilisateur`
--
ALTER TABLE `Utilisateur`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT;

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
