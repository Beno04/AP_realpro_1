-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : ven. 21 mars 2025 à 16:34
-- Version du serveur : 10.4.32-MariaDB
-- Version de PHP : 8.0.30

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
-- Structure de la table `bateau`
--

CREATE TABLE `bateau` (
  `id_bateau` int(11) NOT NULL,
  `nom_bateau` varchar(50) DEFAULT NULL,
  `long_bateau` decimal(4,2) DEFAULT NULL,
  `larg_bateau` decimal(4,2) DEFAULT NULL,
  `vitesse_bateau` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `bateau`
--

INSERT INTO `bateau` (`id_bateau`, `nom_bateau`, `long_bateau`, `larg_bateau`, `vitesse_bateau`) VALUES
(1, 'Luce Isle', 37.20, 8.60, '26 noeuds'),
(2, 'Al\'xi', 25.00, 7.00, '16 noeuds');

-- --------------------------------------------------------

--
-- Structure de la table `catégorie`
--

CREATE TABLE `catégorie` (
  `id_cat` int(11) NOT NULL,
  `desc_cat` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `catégorie`
--

INSERT INTO `catégorie` (`id_cat`, `desc_cat`) VALUES
(1, 'Passager'),
(2, 'Veh.inf.2m'),
(3, 'Veh.sup.2m');

-- --------------------------------------------------------

--
-- Structure de la table `choisir`
--

CREATE TABLE `choisir` (
  `id_client` int(11) NOT NULL,
  `id_resa` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `classer`
--

CREATE TABLE `classer` (
  `id_type` int(11) NOT NULL,
  `id_cat` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `client`
--

CREATE TABLE `client` (
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
-- Structure de la table `contenir`
--

CREATE TABLE `contenir` (
  `id_bateau` int(11) NOT NULL,
  `id_cat` int(11) NOT NULL,
  `capac_bateau_pass` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `contenir`
--

INSERT INTO `contenir` (`id_bateau`, `id_cat`, `capac_bateau_pass`) VALUES
(1, 1, 500),
(1, 2, 20),
(1, 3, 10),
(2, 1, 300),
(2, 2, 15),
(2, 3, 5);

-- --------------------------------------------------------

--
-- Structure de la table `enregistrer`
--

CREATE TABLE `enregistrer` (
  `id_resa` int(11) NOT NULL,
  `id_type` int(11) NOT NULL,
  `quantité` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `enregistrer`
--

INSERT INTO `enregistrer` (`id_resa`, `id_type`, `quantité`) VALUES
(1, 1, '2'),
(1, 3, '3'),
(1, 4, '1'),
(1, 7, '1'),
(2, 1, '1'),
(3, 1, '5');

--
-- Déclencheurs `enregistrer`
--
DELIMITER $$
CREATE TRIGGER `Check_PlaceDispoPassager_Before_Insert` BEFORE INSERT ON `enregistrer` FOR EACH ROW BEGIN
    DECLARE places_dispo INT;

    -- Récupération des places disponibles pour la traversée concernée
    SELECT PlaceDispo INTO places_dispo 
    FROM PlaceDispoPassager 
    WHERE id_travers = (SELECT id_travers FROM reservation WHERE id_resa = NEW.id_resa)
    LIMIT 1;

    -- Vérification si on dépasse le nombre de places disponibles
    IF places_dispo IS NULL OR places_dispo < NEW.quantité THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Réservation refusée : plus assez de places disponibles.';
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `Check_PlaceDispoVéhiculeInf2m_Before_Insert` BEFORE INSERT ON `enregistrer` FOR EACH ROW BEGIN
    DECLARE places_dispo INT;

    -- Vérification que l'insertion concerne un véhicule < 2m (id_type 4 ou 5)
    IF NEW.id_type IN (4,5) THEN
        -- Récupération des places disponibles pour la traversée concernée
        SELECT PlaceDispo INTO places_dispo 
        FROM PlaceDispoVéhiculeInf2m 
        WHERE id_travers = (SELECT id_travers FROM reservation WHERE id_resa = NEW.id_resa)
        LIMIT 1;

        -- Vérification si la réservation dépasse les places disponibles
        IF places_dispo IS NULL OR places_dispo < NEW.quantité THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Réservation refusée : plus assez de places pour les véhicules < 2m.';
        END IF;
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `Check_PlaceDispoVéhiculeSup2m_Before_Insert` BEFORE INSERT ON `enregistrer` FOR EACH ROW BEGIN
    DECLARE places_dispo INT;

    -- Vérification que l'insertion concerne un véhicule > 2m (id_type 6, 7 ou 8)
    IF NEW.id_type IN (6,7,8) THEN
        -- Récupération des places disponibles pour la traversée concernée
        SELECT PlaceDispo INTO places_dispo 
        FROM PlaceDispoVéhiculeSup2m 
        WHERE id_travers = (SELECT id_travers FROM reservation WHERE id_resa = NEW.id_resa)
        LIMIT 1;

        -- Vérification si la réservation dépasse les places disponibles
        IF places_dispo IS NULL OR places_dispo < NEW.quantité THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Réservation refusée : plus assez de places pour les véhicules > 2m.';
        END IF;
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `equipement`
--

CREATE TABLE `equipement` (
  `id_equip` int(11) NOT NULL,
  `desc_equip` varchar(150) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `equipement`
--

INSERT INTO `equipement` (`id_equip`, `desc_equip`) VALUES
(1, 'Accès Handicapé'),
(2, 'Bar'),
(3, 'Pont Promenade'),
(4, 'Salon Vidéo');

-- --------------------------------------------------------

--
-- Structure de la table `liaison`
--

CREATE TABLE `liaison` (
  `id_liaison` int(11) NOT NULL,
  `dist_milles` decimal(4,2) DEFAULT NULL,
  `id_port` int(11) NOT NULL,
  `id_port_1` int(11) NOT NULL,
  `id_secteur` int(11) NOT NULL,
  `id_travers` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `liaison`
--

INSERT INTO `liaison` (`id_liaison`, `dist_milles`, `id_port`, `id_port_1`, `id_secteur`, `id_travers`) VALUES
(1, 8.30, 1, 2, 1, 2),
(2, 9.00, 2, 1, 1, 15),
(3, 8.80, 1, 5, 2, 30),
(4, 8.80, 5, 1, 2, 31),
(5, 7.70, 6, 7, 3, 32),
(6, 7.40, 7, 6, 3, 33),
(7, 8.80, 1, 2, 1, 3);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `nbpassagerresa`
-- (Voir ci-dessous la vue réelle)
--
CREATE TABLE `nbpassagerresa` (
`id_travers` int(11)
,`NbPersonneResa` double
);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `nbréssavertion`
-- (Voir ci-dessous la vue réelle)
--
CREATE TABLE `nbréssavertion` (
`id_travers` int(11)
,`NbPersonneResa` double
,`NbVehiculeInf2mResa` double
,`NbVehiculeSup2mResa` double
);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `nbvéhiculeinf2mresa`
-- (Voir ci-dessous la vue réelle)
--
CREATE TABLE `nbvéhiculeinf2mresa` (
`id_travers` int(11)
,`NbVéhiculeResa` double
);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `nbvéhiculesup2mresa`
-- (Voir ci-dessous la vue réelle)
--
CREATE TABLE `nbvéhiculesup2mresa` (
`id_travers` int(11)
,`NbVéhiculeResa` double
);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `placedispopassager`
-- (Voir ci-dessous la vue réelle)
--
CREATE TABLE `placedispopassager` (
`id_travers` int(11)
,`PlaceDispo` double
);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `placedispovéhiculeinf2m`
-- (Voir ci-dessous la vue réelle)
--
CREATE TABLE `placedispovéhiculeinf2m` (
`id_travers` int(11)
,`PlaceDispo` double
);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `placedispovéhiculesup2m`
-- (Voir ci-dessous la vue réelle)
--
CREATE TABLE `placedispovéhiculesup2m` (
`id_travers` int(11)
,`PlaceDispo` double
);

-- --------------------------------------------------------

--
-- Structure de la table `port`
--

CREATE TABLE `port` (
  `id_port` int(11) NOT NULL,
  `nom_port` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `port`
--

INSERT INTO `port` (`id_port`, `nom_port`) VALUES
(1, 'Quiberon'),
(2, 'Le Palais'),
(3, 'Sauzon'),
(4, 'Vannes'),
(5, 'Port St Gildas'),
(6, 'Lorient'),
(7, 'Port-Tudy');

-- --------------------------------------------------------

--
-- Structure de la table `période`
--

CREATE TABLE `période` (
  `date_debut` date NOT NULL,
  `date_fin` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `période`
--

INSERT INTO `période` (`date_debut`, `date_fin`) VALUES
('2023-09-01', '2024-06-15'),
('2024-06-16', '2024-09-15'),
('2024-09-16', '2025-05-31');

-- --------------------------------------------------------

--
-- Structure de la table `reservation`
--

CREATE TABLE `reservation` (
  `id_resa` int(11) NOT NULL,
  `date_resa` date DEFAULT NULL,
  `id_travers` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `reservation`
--

INSERT INTO `reservation` (`id_resa`, `date_resa`, `id_travers`) VALUES
(1, '2025-03-13', 33),
(2, '2025-03-13', 2),
(3, '2025-03-13', 18);

-- --------------------------------------------------------

--
-- Structure de la table `secteur`
--

CREATE TABLE `secteur` (
  `id_secteur` int(11) NOT NULL,
  `nom_secteur` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `secteur`
--

INSERT INTO `secteur` (`id_secteur`, `nom_secteur`) VALUES
(1, 'Belle-Ile-en-Mer'),
(2, 'Houat'),
(3, 'Ile de Groix');

-- --------------------------------------------------------

--
-- Structure de la table `tarifer`
--

CREATE TABLE `tarifer` (
  `id_liaison` int(11) NOT NULL,
  `id_type` int(11) NOT NULL,
  `date_debut` date NOT NULL,
  `Tarif` decimal(5,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `tarifer`
--

INSERT INTO `tarifer` (`id_liaison`, `id_type`, `date_debut`, `Tarif`) VALUES
(1, 1, '2024-09-16', 20.00),
(1, 2, '2024-09-16', 13.10),
(1, 3, '2024-09-16', 7.00),
(1, 4, '2024-09-16', 95.00),
(1, 5, '2024-09-16', 142.00),
(1, 6, '2024-09-16', 208.00),
(1, 7, '2024-09-16', 226.00),
(1, 8, '2024-09-16', 295.00),
(2, 1, '2024-09-16', 25.00),
(2, 2, '2024-09-16', 18.10),
(2, 3, '2024-09-16', 12.00),
(2, 4, '2024-09-16', 100.00),
(2, 5, '2024-09-16', 147.00),
(2, 6, '2024-09-16', 213.00),
(2, 7, '2024-09-16', 231.00),
(2, 8, '2024-09-16', 300.00),
(3, 1, '2024-09-16', 17.00),
(3, 2, '2024-09-16', 16.00),
(3, 3, '2024-09-16', 10.00),
(3, 4, '2024-09-16', 90.00),
(3, 5, '2024-09-16', 143.00),
(3, 6, '2024-09-16', 210.00),
(3, 7, '2024-09-16', 215.00),
(3, 8, '2024-09-16', 285.00),
(4, 1, '2024-09-16', 25.00),
(4, 2, '2024-09-16', 18.10),
(4, 3, '2024-09-16', 12.00),
(4, 4, '2024-09-16', 100.00),
(4, 5, '2024-09-16', 147.00),
(4, 6, '2024-09-16', 213.00),
(4, 7, '2024-09-16', 231.00),
(4, 8, '2024-09-16', 300.00),
(5, 1, '2024-09-16', 17.00),
(5, 2, '2024-09-16', 11.00),
(5, 3, '2024-09-16', 3.00),
(5, 4, '2024-09-16', 80.00),
(5, 5, '2024-09-16', 120.00),
(5, 6, '2024-09-16', 200.00),
(5, 7, '2024-09-16', 223.00),
(5, 8, '2024-09-16', 275.00),
(6, 1, '2024-09-16', 17.00),
(6, 2, '2024-09-16', 11.00),
(6, 3, '2024-09-16', 3.00),
(6, 4, '2024-09-16', 80.00),
(6, 5, '2024-09-16', 120.00),
(6, 6, '2024-09-16', 200.00),
(6, 7, '2024-09-16', 223.00),
(6, 8, '2024-09-16', 275.00),
(7, 1, '2024-09-16', 17.00),
(7, 2, '2024-09-16', 11.00),
(7, 3, '2024-09-16', 3.00),
(7, 4, '2024-09-16', 80.00),
(7, 5, '2024-09-16', 120.00),
(7, 6, '2024-09-16', 200.00),
(7, 7, '2024-09-16', 223.00),
(7, 8, '2024-09-16', 275.00);

-- --------------------------------------------------------

--
-- Structure de la table `traversée`
--

CREATE TABLE `traversée` (
  `id_travers` int(11) NOT NULL,
  `date_travers` date DEFAULT NULL,
  `heure_travers` time DEFAULT NULL,
  `desc_travers` varchar(50) NOT NULL,
  `id_bateau` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `traversée`
--

INSERT INTO `traversée` (`id_travers`, `date_travers`, `heure_travers`, `desc_travers`, `id_bateau`) VALUES
(2, '2025-12-05', '07:45:00', 'Quiberon-Le Palais', 1),
(3, '2025-12-06', '09:15:00', 'Quiberon-Le Palais', 1),
(4, '2019-07-10', '10:50:00', 'Quiberon-Le Palais', 1),
(5, '2019-07-10', '12:15:00', 'Quiberon-Le Palais', 1),
(6, '2019-07-10', '14:30:00', 'Quiberon-Le Palais', 1),
(7, '2019-07-10', '16:45:00', 'Quiberon-Le Palais', 1),
(8, '2019-07-10', '18:15:00', 'Quiberon-Le Palais', 1),
(9, '2019-07-10', '19:45:00', 'Quiberon-Le Palais', 1),
(10, '2019-07-10', '07:00:00', 'Le Palais-Quiberon', 1),
(12, '2019-07-10', '10:00:00', 'Le Palais-Quiberon', 1),
(13, '2019-07-10', '11:30:00', 'Le Palais-Quiberon', 1),
(14, '2019-07-10', '13:45:00', 'Le Palais-Quiberon', 1),
(15, '2019-07-10', '15:15:00', 'Le Palais-Quiberon', 1),
(16, '2019-07-10', '17:30:00', 'Le Palais-Quiberon', 1),
(17, '2019-07-10', '19:00:00', 'Le Palais-Quiberon', 1),
(18, '2019-07-10', '08:30:00', 'Vannes-Le Palais', 2),
(19, '2019-07-10', '11:30:00', 'Vannes-Le Palais', 2),
(20, '2019-07-10', '14:00:00', 'Vannes-Le Palais', 2),
(21, '2019-07-10', '17:00:00', 'Vannes-Le Palais', 2),
(22, '2019-07-10', '19:00:00', 'Vannes-Le Palais', 2),
(23, '2019-07-10', '10:00:00', 'Le Palais-Vannes', 2),
(24, '2019-07-10', '13:00:00', 'Le Palais-Vannes', 2),
(25, '2019-07-10', '15:30:00', 'Le Palais-Vannes', 2),
(26, '2019-07-10', '19:30:00', 'Le Palais-Vannes', 2),
(27, '2019-07-10', '21:30:00', 'Le Palais-Vannes', 2),
(28, '2025-08-15', '10:54:03', 'Quiberon-Sauzon', 2),
(29, '2025-08-15', '10:54:03', 'Sauzon-Quiberon', 2),
(30, '2025-08-16', '10:54:03', 'Giberon-PortStGildas', 1),
(31, '2025-08-16', '10:54:03', 'PortStGildas-Giberon', 2),
(32, '2025-08-17', '10:54:03', 'Lorient-PortTudy', 2),
(33, '2025-08-17', '10:54:03', 'PortTudy-Lorient', 1);

-- --------------------------------------------------------

--
-- Structure de la table `type`
--

CREATE TABLE `type` (
  `id_type` int(11) NOT NULL,
  `desc_type` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `type`
--

INSERT INTO `type` (`id_type`, `desc_type`) VALUES
(1, 'Adulte'),
(2, 'Junior 8 à 18 ans'),
(3, 'Enfant 0 à 7'),
(4, 'Voiture long.inf.4m'),
(5, 'Voiture long.inf.5m'),
(6, 'Fourgon'),
(7, 'Camping Car'),
(8, 'Camion');

-- --------------------------------------------------------

--
-- Structure de la table `utilisateur`
--

CREATE TABLE `utilisateur` (
  `id_utilisateur` int(11) NOT NULL,
  `nom_user` varchar(50) DEFAULT NULL,
  `prenom_user` varchar(50) DEFAULT NULL,
  `mail_user` varchar(50) DEFAULT NULL,
  `mdp_user` varchar(200) DEFAULT NULL,
  `typer_user` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `utilisateur`
--

INSERT INTO `utilisateur` (`id_utilisateur`, `nom_user`, `prenom_user`, `mail_user`, `mdp_user`, `typer_user`) VALUES
(11, 'Marieteam', 'Admin', 'admin.marieteam@gmail.com', '$2y$12$R6sAeZHb8x18IARIK/qvcOmq5Z9xLyh.GujnpVns3FIuAtO/kXY2S', 'Gestionnaire'),
(12, 'Benault', 'Lucas', 'lucas.benault@gmail.com', '$2y$12$yDMhFiPtgr5NqUe0NJAEEeMZNsnKSGw8PXGNtvDeJCV8nd/b.8bZy', 'Client'),
(13, 'Verdon', 'Axel', 'axel.verdon@gmail.com', '$2y$12$xqn.cBypssUxd9PzhWWyNeNN9rgGRCb1hrV3nuRZfRtezyP4uPbU.', 'Client'),
(14, 'Capitaine', 'numeroUN', 'capitaine.1@gmail.com', '$2y$12$iiY.oCGoH7BBTW6QafZ2Z.wlaj8J2.3fKlq.qJ3fR4EClSW7EhUGS', 'Capitaine'),
(15, 'axel', 'verdon', 'axel.verdon@worldline.com', '$2y$12$rlFExkWzrBYgZh9R6SlA9eRuEA7m1PADj0r/0gg6YWN6dTMPfBbnS', 'Client');

-- --------------------------------------------------------

--
-- Structure de la table `être_équipé`
--

CREATE TABLE `être_équipé` (
  `id_bateau` int(11) NOT NULL,
  `id_equip` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `être_équipé`
--

INSERT INTO `être_équipé` (`id_bateau`, `id_equip`) VALUES
(1, 1),
(1, 2),
(2, 1),
(2, 2),
(2, 3),
(2, 4);

-- --------------------------------------------------------

--
-- Structure de la vue `nbpassagerresa`
--
DROP TABLE IF EXISTS `nbpassagerresa`;

CREATE ALGORITHM=UNDEFINED DEFINER=`marieteam`@`localhost` SQL SECURITY DEFINER VIEW `nbpassagerresa`  AS SELECT `t`.`id_travers` AS `id_travers`, coalesce(sum(`e`.`quantité`),0) AS `NbPersonneResa` FROM ((`traversée` `t` left join `reservation` `r` on(`t`.`id_travers` = `r`.`id_travers`)) left join `enregistrer` `e` on(`r`.`id_resa` = `e`.`id_resa` and `e`.`id_type` in (1,2,3))) WHERE `t`.`date_travers` > curdate() GROUP BY `t`.`id_travers` ;

-- --------------------------------------------------------

--
-- Structure de la vue `nbréssavertion`
--
DROP TABLE IF EXISTS `nbréssavertion`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `nbréssavertion`  AS SELECT `t`.`id_travers` AS `id_travers`, coalesce(sum(case when `e`.`id_type` in (1,2,3) then `e`.`quantité` end),0) AS `NbPersonneResa`, coalesce(sum(case when `e`.`id_type` in (4,5) then `e`.`quantité` end),0) AS `NbVehiculeInf2mResa`, coalesce(sum(case when `e`.`id_type` in (6,7,8) then `e`.`quantité` end),0) AS `NbVehiculeSup2mResa` FROM ((`traversée` `t` left join `reservation` `r` on(`t`.`id_travers` = `r`.`id_travers`)) left join `enregistrer` `e` on(`r`.`id_resa` = `e`.`id_resa`)) WHERE `t`.`date_travers` > curdate() GROUP BY `t`.`id_travers` ;

-- --------------------------------------------------------

--
-- Structure de la vue `nbvéhiculeinf2mresa`
--
DROP TABLE IF EXISTS `nbvéhiculeinf2mresa`;

CREATE ALGORITHM=UNDEFINED DEFINER=`marieteam`@`localhost` SQL SECURITY DEFINER VIEW `nbvéhiculeinf2mresa`  AS SELECT `t`.`id_travers` AS `id_travers`, coalesce(sum(`e`.`quantité`),0) AS `NbVéhiculeResa` FROM ((`traversée` `t` left join `reservation` `r` on(`t`.`id_travers` = `r`.`id_travers`)) left join `enregistrer` `e` on(`r`.`id_resa` = `e`.`id_resa` and `e`.`id_type` in (4,5))) WHERE `t`.`date_travers` > curdate() GROUP BY `t`.`id_travers` ;

-- --------------------------------------------------------

--
-- Structure de la vue `nbvéhiculesup2mresa`
--
DROP TABLE IF EXISTS `nbvéhiculesup2mresa`;

CREATE ALGORITHM=UNDEFINED DEFINER=`marieteam`@`localhost` SQL SECURITY DEFINER VIEW `nbvéhiculesup2mresa`  AS SELECT `t`.`id_travers` AS `id_travers`, coalesce(sum(`e`.`quantité`),0) AS `NbVéhiculeResa` FROM ((`traversée` `t` left join `reservation` `r` on(`t`.`id_travers` = `r`.`id_travers`)) left join `enregistrer` `e` on(`r`.`id_resa` = `e`.`id_resa` and `e`.`id_type` in (6,7,8))) WHERE `t`.`date_travers` > curdate() GROUP BY `t`.`id_travers` ;

-- --------------------------------------------------------

--
-- Structure de la vue `placedispopassager`
--
DROP TABLE IF EXISTS `placedispopassager`;

CREATE ALGORITHM=UNDEFINED DEFINER=`marieteam`@`localhost` SQL SECURITY DEFINER VIEW `placedispopassager`  AS SELECT `traversée`.`id_travers` AS `id_travers`, `contenir`.`capac_bateau_pass`- `nbpassagerresa`.`NbPersonneResa` AS `PlaceDispo` FROM (((`nbpassagerresa` join `traversée` on(`nbpassagerresa`.`id_travers` = `traversée`.`id_travers`)) join `bateau` on(`traversée`.`id_bateau` = `bateau`.`id_bateau`)) join `contenir` on(`bateau`.`id_bateau` = `contenir`.`id_bateau`)) WHERE `contenir`.`id_cat` = 1 ;

-- --------------------------------------------------------

--
-- Structure de la vue `placedispovéhiculeinf2m`
--
DROP TABLE IF EXISTS `placedispovéhiculeinf2m`;

CREATE ALGORITHM=UNDEFINED DEFINER=`marieteam`@`localhost` SQL SECURITY DEFINER VIEW `placedispovéhiculeinf2m`  AS SELECT `traversée`.`id_travers` AS `id_travers`, `contenir`.`capac_bateau_pass`- `nbvéhiculeinf2mresa`.`NbVéhiculeResa` AS `PlaceDispo` FROM (((`nbvéhiculeinf2mresa` join `traversée` on(`nbvéhiculeinf2mresa`.`id_travers` = `traversée`.`id_travers`)) join `bateau` on(`traversée`.`id_bateau` = `bateau`.`id_bateau`)) join `contenir` on(`bateau`.`id_bateau` = `contenir`.`id_bateau`)) WHERE `contenir`.`id_cat` = 2 ;

-- --------------------------------------------------------

--
-- Structure de la vue `placedispovéhiculesup2m`
--
DROP TABLE IF EXISTS `placedispovéhiculesup2m`;

CREATE ALGORITHM=UNDEFINED DEFINER=`marieteam`@`localhost` SQL SECURITY DEFINER VIEW `placedispovéhiculesup2m`  AS SELECT `traversée`.`id_travers` AS `id_travers`, `contenir`.`capac_bateau_pass`- `nbvéhiculesup2mresa`.`NbVéhiculeResa` AS `PlaceDispo` FROM (((`nbvéhiculesup2mresa` join `traversée` on(`nbvéhiculesup2mresa`.`id_travers` = `traversée`.`id_travers`)) join `bateau` on(`traversée`.`id_bateau` = `bateau`.`id_bateau`)) join `contenir` on(`bateau`.`id_bateau` = `contenir`.`id_bateau`)) WHERE `contenir`.`id_cat` = 3 ;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `bateau`
--
ALTER TABLE `bateau`
  ADD PRIMARY KEY (`id_bateau`);

--
-- Index pour la table `catégorie`
--
ALTER TABLE `catégorie`
  ADD PRIMARY KEY (`id_cat`);

--
-- Index pour la table `choisir`
--
ALTER TABLE `choisir`
  ADD PRIMARY KEY (`id_client`,`id_resa`),
  ADD KEY `id_resa` (`id_resa`);

--
-- Index pour la table `classer`
--
ALTER TABLE `classer`
  ADD PRIMARY KEY (`id_type`),
  ADD KEY `id_cat` (`id_cat`);

--
-- Index pour la table `client`
--
ALTER TABLE `client`
  ADD PRIMARY KEY (`id_client`),
  ADD UNIQUE KEY `id_utilisateur` (`id_utilisateur`);

--
-- Index pour la table `contenir`
--
ALTER TABLE `contenir`
  ADD PRIMARY KEY (`id_bateau`,`id_cat`),
  ADD KEY `id_cat` (`id_cat`);

--
-- Index pour la table `enregistrer`
--
ALTER TABLE `enregistrer`
  ADD PRIMARY KEY (`id_resa`,`id_type`),
  ADD KEY `id_type` (`id_type`);

--
-- Index pour la table `equipement`
--
ALTER TABLE `equipement`
  ADD PRIMARY KEY (`id_equip`);

--
-- Index pour la table `liaison`
--
ALTER TABLE `liaison`
  ADD PRIMARY KEY (`id_liaison`),
  ADD KEY `id_port` (`id_port`),
  ADD KEY `id_port_1` (`id_port_1`),
  ADD KEY `id_secteur` (`id_secteur`),
  ADD KEY `id_travers` (`id_travers`),
  ADD KEY `idx_liaison_secteur` (`id_secteur`);

--
-- Index pour la table `port`
--
ALTER TABLE `port`
  ADD PRIMARY KEY (`id_port`);

--
-- Index pour la table `période`
--
ALTER TABLE `période`
  ADD PRIMARY KEY (`date_debut`);

--
-- Index pour la table `reservation`
--
ALTER TABLE `reservation`
  ADD PRIMARY KEY (`id_resa`),
  ADD KEY `id_travers` (`id_travers`);

--
-- Index pour la table `secteur`
--
ALTER TABLE `secteur`
  ADD PRIMARY KEY (`id_secteur`),
  ADD KEY `idx_nom_secteur` (`nom_secteur`);

--
-- Index pour la table `tarifer`
--
ALTER TABLE `tarifer`
  ADD PRIMARY KEY (`id_liaison`,`id_type`,`date_debut`),
  ADD KEY `id_type` (`id_type`),
  ADD KEY `date_debut` (`date_debut`);

--
-- Index pour la table `traversée`
--
ALTER TABLE `traversée`
  ADD PRIMARY KEY (`id_travers`),
  ADD KEY `id_bateau` (`id_bateau`),
  ADD KEY `idx_traversee` (`id_travers`);

--
-- Index pour la table `type`
--
ALTER TABLE `type`
  ADD PRIMARY KEY (`id_type`);

--
-- Index pour la table `utilisateur`
--
ALTER TABLE `utilisateur`
  ADD PRIMARY KEY (`id_utilisateur`);

--
-- Index pour la table `être_équipé`
--
ALTER TABLE `être_équipé`
  ADD PRIMARY KEY (`id_bateau`,`id_equip`),
  ADD KEY `id_equip` (`id_equip`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `bateau`
--
ALTER TABLE `bateau`
  MODIFY `id_bateau` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `catégorie`
--
ALTER TABLE `catégorie`
  MODIFY `id_cat` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `client`
--
ALTER TABLE `client`
  MODIFY `id_client` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `equipement`
--
ALTER TABLE `equipement`
  MODIFY `id_equip` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `liaison`
--
ALTER TABLE `liaison`
  MODIFY `id_liaison` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT pour la table `port`
--
ALTER TABLE `port`
  MODIFY `id_port` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT pour la table `reservation`
--
ALTER TABLE `reservation`
  MODIFY `id_resa` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `secteur`
--
ALTER TABLE `secteur`
  MODIFY `id_secteur` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `traversée`
--
ALTER TABLE `traversée`
  MODIFY `id_travers` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT pour la table `type`
--
ALTER TABLE `type`
  MODIFY `id_type` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT pour la table `utilisateur`
--
ALTER TABLE `utilisateur`
  MODIFY `id_utilisateur` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `choisir`
--
ALTER TABLE `choisir`
  ADD CONSTRAINT `choisir_ibfk_1` FOREIGN KEY (`id_client`) REFERENCES `client` (`id_client`),
  ADD CONSTRAINT `choisir_ibfk_2` FOREIGN KEY (`id_resa`) REFERENCES `reservation` (`id_resa`);

--
-- Contraintes pour la table `classer`
--
ALTER TABLE `classer`
  ADD CONSTRAINT `classer_ibfk_1` FOREIGN KEY (`id_type`) REFERENCES `type` (`id_type`),
  ADD CONSTRAINT `classer_ibfk_2` FOREIGN KEY (`id_cat`) REFERENCES `catégorie` (`id_cat`);

--
-- Contraintes pour la table `client`
--
ALTER TABLE `client`
  ADD CONSTRAINT `client_ibfk_1` FOREIGN KEY (`id_utilisateur`) REFERENCES `utilisateur` (`id_utilisateur`);

--
-- Contraintes pour la table `contenir`
--
ALTER TABLE `contenir`
  ADD CONSTRAINT `contenir_ibfk_1` FOREIGN KEY (`id_bateau`) REFERENCES `bateau` (`id_bateau`),
  ADD CONSTRAINT `contenir_ibfk_2` FOREIGN KEY (`id_cat`) REFERENCES `catégorie` (`id_cat`);

--
-- Contraintes pour la table `enregistrer`
--
ALTER TABLE `enregistrer`
  ADD CONSTRAINT `enregistrer_ibfk_1` FOREIGN KEY (`id_resa`) REFERENCES `reservation` (`id_resa`),
  ADD CONSTRAINT `enregistrer_ibfk_2` FOREIGN KEY (`id_type`) REFERENCES `type` (`id_type`);

--
-- Contraintes pour la table `liaison`
--
ALTER TABLE `liaison`
  ADD CONSTRAINT `liaison_ibfk_1` FOREIGN KEY (`id_port`) REFERENCES `port` (`id_port`),
  ADD CONSTRAINT `liaison_ibfk_2` FOREIGN KEY (`id_port_1`) REFERENCES `port` (`id_port`),
  ADD CONSTRAINT `liaison_ibfk_3` FOREIGN KEY (`id_secteur`) REFERENCES `secteur` (`id_secteur`),
  ADD CONSTRAINT `liaison_ibfk_4` FOREIGN KEY (`id_travers`) REFERENCES `traversée` (`id_travers`);

--
-- Contraintes pour la table `reservation`
--
ALTER TABLE `reservation`
  ADD CONSTRAINT `reservation_ibfk_1` FOREIGN KEY (`id_travers`) REFERENCES `traversée` (`id_travers`);

--
-- Contraintes pour la table `tarifer`
--
ALTER TABLE `tarifer`
  ADD CONSTRAINT `tarifer_ibfk_1` FOREIGN KEY (`id_liaison`) REFERENCES `liaison` (`id_liaison`),
  ADD CONSTRAINT `tarifer_ibfk_2` FOREIGN KEY (`id_type`) REFERENCES `type` (`id_type`),
  ADD CONSTRAINT `tarifer_ibfk_3` FOREIGN KEY (`date_debut`) REFERENCES `période` (`date_debut`);

--
-- Contraintes pour la table `traversée`
--
ALTER TABLE `traversée`
  ADD CONSTRAINT `traversée_ibfk_1` FOREIGN KEY (`id_bateau`) REFERENCES `bateau` (`id_bateau`);

--
-- Contraintes pour la table `être_équipé`
--
ALTER TABLE `être_équipé`
  ADD CONSTRAINT `être_équipé_ibfk_1` FOREIGN KEY (`id_bateau`) REFERENCES `bateau` (`id_bateau`),
  ADD CONSTRAINT `être_équipé_ibfk_2` FOREIGN KEY (`id_equip`) REFERENCES `equipement` (`id_equip`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
