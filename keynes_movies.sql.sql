-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3308
-- Généré le : jeu. 26 mars 2026 à 13:40
-- Version du serveur : 8.4.7
-- Version de PHP : 8.3.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

DROP TABLE IF EXISTS `achats`;
CREATE TABLE IF NOT EXISTS `achats` (
  `id` int NOT NULL AUTO_INCREMENT,
  `utilisateur_id` int NOT NULL,
  `film_id` int NOT NULL,
  `date_achat` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `utilisateur_id` (`utilisateur_id`),
  KEY `film_id` (`film_id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


INSERT INTO `achats` (`id`, `utilisateur_id`, `film_id`, `date_achat`) VALUES
(1, 3, 19, '2026-03-23 13:34:16'),
(2, 3, 18, '2026-03-23 13:34:16'),
(3, 3, 33, '2026-03-23 16:09:11'),
(4, 3, 37, '2026-03-23 16:32:58'),
(5, 3, 93, '2026-03-25 15:08:01');


DROP TABLE IF EXISTS `films`;
CREATE TABLE IF NOT EXISTS `films` (
  `id` int NOT NULL AUTO_INCREMENT,
  `titre` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `realisateur` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `acteurs` text COLLATE utf8mb4_unicode_ci,
  `prix` decimal(10,2) NOT NULL,
  `image` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `categorie` enum('action','drame','comedie','amour','aventure','horreur') COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_ajout` datetime DEFAULT CURRENT_TIMESTAMP,
  `bande_annonce` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_sortie` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `note` decimal(2,1) DEFAULT NULL,
  `duree` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=94 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


INSERT INTO `films` (`id`, `titre`, `description`, `realisateur`, `acteurs`, `prix`, `image`, `categorie`, `date_ajout`, `bande_annonce`, `date_sortie`, `note`, `duree`) VALUES
(1, 'Inception', 'Un voleur qui vole des secrets à travers les rêves', 'Christopher Nolan', 'Leonardo DiCaprio, Joseph Gordon-Levitt', 12.99, 'https://m.media-amazon.com/images/M/MV5BMjAxMzY3NjcxNF5BMl5BanBnXkFtZTcwNTI5OTM0Mw@@._V1_SX300.jpg', 'action', '2026-03-23 11:41:55', 'https://www.youtube.com/embed/YoHD9XEInc0', '2010-07-16', 8.8, 148),
(2, 'John Wick', 'Un tueur à la retraite reprend du service', 'Chad Stahelski', 'Keanu Reeves, Michael Nyqvist', 9.99, 'https://m.media-amazon.com/images/M/MV5BMTU2NjA1ODgzMF5BMl5BanBnXkFtZTgwMTM2MTI4MjE@._V1_SX300.jpg', 'action', '2026-03-23 11:41:55', 'https://www.youtube.com/embed/2AUmvWm5ZDQ', '2014-10-24', 7.4, 101),
(3, 'The Dark Knight', 'Batman contre le Joker', 'Christopher Nolan', 'Christian Bale, Heath Ledger', 13.99, 'https://m.media-amazon.com/images/M/MV5BMTMxNTMwODM0NF5BMl5BanBnXkFtZTcwODAyMTk2Mw@@._V1_SX300.jpg', 'action', '2026-03-23 11:41:55', 'https://www.youtube.com/embed/EXeTwQWrcwY', '2008-07-18', 9.0, 152),
(4, 'Die Hard', 'Un policier contre des terroristes', 'John McTiernan', 'Bruce Willis, Alan Rickman', 8.99, 'https://m.media-amazon.com/images/M/MV5BMGNlYmM1NmQtYWExMS00NmRjLTg5ZmEtMmYyYzJkMzljYWMxXkEyXkFqcGc@._V1_SX300.jpg', 'action', '2026-03-23 11:41:55', 'https://www.youtube.com/embed/jaJuwKCmJbY', '1988-07-20', 8.2, 132),
(5, 'Mad Max: Fury Road', 'Course poursuite dans un désert apocalyptique', 'George Miller', 'Tom Hardy, Charlize Theron', 11.99, 'https://m.media-amazon.com/images/M/MV5BZDRkODJhOTgtOTc1OC00NTgzLTk4NjItNDgxZDY4YjlmNDY2XkEyXkFqcGc@._V1_SX300.jpg', 'action', '2026-03-23 11:41:55', 'https://www.youtube.com/embed/hEJnMQG9ev8', '2015-05-15', 8.1, 120),
(6, 'Gladiator', 'Un général romain devenu gladiateur', 'Ridley Scott', 'Russell Crowe, Joaquin Phoenix', 10.99, 'https://m.media-amazon.com/images/M/MV5BYWQ4YmNjYjEtOWE1Zi00Y2U4LWI4NTAtMTU0MjkxNWQ1ZmJiXkEyXkFqcGc@._V1_SX300.jpg', 'action', '2026-03-23 11:41:55', 'https://www.youtube.com/embed/owK1qxDselE', '2000-05-05', 8.5, 155),
(7, 'Top Gun: Maverick', 'Pilote de chasse légendaire', 'Joseph Kosinski', 'Tom Cruise, Miles Teller', 14.99, 'https://m.media-amazon.com/images/M/MV5BMDBkZDNjMWEtOTdmMi00NmExLTg5MmMtNTFlYTJlNWY5YTdmXkEyXkFqcGc@._V1_SX300.jpg', 'action', '2026-03-23 11:41:55', 'https://www.youtube.com/embed/giXco2jaZ_4', '2022-05-27', 8.3, 130),
(8, 'Mission: Impossible', 'Agent secret en mission', 'Christopher McQuarrie', 'Tom Cruise, Henry Cavill', 12.99, 'https://m.media-amazon.com/images/M/MV5BMTY4MTUxMjQ5OV5BMl5BanBnXkFtZTcwNTUyMzg5Ng@@._V1_SX300.jpg', 'action', '2026-03-23 11:41:55', 'https://www.youtube.com/embed/d662RJYI2ZI', '2018-07-27', 7.7, 147),
(9, 'The Matrix', 'Un homme découvre la réalité virtuelle', 'Lana Wachowski', 'Keanu Reeves, Laurence Fishburne', 10.99, 'https://m.media-amazon.com/images/M/MV5BN2NmN2VhMTQtMDNiOS00NDlhLTliMjgtODE2ZTY0ODQyNDRhXkEyXkFqcGc@._V1_SX300.jpg', 'action', '2026-03-23 11:41:55', 'https://www.youtube.com/embed/vKQi3bBA1y8', '1999-03-31', 8.7, 136),
(10, 'Kill Bill: Vol. 1', 'Une tueuse se venge', 'Quentin Tarantino', 'Uma Thurman, Lucy Liu', 9.99, 'https://m.media-amazon.com/images/M/MV5BZmMyYzJlZmYtY2I3NC00NjAyLTkyZWItZjdjZDI1YTYyYTEwXkEyXkFqcGc@._V1_SX300.jpg', 'action', '2026-03-23 11:41:55', 'https://www.youtube.com/embed/7kSuas6mRpk', '2003-10-10', 8.2, 111),
(11, 'The Avengers', 'Des super-héros unissent leurs forces', 'Joss Whedon', 'Robert Downey Jr., Chris Evans', 13.99, 'https://m.media-amazon.com/images/M/MV5BNGE0YTVjNzUtNzJjOS00NGNlLTgxMzctZTY4YTE1Y2Y1ZTU4XkEyXkFqcGc@._V1_SX300.jpg', 'action', '2026-03-23 11:41:55', 'https://www.youtube.com/embed/eOrNdBpGMv8', '2012-05-04', 8.0, 143),
(12, 'Black Panther', 'Le roi du Wakanda', 'Ryan Coogler', 'Chadwick Boseman, Michael B. Jordan', 12.99, 'https://m.media-amazon.com/images/M/MV5BMTg1MTY2MjYzNV5BMl5BanBnXkFtZTgwMTc4NTMwNDI@._V1_SX300.jpg', 'action', '2026-03-23 11:41:55', 'https://www.youtube.com/embed/xjDjIWPwcPU', '2018-02-16', 7.3, 134),
(13, 'Fast & Furious', 'Des courses de rue spectaculaires', 'Justin Lin', 'Vin Diesel, Paul Walker', 11.99, 'https://m.media-amazon.com/images/M/MV5BM2Y1YzhkNzUtMzhmZC00OTFkLWJjZDktMWYzZmQ0Y2Y5ODcwXkEyXkFqcGc@._V1_SX300.jpg', 'action', '2026-03-23 11:41:55', 'https://www.youtube.com/embed/JwMKRevYa_M', '2015-04-03', 7.1, 137),
(14, 'Terminator 2', 'Un robot vient protéger le futur', 'James Cameron', 'Arnold Schwarzenegger, Linda Hamilton', 10.99, 'https://m.media-amazon.com/images/M/MV5BNGMyMGNkMDUtMjc2Ni00NWFlLTgyODEtZTY2MzBiZTg0OWZiXkEyXkFqcGc@._V1_SX300.jpg', 'action', '2026-03-23 11:41:55', 'https://www.youtube.com/embed/CRRlbK5w8AE', '1991-07-03', 8.6, 137),
(15, 'Captain America', 'Un super-soldat pendant la guerre', 'Joe Johnston', 'Chris Evans, Hugo Weaving', 12.99, 'https://m.media-amazon.com/images/M/MV5BZjAwNGM0NWUtNmIwZC00OGEzLWFjZGEtMWE5ZjJjM2ZjZThhXkEyXkFqcGc@._V1_SX300.jpg', 'action', '2026-03-23 11:41:55', 'https://www.youtube.com/embed/JerVrbLldXw', '2011-07-22', 6.9, 124),
(16, 'The Shawshank Redemption', 'Un banquier innocent en prison', 'Frank Darabont', 'Tim Robbins, Morgan Freeman', 12.99, 'https://m.media-amazon.com/images/M/MV5BMDAyY2FhYjctNDc5OS00MDNlLThiMGUtY2UxYWVkNGY2ZjljXkEyXkFqcGc@._V1_SX300.jpg', 'drame', '2026-03-23 11:41:56', 'https://www.youtube.com/embed/6hB3S9bIaco', '1994-10-14', 9.3, 142),
(17, 'Forrest Gump', 'La vie extraordinaire d\'un homme simple', 'Robert Zemeckis', 'Tom Hanks, Robin Wright', 10.99, 'https://m.media-amazon.com/images/M/MV5BNDYwNzVjMTItZmU5YS00YjQ5LTljYjgtMjY2NDVmYWMyNWFmXkEyXkFqcGc@._V1_SX300.jpg', 'drame', '2026-03-23 11:41:56', 'https://www.youtube.com/embed/bLvqoHBptjg', '1994-07-06', 8.8, 142),
(18, 'Green Book', 'Un pianiste noir et son chauffeur dans le sud', 'Peter Farrelly', 'Viggo Mortensen, Mahershala Ali', 11.99, 'https://m.media-amazon.com/images/M/MV5BNDU5YTNmMmItN2QxNy00OGQ0LTg5MTctNzFmYjEzZjcwN2UwXkEyXkFqcGc@._V1_SX300.jpg', 'drame', '2026-03-23 11:41:56', 'https://www.youtube.com/embed/QkZxoko_HC0', '2018-11-21', 8.2, 130),
(19, 'The Pursuit of Happyness', 'Un père sans abri se bat pour son fils', 'Gabriele Muccino', 'Will Smith, Jaden Smith', 9.99, 'https://m.media-amazon.com/images/M/MV5BMTQ5NjQ0NDI3NF5BMl5BanBnXkFtZTcwNDI0MjEzMw@@._V1_SX300.jpg', 'drame', '2026-03-23 11:41:56', 'https://www.youtube.com/embed/DMOBlEcRuw8', '2006-12-15', 8.0, 117),
(20, 'La Vie est Belle', 'Un père protège son fils des camps', 'Roberto Benigni', 'Roberto Benigni, Nicoletta Braschi', 10.99, 'https://m.media-amazon.com/images/M/MV5BNjBiNzVjMjUtY2MyOC00MzFlLWJmMmMtNzY5NWM4YzE4YjA3XkEyXkFqcGc@._V1_SX300.jpg', 'drame', '2026-03-23 11:41:56', 'https://www.youtube.com/embed/3d6DsjIBzJ4', '1997-12-20', 8.6, 116),
(21, 'The Godfather', 'Une famille mafieuse italo-américaine', 'Francis Ford Coppola', 'Marlon Brando, Al Pacino', 13.99, 'https://m.media-amazon.com/images/M/MV5BNGEwYjgwOGQtYjg5ZS00Njc1LTk2ZGEtM2QwZWQ2NjdhZTE5XkEyXkFqcGc@._V1_SX300.jpg', 'drame', '2026-03-23 11:41:56', 'https://www.youtube.com/embed/sY1S34973zA', '1972-03-24', 9.2, 175),
(22, 'Fight Club', 'Un homme crée un club de combat', 'David Fincher', 'Brad Pitt, Edward Norton', 11.99, 'https://m.media-amazon.com/images/M/MV5BOTgyOGQ1NDItNGU3Ny00MjU3LTg2YWEtNmEyYjBiMjI1Y2M5XkEyXkFqcGc@._V1_SX300.jpg', 'drame', '2026-03-23 11:41:56', 'https://www.youtube.com/embed/SUXWAEX2jlg', '1999-10-15', 8.8, 139),
(23, 'The Social Network', 'La création de Facebook', 'David Fincher', 'Jesse Eisenberg, Andrew Garfield', 10.99, 'https://m.media-amazon.com/images/M/MV5BMjlkNTE5ZTUtNGEwNy00MGVhLThmZjMtZjU1NDE5Zjk1NDZkXkEyXkFqcGc@._V1_SX300.jpg', 'drame', '2026-03-23 11:41:56', 'https://www.youtube.com/embed/lB95KLmpLR4', '2010-10-01', 7.7, 120),
(24, 'Joker', 'L\'histoire du célèbre ennemi de Batman', 'Todd Phillips', 'Joaquin Phoenix, Robert De Niro', 12.99, 'https://m.media-amazon.com/images/M/MV5BNzY3OWQ5NDktNWQ2OC00ZjdlLThkMmItMDhhNDk3NTFiZGU4XkEyXkFqcGc@._V1_SX300.jpg', 'drame', '2026-03-23 11:41:56', 'https://www.youtube.com/embed/zAGVQLHvwOY', '2019-10-04', 8.5, 122),
(25, 'The Whale', 'Un professeur en surpoids cherche à renouer avec sa fille', 'Darren Aronofsky', 'Brendan Fraser, Sadie Sink', 11.99, 'https://m.media-amazon.com/images/M/MV5BYmNhOWMyNTYtNTljNC00NTU3LWFiYmQtMDBhOGU5NWFhNGU5XkEyXkFqcGc@._V1_SX300.jpg', 'drame', '2026-03-23 11:41:56', 'https://www.youtube.com/embed/nWiQodhMvz4', '2022-12-09', 7.8, 117),
(26, 'Nomadland', 'Une femme voyage à travers l\'Ouest américain', 'Chloé Zhao', 'Frances McDormand, David Strathairn', 10.99, 'https://m.media-amazon.com/images/M/MV5BZGNkOWQ0ZjMtMTc4Ny00NDRhLTgyMjUtNzFmZDM0MTc3N2JjXkEyXkFqcGc@._V1_SX300.jpg', 'drame', '2026-03-23 11:41:56', 'https://www.youtube.com/embed/6sxCFZ8_d84', '2020-12-25', 7.4, 108),
(27, 'CODA', 'Une enfant de sourds-muets poursuit sa passion', 'Sian Heder', 'Emilia Jones, Marlee Matlin', 11.99, 'https://m.media-amazon.com/images/M/MV5BNzIzOTNjOTQtM2QzOC00NjFlLTljZDUtZmI4Yjg1YTkyMTBiXkEyXkFqcGc@._V1_SX300.jpg', 'drame', '2026-03-23 11:41:56', 'https://www.youtube.com/embed/0pmfrE1YL4I', '2021-08-13', 8.0, 111),
(28, 'Manchester by the Sea', 'Un homme doit s\'occuper de son neveu', 'Kenneth Lonergan', 'Casey Affleck, Michelle Williams', 9.99, 'https://m.media-amazon.com/images/M/MV5BMTYxMjk0NDg4Ml5BMl5BanBnXkFtZTgwODcyNjA5OTE@._V1_SX300.jpg', 'drame', '2026-03-23 11:41:56', 'https://www.youtube.com/embed/gsVoD0pTge0', '2016-12-16', 7.8, 137),
(29, 'Moonlight', 'Un jeune homme noir grandit à Miami', 'Barry Jenkins', 'Mahershala Ali, Trevante Rhodes', 10.99, 'https://m.media-amazon.com/images/M/MV5BNzQxNTIyODAxMV5BMl5BanBnXkFtZTgwNzQyMDA3OTE@._V1_SX300.jpg', 'drame', '2026-03-23 11:41:56', 'https://www.youtube.com/embed/9NJj12tJzqc', '2016-10-21', 7.4, 111),
(30, 'Parasite', 'Une famille pauvre s\'infiltre chez les riches', 'Bong Joon-ho', 'Song Kang-ho, Lee Sun-kyun', 12.99, 'https://m.media-amazon.com/images/M/MV5BYjk1Y2U4MjQtY2ZiNS00OWQyLWI3MmYtZWUwNmRjYWRiNWNhXkEyXkFqcGc@._V1_SX300.jpg', 'drame', '2026-03-23 11:41:56', 'https://www.youtube.com/embed/isOGD_7hNIY', '2019-05-31', 8.6, 132),
(31, 'The Intouchables', 'Un aristocrate et son aide à domicile', 'Olivier Nakache', 'Omar Sy, François Cluzet', 11.99, 'https://m.media-amazon.com/images/M/MV5BMTYxNDA3MDQwNl5BMl5BanBnXkFtZTcwNTU4Mzc1Nw@@._V1_SX300.jpg', 'comedie', '2026-03-23 11:41:56', 'https://www.youtube.com/embed/34WIbmXkewU', '2011-11-02', 8.5, 112),
(32, 'Superbad', 'Deux ados veulent acheter de l\'alcool', 'Greg Mottola', 'Jonah Hill, Michael Cera', 8.99, 'https://m.media-amazon.com/images/M/MV5BNjk0MzdlZGEtNTRkOC00ZDRiLWJkYjAtMzUzYTRiNzk1YTViXkEyXkFqcGc@._V1_SX300.jpg', 'comedie', '2026-03-23 11:41:56', 'https://www.youtube.com/embed/4eaZ_48ZYog', '2007-08-17', 7.6, 113),
(33, 'Welcome to the Sticks', 'Un postalier muté dans le nord', 'Dany Boon', 'Kad Merad, Dany Boon', 9.99, 'https://m.media-amazon.com/images/M/MV5BYmIyZTBhOGUtNDBmZC00YjkyLWI1ZmUtYWNkMGU1NzgzZDQ4XkEyXkFqcGc@._V1_SX300.jpg', 'comedie', '2026-03-23 11:41:56', 'https://www.youtube.com/embed/JYayQf03_wE', '2008-02-27', 7.4, 106),
(34, 'Ted', 'Un ours en peluche qui prend vie', 'Seth MacFarlane', 'Mark Wahlberg, Seth MacFarlane', 10.99, 'https://m.media-amazon.com/images/M/MV5BMTQ1OTU0ODcxMV5BMl5BanBnXkFtZTcwOTMxNTUwOA@@._V1_SX300.jpg', 'comedie', '2026-03-23 11:41:56', 'https://www.youtube.com/embed/KcGddC99NzA', '2012-06-29', 6.9, 106),
(35, 'The Hangover', 'Un enterrement de vie de garçon qui tourne mal', 'Todd Phillips', 'Bradley Cooper, Zach Galifianakis', 9.99, 'https://m.media-amazon.com/images/M/MV5BNDI2MzBhNzgtOWYyOS00NDM2LWE0OGYtOGQ0M2FjMTI2NTllXkEyXkFqcGc@._V1_SX300.jpg', 'comedie', '2026-03-23 11:41:56', 'https://www.youtube.com/embed/tcdUhdOlz9M', '2009-06-05', 7.7, 100),
(36, 'Bridesmaids', 'Une demoiselle d\'honneur vit une série de catastrophes', 'Paul Feig', 'Kristen Wiig, Maya Rudolph', 8.99, 'https://m.media-amazon.com/images/M/MV5BMjAyOTMyMzUxNl5BMl5BanBnXkFtZTcwODI4MzE0NA@@._V1_SX300.jpg', 'comedie', '2026-03-23 11:41:56', 'https://www.youtube.com/embed/FNppLrmdyug', '2011-05-13', 6.8, 125),
(37, 'Deadpool', 'Un super-héros qui casse le quatrième mur', 'Tim Miller', 'Ryan Reynolds, Morena Baccarin', 12.99, 'https://m.media-amazon.com/images/M/MV5BNzY3ZWU5NGQtOTViNC00ZWVmLTliNjAtNzViNzlkZWQ4YzQ4XkEyXkFqcGc@._V1_SX300.jpg', 'comedie', '2026-03-23 11:41:56', 'https://www.youtube.com/embed/ONHBaC-pfsk', '2016-02-12', 8.0, 108),
(38, 'Serial (Bad) Weddings', 'Une famille française face aux gendres étrangers', 'Philippe de Chauveron', 'Christian Clavier, Chantal Lauby', 10.99, 'https://m.media-amazon.com/images/M/MV5BMDU5YWYyNmUtZDcwOC00NGI3LThmYjEtYTFiNzE3MzVhMGY0XkEyXkFqcGc@._V1_SX300.jpg', 'comedie', '2026-03-23 11:41:56', 'https://www.youtube.com/embed/QerOPic11Tk', '2014-04-16', 6.9, 97),
(39, 'The Wolf of Wall Street', 'L\'ascension fulgurante et la chute spectaculaire d\'un courtier en bourse new-yorkais, qui a dirigé une vaste fraude financière.', 'Martin Scorsese', 'Leonardo DiCaprio, Jonah Hill, Margot Robbie', 12.99, 'https://m.media-amazon.com/images/M/MV5BMjIxMjgxNTk0MF5BMl5BanBnXkFtZTgwNjIyOTg2MDE@._V1_SX300.jpg', 'comedie', '2026-03-23 11:41:56', 'https://www.youtube.com/embed/iszwuX1AK6A', '2013-12-25', 8.2, 180),
(40, 'Barbie', 'Barbie vit dans un monde parfait', 'Greta Gerwig', 'Margot Robbie, Ryan Gosling', 13.99, 'https://m.media-amazon.com/images/M/MV5BYjI3NDU0ZGYtYjA2YS00Y2RlLTgwZDAtYTE2YTM5ZjE1M2JlXkEyXkFqcGc@._V1_SX300.jpg', 'comedie', '2026-03-23 11:41:56', 'https://www.youtube.com/embed/pBk4NYhWNMM', '2023-07-19', 6.9, 114),
(41, 'The Grand Budapest Hotel', 'Un concierge légendaire dans un hôtel', 'Wes Anderson', 'Ralph Fiennes, Tony Revolori', 11.99, 'https://m.media-amazon.com/images/M/MV5BMzM5NjUxOTEyMl5BMl5BanBnXkFtZTgwNjEyMDM0MDE@._V1_SX300.jpg', 'comedie', '2026-03-23 11:41:56', 'https://www.youtube.com/embed/2Z4m4lnjxkY', '2014-03-28', 8.1, 100),
(42, 'National Lampoon\'s Vacation', 'Des vacances qui tournent mal', 'John Francis', 'Steve Martin, Chevy Chase', 7.99, 'https://m.media-amazon.com/images/M/MV5BOWQ3ZTg3MzYtOGU0Yi00NjgyLWFkNmMtMWFlZWE3MTkyOTdlXkEyXkFqcGc@._V1_SX300.jpg', 'comedie', '2026-03-23 11:41:56', 'https://www.youtube.com/embed/FHThGmVfE3A', '1983-07-29', 7.3, 98),
(43, 'Step Brothers', 'Deux hommes doivent cohabiter', 'Adam McKay', 'Will Ferrell, John C. Reilly', 8.99, 'https://m.media-amazon.com/images/M/MV5BYWNiOGZkOTgtNGMzMC00MDg5LTliM2UtN2VjMDI3N2ViOWE5XkEyXkFqcGc@._V1_SX300.jpg', 'comedie', '2026-03-23 11:41:56', 'https://www.youtube.com/embed/CewglxElBK0', '2008-07-25', 6.9, 98),
(44, 'The 40-Year-Old Virgin', 'Un homme cherche à perdre sa virginité', 'Judd Apatow', 'Steve Carell, Catherine Keener', 9.99, 'https://m.media-amazon.com/images/M/MV5BMzFiNzU2NjQtZTcwZC00Nzc3LTk3NjEtMDZmMDhmYjQ4NTAwXkEyXkFqcGc@._V1_SX300.jpg', 'comedie', '2026-03-23 11:41:56', 'https://www.youtube.com/embed/4a8r2hvQ-O4', '2005-08-19', 7.1, 116),
(46, 'The Notebook', 'Une histoire d\'amour inoubliable', 'Nick Cassavetes', 'Ryan Gosling, Rachel McAdams', 9.99, 'https://m.media-amazon.com/images/M/MV5BZjE0ZjgzMzYtMTAxYi00NGMzLThmZDktNzFlMzA2MWRmYWQ0XkEyXkFqcGc@._V1_SX300.jpg', 'amour', '2026-03-23 11:41:56', 'https://www.youtube.com/embed/BjJcYdEOI0k', '2004-06-25', 7.8, 123),
(47, 'Titanic', 'Un amour sur le célèbre navire', 'James Cameron', 'Leonardo DiCaprio, Kate Winslet', 12.99, 'https://m.media-amazon.com/images/M/MV5BYzYyN2FiZmUtYWYzMy00MzViLWJkZTMtOGY1ZjgzNWMwN2YxXkEyXkFqcGc@._V1_SX300.jpg', 'amour', '2026-03-23 11:41:56', 'https://www.youtube.com/embed/kVrqfYjkTdQ', '1997-12-19', 7.9, 194),
(48, 'PS: I Love You', 'Une femme reçoit des lettres de son défunt mari', 'Richard LaGravenese', 'Hilary Swank, Gerard Butler', 8.99, 'https://m.media-amazon.com/images/M/MV5BNTg2MDg4MjI5NV5BMl5BanBnXkFtZTcwMzQ0MDczMw@@._V1_SX300.jpg', 'amour', '2026-03-23 11:41:56', 'https://www.youtube.com/embed/cqPaPK2zVyM', '2007-12-21', 7.1, 126),
(49, 'La La Land', 'Un musicien et une actrice à Los Angeles', 'Damien Chazelle', 'Ryan Gosling, Emma Stone', 11.99, 'https://m.media-amazon.com/images/M/MV5BMzUzNDM2NzM2MV5BMl5BanBnXkFtZTgwNTM3NTg4OTE@._V1_SX300.jpg', 'amour', '2026-03-23 11:41:56', 'https://www.youtube.com/embed/0pdqf4P9MB8', '2016-12-09', 8.0, 128),
(50, 'Pride and Prejudice', 'L\'histoire d\'amour de Elizabeth et Mr Darcy', 'Joe Wright', 'Keira Knightley, Matthew Macfadyen', 9.99, 'https://m.media-amazon.com/images/M/MV5BYzNkMjRmZGMtODg1Ni00MjIxLWI4MTYtOGEwM2YyMmZiMjUzXkEyXkFqcGc@._V1_SX300.jpg', 'amour', '2026-03-23 11:41:56', 'https://www.youtube.com/embed/1dYv5u6v55Y', '2005-11-11', 8.1, 129),
(51, 'Love Actually', 'Plusieurs histoires d\'amour à Noël', 'Richard Curtis', 'Hugh Grant, Emma Thompson', 10.99, 'https://m.media-amazon.com/images/M/MV5BYWRlZjcwYTgtYWJkOS00MGYwLTk3Y2ItNmU4NTg5Nzg2YTQ2XkEyXkFqcGc@._V1_SX300.jpg', 'amour', '2026-03-23 11:41:56', 'https://www.youtube.com/embed/f-xfOZ0-1kk', '2003-11-07', 7.6, 135),
(52, '500 Days of Summer', 'Une vision non linéaire d\'une relation', 'Marc Webb', 'Joseph Gordon-Levitt, Zooey Deschanel', 8.99, 'https://m.media-amazon.com/images/M/MV5BMTk5MjM4OTU1OV5BMl5BanBnXkFtZTcwODkzNDIzMw@@._V1_SX300.jpg', 'amour', '2026-03-23 11:41:56', 'https://www.youtube.com/embed/PsD0NpFSADM', '2009-08-07', 7.6, 95),
(53, 'Crazy Rich Asians', 'Une jeune femme rencontre la famille de son copain', 'Jon M. Chu', 'Constance Wu, Henry Golding', 11.99, 'https://m.media-amazon.com/images/M/MV5BMTYxNDMyOTAxN15BMl5BanBnXkFtZTgwMDg1ODYzNTM@._V1_SX300.jpg', 'amour', '2026-03-23 11:41:56', 'https://www.youtube.com/embed/mOx-ZOdntVM', '2018-08-15', 6.9, 120),
(54, 'Before Sunrise', 'Une rencontre dans un train à Vienne', 'Richard Linklater', 'Ethan Hawke, Julie Delpy', 9.99, 'https://m.media-amazon.com/images/M/MV5BZDZhZmI1ZTUtYWI3NC00NTMwLTk3NWMtNDc0OGNjM2I0ZjlmXkEyXkFqcGc@._V1_SX300.jpg', 'amour', '2026-03-23 11:41:56', 'https://www.youtube.com/embed/IQ0ZrOYMdtA', '1995-01-27', 8.1, 101),
(55, 'A Star Is Born', 'Un chanteur découvre une jeune artiste', 'Bradley Cooper', 'Bradley Cooper, Lady Gaga', 10.99, 'https://m.media-amazon.com/images/M/MV5BNGUxZTc0NTAtNzQwMy00MmM2LTgzMGYtZWIyY2E1MGFjYmM5XkEyXkFqcGc@._V1_SX300.jpg', 'amour', '2026-03-23 11:41:56', 'https://www.youtube.com/embed/nSbzyEJ8X9E', '2018-10-05', 7.6, 136),
(56, 'Silver Linings Playbook', 'Deux personnes troublées se rapprochent', 'David O. Russell', 'Bradley Cooper, Jennifer Lawrence', 9.99, 'https://m.media-amazon.com/images/M/MV5BMTM2MTI5NzA3MF5BMl5BanBnXkFtZTcwODExNTc0OA@@._V1_SX300.jpg', 'amour', '2026-03-23 11:41:56', 'https://www.youtube.com/embed/Lm8p5rlrSkY', '2012-11-16', 7.7, 122),
(57, 'Eternal Sunshine of the Spotless Mind', 'Un couple efface ses souvenirs', 'Michel Gondry', 'Jim Carrey, Kate Winslet', 10.99, 'https://m.media-amazon.com/images/M/MV5BMTY4NzcwODg3Nl5BMl5BanBnXkFtZTcwNTEwOTMyMw@@._V1_SX300.jpg', 'amour', '2026-03-23 11:41:56', 'https://www.youtube.com/embed/iY8B790zlR0', '2004-03-19', 8.3, 108),
(58, 'Call Me By Your Name', 'Un amour d\'été en Italie', 'Luca Guadagnino', 'Timothée Chalamet, Armie Hammer', 11.99, 'https://m.media-amazon.com/images/M/MV5BNDk3NTEwNjc0MV5BMl5BanBnXkFtZTgwNzYxNTMwMzI@._V1_SX300.jpg', 'amour', '2026-03-23 11:41:56', 'https://www.youtube.com/embed/Z9AYPxH5NTM', '2017-11-24', 7.9, 132),
(59, 'The Fault in Our Stars', 'Deux ados malades tombent amoureux', 'Josh Boone', 'Shailene Woodley, Ansel Elgort', 9.99, 'https://m.media-amazon.com/images/M/MV5BYTA4ODg5YWUtYmZiYy00Y2M4LWE0NjEtODE5MzhkYmJmZGEwXkEyXkFqcGc@._V1_SX300.jpg', 'amour', '2026-03-23 11:41:56', 'https://www.youtube.com/embed/9ItBvH5J6ss', '2014-06-06', 7.7, 126),
(60, '10 Things I Hate About You', 'Une comédie romantique au lycée', 'Gil Junger', 'Heath Ledger, Julia Stiles', 8.99, 'https://m.media-amazon.com/images/M/MV5BOTQwYmRhNGQtODI2Mi00ZTRlLTk0Y2QtY2NkNjE1MGNhNTgwXkEyXkFqcGc@._V1_SX300.jpg', 'amour', '2026-03-23 11:41:56', 'https://www.youtube.com/embed/h8waAEOdv6I', '1999-03-31', 7.3, 97),
(61, 'Indiana Jones', 'L\'archéologue aventurier', 'Steven Spielberg', 'Harrison Ford, Karen Allen', 10.99, 'https://m.media-amazon.com/images/M/MV5BNGIxNzQ0YzYtMjNmYi00YjBlLWFjNzEtNGE3ZGFmYTczM2MwXkEyXkFqcGc@._V1_SX300.jpg', 'aventure', '2026-03-23 11:41:56', 'https://www.youtube.com/embed/XkkzKHCx154', '1981-06-12', 8.4, 115),
(62, 'Pirates of the Caribbean: The Curse of the Black Pearl', 'Un pirate au coeur d\'or', 'Gore Verbinski', 'Johnny Depp, Orlando Bloom', 11.99, 'https://m.media-amazon.com/images/M/MV5BNDhlMzEyNzItMTA5Mi00YWRhLThlNTktYTQyMTA0MDIyNDEyXkEyXkFqcGc@._V1_SX300.jpg', 'aventure', '2026-03-23 11:41:56', 'https://www.youtube.com/embed/naQr0uTrH_s', '2003-07-09', 8.1, 143),
(63, 'Jurassic Park', 'Des dinosaures ressuscités', 'Steven Spielberg', 'Sam Neill, Laura Dern', 10.99, 'https://m.media-amazon.com/images/M/MV5BMjM2MDgxMDg0Nl5BMl5BanBnXkFtZTgwNTM2OTM5NDE@._V1_SX300.jpg', 'aventure', '2026-03-23 11:41:56', 'https://www.youtube.com/embed/lc0UehYemQA', '1993-06-11', 8.2, 127),
(64, 'The Lord of the Rings: The Fellowship of the Ring', 'Un voyage épique en Terre du Milieu', 'Peter Jackson', 'Elijah Wood, Ian McKellen', 14.99, 'https://m.media-amazon.com/images/M/MV5BNzIxMDQ2YTctNDY4MC00ZTRhLTk4ODQtMTVlOWY4NTdiYmMwXkEyXkFqcGc@._V1_SX300.jpg', 'aventure', '2026-03-23 11:41:56', 'https://www.youtube.com/embed/V75dMMIW2B4', '2001-12-19', 8.9, 178),
(65, 'Avatar', 'Un soldat sur une planète extraterrestre', 'James Cameron', 'Sam Worthington, Zoe Saldana', 13.99, 'https://m.media-amazon.com/images/M/MV5BMDEzMmQwZjctZWU2My00MWNlLWE0NjItMDJlYTRlNGJiZjcyXkEyXkFqcGc@._V1_SX300.jpg', 'aventure', '2026-03-23 11:41:56', 'https://www.youtube.com/embed/5PSNL1qE6VY', '2009-12-18', 7.9, 162),
(66, 'Harry Potter', 'Un jeune sorcier découvre un monde magique', 'Chris Columbus', 'Daniel Radcliffe, Emma Watson', 12.99, 'https://m.media-amazon.com/images/M/MV5BOTA1Mzc2N2ItZWRiNS00MjQzLTlmZDQtMjU0NmY1YWRkMGQ4XkEyXkFqcGc@._V1_SX300.jpg', 'aventure', '2026-03-23 11:41:56', 'https://www.youtube.com/embed/VyHV0BRtdxo', '2001-11-16', 7.6, 152),
(67, 'The Revenant', 'Un trappeur cherche à survivre', 'Alejandro Iñárritu', 'Leonardo DiCaprio, Tom Hardy', 11.99, 'https://m.media-amazon.com/images/M/MV5BYTgwNmQzZDctMjNmOS00OTExLTkwM2UtNzJmOTJhODFjOTdlXkEyXkFqcGc@._V1_SX300.jpg', 'aventure', '2026-03-23 11:41:56', 'https://www.youtube.com/embed/QRfj1VCg16Y', '2015-12-25', 8.0, 156),
(68, 'Jumanji', 'Un jeu vidéo qui devient réalité', 'Jake Kasdan', 'Dwayne Johnson, Kevin Hart', 10.99, 'https://m.media-amazon.com/images/M/MV5BYTFkMjFmODgtYzRiZi00NmQwLTliZWMtMzRhMWQ5ZmY3ZDExXkEyXkFqcGc@._V1_SX300.jpg', 'aventure', '2026-03-23 11:41:56', 'https://www.youtube.com/embed/2QKg5SZ_35I', '2017-12-20', 6.9, 119),
(69, 'King Kong', 'Un gorille géant sur une île', 'Peter Jackson', 'Naomi Watts, Jack Black', 9.99, 'https://m.media-amazon.com/images/M/MV5BMWY0NWE0ZjUtNjRlOS00ZDViLTgxNTQtMGMwN2FhNDY1YTg2XkEyXkFqcGc@._V1_SX300.jpg', 'aventure', '2026-03-23 11:41:56', 'https://www.youtube.com/embed/l6xEypeB3iU', '2005-12-14', 7.2, 187),
(70, 'Interstellar', 'Un voyage dans l\'espace pour sauver l\'humanité', 'Christopher Nolan', 'Matthew McConaughey, Anne Hathaway', 13.99, 'https://m.media-amazon.com/images/M/MV5BYzdjMDAxZGItMjI2My00ODA1LTlkNzItOWFjMDU5ZDJlYWY3XkEyXkFqcGc@._V1_SX300.jpg', 'aventure', '2026-03-23 11:41:56', 'https://www.youtube.com/embed/zSWdZVtXT7E', '2014-11-07', 8.6, 169),
(71, 'Dune', 'Un jeune homme sur une planète désertique', 'Denis Villeneuve', 'Timothée Chalamet, Zendaya', 14.99, 'https://m.media-amazon.com/images/M/MV5BMGJlMGM3NDAtOWNhMy00MWExLWI2MzEtMDQ0ZDIzZDY5ZmQ2XkEyXkFqcGc@._V1_SX300.jpg', 'aventure', '2026-03-23 11:41:56', 'https://www.youtube.com/embed/8g18jFHCLXk', '2021-10-22', 8.0, 155),
(72, 'The Hunger Games', 'Une jeune fille participe à des jeux mortels', 'Gary Ross', 'Jennifer Lawrence, Josh Hutcherson', 10.99, 'https://m.media-amazon.com/images/M/MV5BMWI1OGM4YjQtNmIxNi00YmE2LWJkNTAtY2Q0YjU4NTI5NWQyXkEyXkFqcGc@._V1_SX300.jpg', 'aventure', '2026-03-23 11:41:56', 'https://www.youtube.com/embed/mfmrPu43DF8', '2012-03-23', 7.2, 142),
(73, 'The Mummy', 'Une momie égyptienne se réveille', 'Stephen Sommers', 'Brendan Fraser, Rachel Weisz', 9.99, 'https://m.media-amazon.com/images/M/MV5BMTY4YWE0OGMtNjU0Yi00YzIwLTk3NTktM2ZiYWQwNjM4MmMxXkEyXkFqcGc@._V1_SX300.jpg', 'aventure', '2026-03-23 11:41:56', 'https://www.youtube.com/embed/c58CBfdY6R8', '1999-05-07', 7.1, 125),
(74, 'The Lost City', 'Une romancière et son modèle en aventure', 'Aaron Nee', 'Sandra Bullock, Channing Tatum', 10.99, 'https://m.media-amazon.com/images/M/MV5BZjA4YmZjMWItZGNkNS00ODFkLWEwNjUtNGNhMzViZDRmMzgxXkEyXkFqcGc@._V1_SX300.jpg', 'aventure', '2026-03-23 11:41:56', 'https://www.youtube.com/embed/nfKO9rYDmE8', '2022-03-25', 6.5, 112),
(75, 'Uncharted', 'Un chasseur de trésor en herbe', 'Ruben Fleischer', 'Tom Holland, Mark Wahlberg', 11.99, 'https://m.media-amazon.com/images/M/MV5BYjQxYWNiNzgtOTc2Yi00OGEwLTk5MjAtODdiZTk0ZDJlZGY4XkEyXkFqcGc@._V1_SX300.jpg', 'aventure', '2026-03-23 11:41:56', 'https://www.youtube.com/embed/eHp3MbsCbMg', '2022-02-18', 6.3, 116),
(76, 'The Conjuring', 'Des enquêteurs du paranormal', 'James Wan', 'Vera Farmiga, Patrick Wilson', 9.99, 'https://m.media-amazon.com/images/M/MV5BMTM3NjA1NDMyMV5BMl5BanBnXkFtZTcwMDQzNDMzOQ@@._V1_SX300.jpg', 'horreur', '2026-03-23 11:41:56', 'https://www.youtube.com/embed/k10ETZ41q5o', '2013-07-19', 7.5, 112),
(77, 'Get Out', 'Un jeune homme visite la famille de sa copine', 'Jordan Peele', 'Daniel Kaluuya, Allison Williams', 10.99, 'https://m.media-amazon.com/images/M/MV5BMjUxMDQwNjcyNl5BMl5BanBnXkFtZTgwNzcwMzc0MTI@._V1_SX300.jpg', 'horreur', '2026-03-23 11:41:56', 'https://www.youtube.com/embed/DzfpyUB60YY', '2017-02-24', 7.8, 104),
(78, 'It', 'Un clown maléfique terrorise des enfants', 'Andy Muschietti', 'Bill Skarsgård, Jaeden Martell', 11.99, 'https://m.media-amazon.com/images/M/MV5BZGZmOTZjNzUtOTE4OS00OGM3LWJiNGEtZjk4Yzg2M2Q1YzYxXkEyXkFqcGc@._V1_SX300.jpg', 'horreur', '2026-03-23 11:41:56', 'https://www.youtube.com/embed/xKJmEC5ieOk', '2017-09-08', 7.3, 135),
(79, 'The Shining', 'Un écrivain garde un hôtel isolé', 'Stanley Kubrick', 'Jack Nicholson, Shelley Duvall', 9.99, 'https://m.media-amazon.com/images/M/MV5BNmM5ZThhY2ItOGRjOS00NzZiLWEwYTItNDgyMjFkOTgxMmRiXkEyXkFqcGc@._V1_SX300.jpg', 'horreur', '2026-03-23 11:41:56', 'https://www.youtube.com/embed/5Cb3ik6zP2I', '1980-05-23', 8.4, 146),
(80, 'Hereditary', 'Une famille hantée par des secrets', 'Ari Aster', 'Toni Collette, Alex Wolff', 11.99, 'https://m.media-amazon.com/images/M/MV5BNTEyZGQwODctYWJjZi00NjFmLTg3YmEtMzlhNjljOGZhMWMyXkEyXkFqcGc@._V1_SX300.jpg', 'horreur', '2026-03-23 11:41:56', 'https://www.youtube.com/embed/V6wWKNij_1M', '2018-06-08', 7.3, 127),
(81, 'A Quiet Place', 'Des créatures attaquent au moindre bruit', 'John Krasinski', 'Emily Blunt, John Krasinski', 10.99, 'https://m.media-amazon.com/images/M/MV5BMjI0MDMzNTQ0M15BMl5BanBnXkFtZTgwMTM5NzM3NDM@._V1_SX300.jpg', 'horreur', '2026-03-23 11:41:56', 'https://www.youtube.com/embed/WR7cc5t7tv8', '2018-04-06', 7.5, 90),
(82, 'The Witch', 'Une famille dans la Nouvelle-Angleterre', 'Robert Eggers', 'Anya Taylor-Joy, Ralph Ineson', 8.99, 'https://m.media-amazon.com/images/M/MV5BMTUyNzkwMzAxOF5BMl5BanBnXkFtZTgwMzc1OTk1NjE@._V1_SX300.jpg', 'horreur', '2026-03-23 11:41:56', 'https://www.youtube.com/embed/iQXmlf3Sefg', '2016-02-19', 7.0, 92),
(83, 'Us', 'Une famille confrontée à ses doubles', 'Jordan Peele', 'Lupita Nyong\'o, Winston Duke', 10.99, 'https://m.media-amazon.com/images/M/MV5BMzhkMjFkN2YtODU2Ni00YWYwLWExN2MtOWNjZmQxM2U4YTM5XkEyXkFqcGc@._V1_SX300.jpg', 'horreur', '2026-03-23 11:41:56', 'https://www.youtube.com/embed/Pqo4FGNlcpg', '2019-03-22', 6.8, 116),
(84, 'Midsommar', 'Un festival en Suède tourne au cauchemar', 'Ari Aster', 'Florence Pugh, Jack Reynor', 11.99, 'https://m.media-amazon.com/images/M/MV5BMzQxNzQzOTQwM15BMl5BanBnXkFtZTgwMDQ2NTcwODM@._V1_SX300.jpg', 'horreur', '2026-03-23 11:41:56', 'https://www.youtube.com/embed/1Vnghdsjmd0', '2019-07-03', 7.1, 147),
(85, 'The Ring', 'Une cassette vidéo qui tue', 'Gore Verbinski', 'Naomi Watts, Martin Henderson', 8.99, 'https://m.media-amazon.com/images/M/MV5BNDA2NTg2NjE4Ml5BMl5BanBnXkFtZTYwMjYxMDg5._V1_SX300.jpg', 'horreur', '2026-03-23 11:41:56', 'https://www.youtube.com/embed/CG7BAY6_hsw', '2002-10-18', 7.1, 115),
(86, 'The Exorcist', 'Une fille possédée par un démon', 'William Friedkin', 'Ellen Burstyn, Max von Sydow', 9.99, 'https://m.media-amazon.com/images/M/MV5BZjg3YjE4ZjAtYTdmYS00ZTBkLWE1ZjgtNzAzODUwNzRiYjlmXkEyXkFqcGc@._V1_SX300.jpg', 'horreur', '2026-03-23 11:41:56', 'https://www.youtube.com/embed/3It3N7oYt_g', '1973-12-26', 8.1, 122),
(87, 'Scream', 'Un tueur masqué terrorise des ados', 'Wes Craven', 'Neve Campbell, Courteney Cox', 8.99, 'https://m.media-amazon.com/images/M/MV5BMjA2NjU5MTg5OF5BMl5BanBnXkFtZTgwOTkyMzQxMDE@._V1_SX300.jpg', 'horreur', '2026-03-23 11:41:56', 'https://www.youtube.com/embed/3VhZvuMlIF8', '1996-12-20', 7.4, 111),
(88, 'Halloween', 'Un tueur s\'échappe de l\'asile', 'John Carpenter', 'Jamie Lee Curtis, Donald Pleasence', 8.99, 'https://m.media-amazon.com/images/M/MV5BMzZiNTdiYTgtYjNkMS00MmJmLWEwZGQtNmY0NGJkMGE0YmYzXkEyXkFqcGc@._V1_SX300.jpg', 'horreur', '2026-03-23 11:41:56', 'https://www.youtube.com/embed/WUvTyaaNkzM', '1978-10-25', 7.7, 91),
(89, 'The Nun', 'Une nonne démoniaque', 'Corin Hardy', 'Taissa Farmiga, Demián Bichir', 9.99, 'https://m.media-amazon.com/images/M/MV5BMjM3NzQ5NDcxOF5BMl5BanBnXkFtZTgwNzM4MTQ5NTM@._V1_SX300.jpg', 'horreur', '2026-03-23 11:41:56', 'https://www.youtube.com/embed/hxRjOBRINu0', '2018-09-07', 5.8, 96),
(90, 'Insidious', 'Une famille hantée', 'James Wan', 'Patrick Wilson, Rose Byrne', 9.99, 'https://m.media-amazon.com/images/M/MV5BMTYyOTAxMDA0OF5BMl5BanBnXkFtZTcwNzgwNTc1NA@@._V1_SX300.jpg', 'horreur', '2026-03-23 11:41:56', 'https://www.youtube.com/embed/HZedg27LSZ8', '2011-04-01', 6.8, 103),
(93, 'Shrek', 'Un ogre solitaire voit sa vie paisible envahie par des personnages de contes de fées. Pour récupérer son marais, il doit sauver une princesse.', 'Andrew Adamson, Vicky Jenson', 'Mike Myers, Eddie Murphy, Cameron Diaz', 8.99, 'https://th.bing.com/th/id/OIP.OvaTFTpok8NFUWsSAzvguwHaLH?w=202&h=303&c=7&r=0&o=7&dpr=1.5&pid=1.7&rm=3', 'comedie', '2026-03-23 17:07:10', 'https://www.youtube.com/embed/CwXOrWvPBPk', '2001-05-18', 7.9, 90);


DROP TABLE IF EXISTS `panier`;
CREATE TABLE IF NOT EXISTS `panier` (
  `id` int NOT NULL AUTO_INCREMENT,
  `utilisateur_id` int NOT NULL,
  `film_id` int NOT NULL,
  `quantite` int DEFAULT '1',
  `date_ajout` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `utilisateur_id` (`utilisateur_id`),
  KEY `film_id` (`film_id`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


INSERT INTO `panier` (`id`, `utilisateur_id`, `film_id`, `quantite`, `date_ajout`) VALUES
(11, 4, 93, 1, '2026-03-25 15:13:54');


DROP TABLE IF EXISTS `utilisateurs`;
CREATE TABLE IF NOT EXISTS `utilisateurs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mot_de_passe` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_inscription` datetime DEFAULT CURRENT_TIMESTAMP,
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


INSERT INTO `utilisateurs` (`id`, `nom`, `email`, `mot_de_passe`, `date_inscription`, `avatar`) VALUES
(3, 'keynes steve', 'keynessteve@icloud.com', '$2y$10$qoWSPV3Enda8IueEhRqHPuZPjZm/9J4yu/G64PkUggpI/77Qfqjse', '2026-03-23 13:33:07', 'uploads/avatars/user_3_1774345914.png'),
(2, 'test', 'test@example.com', '$2y$10$I/ldEAaK7Ps03URdK4upsOr9uXZoj7Pko1YeWLP1ENUafM8XSpYi2', '2026-03-23 12:28:34', 'uploads/avatars/default.jpg'),
(4, 'KM10', 'KM10@icloud.com', '$2y$10$MNxylYvSTEjJMTZKolii6u/88aAi/fKD/D475HMuQOmQfU2ws/e2i', '2026-03-25 15:12:00', 'uploads/avatars/user_4_1774447958.jpg');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
