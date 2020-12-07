-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost
-- Généré le :  lun. 07 déc. 2020 à 16:56
-- Version du serveur :  8.0.18
-- Version de PHP :  7.3.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `joueurs`
--

-- --------------------------------------------------------

--
-- Structure de la table `agents`
--

CREATE TABLE `agents` (
  `Id` int(11) NOT NULL,
  `prenom` varchar(45) NOT NULL,
  `nom` varchar(45) NOT NULL,
  `telephone` varchar(15) NOT NULL,
  `email` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `agents`
--

INSERT INTO `agents` (`Id`, `prenom`, `nom`, `telephone`, `email`) VALUES
(1, 'Pat', 'Brisson', '819-774-4154', 'patbris54@gmail.com');

-- --------------------------------------------------------

--
-- Structure de la table `compagnies`
--

CREATE TABLE `compagnies` (
  `id` int(11) NOT NULL,
  `nom` varchar(45) NOT NULL,
  `anneeinnoguration` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `compagnies`
--

INSERT INTO `compagnies` (`id`, `nom`, `anneeinnoguration`) VALUES
(1, 'Gatorade', '1965-07-09'),
(2, 'Reebok', '1989-05-26');

--
-- Déclencheurs `compagnies`
--
DELIMITER $$
CREATE TRIGGER `faillite` AFTER DELETE ON `compagnies` FOR EACH ROW BEGIN
	delete from signatures
    where signatures.id = 1;
    
    delete from contratspubicitaires
    where contratspubicitaires.compagnies_id = old.compagnies.id;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `contrats`
--

CREATE TABLE `contrats` (
  `id` int(11) NOT NULL,
  `salaire` varchar(100) NOT NULL,
  `nombre_annees` int(11) NOT NULL,
  `equipes_id` int(11) NOT NULL,
  `signature_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `contrats`
--

INSERT INTO `contrats` (`id`, `salaire`, `nombre_annees`, `equipes_id`, `signature_id`) VALUES
(1, '10 millions', 6, 1, 2);

-- --------------------------------------------------------

--
-- Structure de la table `contratspubicitaires`
--

CREATE TABLE `contratspubicitaires` (
  `id` int(11) NOT NULL,
  `salaire` varchar(45) NOT NULL,
  `annees` int(11) NOT NULL,
  `compagnies_id` int(11) NOT NULL,
  `signatures_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `contratspubicitaires`
--

INSERT INTO `contratspubicitaires` (`id`, `salaire`, `annees`, `compagnies_id`, `signatures_id`) VALUES
(1, '5 million', 15, 2, 1);

-- --------------------------------------------------------

--
-- Structure de la table `directeurs_generaux`
--

CREATE TABLE `directeurs_generaux` (
  `id` int(11) NOT NULL,
  `nom` varchar(45) NOT NULL,
  `prenom` varchar(45) NOT NULL,
  `actif` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `directeurs_generaux`
--

INSERT INTO `directeurs_generaux` (`id`, `nom`, `prenom`, `actif`) VALUES
(1, 'Bergevin', 'Marc', 1);

-- --------------------------------------------------------

--
-- Structure de la table `equipes`
--

CREATE TABLE `equipes` (
  `id` int(11) NOT NULL,
  `nom` varchar(45) NOT NULL,
  `ville` varchar(45) NOT NULL,
  `annee_creation` date NOT NULL,
  `directeurs_generaux_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `equipes`
--

INSERT INTO `equipes` (`id`, `nom`, `ville`, `annee_creation`, `directeurs_generaux_id`) VALUES
(1, 'Canadiens', 'Montréal', '1909-01-01', 1);

-- --------------------------------------------------------

--
-- Structure de la table `joueurs`
--

CREATE TABLE `joueurs` (
  `id` int(11) NOT NULL,
  `nom` varchar(45) NOT NULL,
  `prenom` varchar(100) NOT NULL,
  `actif` tinyint(4) NOT NULL,
  `agents_Id` int(11) NOT NULL,
  `postes_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `joueurs`
--

INSERT INTO `joueurs` (`id`, `nom`, `prenom`, `actif`, `agents_Id`, `postes_id`) VALUES
(1, 'McDavid', 'Connor', 1, 1, 1),
(2, 'Lapierre', 'Maxim', 1, 1, 1),
(3, 'Price', 'Carey', 1, 1, 6),
(4, 'Sande', 'Joel', 1, 1, 3);

-- --------------------------------------------------------

--
-- Structure de la table `personnels`
--

CREATE TABLE `personnels` (
  `id` int(11) NOT NULL,
  `nom` varchar(45) NOT NULL,
  `prenom` varchar(45) NOT NULL,
  `actif` varchar(45) NOT NULL,
  `postes_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `personnels`
--

INSERT INTO `personnels` (`id`, `nom`, `prenom`, `actif`, `postes_id`) VALUES
(1, 'Julien', 'Claude', '1', 7);

-- --------------------------------------------------------

--
-- Structure de la table `postes`
--

CREATE TABLE `postes` (
  `id` int(11) NOT NULL,
  `poste` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `postes`
--

INSERT INTO `postes` (`id`, `poste`) VALUES
(1, 'centre'),
(2, 'ailier gauche'),
(3, 'ailier droite'),
(4, 'defenseur gauche'),
(5, 'defenseur droite'),
(6, 'gardien de but'),
(7, 'entraineur');

-- --------------------------------------------------------

--
-- Structure de la table `signatures`
--

CREATE TABLE `signatures` (
  `id` int(11) NOT NULL,
  `date` date NOT NULL,
  `joueurs_id` int(11) DEFAULT NULL,
  `personnels_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `signatures`
--

INSERT INTO `signatures` (`id`, `date`, `joueurs_id`, `personnels_id`) VALUES
(1, '2020-12-07', 1, NULL),
(2, '2020-12-07', 3, NULL);

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `agents`
--
ALTER TABLE `agents`
  ADD PRIMARY KEY (`Id`);

--
-- Index pour la table `compagnies`
--
ALTER TABLE `compagnies`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `contrats`
--
ALTER TABLE `contrats`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_contrats_equipes1_idx` (`equipes_id`),
  ADD KEY `fk_contrats_signature1_idx` (`signature_id`);

--
-- Index pour la table `contratspubicitaires`
--
ALTER TABLE `contratspubicitaires`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_contratspubicitaires_compagnies1_idx` (`compagnies_id`),
  ADD KEY `fk_contratspubicitaires_signatures1_idx` (`signatures_id`);

--
-- Index pour la table `directeurs_generaux`
--
ALTER TABLE `directeurs_generaux`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `equipes`
--
ALTER TABLE `equipes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_equipes_directeurs_generaux1_idx` (`directeurs_generaux_id`);

--
-- Index pour la table `joueurs`
--
ALTER TABLE `joueurs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_joueurs_agents_idx` (`agents_Id`),
  ADD KEY `fk_joueurs_postes1_idx` (`postes_id`);

--
-- Index pour la table `personnels`
--
ALTER TABLE `personnels`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_personnels_postes1_idx` (`postes_id`);

--
-- Index pour la table `postes`
--
ALTER TABLE `postes`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `signatures`
--
ALTER TABLE `signatures`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_signatures_joueurs1_idx` (`joueurs_id`),
  ADD KEY `fk_signatures_personnels1_idx` (`personnels_id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `agents`
--
ALTER TABLE `agents`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `compagnies`
--
ALTER TABLE `compagnies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `contrats`
--
ALTER TABLE `contrats`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `contratspubicitaires`
--
ALTER TABLE `contratspubicitaires`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `directeurs_generaux`
--
ALTER TABLE `directeurs_generaux`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `equipes`
--
ALTER TABLE `equipes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `joueurs`
--
ALTER TABLE `joueurs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `personnels`
--
ALTER TABLE `personnels`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `postes`
--
ALTER TABLE `postes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT pour la table `signatures`
--
ALTER TABLE `signatures`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `contrats`
--
ALTER TABLE `contrats`
  ADD CONSTRAINT `fk_contrats_equipes1` FOREIGN KEY (`equipes_id`) REFERENCES `equipes` (`id`),
  ADD CONSTRAINT `fk_contrats_signature1` FOREIGN KEY (`signature_id`) REFERENCES `signatures` (`id`);

--
-- Contraintes pour la table `contratspubicitaires`
--
ALTER TABLE `contratspubicitaires`
  ADD CONSTRAINT `fk_contratspubicitaires_compagnies1` FOREIGN KEY (`compagnies_id`) REFERENCES `compagnies` (`id`),
  ADD CONSTRAINT `fk_contratspubicitaires_signatures1` FOREIGN KEY (`signatures_id`) REFERENCES `signatures` (`id`);

--
-- Contraintes pour la table `equipes`
--
ALTER TABLE `equipes`
  ADD CONSTRAINT `fk_equipes_directeurs_generaux1` FOREIGN KEY (`directeurs_generaux_id`) REFERENCES `directeurs_generaux` (`id`);

--
-- Contraintes pour la table `joueurs`
--
ALTER TABLE `joueurs`
  ADD CONSTRAINT `fk_joueurs_agents` FOREIGN KEY (`agents_Id`) REFERENCES `agents` (`Id`),
  ADD CONSTRAINT `fk_joueurs_postes1` FOREIGN KEY (`postes_id`) REFERENCES `postes` (`id`);

--
-- Contraintes pour la table `personnels`
--
ALTER TABLE `personnels`
  ADD CONSTRAINT `fk_personnels_postes1` FOREIGN KEY (`postes_id`) REFERENCES `postes` (`id`);

--
-- Contraintes pour la table `signatures`
--
ALTER TABLE `signatures`
  ADD CONSTRAINT `fk_signatures_joueurs1` FOREIGN KEY (`joueurs_id`) REFERENCES `joueurs` (`id`),
  ADD CONSTRAINT `fk_signatures_personnels1` FOREIGN KEY (`personnels_id`) REFERENCES `personnels` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
