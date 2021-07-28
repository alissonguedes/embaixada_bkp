-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Tempo de geração: 28-Jul-2021 às 16:39
-- Versão do servidor: 10.3.29-MariaDB-0ubuntu0.20.04.1-log
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
(73, 0, 2, 0, 'Página Inicial', '{\"en\":\"Home\",\"hr\":\"Honlap\",\"pt-br\":\"In\\u00edcio\"}', 'pagina-inicial', NULL, NULL, 1, 0000, '2021-07-22 19:06:23', '0', '1'),
(78, 0, 2, 0, 'Embaixada', '{\"en\":\"Embasy\",\"hr\":\"nagyk\\u00f6vets\\u00e9g\",\"pt-br\":\"Embaixada\"}', 'embaixada', NULL, NULL, 2, 0000, '2021-03-09 19:57:40', '0', '1'),
(79, 0, 2, 0, 'Sobre o site', '{\"en\":\"About\",\"hr\":\"Az oldalr\\u00f3l\",\"pt-br\":\"Sobre o site\"}', 'sobre-o-site', NULL, NULL, 3, 0000, '2021-07-27 06:05:12', '0', '1'),
(80, 0, 2, 0, 'Notícias', '{\"en\":\"News\",\"hr\":\"Noti\",\"pt-br\":\"Not\\u00edcias\"}', 'noticias', NULL, NULL, 4, 0000, '2021-07-22 19:28:14', '0', '1'),
(81, 0, 2, 0, 'Galeria de Fotos', '{\"en\":\"Photos\",\"hr\":\"Fot\\u00f3k\",\"pt-br\":\"Fotos\"}', 'galeria-de-fotos', NULL, NULL, 0, 0000, '2021-07-22 17:46:40', '0', '1');

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
  `ultimo_login` datetime DEFAULT NULL,
  `permissao` smallint(4) UNSIGNED ZEROFILL NOT NULL DEFAULT 0000,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status` enum('0','1') NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tabela para cadastro de usuários';

--
-- Extraindo dados da tabela `tb_acl_usuario`
--

INSERT INTO `tb_acl_usuario` (`id`, `id_grupo`, `id_gestor`, `nome`, `email`, `login`, `senha`, `salt`, `ultimo_login`, `permissao`, `updated_at`, `status`) VALUES
(3, 1, 0, 'Alisson', 'alissonguedes87@gmail.com', 'alisson', 'c7ad44cbad762a5da0a452f9e854fdc1e0e7a52a38015f23f3', NULL, '0000-00-00 00:00:00', 0000, '2021-03-13 06:25:25', '1'),
(4, 1, 0, 'Felipe', 'felipeweb@hotmail.com', 'felipeweb', 'c7ad44cbad762a5da0a452f9e854fdc1e0e7a52a38015f23f3', NULL, '0000-00-00 00:00:00', 0000, '2021-03-13 06:25:25', '1'),
(6, 2, 0, 'Isaac Brigano', 'isaacbrigano@email.com', 'isaacbrigano', 'd866fcd2a66112773d45e594e2b7be2c4e095a2c54419c78c1', NULL, '0000-00-00 00:00:00', 0000, '2021-07-06 21:16:57', '1');

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
  `titulo` varchar(255) DEFAULT NULL,
  `descricao` varchar(500) DEFAULT NULL,
  `imagem` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp(),
  `status` enum('0','1') NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `tb_album`
--

INSERT INTO `tb_album` (`id`, `nome`, `slug`, `titulo`, `descricao`, `imagem`, `created_at`, `updated_at`, `status`) VALUES
(12, 'teste', 'e42fa7ba757e260288344dbc6b45ddad0530bba9', '{\"en\":\"teste\",\"hr\":\"teste1\",\"pt-br\":\"teste2\"}', NULL, 'assets/embaixada/img/galeria/thumbs/23f8a915d897a42fed9a5f6c076801d0770c69c9.jpg', '2021-07-27 05:42:35', '2021-07-27 05:42:35', '1'),
(13, 'teste2', 'e74b28f505888d137aece0d78f07cbe71b9a07df', '{\"en\":\"teste\",\"hr\":\"teste2\",\"pt-br\":\"teste3\"}', NULL, 'assets/embaixada/img/galeria/thumbs/aa5ef8bfe600d24ddb3a30de33ca2e2eef991430.jpg', '2021-07-27 05:43:57', '2021-07-27 05:43:57', '1');

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_attachment`
--

CREATE TABLE `tb_attachment` (
  `id` int(11) UNSIGNED NOT NULL,
  `id_modulo` int(11) UNSIGNED NOT NULL COMMENT 'Chave estrangeira referente à tabela identificada na coluna `modulo`',
  `modulo` varchar(100) NOT NULL COMMENT 'Coluna que identifica a tabela ou página que está referenciando.',
  `path` varchar(255) NOT NULL,
  `realname` varchar(255) NOT NULL,
  `titulo` varchar(500) DEFAULT NULL COMMENT 'Título do arquivo',
  `descricao` text DEFAULT NULL COMMENT 'Texto descritivo do arquivo',
  `clicks` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Quantidade de clicks/visualizações do arquivo',
  `url` varchar(255) DEFAULT NULL COMMENT 'Um link externo para arquivo se houver',
  `size` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Tamanho do arquivo',
  `author` varchar(500) NOT NULL COMMENT 'Id do usuário que fez a importação do arquivo',
  `ordem` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Ordem para listagem para o caso de o arquivo for uma imagem e pertencer a um banner',
  `tags` varchar(200) DEFAULT NULL COMMENT 'Tags de pesquisa',
  `created_at` timestamp NULL DEFAULT current_timestamp() COMMENT 'Data de criação do arquivo',
  `updated_at` timestamp NULL DEFAULT current_timestamp() COMMENT 'Data a última modificação do arquivo',
  `status` enum('0','1') NOT NULL DEFAULT '1' COMMENT 'Situação de exibição do banner. 0 - Não exibir; 1 - Exibir.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
-- Estrutura da tabela `tb_link`
--

CREATE TABLE `tb_link` (
  `id` int(11) UNSIGNED NOT NULL,
  `titulo` varchar(255) NOT NULL,
  `descricao` varchar(500) NOT NULL,
  `slug` varchar(500) NOT NULL,
  `link` varchar(255) DEFAULT NULL,
  `imagem` varchar(255) DEFAULT NULL,
  `status` enum('0','1') NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tabela de adição de links rápidos do site';

--
-- Extraindo dados da tabela `tb_link`
--

INSERT INTO `tb_link` (`id`, `titulo`, `descricao`, `slug`, `link`, `imagem`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Quero obter um visto', '{\"en\":\"I want to get a visa\",\"hr\":\"Szeretn\\u00e9k v\\u00edzumot szerezni\",\"pt-br\":\"Quero obter um visto\"}', 'quero-obter-um-visto', NULL, 'assets/embaixada/links/92ab3940864627db856a9f920b327ca6e4bef983.png', '1', '2021-07-09 04:29:36', '2021-07-27 10:47:01'),
(2, 'Procuro serviços para cidadãos angolanos', '{\"en\":\"I\'m looking for services for Angolan citizens\",\"hr\":\"Szolg\\u00e1ltat\\u00e1sokat keresek angolai \\u00e1llampolg\\u00e1rok sz\\u00e1m\\u00e1ra\",\"pt-br\":\"Procuro servi\\u00e7os para cidad\\u00e3os angolanos\"}', 'procuro-servicos-para-cidadaos-angolanos', NULL, 'assets/embaixada/links/4f32e9cfbb6f3e7f796d25545b767e3cb037faf2.png', '1', '2021-07-09 04:32:50', '2021-07-27 10:46:30'),
(3, 'Quero estudar na Hungria', '{\"en\":\"I want to study in Hungary\",\"hr\":\"Magyarorsz\\u00e1gon szeretn\\u00e9k tanulni\",\"pt-br\":\"Quero estudar na Hungria\"}', 'quero-estudar-na-hungria', NULL, 'assets/embaixada/links/0d9180489fa55228acf69b37cd0ba215782afc32.png', '1', '2021-07-09 04:33:43', '2021-07-27 10:46:56'),
(4, 'Procuro oportunidades de negócios', '{\"en\":\"I\'m looking for business opportunities\",\"hr\":\"\\u00dczleti lehet\\u0151s\\u00e9geket keresek\",\"pt-br\":\"Procuro oportunidades de neg\\u00f3cios\"}', 'procuro-oportunidades-de-negocios', NULL, 'assets/embaixada/links/92ab3940864627db856a9f920b327ca6e4bef983.png', '1', '2021-07-09 04:34:23', '2021-07-27 10:46:41'),
(5, 'Quero visitar a Hungria', '{\"en\":\"I want to visit Hungary\",\"hr\":\"Magyarorsz\\u00e1gra akarok l\\u00e1togatni\",\"pt-br\":\"Quero visitar a Hungria\"}', 'quero-visitar-a-hungria', NULL, 'assets/embaixada/links/be455cd88fc46cb5882ade28af01bf09c741e1c8.png', '1', '2021-07-09 04:34:54', '2021-07-27 10:46:49'),
(6, 'Procuro informações sobre política Hungara', '{\"en\":\"I\'m looking for information on Hungarian politics\",\"hr\":\"Inform\\u00e1ci\\u00f3t keresek a magyar politik\\u00e1r\\u00f3l\",\"pt-br\":\"Procuro informa\\u00e7\\u00f5es sobre pol\\u00edtica Hungara\"}', 'procuro-informacoes-sobre-politica-hungara', NULL, 'assets/embaixada/links/f918dba21d265d1c17255955c11888c406ca8556.png', '1', '2021-07-09 04:35:28', '2021-07-27 10:46:38');

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_link_pagina`
--

CREATE TABLE `tb_link_pagina` (
  `id` int(11) UNSIGNED NOT NULL,
  `id_link` int(11) UNSIGNED NOT NULL,
  `id_pagina` int(11) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tabela para vincluar um link a uma página';

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

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_pagina`
--

CREATE TABLE `tb_pagina` (
  `id` int(11) UNSIGNED NOT NULL,
  `id_menu` int(11) UNSIGNED NOT NULL,
  `id_pagina` int(11) UNSIGNED DEFAULT 0,
  `tipo` varchar(20) NOT NULL DEFAULT 'post' COMMENT 'Informa o tipo de página: Página simples ou galeria de fotos',
  `descricao` varchar(500) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `titulo` text NOT NULL,
  `subtitulo` text DEFAULT NULL,
  `texto` longblob NOT NULL,
  `arquivo` text DEFAULT NULL,
  `idioma` varchar(5) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` enum('0','1') NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_pagina_album`
--

CREATE TABLE `tb_pagina_album` (
  `id` int(11) UNSIGNED NOT NULL COMMENT 'Numero sequencial',
  `id_album` int(11) UNSIGNED NOT NULL,
  `id_pagina` int(11) UNSIGNED DEFAULT NULL COMMENT 'Título principal do banner.',
  `created_at` timestamp NULL DEFAULT current_timestamp() COMMENT 'Data de criação do banner',
  `updated_at` timestamp NULL DEFAULT current_timestamp(),
  `status` enum('0','1') NOT NULL DEFAULT '1' COMMENT 'Situação de exibição do banner. 0 - Não exibir; 1 - Exibir.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


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
(1, 'site_logo', 'assets/embaixada/img/d52dadcd9688a4d77b152d5872f765f0db18bba4.jpg', '2021-03-09 19:55:51', '2021-07-28 00:38:09'),
(2, 'original_logo_name', '8525b5a07413f4e1aa2eda63bbf0bcb129b12b78.jpg', '2021-03-09 19:55:51', '2021-07-28 00:38:09'),
(3, 'site_title', 'EMBAIXADA DA REPÚBLICA DE ANGOLA NA HUNGRIA', '2021-03-09 19:55:51', '2021-07-28 00:47:05'),
(4, 'site_url', NULL, '2021-03-09 19:55:51', '2021-03-09 19:55:51'),
(5, 'language', 'en', '2021-03-09 19:55:51', '2021-07-28 01:44:48'),
(6, 'contact_email', 'teste', '2021-03-09 19:55:51', '2021-07-28 02:12:51'),
(7, 'contact_phone', '(12) 3412.2431', '2021-03-09 19:55:51', '2021-07-28 02:12:51'),
(8, 'contact_cel', '(12) 3 4134.1234', '2021-03-09 19:55:51', '2021-07-28 02:12:51'),
(9, 'facebook', NULL, '2021-03-09 19:55:51', '2021-03-09 19:55:51'),
(10, 'instagram', NULL, '2021-03-09 19:55:51', '2021-03-09 19:55:51'),
(11, 'linkedin', NULL, '2021-03-09 19:55:51', '2021-03-09 19:55:51'),
(12, 'address', 'teste', '2021-03-09 19:55:51', '2021-07-28 02:02:38'),
(13, 'address_nro', '15', '2021-03-09 19:55:51', '2021-07-28 02:02:38'),
(14, 'cep', '12345-667', '2021-03-09 19:55:51', '2021-07-28 02:11:32'),
(15, 'complemento', 'teste', '2021-03-09 19:55:51', '2021-07-28 02:11:32'),
(16, 'bairro', 'Teste', '2021-03-09 19:55:51', '2021-07-28 02:11:32'),
(17, 'cidade', 'Angola', '2021-03-09 19:55:51', '2021-07-28 02:11:32'),
(18, 'uf', 'AN', '2021-03-09 19:55:51', '2021-07-28 02:11:32'),
(19, 'gmaps', '<iframe src=\"https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d1664.5836546927305!2d-34.858389255410266!3d-7.117950406096949!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x7acdd56d3578e67%3A0x65c680df17fb4e42!2sHostDime%20Brasil!5e0!3m2!1spt-BR!2sbr!4v1615446431902!5m2!1spt-BR!2sbr\" width=\"600\" height=\"450\" style=\"border:0;\" allowfullscreen=\"\" loading=\"lazy\"></iframe>', '2021-03-09 19:55:51', '2021-03-11 10:07:25'),
(20, 'site_description', 'EMBAIXADA DA REPÚBLICA DE ANGOLA NA HUNGRIA', '2021-03-09 20:00:20', '2021-07-28 00:47:05'),
(21, 'site_tags', NULL, '2021-03-09 20:08:48', '2021-07-06 21:15:52'),
(22, 'pais', 'Angola', '2021-07-27 23:11:32', '2021-07-27 23:11:32');

-- --------------------------------------------------------

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
  `imagem` varchar(255) DEFAULT NULL,
  `updated_at` datetime DEFAULT current_timestamp(),
  `status` enum('0','1') NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `tb_sys_idioma`
--

INSERT INTO `tb_sys_idioma` (`id`, `descricao`, `sigla`, `imagem`, `updated_at`, `status`) VALUES
(1, 'Português', 'pt-br', 'assets/embaixada/img/galeria/thumbs/23f8a915d897a42fed9a5f6c076801d0770c69c9.jpg', '2021-07-27 22:42:21', '1'),
(2, 'English', 'en', 'assets/embaixada/img/localidades/8525b5a07413f4e1aa2eda63bbf0bcb129b12b78.jpg', '2021-07-22 19:23:28', '1'),
(3, 'Magyar', 'hr', 'assets/embaixada/img/galeria/thumbs/b63b57520df469ffaae87179b8b1cb9a0d83ebbd.jpg', '2021-07-22 19:24:40', '1');

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
-- Índices para tabela `tb_attachment`
--
ALTER TABLE `tb_attachment`
  ADD PRIMARY KEY (`id`);

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
-- Índices para tabela `tb_link`
--
ALTER TABLE `tb_link`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `tb_link_pagina`
--
ALTER TABLE `tb_link_pagina`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_tb_link_pagina_id_link` (`id_link`),
  ADD KEY `fk_tb_link_pagina_id_pagina` (`id_pagina`);

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
-- Índices para tabela `tb_pagina_album`
--
ALTER TABLE `tb_pagina_album`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_tb_album_foto_id_album` (`id_album`);

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
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de tabela `tb_acl_usuario_imagem`
--
ALTER TABLE `tb_acl_usuario_imagem`
  MODIFY `id_imagem` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `tb_album`
--
ALTER TABLE `tb_album`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de tabela `tb_attachment`
--
ALTER TABLE `tb_attachment`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=293;

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
-- AUTO_INCREMENT de tabela `tb_link`
--
ALTER TABLE `tb_link`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de tabela `tb_link_pagina`
--
ALTER TABLE `tb_link_pagina`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `tb_noticia`
--
ALTER TABLE `tb_noticia`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de tabela `tb_pagina`
--
ALTER TABLE `tb_pagina`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT de tabela `tb_pagina_album`
--
ALTER TABLE `tb_pagina_album`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Numero sequencial', AUTO_INCREMENT=15;

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
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Número sequencial da tabela.', AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT de tabela `tb_sys_dicionario`
--
ALTER TABLE `tb_sys_dicionario`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `tb_sys_idioma`
--
ALTER TABLE `tb_sys_idioma`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

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
-- Limitadores para a tabela `tb_link_pagina`
--
ALTER TABLE `tb_link_pagina`
  ADD CONSTRAINT `fk_tb_link_pagina_id_link` FOREIGN KEY (`id_link`) REFERENCES `tb_link` (`id`),
  ADD CONSTRAINT `fk_tb_link_pagina_id_pagina` FOREIGN KEY (`id_pagina`) REFERENCES `tb_pagina` (`id`);

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
-- Limitadores para a tabela `tb_pagina_album`
--
ALTER TABLE `tb_pagina_album`
  ADD CONSTRAINT `fk_tb_album_foto_id_album` FOREIGN KEY (`id_album`) REFERENCES `tb_album` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

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
