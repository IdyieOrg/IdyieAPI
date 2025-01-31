CREATE DATABASE IF NOT EXISTS `idyie_api_development` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;

USE `idyie_api_development`;

CREATE TABLE IF NOT EXISTS `users` (
  `id` INT(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `username` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `active` BOOLEAN NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

INSERT INTO `users` (`username`, `email`, `created_at`, `active`) VALUES
('alexandre92', 'alexandre92@example.com', '2024-01-30 14:25:00', 0),
('marie_t', 'marie.t@example.com', '2024-01-29 09:12:00', 0),
('lucas_p', 'lucas.p@example.com', '2024-01-28 18:45:00', 0),
('sophie_m', 'sophie.m@example.com', '2024-01-27 11:30:00', 0),
('theo_g', 'theo.g@example.com', '2024-01-26 23:15:00', 0),
('emma_l', 'emma.l@example.com', '2024-01-25 14:50:00', 0),
('quentin_b', 'quentin.b@example.com', '2024-01-24 07:05:00', 0),
('juliette_c', 'juliette.c@example.com', '2024-01-23 19:40:00', 0),
('nathan_d', 'nathan.d@example.com', '2024-01-22 15:55:00', 1),
('lea_f', 'lea.f@example.com', '2024-01-21 10:20:00', 1),
('gabriel_h', 'gabriel.h@example.com', '2024-01-20 16:10:00', 1),
('manon_j', 'manon.j@example.com', '2024-01-19 12:30:00', 1),
('adrien_k', 'adrien.k@example.com', '2024-01-18 21:45:00', 1),
('camille_l', 'camille.l@example.com', '2024-01-17 08:05:00', 1),
('vincent_m', 'vincent.m@example.com', '2024-01-16 17:20:00', 1),
('pauline_n', 'pauline.n@example.com', '2024-01-15 14:10:00', 1),
('mathieu_o', 'mathieu.o@example.com', '2024-01-14 09:55:00', 1),
('charlotte_p', 'charlotte.p@example.com', '2024-01-13 20:30:00', 1),
('thomas_q', 'thomas.q@example.com', '2024-01-12 18:15:00', 1),
('elodie_r', 'elodie.r@example.com', '2024-01-11 11:40:00', 1);
