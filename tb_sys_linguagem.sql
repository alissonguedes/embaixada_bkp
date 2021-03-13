-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Tempo de geração: 05-Mar-2021 às 21:05
-- Versão do servidor: 10.3.25-MariaDB-0ubuntu0.20.04.1
-- versão do PHP: 7.4.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `alissong_embaixada`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_sys_linguagem`
--

CREATE TABLE `tb_sys_linguagem` (
  `id` int(11) UNSIGNED NOT NULL,
  `lang` varchar(100) DEFAULT NULL,
  `lang_abr` varchar(5) DEFAULT NULL,
  `bandeira` varchar(255) DEFAULT NULL,
  `status` enum('0','1') NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `tb_sys_linguagem`
--

INSERT INTO `tb_sys_linguagem` (`id`, `lang`, `lang_abr`, `bandeira`, `status`) VALUES
(1, 'Português', 'pt-br', 'img/localidades/1612531977_220a6c6c090a89d743e9.jpg', '1'),
(2, 'English', 'en', 'img/localidades/1612531878_bd7502753e5de17e7b45.jpg', '1'),
(3, 'Húngaro', 'hr', 'img/localidades/1612531970_988317c9bd4ee27b70dc.jpg', '1'),
(4, 'Espanhol', 'es', 'img/localidades/1612531957_fa3c3a4c5e863f86e26d.jpg', '0');

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `tb_sys_linguagem`
--
ALTER TABLE `tb_sys_linguagem`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `lang_abr` (`lang_abr`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `tb_sys_linguagem`
--
ALTER TABLE `tb_sys_linguagem`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
