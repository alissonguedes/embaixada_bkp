-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Tempo de geração: 11-Mar-2021 às 18:21
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
-- Estrutura da tabela `tb_acl_grupo`
--

CREATE TABLE `tb_acl_grupo` (
  `id` int(11) UNSIGNED NOT NULL,
  `grupo` varchar(25) NOT NULL,
  `descricao` varchar(255) DEFAULT NULL,
  `permissao` smallint(4) UNSIGNED ZEROFILL NOT NULL DEFAULT 0000,
  `status` enum('0','1') NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tabela para cadastro de grupos de usuários.';

--
-- Extraindo dados da tabela `tb_acl_grupo`
--

INSERT INTO `tb_acl_grupo` (`id`, `grupo`, `descricao`, `permissao`, `status`) VALUES
(1, 'Super Administrador', 'Tem permissão total no sistema.', 1111, '1'),
(2, 'Administrador', 'Há restrições para permissão exclusão de dados', 0100, '1');

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_acl_menu`
--

CREATE TABLE `tb_acl_menu` (
  `id` int(11) UNSIGNED NOT NULL,
  `id_palavra` int(11) UNSIGNED NOT NULL,
  `id_secao` int(11) UNSIGNED NOT NULL,
  `id_parent` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `label` varchar(255) NOT NULL,
  `traducao` varchar(255) DEFAULT NULL,
  `link` varchar(255) NOT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `target` varchar(20) DEFAULT NULL,
  `ordem` int(11) NOT NULL DEFAULT 0,
  `permissao` smallint(4) UNSIGNED ZEROFILL NOT NULL DEFAULT 0000,
  `updated_at` datetime NOT NULL DEFAULT current_timestamp(),
  `editavel` enum('0','1') NOT NULL DEFAULT '1',
  `status` enum('0','1') NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tabela para cadastro de menus';

--
-- Extraindo dados da tabela `tb_acl_menu`
--

INSERT INTO `tb_acl_menu` (`id`, `id_palavra`, `id_secao`, `id_parent`, `label`, `traducao`, `link`, `icon`, `target`, `ordem`, `permissao`, `updated_at`, `editavel`, `status`) VALUES
(73, 0, 2, 0, 'Página Inicial', '{\"en\":\"Home\",\"hr\":\"Honlap\",\"pt-br\":\"In\\u00edcio\"}', 'pagina-inicial', NULL, NULL, 1, 0000, '2021-03-09 19:57:40', '0', '1'),
(78, 0, 2, 0, 'Embaixada', '{\"en\":\"Embasy\",\"hr\":\"nagyk\\u00f6vets\\u00e9g\",\"pt-br\":\"Embaixada\"}', 'embaixada', NULL, NULL, 2, 0000, '2021-03-09 19:57:40', '0', '1'),
(79, 0, 2, 0, 'Sobre o site', '{\"en\":\"About\",\"hr\":\"Az oldalr\\u00f3l\",\"pt-br\":\"Sobre o site\"}', 'sobre-o-site', NULL, NULL, 3, 0000, '2021-03-11 08:26:28', '0', '1'),
(80, 0, 2, 0, 'Notícias', '{\"en\":\"News\",\"hr\":\"\",\"pt-br\":\"Not\\u00edcias\"}', 'noticias', NULL, NULL, 4, 0000, '2021-03-09 19:57:40', '0', '1'),
(81, 0, 2, 0, 'Fotos', '{\"en\":\"\",\"hr\":\"\",\"pt-br\":\"\"}', 'fotos', NULL, NULL, 0, 0000, '2021-03-11 20:55:58', '0', '1');

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_acl_menu_grupo`
--

CREATE TABLE `tb_acl_menu_grupo` (
  `id` int(11) UNSIGNED NOT NULL,
  `id_grupo` int(11) UNSIGNED NOT NULL,
  `id_menu` int(11) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tabela para atribuições de menus a grupos de usuários.';

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_acl_menu_secao`
--

CREATE TABLE `tb_acl_menu_secao` (
  `id` int(11) UNSIGNED NOT NULL,
  `id_modulo` int(11) UNSIGNED NOT NULL,
  `secao` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `descricao` varchar(255) DEFAULT NULL,
  `status` enum('0','1') NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tabela para cadastro de seções de menus. Seções correspondem ao local onde o menu se localizará: sidebar, header, footer, etc...';

--
-- Extraindo dados da tabela `tb_acl_menu_secao`
--

INSERT INTO `tb_acl_menu_secao` (`id`, `id_modulo`, `secao`, `slug`, `descricao`, `status`) VALUES
(1, 1, 'Menu Principal', 'sidebar', 'Menu principal da área administrativa', '1'),
(2, 2, 'Main Principal', 'main-menu', 'Menu principal da área pública', '1');

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_acl_modulo`
--

CREATE TABLE `tb_acl_modulo` (
  `id` int(11) UNSIGNED NOT NULL,
  `modulo` varchar(50) NOT NULL,
  `diretorio` varchar(50) NOT NULL,
  `descricao` varchar(200) DEFAULT NULL,
  `status` enum('0','1') NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tabela para cadastro de módulos. Módulos correspondem aos diretórios da aplicação: main, admin, etc...';

--
-- Extraindo dados da tabela `tb_acl_modulo`
--

INSERT INTO `tb_acl_modulo` (`id`, `modulo`, `diretorio`, `descricao`, `status`) VALUES
(1, 'área administrativa', 'admin', 'Área administrativa do site', '1'),
(2, 'área pública', 'main', 'Área pública do site', '1');

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_acl_rotas`
--

CREATE TABLE `tb_acl_rotas` (
  `id` int(11) UNSIGNED NOT NULL,
  `id_menu` int(11) UNSIGNED NOT NULL,
  `type` enum('add','get','post','put','head','options','delete','patch','match','resource','map','group') NOT NULL DEFAULT 'add',
  `route` varchar(255) NOT NULL,
  `controller` varchar(255) NOT NULL,
  `filter` longtext DEFAULT NULL,
  `permissao` smallint(4) UNSIGNED ZEROFILL NOT NULL DEFAULT 0000,
  `status` enum('0','1') NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tabela para cadastro de rotas de menus.';

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_acl_usuario`
--

CREATE TABLE `tb_acl_usuario` (
  `id` int(11) UNSIGNED NOT NULL,
  `id_grupo` int(11) UNSIGNED NOT NULL,
  `id_gestor` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `nome` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `login` varchar(255) NOT NULL,
  `senha` varchar(255) NOT NULL,
  `salt` varchar(255) DEFAULT NULL,
  `ultimo_login` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `permissao` smallint(4) UNSIGNED ZEROFILL NOT NULL DEFAULT 0000,
  `status` enum('0','1') NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tabela para cadastro de usuários';

--
-- Extraindo dados da tabela `tb_acl_usuario`
--

INSERT INTO `tb_acl_usuario` (`id`, `id_grupo`, `id_gestor`, `nome`, `email`, `login`, `senha`, `salt`, `ultimo_login`, `permissao`, `status`) VALUES
(1, 1, 0, 'Alisson', 'alisson', 'alissonguedes87@gmail.com', 'c7ad44cbad762a5da0a452f9e854fdc1e0e7a52a38015f23f3', NULL, '2021-03-08 22:40:38', 0110, '1'),
(2, 2, 0, 'Edvan', 'edvan', 'edvan', 'b123e9e19d217169b981a61188920f9d28638709a513220168', NULL, '2021-03-03 08:38:46', 0000, '1'),
(3, 1, 0, 'Alisson', 'alissonguedes87@gmail.com', 'alisson', 'c7ad44cbad762a5da0a452f9e854fdc1e0e7a52a38015f23f3', NULL, '0000-00-00 00:00:00', 0000, '1'),
(4, 1, 0, 'Felipe', 'felipeweb@hotmail.com', 'felipeweb', 'c7ad44cbad762a5da0a452f9e854fdc1e0e7a52a38015f23f3', NULL, '0000-00-00 00:00:00', 0000, '1'),
(5, 2, 0, 'teste', 'teste@teste.com', 'teste', 'b123e9e19d217169b981a61188920f9d28638709a513220168', NULL, '0000-00-00 00:00:00', 0000, '1'),
(6, 2, 0, 'Isaac Brigano', 'isaacbrigano@email.com', 'isaacbrigano', 'd866fcd2a66112773d45e594e2b7be2c4e095a2c54419c78c1', NULL, '0000-00-00 00:00:00', 0000, '1');

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_acl_usuario_imagem`
--

CREATE TABLE `tb_acl_usuario_imagem` (
  `id_imagem` int(11) UNSIGNED NOT NULL,
  `id_usuario` int(11) UNSIGNED NOT NULL,
  `imagem` varchar(255) NOT NULL,
  `privada` enum('0','1') NOT NULL,
  `data_add` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_album`
--

CREATE TABLE `tb_album` (
  `id` int(11) UNSIGNED NOT NULL,
  `nome` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `titulo` varchar(255) NOT NULL,
  `descricao` varchar(500) NOT NULL,
  `imagem` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp(),
  `status` enum('0','1') NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `tb_album`
--

INSERT INTO `tb_album` (`id`, `nome`, `slug`, `titulo`, `descricao`, `imagem`, `created_at`, `updated_at`, `status`) VALUES
(1, 'teste', '2818f9fe32e48fc8b5ee168ac9b8c9e9498799bd', '{\"en\":\"Test\",\"hr\":\"test\",\"pt-br\":\"teste\"}', '{\"en\":\"teste\",\"hr\":\"este\",\"pt-br\":\"steste\"}', 'assets/embaixada/img/fotos/f622b04658c3d6489cdd27184c0f31da011125b1.png', '2021-03-09 04:24:28', '2021-03-09 08:52:19', '1'),
(2, 'teste2', '22ba8f46e9d0f52cae0fa13f51e534ff5b01a14f', '{\"en\":\"\",\"hr\":\"\",\"pt-br\":\"\"}', '{\"en\":\"\",\"hr\":\"\",\"pt-br\":\"\"}', 'assets/embaixada/img/fotos/5fd123d76bdc083cba11d0a994ae2fb0e5c50e4a.png', '2021-03-09 05:54:27', '2021-03-09 05:54:27', '1');

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_album_foto`
--

CREATE TABLE `tb_album_foto` (
  `id` int(11) UNSIGNED NOT NULL COMMENT 'Numero sequencial',
  `id_album` int(11) UNSIGNED NOT NULL,
  `legenda` varchar(500) DEFAULT NULL COMMENT 'Título principal do banner.',
  `descricao` text DEFAULT NULL COMMENT 'Texto descritivo do banner',
  `clicks` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Quantidade de clicks/visualizações do banner',
  `url` varchar(255) DEFAULT NULL COMMENT 'Link para artigo',
  `imagem` varchar(255) NOT NULL COMMENT 'Caminho ou nome da imagem do banner',
  `original_name` varchar(255) NOT NULL,
  `imgsize` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Tamanho da imagem do banner',
  `autor` varchar(500) NOT NULL COMMENT 'Autor de criação do banner',
  `ordem` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Ordem para listagem do banner',
  `tags` varchar(200) DEFAULT NULL COMMENT 'Tags de pesquisa do banner',
  `created_at` timestamp NULL DEFAULT current_timestamp() COMMENT 'Data de criação do banner',
  `updated_at` timestamp NULL DEFAULT current_timestamp(),
  `status` enum('0','1') NOT NULL DEFAULT '1' COMMENT 'Situação de exibição do banner. 0 - Não exibir; 1 - Exibir.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `tb_album_foto`
--

INSERT INTO `tb_album_foto` (`id`, `id_album`, `legenda`, `descricao`, `clicks`, `url`, `imagem`, `original_name`, `imgsize`, `autor`, `ordem`, `tags`, `created_at`, `updated_at`, `status`) VALUES
(1, 1, NULL, NULL, 0, NULL, 'img/fotos/1614782111_7f9b7648996bff545d60.jpg', 'imagempagina.jpg', 374667, '1', 0, NULL, '2021-03-03 14:35:11', '2021-03-09 04:29:53', '1'),
(2, 1, NULL, NULL, 0, NULL, 'img/fotos/1614782111_14040392916cb23aa09f.png', 'insignia.png', 13681, '1', 0, NULL, '2021-03-03 14:35:11', '2021-03-09 04:29:53', '1'),
(3, 1, NULL, NULL, 0, NULL, 'img/fotos/1614782111_95bc56e04613b6086017.png', 'simbolo_angola.png', 36111, '1', 0, NULL, '2021-03-03 14:35:11', '2021-03-09 04:29:53', '1'),
(4, 1, NULL, NULL, 0, NULL, 'img/fotos/1614782111_6ed325c501875997e99a.png', 'top_banner.png', 41006, '1', 0, NULL, '2021-03-03 14:35:11', '2021-03-09 04:29:53', '1'),
(5, 1, NULL, NULL, 0, NULL, 'img/fotos/1614782111_2e9d04969aee9e346a80.jpg', 'bt_fechar2.jpg', 13007, '1', 0, NULL, '2021-03-03 14:35:11', '2021-03-09 04:29:53', '1'),
(6, 1, NULL, NULL, 0, NULL, 'img/fotos/1614782111_ed9500c650215bbcd2d7.png', 'bt_mob.png', 2977, '1', 0, NULL, '2021-03-03 14:35:11', '2021-03-09 04:29:53', '1'),
(7, 1, NULL, NULL, 0, NULL, 'img/fotos/1614782111_d6ab5c828de06dcf88ba.png', 'foto.png', 169103, '1', 0, NULL, '2021-03-03 14:35:11', '2021-03-09 04:29:53', '1'),
(8, 1, NULL, NULL, 0, NULL, 'img/fotos/1614782111_0a1516983805e8b0c395.jpg', 'imagempagina.jpg', 374667, '1', 0, NULL, '2021-03-03 14:35:11', '2021-03-09 04:29:53', '1'),
(9, 1, NULL, NULL, 0, NULL, 'img/fotos/1614782111_004148733492a67fc129.png', 'insignia.png', 13681, '1', 0, NULL, '2021-03-03 14:35:11', '2021-03-09 04:29:53', '1'),
(10, 1, NULL, NULL, 0, NULL, 'img/fotos/1614782111_305aa50433db7c832d4b.png', 'simbolo_angola.png', 36111, '1', 0, NULL, '2021-03-03 14:35:11', '2021-03-09 04:29:53', '1'),
(11, 1, NULL, NULL, 0, NULL, 'img/fotos/1614782111_ba8390514180ab111206.png', 'top_banner.png', 41006, '1', 0, NULL, '2021-03-03 14:35:11', '2021-03-09 04:29:53', '1');

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_banner`
--

CREATE TABLE `tb_banner` (
  `id` int(11) UNSIGNED NOT NULL COMMENT 'Numero sequencial',
  `titulo` varchar(255) DEFAULT NULL COMMENT 'Título principal do banner.',
  `alias` varchar(255) DEFAULT NULL COMMENT 'Título sem caracteres especiais para identificar o banner.',
  `descricao` text DEFAULT NULL COMMENT 'Texto descritivo do banner',
  `clicks` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Quantidade de clicks/visualizações do banner',
  `url` varchar(255) DEFAULT NULL COMMENT 'Link para artigo',
  `imagem` varchar(255) NOT NULL COMMENT 'Caminho ou nome da imagem do banner',
  `original_name` varchar(255) NOT NULL,
  `imgsize` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Tamanho da imagem do banner',
  `dataadd` timestamp NULL DEFAULT current_timestamp() COMMENT 'Data de criação do banner',
  `autor` varchar(50) NOT NULL COMMENT 'Autor de criação do banner',
  `ordem` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Ordem para listagem do banner',
  `publish_up` date NOT NULL COMMENT 'Data para exibição do banner',
  `publish_down` date NOT NULL COMMENT 'Data para parar exibição do banner',
  `tags` varchar(200) DEFAULT NULL COMMENT 'Tags de pesquisa do banner',
  `status` enum('0','1') NOT NULL DEFAULT '1' COMMENT 'Situação de exibição do banner. 0 - Não exibir; 1 - Exibir.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_cliente`
--

CREATE TABLE `tb_cliente` (
  `id` int(11) UNSIGNED NOT NULL,
  `nome` varchar(100) NOT NULL,
  `rua` varchar(100) NOT NULL,
  `cep` varchar(9) NOT NULL,
  `bairro` varchar(100) NOT NULL,
  `cidade` varchar(100) NOT NULL,
  `uf` varchar(3) NOT NULL,
  `complemento` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_cliente_email`
--

CREATE TABLE `tb_cliente_email` (
  `id` int(11) UNSIGNED NOT NULL,
  `id_cliente` int(11) UNSIGNED NOT NULL,
  `email` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_cliente_telefone`
--

CREATE TABLE `tb_cliente_telefone` (
  `id` int(11) UNSIGNED NOT NULL,
  `id_cliente` int(11) UNSIGNED NOT NULL,
  `telefone` varchar(16) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_distribuidor`
--

CREATE TABLE `tb_distribuidor` (
  `id` int(11) UNSIGNED NOT NULL,
  `nome` varchar(100) NOT NULL,
  `telefone` varchar(16) NOT NULL,
  `email` varchar(255) NOT NULL,
  `rua` varchar(100) NOT NULL,
  `cep` varchar(9) NOT NULL,
  `bairro` varchar(100) NOT NULL,
  `cidade` varchar(100) NOT NULL,
  `uf` varchar(3) NOT NULL,
  `complemento` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_distribuidor_email`
--

CREATE TABLE `tb_distribuidor_email` (
  `id` int(11) UNSIGNED NOT NULL,
  `id_distribuidor` int(11) UNSIGNED NOT NULL,
  `email` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_distribuidor_telefone`
--

CREATE TABLE `tb_distribuidor_telefone` (
  `id` int(11) UNSIGNED NOT NULL,
  `id_distribuidor` int(11) UNSIGNED NOT NULL,
  `telefone` varchar(16) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_email`
--

CREATE TABLE `tb_email` (
  `id` int(11) UNSIGNED NOT NULL,
  `id_reply` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `nome` varchar(50) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `telefone` varchar(16) NOT NULL,
  `assunto` varchar(100) NOT NULL,
  `mensagem` text NOT NULL,
  `datahora` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` enum('0','1') NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_empresa`
--

CREATE TABLE `tb_empresa` (
  `id` int(11) UNSIGNED NOT NULL COMMENT 'Chave primária da tabela.',
  `cnpj` varchar(18) NOT NULL COMMENT 'CNPJ da empresa.',
  `inscricao_estadual` varchar(14) NOT NULL COMMENT 'Inscrição Estadual da empresa',
  `inscricao_municipal` varchar(20) NOT NULL COMMENT 'Inscrição Municipal da empresa.',
  `razao_social` varchar(200) NOT NULL COMMENT 'Razão Social da empresa',
  `nome_fantasia` varchar(200) NOT NULL COMMENT 'Nome Fantasia da empresa.',
  `cep` varchar(9) NOT NULL COMMENT 'CEP do endereço da empresa',
  `endereco` varchar(200) NOT NULL COMMENT 'Endereço da empresa',
  `numero` varchar(11) NOT NULL COMMENT 'Número do endereço da empresa',
  `bairro` varchar(200) NOT NULL COMMENT 'Bairro do endereço da empresa',
  `complemento` varchar(200) DEFAULT NULL COMMENT 'Complemento do endereço da empresa',
  `cidade` varchar(200) NOT NULL COMMENT 'Cidade',
  `estado` varchar(3) NOT NULL COMMENT 'Estado',
  `quem_somos` text DEFAULT NULL COMMENT 'Descrição da empresa',
  `quem_somos_imagem` varchar(255) DEFAULT NULL,
  `distribuidor_imagem` varchar(255) DEFAULT NULL,
  `contato_imagem` varchar(255) DEFAULT NULL,
  `telefone` varchar(16) NOT NULL COMMENT 'Número do telefone da empresa',
  `celular` varchar(16) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL COMMENT 'E-mail da empresa',
  `facebook` varchar(255) DEFAULT NULL,
  `instagram` varchar(255) DEFAULT NULL,
  `gplus` varchar(255) DEFAULT NULL,
  `linkedin` varchar(255) DEFAULT NULL,
  `github` varchar(255) DEFAULT NULL,
  `gmaps` varchar(255) DEFAULT NULL,
  `aliquota_imposto` decimal(10,3) UNSIGNED NOT NULL DEFAULT 0.000 COMMENT 'Alíquota de imposto da empresa',
  `tributacao` enum('SIMPLES NACIONAL','SN - EXCESSO DE SUB-LIMITE DA RECEITA','REGIME NORMAL') NOT NULL DEFAULT 'SIMPLES NACIONAL' COMMENT 'Tipo de tributação',
  `certificado` blob DEFAULT NULL COMMENT 'Localização do arquivo de certificado digital para emissão de notas fiscais',
  `senha_certificado` varchar(255) NOT NULL COMMENT 'Senha do certificado digital',
  `ambiente` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'Tipo do ambiente de emissão de notas fiscais. 0 - Homologação; 1 - Produção',
  `sequence_nfe` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Número da última nota fiscal eletrônica emitida.',
  `sequence_nfce` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Número da última nota fiscal de consumidor emitida.',
  `serie_nfe` int(2) UNSIGNED ZEROFILL NOT NULL DEFAULT 00 COMMENT 'Série da nota fiscal eletrônica.',
  `serie_nfce` int(2) UNSIGNED ZEROFILL NOT NULL DEFAULT 00 COMMENT 'Série da nota fiscal de consumidor.',
  `tokencsc` varchar(6) DEFAULT NULL COMMENT 'Token CSC',
  `csc` varchar(36) DEFAULT NULL COMMENT 'CSC',
  `matriz` enum('S','N') NOT NULL DEFAULT 'N' COMMENT 'Identifica como loja Matriz ou Filial',
  `status` enum('0','1') NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tabela de cadastro de lojas/empresas';

--
-- Extraindo dados da tabela `tb_empresa`
--

INSERT INTO `tb_empresa` (`id`, `cnpj`, `inscricao_estadual`, `inscricao_municipal`, `razao_social`, `nome_fantasia`, `cep`, `endereco`, `numero`, `bairro`, `complemento`, `cidade`, `estado`, `quem_somos`, `quem_somos_imagem`, `distribuidor_imagem`, `contato_imagem`, `telefone`, `celular`, `email`, `facebook`, `instagram`, `gplus`, `linkedin`, `github`, `gmaps`, `aliquota_imposto`, `tributacao`, `certificado`, `senha_certificado`, `ambiente`, `sequence_nfe`, `sequence_nfce`, `serie_nfe`, `serie_nfce`, `tokencsc`, `csc`, `matriz`, `status`) VALUES
(1, '', '', '', '', '', '', '', '', '', NULL, '', '', NULL, NULL, NULL, '/embaixada_cod/public_html/assets/embaixada/img/quem_somos/1610941873_d36a8dfdb8b8262fcb0d.png', '', '', '', '', '', NULL, '', NULL, NULL, '0.000', 'SIMPLES NACIONAL', NULL, '', '0', 0, 0, 00, 00, NULL, NULL, 'N', '1');

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_lead`
--

CREATE TABLE `tb_lead` (
  `id` int(11) UNSIGNED NOT NULL,
  `id_produto` int(11) UNSIGNED NOT NULL,
  `id_cliente` int(11) UNSIGNED NOT NULL,
  `datahora` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_noticia`
--

CREATE TABLE `tb_noticia` (
  `id` int(11) UNSIGNED NOT NULL,
  `id_menu` int(11) UNSIGNED NOT NULL,
  `descricao` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `titulo` text NOT NULL,
  `subtitulo` text DEFAULT NULL,
  `texto` text DEFAULT NULL,
  `imagem` varchar(255) DEFAULT NULL,
  `idioma` varchar(5) NOT NULL COMMENT 'Idioma padrão da postagem',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` enum('0','1') NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `tb_noticia`
--

INSERT INTO `tb_noticia` (`id`, `id_menu`, `descricao`, `slug`, `titulo`, `subtitulo`, `texto`, `imagem`, `idioma`, `created_at`, `updated_at`, `status`) VALUES
(1, 80, 'The Standard lorem ipsum passage used since the 15 years old The Standard lorem ipsum passage used since the 15 years old', 'the-standard-lorem-ipsum-passage-used-since-the-15-years-old-the-standard-lorem-ipsum-passage-used-since-the-15-years-old', '{\"en\":\"teste\",\"hr\":\"teste\",\"pt-br\":\"teste\"}', '{\"en\":\"teste\",\"hr\":\"teste\",\"pt-br\":\"teste\"}', '{\"en\":\"<p><br><\\/p>\",\"hr\":\"<p><br><\\/p>\",\"pt-br\":\"<p><br><\\/p>\"}', 'assets/embaixada/img/paginas/f622b04658c3d6489cdd27184c0f31da011125b1.png', 'pt-br', '2021-02-05 15:15:38', '2021-03-11 21:41:44', '1'),
(2, 80, 'The Standard lorem ipsum passage used since the 15 years old', 'the-standard-lorem-ipsum-passage-used-since-the-15-years-old', '{\"en\":\"The standard Lorem Ipsum passage\",\"hr\":\"The standard\",\"pt-br\":\"The standard Lorem Ipsu\"}', '{\"en\":\"The standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500s\",\"hr\":\"The standard\",\"pt-br\":\"The standard Lorem Ipsum passage, used \"}', '{\"en\":\"<p>The standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500s<\\/p><p><br><\\/p><p>The standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500s<\\/p><p><br><\\/p><p>The standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500s<\\/p>\",\"hr\":\"<p>The standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500s<\\/p><p><br><\\/p><p>The standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500s<\\/p><p><br><\\/p><p>The standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500s<\\/p>\",\"pt-br\":\"<p>The standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500s<\\/p><p><br><\\/p><p>The standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500s<\\/p><p><br><\\/p><p>The standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500s<\\/p>\"}', 'assets/embaixada/img/paginas/264cbb47f5dafa76f5bb979e9c5825ef8a82602b.jpg', 'pt-br', '2021-03-03 14:21:59', '2021-03-11 22:25:45', '1');

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_pagina`
--

CREATE TABLE `tb_pagina` (
  `id` int(11) UNSIGNED NOT NULL,
  `id_menu` int(11) UNSIGNED NOT NULL,
  `descricao` varchar(500) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `titulo` text NOT NULL,
  `subtitulo` text DEFAULT NULL,
  `texto` text NOT NULL,
  `imagem` varchar(255) DEFAULT NULL,
  `idioma` varchar(5) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` enum('0','1') NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `tb_pagina`
--

INSERT INTO `tb_pagina` (`id`, `id_menu`, `descricao`, `slug`, `titulo`, `subtitulo`, `texto`, `imagem`, `idioma`, `created_at`, `updated_at`, `status`) VALUES
(5, 79, 'Página de teste', 'pagina-de-teste', '{\"en\":\"Test Home page\",\"hr\":\"Teste\",\"pt-br\":\"P\\u00e1gina de teste\"}', '{\"en\":\"Test home page\",\"hr\":\"Teste\",\"pt-br\":\"P\\u00e1gina de teste\"}', '{\"en\":\"<p>Teste Home page<\\/p>\",\"hr\":\"<p>teste<\\/p>\",\"pt-br\":\"<p>P\\u00e1gina de teste<\\/p>\"}', NULL, 'pt-br', '2021-03-09 02:30:04', '2021-03-09 22:57:59', '1'),
(6, 79, 'What is Lorem Ipsum?', 'what-is-lorem-ipsum', '{\"en\":\"What is Lorem Ipsum?\",\"hr\":\"Mi a Lorem Ipsum?\",\"pt-br\":\"O que \\u00e9 o Lorem Ipsum?\"}', '{\"en\":\"\\\"Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit...\\\"\",\"hr\":\"\",\"pt-br\":\"\"}', '{\"en\":\"<p class=\\\"ql-align-justify\\\">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas in interdum neque. Aliquam rhoncus quis nisl at rhoncus. Aenean tristique tempus augue nec euismod. Nam massa augue, laoreet et ornare id, sodales in magna. Duis tristique nunc mattis enim tristique, sit amet elementum ligula sollicitudin. Maecenas dolor magna, congue at tortor quis, volutpat pharetra sapien. Sed vel diam vestibulum, ultricies dui vitae, porttitor neque. Nam id tempor dui, ac vestibulum risus. Cras est risus, aliquam id egestas ut, laoreet at neque. Praesent non justo gravida, ultrices velit quis, dictum urna. Duis eget arcu sed magna blandit viverra in vel purus. Phasellus elit quam, fringilla eget hendrerit eu, maximus eleifend metus. Aenean in scelerisque ex, varius viverra odio.<\\/p><p class=\\\"ql-align-justify\\\">Curabitur semper massa at erat aliquet, dignissim auctor nulla volutpat. Vestibulum vulputate faucibus odio non pretium. Duis iaculis lectus ut scelerisque pulvinar. Quisque dolor massa, laoreet eu aliquam nec, molestie sit amet ex. Maecenas tortor diam, fermentum ut purus id, auctor porta lectus. Nam eu laoreet tortor. Ut nulla est, auctor eget vehicula vitae, auctor ut odio. Donec sodales justo non purus molestie sodales.<\\/p><p class=\\\"ql-align-justify\\\">Mauris ut tempor dolor. Pellentesque ante diam, feugiat ut laoreet ut, lacinia non lectus. Sed dictum in odio sed sollicitudin. Quisque facilisis, turpis vel dictum egestas, turpis arcu ultrices lacus, quis rhoncus nulla massa et nisl. Mauris cursus vitae nibh ut sollicitudin. Nullam neque orci, fermentum eu quam sed, condimentum consectetur dui. Proin a neque a leo suscipit iaculis vitae sed velit. Ut a consequat ipsum. Nam fermentum dapibus urna, eu faucibus ipsum dictum eget. Morbi malesuada diam a ex facilisis, eget facilisis nibh laoreet. Praesent fringilla volutpat ullamcorper. Mauris et faucibus arcu, quis commodo nulla. Vestibulum sed feugiat nibh.<\\/p><p class=\\\"ql-align-justify\\\">In luctus felis id est lacinia mollis. Phasellus vitae scelerisque erat. Proin a pulvinar mi. Proin porttitor pretium arcu, molestie volutpat metus vehicula ultricies. Pellentesque ante sem, vehicula vitae est sit amet, varius fringilla tortor. Vestibulum sit amet facilisis nibh. Aliquam condimentum venenatis augue in feugiat. Proin dignissim metus lacus, eget mollis enim aliquam semper. Sed lectus tellus, pretium ac lorem id, tempus condimentum neque. Fusce in ligula ut ex mattis faucibus. Vivamus semper eros non finibus elementum. Vivamus sed felis mauris. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Suspendisse non imperdiet nibh.<\\/p><p class=\\\"ql-align-justify\\\">Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Sed id auctor nulla. Sed vel ex sed lorem interdum ullamcorper. Praesent consectetur libero dignissim mollis condimentum. In cursus commodo purus, vel faucibus turpis iaculis vitae. Suspendisse dapibus ac metus ut ornare. Vivamus turpis velit, gravida id velit eu, consectetur mollis urna. Aenean eget aliquam est, sit amet hendrerit ante.<\\/p><p class=\\\"ql-align-justify\\\"><br><\\/p><p><br><\\/p>\",\"hr\":\"<p>A Lorem Ipsum r\\u00e9szleteinek sok v\\u00e1ltozata el\\u00e9rhet\\u00f5, de a legt\\u00f6bbet megv\\u00e1ltoztatt\\u00e1k egy kis humorral \\u00e9s v\\u00e9letlenszer\\u00fben kiv\\u00e1lasztott szavakkal, amik kicsit sem teszik \\u00e9rtelmess\\u00e9. Ha haszn\\u00e1lni k\\u00e9sz\\u00fclsz a Lorem Ipsumot, biztosnak kell lenned abban, hogy semmi k\\u00ednos sincs elrejtve a sz\\u00f6veg k\\u00f6zep\\u00e9n. Az \\u00f6sszes internetes Lorem Ipsum k\\u00e9sz\\u00edt\\u00f5 igyekszik el\\u00f5re be\\u00e1ll\\u00edtott r\\u00e9szleteket ism\\u00e9telni a sz\\u00fcks\\u00e9ges mennyis\\u00e9gben, ezzel t\\u00e9ve az internet egyetlen igazi Lorem Ipsum gener\\u00e1tor\\u00e1v\\u00e1 ezt az oldalt. Az oldal k\\u00f6r\\u00fclbel\\u00fcl 200 latin sz\\u00f3t haszn\\u00e1l, egy maroknyi modell-mondatszerkezettel \\u00edgy t\\u00e9ve a Lorem Ipsumot elfogadhat\\u00f3v\\u00e1. Tov\\u00e1bb\\u00e1 az elk\\u00e9sz\\u00fclt Lorem Ipsum humort\\u00f3l, ism\\u00e9tl\\u00f5d\\u00e9st\\u00f5l vagy \\u00e9rtelmetlen szavakt\\u00f3l mentes.<\\/p>\",\"pt-br\":\"<p>O&nbsp;Lorem Ipsum&nbsp;\\u00e9 um texto modelo da ind\\u00fastria tipogr\\u00e1fica e de impress\\u00e3o. O Lorem Ipsum tem vindo a ser o texto padr\\u00e3o usado por estas ind\\u00fastrias desde o ano de 1500, quando uma misturou os caracteres de um texto para criar um esp\\u00e9cime de livro. Este texto n\\u00e3o s\\u00f3 sobreviveu 5 s\\u00e9culos, mas tamb\\u00e9m o salto para a tipografia electr\\u00f3nica, mantendo-se essencialmente inalterada. Foi popularizada nos anos 60 com a disponibiliza\\u00e7\\u00e3o das folhas de Letraset, que continham passagens com Lorem Ipsum, e mais recentemente com os programas de publica\\u00e7\\u00e3o como o Aldus PageMaker que incluem vers\\u00f5es do Lorem Ipsum.<\\/p>\"}', 'assets/embaixada/img/paginas/9cb7f50558cb7c9b55cec88009081b11732a0797.png', 'pt-br', '2021-03-09 02:54:19', '2021-03-11 10:40:33', '1'),
(7, 78, 'Embaixada', 'embaixada', '{\"en\":\"Embasy\",\"hr\":\"\",\"pt-br\":\"\"}', '{\"en\":\"Lorem ipsum dolor\",\"hr\":\"\",\"pt-br\":\"\"}', '{\"en\":\"<p>Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor <\\/p><p><br><\\/p><p>Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor <\\/p><p><br><\\/p><p>Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor <\\/p>\",\"hr\":\"<p>Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor orem ipsum dolor <\\/p><p><br><\\/p><p>Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor <\\/p>\",\"pt-br\":\"<p>Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem <\\/p>\"}', 'assets/embaixada/img/paginas/dabd35f70ce15ac04dceeca28e0ee60e10b24edd.png', 'en', '2021-03-11 20:48:59', '2021-03-11 23:50:02', '1');

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_produto`
--

CREATE TABLE `tb_produto` (
  `id` int(11) UNSIGNED NOT NULL,
  `id_distribuidor` int(11) UNSIGNED NOT NULL,
  `id_categoria` int(11) UNSIGNED NOT NULL,
  `nome` varchar(100) NOT NULL,
  `descricao` text NOT NULL,
  `modo_uso` text NOT NULL,
  `imagem` varchar(255) DEFAULT NULL,
  `valor` decimal(10,3) NOT NULL,
  `status` enum('0','1') NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_produto_categoria`
--

CREATE TABLE `tb_produto_categoria` (
  `id` int(10) UNSIGNED NOT NULL,
  `id_parent` int(11) UNSIGNED NOT NULL,
  `categoria` varchar(100) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `imagem` varchar(255) DEFAULT NULL,
  `status` enum('0','1') NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_sys_config`
--

CREATE TABLE `tb_sys_config` (
  `id` int(11) UNSIGNED NOT NULL COMMENT 'Número sequencial da tabela.',
  `config` varchar(255) NOT NULL,
  `value` longtext DEFAULT NULL COMMENT 'Endereço do website',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tabela de configurações do site';

--
-- Extraindo dados da tabela `tb_sys_config`
--

INSERT INTO `tb_sys_config` (`id`, `config`, `value`, `created_at`, `updated_at`) VALUES
(1, 'site_logo', NULL, '2021-03-09 19:55:51', '2021-03-09 23:00:20'),
(2, 'original_logo_name', NULL, '2021-03-09 19:55:51', '2021-03-09 23:00:20'),
(3, 'site_title', NULL, '2021-03-09 19:55:51', '2021-03-09 19:55:51'),
(4, 'site_url', NULL, '2021-03-09 19:55:51', '2021-03-09 19:55:51'),
(5, 'language', 'pt-br', '2021-03-09 19:55:51', '2021-03-09 22:56:20'),
(6, 'contact_email', NULL, '2021-03-09 19:55:51', '2021-03-09 19:55:51'),
(7, 'contact_phone', NULL, '2021-03-09 19:55:51', '2021-03-09 19:55:51'),
(8, 'contact_cel', NULL, '2021-03-09 19:55:51', '2021-03-09 19:55:51'),
(9, 'facebook', NULL, '2021-03-09 19:55:51', '2021-03-09 19:55:51'),
(10, 'instagram', NULL, '2021-03-09 19:55:51', '2021-03-09 19:55:51'),
(11, 'linkedin', NULL, '2021-03-09 19:55:51', '2021-03-09 19:55:51'),
(12, 'address', NULL, '2021-03-09 19:55:51', '2021-03-09 19:55:51'),
(13, 'address_nro', NULL, '2021-03-09 19:55:51', '2021-03-09 19:55:51'),
(14, 'cep', NULL, '2021-03-09 19:55:51', '2021-03-09 19:55:51'),
(15, 'complemento', NULL, '2021-03-09 19:55:51', '2021-03-09 19:55:51'),
(16, 'bairro', NULL, '2021-03-09 19:55:51', '2021-03-09 19:55:51'),
(17, 'cidade', NULL, '2021-03-09 19:55:51', '2021-03-09 19:55:51'),
(18, 'uf', NULL, '2021-03-09 19:55:51', '2021-03-09 19:55:51'),
(19, 'gmaps', '<iframe src=\"https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d1664.5836546927305!2d-34.858389255410266!3d-7.117950406096949!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x7acdd56d3578e67%3A0x65c680df17fb4e42!2sHostDime%20Brasil!5e0!3m2!1spt-BR!2sbr!4v1615446431902!5m2!1spt-BR!2sbr\" width=\"600\" height=\"450\" style=\"border:0;\" allowfullscreen=\"\" loading=\"lazy\"></iframe>', '2021-03-09 19:55:51', '2021-03-11 10:07:25'),
(20, 'site_description', 'asdfa', '2021-03-09 20:00:20', '2021-03-09 20:00:20'),
(21, 'site_tags', 'Quantidade máxima de Tags = 10,Tag N (...),Tag 10,4', '2021-03-09 20:08:48', '2021-03-11 10:07:25');

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_sys_config_versao-1`
--

CREATE TABLE `tb_sys_config_versao-1` (
  `id` int(11) NOT NULL,
  `url` varchar(255) NOT NULL,
  `path` varchar(255) NOT NULL,
  `title` varchar(70) NOT NULL DEFAULT 'My New Site',
  `description` varchar(160) DEFAULT NULL,
  `quem_somos` longtext DEFAULT NULL,
  `keywords` varchar(200) DEFAULT NULL,
  `custodian` varchar(100) DEFAULT NULL,
  `expires` varchar(60) DEFAULT NULL,
  `revisit_after` varchar(20) DEFAULT NULL,
  `rating` varchar(60) NOT NULL DEFAULT 'general',
  `robots` varchar(16) NOT NULL DEFAULT 'index,follow',
  `theme_color` varchar(26) DEFAULT NULL,
  `logomarca` varchar(255) DEFAULT NULL,
  `language` varchar(5) NOT NULL DEFAULT 'pt-BR',
  `msg_manutencao` longtext DEFAULT NULL,
  `msg_suspensao` longtext DEFAULT NULL,
  `manutencao` enum('1','0') NOT NULL DEFAULT '0',
  `bloqueado` enum('1','0') NOT NULL DEFAULT '0',
  `force_www` enum('1','0') NOT NULL DEFAULT '0',
  `force_https` enum('1','0') NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `tb_sys_config_versao-1`
--

INSERT INTO `tb_sys_config_versao-1` (`id`, `url`, `path`, `title`, `description`, `quem_somos`, `keywords`, `custodian`, `expires`, `revisit_after`, `rating`, `robots`, `theme_color`, `logomarca`, `language`, `msg_manutencao`, `msg_suspensao`, `manutencao`, `bloqueado`, `force_www`, `force_https`) VALUES
(1, 'localhost', '/embaixada', 'Embaixada da República de Angola na Hungria', '', NULL, NULL, 'Guedes, Alisson', NULL, NULL, 'general', '', NULL, NULL, 'pt-br', NULL, NULL, '0', '0', '0', '0');

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_sys_dicionario`
--

CREATE TABLE `tb_sys_dicionario` (
  `id` int(11) UNSIGNED NOT NULL,
  `palavra` text NOT NULL,
  `definicao` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_sys_idioma`
--

CREATE TABLE `tb_sys_idioma` (
  `id` int(11) UNSIGNED NOT NULL,
  `descricao` varchar(100) NOT NULL,
  `sigla` varchar(7) NOT NULL,
  `bandeira` varchar(255) DEFAULT NULL,
  `updated_at` datetime DEFAULT current_timestamp(),
  `status` enum('0','1') NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `tb_sys_idioma`
--

INSERT INTO `tb_sys_idioma` (`id`, `descricao`, `sigla`, `bandeira`, `updated_at`, `status`) VALUES
(1, 'Português Brasil', 'pt-br', 'img/localidades/1612531977_220a6c6c090a89d743e9.jpg', '2021-03-07 19:20:44', '1'),
(2, 'English', 'en', 'img/localidades/1612531878_bd7502753e5de17e7b45.jpg', '2021-03-08 20:21:46', '1'),
(3, 'Húngaro', 'hr', 'img/localidades/1612531970_988317c9bd4ee27b70dc.jpg', '2021-03-07 22:06:18', '1');

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_sys_idioma_dicionario`
--

CREATE TABLE `tb_sys_idioma_dicionario` (
  `id` int(11) UNSIGNED NOT NULL,
  `id_idioma` int(11) UNSIGNED NOT NULL,
  `id_palavra` int(11) UNSIGNED NOT NULL,
  `traducao` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `tb_acl_grupo`
--
ALTER TABLE `tb_acl_grupo`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `grupo` (`grupo`);

--
-- Índices para tabela `tb_acl_menu`
--
ALTER TABLE `tb_acl_menu`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_tb_acl_menu_id_secao` (`id_secao`);

--
-- Índices para tabela `tb_acl_menu_grupo`
--
ALTER TABLE `tb_acl_menu_grupo`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id_menu` (`id_menu`,`id_grupo`),
  ADD KEY `fk_tb_acl_menu_grupo_id_grupo` (`id_grupo`);

--
-- Índices para tabela `tb_acl_menu_secao`
--
ALTER TABLE `tb_acl_menu_secao`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id_modulo` (`id_modulo`,`secao`,`slug`);

--
-- Índices para tabela `tb_acl_modulo`
--
ALTER TABLE `tb_acl_modulo`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `modulo` (`modulo`),
  ADD UNIQUE KEY `diretorio` (`diretorio`);

--
-- Índices para tabela `tb_acl_rotas`
--
ALTER TABLE `tb_acl_rotas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_tb_acl_rotas_id_menu` (`id_menu`);

--
-- Índices para tabela `tb_acl_usuario`
--
ALTER TABLE `tb_acl_usuario`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `login` (`login`),
  ADD KEY `fk_tb_acl_usuario_id_grupo` (`id_grupo`);

--
-- Índices para tabela `tb_acl_usuario_imagem`
--
ALTER TABLE `tb_acl_usuario_imagem`
  ADD PRIMARY KEY (`id_imagem`),
  ADD KEY `tb_acl_usuario_imagem_id_usuario` (`id_usuario`);

--
-- Índices para tabela `tb_album`
--
ALTER TABLE `tb_album`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `tb_album_foto`
--
ALTER TABLE `tb_album_foto`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_tb_album_foto_id_album` (`id_album`);

--
-- Índices para tabela `tb_banner`
--
ALTER TABLE `tb_banner`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `tb_cliente`
--
ALTER TABLE `tb_cliente`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `tb_cliente_email`
--
ALTER TABLE `tb_cliente_email`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tb_cliente_email_id_cliente` (`id_cliente`);

--
-- Índices para tabela `tb_cliente_telefone`
--
ALTER TABLE `tb_cliente_telefone`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tb_cliente_telefone_id_cliente` (`id_cliente`);

--
-- Índices para tabela `tb_distribuidor`
--
ALTER TABLE `tb_distribuidor`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `tb_distribuidor_email`
--
ALTER TABLE `tb_distribuidor_email`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_tb_distribuidor_email_id_distribuidor` (`id_distribuidor`);

--
-- Índices para tabela `tb_distribuidor_telefone`
--
ALTER TABLE `tb_distribuidor_telefone`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_tb_distribuidor_telefone_id_distribuidor` (`id_distribuidor`);

--
-- Índices para tabela `tb_email`
--
ALTER TABLE `tb_email`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `tb_empresa`
--
ALTER TABLE `tb_empresa`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `cnpj` (`cnpj`);

--
-- Índices para tabela `tb_lead`
--
ALTER TABLE `tb_lead`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tb_lead_id_cliente` (`id_cliente`),
  ADD KEY `tb_lead_id_produto` (`id_produto`);

--
-- Índices para tabela `tb_noticia`
--
ALTER TABLE `tb_noticia`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_tb_noticia_idioma` (`idioma`) USING BTREE,
  ADD KEY `fk_tb_noticia_id_menu` (`id_menu`);

--
-- Índices para tabela `tb_pagina`
--
ALTER TABLE `tb_pagina`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_tb_pagina_id_menu` (`id_menu`),
  ADD KEY `fk_tb_pagina_idioma` (`idioma`) USING BTREE;

--
-- Índices para tabela `tb_produto`
--
ALTER TABLE `tb_produto`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tb_produto_id_categoria` (`id_categoria`);

--
-- Índices para tabela `tb_produto_categoria`
--
ALTER TABLE `tb_produto_categoria`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `tb_sys_config`
--
ALTER TABLE `tb_sys_config`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`,`config`);

--
-- Índices para tabela `tb_sys_config_versao-1`
--
ALTER TABLE `tb_sys_config_versao-1`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `url` (`url`);

--
-- Índices para tabela `tb_sys_dicionario`
--
ALTER TABLE `tb_sys_dicionario`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `tb_sys_idioma`
--
ALTER TABLE `tb_sys_idioma`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `sigla` (`sigla`);

--
-- Índices para tabela `tb_sys_idioma_dicionario`
--
ALTER TABLE `tb_sys_idioma_dicionario`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_tb_sys_idioma_id_palavra` (`id_palavra`),
  ADD KEY `fk_tb_sys_idioma_id_idioma` (`id_idioma`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `tb_acl_grupo`
--
ALTER TABLE `tb_acl_grupo`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `tb_acl_menu`
--
ALTER TABLE `tb_acl_menu`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=83;

--
-- AUTO_INCREMENT de tabela `tb_acl_menu_grupo`
--
ALTER TABLE `tb_acl_menu_grupo`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `tb_acl_menu_secao`
--
ALTER TABLE `tb_acl_menu_secao`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `tb_acl_modulo`
--
ALTER TABLE `tb_acl_modulo`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `tb_acl_rotas`
--
ALTER TABLE `tb_acl_rotas`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `tb_acl_usuario`
--
ALTER TABLE `tb_acl_usuario`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de tabela `tb_acl_usuario_imagem`
--
ALTER TABLE `tb_acl_usuario_imagem`
  MODIFY `id_imagem` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `tb_album`
--
ALTER TABLE `tb_album`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `tb_album_foto`
--
ALTER TABLE `tb_album_foto`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Numero sequencial', AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de tabela `tb_banner`
--
ALTER TABLE `tb_banner`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Numero sequencial';

--
-- AUTO_INCREMENT de tabela `tb_cliente`
--
ALTER TABLE `tb_cliente`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `tb_cliente_email`
--
ALTER TABLE `tb_cliente_email`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `tb_cliente_telefone`
--
ALTER TABLE `tb_cliente_telefone`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `tb_distribuidor`
--
ALTER TABLE `tb_distribuidor`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `tb_distribuidor_email`
--
ALTER TABLE `tb_distribuidor_email`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `tb_distribuidor_telefone`
--
ALTER TABLE `tb_distribuidor_telefone`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `tb_email`
--
ALTER TABLE `tb_email`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `tb_empresa`
--
ALTER TABLE `tb_empresa`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Chave primária da tabela.', AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `tb_lead`
--
ALTER TABLE `tb_lead`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `tb_noticia`
--
ALTER TABLE `tb_noticia`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `tb_pagina`
--
ALTER TABLE `tb_pagina`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de tabela `tb_produto`
--
ALTER TABLE `tb_produto`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `tb_produto_categoria`
--
ALTER TABLE `tb_produto_categoria`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `tb_sys_config`
--
ALTER TABLE `tb_sys_config`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Número sequencial da tabela.', AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT de tabela `tb_sys_config_versao-1`
--
ALTER TABLE `tb_sys_config_versao-1`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `tb_sys_dicionario`
--
ALTER TABLE `tb_sys_dicionario`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `tb_sys_idioma`
--
ALTER TABLE `tb_sys_idioma`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de tabela `tb_sys_idioma_dicionario`
--
ALTER TABLE `tb_sys_idioma_dicionario`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `tb_acl_menu`
--
ALTER TABLE `tb_acl_menu`
  ADD CONSTRAINT `fk_tb_acl_menu_id_secao` FOREIGN KEY (`id_secao`) REFERENCES `tb_acl_menu_secao` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `tb_acl_menu_grupo`
--
ALTER TABLE `tb_acl_menu_grupo`
  ADD CONSTRAINT `fk_tb_acl_menu_grupo_id_grupo` FOREIGN KEY (`id_grupo`) REFERENCES `tb_acl_grupo` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_tb_acl_menu_grupo_id_menu` FOREIGN KEY (`id_menu`) REFERENCES `tb_acl_menu` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `tb_acl_menu_secao`
--
ALTER TABLE `tb_acl_menu_secao`
  ADD CONSTRAINT `fk_tb_acl_menu_secao_id_modulo` FOREIGN KEY (`id_modulo`) REFERENCES `tb_acl_modulo` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `tb_acl_rotas`
--
ALTER TABLE `tb_acl_rotas`
  ADD CONSTRAINT `fk_tb_acl_rotas_id_menu` FOREIGN KEY (`id_menu`) REFERENCES `tb_acl_menu` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `tb_acl_usuario`
--
ALTER TABLE `tb_acl_usuario`
  ADD CONSTRAINT `fk_tb_acl_usuario_id_grupo` FOREIGN KEY (`id_grupo`) REFERENCES `tb_acl_grupo` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `tb_acl_usuario_imagem`
--
ALTER TABLE `tb_acl_usuario_imagem`
  ADD CONSTRAINT `tb_acl_usuario_imagem_id_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `tb_acl_usuario` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `tb_album_foto`
--
ALTER TABLE `tb_album_foto`
  ADD CONSTRAINT `fk_tb_album_foto_id_album` FOREIGN KEY (`id_album`) REFERENCES `tb_album` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `tb_cliente_email`
--
ALTER TABLE `tb_cliente_email`
  ADD CONSTRAINT `tb_cliente_email_id_cliente` FOREIGN KEY (`id_cliente`) REFERENCES `tb_cliente` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `tb_cliente_telefone`
--
ALTER TABLE `tb_cliente_telefone`
  ADD CONSTRAINT `tb_cliente_telefone_id_cliente` FOREIGN KEY (`id_cliente`) REFERENCES `tb_cliente` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `tb_distribuidor_email`
--
ALTER TABLE `tb_distribuidor_email`
  ADD CONSTRAINT `fk_tb_distribuidor_email_id_distribuidor` FOREIGN KEY (`id_distribuidor`) REFERENCES `tb_distribuidor` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `tb_distribuidor_telefone`
--
ALTER TABLE `tb_distribuidor_telefone`
  ADD CONSTRAINT `fk_tb_distribuidor_telefone_id_distribuidor` FOREIGN KEY (`id_distribuidor`) REFERENCES `tb_distribuidor` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `tb_lead`
--
ALTER TABLE `tb_lead`
  ADD CONSTRAINT `tb_lead_id_cliente` FOREIGN KEY (`id_cliente`) REFERENCES `tb_cliente` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tb_lead_id_produto` FOREIGN KEY (`id_produto`) REFERENCES `tb_produto` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `tb_noticia`
--
ALTER TABLE `tb_noticia`
  ADD CONSTRAINT `fk_tb_noticia_id_menu` FOREIGN KEY (`id_menu`) REFERENCES `tb_acl_menu` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_tb_noticia_idioma` FOREIGN KEY (`idioma`) REFERENCES `tb_sys_idioma` (`sigla`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `tb_pagina`
--
ALTER TABLE `tb_pagina`
  ADD CONSTRAINT `fk_tb_pagina_id_menu` FOREIGN KEY (`id_menu`) REFERENCES `tb_acl_menu` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_tb_pagina_idioma` FOREIGN KEY (`idioma`) REFERENCES `tb_sys_idioma` (`sigla`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `tb_produto`
--
ALTER TABLE `tb_produto`
  ADD CONSTRAINT `tb_produto_id_categoria` FOREIGN KEY (`id_categoria`) REFERENCES `tb_produto_categoria` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `tb_sys_idioma_dicionario`
--
ALTER TABLE `tb_sys_idioma_dicionario`
  ADD CONSTRAINT `fk_tb_sys_idioma_id_idioma` FOREIGN KEY (`id_idioma`) REFERENCES `tb_sys_idioma` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_tb_sys_idioma_id_palavra` FOREIGN KEY (`id_palavra`) REFERENCES `tb_sys_dicionario` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
