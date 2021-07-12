-- MySQL dump 10.19  Distrib 10.3.29-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: alissong_embaixada
-- ------------------------------------------------------
-- Server version	10.3.29-MariaDB-0ubuntu0.20.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `alissong_embaixada`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `alissong_embaixada` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;

USE `alissong_embaixada`;

--
-- Table structure for table `tb_acl_grupo`
--

DROP TABLE IF EXISTS `tb_acl_grupo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_acl_grupo` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `grupo` varchar(25) NOT NULL,
  `descricao` varchar(255) DEFAULT NULL,
  `permissao` smallint(4) unsigned zerofill NOT NULL DEFAULT 0000,
  `status` enum('0','1') NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `grupo` (`grupo`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='Tabela para cadastro de grupos de usuários.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_acl_grupo`
--

LOCK TABLES `tb_acl_grupo` WRITE;
/*!40000 ALTER TABLE `tb_acl_grupo` DISABLE KEYS */;
INSERT INTO `tb_acl_grupo` VALUES (1,'Super Administrador','Tem permissão total no sistema.',1111,'1'),(2,'Administrador','Há restrições para permissão exclusão de dados',0100,'1');
/*!40000 ALTER TABLE `tb_acl_grupo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_acl_menu`
--

DROP TABLE IF EXISTS `tb_acl_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_acl_menu` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_palavra` int(11) unsigned NOT NULL,
  `id_secao` int(11) unsigned NOT NULL,
  `id_parent` int(11) unsigned NOT NULL DEFAULT 0,
  `label` varchar(255) NOT NULL,
  `traducao` varchar(255) DEFAULT NULL,
  `link` varchar(255) NOT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `target` varchar(20) DEFAULT NULL,
  `ordem` int(11) NOT NULL DEFAULT 0,
  `permissao` smallint(4) unsigned zerofill NOT NULL DEFAULT 0000,
  `updated_at` datetime NOT NULL DEFAULT current_timestamp(),
  `editavel` enum('0','1') NOT NULL DEFAULT '1',
  `status` enum('0','1') NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `fk_tb_acl_menu_id_secao` (`id_secao`),
  CONSTRAINT `fk_tb_acl_menu_id_secao` FOREIGN KEY (`id_secao`) REFERENCES `tb_acl_menu_secao` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8 COMMENT='Tabela para cadastro de menus';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_acl_menu`
--

LOCK TABLES `tb_acl_menu` WRITE;
/*!40000 ALTER TABLE `tb_acl_menu` DISABLE KEYS */;
INSERT INTO `tb_acl_menu` VALUES (73,0,2,0,'Página Inicial','{\"en\":\"Home\",\"hr\":\"Honlap\",\"pt-br\":\"In\\u00edcio\"}','pagina-inicial',NULL,NULL,1,0000,'2021-03-09 19:57:40','0','1'),(78,0,2,0,'Embaixada','{\"en\":\"Embasy\",\"hr\":\"nagyk\\u00f6vets\\u00e9g\",\"pt-br\":\"Embaixada\"}','embaixada',NULL,NULL,2,0000,'2021-03-09 19:57:40','0','1'),(79,0,2,0,'Sobre o site','{\"en\":\"About\",\"hr\":\"Az oldalr\\u00f3l\",\"pt-br\":\"Sobre o site\"}','sobre-o-site',NULL,NULL,3,0000,'2021-03-11 08:26:28','0','1'),(80,0,2,0,'Notícias','{\"en\":\"News\",\"hr\":\"\",\"pt-br\":\"Not\\u00edcias\"}','noticias',NULL,NULL,4,0000,'2021-03-09 19:57:40','0','1'),(81,0,2,0,'Fotos','{\"en\":\"Photos\",\"hr\":\"Fot\\u00f3k\",\"pt-br\":\"Fotos\"}','fotos',NULL,NULL,0,0000,'2021-07-09 06:33:36','0','1');
/*!40000 ALTER TABLE `tb_acl_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_acl_menu_grupo`
--

DROP TABLE IF EXISTS `tb_acl_menu_grupo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_acl_menu_grupo` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_grupo` int(11) unsigned NOT NULL,
  `id_menu` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_menu` (`id_menu`,`id_grupo`),
  KEY `fk_tb_acl_menu_grupo_id_grupo` (`id_grupo`),
  CONSTRAINT `fk_tb_acl_menu_grupo_id_grupo` FOREIGN KEY (`id_grupo`) REFERENCES `tb_acl_grupo` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_tb_acl_menu_grupo_id_menu` FOREIGN KEY (`id_menu`) REFERENCES `tb_acl_menu` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tabela para atribuições de menus a grupos de usuários.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_acl_menu_grupo`
--

LOCK TABLES `tb_acl_menu_grupo` WRITE;
/*!40000 ALTER TABLE `tb_acl_menu_grupo` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_acl_menu_grupo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_acl_menu_secao`
--

DROP TABLE IF EXISTS `tb_acl_menu_secao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_acl_menu_secao` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_modulo` int(11) unsigned NOT NULL,
  `secao` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `descricao` varchar(255) DEFAULT NULL,
  `status` enum('0','1') NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_modulo` (`id_modulo`,`secao`,`slug`),
  CONSTRAINT `fk_tb_acl_menu_secao_id_modulo` FOREIGN KEY (`id_modulo`) REFERENCES `tb_acl_modulo` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='Tabela para cadastro de seções de menus. Seções correspondem ao local onde o menu se localizará: sidebar, header, footer, etc...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_acl_menu_secao`
--

LOCK TABLES `tb_acl_menu_secao` WRITE;
/*!40000 ALTER TABLE `tb_acl_menu_secao` DISABLE KEYS */;
INSERT INTO `tb_acl_menu_secao` VALUES (1,1,'Menu Principal','sidebar','Menu principal da área administrativa','1'),(2,2,'Main Principal','main-menu','Menu principal da área pública','1');
/*!40000 ALTER TABLE `tb_acl_menu_secao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_acl_modulo`
--

DROP TABLE IF EXISTS `tb_acl_modulo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_acl_modulo` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `modulo` varchar(50) NOT NULL,
  `diretorio` varchar(50) NOT NULL,
  `descricao` varchar(200) DEFAULT NULL,
  `status` enum('0','1') NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `modulo` (`modulo`),
  UNIQUE KEY `diretorio` (`diretorio`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='Tabela para cadastro de módulos. Módulos correspondem aos diretórios da aplicação: main, admin, etc...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_acl_modulo`
--

LOCK TABLES `tb_acl_modulo` WRITE;
/*!40000 ALTER TABLE `tb_acl_modulo` DISABLE KEYS */;
INSERT INTO `tb_acl_modulo` VALUES (1,'área administrativa','admin','Área administrativa do site','1'),(2,'área pública','main','Área pública do site','1');
/*!40000 ALTER TABLE `tb_acl_modulo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_acl_rotas`
--

DROP TABLE IF EXISTS `tb_acl_rotas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_acl_rotas` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_menu` int(11) unsigned NOT NULL,
  `type` enum('add','get','post','put','head','options','delete','patch','match','resource','map','group') NOT NULL DEFAULT 'add',
  `route` varchar(255) NOT NULL,
  `controller` varchar(255) NOT NULL,
  `filter` longtext DEFAULT NULL,
  `permissao` smallint(4) unsigned zerofill NOT NULL DEFAULT 0000,
  `status` enum('0','1') NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `fk_tb_acl_rotas_id_menu` (`id_menu`),
  CONSTRAINT `fk_tb_acl_rotas_id_menu` FOREIGN KEY (`id_menu`) REFERENCES `tb_acl_menu` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tabela para cadastro de rotas de menus.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_acl_rotas`
--

LOCK TABLES `tb_acl_rotas` WRITE;
/*!40000 ALTER TABLE `tb_acl_rotas` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_acl_rotas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_acl_usuario`
--

DROP TABLE IF EXISTS `tb_acl_usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_acl_usuario` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_grupo` int(11) unsigned NOT NULL,
  `id_gestor` int(11) unsigned NOT NULL DEFAULT 0,
  `nome` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `login` varchar(255) NOT NULL,
  `senha` varchar(255) NOT NULL,
  `salt` varchar(255) DEFAULT NULL,
  `ultimo_login` datetime DEFAULT NULL,
  `permissao` smallint(4) unsigned zerofill NOT NULL DEFAULT 0000,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status` enum('0','1') NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `login` (`login`),
  KEY `fk_tb_acl_usuario_id_grupo` (`id_grupo`),
  CONSTRAINT `fk_tb_acl_usuario_id_grupo` FOREIGN KEY (`id_grupo`) REFERENCES `tb_acl_grupo` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='Tabela para cadastro de usuários';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_acl_usuario`
--

LOCK TABLES `tb_acl_usuario` WRITE;
/*!40000 ALTER TABLE `tb_acl_usuario` DISABLE KEYS */;
INSERT INTO `tb_acl_usuario` VALUES (3,1,0,'Alisson','alissonguedes87@gmail.com','alisson','c7ad44cbad762a5da0a452f9e854fdc1e0e7a52a38015f23f3',NULL,'0000-00-00 00:00:00',0000,'2021-03-13 06:25:25','1'),(4,1,0,'Felipe','felipeweb@hotmail.com','felipeweb','c7ad44cbad762a5da0a452f9e854fdc1e0e7a52a38015f23f3',NULL,'0000-00-00 00:00:00',0000,'2021-03-13 06:25:25','1'),(6,2,0,'Isaac Brigano','isaacbrigano@email.com','isaacbrigano','d866fcd2a66112773d45e594e2b7be2c4e095a2c54419c78c1',NULL,'0000-00-00 00:00:00',0000,'2021-07-06 21:16:57','1');
/*!40000 ALTER TABLE `tb_acl_usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_acl_usuario_imagem`
--

DROP TABLE IF EXISTS `tb_acl_usuario_imagem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_acl_usuario_imagem` (
  `id_imagem` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) unsigned NOT NULL,
  `imagem` varchar(255) NOT NULL,
  `privada` enum('0','1') NOT NULL,
  `data_add` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id_imagem`),
  KEY `tb_acl_usuario_imagem_id_usuario` (`id_usuario`),
  CONSTRAINT `tb_acl_usuario_imagem_id_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `tb_acl_usuario` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_acl_usuario_imagem`
--

LOCK TABLES `tb_acl_usuario_imagem` WRITE;
/*!40000 ALTER TABLE `tb_acl_usuario_imagem` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_acl_usuario_imagem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_album`
--

DROP TABLE IF EXISTS `tb_album`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_album` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `titulo` varchar(255) DEFAULT NULL,
  `descricao` varchar(500) DEFAULT NULL,
  `imagem` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp(),
  `status` enum('0','1') NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_album`
--

LOCK TABLES `tb_album` WRITE;
/*!40000 ALTER TABLE `tb_album` DISABLE KEYS */;
INSERT INTO `tb_album` VALUES (2,'teste2','96a62ca98bdec7f55343f8cfa594379bdba76cc960e49ced0fc0d','{\"en\":\"Teste2\",\"hr\":\"teste23\",\"pt-br\":\"teste2\"}',NULL,'assets/embaixada/img/galeria/thumbs/16a035d0723629020fb36c15e5f558854353ee0b.jpg','2021-03-09 05:54:27','2021-07-06 21:13:58','1'),(3,'Novo Álbum de teste','27d68c2cee3738ac87a185145f51ad8f8c6cb00960e49ecccd2c4','{\"en\":\"New tester album\",\"hr\":\"New Album tester hungaro\",\"pt-br\":\"Novo \\u00c1lbum\"}',NULL,'assets/embaixada/img/fotos/8aedb38ce4afe798e63f421bf1c2b63be8ebc221.png','2021-07-06 18:19:48','2021-07-06 21:19:56','1'),(6,'Novo','6331c8b60c3743e973b672e494c96d7467224429','{\"en\":\"teste\",\"hr\":\"teste2\",\"pt-br\":\"teste3\"}',NULL,'assets/embaixada/img/galeria/thumbs/3d94f6192fa75f41d422cb23a9d7e5c04b9c4b4b.png','2021-07-06 18:26:56','2021-07-06 18:26:56','1'),(7,'teste','2e6f9b0d5885b6010f9167787445617f553a735f60e7f1a8b59bd','{\"en\":\" sfg\",\"hr\":\"\",\"pt-br\":\"s\"}',NULL,'assets/embaixada/img/galeria/thumbs/3d94f6192fa75f41d422cb23a9d7e5c04b9c4b4b.png','2021-07-06 18:27:44','2021-07-09 09:50:16','1'),(8,'mais um teste','b53f464d8651bc2349f361e53e8948d37ab6b7df','{\"en\":\"teste1\",\"hr\":\"teste2\",\"pt-br\":\"teste3\"}',NULL,'assets/embaixada/img/galeria/thumbs/3d94f6192fa75f41d422cb23a9d7e5c04b9c4b4b.png','2021-07-06 18:28:30','2021-07-06 18:28:30','1'),(9,'mais um teste1','9326da5d47503a58ef8abda5d5875c8c815deba6','{\"en\":\"teste1\",\"hr\":\"teste2\",\"pt-br\":\"teste3\"}',NULL,'assets/embaixada/img/galeria/thumbs/3d94f6192fa75f41d422cb23a9d7e5c04b9c4b4b.png','2021-07-06 18:29:31','2021-07-06 18:29:31','1');
/*!40000 ALTER TABLE `tb_album` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_attachment`
--

DROP TABLE IF EXISTS `tb_attachment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_attachment` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_modulo` int(11) unsigned NOT NULL COMMENT 'Chave estrangeira referente à tabela identificada na coluna `modulo`',
  `modulo` varchar(100) NOT NULL COMMENT 'Coluna que identifica a tabela ou página que está referenciando.',
  `path` varchar(255) NOT NULL,
  `realname` varchar(255) NOT NULL,
  `titulo` varchar(500) DEFAULT NULL COMMENT 'Título do arquivo',
  `descricao` text DEFAULT NULL COMMENT 'Texto descritivo do arquivo',
  `clicks` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'Quantidade de clicks/visualizações do arquivo',
  `url` varchar(255) DEFAULT NULL COMMENT 'Um link externo para arquivo se houver',
  `size` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'Tamanho do arquivo',
  `author` varchar(500) NOT NULL COMMENT 'Id do usuário que fez a importação do arquivo',
  `ordem` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'Ordem para listagem para o caso de o arquivo for uma imagem e pertencer a um banner',
  `tags` varchar(200) DEFAULT NULL COMMENT 'Tags de pesquisa',
  `created_at` timestamp NULL DEFAULT current_timestamp() COMMENT 'Data de criação do arquivo',
  `updated_at` timestamp NULL DEFAULT current_timestamp() COMMENT 'Data a última modificação do arquivo',
  `status` enum('0','1') NOT NULL DEFAULT '1' COMMENT 'Situação de exibição do banner. 0 - Não exibir; 1 - Exibir.',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=254 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_attachment`
--

LOCK TABLES `tb_attachment` WRITE;
/*!40000 ALTER TABLE `tb_attachment` DISABLE KEYS */;
INSERT INTO `tb_attachment` VALUES (154,6,'page','assets/embaixada/documentos/49eaccb83f7d5f809f0d07a0341b3ea29c06c22960e3a0101467d.pdf','rel_boletobancariotcr_01_07_2021_01_56_14.pdf',NULL,NULL,0,NULL,9724,'Alisson',0,NULL,'2021-07-06 00:13:04','2021-07-06 00:13:04','1'),(155,6,'page','assets/embaixada/documentos/0692b582f27233ace97d8579cd65b7ccc161ea8660e3a010148cf.pdf','rel_boletobancariotcr_01_07_2021_01_54_14.pdf',NULL,NULL,0,NULL,9707,'Alisson',0,NULL,'2021-07-06 00:13:04','2021-07-06 00:13:04','1'),(156,6,'page','assets/embaixada/documentos/d6dae978a0ba12a64c15e0c72a2ac5eb4e36924360e3a01014985.pdf','rel_boletobancarioiptu_01_07_2021_01_56_33.pdf',NULL,NULL,0,NULL,9721,'Alisson',0,NULL,'2021-07-06 00:13:04','2021-07-06 00:13:04','1'),(157,6,'page','assets/embaixada/documentos/18d287ceb997f67b4630d7437016bfc4234503ba60e3a01014a10.pdf','rel_boletobancarioiptu_01_07_2021_01_53_42.pdf',NULL,NULL,0,NULL,41404,'Alisson',0,NULL,'2021-07-06 00:13:04','2021-07-06 00:13:04','1'),(158,6,'page','assets/embaixada/documentos/45b50b0ee5306d2317e83d81d9e6f6011889dc6660e3a01014ae0.pdf','rel_boletobancarioiptu_01_07_2021_01_51_29.pdf',NULL,NULL,0,NULL,9718,'Alisson',0,NULL,'2021-07-06 00:13:04','2021-07-06 00:13:04','1'),(159,6,'page','assets/embaixada/documentos/57ee2d086f25f4638dbef5e746db27003795b37c60e3a01014b80.xls','rel_896205.xls',NULL,NULL,0,NULL,1984,'Alisson',0,NULL,'2021-07-06 00:13:04','2021-07-06 00:13:04','1'),(160,6,'page','assets/embaixada/documentos/b466713c9346360e29b619cfe65366f1078c17d560e3a01014c04.csv','rel_841051.csv',NULL,NULL,0,NULL,0,'Alisson',0,NULL,'2021-07-06 00:13:04','2021-07-06 00:13:04','1'),(161,6,'page','assets/embaixada/documentos/670d249ad31a2727507e2aab2e5715e70747ab9860e3a01014c65.xls','rel_823630.xls',NULL,NULL,0,NULL,51903,'Alisson',0,NULL,'2021-07-06 00:13:04','2021-07-06 00:13:04','1'),(162,6,'page','assets/embaixada/documentos/731b5aacda0190c6382bcd9a85f22f9e60a69c4c60e3a01014d41.csv','rel_784262.csv',NULL,NULL,0,NULL,0,'Alisson',0,NULL,'2021-07-06 00:13:04','2021-07-06 00:13:04','1'),(163,6,'page','assets/embaixada/documentos/420a760869eb1f85f255afbb4cc521e16a46d35660e3a01014dba.xls','rel_780284.xls',NULL,NULL,0,NULL,41600,'Alisson',0,NULL,'2021-07-06 00:13:04','2021-07-06 00:13:04','1'),(164,6,'page','assets/embaixada/documentos/44ac54b762a7c5a42a99b841094bc3ed633e79bd60e3a01014e82.csv','rel_760642.csv',NULL,NULL,0,NULL,0,'Alisson',0,NULL,'2021-07-06 00:13:04','2021-07-06 00:13:04','1'),(165,6,'page','assets/embaixada/documentos/4a43eafb1dedd740376ccbf1a496e5ab7fd6deb460e3a01014eed.csv','rel_743004.csv',NULL,NULL,0,NULL,740,'Alisson',0,NULL,'2021-07-06 00:13:04','2021-07-06 00:13:04','1'),(166,6,'page','assets/embaixada/documentos/3e602cefe940eb0f42d5df99c96db8c59f5afd8960e3a01014f5c.csv','rel_738499.csv',NULL,NULL,0,NULL,55536,'Alisson',0,NULL,'2021-07-06 00:13:04','2021-07-06 00:13:04','1'),(167,6,'page','assets/embaixada/documentos/c4a008e1b070ff76ca6eb49413b3d2211cce0f5b60e3a01015013.xls','rel_738276.xls',NULL,NULL,0,NULL,25595,'Alisson',0,NULL,'2021-07-06 00:13:04','2021-07-06 00:13:04','1'),(168,6,'page','assets/embaixada/documentos/292a23e290d50258fcc8662da1ed0af019731efe60e3a0101508b.xls','rel_734579.xls',NULL,NULL,0,NULL,58637,'Alisson',0,NULL,'2021-07-06 00:13:04','2021-07-06 00:13:04','1'),(169,6,'page','assets/embaixada/documentos/cacc15c33da9cfa0ab129f9043cc2dc72f94018760e3a0101511c.xls','rel_722399.xls',NULL,NULL,0,NULL,2652,'Alisson',0,NULL,'2021-07-06 00:13:04','2021-07-06 00:13:04','1'),(170,6,'page','assets/embaixada/documentos/21caa7593e72d7c4f3ec7ebf2f4792e9a63515a460e3a01015177.csv','rel_704317.csv',NULL,NULL,0,NULL,739,'Alisson',0,NULL,'2021-07-06 00:13:04','2021-07-06 00:13:04','1'),(171,6,'page','assets/embaixada/documentos/c2dff4c177c21ae979b297e9f708aac9d69ef2cb60e3a010151d1.xls','rel_700498.xls',NULL,NULL,0,NULL,58277,'Alisson',0,NULL,'2021-07-06 00:13:04','2021-07-06 00:13:04','1'),(172,6,'page','assets/embaixada/documentos/77afdf6761120bc8bf653fa79c9575f8290228b460e3a01015258.csv','rel_685089.csv',NULL,NULL,0,NULL,739,'Alisson',0,NULL,'2021-07-06 00:13:04','2021-07-06 00:13:04','1'),(173,6,'page','assets/embaixada/documentos/1e1132f8d6feaef1524897f4684e83fe0ac368b360e3a010152b4.xls','rel_655970.xls',NULL,NULL,0,NULL,9536,'Alisson',0,NULL,'2021-07-06 00:13:04','2021-07-06 00:13:04','1'),(174,6,'page','assets/embaixada/documentos/2437e1b77f22649ef7f6ca9af366a6fb335ee97160e3a01015316.xls','rel_652100.xls',NULL,NULL,0,NULL,17460,'Alisson',0,NULL,'2021-07-06 00:13:04','2021-07-06 00:13:04','1'),(175,6,'page','assets/embaixada/documentos/14e97f15790cb8cb0231a9bdcd64534c4173630660e3a01015381.xls','rel_595131.xls',NULL,NULL,0,NULL,2652,'Alisson',0,NULL,'2021-07-06 00:13:04','2021-07-06 00:13:04','1'),(176,6,'page','assets/embaixada/documentos/2253653c0b7f0a2b871227fecbe928d890742c7660e3a010153ed.xls','rel_590806.xls',NULL,NULL,0,NULL,58526,'Alisson',0,NULL,'2021-07-06 00:13:04','2021-07-06 00:13:04','1'),(177,6,'page','assets/embaixada/documentos/7920426c8630dde8e1aad9c42b8e297486f804d960e3a0101547a.csv','rel_534247.csv',NULL,NULL,0,NULL,0,'Alisson',0,NULL,'2021-07-06 00:13:04','2021-07-06 00:13:04','1'),(178,6,'page','assets/embaixada/documentos/e0ea4c9d56b10904e507af81d2df1461affb86a160e3a010154c2.csv','rel_533523.csv',NULL,NULL,0,NULL,1492,'Alisson',0,NULL,'2021-07-06 00:13:04','2021-07-06 00:13:04','1'),(179,6,'page','assets/embaixada/documentos/679112da676f9f86712cc3b4fda4f644ddd6e13060e3a0101551b.csv','rel_524043.csv',NULL,NULL,0,NULL,216,'Alisson',0,NULL,'2021-07-06 00:13:04','2021-07-06 00:13:04','1'),(180,6,'page','assets/embaixada/documentos/11de9812e020c8cd2a2f387789d5e0ecaf21b0cd60e3a01015575.csv','rel_496186.csv',NULL,NULL,0,NULL,2142,'Alisson',0,NULL,'2021-07-06 00:13:04','2021-07-06 00:13:04','1'),(181,6,'page','assets/embaixada/documentos/e21592c4c678c728862458e8707a6e52c99eb37560e3a010155d1.csv','rel_481740.csv',NULL,NULL,0,NULL,56868,'Alisson',0,NULL,'2021-07-06 00:13:04','2021-07-06 00:13:04','1'),(182,6,'page','assets/embaixada/documentos/32b2e881fd93e5c3ee075e702d927dfd7197c24360e3a0101565e.csv','rel_477660.csv',NULL,NULL,0,NULL,0,'Alisson',0,NULL,'2021-07-06 00:13:04','2021-07-06 00:13:04','1'),(183,6,'page','assets/embaixada/documentos/91080d83dd337732a37f884e25e339164b525c0b60e3a010156ac.xls','rel_453884.xls',NULL,NULL,0,NULL,16915,'Alisson',0,NULL,'2021-07-06 00:13:04','2021-07-06 00:13:04','1'),(184,6,'page','assets/embaixada/documentos/281057f16548dc7018bb0799a35a4d8dd7471abf60e3a01015716.xls','rel_451383.xls',NULL,NULL,0,NULL,17953,'Alisson',0,NULL,'2021-07-06 00:13:04','2021-07-06 00:13:04','1'),(185,6,'page','assets/embaixada/documentos/387a25b7bcbb74b127030f4f598c6047562344f660e3a0101577e.xls','rel_447027.xls',NULL,NULL,0,NULL,41304,'Alisson',0,NULL,'2021-07-06 00:13:04','2021-07-06 00:13:04','1'),(186,6,'page','assets/embaixada/documentos/2a1560c9fae7d35524ab012fcb7abd8a813ef26360e3a010157fa.csv','rel_434019.csv',NULL,NULL,0,NULL,0,'Alisson',0,NULL,'2021-07-06 00:13:04','2021-07-06 00:13:04','1'),(187,6,'page','assets/embaixada/documentos/9d95434f0ce6a17e04ee0d460498b6b9e2adef3f60e3a01015841.xls','rel_432949.xls',NULL,NULL,0,NULL,17334,'Alisson',0,NULL,'2021-07-06 00:13:04','2021-07-06 00:13:04','1'),(188,6,'page','assets/embaixada/documentos/765ceb624fcefdcb4a2b79986d7887ba93eabab360e3a010158ae.xls','rel_390856.xls',NULL,NULL,0,NULL,1984,'Alisson',0,NULL,'2021-07-06 00:13:04','2021-07-06 00:13:04','1'),(189,6,'page','assets/embaixada/documentos/d3c198386c2277aeaebf31d886d7a34be5fe5c5d60e3a01015909.csv','rel_388444.csv',NULL,NULL,0,NULL,408,'Alisson',0,NULL,'2021-07-06 00:13:04','2021-07-06 00:13:04','1'),(190,6,'page','assets/embaixada/documentos/2268405646b5fe7ce87fe263729a4d3cdda6074a60e3a01015962.csv','rel_302265.csv',NULL,NULL,0,NULL,56868,'Alisson',0,NULL,'2021-07-06 00:13:04','2021-07-06 00:13:04','1'),(191,6,'page','assets/embaixada/documentos/8bd13f77435613b2f5ba9d2683439776c9375da860e3a010159e6.xls','rel_278508.xls',NULL,NULL,0,NULL,51903,'Alisson',0,NULL,'2021-07-06 00:13:04','2021-07-06 00:13:04','1'),(192,6,'page','assets/embaixada/documentos/971e4d9b2144759d47dd5f225d8646b7881b20d660e3a01015a6e.xls','rel_230863.xls',NULL,NULL,0,NULL,7280,'Alisson',0,NULL,'2021-07-06 00:13:04','2021-07-06 00:13:04','1'),(193,6,'page','assets/embaixada/documentos/3ede4c00919d1c1ccb1dd28fa20fa5574477673160e3a01015acd.xls','rel_225979.xls',NULL,NULL,0,NULL,21643,'Alisson',0,NULL,'2021-07-06 00:13:04','2021-07-06 00:13:04','1'),(194,6,'page','assets/embaixada/documentos/e1303f66d2364e104f43ab406f67369191d1c7a660e3a01015b37.csv','rel_215741.csv',NULL,NULL,0,NULL,56868,'Alisson',0,NULL,'2021-07-06 00:13:04','2021-07-06 00:13:04','1'),(195,6,'page','assets/embaixada/documentos/c0cee3db7f7faca97f4972247d51eaeb8806909360e3a01015bbc.xls','rel_166037.xls',NULL,NULL,0,NULL,16493,'Alisson',0,NULL,'2021-07-06 00:13:04','2021-07-06 00:13:04','1'),(196,6,'page','assets/embaixada/documentos/c557bd9b738698124ec60f0d7d10011a5a28556b60e3a01015c23.csv','rel_136555.csv',NULL,NULL,0,NULL,972,'Alisson',0,NULL,'2021-07-06 00:13:04','2021-07-06 00:13:04','1'),(197,6,'page','assets/embaixada/documentos/36e3d2b69062f217b550f67badd419593699cebd60e3a01015c82.xls','rel_134579.xls',NULL,NULL,0,NULL,58277,'Alisson',0,NULL,'2021-07-06 00:13:04','2021-07-06 00:13:04','1'),(198,6,'page','assets/embaixada/documentos/8b931da4211b0dbbf4491aae9f8ffc26ca257d4360e3a01015d0b.csv','rel_122921.csv',NULL,NULL,0,NULL,4650,'Alisson',0,NULL,'2021-07-06 00:13:04','2021-07-06 00:13:04','1'),(199,6,'page','assets/embaixada/documentos/13f1a4a46886830298047d2cf0371bccbb0fd36a60e3a01015d6d.xls','rel_122787.xls',NULL,NULL,0,NULL,49777,'Alisson',0,NULL,'2021-07-06 00:13:04','2021-07-06 00:13:04','1'),(200,6,'page','assets/embaixada/documentos/c16057be3445250fbba2ee170ef4537e50811f5860e3a01015df6.sql','devcontratos.sql',NULL,NULL,0,NULL,665037,'Alisson',0,NULL,'2021-07-06 00:13:04','2021-07-06 00:13:04','1'),(201,6,'page','assets/embaixada/documentos/a5234244bb68dbde680132a7c538b73f5ba33cfa60e3a01016075.pdf','boletoparcelamentodebito_01_07_2021_01_58_44.pdf',NULL,NULL,0,NULL,10583,'Alisson',0,NULL,'2021-07-06 00:13:04','2021-07-06 00:13:04','1'),(202,6,'page','assets/embaixada/documentos/61719d882ae38fe43150feff9008b0fed217b6cf60e3a010160f4.csv','21_exemplo_de_demanda_2_campos.csv',NULL,NULL,0,NULL,333707,'Alisson',0,NULL,'2021-07-06 00:13:04','2021-07-06 00:13:04','1'),(219,1,'album','assets/embaixada/img/galeria/2e6f9b0d5885b6010f9167787445617f553a735f/abf633ddbf9c01d32d113e0d51da62cbf19c7d6c.jpg','alisson_2.jpg',NULL,NULL,0,NULL,11384801,'Alisson',0,NULL,'2021-07-06 01:07:19','2021-07-06 01:07:19','1'),(220,1,'album','assets/embaixada/img/galeria/2e6f9b0d5885b6010f9167787445617f553a735f/5a5a1783689e098316d57eaf6f02bab2a36abddb.jpg','alisson_1.jpg',NULL,NULL,0,NULL,10571183,'Alisson',0,NULL,'2021-07-06 01:07:19','2021-07-06 01:07:19','1'),(221,2,'album','assets/embaixada/img/galeria/2/abf633ddbf9c01d32d113e0d51da62cbf19c7d6c.jpg','alisson_2.jpg',NULL,NULL,0,NULL,11384801,'Alisson',0,NULL,'2021-07-06 01:38:40','2021-07-06 01:38:40','1'),(222,2,'album','assets/embaixada/img/galeria/2/5a5a1783689e098316d57eaf6f02bab2a36abddb.jpg','alisson_1.jpg',NULL,NULL,0,NULL,10571183,'Alisson',0,NULL,'2021-07-06 01:38:40','2021-07-06 01:38:40','1'),(223,2,'album','assets/embaixada/img/galeria/2/a49bdb5edc7b780eb092a4728bcd0a7a609ee753.png','captura_de_tela_de_2021_07_01_16_49_46.png',NULL,NULL,0,NULL,125128,'Alisson',0,NULL,'2021-07-06 17:19:24','2021-07-06 17:19:24','1'),(224,2,'album','assets/embaixada/img/galeria/2/52f08bf48d4f69885ab96b04d62d5976ebbf0a33.png','captura_de_tela_de_2021_07_01_16_49_43.png',NULL,NULL,0,NULL,24467,'Alisson',0,NULL,'2021-07-06 17:19:24','2021-07-06 17:19:24','1'),(225,2,'album','assets/embaixada/img/galeria/2/38be193aa2efd49dfd53e006fc86fbfa704e597d.png','captura_de_tela_de_2021_06_29_19_22_05.png',NULL,NULL,0,NULL,271044,'Alisson',0,NULL,'2021-07-06 17:19:24','2021-07-06 17:19:24','1'),(226,2,'album','assets/embaixada/img/galeria/2/4d3a29d24414cd217cd0eaa6402057f9b09dcbae.png','captura_de_tela_de_2021_06_29_19_10_48.png',NULL,NULL,0,NULL,277276,'Alisson',0,NULL,'2021-07-06 17:19:24','2021-07-06 17:19:24','1'),(227,2,'album','assets/embaixada/img/galeria/2/dff6e2eede51175c88f38ab1bb00c0362610730c.png','captura_de_tela_de_2021_06_17_19_19_59.png',NULL,NULL,0,NULL,155689,'Alisson',0,NULL,'2021-07-06 17:19:24','2021-07-06 17:19:24','1'),(228,3,'album','assets/embaixada/img/galeria/3/a49bdb5edc7b780eb092a4728bcd0a7a609ee753.png','captura_de_tela_de_2021_07_01_16_49_46.png',NULL,NULL,0,NULL,125128,'Alisson',0,NULL,'2021-07-06 18:19:56','2021-07-06 18:19:56','1'),(229,3,'album','assets/embaixada/img/galeria/3/52f08bf48d4f69885ab96b04d62d5976ebbf0a33.png','captura_de_tela_de_2021_07_01_16_49_43.png',NULL,NULL,0,NULL,24467,'Alisson',0,NULL,'2021-07-06 18:19:56','2021-07-06 18:19:56','1'),(230,3,'album','assets/embaixada/img/galeria/3/38be193aa2efd49dfd53e006fc86fbfa704e597d.png','captura_de_tela_de_2021_06_29_19_22_05.png',NULL,NULL,0,NULL,271044,'Alisson',0,NULL,'2021-07-06 18:19:56','2021-07-06 18:19:56','1'),(231,3,'album','assets/embaixada/img/galeria/3/4d3a29d24414cd217cd0eaa6402057f9b09dcbae.png','captura_de_tela_de_2021_06_29_19_10_48.png',NULL,NULL,0,NULL,277276,'Alisson',0,NULL,'2021-07-06 18:19:56','2021-07-06 18:19:56','1'),(232,3,'album','assets/embaixada/img/galeria/3/dff6e2eede51175c88f38ab1bb00c0362610730c.png','captura_de_tela_de_2021_06_17_19_19_59.png',NULL,NULL,0,NULL,155689,'Alisson',0,NULL,'2021-07-06 18:19:56','2021-07-06 18:19:56','1'),(233,6,'album','assets/embaixada/img/galeria/6/a49bdb5edc7b780eb092a4728bcd0a7a609ee753.png','captura_de_tela_de_2021_07_01_16_49_46.png',NULL,NULL,0,NULL,125128,'Alisson',0,NULL,'2021-07-06 18:26:56','2021-07-06 18:26:56','1'),(234,6,'album','assets/embaixada/img/galeria/6/52f08bf48d4f69885ab96b04d62d5976ebbf0a33.png','captura_de_tela_de_2021_07_01_16_49_43.png',NULL,NULL,0,NULL,24467,'Alisson',0,NULL,'2021-07-06 18:26:56','2021-07-06 18:26:56','1'),(235,6,'album','assets/embaixada/img/galeria/6/38be193aa2efd49dfd53e006fc86fbfa704e597d.png','captura_de_tela_de_2021_06_29_19_22_05.png',NULL,NULL,0,NULL,271044,'Alisson',0,NULL,'2021-07-06 18:26:56','2021-07-06 18:26:56','1'),(236,6,'album','assets/embaixada/img/galeria/6/4d3a29d24414cd217cd0eaa6402057f9b09dcbae.png','captura_de_tela_de_2021_06_29_19_10_48.png',NULL,NULL,0,NULL,277276,'Alisson',0,NULL,'2021-07-06 18:26:56','2021-07-06 18:26:56','1'),(237,6,'album','assets/embaixada/img/galeria/6/dff6e2eede51175c88f38ab1bb00c0362610730c.png','captura_de_tela_de_2021_06_17_19_19_59.png',NULL,NULL,0,NULL,155689,'Alisson',0,NULL,'2021-07-06 18:26:56','2021-07-06 18:26:56','1'),(238,8,'album','assets/embaixada/img/galeria/8/a49bdb5edc7b780eb092a4728bcd0a7a609ee753.png','captura_de_tela_de_2021_07_01_16_49_46.png',NULL,NULL,0,NULL,125128,'Alisson',0,NULL,'2021-07-06 18:28:30','2021-07-06 18:28:30','1'),(239,8,'album','assets/embaixada/img/galeria/8/52f08bf48d4f69885ab96b04d62d5976ebbf0a33.png','captura_de_tela_de_2021_07_01_16_49_43.png',NULL,NULL,0,NULL,24467,'Alisson',0,NULL,'2021-07-06 18:28:30','2021-07-06 18:28:30','1'),(240,8,'album','assets/embaixada/img/galeria/8/38be193aa2efd49dfd53e006fc86fbfa704e597d.png','captura_de_tela_de_2021_06_29_19_22_05.png',NULL,NULL,0,NULL,271044,'Alisson',0,NULL,'2021-07-06 18:28:31','2021-07-06 18:28:31','1'),(241,8,'album','assets/embaixada/img/galeria/8/4d3a29d24414cd217cd0eaa6402057f9b09dcbae.png','captura_de_tela_de_2021_06_29_19_10_48.png',NULL,NULL,0,NULL,277276,'Alisson',0,NULL,'2021-07-06 18:28:31','2021-07-06 18:28:31','1'),(242,8,'album','assets/embaixada/img/galeria/8/dff6e2eede51175c88f38ab1bb00c0362610730c.png','captura_de_tela_de_2021_06_17_19_19_59.png',NULL,NULL,0,NULL,155689,'Alisson',0,NULL,'2021-07-06 18:28:31','2021-07-06 18:28:31','1'),(243,9,'album','assets/embaixada/img/galeria/9/a49bdb5edc7b780eb092a4728bcd0a7a609ee753.png','captura_de_tela_de_2021_07_01_16_49_46.png',NULL,NULL,0,NULL,125128,'Alisson',0,NULL,'2021-07-06 18:29:31','2021-07-06 18:29:31','1'),(244,9,'album','assets/embaixada/img/galeria/9/52f08bf48d4f69885ab96b04d62d5976ebbf0a33.png','captura_de_tela_de_2021_07_01_16_49_43.png',NULL,NULL,0,NULL,24467,'Alisson',0,NULL,'2021-07-06 18:29:31','2021-07-06 18:29:31','1'),(245,9,'album','assets/embaixada/img/galeria/9/38be193aa2efd49dfd53e006fc86fbfa704e597d.png','captura_de_tela_de_2021_06_29_19_22_05.png',NULL,NULL,0,NULL,271044,'Alisson',0,NULL,'2021-07-06 18:29:31','2021-07-06 18:29:31','1'),(246,9,'album','assets/embaixada/img/galeria/9/4d3a29d24414cd217cd0eaa6402057f9b09dcbae.png','captura_de_tela_de_2021_06_29_19_10_48.png',NULL,NULL,0,NULL,277276,'Alisson',0,NULL,'2021-07-06 18:29:31','2021-07-06 18:29:31','1'),(247,9,'album','assets/embaixada/img/galeria/9/dff6e2eede51175c88f38ab1bb00c0362610730c.png','captura_de_tela_de_2021_06_17_19_19_59.png',NULL,NULL,0,NULL,155689,'Alisson',0,NULL,'2021-07-06 18:29:31','2021-07-06 18:29:31','1'),(248,15,'page','assets/embaixada/documentos/a49bdb5edc7b780eb092a4728bcd0a7a609ee75360e4a312024a0.png','captura_de_tela_de_2021_07_01_16_49_46.png',NULL,NULL,0,NULL,125128,'Alisson',0,NULL,'2021-07-06 18:38:10','2021-07-06 18:38:10','1'),(249,15,'page','assets/embaixada/documentos/a49bdb5edc7b780eb092a4728bcd0a7a609ee75360e4a31faf546.png','captura_de_tela_de_2021_07_01_16_49_46.png',NULL,NULL,0,NULL,125128,'Alisson',0,NULL,'2021-07-06 18:38:23','2021-07-06 18:38:23','1'),(250,15,'page','assets/embaixada/documentos/52f08bf48d4f69885ab96b04d62d5976ebbf0a3360e4a31faf787.png','captura_de_tela_de_2021_07_01_16_49_43.png',NULL,NULL,0,NULL,24467,'Alisson',0,NULL,'2021-07-06 18:38:23','2021-07-06 18:38:23','1'),(251,15,'page','assets/embaixada/documentos/38be193aa2efd49dfd53e006fc86fbfa704e597d60e4a31faf82e.png','captura_de_tela_de_2021_06_29_19_22_05.png',NULL,NULL,0,NULL,271044,'Alisson',0,NULL,'2021-07-06 18:38:23','2021-07-06 18:38:23','1'),(252,15,'page','assets/embaixada/documentos/4d3a29d24414cd217cd0eaa6402057f9b09dcbae60e4a31fafa05.png','captura_de_tela_de_2021_06_29_19_10_48.png',NULL,NULL,0,NULL,277276,'Alisson',0,NULL,'2021-07-06 18:38:23','2021-07-06 18:38:23','1'),(253,15,'page','assets/embaixada/documentos/dff6e2eede51175c88f38ab1bb00c0362610730c60e4a31fafc09.png','captura_de_tela_de_2021_06_17_19_19_59.png',NULL,NULL,0,NULL,155689,'Alisson',0,NULL,'2021-07-06 18:38:23','2021-07-06 18:38:23','1');
/*!40000 ALTER TABLE `tb_attachment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_banner`
--

DROP TABLE IF EXISTS `tb_banner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_banner` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Numero sequencial',
  `titulo` varchar(255) DEFAULT NULL COMMENT 'Título principal do banner.',
  `alias` varchar(255) DEFAULT NULL COMMENT 'Título sem caracteres especiais para identificar o banner.',
  `descricao` text DEFAULT NULL COMMENT 'Texto descritivo do banner',
  `clicks` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'Quantidade de clicks/visualizações do banner',
  `url` varchar(255) DEFAULT NULL COMMENT 'Link para artigo',
  `imagem` varchar(255) NOT NULL COMMENT 'Caminho ou nome da imagem do banner',
  `original_name` varchar(255) NOT NULL,
  `imgsize` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'Tamanho da imagem do banner',
  `dataadd` timestamp NULL DEFAULT current_timestamp() COMMENT 'Data de criação do banner',
  `autor` varchar(50) NOT NULL COMMENT 'Autor de criação do banner',
  `ordem` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'Ordem para listagem do banner',
  `publish_up` date NOT NULL COMMENT 'Data para exibição do banner',
  `publish_down` date NOT NULL COMMENT 'Data para parar exibição do banner',
  `tags` varchar(200) DEFAULT NULL COMMENT 'Tags de pesquisa do banner',
  `status` enum('0','1') NOT NULL DEFAULT '1' COMMENT 'Situação de exibição do banner. 0 - Não exibir; 1 - Exibir.',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_banner`
--

LOCK TABLES `tb_banner` WRITE;
/*!40000 ALTER TABLE `tb_banner` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_banner` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_cliente`
--

DROP TABLE IF EXISTS `tb_cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_cliente` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `rua` varchar(100) NOT NULL,
  `cep` varchar(9) NOT NULL,
  `bairro` varchar(100) NOT NULL,
  `cidade` varchar(100) NOT NULL,
  `uf` varchar(3) NOT NULL,
  `complemento` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_cliente`
--

LOCK TABLES `tb_cliente` WRITE;
/*!40000 ALTER TABLE `tb_cliente` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_cliente_email`
--

DROP TABLE IF EXISTS `tb_cliente_email`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_cliente_email` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_cliente` int(11) unsigned NOT NULL,
  `email` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tb_cliente_email_id_cliente` (`id_cliente`),
  CONSTRAINT `tb_cliente_email_id_cliente` FOREIGN KEY (`id_cliente`) REFERENCES `tb_cliente` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_cliente_email`
--

LOCK TABLES `tb_cliente_email` WRITE;
/*!40000 ALTER TABLE `tb_cliente_email` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_cliente_email` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_cliente_telefone`
--

DROP TABLE IF EXISTS `tb_cliente_telefone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_cliente_telefone` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_cliente` int(11) unsigned NOT NULL,
  `telefone` varchar(16) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tb_cliente_telefone_id_cliente` (`id_cliente`),
  CONSTRAINT `tb_cliente_telefone_id_cliente` FOREIGN KEY (`id_cliente`) REFERENCES `tb_cliente` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_cliente_telefone`
--

LOCK TABLES `tb_cliente_telefone` WRITE;
/*!40000 ALTER TABLE `tb_cliente_telefone` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_cliente_telefone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_distribuidor`
--

DROP TABLE IF EXISTS `tb_distribuidor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_distribuidor` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `telefone` varchar(16) NOT NULL,
  `email` varchar(255) NOT NULL,
  `rua` varchar(100) NOT NULL,
  `cep` varchar(9) NOT NULL,
  `bairro` varchar(100) NOT NULL,
  `cidade` varchar(100) NOT NULL,
  `uf` varchar(3) NOT NULL,
  `complemento` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_distribuidor`
--

LOCK TABLES `tb_distribuidor` WRITE;
/*!40000 ALTER TABLE `tb_distribuidor` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_distribuidor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_distribuidor_email`
--

DROP TABLE IF EXISTS `tb_distribuidor_email`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_distribuidor_email` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_distribuidor` int(11) unsigned NOT NULL,
  `email` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_tb_distribuidor_email_id_distribuidor` (`id_distribuidor`),
  CONSTRAINT `fk_tb_distribuidor_email_id_distribuidor` FOREIGN KEY (`id_distribuidor`) REFERENCES `tb_distribuidor` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_distribuidor_email`
--

LOCK TABLES `tb_distribuidor_email` WRITE;
/*!40000 ALTER TABLE `tb_distribuidor_email` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_distribuidor_email` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_distribuidor_telefone`
--

DROP TABLE IF EXISTS `tb_distribuidor_telefone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_distribuidor_telefone` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_distribuidor` int(11) unsigned NOT NULL,
  `telefone` varchar(16) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_tb_distribuidor_telefone_id_distribuidor` (`id_distribuidor`),
  CONSTRAINT `fk_tb_distribuidor_telefone_id_distribuidor` FOREIGN KEY (`id_distribuidor`) REFERENCES `tb_distribuidor` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_distribuidor_telefone`
--

LOCK TABLES `tb_distribuidor_telefone` WRITE;
/*!40000 ALTER TABLE `tb_distribuidor_telefone` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_distribuidor_telefone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_email`
--

DROP TABLE IF EXISTS `tb_email`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_email` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_reply` int(11) unsigned NOT NULL DEFAULT 0,
  `nome` varchar(50) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `telefone` varchar(16) NOT NULL,
  `assunto` varchar(100) NOT NULL,
  `mensagem` text NOT NULL,
  `datahora` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` enum('0','1') NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_email`
--

LOCK TABLES `tb_email` WRITE;
/*!40000 ALTER TABLE `tb_email` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_email` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_empresa`
--

DROP TABLE IF EXISTS `tb_empresa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_empresa` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Chave primária da tabela.',
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
  `aliquota_imposto` decimal(10,3) unsigned NOT NULL DEFAULT 0.000 COMMENT 'Alíquota de imposto da empresa',
  `tributacao` enum('SIMPLES NACIONAL','SN - EXCESSO DE SUB-LIMITE DA RECEITA','REGIME NORMAL') NOT NULL DEFAULT 'SIMPLES NACIONAL' COMMENT 'Tipo de tributação',
  `certificado` blob DEFAULT NULL COMMENT 'Localização do arquivo de certificado digital para emissão de notas fiscais',
  `senha_certificado` varchar(255) NOT NULL COMMENT 'Senha do certificado digital',
  `ambiente` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'Tipo do ambiente de emissão de notas fiscais. 0 - Homologação; 1 - Produção',
  `sequence_nfe` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'Número da última nota fiscal eletrônica emitida.',
  `sequence_nfce` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'Número da última nota fiscal de consumidor emitida.',
  `serie_nfe` int(2) unsigned zerofill NOT NULL DEFAULT 00 COMMENT 'Série da nota fiscal eletrônica.',
  `serie_nfce` int(2) unsigned zerofill NOT NULL DEFAULT 00 COMMENT 'Série da nota fiscal de consumidor.',
  `tokencsc` varchar(6) DEFAULT NULL COMMENT 'Token CSC',
  `csc` varchar(36) DEFAULT NULL COMMENT 'CSC',
  `matriz` enum('S','N') NOT NULL DEFAULT 'N' COMMENT 'Identifica como loja Matriz ou Filial',
  `status` enum('0','1') NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `cnpj` (`cnpj`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Tabela de cadastro de lojas/empresas';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_empresa`
--

LOCK TABLES `tb_empresa` WRITE;
/*!40000 ALTER TABLE `tb_empresa` DISABLE KEYS */;
INSERT INTO `tb_empresa` VALUES (1,'','','','','','','','','',NULL,'','',NULL,NULL,NULL,'/embaixada_cod/public_html/assets/embaixada/img/quem_somos/1610941873_d36a8dfdb8b8262fcb0d.png','','','','','',NULL,'',NULL,NULL,0.000,'SIMPLES NACIONAL',NULL,'','0',0,0,00,00,NULL,NULL,'N','1');
/*!40000 ALTER TABLE `tb_empresa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_lead`
--

DROP TABLE IF EXISTS `tb_lead`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_lead` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_produto` int(11) unsigned NOT NULL,
  `id_cliente` int(11) unsigned NOT NULL,
  `datahora` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `tb_lead_id_cliente` (`id_cliente`),
  KEY `tb_lead_id_produto` (`id_produto`),
  CONSTRAINT `tb_lead_id_cliente` FOREIGN KEY (`id_cliente`) REFERENCES `tb_cliente` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tb_lead_id_produto` FOREIGN KEY (`id_produto`) REFERENCES `tb_produto` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_lead`
--

LOCK TABLES `tb_lead` WRITE;
/*!40000 ALTER TABLE `tb_lead` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_lead` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_link`
--

DROP TABLE IF EXISTS `tb_link`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_link` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `titulo` varchar(255) NOT NULL,
  `descricao` varchar(500) NOT NULL,
  `slug` varchar(500) NOT NULL,
  `link` varchar(255) DEFAULT NULL,
  `imagem` varchar(255) DEFAULT NULL,
  `status` enum('0','1') NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='Tabela de adição de links rápidos do site';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_link`
--

LOCK TABLES `tb_link` WRITE;
/*!40000 ALTER TABLE `tb_link` DISABLE KEYS */;
INSERT INTO `tb_link` VALUES (1,'Quero obter um visto','{\"en\":\"I want to get a visa\",\"hr\":\"Szeretn\\u00e9k v\\u00edzumot szerezni\",\"pt-br\":\"Quero obter um visto\"}','quero-obter-um-visto','#','assets/embaixada/links/92ab3940864627db856a9f920b327ca6e4bef983.png','1','2021-07-09 04:29:36','2021-07-09 07:49:17'),(2,'Procuro serviços para cidadãos angolanos','{\"en\":\"I\'m looking for services for Angolan citizens\",\"hr\":\"Szolg\\u00e1ltat\\u00e1sokat keresek angolai \\u00e1llampolg\\u00e1rok sz\\u00e1m\\u00e1ra\",\"pt-br\":\"Procuro servi\\u00e7os para cidad\\u00e3os angolanos\"}','procuro-servicos-para-cidadaos-angolanos','#','assets/embaixada/links/4f32e9cfbb6f3e7f796d25545b767e3cb037faf2.png','1','2021-07-09 04:32:50','2021-07-09 07:49:17'),(3,'Quero estudar na Hungria','{\"en\":\"I want to study in Hungary\",\"hr\":\"Magyarorsz\\u00e1gon szeretn\\u00e9k tanulni\",\"pt-br\":\"Quero estudar na Hungria\"}','quero-estudar-na-hungria','#','assets/embaixada/links/0d9180489fa55228acf69b37cd0ba215782afc32.png','1','2021-07-09 04:33:43','2021-07-09 07:49:17'),(4,'Procuro oportunidades de negócios','{\"en\":\"I\'m looking for business opportunities\",\"hr\":\"\\u00dczleti lehet\\u0151s\\u00e9geket keresek\",\"pt-br\":\"Procuro oportunidades de neg\\u00f3cios\"}','procuro-oportunidades-de-negocios','#','assets/embaixada/links/92ab3940864627db856a9f920b327ca6e4bef983.png','1','2021-07-09 04:34:23','2021-07-09 07:54:00'),(5,'Quero visitar a Hungria','{\"en\":\"I want to visit Hungary\",\"hr\":\"Magyarorsz\\u00e1gra akarok l\\u00e1togatni\",\"pt-br\":\"Quero visitar a Hungria\"}','quero-visitar-a-hungria','#','assets/embaixada/links/be455cd88fc46cb5882ade28af01bf09c741e1c8.png','1','2021-07-09 04:34:54','2021-07-09 07:49:17'),(6,'Procuro informações sobre política Hungara','{\"en\":\"I\'m looking for information on Hungarian politics\",\"hr\":\"Inform\\u00e1ci\\u00f3t keresek a magyar politik\\u00e1r\\u00f3l\",\"pt-br\":\"Procuro informa\\u00e7\\u00f5es sobre pol\\u00edtica Hungara\"}','procuro-informacoes-sobre-politica-hungara','#','assets/embaixada/links/f918dba21d265d1c17255955c11888c406ca8556.png','1','2021-07-09 04:35:28','2021-07-09 07:54:00');
/*!40000 ALTER TABLE `tb_link` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_link_pagina`
--

DROP TABLE IF EXISTS `tb_link_pagina`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_link_pagina` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_link` int(11) unsigned NOT NULL,
  `id_pagina` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_tb_link_pagina_id_link` (`id_link`),
  KEY `fk_tb_link_pagina_id_pagina` (`id_pagina`),
  CONSTRAINT `fk_tb_link_pagina_id_link` FOREIGN KEY (`id_link`) REFERENCES `tb_link` (`id`),
  CONSTRAINT `fk_tb_link_pagina_id_pagina` FOREIGN KEY (`id_pagina`) REFERENCES `tb_pagina` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tabela para vincluar um link a uma página';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_link_pagina`
--

LOCK TABLES `tb_link_pagina` WRITE;
/*!40000 ALTER TABLE `tb_link_pagina` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_link_pagina` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_noticia`
--

DROP TABLE IF EXISTS `tb_noticia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_noticia` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_menu` int(11) unsigned NOT NULL,
  `descricao` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `titulo` text NOT NULL,
  `subtitulo` text DEFAULT NULL,
  `texto` text DEFAULT NULL,
  `imagem` varchar(255) DEFAULT NULL,
  `idioma` varchar(5) NOT NULL COMMENT 'Idioma padrão da postagem',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` enum('0','1') NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `fk_tb_noticia_idioma` (`idioma`) USING BTREE,
  KEY `fk_tb_noticia_id_menu` (`id_menu`),
  CONSTRAINT `fk_tb_noticia_id_menu` FOREIGN KEY (`id_menu`) REFERENCES `tb_acl_menu` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_tb_noticia_idioma` FOREIGN KEY (`idioma`) REFERENCES `tb_sys_idioma` (`sigla`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_noticia`
--

LOCK TABLES `tb_noticia` WRITE;
/*!40000 ALTER TABLE `tb_noticia` DISABLE KEYS */;
INSERT INTO `tb_noticia` VALUES (1,80,'The Standard lorem ipsum passage used since the 15 years old The Standard lorem ipsum passage used since the 15 years old','the-standard-lorem-ipsum-passage-used-since-the-15-years-old-the-standard-lorem-ipsum-passage-used-since-the-15-years-old','{\"en\":\"teste12341234\",\"hr\":\"testeasdf\",\"pt-br\":\"testeasdf\"}','{\"en\":\"teste12341234\",\"hr\":\"teste\",\"pt-br\":\"teste\"}','{\"en\":\"<table style=\\\"border-collapse: collapse; width: 23.248%; height: 36px; float: left;\\\" border=\\\"0\\\" data-mce-id=\\\"__mce\\\">\\n<tbody>\\n<tr style=\\\"height: 18px;\\\">\\n<td style=\\\"width: 40.2907%; height: 18px;\\\"><img src=\\\"..\\/..\\/assets\\/embaixada\\/tinymce\\/8aedb38ce4afe798e63f421bf1c2b63be8ebc221.png\\\" alt=\\\"\\\" width=\\\"402\\\" height=\\\"446\\\" \\/><\\/td>\\n<td style=\\\"width: 32.5221%; height: 18px;\\\">&nbsp;<\\/td>\\n<\\/tr>\\n<tr style=\\\"height: 18px;\\\">\\n<td style=\\\"width: 40.2907%; height: 18px;\\\">&nbsp;<\\/td>\\n<td style=\\\"width: 32.5221%; height: 18px;\\\">&nbsp;<\\/td>\\n<\\/tr>\\n<\\/tbody>\\n<\\/table>\\n<p style=\\\"text-align: left;\\\">test<\\/p>\",\"hr\":\"<table style=\\\"border-collapse: collapse; width: 23.248%; height: 36px; float: left;\\\" border=\\\"0\\\" data-mce-id=\\\"__mce\\\">\\n<tbody>\\n<tr style=\\\"height: 18px;\\\">\\n<td style=\\\"width: 40.2907%; height: 18px;\\\"><img src=\\\"..\\/..\\/assets\\/embaixada\\/tinymce\\/8aedb38ce4afe798e63f421bf1c2b63be8ebc221.png\\\" alt=\\\"\\\" width=\\\"402\\\" height=\\\"446\\\" \\/><\\/td>\\n<td style=\\\"width: 5.54659%; height: 18px;\\\">&nbsp;<\\/td>\\n<\\/tr>\\n<tr style=\\\"height: 18px;\\\">\\n<td style=\\\"width: 40.2907%; height: 18px;\\\">&nbsp;<\\/td>\\n<td style=\\\"width: 5.54659%; height: 18px;\\\">&nbsp;<\\/td>\\n<\\/tr>\\n<\\/tbody>\\n<\\/table>\\n<p style=\\\"text-align: left;\\\">test<\\/p>\",\"pt-br\":\"<table style=\\\"border-collapse: collapse; width: 21.9595%; height: 36px; float: left;\\\" border=\\\"0\\\" data-mce-id=\\\"__mce\\\">\\n<tbody>\\n<tr style=\\\"height: 18px;\\\">\\n<td style=\\\"width: 40.6102%; height: 18px;\\\"><img src=\\\"..\\/..\\/assets\\/embaixada\\/tinymce\\/8aedb38ce4afe798e63f421bf1c2b63be8ebc221.png\\\" alt=\\\"\\\" width=\\\"220\\\" height=\\\"244\\\" \\/><\\/td>\\n<td style=\\\"width: 1.71271%; height: 18px;\\\">&nbsp;<\\/td>\\n<\\/tr>\\n<tr style=\\\"height: 18px;\\\">\\n<td style=\\\"width: 40.6102%; height: 18px;\\\">&nbsp;<\\/td>\\n<td style=\\\"width: 1.71271%; height: 18px;\\\">&nbsp;<\\/td>\\n<\\/tr>\\n<\\/tbody>\\n<\\/table>\\n<p style=\\\"text-align: left;\\\">test<\\/p>\"}','/assets/embaixada/img/news/1d96d84697e8d5797dc740a825c1270470ae47b3.png','pt-br','2021-02-05 15:15:38','2021-07-09 07:57:06','1'),(2,80,'The Standard lorem ipsum passage used since the 15 years old','the-standard-lorem-ipsum-passage-used-since-the-15-years-old','{\"en\":\"The standard Lorem Ipsum passage\",\"hr\":\"The standard\",\"pt-br\":\"The standard Lorem Ipsu\"}','{\"en\":\"The standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500s\",\"hr\":\"The standard\",\"pt-br\":\"The standard Lorem Ipsum passage, used \"}','{\"en\":\"<p>The standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500s<\\/p>\\n<p>&nbsp;<\\/p>\\n<p>The standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500s<\\/p>\\n<p>&nbsp;<\\/p>\\n<p>The standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500s<\\/p>\",\"hr\":\"<p>The standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500s<\\/p>\\n<p>&nbsp;<\\/p>\\n<p>The standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500s<\\/p>\\n<p>&nbsp;<\\/p>\\n<p>The standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500s<\\/p>\",\"pt-br\":\"<p>The standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500s<\\/p>\\n<p>&nbsp;<\\/p>\\n<p>The standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500s<\\/p>\\n<p>&nbsp;<\\/p>\\n<p>The standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500sThe standard Lorem Ipsum passage, used since the 1500s<\\/p>\"}','/assets/embaixada/img/news/1d96d84697e8d5797dc740a825c1270470ae47b3.png','pt-br','2021-03-03 14:21:59','2021-07-09 07:57:11','1'),(6,80,'teste','teste','{\"en\":\"teste\",\"hr\":\"asdfasdfa\",\"pt-br\":\"adfa\"}','{\"en\":\"stest\",\"hr\":\"sdfasdf\",\"pt-br\":\"asdf\"}','{\"en\":\"<p>este<\\/p>\",\"hr\":\"<p>asdfa<\\/p>\",\"pt-br\":\"<p>asdf<\\/p>\"}','/assets/embaixada/img/news/1d96d84697e8d5797dc740a825c1270470ae47b3.png','en','2021-07-02 01:55:01','2021-07-09 07:57:17','1'),(7,80,'asdfasdfadsfasdfasdfasdf','asdfasdfadsfasdfasdfasdf','{\"en\":\"asdfa\",\"hr\":\"asdfasdf\",\"pt-br\":\"dfasdfa\"}','{\"en\":\"fdsafasdfa\",\"hr\":\"asdfafd\",\"pt-br\":\"asdfas\"}','{\"en\":\"\",\"hr\":\"\",\"pt-br\":\"<p>asdfadsf<\\/p>\"}','/assets/embaixada/img/news/1d96d84697e8d5797dc740a825c1270470ae47b3.png','en','2021-07-02 01:55:19','2021-07-09 07:57:23','1');
/*!40000 ALTER TABLE `tb_noticia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_pagina`
--

DROP TABLE IF EXISTS `tb_pagina`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_pagina` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_menu` int(11) unsigned NOT NULL,
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
  `status` enum('0','1') NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `fk_tb_pagina_id_menu` (`id_menu`),
  KEY `fk_tb_pagina_idioma` (`idioma`) USING BTREE,
  CONSTRAINT `fk_tb_pagina_id_menu` FOREIGN KEY (`id_menu`) REFERENCES `tb_acl_menu` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_tb_pagina_idioma` FOREIGN KEY (`idioma`) REFERENCES `tb_sys_idioma` (`sigla`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_pagina`
--

LOCK TABLES `tb_pagina` WRITE;
/*!40000 ALTER TABLE `tb_pagina` DISABLE KEYS */;
INSERT INTO `tb_pagina` VALUES (5,73,'post','Página de teste','pagina-de-teste','{\"en\":\"Test Home page\",\"hr\":\"Teste\",\"pt-br\":\"P\\u00e1gina de teste\"}','{\"en\":\"Test home page\",\"hr\":\"Teste\",\"pt-br\":\"P\\u00e1gina de teste\"}','{\"en\":\"<p>Teste Home page<\\/p>\",\"hr\":\"<p>teste<\\/p>\",\"pt-br\":\"<p>P&aacute;gina de teste<\\/p>\"}',NULL,'pt-br','2021-03-09 02:30:04','2021-07-09 09:52:43','1'),(6,73,'post','What is Lorem Ipsum?','what-is-lorem-ipsum','{\"en\":\"What is Lorem Ipsum?\",\"hr\":\"Mi a Lorem Ipsum?\",\"pt-br\":\"O que \\u00e9 o Lorem Ipsum?\"}','{\"en\":\"\\\"Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit...\\\"\",\"hr\":\"\",\"pt-br\":\"\"}','{\"en\":\"<table style=\\\"border-collapse: collapse; width: 25.1177%; height: 249px; float: left;\\\" border=\\\"0\\\" cellspacing=\\\"0\\\" cellpadding=\\\"0\\\"><tbody><tr style=\\\"height: 210px;\\\"><td style=\\\"width: 100%; height: 249px;\\\"><p><img style=\\\"float: left;\\\" src=\\\"..\\/..\\/assets\\/embaixada\\/tinymce\\/051bc2052a74330f08dfbc73c8ae8ce0745dd0b1.png\\\" width=\\\"153\\\" height=\\\"187\\\" \\/><\\/p><p style=\\\"text-align: left;\\\">&nbsp;<\\/p><\\/td><\\/tr><\\/tbody><\\/table><p style=\\\"text-align: justify;\\\"><span style=\\\"text-align: justify;\\\">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer lobortis&nbsp; placerat sodales. Mauris lacinia ornare justo non vehicula. Fusce sodales eu nisl in luctus. Curabitur eros turpis, aliquet eu semper at, scelerisque at nunc. Fusce a tellus pharetra, congue odio et, rutrum justo. Nam pulvinar massa eget leo semper, varius aliquam felis auctor. Duis quis blandit tellus. Fusce pretium nisl in libero faucibus, sit amet rhoncus augue pulvinar. Aliquam rhoncus scelerisque purus, nec fringilla enim viverra id. Etiam efficitur nibh quis quam varius placerat. Vestibulum diam risus, pulvinar eu lectus ut, consectetur suscipit est. Pellentesque iaculis lectus id diam interdum, vel pellentesque lectus laoreet. Ut sit amet metus at lacus ullamcorper tincidunt sed at sem. Maecenas rhoncus sapien lacus, lobortis suscipit ipsum vehicula id. Sed id ante ullamcorper, fringilla sapien id, volutpat nisi. Suspendisse in luctus mauris, et consequat mi.<\\/span><\\/p><p style=\\\"text-align: justify;\\\"><br \\/>Donec mollis felis eget hendrerit gravida. Curabitur suscipit volutpat iaculis. Sed eros ligula, accumsan at diam nec, venenatis molestie velit. Etiam faucibus ornare e<\\/p><p style=\\\"text-align: justify;\\\">lementum. Etiam ut ipsum a nulla iaculis elementum. In auctor ex ultricies, posuere augue in, pellentesque arcu. Morbi est risus, imperdiet sit amet viverra a, molestie vel eros. Praesent accumsan, libero venenatis sagittis scelerisque, magna est faucibus lorem, quis condimentum orci quam sit amet ante. Suspendisse tempor vita<\\/p><p style=\\\"text-align: justify;\\\">nibh ut efficitur. Vestibulum vehicula sapien dictum odio placerat pharetra. Nam auctor sem ut arcu sagittis fermentum. Sed lectus metus, auctor porttitor metus id, porta viverra ipsum. Sed eget magna at purus feugiat consequat sit amet at ante. Sed scelerisque sapien sed viverra ornare. Duis bibendum ultrices maximus.<\\/p><table style=\\\"border-collapse: collapse; width: 12.1641%; height: 89px; float: right;\\\" border=\\\"0\\\"><tbody><tr style=\\\"height: 18px;\\\"><td style=\\\"width: 100%; height: 89px; text-align: right;\\\"><img src=\\\"..\\/..\\/assets\\/embaixada\\/tinymce\\/a4531b15b8bd4914c5ad32e841398325d422a518.png\\\" alt=\\\"\\\" width=\\\"58\\\" height=\\\"71\\\" \\/><\\/td><\\/tr><\\/tbody><\\/table><p style=\\\"text-align: justify;\\\">Integer blandit, lectus ut bibendum convallis, nibh enim pulvinar sem, in luctus urna lorem vitae neque. Cras non ornare sem, vitae euismod lorem. Fusce vehicula consequat convallis. Donec id urna at lorem finibus commodo. Nullam ac risus magna. Duis at sodales lacus, vitae congue magna. Curabitur dolor lacus, volutpat a erat quis, commodo facilisis velit. In id ullamcorper massa. Nulla fermentum, arcu at malesuada consequat, libero urna efficitur elit, sed sodales elit urna ullamcorper urna.<\\/p><p style=\\\"text-align: justify;\\\">Cras lectus tortor, semper et rutrum nec, suscipit et nisl. Praesent mattis pulvinar elementum. Aliquam commodo est at justo bibendum viverra. Aliquam viverra accumsan mattis. Aliquam enim est, viverra et felis ac, gravida elementum eros. Integer nec porttitor ex. Ut convallis dictum ante, et finibus lorem vulputate vel. Aliquam varius diam ut turpis vestibulum, quis mollis nisl sodales. Suspendisse pretium blandit ex, et cursus nibh fermentum nec. Nullam vel diam rutrum, viverra turpis eu, molestie lectus.<\\/p><p style=\\\"text-align: justify;\\\">Phasellus eu odio vitae leo fermentum scelerisque. Maecenas magna leo, feugiat eget convallis ut, laoreet non turpis. Integer vitae sem vitae nulla vulputate faucibus sit amet eu libero. Nunc auctor nunc et nibh porta, non fringilla eros fringilla. Nunc tincidunt euismod diam non convallis. Sed velit tellus, rutrum quis velit gravida, scelerisque fringilla massa. Nullam tincidunt bibendum metus. Curabitur luctus consequat lacinia. Nulla facilisi. Maecenas id eros vitae leo accumsan gravida. Donec ut ipsum metus. Duis vestibulum justo nec sem lacinia, eget vestibulum nibh tincidunt.<\\/p>\",\"hr\":\"\",\"pt-br\":\"\"}',NULL,'pt-br','2021-03-09 02:54:19','2021-07-06 03:13:04','1'),(7,78,'post','Embaixada','embaixada','{\"en\":\"Embasy\",\"hr\":\"teste1\",\"pt-br\":\"teste2\"}','{\"en\":\"Lorem ipsum dolor\",\"hr\":\"teste1\",\"pt-br\":\"teste2\"}','{\"en\":\"<table style=\\\"border-collapse: collapse; width: 42.5085%; float: left;\\\" border=\\\"0\\\"><tbody><tr><td style=\\\"width: 15.1385%;\\\"><img src=\\\"data:image\\/png;base64,iVBORw0KGgoAAAANSUhEUgAAAZIAAAG+CAYAAAC57IK3AAAABHNCSVQICAgIfAhkiAAAABl0RVh0U29mdHdhcmUAZ25vbWUtc2NyZWVuc2hvdO8Dvz4AAAAmdEVYdENyZWF0aW9uIFRpbWUAcXVpIDAxIGp1bCAyMDIxIDE2OjQ5OjQzvirHhgAAIABJREFUeJzs3Xd8E\\/Ufx\\/HXJemelNJFGWXvvfdGQBGQoQIqslGGuAEVRQQVRXGvnwtRRERQBGQJMhUERBQQZAhllFG6myb5\\/v5oCqEkbdqjCz7Px+MehORy973vJd\\/33fd7l4IQQgghhBBCCCGEEEIIIcTNR7tJ1y2EEDciVRQrLYrGXAJECCEKVqEGSmE06hIcQghRtAo0WAqikde7TAkeIYTImd5guK7Bcr0a7bwsp6DmFUKIG1leGv+Cmtep69FQu7MMV\\/Poea8QQtws3GnsXc2j571u0dNI5\\/ZeZ69nf05PwAghxM3I3cBwNl9ugZGvQMlvg53T+3ILC83N1\\/KyTiGEuBHl1LDnFBy5hUpelpur\\/DTO7p5FOAsMVyEiZypCCHG1\\/Jx5OHucl4DJ7Xmn8towu9PA5xQgOQVKTsGS2\\/NCCHGjcaeRzyksXP2b02N31n+N63EFlbvB4c5rrpbnTjmEEOJGkdv4RvbHOYVHXoMlt3Jcw91GOa8h4u7j3M5Y5MxECHGzya1Rzy00XIVITuHiznpdMuU2Qw6yh0hugeEsPNwNlOyPhRDiZuBul5WrEHF8Lrd1aG7M61R+gySnrig9E04eO1uPEELcDFwFiavAcGfKvjzNxWO3uRMk7l6NldNkcPHYnVBxVgZXzwkhREmW09hIXsLDlu1xbuvMKUxyDZfr0bWVl\\/Bw9a87Zycg4SGEuHnkNKCeU3jYyGwrbU7e4ypUsodJnuQWJK7ORtwNEYOTx85ecxUqztbpqmxCCFHSubrPw1WIZD\\/zsJHZljqGiebkNVfr1nAeKjmGjN4zElch4iw8nE3OAiW3bi5c\\/F8IIUq6nIIkpzMRx5DICo+syeZkeTmFSZ7lJUhyG69w1p1lAIxcHR5GwBcIA4IAb4d5yLaMnNYtQSKEuNHkdJVW1mPHLiobYAXSgEvAWSDF\\/lz2g\\/Gs+bPa56xlZA8PV2clLuUUJDk11LkNrGcPkax\\/TUD5qKiozhXLl5\\/s4+3tbzQa0TTJBCGEyA+lFFarldS0tKSjR4++Gnv69FrgOGDBdTtuw\\/XJgavwcBksuYVF9v9nHxvJPmjuePbhGCJZU\\/WG9eu\\/VjokpEZaejpmsxmr1YpS+TqbEkKIm56maRiNRjw9PfH28uL8xYt\\/79q9+yHgAJlnJlmTzeHfrMfZB+ld3biIw3PXMOZUPiePczsDcQyR7FPFhvXrvxkUGFjjUkICGRkZ2Gy5XZUmhBAiNzabjYyMDNLS0wkMCChTqlSpRqfPnNkCJDiZPadLjLNzq7vIkPssOXI3WPwiIyO7BgYE1EhITJQzECGEKABKKRISEwkMDKwVGR7eGfDD9YVOzi5qype8BEn2MxR3QiTrbCS8fHT0g0nJyXrKKoQQwg1JSUmUL19+ApkXNWW1w+6ESb4uaHIVJK4W5ur+Dmf3jjiGSRAQIGciQghR8OxtbQAQjOsQyX6FbPY2nWzPZ398md7f2nI3TLxtNptcmiVuOEopLFZrkY33GQwGTHLlo3DC3uZ6c3VbnDWonvXYsQ3P993t+QmSnAbes98\\/kjV5yMC6uNEopbDabAQFBuLv54fRmNO1K9ef1WolKTmZhMREjAaDhIm4ir3N9SCzDXa8gdHxzvfsU77CxN0xEmdnIFn\\/Zg8Rp+Ml0q0lbjQWq5XAgACCAgMLPUQAjEYjQYGBBAYEYLFaC339onizt7muxkXc\\/Umq637VlrP7SrL+dXZGkvXY6G5hhChJbDYb\\/n5+RV0M\\/P385FJ64Yrj\\/X3Z22dXIYKL\\/7uUn8t\\/83v1lhA3nKI4EymOZRDFVoFerZUlv\\/eROFtxTmEiZyRCCFH4nLXFOQVIvtrq3IIkt1Od7KdFrvre9N74KIQQIu9ctcfO2m5Heermut5\\/s13OSIQQwgWTBq38Mmjln0FlTwuhpsyLkM5ZNA6lm9ia7MGWZA8s1+\\/apLyekeRLfi\\/\\/dZVkOV0aLIQQN602\\/hncXzqVSI9rL4yI9lREe5rpEGAmNsPAx+d92JTkcT1W66otdtWl5XgZsNucdTm5avRzCgNXgzeOp1FCCHHTMQAjQlOZGpHsNESyi\\/KwMTUimRGhqddjTMDVcIM7B\\/luZ4E75cxtYc6SLnvqSZDoZAiKoUnHW+l\\/a0NC8n2JhD\\/lGrWjxx19aBruxkJ8ajBg0r00DJbdJ0R+3R+ayh3B6Xl+3x3B6Qwrnap39c7a4pza7pyW4VJeb0jM7fm8Jp5wk2fTkbz8wlTGD2xIqfwuxNSA+16czbTJQ2gRlsuuN0bQbcpsxg+8n8l31cbLneX7NmT0hyv46bu59K+kZ\\/hNiBtDG\\/+MfIVIlv6l0mnpl6G3GO60y\\/kOEdA32J6bnK4IuGEE9JjDsqda45Gxj3fvHc38ow53GHvWZuwn7zI4RuO\\/z0Yy5J2\\/KRn3H2uU6jyRSZ18+PuLx5jy3p+481UwhNWlWfVg\\/IwNaV7Dj8X\\/XsrfH4C+gX2zZIlb8\\/Xv27eASyIKmkmD4c7OKDQDKBddXE5eGxmaym8p+R6Ad+eMQze9P9ro+DinQfcblIEykWEYNNA8azLwnlZ8N+MXkhSARuku99GnogkNRWhUBB6UlCBRXFzzMpPP+HN0z3HS3HyX7dgy5r7iR6fSh\\/h+fcGHSFBQEJ27dGHlihWkpKRc87qvry+39OjB2jVruHTpUgGXxj0SEAVv89atOb7eumXLQilHK78MIrKPiWgGgp\\/6jPRN35O6buFVL\\/l0GoRXm9uIn3HPVWES6WGjpV8Gv+R\\/8D2nQXZXz+VJXoPE3fGS7PPeoGFipHSZ0vb+QQMhne6m10ebWXjSBqYq9L2rBX4agIZHaBilDHDKBhhCaXjnGEb0bUPNcE9SYv9kw8L3eO+7fSTYW1\\/NvyZ9Jkzgrva1CPNM4MRZAyYyf2ntMjeW45QWQscnv6B7RCQ+6bH8seojXntnNcfSAXxoMnoOk3pUJiLED5M5nuN717HgjXdZ+W8qYCS89XAmjbqVxjGlMKXFc\\/boWt547HU2J9eh7wNDucU3FvXret7YawEtkJq9RzJiYAfqlwtGS45l36IXePR\\/e0jPb\\/ntbrnlFiZMmkS37t15+KGHSHb4ezd+fn68MncudevWxcNkYuHChTksSdxoXIVFbiFzPTntklI20jYtI3D0C2DyIPWn+QB4dxpIwOiZJH403enZio4gye0AP6c23e1jwYK+UfAGDZAsnpQK8UfDxoW489g869H3jjp4AH7NB9K7koHkc+dIVWAIDiFIAzQ\\/Go6fx9wHe9GgrB+2dEVA+ab0efQNXrm3Gh4AhjBueepVJt\\/WgCh\\/K0lJJiKjS129s9xZjiuaD2HlSqOSUzEElafZwGd4+cEm+AKQgdU\\/gjKeaVw8G0eSIYRKLQbw5Ix7qGECLbQHjzx3H+2qBmM5c4SjZ80ElvHEnOzsM+dDrRGv8cbj\\/WkRE4IhLZF0rwj8bYlk6Cm\\/3fLlyzlw4AB169bllblz8bP\\/7pVjiBw4cIDly5e7sTQhrq+q3hanz6et+5qE96YQMHw6Pt2G4N1pIIGjXyDxo+mXgyW7ai6WlQcF2hbr+Rn57I\\/zOk\\/JZwimVLCGhpWDi7+EoQ\\/QrEd\\/2nx2hqABnQlRJ1j05a+0eqA\\/UcHBBBnAEHoL9\\/WtiIc6w5rpo5mx+iKRd7zI+5NbUOOuIbT+5mk2hnSlX8sgDNb\\/+HbyCF79NQG\\/Hi\\/z\\/dNtLoeJISz35fyc5KLcttN8O3EQr\\/6uiOwzm48fbUXULX1o8e4O1iVb2DN3AD1e8ySgVBC+IR15\\/N0JNC3XgPplDPwTXI4oLw2V9jvvP\\/gw352xYjCZwALZW39DaDdG3FUDH3WRza8+wNPfHiHN4IufRyqE9ct\\/+e2SkpKYNGECr82bdzlMnp42jeeef\\/5yiEyaMIGkpFwWVIhkjOTmEWJ0fUCftu5rNDQCRs8EIPG9qdd0dbm7LDfkp83O0wqv153t13PekkMLIDjAACqNhCPL+Wn9nTTr1ZaB4yz4N\\/bG\\/OcSlvzqQ\\/2xoPkEEmACY9Xa1PDUsF3cxvKfz2AB\\/lv1E39MaE4b\\/xrUrmBkc0gVKpg0bOd3sGFXAgqwZFx9muzOcn7e52pExkpGhg2wcHrjRv6e3IpmPhWIiTLC4dK0GDONyf0bE+FjuLLjLL74+ID1yFa2\\/HcXFSo24+GvFtN9\\/TIWzf+a9f9e21gbq9ejlreGLX4T3y47QpoCrCkkW8GjiZ7yX5GQkHBVmCxZuhTgcogkJCS4tSsLiwSEKGSF0k7Lb2DpYfDH318DlURiUjK\\/Lf6BYzZv6t3Wg0qGRLYsXsmJxERSFGgGf\\/z9NDdzXmXOZvJwnfTXaSRb8\\/DIPJFQCptV4dd2HNMGNyU84y++ffVZpj+\\/gD0pDitL2807Y8cya\\/5G\\/k0LoW6PkTz34RsMq+mkM8pgyPyAKRvX9Ppex5H4rDA5cOAAUHxDRNxcLlhdt8uOYyIJ700hYPRMfLoNcTn\\/eUvxPha\\/nkFSvLe0QPgR4K+BSic11Ybl4FKW7ErL\\/FuWp1exeGM8Ki0t86onzY8APw3roT\\/Zb1YYglvQq0M4Jjwo170b9U0aKvkgfx+zYv33IP9aFIbAVtzevazT8QJ3lpMrzZ9afXpSywS2hAP8HQsh0WXxM4D1wI98+s1KVv\\/0K8fSHFp9UyCl1EGWv\\/UE9\\/a7n4\\/2WdB8qtC2RblrPkzWo4c4YlEYgltxW5eyeALggb+\\/N7brUX4HCQkJTBw\\/nlfnzGHi+PESIgVo89atOU4i08E054eB2cdEso+ZOPNPeoHcqXHd2uyCKN1NEyiatx++pswgSTMrsJ1h1fyvaK5qEr\\/6G\\/akg9LSSFeAwRc\\/Xw3b8Z\\/4fOkg6g8oT5dnv6HVo2Y8\\/H3xII0Di75gcxLYklfw2Y\\/9md27LO2mfMkPYy6Q7hWCB1y+fNh2NvfluC54JH1e\\/pZOKoDQIG8MJLPniy\\/ZkWbDeOAgF2x1KNP4Qd77qBP\\/JQYQE3Bll5pq3MPbb\\/fD92wscUkeRFQygkrm1MkLKKKuWo3txAoWrB3AjO7hdHrqa1pNiifV4I\\/3nhfp95iO8ruQmJjI4sWL8\\/7GQnQjjJEU1uWzehSHQNuW7EHHAPPVT2oGvFv3vmZMJGvMxKvNbaSuXnDNlVtbkq\\/L725dLsX1XBgUzg2JNyzN189+pVM66WYARdL293hsu8NM1nTSMxSYfPHzM4BKYse88Tx24UFG3N6SamU8SDm5m03fvMs7i\\/7OvPFPXWLrnAd4\\/PRY7u3VnGoRZfC2JHPu+CEO\\/3aIS+DecrKzneHPLbuoUjuGyLAQQknj3KHN\\/Pz1B3y0\\/F8sgGXnu0x9zYvxA9tQrVpjwskgJf4E+w\\/t4kgiGP0TOHE0gToVYqgakUHi6X2s\\/v593lwTj8r+95XUBTbMeoApJ8cw9JYmVAkPxj8tjn8vWvElH+W\\/ARTngLhRFJeg25LswakMw9W\\/r6VsxD9\\/j9NLfFPXLSR1\\/aJrXovNMLDt+gRJgbXJzhbs7FchHX+A0fGvHmZNJjKv2TEBnvbHjv82bNSgwesFswlCFI10s5mK5csXdTEAOHr8OF6enkVdDJFNa\\/8MpkUk5z5jDp495ZfvIPl99+6JwC7ADGRk+9dif2whs7Mja7I5TCrblOWqUU4ZbBdCiAKyOcmDxfFu\\/VKdU4suel2vs5ECJUEihBAF6H\\/nfPjmYt7DZNFFLz4571MAJbr+5CdahRCiANmAj8778FeaiRGhqUTl8jdJYjMMvH\\/Oh+0l4EwkiwSJEEIUgq3JHvyW4kFLvwxa+mVQxctKGVNmqMRZDBxKN7I12YOt1\\/dP7RYKCRIhhCgkFgW\\/JHno+SXfYknGSIQQQugiQSKEEEIXCRIhdLBai\\/5PlRWHMoibmwSJEPlkMBhIStZ3s9n1kJScjMEgX2VRdGSwXYh8MhoMJCQmAuDv54fRmP03YgqW1WolKTmZhMREjBIkoghJkAiRTwaDAWWzcSkhgYvx8UVWBoOmyRmJKFISJELoYDRk\\/vGvojwjkBARRU2CRAidpCEXNzv5BgghhNBFgkQIIYQuEiRCCCF0kSARQgihS6ENtl+4eLGwViWEEKIQFVqQ7P3zz8JalRBCCCAgIKBQ1iNdW0IIIXSRIBFCCKGLBIkQQghdJEiEEELoIkEihBBCFwkSIYQQukiQCCGE0EWCRAghhC4SJEIIIXSRIBFCCKGLBIkQQghdJEiEEELoIkEihBBCFwkSIYQQukiQCCGE0EWCRAghhC4SJEIIIXSRIBFCCKGLBIkQQghdJEiEEELoIkEihBBCFwkSIYQQukiQCCGE0EWCRAghhC4SJEIIIXSRIBFCCKGLBIkQQghdJEiEEELoIkEihBBCFwkSIYQQukiQCCGE0EWCRAghhC4SJEIIIXSRIBFCCKGLBIkQQghdJEiEEELoIkEihBBCFwkSIYQQukiQCCGE0EWCRAghhC4SJEIIIXSRIBFCCKGLBIkQQghdJEiEEELoIkEihBBCFwkSIYQQukiQCCGE0EWCRAghhC4SJEIIIXSRIBFCCKGLBIkQQghdJEiEEELoIkEihBBCFwkSIYQQukiQCCGE0EWCRAghhC4SJEIIIXSRIBFCCKGLBIkQQghdJEiEEELoIkEihBBCFwkSIYQQukiQCCGE0EWCRAghhC4SJEIIIXSRIBFCCKGLBIkQQghdJEiEEELoIkEihBBCFwkSIYQQukiQCCGE0EWCRAghhC4SJEIIIXSRIBFCCKGLBIkQQghdJEiEEELoIkEihBBCFwkSIYQQukiQCCGE0EWCRAghhC4SJEIIIXQxFdaKLBZLYa1KCCFEISq0IDGZCm1VQgghCpF0bQkhhNBFgkQIIYQuEiRCCCF0kSARQgihiwSJEEIIXSRIhBBC6CJBIoQQQhcJEiGEELqUwCCxcvyHN\\/hwWxzWoi6KEEKIkhcklkPvM3b0NJ5+7huOSJIIIUSRK1lBYjvFwqmz2GRpxuNzR1LFCGDlrxdbExIQQEC2KbjWo2zKcL4olXiQle9MYditralTKZLwdi\\/xVx6CKbf3px7fwEfT7qN746pEhZYmLLo6zW8by9zVx0l3srzUf39g5r0dqVMujNDwCtTtOJRnF+8nWeWhfnKTsod5t1UkKCCUfp+d45pFpx5m6XODaV8rmrCwKKq1vIMnvthLopMyWE7\\/wlvje9OsaiShpcOpULcjQ6d\\/w9\\/ZCpzXerhW3vavW\\/Vo+Z3pTUpds7wrUzD1p\\/2Ki4+OuCyV4xs\\/5pmRt9GqVgXCS2fu36Y97ufZr\\/7g0rUfMI6umsPIbvWpGB5CSHg5arbszbhXV3E01fVaLOf\\/4Pu3pjGybwcaVS9PeHg7XnTxZXVnXpWwlwXT7qRdrXKEhUYQ06A7I19exbG0a5eXcng5L43uSeMqkYSWKk1klSb0GvMKq446mfkmVqJ+ACt951u88lMC5Uc8zcjqWUVXpCSloExVuH3yUBr5XZnfENCQisbsS7Fx9udZDB\\/1ChtOGwmr24YOfToSU6UxgZo7pXDn\\/VZOr3iZ6Z+epE6HrtzV2Ye0U3+wftUXPDPwFw5\\/9QtvdC9F1uzWI59xb7cJrEyModvQSdwTHMe2rxfwyv0b2Rn3E4vHVMcj\\/9WWKf0gHw8bwNMbzmPD69rXrcdZMLwH4344T1iTW7mrmyf\\/rFnG2+N68cfFlXz3YC087bOqcyuZ1G0wn52KoO3A0QyIMXJyyzd8+epwft5xjrXfjaGaKe\\/14Jz7+9ftejRE0u7+hzGcs2VbVwZHVn3A4r0a0dFluOajI65iO7mQiYMmsibJITHMsezftIj9m1ew\\/uhyVjzRCB8A0vnr3bu49fF1xNmy5o\\/nxJ\\/r+XzfRlZufJEfvx5NDU+HFahL7PzgYcZNX8TfibYrBz7GQC7E28BxD7k5r0rYwrO33cGrvyddnif18Ba+mrGdDTvmsfKLe6hkb1pSd8+l723T2RJ\\/5XOSfuYAG7+YzqaVG3npp28YXU33N\\/OG4Ow7rGV77DgZHCajw2QCPOz\\/etofO\\/7bMDEx8XV9RU1ixZh63LmoHE9vWcfD1bM+RGbWTahF34Wt+PToZ\\/TxyWUp256lx+2v8nfYrTz97hzGtI7EM+e35O\\/9liQSzX4E+GZVp+LC8rG0GryA+N6fcvizvmS2iQn8MLIBgxd5c9eCX3inZ2k0QMV9z+h2Q\\/kqqRcf7p7PwNJupZxz6gJrHu7KnV\\/6M3JoKT58dxNt39zP4ntC7TtbEb98NE3uXgi3vcfPn95JtBHU+Z+Y2HEQn5zvzJu\\/fs09ZQ2AlQOvdKLlc\\/\\/S+a1tLBxSNvO0Vp1j6YiW3LPYxMjv\\/2BOW4881oMr7u5f\\/fWYvudFund7gUPNX2LDt6OpXKIOs4pCKr9O781Df9aiZ6cmVAk1EPf7Qt56\\/2dOZCgMIXfx5d\\/v09MXbCf+R78mk1ibrDAENGDwlPF0D41l+euz+erPZJTmT5fXd7B4WNbnKYGtM3rTb85OkhRoplJU73Q7vTs2o1alctRq0Z6aIfZ96fa8ZnZOb03XV\\/eTgYmojuMY3yuIPR\\/PZeGfSShDKXq+vZ0vB0disMXycb+GTFybAsYouj0xiwfb+HF44QymfrqHZGUgbOgi9r7dDd8i3AO5CQgImAjsAsxARrZ\\/LfbHFsDqMNkcJpVtynLV+WbJ+aqkbOS7lecx1h1P7yqOx4oWLl1MRAsOpVRuh5DpO3ll4uv84dGeF5d8wpgqeTyayMv7Tf4EXFW7GoHlognWIMnkUFDzb6xadx4tehz3dS19OcW1Mrcw6o4YFs1bz\\/KNyQzs6395e08dPIZf1cpXn0GlHuNgXDjVyntnK4iV\\/758kDGfpND7w+95yvgkH72bvbAJrFv4I2cNVXjoof5E24unle7C5FFN+GLKBhYuj2XIqGgMWDl66ChWY3maNIq40jeqhdC0RXVMi37l1BkzZJ1DuVsPLrm5f\\/Ncj9mr6R8+eGwuu7QWzHxluISIW3xoNn01mx2fuqMF1u1NmbYjA1tyHHHJCnwhfsOPbElRgAd1J77HvAdrYQJ61U1jX9uZ\\/JGRzC\\/fLOfUvaMoa1Akrn+GUa\\/+TpLSMJW9hRnz32VckxAnffF5mDf1Fz5dcJAMBYbQfrz86fP0DtawttM40GoGuzLiWfv5d5y4ayzlLX+xc08aCjDVuIdnHulHXRN0aJTE+q+HsTTFRvzRo1y0gW\\/JGiAoECWmCjL+3MzWeI2yLVte3V1li+fcBQtacBD+1uxdFVdLXv8Bn+63UfGeKQyrZCPh7CniEs3XjhVcx\\/enXzrN8X\\/3sf2Ht3hw7NscCOnIE5O6XjkKt8RzMVFhKBVC8FV7w4PqdapjIo1DB49fvkIt7bfn6dOmA\\/1e2EJ81opT9vLOkM607PEIq7J1TFv+\\/R\\/jn1hNqVHvM7dvlPPumoz97NydBP6NaVHbsQU1ULZZc6IN6ezduRczAEaq1KiCh+UA33+zm5SsWdU5fvl5LxafxrRpcu1pQ6714Iq7+zeP9Xg1xYXlL\\/LatnSqjpjB8KqSInmScpJ9O35j2y+r+GrOVD78wwIYCG7Xm46lNUCReDEBqwIwEBp+pdvQVLU5TUIMgCJj\\/172WwDbf3z16gKOWRWYKjF83hz6lLnEybPJXPNXjfIwr+WfbfwaZwM0vJp1oV1w5uGGsUon2lcwAgrzH9vZlQYYQgkvk\\/lBsh5eyaLf4lEoEn7dwt50BZgo36ghYSWmBS1YJeQbo0g8eIBYq4l2NatcXWjbGWLP2rDsn0OH8Ln4lq5I7RZdGThmIve3j3bodsrg9zUbuKA0PNZMpu5H+zidYgPNm4gmdzB59guMbhaSQ399ft5vZsszbenz0WlsgBbQiAnzP2RcPYeG1rMCMWWNWI7sYk+8ooZD14tnUCCeKFKTUy+HlXej0TwzeAXDXhpIP+tCvpnsz4Kh\\/Zi20Yc+b0ymY5BDCaxH+HjSs2yKGM0PT7clSMP5ALf1FCfO2DCWjSAs2yfCGBFFhFFxMjaWiwoiNSOV7pvOmK8HMO+VvtwS+zCT72mC+dspTF7hSdeX5nJ\\/xezfLjfqwRV3928e6\\/Hq7f+HT1\\/9jjj\\/zjzzQBPcKFXxYDvGshdeY22cq4DV8Gs2iucG1yrQL7rl8CcM7zqbfZdbbg3vmiP5+P37KG8AMFCmSiUCDVs5ZzOz7ZPX+anto3Ss6ENGXCJmT3sHa+IlEqyg4tfx4\\/bMfaWpU8wfUpf3U20ozYhf+VYMmvQcz9zfhBADqHPuz2s9eYz\\/rJnlK1W27JUuKUME5SINcAhU+gmOn7FBTD2GPXo7C0Z9y4m03bx2axM2dG2EdcsqjlgNBDR8kNcfaaJ\\/7PIGUUKCxEbcmThsmjdlwgKubqyN5ek\\/ez4NLsQTF3uYP7et4YfV7\\/HYiiWsnrOcL0dUz2xs1EUOH4rDqgUQUrUdA8ZOJKaUgfj9q\\/jwzS957PbDpK\\/7kYk1XXw08vV+D+qNfIdPm\\/\\/H8QNbWbZgMfMGdOD4vB\\/43+CYzMo3NWDQ3fV5b8aPPD1yNj5T+tMgzERS7F7WL95NOhq+\\/r5XttkYSc9XlvKZoQ\\/3vNKf1l95cOpMEHe8vYx3BsU4BKeN2IVP8vymUO5f+gQtcurINaeSalPg5X3NMLzm5YO3Bio1hTQFaKAFteXJeRPZ3GsWu75+lvsWZGBVGv6NJzCmZ2UnQ\\/lu1IMr7u7fvNajg7RtH\\/LRbguR94zljsgSdIhpqEDvaXPpXdTluIYibf8nTJrckGUfDaaSB\\/h2HM2oBkuY9XsKyTtfp38DJ0OmJi+8DGA59Df\\/ZGRGvrKmkJx1RZeyknzsF\\/43+Vb2XFjFqsfqY8jDvNaUZMwKQMPT2+vKZ0Hzwts7a7wljZRUBRiJvmMW05duZNTSOGzmM\\/y+fEXmPIZAqrVpS2V\\/HeOWN5gS8q1RmNPNKM0TD1O2naf2epFeAAAgAElEQVSVpnbnXtw+YDAjJj7Na19uYM\\/PL9I1JI7VzzzFojP2Y1CVTEKSAo+mjJs3i8nDBtG3zwCGPfEB3829jVIpv\\/HOB1vs3TfOipCf92uUrt2FPncNY8L091m14QP6h55k6ZNPseRc1rGxiToTP+XDcU2xbpjF4I6NqF27Hs27DWPGD4cx40H5imWv7pIyRNDtqWfpXzaVE\\/9dIrDLEzw\\/IObqQf+Ujcx5YRXm1sO5K+YSJ0+e5OTJk8ReSEWhSLt4mpOn40kD8PTBx6BBevo1ZywqPZU0BZqPL1nftfS\\/3uLOfi9xtMlTrDgYy5Gdy3jjwfYE753HwK5j+TY2+xGyO\\/Xggrv7Nz\\/1mFlRbFywhP+0ivQf0rZYD5wWV6a6U9l2MYELZ46xb917DK\\/vh6bSOfbd40z71n6ZuVdDHvtmCbMGt6Ccr8HeiGt4+Qdc\\/lwZo8sRZQSVlEiSvRssfNDH\\/BV7jovnT7Dnm4do5q+BSmbXO++wPiVv8xp9fMk8+VGY09KunJ2qNFLT7P\\/TvPH10YBkfpt9F5OWxWEzhNBy\\/MvMnnAbtUsZ0WwJ7HxzMH2e2URSYVVyMVdCgkTDx9cbTaWRmpbzOAho+NUZzsS+URgSt7Dxd3vTrvng56OBSrUfcVyZP7RNB+p5WIk7cADXvQQ63w8YI2\\/l3p7hcGkT6393uEvBswK9Z69m34GdrP9hCd\\/9uJ5f9\\/3Gi208wLMBbZpfPUCsEn5jzl2jmB9XgU7da5Gx8mEGTF3DWYd1Z+xewU8nLCT9PIV2NWtQo0bmVG\\/CCtKUmV+mtaR28yfZYAaMkUSHG7CeO83ZbB3L1jOxnLZq+EZFUUoD1Bm+eWYmG9Pa8dR7D9My1JtSVTty36wl\\/DirA97\\/LWbme7uu7ct2px7c4mL\\/5qMeAUj5hW9XnMVQ8Vb6NMzL9XviahoeviGUb3o3s6b1IXPYI5Hftv55+X4cY5lWPPDuav46cZJD+\\/awZ99BfpnexH5GaiC0eSuqm0DzD8DPHi4WzyDCA7wweQZRqfsjjGyXeSZhu3SAA6eseZrXGFWOskYAxcUTsaRkfY1tpzlxKvPLo3lFUy7MgO3kV8x4PXMAP6jHLObPHMMDMxewafN79Ik0gkrjwMfvsSqxUCq32CshXVtGwstG4sEfnD51ARtRuSSgAT9\\/HzTiybBkHWmEULlKCIaNh9l\\/KAOir3TA2FKTSbZpGP388XV1tqr3\\/QAoMjIyByINTjbAK7QqTdpXBRSJW6Zx77pUgrreQ7\\/yV2ZWl7Yxe8BAZu8uw+APv2PebT788vQdDH5jMH0sn7Hkxe6EG8BU8z7eWtiR1GwH\\/Bnb5jLs1d+oNeZdpnSvSWMTYKhB4wb+8P0Otu2z0KNx1sfCxsnt2zlh86JF47qZZzwZf\\/Hr7mQMZRtQP9xxI0xU6NqFmh7r+ePQEcw0zuHDlXM95M7J\\/s1jPWZJ\\/20VP1\\/QKNu\\/B\\/VKWoe39SjfPf8Kq8\\/mMEbSciwvDKldiF90G\\/Gnz9g\\/dxpePl7Xdid6+BNW3gdt02zGztxgv2S3Knfd2xYfQFWtTXVPjeOpNi7t2MKf5q408gSsp4k9Y80cDzEGERRgwBSYh3kjm9OktIG\\/z9hI\\/20NGy\\/dmXnV1qH1bDhmATQ86zWnkQ9Y\\/\\/iHf9Mzu7hCKlXOPIgCTNEd6FDTxJJTVpQ5notJCgI0MJ9m5+oNHPVtTPcOVXDs9Uo78Ss\\/bT5J6RbdaV3B8Zw3hWObV7HtfBStujWnXPYLLkuQEhIk4FuzLpWNyzmwdz8ZRF3uh7ekpGDz9b2qW8cSu4IPvv0Xq3crmtfPesWTZr1uIeLjT1n6wRIeaXcnZQ0AKez6bCF7LD607NKGIJdBkJf3K5LjE\\/AKDrqqgtP++Zx3fziHCuhFmwauWq0Ujq2cw9gH3uJAQEfmPD+ICIcymWP3sjM2ivs+XsyrvTK7ajrOWMJC0wDGbtnN8ZRuhPtraKVq0r57zWuWnp7+JQYMhNbpRPfOWfeRBNJpUE\\/Cli7ki9cWM+qTQZQ1grqwlrkf7CAjoDODetnD21iOmGgT1n2b+PlgOo1rZe0JKyc2bOSgxUjZmIr2\\/aGnHjK5v3\\/zVo9ZZT60dTtnbX70adMgh\\/uJUjm86nN+OFGFvkM7Ud5hxrSjq\\/l86TFi+gylSwWH0aH0o6z5fClHyt\\/G0G6VKJA2wliRPs+8QZ+CWLYbbLH\\/Y3DvRfh260zT6pEEmczE\\/b2azz9al3m0bwihTbu6lwekU45sYf3u45w9foAdG75n6bqDXLIq0HyoNfZVHm6cWX9aaHf6dwpkzfJLWPa\\/zZixgUzuXY4La+bxyq4MQMOneU86hWpomvvzYmjP0IGV+PLNQ1jOf8tj90byX68g9nzyKrszAEMwnYf2IdoAWqXa1PDWOJZs5dhnjzG5wiPcUcuXc9s\\/ZO4m+\\/WLUXWpW1oDdZEfHmzHkK9OYcWXxtPXs3ZyLYyAOrOQ4W1Gsey8DS2wI69s\\/o6RFQ2AjWMf3kmryetJUAZCer3N1gWDiSohfUTuyH4DouMNh16AD+AHBAKlgFAgAigHxADVgTpAI6A50BaYkJiYqHRN51epcRWMylT1IfXzxaznz6sfR1dUoVVbqVvvvl+NGj1SDe3bTlUJMipN81eNH1+rTjsu49Jf6oM+kcqo+agKnYarJ56bribf2UiVNmrKv\\/EU9fOZrHkvqk2P11ImvFTnNw6rhLy+\\/9I+9WLrABVRr4vqf+8oNWbMcDX41maqvK9BacYw1e3VHeq8Q7ku\\/fWdmvP042ri\\/Xeo9jVKK09NUz4xvdWLP5+8sm6H6cK5806eP6\\/Onc+9Hs\\/N76d8NC\\/V9a0jVy8jfp9699YIZdS8VNmWA9WoMUNUp0q+SjMEq7YvbHMob4L696shqoKHpowh9VW\\/8dPU888\\/rSYObKLCPTRlCOup3t13KR\\/14KzO87Z\\/81qPiYkn1Ac9fZXm0UTN2BXvss4SDr+luvlqCs1X9frg+JVlJRxWb3XzURqa8r3lXXU04UodHXm3u\\/LVUJpPZ\\/XGoQR9n\\/1iOp1ZMFAFa9fcsJY5aZ6qQv8P1b74rPkvqf2vtFOe2ebTvMurrk8uVf\\/EX73si7vfVD0ijEq7ZtmaMoR2VLO3xeVr3oTj36sHa\\/teO69mVBE931K7L7ctZ9XGZ1uqIIPz7dM8Kqi7Pj+gLiUmqsT47WpafY\\/L6\\/QfsEDFZZXt54dUVZP9fYYIdf+y85e\\/r98Pj1QG+\\/KMMePVmgvXfx8BE+xtcHN7m1zH3kbH2NvsCHsbXsrepvvZ23gvrtxkbrRngWM2XKXEnJHg2YQ7+lTkvTe\\/45vfptK4pRdgI7R5P7oe\\/pnta77mp\\/OpGPzDiak\\/iCmjHuLB3jWuvk\\/BUI47P1hFYK0ZvPrld8zblIgWUoWWI+bx1LR7aeRw1mm1WEEz4h\\/gd6XW3H6\\/BzV7DKTpj1vZtmwzpxMseAZHUb3dSCZMmMz9baOuumzQenItb7\\/0ERdDy1G1Ti8mj7+ToQPaUt7FdageXs6OnT1x+rS7jOUZ\\/L8V+L\\/0NK8sXMlnu2wEV27N2LefZdrdtR2O1jXK9HqdVd\\/WYvbc+az65CWWpmj4hcXQYMBTvPH4g\\/S43IWUx3q4ps7ztn\\/zWo9YT3D0RAZ4lKNClOu7HbWgurRuWIYtR+rQtq6\\/w9U+QdRr24SwLYeo2a4eAVdeILBuO5qGb2Z\\/lXbUC74Rr+5R2GJ6MG5YOpt27uHvw6e4kGLFMyiSyvVb0\\/PucYwb2JDSl6vVgH+APyZPX\\/xCo6hYrR7NOvSg\\/6A+tIi+9nzNVPlePl8bxTuz3+DLtTv5Ny4dU0hFGnW5m4lPjqNbBe98zauV6sDMH3+k2gsv8P732zh03oJ\\/dH06D36Yp8Z3p8LlFtGHhpO\\/Y0PNd5jz1kLW\\/v4vZ1PAp3Q5arXswdAJDzG0WRn7WXp1Bk24ix+e+IZ\\/\\/Vrx0Mj2l3tMTHUHM6nvTzy1\\/ASlOz7Efc0dekjum0TPjS+w7nxZejw0hFxOzou1EvQTKWA9\\/CY9Wk1lf+f32PHFnYQV2PcznVVjqjHw62imbNrI47XkV5cKntS5ENdbYf1ESonqkTNWHsa0eyqSuGImL6y75PYd6XlmPczuPxMxVOtJz2rSoBUKqXMhSqwSFSTgR9spLzEk+gRfPP8\\/DhbQ3yOxndrFnjMBtBsxlNolp\\/OvRJM6F6LkKlFdW1mS92\\/jn9CmNAgtwCNXazrpeOElB8eFR+pciOtKfv03B341WtCgoFdi9HL2VztEQZI6F6JEKmFdW0IIIYobCRIhhBC6SJAIIYTQRYJECCGELhIkQgghdCm0q7b27NlTWKsSQghRiAotSFq3bl1YqxJCCFGIpGtLCCGELhIkQgghdJEgEUIIoYsEiRBCCF0kSIQQQugiQSKEEEIXCRIhhBC6SJCIm067du2KughC3FAkSIQQQugiQSKEEEIXCRIhhBC6SJAIIYTQRYJECCGELiUgSBRJ\\/6zkrceG0KVBRcoEeOHhHUh4lWb0fmAuq46mOX1Xyj9LmTGkHdXD\\/PH09CU4sgZtBjzKR9vPYs1xfan8t+kLZk+8i25NqxNd2h+\\/ulPZYdE5v7rI7588Qt9mMYT6e+NXuiKNb5vI+9vPOS2PSvqbb58fRpe60QT7eOLpV4bKzfvx8AfbOJvzBjhZ2CV2zutDBU8DmrEMw1eanc5WsHWWytHVbzJ5QGuqR5XCx8MTv9AYGvccwyurjuJsL+apPNaDvNTCE03TnE7GiFH85HyzhRAFQHOYDICRzJ+b9wC8AB\\/ADwgESgGhQARQDogBqgN1gEZAc6AtMEHlk+3cl6p\\/iEEBTidDmW7qzb\\/Mju9QlzZPV61KOX+P5llJ3b3gqLI4WVfy31+pSe2jlJeWbR0Ro9XqdB3z206r5eNqKx\\/NSXm8qqphi08oq+PscT+ph+r7K83ZNmueqsKg+eqIsw1wIvXoSvV870pX1m0IVfevyL4xBVtntks71Jv9qzjd\\/qwydX3zL2XWU56MHWpKTZPrz0n4SLXKXp62bdu6V3lClHDABHsb3NzeJtext9Ex9jY7wt6Gl7K36X72Nt7L3uab7BlgyJYNJStIlEpRWx+rpbz8y6nG3Qep+8eOUyMHtleV\\/LMaGYMKu+8HlZQ1e9oW9WgNj8xGWDOooNq3qVETx6oBTcKUyd6QGUr3UZ\\/F2hzWYVPxW55TbS4HlqY0nwhVt9Mdatj4R9XUmYvV\\/qtarbzMb1PnvrtHlTXaG0GPCNXk9jvV7U0ilGdWeUL7qfmnssqTpn55qLIy2pfrXbGrGvv0TPX02C6qgpdmb3gj1P3Lk1ROUo6uVW9P7KZifLVrGu1rgqSg6yxxq5ra0EdpoDSPUFWrQx915509VcNwz8thaQi7T32fpKM86WvVuLKZZTGW7aBGTH5YPfzwlemR6YvUAXt5JEjEzUKCxIEt6aw6k3R1I3Z+fl8VYG9UPNu+po7YD+nT1z2gou2NtrHyOLX6kv196X+omc287Y2Tt2o\\/7+jlswDb2e\\/UveWMmQ2dMUy1feRL9ccF14f8eZrfely91dnHvl4f1erFfSpdKaXMf6s5bXztz3uqFi8dzDzCztilnq5rP7I21VZTfstq9NPVjqm1lQkUmFS9Z3arDNclVBe+HqRKG7LOYgzKYNBcBklh1Fn6n6+ru+54Rn1\\/OPnyc5aj81QHb3u5PBqpGX9a8l0elbpE3R2QuSyvbu+p0zblkgSJuFkUVpCUgDES0PzKEOZnL7s1jYtHt7Jw2S5SATQPKrVsTpQBQBF\\/6B\\/irAAaAa1voW2g\\/X2etRjQv0Hmn4RU6eze9ru9Xz6DXfOmseCEFaV5UuO+F3iivQd\\/rVnO2h1HuHRNZ3ze5lcX1vDjljQUoHm25p6hNfEE8KjO4KGt8dQAlcHutRs4pwAMaFm7SSVzMf5Kx74lI8NeIR5ERIVhdF1jlOo1nP5lfYlqfjfPffUdTzX3cDFvYdQZeNaewIJvpnNrJd\\/LzxlDwinjmVVkP\\/z9tHyWB9SlOM6ZFaDhGRJKoFvHTEKIglLszkiUUkqlLVNDg7J102i+qmr\\/t9Vuh16eSwv6KV8ts6vFs+1c9a\\/D4EPy1wPsr6G8Or+tTtqUUuat6tGqRhd965ryrdhdTfnh+JX++zzOb976qKqadXRdcZL6xWE4x7xhgqpw+cj7YbXZrJRSZvX7sw2Vt30bjOHt1KSP1qnNX09QjQM0BZryqjFBrbmYwyG3Ukopq4qPO59ZDuth9UprT5dnJAVeZ04lq50zWig\\/+3p9285V\\/1jyWR6llGXvDNXQw15ngZGqaq2GqvUtd6oHZ85X22Kv3l45IxE3CwrpjKTQ\\/mZ7wcgg\\/sRfHDhtpn7lzENb\\/xbtaeq9hA2pCvPm6fS5O477u1Qj0HqBwz\\/uIuv4XlksWBTYTv3Gr8dcXZOkSDm6ilkDbkNbv5Xnm\\/vkeX4Vf56LKvNVQ3AIwQ7ngFpQKYLsu0TFXyBeAXjQ8Imv+eBgD0YsOET6mY28NrwTr9nfYwjtyWvLXqZzcG6H3AaCQkNymSdTQdfZtZLZ+\\/Zd9H52O8kKNP+mPDF3NFWM+SsPGlhP\\/UesNXP91oRT\\/PPXKf75axebVy7k7TnzePir73mxW5h7nbtCCN2K5xmJ5V+18u3X1KsvzVBTJ9ypWkR52QdqNeVVd4ranpo1Y6La8lTTy+MnzidN+fSZry4ppTK2PaaqmbLOGO5TXx04qxLT09Wlo+vVSz0jlME+f\\/CAheqiLe\\/zp\\/94vwq1j1V4NHhO7XUYRsjY\\/YyqZ8oaPB6mlmdd5XR+g5rerowyaijN4KP8\\/YxXruDSTCqqx2vq95zH2q+WyxlJQdfZVWwX1ObnO6oy9jEbzbOyGrrwWLYrwvJWHqWUspz8Tf2wZLH66vMP1LxZT6ox\\/Vqqcg4XGhgiBqvF5zILI2ck4maBDLbnzHpqoboz0n7FkKGsGrfWoXG0XVJ\\/LnxGDelQW0UHeyujwUP5R9ZUVSPsVwJhUrWm7FAZSinz1kdUFXv3kqnaY2qbwwh2xs6pqlZWg1n5YbXFnI\\/5tzx8eX63urasx9UnvctkNsaGUNXttT9UUspJte3zx1SnKJN9oNlD1Z7yq3JyRbKLysotSAq2zq6U47RaObmxCrQHq+ZXV43+9pjziwbyUB5X0g5\\/qvpH2bvgtAA1YGFm7EiQiJtFYQVJiRhsd8YQ3oZ2tewDyLbzxJ5Ov\\/KiFkjtgdP5fP2f\\/HcxFYvVzKWdT9MAKwrAWI6ut9TFBBhKhxFqrwXr6aMcT3VYjH8g\\/llVlmHGnI\\/5TZWqU9kj80nbqX3sO2fv50Jxfv9+TtsANEyVq1PZBLZj3\\/DByjhsgKnqCJ5\\/oC5+PlE0H\\/Iiyz4bRQUjoDI4+ONKDub1xsScFGCdZUpk27O96T93Jwk20AKb8sjStbzdt7zz\\/tU8lMcVr0qDGNLRL\\/NTr9I5HXshv7UjhMhB8Q8SdYF\\/D8aR\\/aZk86ElLP3dfhWToTRRkV4uFmDhwq7PGHfraBaftgEa\\/q3GM65V5piKsUIzmkZmds6rpLUs+C4WGwAZ\\/LN0GXstABqeNetR3ZT3+bXQ9nSq74EGKPNm5n9xgAyAjH\\/48ovNZF5o5EGDzu0J1UAlJpBks2+6OZFEh3w0mEyFtMOub50BpG19nvtn\\/UaSAs23HhMWLefFzmXc3J6cywM2Ei8mXHO3uy1uLcu3JWcGj+ZFeKR7Y0ZCiLwp9oPt6vQixtQfz87yzWjVqCoRgSbS4\\/azec0WjiRmNl\\/G6Nvo08zz8nsy\\/pjP059s49yZ\\/zi4exu\\/\\/n2WtMzWBGPkrbz64YNUy7p21rMV991bm\\/ee\\/wOz7TxLx7an5y+9qWn+jUVfbiFVAYYy3D68D+FaPuY3VmHI2Ft48bdlXLClsHlqZ9psbk9U7AZ+\\/C2zkTOE9OSBoVUyL+et1oH25YzsOWLFevQ97uqcwP196hGc9Dc\\/fPw5R6wARsq2bUdVI2DZzdMNmzLjTwvgTe\\/PT7N0SFCe67lA64wEfnzjQw5kZI6M+1SqDD+9yKM\\/OZZAw7\\/5SJ4aUA1jXstj3cfcTi2Zl1KPpvUqExnsDYnH2bHuZ\\/7MvI4YQ5lbGdQlIM\\/1IoTIn2I1RpK8dKgKMbgedDUENlaPrI5TjmO6aT\\/cp0KyD9RqXqpsx0fUt4fSrl1J0nb1fOtS9kHi7O\\/zVtXuX6JirTrmtxxTC4dUunwnu+OkeVZWQ78+7jDYbFOnfxiravloLrZZU97VR6jvTtlXYNmrnmvgYX\\/NW\\/X+PP7a7XNjjKRA6yzjV\\/VEDdc\\/X5I5GVSZESsvj\\/vkpTy2s\\/9TPV3WF0rzr6ce+D728s2LMkYibhbI5b+ZDLUH8+zjHqzetIO9B45y6kISFlMg4TG1ad5tIGMmjaRrxasvMTX4BxDg6YMlsAzRlWpSv0UHevUfTL825XB2MSp+zZi6ajt1583ijS9Xs\\/PQWZINgUTXaUe\\/UU\\/wxH1NKW3QMb+xPAM\\/3kLZljOY+f5Sth48S7pXONVb3c6oqU8xqpXjzYUa4b3eYuuvHZj74jssWr+LQ2eSUF7BRFZpSIc+w3lo0iDqZ13+a7vAuYv2vjBjGBXK+ZIfBVpnKo3UNOVsKdenPKb63P3kWAJ+2cGevw\\/x35l40gz+hFWsQ4tu\\/Rk5cTQ9KuevXoQQuXN2GZeW7XH2M5SsyegwZZ2xmABP+2PHfxsqpV4vmE24ualzH3NrueH8mKbQggbw1bGvGZj3nq2bSrt27di4cWNRF0OIAqdp2kRgF2AGMrL9a7E\\/tgBWh8nmMGU\\/w89y1ZFh8R9sFzlK37WNXWYFGAi5ZQBdA4u6REKIm40ESYlm4eDOP0jWNDRTFe4dfxul5NZtIUQhK\\/ZjJCInJuo9sZVzow+z628zVVt6F3WBhBA3IQmSG4BHqco0a1XUpSg5ZHxEiOtLuraEEELoIkEihBBCFwkSIYQQukiQCCGE0EWCRAghhC4SJEIIIXSRIBFCCKGLBIkQQghdJEiEEELoIkEihBBCFwkSIYQQukiQCCGE0EWCRAghhC4SJEIIIXSRIBFCCKGLBIkQQghdJEiEEELoIkEihBBCFwkSIYQQukiQCCGE0EWCRAghhC4SJEIIIXSRIBFCCKGLBIkQQghdJEiEEELoIkEihBBCFwkSIYQQukiQCCGE0EWCRAghhC6mwlrR5s2bC2tVQgghClGhBUnjxo0La1VCCCEKkXRtCSGE0EWCRAghhC4SJEIIIXSRIBFCCKGLBIkQQghdCu2qrfwwm82cOHGChIQErFZrURfHbUajkYCAAKKjo\\/Hy8nI6j2xb8SPbJttW3LizbcVBsQ0Ss9nM\\/v37iYyMJCYmBk9Pz6IuktvMZjPnzp3jwIED1KhR45qyy7YVT7Jtsm3FTW7bVlwU266tEydOEBkZSVRUVLGtPFc8PT2JiooiMjKSEydOXPO6bFvxJNsm21bc5LZtxUWxDZJLly5RpkyZoi6GLqGhoSQkJFzzvGxb8SbbVjLdjNtWXBTbILHZbHh4eBR1MXTx9PR02h8r21a8ybaVTDfjthUXxTZIhBBClAwSJEIIIXSRIBFCCKGLBIkQQghdJEiEEELoIkEihBBCFwkSIYQQuhTbn0gpCLaTCxl\\/37v8Zcn+iiftnl7Gsx2L72\\/ZuEOlHGLF++\\/w5fo\\/OZPuTXjN9gwaN4ZeVX3RirpwOqn43Xz1xjss2XaES8ZQqrcZwNixfagZUNK3TJRkKvUYvyycz+L1v3Po1CUyPEoRXb0RHe8cyZBmoSX+e+eumypIDGW68OgbdUmxZT1j5dRPc3l5QxmaVi\\/ZNyyhEtny+hO8\\/lcDRk97gwb+Z9n0yWu8PtVKmU8epblvURdQB9sJljw7lc+TOjPhhUeolPEXi+a9zROzvfng+R6E3Szf1hImISGBZcuWsXnzZmJjYzGbzURHR9OyZUv69u1LqVKlirqIuqikPXz0yBS+PBFG69sGM6lWBD7mCxz763cS0m6qpvXmChI8S1OxRunL\\/1WnlvHxugs0GjubXlElvJfP+g+\\/7kyk+qDh9G0aiUY1Kow4yM8PbGDvf1aaVzcWdQnzzXZsHSv3+dD5hQe4pb4XUJWHRv\\/F4Gd\\/YN3J7twZXcL3HQBp\\/P7GSJ77oxOz3xlGjRL+zdy+fTuzZ8+mdevWPPjgg5QrVw5PT0+OHDnCmjVrGDZsGA899BDt27cv6qLmUzp7P53DV\\/\\/FcN\\/clxlazefyK20631qE5SoaJfzjqoNKZOtnn\\/NHWB\\/e7BpW8k9BDWGUjdBYv+NXTva9nWiTjXP79xMXWIta0SU3RABsKUkk4Ueg\\/5WPq0+lKkSzmSPHrXBDBIkR\\/7BylIsOxbeEb86mTZt4\\/fXXmTVrFjVq1LjqtZo1a1KzZk169OjB1KlTAUpmmKT\\/zo+rTxHcaQIDHULkZnXTBok6tYqF6y20eaIvVW6EWjBE03vSGP6Y9jZjR2yjfR0bv29Noc\\/T02jpV9SF08dYvg61fJfw85KfuWViJ8p5mzl36hxpyoLZooq6eNeJB9UGvcAbRV0MHdasWUPp0qV57bXXmDlzJtWrV3c5b5UqVZg5cyaPPPII9evXJzg4uBBLqp8t7hj\\/JRuIqV6FkvV7wgXjRmhC88HKoZXL+TukC3NaB5X8sxEAFMlnj3PGFkOHni2IiN2MIe0Iv6zaSa86HYkowSclWkBbxjxxBzPmvMi9t72ABnj7+WC2BVEvuGQfvlv2vc29ExYRa8v+ipHK973Pe\\/dWoqTsuu3bt7NmzRpq1qxJTExMrvNXqVKFTp06sWTJEoYNG1YIJby+FKBpN0brodfNGSTWf1j\\/80nC2z9GrRI+xp5FJW3i3Zd\\/ovTIT5ncszQat9Ov2weMnzSP\\/7VuzpTWJXm0XSO0xRheXzSM+LMXSPcMJO2nxxn5eWlqx5SUZks21GUAAB7bSURBVNY5U5VBvPB+NzKuObHS8AqJLjEhAnDx4kUADh06xIoVK7j99ttzfU+XLl2YO3duiQsSQ2hZorxt7D10hAwa3vRnJTdlkNiO\\/8qO06Vo0rzqDVMBKu4IR5MDaFDuyhmWT5V6VPNbxMnTCShK\\/iXAaF4Eh0diObWKGYsOEtplFi1K+uW\\/XqWpULl07vOVAGazmQ4dOjBixAjKli3r1ntiYmKIjY0t4JIVAK9GdGoTzM9rF7C8Xx36lrtBjkjz6UZpR\\/NAkbD\\/L44bqzOo6o2z+YaoBjQIm89PH3xI9RFdqOyTyP7lH7MxpTz965Up4SGiSD7zL8djT3Nk70a+X7KO2HJDmTmyESX5POtqJf+qralTpxIeHp6n9\\/j4+LB8+fICKlEB0vxoOfxBOu15gbcmTOKfO26lRdUy+FgTOHXoT05FDWBUl8gS\\/r1zXwn8uOplJfbYCWyhbYnyLuqyXEde9Rgx8wkM737Bu09+S3yGJyEVG9DnqQcYUrUkdZA4Y2H3Rw8xY5s3kZXq0HzYHJ7rWZ8yN9Snt+RftZXXECnptNAOPPFWKLXnf8mPy99h3bkUbB4BhFaoSYu+ZqzcPA3szbKdDkzUGjOfn8YUdTmuP68KnRg7qxNji7og150HracsY2VRF6NAlfyrtm5GhlJ1uH38TG4fX9QlKVol9NhHCCFEcSFBIoQQQhcJEiGEELpIkAghhNBFgkQIIYQuEiRCCCF0kSARQgihS7ENEqPRSEZGRlEXQxez2YzReO3NgLJtxZtsW8l0M25bcVFsg8Tf35+4uLiiLoYucXFxBAQEXPO8bFvxJttWMt2M21ZcFNsgCQ8P59SpU5w8eRKz2VzUxckTs9nMyZMnOX36tNOfjZBtK55k22Tbipvctq24cPabYlq2x46TwWEyOkwmwMP+r6f9seO\\/DVNTU1\\/PS8FsNhtJSUnExcWRmJiI1WrNy9uLlNFoxN\\/fnzJlyhAQEIDBcHVey7YVT7Jtsm3FTW7blhsfH5+JwC7A\\/P\\/27jy+iTr\\/4\\/hrkjZtIZGrBwlVKHIUEBVxRRB1VwUvBC\\/EAxV2XdR1QVdR2UWFVRFFcQVZWRUF1gsRDxDc9cB1PX4KLoLI0YIKQku7pAI9oHSaZH5\\/QJaQJk3SFDLH5\\/l4zCNp2iTfTyf5vuf7nckEqA+79B287gP8IUsgZNHClqDDvvhAt+fastlsuFwuHA4Hfr8fTTPON+EpioLdbsfhcERc8VKbPkltUpvexKpNL3QbJHDgn5iZaaZT9B4itRmT1GZMZq5ND\\/QbcUIIIQxBgkQIIURSdD21paoqJSUlVFVVGW4HmcvlIj8\\/n4yMjIh\\/I7Xpj9QmtelNPLXpgW6DRFVVioqKcLvdFBQU4HA4Ut2kuKmqSkVFBcXFxRQWFjZou9SmT1Kb1KY3sWrTC91ObZWUlOB2u\\/F4PLr950XjcDjweDy43W5KSkoa\\/F5q0yepTWrTm1i16YVug6SyspKcnJxUNyMp2dnZVFVVNbhdatM3qc2YrFibXug2SAKBAOnp6aluRlKCx62Hk9r0TWozJivWphe6DRIhhBDGIEEihBAiKRIkQgghkiJBIoQQIikSJEIIIZIiQSKEOEr2U7z4RRYXVWOc8+82po6fls\\/j9VVVJqmn6SRIhBBHhVr0CtNm\\/4uteyN9DZIRKdSXrmD+E8\\/zdY21o8TCQeJn5ydTuW7wYH6\\/cIcptii0Xe8yfvCv+NWvDi3njZpDsX4PP0+Qnz3FH\\/Di1PHcdPUwho5dwPZAqtsk4qJ5+XDeO+zq\\/2tuPMUZ8Rv1jMdBl6vGcIHyIXOXbMPKL0XdnmvryNLY8\\/VfmTBzNfXGOmNCo7R9e6m1deXqR+\\/m3HYH3qqKow359hQ3rFnU8cPbk5n4UgU9LxrCyPE34s7tQK6FN4WMJLDtfZasPoZB0wfS2hwpckDmSVw6pIBly5ax\\/qrf0duiPaoly\\/aXLOXRaWvoc+94Mmc\\/wLepblAz0fbWUKPk0PmErnRpmerWNK+6717koQV2bpg1m4s85nrZ+srWsoGenOg+WFfdNtZszqL3CTmYYhuAADu+\\/IKtbftzW6GxP2HekI38gQMpmP8Pvtg0ht49zfXajJf1tud8P7LwsXnUXPonbu7byiRD7AO0qj1Updmp+9lLtWqGybqDtD38e8Eyyu1elv3xaoZechnXj3uMResqTTAlWceGd55kwl2PsrzMB\\/XbWPrQeCb+9X22+FLdtuayn+INW7F17UEXE\\/azNk9PCl1eiop2meD12DQmXK2N8fHTor+wkOE8OaILDqU41Q1qVmqdQquWG3j2t1fzZMBJp9Mv5eaxN9Av1+Dbtb4iVq+rI+fUQVw99EQ8WVWse2Mmz\\/xpKllzpnJxrpE3BzI48bdT+UPFXUy\\/50HWHLuJj3f0Y+L0a83T6QYqKN8ZoE3vXEw0k3yILYf2ObCyfCd+cq3WqQIWG5FoFR\\/x3Os1XHjrZRSYcG23GHgX8xYs4t33FvPStF\\/TdfvrTJq0gB8NvrNd2\\/szP9faKBhwMWee1I3ju53KsNtHcbr\\/Gz76wmv8rcA0N4PG38l59V+wbGUml04Yx4B2JnpranXU1Wk4MjJMNQPwP4qDjEyo278\\/1S1JGRO9WmPRqFzxMV9XbmPRHZcwePBgBl84lgXbVTY+P4phU7+gPtVNbC52Jx36DOMPY84m44fP+LLE2MeTKGnppCkaNdU1h0IjM4e8VlC5p8r4R8v4\\/8snTz3FR\\/bTuaBvLe88\\/jdW7DZ8PB6iOMjIUFDr6owf+pFoKnV1kJGp328wPNJMuF0ejcIxvxzPC733H3oxB7bwxsRHKD5rCvdd2ct0\\/4xAwCRv26zjKGivsXTdRvZemoMT0Cq3smVXGp4OuQbfGqrjuzkTmLa2K3dMn8jg7BK6Tx7PQ\\/e1ZcaM6zjeDC9KWzbtc23s3ulFxYSdTsBLuRdy2uea5OCIxJlunTbG1jKXY0OPZvLX0ipdwdHGw7Htsow97A7s4NPXPqHmuG54jlHYu\\/0blrz0CWrX0ZyRb+yuFns3zh\\/Sg7eff56nFjsZ0cPHN\\/Nf4ts25\\/LQAJex1xsZFF48jilDTqCPJw3oxLBJ08kvzqKTad6dWXQr7ERgaRE\\/+s7hBNPUdUCgvIjiqmxO7N7O4K\\/FpjPZKrWwQC27t67grTdfZkeVD0crD937\\/ZapN11BJ8NvJtk47opJPLj\\/aZ57+X5uq1TI7nEud065lX5O47910\\/P70Cf0hoyO9D0xVa05Emx06D+AjvM\\/4ItNYzjBVIfIBtjx+edsadefW7uZqa7EWLdyAHt3bpr3z1S3onmkHc+wiTMYlup2HCm2dpx6\\/WROvT7VDRFNYet0PkNPep0X3\\/qCa3qczTHGz\\/8D6r7jnaU\\/0OniuznBbB+RSYDB5zyEEIag5DJo9DBaf\\/4C89fsM8lO93p+XPQs7\\/nOZfTQjpbuTK09IhFCHDUZPUZy9xiNjQ6DH4\\/+P35sOacw8q7hnOYyyxCraSRIhBBHSRY9Lh9Dj1Q3o9lk0mnwTXRKdTN0wMqjMSGEEM1AgkQIIURSJEiEEEIkRYJECCFEUnQbJHa7nfp6Y5\\/9SlVV7PaGnwaU2vRNajMmK9amF7oNEqfTidfrTXUzkuL1enG5XA1ul9r0TWozJivWphe6DZK8vDzKysooLS1FVdVUNychqqpSWlpKeXk5eXl5DX4vtemT1Ca16U2s2vQi0qdolLDroYstZLGHLGlA+sFLx8HroZd9amtrZyTSsEAgQE1NDV6vl+rqavx+43yIyW6343Q6ycnJweVyYbMdntdSmz5JbVKb3sSqLZasrKzbgdWACtSHXfoOXvcB\\/pAlELJoYUvQYScn0O0HEm02Gy6XC4fDgd\\/vR9OMc1IFRVGw2+04HI6IK15q0yepTWrTm1i16YVugwQO\\/BMzMzNT3YwjQmozJqnNmMxcmx7oN+KEEEIYggSJEEKIpOh6aktVVUpKSqiqqjLcDjKXy0V+fj4ZGZG\\/x1lq0x+pTWrTm3hq0wPdBomqqhQVFeF2uykoKMDhcKS6SXFTVZWKigqKi4spLCxs0HapTZ+kNqlNb2LVphe6ndoqKSnB7Xbj8Xh0+8+LxuFw4PF4cLvdlJSUNPi91KZPUpvUpjexatML3QZJZWUlOTk5qW5GUrKzs6mqqmpwu9Smb1KbMVmxNr3QbZAEAgHS0439JcjB49bDSW36JrUZkxVr0wvdBokQQghjkCARQgiRFAkSIYQQSZEgEUIIkRQJEiGEEEmRIBFCHFWBXWtZ9PgdXD\\/0As4fej1\\/fHkt1cY5IW\\/jtErWvbeAf\\/1Yl+qWHFUSJEKIo6q+dCNl+cN54PlXmXdfP\\/778nP8o8wcSaJVr+C12cvZjrEPN06Ubk+RcqTV\\/riYR\\/44m9qRr\\/L4JW0jfsOXsdRT9tVC5r7yHis2e6nLyqNwwJXccutQCp0Gr07bzdq35vLKe1+ybnslmqsDvX55DbeNGUwn\\/Z5+SESR0XsEY3sf\\/MHZHY99HfX1GpG\\/Z89Yar9dyYa2v+D6jtbaRrdckASqf+TTRfOYu+j\\/KNlvo0+qG9Rc9n3Lgr99QE3\\/q\\/jDdXnw03LmzZ3JJHsH5t95Ksb+JoZ06uvS6HnZOIZ3yKS6+H3mz3uCh5ydeW50F+ypbp5oolqKFr7Fd8edyW\\/yzdDxqmxY+S2ZfSfSxWIvSosFSYCyf85i9socLn\\/gDr5\\/5Gl2p7pJzaXFqYyd8wJpaQdX6eknY9\\/8FQ9uWM+OwKl0NvL7VHHS99px9A3+fHJXald\\/yowftlJHF1qksm2iaQI\\/858XH+TRj9tzy7QRFJih4\\/VtYuVqjVPG9rBax2q1em10uHI6C4YrKL4VTEt1c5rZ\\/0IEQKti1656Mj35ZBt\\/xuCQwD52rHqbD4qdnHpLb7JS3R6RMG3vJt6aOpnX9w3iT7Nu5JS2Rt7KOcS\\/5WtW7T2ZG3tbb77VHGswEYpigpnYWHyULJvBS5u7M3LU2RxjkoKrP7yfiwYN4bp7X2Pnab9n3KA8C6xL49H2fsm04YO54W\\/rUQG0PXz2yFVcdOtLfF9VzGsTJ\\/Jem5uZOW20QUPER+WWFSyd9wQPzPo3uzWAAGWr\\/oO3Vz9OtuDWjcVGJFZQx09Lp3Dv7B2cMfEJrupsnlXsHDCWWc8Mp3zz5yya9xi3T0vnmQln0tbAaaLtWsafRs1iTX34bxRanvMAr919uuGO\\/1Fa9mPEFV34+NXX+fTqSZy06ilmfuVh1Mwr8S28jTcyRjLztv60Daio9TbS0tKwGWod1lP8wZus9PrY\\/NkrvHvRQG4o2MWqldvofs4puAxVS\\/MwTy8jODASeYjxs8sYeN8TjO3fzlRb7ErLXDp3z6Vz9970zirn6sfe5JPfDOTyXONWqRxzBrdMK2BvoMFvsLfON+gb1MZxF1\\/H2Yse5LVZf+HdrzfQa9wsrswv4ukPfmKP9yluuPApAJSsM5m48EHOdaa4yQnJ4rSbp3GaVs7bd\\/2aBe+sZvivd7Hy+870u9sMR4AmzpivUxHRvrVzuP+ZbfSb+BfGmSxEIvPh96W6DUlKa03HwtapbkWzU1ynM2JoR26e9yHHXvkYU87NxabkcvvC5dye6sY1FyWP8y4bwN8ff5fl3exs8JzGmDzzv+sikSAxC20nH85fzM+9R3N+7m5++P7g8WiKgzb5x9HOyPv\\/1I0sfWU9mYWdyWkRoGr7Kpb8\\/UvoeQv921vzjat7tZv4bEUpfjTSXa3IMuVqUnD1u4RznPcy5wUHbYdcgymOYm4CCRKz8P3Ixs11VFfPZtyKkNvtHbnumRe4qZtxj6\\/U9tXg3fwRH76zlZ17A2S2PZZeA37P46OHWvaNq2v+cj58bDIL\\/cO469rVPL1kEf+54m76mfE4bccJXDioA4tfrmXQaQWW\\/UyTdYMkrR\\/3LH4\\/1a1oPumnM2HJx0xIdTuOAKX1Lxj9yC8YneqGiNi0Gr6d8wBPbejBHTNv4rzMj\\/hq8Qze+ng0pw3JNuF0q53jRzzM7P4+crtZtzuV7TkhRDPxsX3pFB5cYuOKSfdwXnsbSuuBXHhGBmv++TE7GhxQYA5KCzddC4+llYV7U+tGqBCimaVx7CVTefOS0NtaMGDCW5ho7C8isHCGCiGEaA4SJEIIIZIiQSKEECIpEiRCCCGSIkEihBAiKboNErvdTn19gzPZGYqqqtjtDT+iJLXpm9RmTFasTS90GyROpxOv15vqZiTF6\\/Xicrka3C616ZvUZkxWrE0vdBskeXl5lJWVUVpaiqqqqW5OQlRVpbS0lPLycvLy8hr8XmrTJ6lNatObWLXpRaQzFihh10MXW8hiD1nSgPSDl46D10Mv+9TW1s5IpGGBQICamhq8Xi\\/V1dX4\\/f5E7p5Sdrsdp9NJTk4OLpcLm+3wvJba9Elqk9r0JlZtsWRlZd0OrAZUoD7s0nfwug\\/whyyBkEULW4JCr+v3k+02mw2Xy4XD4cDv96NpWuw76YSiKNjtdhwOR8QVL7Xpk9QmtelNrNr0QrdBAgf+iZmZmaluxhEhtRmT1GZMZq5ND\\/QbcUIIIQxBgkQIIURSdD21paoqJSUlVFVVGW4HmcvlIj8\\/n4yMyF9NKLXpj9VrK91Txn3vPswnmz6jpm7vUW6hiMSZ0ZJfdh3I\\/RfdQ+fsTqluTlS6PWpLVVWKiopwu91kZ2fjcDgSuXtKqapKRUUFZWVlFBYWNmi71KZPVq5tR2U5fR4\\/C6V9Okq7dBSH+b6Cyog0VUOrUNH+62P13Z\\/iadU+ofsfraO2dDu1VVJSgtvtxuPxGOoNC+BwOPB4PLjdbkpKShr8XmrTJyvXdt+Sh1Hy0rC5HRIiOqI4FGyeDJS8NO5\\/d0qqmxOVboOksrKSnJycVDcjKdnZ2VRVVTW4XWrTNyvW9vGmf2PLMVY4WomS7eBfmz5NdTOi0m2QBAIB0tPTU92MpASPWw8ntembFWvbW7cP0mUkoleKQ6F6f02qmxGVboNECCGEMUiQCCGESIoEiRBCiKRIkAghhEiKBIkQQoikSJAIIYRIigSJEEKIpFgvSAIVrJx7H7+54kLOv2g4Yx5cwNo9xvl+AmtR2fqPx7h1xBAuvmw0E1\\/+lqrgqvJvY+HYIYx6dj11KW2jEMJiQeJjy+uTmbxwB91G3sfDE67AU\\/wi901ZSplkie5oO\\/\\/JrL8W0\\/PO55k39Xz2L5zOa0U+QOPnj+fw2s6BjLm2J5FPQWg0Gvu2\\/B\\/vf11CfaqbIkSCrBUk9d+x+J1NtBt6F3dedga\\/OOtq7hl7Ho5vF7G02DhncrUKf+kWtrv6cFZfNzndz+b0jhVs2boXbe8q5s9dQ7frR9PfZZ5PY+\\/5+lVmvPkd+2SjRhiMpYIksGMDG3e3oPcp3Qie6KLFiX3paStjw8afkfevvthz3eRWFbNuWx3+XetZt8OFu30637\\/xHMuPGc7NF+RFPH21EOLo0vX3kTS3wJ5d7KE1bduE5KejHdmtYNvPewiQiz11zRNhFM9FjBnxFX\\/+3VD+rjnIHzyeW3I+ZPpb+xg84STWPXkHD63dg6vXJdw69nJ6OCVWrCw9516+GjSKggYvAz\\/r1l7BOd8V40tFwyzAUkGCjDmMRXHS+4YneeOafewLZNLSUcWnU25iS9+buapoBg+XDGTSn\\/tQ9MxkHnmpkLm39jLcC9q3\\/hluHPcGOwLBW9Zz6TnTADvHj3qOZ2\\/sLBs3carfPZdr\\/rE44j6z2v1bJUSOIKO975Jia92O1uxh1+4ABN+e6i4qqqBNu9bWmuczECW9BS2B\\/Wtf5YUV+Vz71xMomV5Ozwsv55TjW9Hjot68+sYaSgO96GiwlZjWZQSPPDeYek3D+8Fj\\/LnoTB4dewZORSGjbb6ESCJ8O9m0e2eqW2FJ1goST096tNnHN2s2U9+vJ+lA7Xer2OB3c36PdjLfrme+rbz97HukDXuCS\\/JhiQaK7UBq2Gw2CASMOd7MaEfH49sBGi2+ycTWIpeCLl1oJS\\/GhMnUVupYKkhI782wS7vywUt\\/YWaHmzinbQnL\\/rYc9aTfMaS7Sbb9\\/JuY85vbWNZrCm\\/cfZpJVrCG96PnWVhxFveO6I7D5qdnr3a8vPx9fujbl43L13FMz0vxGGw0IpqXTG2ljjn6mbilUTBiMpP2P8WzL0zi\\/f1OOp1+Iw\\/dfglus2wBavWoqkKrNq1NM8LSalYyf\\/56Ckc9Rz+XAqTR49rxXPnIdMbf+BKunkO5a9TJGPv7\\/RQ8V83ivatS3Q4Dk6mtlLFYkAC2HPqNnkK\\/0aluyJGh1e5gxx4nPXt3NM38uuLsx\\/jX3jn8NteJjJw6n5EpapMQ4hCZDDAZ9fsituacwwUnm+Pz3kII\\/bPeiMTkMvqMZf4LfuyyZoUQR4mMSEzInmaWSS0hhBFIkAghhEiKBIkQQoikSJAIIYRIypEIEi3sUgghROodsb5ZtyMSu91Ofb2xv+JHVVXs9oY7vqU2fbNibc6MllAv2356pakarkxnqpsRVXMGSWOvwoRfoU6nE6\\/Xm0RzUs\\/r9eJyuRrcLrXpmxVrO7vLGQS8agpaJOKhVaic3eWMJt21ib9LSDJBEm8Dm9TYvLw8ysrKKC0tRVWN9QJXVZXS0lLKy8vJy8tr8HupTZ+sXNuEQX9AK\\/cR2FGHpsrIRC80VTuwTsp9\\/HHQnU1+mCjXG\\/u7hEQ6HZMSdj10sYUtdg58qDG4pIcsjpDLPrW1tTMTaVggEKCmpgav10t1dTV+v3G+Ctdut+N0OsnJycHlch04O20IqU2frF7b1p3bePjDx\\/lk8+dU769JUUtFqGMyXZzZZQD3nns73d1dG6y3WLKyssYBqwEVqA+5DC6+kMUPBMIWLWwJOix0mhIkCgcCJFaQBEPEAZxcW1v7dEL\\/AUDTNOrq6vD7\\/WiacbaSFEXBbrfjcDiirnipTX+kNmPWZmbxrLfGZGVljQXWcCBAwkMkWpD4ORAUcQdJoifS0GgYPqFPEP6EkRoQN0VRyMzMbMpddU9qMyapTRhMrD45Wv+cUJ\\/d1H0k8TyxHAYshBCpF60vTjpAgpr78N\\/wYVCTRyNCCCGaxRHvl5M9aivS8ChSgwNJPI8QQoimibSfo7F+u0niCZJYTxBpB0xogMioRAghUiNaX5zIIcEx++9ERiTxPFm00YgEiRBCHH3Rjr6KZ4or7n67KVNbsaaxZD+JEELoQ6J9dJP660hBEu+DhA+Rwkcg4R9sEUIIcXRF+oBhtGmuRPv+\\/0l0RNLYIb6RprMkSIQQInUaC5Fo+0wi\\/dyoWEES7TjjeJZg4\\/1RHkcIIcSRpXH4qU+auiui0T68OT5HEik8whfjnJRICCHMI9L5syKFSlISPUVKULyjkWCIBLKyskZx4NxcoUv4SSCDwRY8p1fwdCzhl0IIYXaN7YeG6BvtoUuAhmHS7AdGReuYw0\\/cGLwMPwtw+AkcQ5e0GJfhgWIPeUxb2PNFa5MQQphNpM94RNsHHRoWoYsvxmWksAkdBDS2D6VB2CQ7IlHCigvt\\/P0hl3B45x\\/+T7Ed\\/LvQgJIgEUJYUawgibYbITwgYo1MIh291aQRSVODJPRJIxUYGibR7hMsJHxqKzxEJEiEEFYST5BECpNoo5PQMIk1vdUk8QRJcOQRWhQcPhoJD5HQMIn0eBoHQiN4GW1KK\\/wxJECEEFYRHiixPmYRPvJoLEQaOww4PFRiBky0IAkNj2i3NTbkIsL9g39r51CAhI5IYu0bkRARQlhNtB3ukYIk2ugkkR3ukZ471m1NmtqKNipp7EOHwb8JDZFI01nxHK0lgSKEMLto01vBy\\/BRRWNhEu3naPtIEp7iijdIQnesRxqVBEcWkQIlPPHCAyTadFa0kYgEiRDC7KKNDhrbNx0tUBr7DEl4mER6vpiS3dkeFAyZYKDECpPg30ULEiJcEuVnIYQwm1gde2NBEh4o0X5OeiQSlMzUVugO+GAwwOFhEr5jPXSHfCIjEQkPIYRVRZvmamxkEilUGvsbwh43IY0FSaRprEjTWpGO6AoNi2BDQ6fGwo\\/sktGIEEIcLtFRSWOhEunnWAESz853IPERSXggRNurHxoioSGhEd8oREYjQghxSDw73+NZok1pRXrMuCW7jyRamED0EUekU64Q4TL8uhBCWFm8YRL+c6Ql2n2aJJ6OOtLfROrsI4VE6PVkA0RCRQhhNdFmfcKvxxMoxLge73M20NQgCb89Wig0Fi6RLuN9PiGEsIJoHXisMAleNhYa8YZIY7cD8XfOiYRJ6PVEg0NCRAghDpdImIReTzQ4mhQikFgHHW8nH29YxHtEloSIEMLq4u3k4w2LeI\\/Iimu\\/SaKddGN\\/31gwNDbqSOQxhRDCqhrr1BsLhsZGHYk8ZlRN6agT7fhl5CGEEEdGoiOVeO4b63cNNLXzbq6d9Mk8vhBCWFE8nXwyU1UJHwacTIfdHPtXknlMIYSwsng7\\/ESCoUmfJWmujvtoBZIQQoiGmvxhwiTvCxyZTlyCQQgh9C3p8Ah1NDp9CRYhhEitZg2OcLbYfyKEEEIIIYQQQgghhBBCCCGEEEKIUP8Pw1zGDz1zyKQAAAAASUVORK5CYII=\\\" width=\\\"276\\\" height=\\\"306\\\" \\/><\\/td><td style=\\\"width: 4.15643%;\\\">&nbsp;<\\/td><\\/tr><tr><td style=\\\"width: 15.1385%;\\\">&nbsp;<\\/td><td style=\\\"width: 4.15643%;\\\">&nbsp;<\\/td><\\/tr><\\/tbody><\\/table><p style=\\\"text-align: left;\\\">Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor<\\/p><p style=\\\"text-align: left;\\\">&nbsp;<\\/p><p style=\\\"text-align: left;\\\">Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor<\\/p><p style=\\\"text-align: left;\\\">&nbsp;<\\/p><p style=\\\"text-align: left;\\\">Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor<\\/p><p style=\\\"text-align: left;\\\">&nbsp;<\\/p><p style=\\\"text-align: left;\\\"><img src=\\\"data:image\\/png;base64,iVBORw0KGgoAAAANSUhEUgAAAZIAAAG+CAYAAAC57IK3AAAABHNCSVQICAgIfAhkiAAAABl0RVh0U29mdHdhcmUAZ25vbWUtc2NyZWVuc2hvdO8Dvz4AAAAmdEVYdENyZWF0aW9uIFRpbWUAcXVpIDAxIGp1bCAyMDIxIDE2OjQ5OjQzvirHhgAAIABJREFUeJzs3Xd8E\\/Ufx\\/HXJemelNJFGWXvvfdGQBGQoQIqslGGuAEVRQQVRXGvnwtRRERQBGQJMhUERBQQZAhllFG6myb5\\/v5oCqEkbdqjCz7Px+MehORy973vJd\\/33fd7l4IQQgghhBBCCCGEEEIIIcTNR7tJ1y2EEDciVRQrLYrGXAJECCEKVqEGSmE06hIcQghRtAo0WAqikde7TAkeIYTImd5guK7Bcr0a7bwsp6DmFUKIG1leGv+Cmtep69FQu7MMV\\/Poea8QQtws3GnsXc2j571u0dNI5\\/ZeZ69nf05PwAghxM3I3cBwNl9ugZGvQMlvg53T+3ILC83N1\\/KyTiGEuBHl1LDnFBy5hUpelpur\\/DTO7p5FOAsMVyEiZypCCHG1\\/Jx5OHucl4DJ7Xmn8towu9PA5xQgOQVKTsGS2\\/NCCHGjcaeRzyksXP2b02N31n+N63EFlbvB4c5rrpbnTjmEEOJGkdv4RvbHOYVHXoMlt3Jcw91GOa8h4u7j3M5Y5MxECHGzya1Rzy00XIVITuHiznpdMuU2Qw6yh0hugeEsPNwNlOyPhRDiZuBul5WrEHF8Lrd1aG7M61R+gySnrig9E04eO1uPEELcDFwFiavAcGfKvjzNxWO3uRMk7l6NldNkcPHYnVBxVgZXzwkhREmW09hIXsLDlu1xbuvMKUxyDZfr0bWVl\\/Bw9a87Zycg4SGEuHnkNKCeU3jYyGwrbU7e4ypUsodJnuQWJK7ORtwNEYOTx85ecxUqztbpqmxCCFHSubrPw1WIZD\\/zsJHZljqGiebkNVfr1nAeKjmGjN4zElch4iw8nE3OAiW3bi5c\\/F8IIUq6nIIkpzMRx5DICo+syeZkeTmFSZ7lJUhyG69w1p1lAIxcHR5GwBcIA4IAb4d5yLaMnNYtQSKEuNHkdJVW1mPHLiobYAXSgEvAWSDF\\/lz2g\\/Gs+bPa56xlZA8PV2clLuUUJDk11LkNrGcPkax\\/TUD5qKiozhXLl5\\/s4+3tbzQa0TTJBCGEyA+lFFarldS0tKSjR4++Gnv69FrgOGDBdTtuw\\/XJgavwcBksuYVF9v9nHxvJPmjuePbhGCJZU\\/WG9eu\\/VjokpEZaejpmsxmr1YpS+TqbEkKIm56maRiNRjw9PfH28uL8xYt\\/79q9+yHgAJlnJlmTzeHfrMfZB+ld3biIw3PXMOZUPiePczsDcQyR7FPFhvXrvxkUGFjjUkICGRkZ2Gy5XZUmhBAiNzabjYyMDNLS0wkMCChTqlSpRqfPnNkCJDiZPadLjLNzq7vIkPssOXI3WPwiIyO7BgYE1EhITJQzECGEKABKKRISEwkMDKwVGR7eGfDD9YVOzi5qype8BEn2MxR3QiTrbCS8fHT0g0nJyXrKKoQQwg1JSUmUL19+ApkXNWW1w+6ESb4uaHIVJK4W5ur+Dmf3jjiGSRAQIGciQghR8OxtbQAQjOsQyX6FbPY2nWzPZ398md7f2nI3TLxtNptcmiVuOEopLFZrkY33GQwGTHLlo3DC3uZ6c3VbnDWonvXYsQ3P993t+QmSnAbes98\\/kjV5yMC6uNEopbDabAQFBuLv54fRmNO1K9ef1WolKTmZhMREjAaDhIm4ir3N9SCzDXa8gdHxzvfsU77CxN0xEmdnIFn\\/Zg8Rp+Ml0q0lbjQWq5XAgACCAgMLPUQAjEYjQYGBBAYEYLFaC339onizt7muxkXc\\/Umq637VlrP7SrL+dXZGkvXY6G5hhChJbDYb\\/n5+RV0M\\/P385FJ64Yrj\\/X3Z22dXIYKL\\/7uUn8t\\/83v1lhA3nKI4EymOZRDFVoFerZUlv\\/eROFtxTmEiZyRCCFH4nLXFOQVIvtrq3IIkt1Od7KdFrvre9N74KIQQIu9ctcfO2m5Heermut5\\/s13OSIQQwgWTBq38Mmjln0FlTwuhpsyLkM5ZNA6lm9ia7MGWZA8s1+\\/apLyekeRLfi\\/\\/dZVkOV0aLIQQN602\\/hncXzqVSI9rL4yI9lREe5rpEGAmNsPAx+d92JTkcT1W66otdtWl5XgZsNucdTm5avRzCgNXgzeOp1FCCHHTMQAjQlOZGpHsNESyi\\/KwMTUimRGhqddjTMDVcIM7B\\/luZ4E75cxtYc6SLnvqSZDoZAiKoUnHW+l\\/a0NC8n2JhD\\/lGrWjxx19aBruxkJ8ajBg0r00DJbdJ0R+3R+ayh3B6Xl+3x3B6Qwrnap39c7a4pza7pyW4VJeb0jM7fm8Jp5wk2fTkbz8wlTGD2xIqfwuxNSA+16czbTJQ2gRlsuuN0bQbcpsxg+8n8l31cbLneX7NmT0hyv46bu59K+kZ\\/hNiBtDG\\/+MfIVIlv6l0mnpl6G3GO60y\\/kOEdA32J6bnK4IuGEE9JjDsqda45Gxj3fvHc38ow53GHvWZuwn7zI4RuO\\/z0Yy5J2\\/KRn3H2uU6jyRSZ18+PuLx5jy3p+481UwhNWlWfVg\\/IwNaV7Dj8X\\/XsrfH4C+gX2zZIlb8\\/Xv27eASyIKmkmD4c7OKDQDKBddXE5eGxmaym8p+R6Ad+eMQze9P9ro+DinQfcblIEykWEYNNA8azLwnlZ8N+MXkhSARuku99GnogkNRWhUBB6UlCBRXFzzMpPP+HN0z3HS3HyX7dgy5r7iR6fSh\\/h+fcGHSFBQEJ27dGHlihWkpKRc87qvry+39OjB2jVruHTpUgGXxj0SEAVv89atOb7eumXLQilHK78MIrKPiWgGgp\\/6jPRN35O6buFVL\\/l0GoRXm9uIn3HPVWES6WGjpV8Gv+R\\/8D2nQXZXz+VJXoPE3fGS7PPeoGFipHSZ0vb+QQMhne6m10ebWXjSBqYq9L2rBX4agIZHaBilDHDKBhhCaXjnGEb0bUPNcE9SYv9kw8L3eO+7fSTYW1\\/NvyZ9Jkzgrva1CPNM4MRZAyYyf2ntMjeW45QWQscnv6B7RCQ+6bH8seojXntnNcfSAXxoMnoOk3pUJiLED5M5nuN717HgjXdZ+W8qYCS89XAmjbqVxjGlMKXFc\\/boWt547HU2J9eh7wNDucU3FvXret7YawEtkJq9RzJiYAfqlwtGS45l36IXePR\\/e0jPb\\/ntbrnlFiZMmkS37t15+KGHSHb4ezd+fn68MncudevWxcNkYuHChTksSdxoXIVFbiFzPTntklI20jYtI3D0C2DyIPWn+QB4dxpIwOiZJH403enZio4gye0AP6c23e1jwYK+UfAGDZAsnpQK8UfDxoW489g869H3jjp4AH7NB9K7koHkc+dIVWAIDiFIAzQ\\/Go6fx9wHe9GgrB+2dEVA+ab0efQNXrm3Gh4AhjBueepVJt\\/WgCh\\/K0lJJiKjS129s9xZjiuaD2HlSqOSUzEElafZwGd4+cEm+AKQgdU\\/gjKeaVw8G0eSIYRKLQbw5Ix7qGECLbQHjzx3H+2qBmM5c4SjZ80ElvHEnOzsM+dDrRGv8cbj\\/WkRE4IhLZF0rwj8bYlk6Cm\\/3fLlyzlw4AB169bllblz8bP\\/7pVjiBw4cIDly5e7sTQhrq+q3hanz6et+5qE96YQMHw6Pt2G4N1pIIGjXyDxo+mXgyW7ai6WlQcF2hbr+Rn57I\\/zOk\\/JZwimVLCGhpWDi7+EoQ\\/QrEd\\/2nx2hqABnQlRJ1j05a+0eqA\\/UcHBBBnAEHoL9\\/WtiIc6w5rpo5mx+iKRd7zI+5NbUOOuIbT+5mk2hnSlX8sgDNb\\/+HbyCF79NQG\\/Hi\\/z\\/dNtLoeJISz35fyc5KLcttN8O3EQr\\/6uiOwzm48fbUXULX1o8e4O1iVb2DN3AD1e8ySgVBC+IR15\\/N0JNC3XgPplDPwTXI4oLw2V9jvvP\\/gw352xYjCZwALZW39DaDdG3FUDH3WRza8+wNPfHiHN4IufRyqE9ct\\/+e2SkpKYNGECr82bdzlMnp42jeeef\\/5yiEyaMIGkpFwWVIhkjOTmEWJ0fUCftu5rNDQCRs8EIPG9qdd0dbm7LDfkp83O0wqv153t13PekkMLIDjAACqNhCPL+Wn9nTTr1ZaB4yz4N\\/bG\\/OcSlvzqQ\\/2xoPkEEmACY9Xa1PDUsF3cxvKfz2AB\\/lv1E39MaE4b\\/xrUrmBkc0gVKpg0bOd3sGFXAgqwZFx9muzOcn7e52pExkpGhg2wcHrjRv6e3IpmPhWIiTLC4dK0GDONyf0bE+FjuLLjLL74+ID1yFa2\\/HcXFSo24+GvFtN9\\/TIWzf+a9f9e21gbq9ejlreGLX4T3y47QpoCrCkkW8GjiZ7yX5GQkHBVmCxZuhTgcogkJCS4tSsLiwSEKGSF0k7Lb2DpYfDH318DlURiUjK\\/Lf6BYzZv6t3Wg0qGRLYsXsmJxERSFGgGf\\/z9NDdzXmXOZvJwnfTXaSRb8\\/DIPJFQCptV4dd2HNMGNyU84y++ffVZpj+\\/gD0pDitL2807Y8cya\\/5G\\/k0LoW6PkTz34RsMq+mkM8pgyPyAKRvX9Ppex5H4rDA5cOAAUHxDRNxcLlhdt8uOYyIJ700hYPRMfLoNcTn\\/eUvxPha\\/nkFSvLe0QPgR4K+BSic11Ybl4FKW7ErL\\/FuWp1exeGM8Ki0t86onzY8APw3roT\\/Zb1YYglvQq0M4Jjwo170b9U0aKvkgfx+zYv33IP9aFIbAVtzevazT8QJ3lpMrzZ9afXpSywS2hAP8HQsh0WXxM4D1wI98+s1KVv\\/0K8fSHFp9UyCl1EGWv\\/UE9\\/a7n4\\/2WdB8qtC2RblrPkzWo4c4YlEYgltxW5eyeALggb+\\/N7brUX4HCQkJTBw\\/nlfnzGHi+PESIgVo89atOU4i08E054eB2cdEso+ZOPNPeoHcqXHd2uyCKN1NEyiatx++pswgSTMrsJ1h1fyvaK5qEr\\/6G\\/akg9LSSFeAwRc\\/Xw3b8Z\\/4fOkg6g8oT5dnv6HVo2Y8\\/H3xII0Di75gcxLYklfw2Y\\/9md27LO2mfMkPYy6Q7hWCB1y+fNh2NvfluC54JH1e\\/pZOKoDQIG8MJLPniy\\/ZkWbDeOAgF2x1KNP4Qd77qBP\\/JQYQE3Bll5pq3MPbb\\/fD92wscUkeRFQygkrm1MkLKKKuWo3txAoWrB3AjO7hdHrqa1pNiifV4I\\/3nhfp95iO8ruQmJjI4sWL8\\/7GQnQjjJEU1uWzehSHQNuW7EHHAPPVT2oGvFv3vmZMJGvMxKvNbaSuXnDNlVtbkq\\/L725dLsX1XBgUzg2JNyzN189+pVM66WYARdL293hsu8NM1nTSMxSYfPHzM4BKYse88Tx24UFG3N6SamU8SDm5m03fvMs7i\\/7OvPFPXWLrnAd4\\/PRY7u3VnGoRZfC2JHPu+CEO\\/3aIS+DecrKzneHPLbuoUjuGyLAQQknj3KHN\\/Pz1B3y0\\/F8sgGXnu0x9zYvxA9tQrVpjwskgJf4E+w\\/t4kgiGP0TOHE0gToVYqgakUHi6X2s\\/v593lwTj8r+95XUBTbMeoApJ8cw9JYmVAkPxj8tjn8vWvElH+W\\/ARTngLhRFJeg25LswakMw9W\\/r6VsxD9\\/j9NLfFPXLSR1\\/aJrXovNMLDt+gRJgbXJzhbs7FchHX+A0fGvHmZNJjKv2TEBnvbHjv82bNSgwesFswlCFI10s5mK5csXdTEAOHr8OF6enkVdDJFNa\\/8MpkUk5z5jDp495ZfvIPl99+6JwC7ADGRk+9dif2whs7Mja7I5TCrblOWqUU4ZbBdCiAKyOcmDxfFu\\/VKdU4suel2vs5ECJUEihBAF6H\\/nfPjmYt7DZNFFLz4571MAJbr+5CdahRCiANmAj8778FeaiRGhqUTl8jdJYjMMvH\\/Oh+0l4EwkiwSJEEIUgq3JHvyW4kFLvwxa+mVQxctKGVNmqMRZDBxKN7I12YOt1\\/dP7RYKCRIhhCgkFgW\\/JHno+SXfYknGSIQQQugiQSKEEEIXCRIhdLBai\\/5PlRWHMoibmwSJEPlkMBhIStZ3s9n1kJScjMEgX2VRdGSwXYh8MhoMJCQmAuDv54fRmP03YgqW1WolKTmZhMREjBIkoghJkAiRTwaDAWWzcSkhgYvx8UVWBoOmyRmJKFISJELoYDRk\\/vGvojwjkBARRU2CRAidpCEXNzv5BgghhNBFgkQIIYQuEiRCCCF0kSARQgihS6ENtl+4eLGwViWEEKIQFVqQ7P3zz8JalRBCCCAgIKBQ1iNdW0IIIXSRIBFCCKGLBIkQQghdJEiEEELoIkEihBBCFwkSIYQQukiQCCGE0EWCRAghhC4SJEIIIXSRIBFCCKGLBIkQQghdJEiEEELoIkEihBBCFwkSIYQQukiQCCGE0EWCRAghhC4SJEIIIXSRIBFCCKGLBIkQQghdJEiEEELoIkEihBBCFwkSIYQQukiQCCGE0EWCRAghhC4SJEIIIXSRIBFCCKGLBIkQQghdJEiEEELoIkEihBBCFwkSIYQQukiQCCGE0EWCRAghhC4SJEIIIXSRIBFCCKGLBIkQQghdJEiEEELoIkEihBBCFwkSIYQQukiQCCGE0EWCRAghhC4SJEIIIXSRIBFCCKGLBIkQQghdJEiEEELoIkEihBBCFwkSIYQQukiQCCGE0EWCRAghhC4SJEIIIXSRIBFCCKGLBIkQQghdJEiEEELoIkEihBBCFwkSIYQQukiQCCGE0EWCRAghhC4SJEIIIXSRIBFCCKGLBIkQQghdJEiEEELoIkEihBBCFwkSIYQQukiQCCGE0EWCRAghhC4SJEIIIXSRIBFCCKGLBIkQQghdJEiEEELoIkEihBBCFwkSIYQQukiQCCGE0EWCRAghhC4SJEIIIXSRIBFCCKGLBIkQQghdJEiEEELoIkEihBBCFwkSIYQQukiQCCGE0EWCRAghhC4SJEIIIXQxFdaKLBZLYa1KCCFEISq0IDGZCm1VQgghCpF0bQkhhNBFgkQIIYQuEiRCCCF0kSARQgihiwSJEEIIXSRIhBBC6CJBIoQQQhcJEiGEELqUwCCxcvyHN\\/hwWxzWoi6KEEKIkhcklkPvM3b0NJ5+7huOSJIIIUSRK1lBYjvFwqmz2GRpxuNzR1LFCGDlrxdbExIQQEC2KbjWo2zKcL4olXiQle9MYditralTKZLwdi\\/xVx6CKbf3px7fwEfT7qN746pEhZYmLLo6zW8by9zVx0l3srzUf39g5r0dqVMujNDwCtTtOJRnF+8nWeWhfnKTsod5t1UkKCCUfp+d45pFpx5m6XODaV8rmrCwKKq1vIMnvthLopMyWE7\\/wlvje9OsaiShpcOpULcjQ6d\\/w9\\/ZCpzXerhW3vavW\\/Vo+Z3pTUpds7wrUzD1p\\/2Ki4+OuCyV4xs\\/5pmRt9GqVgXCS2fu36Y97ufZr\\/7g0rUfMI6umsPIbvWpGB5CSHg5arbszbhXV3E01fVaLOf\\/4Pu3pjGybwcaVS9PeHg7XnTxZXVnXpWwlwXT7qRdrXKEhUYQ06A7I19exbG0a5eXcng5L43uSeMqkYSWKk1klSb0GvMKq446mfkmVqJ+ACt951u88lMC5Uc8zcjqWUVXpCSloExVuH3yUBr5XZnfENCQisbsS7Fx9udZDB\\/1ChtOGwmr24YOfToSU6UxgZo7pXDn\\/VZOr3iZ6Z+epE6HrtzV2Ye0U3+wftUXPDPwFw5\\/9QtvdC9F1uzWI59xb7cJrEyModvQSdwTHMe2rxfwyv0b2Rn3E4vHVMcj\\/9WWKf0gHw8bwNMbzmPD69rXrcdZMLwH4344T1iTW7mrmyf\\/rFnG2+N68cfFlXz3YC087bOqcyuZ1G0wn52KoO3A0QyIMXJyyzd8+epwft5xjrXfjaGaKe\\/14Jz7+9ftejRE0u7+hzGcs2VbVwZHVn3A4r0a0dFluOajI65iO7mQiYMmsibJITHMsezftIj9m1ew\\/uhyVjzRCB8A0vnr3bu49fF1xNmy5o\\/nxJ\\/r+XzfRlZufJEfvx5NDU+HFahL7PzgYcZNX8TfibYrBz7GQC7E28BxD7k5r0rYwrO33cGrvyddnif18Ba+mrGdDTvmsfKLe6hkb1pSd8+l723T2RJ\\/5XOSfuYAG7+YzqaVG3npp28YXU33N\\/OG4Ow7rGV77DgZHCajw2QCPOz\\/etofO\\/7bMDEx8XV9RU1ixZh63LmoHE9vWcfD1bM+RGbWTahF34Wt+PToZ\\/TxyWUp256lx+2v8nfYrTz97hzGtI7EM+e35O\\/9liQSzX4E+GZVp+LC8rG0GryA+N6fcvizvmS2iQn8MLIBgxd5c9eCX3inZ2k0QMV9z+h2Q\\/kqqRcf7p7PwNJupZxz6gJrHu7KnV\\/6M3JoKT58dxNt39zP4ntC7TtbEb98NE3uXgi3vcfPn95JtBHU+Z+Y2HEQn5zvzJu\\/fs09ZQ2AlQOvdKLlc\\/\\/S+a1tLBxSNvO0Vp1j6YiW3LPYxMjv\\/2BOW4881oMr7u5f\\/fWYvudFund7gUPNX2LDt6OpXKIOs4pCKr9O781Df9aiZ6cmVAk1EPf7Qt56\\/2dOZCgMIXfx5d\\/v09MXbCf+R78mk1ibrDAENGDwlPF0D41l+euz+erPZJTmT5fXd7B4WNbnKYGtM3rTb85OkhRoplJU73Q7vTs2o1alctRq0Z6aIfZ96fa8ZnZOb03XV\\/eTgYmojuMY3yuIPR\\/PZeGfSShDKXq+vZ0vB0disMXycb+GTFybAsYouj0xiwfb+HF44QymfrqHZGUgbOgi9r7dDd8i3AO5CQgImAjsAsxARrZ\\/LfbHFsDqMNkcJpVtynLV+WbJ+aqkbOS7lecx1h1P7yqOx4oWLl1MRAsOpVRuh5DpO3ll4uv84dGeF5d8wpgqeTyayMv7Tf4EXFW7GoHlognWIMnkUFDzb6xadx4tehz3dS19OcW1Mrcw6o4YFs1bz\\/KNyQzs6395e08dPIZf1cpXn0GlHuNgXDjVyntnK4iV\\/758kDGfpND7w+95yvgkH72bvbAJrFv4I2cNVXjoof5E24unle7C5FFN+GLKBhYuj2XIqGgMWDl66ChWY3maNIq40jeqhdC0RXVMi37l1BkzZJ1DuVsPLrm5f\\/Ncj9mr6R8+eGwuu7QWzHxluISIW3xoNn01mx2fuqMF1u1NmbYjA1tyHHHJCnwhfsOPbElRgAd1J77HvAdrYQJ61U1jX9uZ\\/JGRzC\\/fLOfUvaMoa1Akrn+GUa\\/+TpLSMJW9hRnz32VckxAnffF5mDf1Fz5dcJAMBYbQfrz86fP0DtawttM40GoGuzLiWfv5d5y4ayzlLX+xc08aCjDVuIdnHulHXRN0aJTE+q+HsTTFRvzRo1y0gW\\/JGiAoECWmCjL+3MzWeI2yLVte3V1li+fcBQtacBD+1uxdFVdLXv8Bn+63UfGeKQyrZCPh7CniEs3XjhVcx\\/enXzrN8X\\/3sf2Ht3hw7NscCOnIE5O6XjkKt8RzMVFhKBVC8FV7w4PqdapjIo1DB49fvkIt7bfn6dOmA\\/1e2EJ81opT9vLOkM607PEIq7J1TFv+\\/R\\/jn1hNqVHvM7dvlPPumoz97NydBP6NaVHbsQU1ULZZc6IN6ezduRczAEaq1KiCh+UA33+zm5SsWdU5fvl5LxafxrRpcu1pQ6714Iq7+zeP9Xg1xYXlL\\/LatnSqjpjB8KqSInmScpJ9O35j2y+r+GrOVD78wwIYCG7Xm46lNUCReDEBqwIwEBp+pdvQVLU5TUIMgCJj\\/172WwDbf3z16gKOWRWYKjF83hz6lLnEybPJXPNXjfIwr+WfbfwaZwM0vJp1oV1w5uGGsUon2lcwAgrzH9vZlQYYQgkvk\\/lBsh5eyaLf4lEoEn7dwt50BZgo36ghYSWmBS1YJeQbo0g8eIBYq4l2NatcXWjbGWLP2rDsn0OH8Ln4lq5I7RZdGThmIve3j3bodsrg9zUbuKA0PNZMpu5H+zidYgPNm4gmdzB59guMbhaSQ399ft5vZsszbenz0WlsgBbQiAnzP2RcPYeG1rMCMWWNWI7sYk+8ooZD14tnUCCeKFKTUy+HlXej0TwzeAXDXhpIP+tCvpnsz4Kh\\/Zi20Yc+b0ymY5BDCaxH+HjSs2yKGM0PT7clSMP5ALf1FCfO2DCWjSAs2yfCGBFFhFFxMjaWiwoiNSOV7pvOmK8HMO+VvtwS+zCT72mC+dspTF7hSdeX5nJ\\/xezfLjfqwRV3928e6\\/Hq7f+HT1\\/9jjj\\/zjzzQBPcKFXxYDvGshdeY22cq4DV8Gs2iucG1yrQL7rl8CcM7zqbfZdbbg3vmiP5+P37KG8AMFCmSiUCDVs5ZzOz7ZPX+anto3Ss6ENGXCJmT3sHa+IlEqyg4tfx4\\/bMfaWpU8wfUpf3U20ozYhf+VYMmvQcz9zfhBADqHPuz2s9eYz\\/rJnlK1W27JUuKUME5SINcAhU+gmOn7FBTD2GPXo7C0Z9y4m03bx2axM2dG2EdcsqjlgNBDR8kNcfaaJ\\/7PIGUUKCxEbcmThsmjdlwgKubqyN5ek\\/ez4NLsQTF3uYP7et4YfV7\\/HYiiWsnrOcL0dUz2xs1EUOH4rDqgUQUrUdA8ZOJKaUgfj9q\\/jwzS957PbDpK\\/7kYk1XXw08vV+D+qNfIdPm\\/\\/H8QNbWbZgMfMGdOD4vB\\/43+CYzMo3NWDQ3fV5b8aPPD1yNj5T+tMgzERS7F7WL95NOhq+\\/r5XttkYSc9XlvKZoQ\\/3vNKf1l95cOpMEHe8vYx3BsU4BKeN2IVP8vymUO5f+gQtcurINaeSalPg5X3NMLzm5YO3Bio1hTQFaKAFteXJeRPZ3GsWu75+lvsWZGBVGv6NJzCmZ2UnQ\\/lu1IMr7u7fvNajg7RtH\\/LRbguR94zljsgSdIhpqEDvaXPpXdTluIYibf8nTJrckGUfDaaSB\\/h2HM2oBkuY9XsKyTtfp38DJ0OmJi+8DGA59Df\\/ZGRGvrKmkJx1RZeyknzsF\\/43+Vb2XFjFqsfqY8jDvNaUZMwKQMPT2+vKZ0Hzwts7a7wljZRUBRiJvmMW05duZNTSOGzmM\\/y+fEXmPIZAqrVpS2V\\/HeOWN5gS8q1RmNPNKM0TD1O2naf2epFeAAAgAElEQVSVpnbnXtw+YDAjJj7Na19uYM\\/PL9I1JI7VzzzFojP2Y1CVTEKSAo+mjJs3i8nDBtG3zwCGPfEB3829jVIpv\\/HOB1vs3TfOipCf92uUrt2FPncNY8L091m14QP6h55k6ZNPseRc1rGxiToTP+XDcU2xbpjF4I6NqF27Hs27DWPGD4cx40H5imWv7pIyRNDtqWfpXzaVE\\/9dIrDLEzw\\/IObqQf+Ujcx5YRXm1sO5K+YSJ0+e5OTJk8ReSEWhSLt4mpOn40kD8PTBx6BBevo1ZywqPZU0BZqPL1nftfS\\/3uLOfi9xtMlTrDgYy5Gdy3jjwfYE753HwK5j+TY2+xGyO\\/Xggrv7Nz\\/1mFlRbFywhP+0ivQf0rZYD5wWV6a6U9l2MYELZ46xb917DK\\/vh6bSOfbd40z71n6ZuVdDHvtmCbMGt6Ccr8HeiGt4+Qdc\\/lwZo8sRZQSVlEiSvRssfNDH\\/BV7jovnT7Dnm4do5q+BSmbXO++wPiVv8xp9fMk8+VGY09KunJ2qNFLT7P\\/TvPH10YBkfpt9F5OWxWEzhNBy\\/MvMnnAbtUsZ0WwJ7HxzMH2e2URSYVVyMVdCgkTDx9cbTaWRmpbzOAho+NUZzsS+URgSt7Dxd3vTrvng56OBSrUfcVyZP7RNB+p5WIk7cADXvQQ63w8YI2\\/l3p7hcGkT6393uEvBswK9Z69m34GdrP9hCd\\/9uJ5f9\\/3Gi208wLMBbZpfPUCsEn5jzl2jmB9XgU7da5Gx8mEGTF3DWYd1Z+xewU8nLCT9PIV2NWtQo0bmVG\\/CCtKUmV+mtaR28yfZYAaMkUSHG7CeO83ZbB3L1jOxnLZq+EZFUUoD1Bm+eWYmG9Pa8dR7D9My1JtSVTty36wl\\/DirA97\\/LWbme7uu7ct2px7c4mL\\/5qMeAUj5hW9XnMVQ8Vb6NMzL9XviahoeviGUb3o3s6b1IXPYI5Hftv55+X4cY5lWPPDuav46cZJD+\\/awZ99BfpnexH5GaiC0eSuqm0DzD8DPHi4WzyDCA7wweQZRqfsjjGyXeSZhu3SAA6eseZrXGFWOskYAxcUTsaRkfY1tpzlxKvPLo3lFUy7MgO3kV8x4PXMAP6jHLObPHMMDMxewafN79Ik0gkrjwMfvsSqxUCq32CshXVtGwstG4sEfnD51ARtRuSSgAT9\\/HzTiybBkHWmEULlKCIaNh9l\\/KAOir3TA2FKTSbZpGP388XV1tqr3\\/QAoMjIyByINTjbAK7QqTdpXBRSJW6Zx77pUgrreQ7\\/yV2ZWl7Yxe8BAZu8uw+APv2PebT788vQdDH5jMH0sn7Hkxe6EG8BU8z7eWtiR1GwH\\/Bnb5jLs1d+oNeZdpnSvSWMTYKhB4wb+8P0Otu2z0KNx1sfCxsnt2zlh86JF47qZZzwZf\\/Hr7mQMZRtQP9xxI0xU6NqFmh7r+ePQEcw0zuHDlXM95M7J\\/s1jPWZJ\\/20VP1\\/QKNu\\/B\\/VKWoe39SjfPf8Kq8\\/mMEbSciwvDKldiF90G\\/Gnz9g\\/dxpePl7Xdid6+BNW3gdt02zGztxgv2S3Knfd2xYfQFWtTXVPjeOpNi7t2MKf5q408gSsp4k9Y80cDzEGERRgwBSYh3kjm9OktIG\\/z9hI\\/20NGy\\/dmXnV1qH1bDhmATQ86zWnkQ9Y\\/\\/iHf9Mzu7hCKlXOPIgCTNEd6FDTxJJTVpQ5notJCgI0MJ9m5+oNHPVtTPcOVXDs9Uo78Ss\\/bT5J6RbdaV3B8Zw3hWObV7HtfBStujWnXPYLLkuQEhIk4FuzLpWNyzmwdz8ZRF3uh7ekpGDz9b2qW8cSu4IPvv0Xq3crmtfPesWTZr1uIeLjT1n6wRIeaXcnZQ0AKez6bCF7LD607NKGIJdBkJf3K5LjE\\/AKDrqqgtP++Zx3fziHCuhFmwauWq0Ujq2cw9gH3uJAQEfmPD+ICIcymWP3sjM2ivs+XsyrvTK7ajrOWMJC0wDGbtnN8ZRuhPtraKVq0r57zWuWnp7+JQYMhNbpRPfOWfeRBNJpUE\\/Cli7ki9cWM+qTQZQ1grqwlrkf7CAjoDODetnD21iOmGgT1n2b+PlgOo1rZe0JKyc2bOSgxUjZmIr2\\/aGnHjK5v3\\/zVo9ZZT60dTtnbX70adMgh\\/uJUjm86nN+OFGFvkM7Ud5hxrSjq\\/l86TFi+gylSwWH0aH0o6z5fClHyt\\/G0G6VKJA2wliRPs+8QZ+CWLYbbLH\\/Y3DvRfh260zT6pEEmczE\\/b2azz9al3m0bwihTbu6lwekU45sYf3u45w9foAdG75n6bqDXLIq0HyoNfZVHm6cWX9aaHf6dwpkzfJLWPa\\/zZixgUzuXY4La+bxyq4MQMOneU86hWpomvvzYmjP0IGV+PLNQ1jOf8tj90byX68g9nzyKrszAEMwnYf2IdoAWqXa1PDWOJZs5dhnjzG5wiPcUcuXc9s\\/ZO4m+\\/WLUXWpW1oDdZEfHmzHkK9OYcWXxtPXs3ZyLYyAOrOQ4W1Gsey8DS2wI69s\\/o6RFQ2AjWMf3kmryetJUAZCer3N1gWDiSohfUTuyH4DouMNh16AD+AHBAKlgFAgAigHxADVgTpAI6A50BaYkJiYqHRN51epcRWMylT1IfXzxaznz6sfR1dUoVVbqVvvvl+NGj1SDe3bTlUJMipN81eNH1+rTjsu49Jf6oM+kcqo+agKnYarJ56bribf2UiVNmrKv\\/EU9fOZrHkvqk2P11ImvFTnNw6rhLy+\\/9I+9WLrABVRr4vqf+8oNWbMcDX41maqvK9BacYw1e3VHeq8Q7ku\\/fWdmvP042ri\\/Xeo9jVKK09NUz4xvdWLP5+8sm6H6cK5806eP6\\/Onc+9Hs\\/N76d8NC\\/V9a0jVy8jfp9699YIZdS8VNmWA9WoMUNUp0q+SjMEq7YvbHMob4L696shqoKHpowh9VW\\/8dPU888\\/rSYObKLCPTRlCOup3t13KR\\/14KzO87Z\\/81qPiYkn1Ac9fZXm0UTN2BXvss4SDr+luvlqCs1X9frg+JVlJRxWb3XzURqa8r3lXXU04UodHXm3u\\/LVUJpPZ\\/XGoQR9n\\/1iOp1ZMFAFa9fcsJY5aZ6qQv8P1b74rPkvqf2vtFOe2ebTvMurrk8uVf\\/EX73si7vfVD0ijEq7ZtmaMoR2VLO3xeVr3oTj36sHa\\/teO69mVBE931K7L7ctZ9XGZ1uqIIPz7dM8Kqi7Pj+gLiUmqsT47WpafY\\/L6\\/QfsEDFZZXt54dUVZP9fYYIdf+y85e\\/r98Pj1QG+\\/KMMePVmgvXfx8BE+xtcHN7m1zH3kbH2NvsCHsbXsrepvvZ23gvrtxkbrRngWM2XKXEnJHg2YQ7+lTkvTe\\/45vfptK4pRdgI7R5P7oe\\/pnta77mp\\/OpGPzDiak\\/iCmjHuLB3jWuvk\\/BUI47P1hFYK0ZvPrld8zblIgWUoWWI+bx1LR7aeRw1mm1WEEz4h\\/gd6XW3H6\\/BzV7DKTpj1vZtmwzpxMseAZHUb3dSCZMmMz9baOuumzQenItb7\\/0ERdDy1G1Ti8mj7+ToQPaUt7FdageXs6OnT1x+rS7jOUZ\\/L8V+L\\/0NK8sXMlnu2wEV27N2LefZdrdtR2O1jXK9HqdVd\\/WYvbc+az65CWWpmj4hcXQYMBTvPH4g\\/S43IWUx3q4ps7ztn\\/zWo9YT3D0RAZ4lKNClOu7HbWgurRuWIYtR+rQtq6\\/w9U+QdRr24SwLYeo2a4eAVdeILBuO5qGb2Z\\/lXbUC74Rr+5R2GJ6MG5YOpt27uHvw6e4kGLFMyiSyvVb0\\/PucYwb2JDSl6vVgH+APyZPX\\/xCo6hYrR7NOvSg\\/6A+tIi+9nzNVPlePl8bxTuz3+DLtTv5Ny4dU0hFGnW5m4lPjqNbBe98zauV6sDMH3+k2gsv8P732zh03oJ\\/dH06D36Yp8Z3p8LlFtGHhpO\\/Y0PNd5jz1kLW\\/v4vZ1PAp3Q5arXswdAJDzG0WRn7WXp1Bk24ix+e+IZ\\/\\/Vrx0Mj2l3tMTHUHM6nvTzy1\\/ASlOz7Efc0dekjum0TPjS+w7nxZejw0hFxOzou1EvQTKWA9\\/CY9Wk1lf+f32PHFnYQV2PcznVVjqjHw62imbNrI47XkV5cKntS5ENdbYf1ESonqkTNWHsa0eyqSuGImL6y75PYd6XlmPczuPxMxVOtJz2rSoBUKqXMhSqwSFSTgR9spLzEk+gRfPP8\\/DhbQ3yOxndrFnjMBtBsxlNolp\\/OvRJM6F6LkKlFdW1mS92\\/jn9CmNAgtwCNXazrpeOElB8eFR+pciOtKfv03B341WtCgoFdi9HL2VztEQZI6F6JEKmFdW0IIIYobCRIhhBC6SJAIIYTQRYJECCGELhIkQgghdCm0q7b27NlTWKsSQghRiAotSFq3bl1YqxJCCFGIpGtLCCGELhIkQgghdJEgEUIIoYsEiRBCCF0kSIQQQugiQSKEEEIXCRIhhBC6SJCIm067du2KughC3FAkSIQQQugiQSKEEEIXCRIhhBC6SJAIIYTQRYJECCGELiUgSBRJ\\/6zkrceG0KVBRcoEeOHhHUh4lWb0fmAuq46mOX1Xyj9LmTGkHdXD\\/PH09CU4sgZtBjzKR9vPYs1xfan8t+kLZk+8i25NqxNd2h+\\/ulPZYdE5v7rI7588Qt9mMYT6e+NXuiKNb5vI+9vPOS2PSvqbb58fRpe60QT7eOLpV4bKzfvx8AfbOJvzBjhZ2CV2zutDBU8DmrEMw1eanc5WsHWWytHVbzJ5QGuqR5XCx8MTv9AYGvccwyurjuJsL+apPNaDvNTCE03TnE7GiFH85HyzhRAFQHOYDICRzJ+b9wC8AB\\/ADwgESgGhQARQDogBqgN1gEZAc6AtMEHlk+3cl6p\\/iEEBTidDmW7qzb\\/Mju9QlzZPV61KOX+P5llJ3b3gqLI4WVfy31+pSe2jlJeWbR0Ro9XqdB3z206r5eNqKx\\/NSXm8qqphi08oq+PscT+ph+r7K83ZNmueqsKg+eqIsw1wIvXoSvV870pX1m0IVfevyL4xBVtntks71Jv9qzjd\\/qwydX3zL2XWU56MHWpKTZPrz0n4SLXKXp62bdu6V3lClHDABHsb3NzeJtext9Ex9jY7wt6Gl7K36X72Nt7L3uab7BlgyJYNJStIlEpRWx+rpbz8y6nG3Qep+8eOUyMHtleV\\/LMaGYMKu+8HlZQ1e9oW9WgNj8xGWDOooNq3qVETx6oBTcKUyd6QGUr3UZ\\/F2hzWYVPxW55TbS4HlqY0nwhVt9Mdatj4R9XUmYvV\\/qtarbzMb1PnvrtHlTXaG0GPCNXk9jvV7U0ilGdWeUL7qfmnssqTpn55qLIy2pfrXbGrGvv0TPX02C6qgpdmb3gj1P3Lk1ROUo6uVW9P7KZifLVrGu1rgqSg6yxxq5ra0EdpoDSPUFWrQx915509VcNwz8thaQi7T32fpKM86WvVuLKZZTGW7aBGTH5YPfzwlemR6YvUAXt5JEjEzUKCxIEt6aw6k3R1I3Z+fl8VYG9UPNu+po7YD+nT1z2gou2NtrHyOLX6kv196X+omc287Y2Tt2o\\/7+jlswDb2e\\/UveWMmQ2dMUy1feRL9ccF14f8eZrfely91dnHvl4f1erFfSpdKaXMf6s5bXztz3uqFi8dzDzCztilnq5rP7I21VZTfstq9NPVjqm1lQkUmFS9Z3arDNclVBe+HqRKG7LOYgzKYNBcBklh1Fn6n6+ru+54Rn1\\/OPnyc5aj81QHb3u5PBqpGX9a8l0elbpE3R2QuSyvbu+p0zblkgSJuFkUVpCUgDES0PzKEOZnL7s1jYtHt7Jw2S5SATQPKrVsTpQBQBF\\/6B\\/irAAaAa1voW2g\\/X2etRjQv0Hmn4RU6eze9ru9Xz6DXfOmseCEFaV5UuO+F3iivQd\\/rVnO2h1HuHRNZ3ze5lcX1vDjljQUoHm25p6hNfEE8KjO4KGt8dQAlcHutRs4pwAMaFm7SSVzMf5Kx74lI8NeIR5ERIVhdF1jlOo1nP5lfYlqfjfPffUdTzX3cDFvYdQZeNaewIJvpnNrJd\\/LzxlDwinjmVVkP\\/z9tHyWB9SlOM6ZFaDhGRJKoFvHTEKIglLszkiUUkqlLVNDg7J102i+qmr\\/t9Vuh16eSwv6KV8ts6vFs+1c9a\\/D4EPy1wPsr6G8Or+tTtqUUuat6tGqRhd965ryrdhdTfnh+JX++zzOb976qKqadXRdcZL6xWE4x7xhgqpw+cj7YbXZrJRSZvX7sw2Vt30bjOHt1KSP1qnNX09QjQM0BZryqjFBrbmYwyG3Ukopq4qPO59ZDuth9UprT5dnJAVeZ04lq50zWig\\/+3p9285V\\/1jyWR6llGXvDNXQw15ngZGqaq2GqvUtd6oHZ85X22Kv3l45IxE3CwrpjKTQ\\/mZ7wcgg\\/sRfHDhtpn7lzENb\\/xbtaeq9hA2pCvPm6fS5O477u1Qj0HqBwz\\/uIuv4XlksWBTYTv3Gr8dcXZOkSDm6ilkDbkNbv5Xnm\\/vkeX4Vf56LKvNVQ3AIwQ7ngFpQKYLsu0TFXyBeAXjQ8Imv+eBgD0YsOET6mY28NrwTr9nfYwjtyWvLXqZzcG6H3AaCQkNymSdTQdfZtZLZ+\\/Zd9H52O8kKNP+mPDF3NFWM+SsPGlhP\\/UesNXP91oRT\\/PPXKf75axebVy7k7TnzePir73mxW5h7nbtCCN2K5xmJ5V+18u3X1KsvzVBTJ9ypWkR52QdqNeVVd4ranpo1Y6La8lTTy+MnzidN+fSZry4ppTK2PaaqmbLOGO5TXx04qxLT09Wlo+vVSz0jlME+f\\/CAheqiLe\\/zp\\/94vwq1j1V4NHhO7XUYRsjY\\/YyqZ8oaPB6mlmdd5XR+g5rerowyaijN4KP8\\/YxXruDSTCqqx2vq95zH2q+WyxlJQdfZVWwX1ObnO6oy9jEbzbOyGrrwWLYrwvJWHqWUspz8Tf2wZLH66vMP1LxZT6ox\\/Vqqcg4XGhgiBqvF5zILI2ck4maBDLbnzHpqoboz0n7FkKGsGrfWoXG0XVJ\\/LnxGDelQW0UHeyujwUP5R9ZUVSPsVwJhUrWm7FAZSinz1kdUFXv3kqnaY2qbwwh2xs6pqlZWg1n5YbXFnI\\/5tzx8eX63urasx9UnvctkNsaGUNXttT9UUspJte3zx1SnKJN9oNlD1Z7yq3JyRbKLysotSAq2zq6U47RaObmxCrQHq+ZXV43+9pjziwbyUB5X0g5\\/qvpH2bvgtAA1YGFm7EiQiJtFYQVJiRhsd8YQ3oZ2tewDyLbzxJ5Ov\\/KiFkjtgdP5fP2f\\/HcxFYvVzKWdT9MAKwrAWI6ut9TFBBhKhxFqrwXr6aMcT3VYjH8g\\/llVlmHGnI\\/5TZWqU9kj80nbqX3sO2fv50Jxfv9+TtsANEyVq1PZBLZj3\\/DByjhsgKnqCJ5\\/oC5+PlE0H\\/Iiyz4bRQUjoDI4+ONKDub1xsScFGCdZUpk27O96T93Jwk20AKb8sjStbzdt7zz\\/tU8lMcVr0qDGNLRL\\/NTr9I5HXshv7UjhMhB8Q8SdYF\\/D8aR\\/aZk86ElLP3dfhWToTRRkV4uFmDhwq7PGHfraBaftgEa\\/q3GM65V5piKsUIzmkZmds6rpLUs+C4WGwAZ\\/LN0GXstABqeNetR3ZT3+bXQ9nSq74EGKPNm5n9xgAyAjH\\/48ovNZF5o5EGDzu0J1UAlJpBks2+6OZFEh3w0mEyFtMOub50BpG19nvtn\\/UaSAs23HhMWLefFzmXc3J6cywM2Ei8mXHO3uy1uLcu3JWcGj+ZFeKR7Y0ZCiLwp9oPt6vQixtQfz87yzWjVqCoRgSbS4\\/azec0WjiRmNl\\/G6Nvo08zz8nsy\\/pjP059s49yZ\\/zi4exu\\/\\/n2WtMzWBGPkrbz64YNUy7p21rMV991bm\\/ee\\/wOz7TxLx7an5y+9qWn+jUVfbiFVAYYy3D68D+FaPuY3VmHI2Ft48bdlXLClsHlqZ9psbk9U7AZ+\\/C2zkTOE9OSBoVUyL+et1oH25YzsOWLFevQ97uqcwP196hGc9Dc\\/fPw5R6wARsq2bUdVI2DZzdMNmzLjTwvgTe\\/PT7N0SFCe67lA64wEfnzjQw5kZI6M+1SqDD+9yKM\\/OZZAw7\\/5SJ4aUA1jXstj3cfcTi2Zl1KPpvUqExnsDYnH2bHuZ\\/7MvI4YQ5lbGdQlIM\\/1IoTIn2I1RpK8dKgKMbgedDUENlaPrI5TjmO6aT\\/cp0KyD9RqXqpsx0fUt4fSrl1J0nb1fOtS9kHi7O\\/zVtXuX6JirTrmtxxTC4dUunwnu+OkeVZWQ78+7jDYbFOnfxiravloLrZZU97VR6jvTtlXYNmrnmvgYX\\/NW\\/X+PP7a7XNjjKRA6yzjV\\/VEDdc\\/X5I5GVSZESsvj\\/vkpTy2s\\/9TPV3WF0rzr6ce+D728s2LMkYibhbI5b+ZDLUH8+zjHqzetIO9B45y6kISFlMg4TG1ad5tIGMmjaRrxasvMTX4BxDg6YMlsAzRlWpSv0UHevUfTL825XB2MSp+zZi6ajt1583ijS9Xs\\/PQWZINgUTXaUe\\/UU\\/wxH1NKW3QMb+xPAM\\/3kLZljOY+f5Sth48S7pXONVb3c6oqU8xqpXjzYUa4b3eYuuvHZj74jssWr+LQ2eSUF7BRFZpSIc+w3lo0iDqZ13+a7vAuYv2vjBjGBXK+ZIfBVpnKo3UNOVsKdenPKb63P3kWAJ+2cGevw\\/x35l40gz+hFWsQ4tu\\/Rk5cTQ9KuevXoQQuXN2GZeW7XH2M5SsyegwZZ2xmABP+2PHfxsqpV4vmE24ualzH3NrueH8mKbQggbw1bGvGZj3nq2bSrt27di4cWNRF0OIAqdp2kRgF2AGMrL9a7E\\/tgBWh8nmMGU\\/w89y1ZFh8R9sFzlK37WNXWYFGAi5ZQBdA4u6REKIm40ESYlm4eDOP0jWNDRTFe4dfxul5NZtIUQhK\\/ZjJCInJuo9sZVzow+z628zVVt6F3WBhBA3IQmSG4BHqco0a1XUpSg5ZHxEiOtLuraEEELoIkEihBBCFwkSIYQQukiQCCGE0EWCRAghhC4SJEIIIXSRIBFCCKGLBIkQQghdJEiEEELoIkEihBBCFwkSIYQQukiQCCGE0EWCRAghhC4SJEIIIXSRIBFCCKGLBIkQQghdJEiEEELoIkEihBBCFwkSIYQQukiQCCGE0EWCRAghhC4SJEIIIXSRIBFCCKGLBIkQQghdJEiEEELoIkEihBBCFwkSIYQQukiQCCGE0EWCRAghhC6mwlrR5s2bC2tVQgghClGhBUnjxo0La1VCCCEKkXRtCSGE0EWCRAghhC4SJEIIIXSRIBFCCKGLBIkQQghdCu2qrfwwm82cOHGChIQErFZrURfHbUajkYCAAKKjo\\/Hy8nI6j2xb8SPbJttW3LizbcVBsQ0Ss9nM\\/v37iYyMJCYmBk9Pz6IuktvMZjPnzp3jwIED1KhR45qyy7YVT7Jtsm3FTW7bVlwU266tEydOEBkZSVRUVLGtPFc8PT2JiooiMjKSEydOXPO6bFvxJNsm21bc5LZtxUWxDZJLly5RpkyZoi6GLqGhoSQkJFzzvGxb8SbbVjLdjNtWXBTbILHZbHh4eBR1MXTx9PR02h8r21a8ybaVTDfjthUXxTZIhBBClAwSJEIIIXSRIBFCCKGLBIkQQghdJEiEEELoIkEihBBCFwkSIYQQuhTbn0gpCLaTCxl\\/37v8Zcn+iiftnl7Gsx2L72\\/ZuEOlHGLF++\\/w5fo\\/OZPuTXjN9gwaN4ZeVX3RirpwOqn43Xz1xjss2XaES8ZQqrcZwNixfagZUNK3TJRkKvUYvyycz+L1v3Po1CUyPEoRXb0RHe8cyZBmoSX+e+eumypIDGW68OgbdUmxZT1j5dRPc3l5QxmaVi\\/ZNyyhEtny+hO8\\/lcDRk97gwb+Z9n0yWu8PtVKmU8epblvURdQB9sJljw7lc+TOjPhhUeolPEXi+a9zROzvfng+R6E3Szf1hImISGBZcuWsXnzZmJjYzGbzURHR9OyZUv69u1LqVKlirqIuqikPXz0yBS+PBFG69sGM6lWBD7mCxz763cS0m6qpvXmChI8S1OxRunL\\/1WnlvHxugs0GjubXlElvJfP+g+\\/7kyk+qDh9G0aiUY1Kow4yM8PbGDvf1aaVzcWdQnzzXZsHSv3+dD5hQe4pb4XUJWHRv\\/F4Gd\\/YN3J7twZXcL3HQBp\\/P7GSJ77oxOz3xlGjRL+zdy+fTuzZ8+mdevWPPjgg5QrVw5PT0+OHDnCmjVrGDZsGA899BDt27cv6qLmUzp7P53DV\\/\\/FcN\\/clxlazefyK20631qE5SoaJfzjqoNKZOtnn\\/NHWB\\/e7BpW8k9BDWGUjdBYv+NXTva9nWiTjXP79xMXWIta0SU3RABsKUkk4Ueg\\/5WPq0+lKkSzmSPHrXBDBIkR\\/7BylIsOxbeEb86mTZt4\\/fXXmTVrFjVq1LjqtZo1a1KzZk169OjB1KlTAUpmmKT\\/zo+rTxHcaQIDHULkZnXTBok6tYqF6y20eaIvVW6EWjBE03vSGP6Y9jZjR2yjfR0bv29Noc\\/T02jpV9SF08dYvg61fJfw85KfuWViJ8p5mzl36hxpyoLZooq6eNeJB9UGvcAbRV0MHdasWUPp0qV57bXXmDlzJtWrV3c5b5UqVZg5cyaPPPII9evXJzg4uBBLqp8t7hj\\/JRuIqV6FkvV7wgXjRmhC88HKoZXL+TukC3NaB5X8sxEAFMlnj3PGFkOHni2IiN2MIe0Iv6zaSa86HYkowSclWkBbxjxxBzPmvMi9t72ABnj7+WC2BVEvuGQfvlv2vc29ExYRa8v+ipHK973Pe\\/dWoqTsuu3bt7NmzRpq1qxJTExMrvNXqVKFTp06sWTJEoYNG1YIJby+FKBpN0brodfNGSTWf1j\\/80nC2z9GrRI+xp5FJW3i3Zd\\/ovTIT5ncszQat9Ov2weMnzSP\\/7VuzpTWJXm0XSO0xRheXzSM+LMXSPcMJO2nxxn5eWlqx5SUZks21GUAAB7bSURBVNY5U5VBvPB+NzKuObHS8AqJLjEhAnDx4kUADh06xIoVK7j99ttzfU+XLl2YO3duiQsSQ2hZorxt7D10hAwa3vRnJTdlkNiO\\/8qO06Vo0rzqDVMBKu4IR5MDaFDuyhmWT5V6VPNbxMnTCShK\\/iXAaF4Eh0diObWKGYsOEtplFi1K+uW\\/XqWpULl07vOVAGazmQ4dOjBixAjKli3r1ntiYmKIjY0t4JIVAK9GdGoTzM9rF7C8Xx36lrtBjkjz6UZpR\\/NAkbD\\/L44bqzOo6o2z+YaoBjQIm89PH3xI9RFdqOyTyP7lH7MxpTz965Up4SGiSD7zL8djT3Nk70a+X7KO2HJDmTmyESX5POtqJf+qralTpxIeHp6n9\\/j4+LB8+fICKlEB0vxoOfxBOu15gbcmTOKfO26lRdUy+FgTOHXoT05FDWBUl8gS\\/r1zXwn8uOplJfbYCWyhbYnyLuqyXEde9Rgx8wkM737Bu09+S3yGJyEVG9DnqQcYUrUkdZA4Y2H3Rw8xY5s3kZXq0HzYHJ7rWZ8yN9Snt+RftZXXECnptNAOPPFWKLXnf8mPy99h3bkUbB4BhFaoSYu+ZqzcPA3szbKdDkzUGjOfn8YUdTmuP68KnRg7qxNji7og150HracsY2VRF6NAlfyrtm5GhlJ1uH38TG4fX9QlKVol9NhHCCFEcSFBIoQQQhcJEiGEELpIkAghhNBFgkQIIYQuEiRCCCF0kSARQgihS7ENEqPRSEZGRlEXQxez2YzReO3NgLJtxZtsW8l0M25bcVFsg8Tf35+4uLiiLoYucXFxBAQEXPO8bFvxJttWMt2M21ZcFNsgCQ8P59SpU5w8eRKz2VzUxckTs9nMyZMnOX36tNOfjZBtK55k22Tbipvctq24cPabYlq2x46TwWEyOkwmwMP+r6f9seO\\/DVNTU1\\/PS8FsNhtJSUnExcWRmJiI1WrNy9uLlNFoxN\\/fnzJlyhAQEIDBcHVey7YVT7Jtsm3FTW7blhsfH5+JwC7A\\/P\\/27jy+iTr\\/4\\/hrkjZtIZGrBwlVKHIUEBVxRRB1VwUvBC\\/EAxV2XdR1QVdR2UWFVRFFcQVZWRUF1gsRDxDc9cB1PX4KLoLI0YIKQku7pAI9oHSaZH5\\/QJaQJk3SFDLH5\\/l4zCNp2iTfTyf5vuf7nckEqA+79B287gP8IUsgZNHClqDDvvhAt+fastlsuFwuHA4Hfr8fTTPON+EpioLdbsfhcERc8VKbPkltUpvexKpNL3QbJHDgn5iZaaZT9B4itRmT1GZMZq5ND\\/QbcUIIIQxBgkQIIURSdD21paoqJSUlVFVVGW4HmcvlIj8\\/n4yMjIh\\/I7Xpj9QmtelNPLXpgW6DRFVVioqKcLvdFBQU4HA4Ut2kuKmqSkVFBcXFxRQWFjZou9SmT1Kb1KY3sWrTC91ObZWUlOB2u\\/F4PLr950XjcDjweDy43W5KSkoa\\/F5q0yepTWrTm1i16YVug6SyspKcnJxUNyMp2dnZVFVVNbhdatM3qc2YrFibXug2SAKBAOnp6aluRlKCx62Hk9r0TWozJivWphe6DRIhhBDGIEEihBAiKRIkQgghkiJBIoQQIikSJEIIIZIiQSKEOEr2U7z4RRYXVWOc8+82po6fls\\/j9VVVJqmn6SRIhBBHhVr0CtNm\\/4uteyN9DZIRKdSXrmD+E8\\/zdY21o8TCQeJn5ydTuW7wYH6\\/cIcptii0Xe8yfvCv+NWvDi3njZpDsX4PP0+Qnz3FH\\/Di1PHcdPUwho5dwPZAqtsk4qJ5+XDeO+zq\\/2tuPMUZ8Rv1jMdBl6vGcIHyIXOXbMPKL0XdnmvryNLY8\\/VfmTBzNfXGOmNCo7R9e6m1deXqR+\\/m3HYH3qqKow359hQ3rFnU8cPbk5n4UgU9LxrCyPE34s7tQK6FN4WMJLDtfZasPoZB0wfS2hwpckDmSVw6pIBly5ax\\/qrf0duiPaoly\\/aXLOXRaWvoc+94Mmc\\/wLepblAz0fbWUKPk0PmErnRpmerWNK+6717koQV2bpg1m4s85nrZ+srWsoGenOg+WFfdNtZszqL3CTmYYhuAADu+\\/IKtbftzW6GxP2HekI38gQMpmP8Pvtg0ht49zfXajJf1tud8P7LwsXnUXPonbu7byiRD7AO0qj1Updmp+9lLtWqGybqDtD38e8Eyyu1elv3xaoZechnXj3uMResqTTAlWceGd55kwl2PsrzMB\\/XbWPrQeCb+9X22+FLdtuayn+INW7F17UEXE\\/azNk9PCl1eiop2meD12DQmXK2N8fHTor+wkOE8OaILDqU41Q1qVmqdQquWG3j2t1fzZMBJp9Mv5eaxN9Av1+Dbtb4iVq+rI+fUQVw99EQ8WVWse2Mmz\\/xpKllzpnJxrpE3BzI48bdT+UPFXUy\\/50HWHLuJj3f0Y+L0a83T6QYqKN8ZoE3vXEw0k3yILYf2ObCyfCd+cq3WqQIWG5FoFR\\/x3Os1XHjrZRSYcG23GHgX8xYs4t33FvPStF\\/TdfvrTJq0gB8NvrNd2\\/szP9faKBhwMWee1I3ju53KsNtHcbr\\/Gz76wmv8rcA0N4PG38l59V+wbGUml04Yx4B2JnpranXU1Wk4MjJMNQPwP4qDjEyo278\\/1S1JGRO9WmPRqFzxMV9XbmPRHZcwePBgBl84lgXbVTY+P4phU7+gPtVNbC52Jx36DOMPY84m44fP+LLE2MeTKGnppCkaNdU1h0IjM4e8VlC5p8r4R8v4\\/8snTz3FR\\/bTuaBvLe88\\/jdW7DZ8PB6iOMjIUFDr6owf+pFoKnV1kJGp328wPNJMuF0ejcIxvxzPC733H3oxB7bwxsRHKD5rCvdd2ct0\\/4xAwCRv26zjKGivsXTdRvZemoMT0Cq3smVXGp4OuQbfGqrjuzkTmLa2K3dMn8jg7BK6Tx7PQ\\/e1ZcaM6zjeDC9KWzbtc23s3ulFxYSdTsBLuRdy2uea5OCIxJlunTbG1jKXY0OPZvLX0ipdwdHGw7Htsow97A7s4NPXPqHmuG54jlHYu\\/0blrz0CWrX0ZyRb+yuFns3zh\\/Sg7eff56nFjsZ0cPHN\\/Nf4ts25\\/LQAJex1xsZFF48jilDTqCPJw3oxLBJ08kvzqKTad6dWXQr7ERgaRE\\/+s7hBNPUdUCgvIjiqmxO7N7O4K\\/FpjPZKrWwQC27t67grTdfZkeVD0crD937\\/ZapN11BJ8NvJtk47opJPLj\\/aZ57+X5uq1TI7nEud065lX5O47910\\/P70Cf0hoyO9D0xVa05Emx06D+AjvM\\/4ItNYzjBVIfIBtjx+edsadefW7uZqa7EWLdyAHt3bpr3z1S3onmkHc+wiTMYlup2HCm2dpx6\\/WROvT7VDRFNYet0PkNPep0X3\\/qCa3qczTHGz\\/8D6r7jnaU\\/0OniuznBbB+RSYDB5zyEEIag5DJo9DBaf\\/4C89fsM8lO93p+XPQs7\\/nOZfTQjpbuTK09IhFCHDUZPUZy9xiNjQ6DH4\\/+P35sOacw8q7hnOYyyxCraSRIhBBHSRY9Lh9Dj1Q3o9lk0mnwTXRKdTN0wMqjMSGEEM1AgkQIIURSJEiEEEIkRYJECCFEUnQbJHa7nfp6Y5\\/9SlVV7PaGnwaU2vRNajMmK9amF7oNEqfTidfrTXUzkuL1enG5XA1ul9r0TWozJivWphe6DZK8vDzKysooLS1FVdVUNychqqpSWlpKeXk5eXl5DX4vtemT1Ca16U2s2vQi0qdolLDroYstZLGHLGlA+sFLx8HroZd9amtrZyTSsEAgQE1NDV6vl+rqavx+43yIyW6343Q6ycnJweVyYbMdntdSmz5JbVKb3sSqLZasrKzbgdWACtSHXfoOXvcB\\/pAlELJoYUvQYScn0O0HEm02Gy6XC4fDgd\\/vR9OMc1IFRVGw2+04HI6IK15q0yepTWrTm1i16YVugwQO\\/BMzMzNT3YwjQmozJqnNmMxcmx7oN+KEEEIYggSJEEKIpOh6aktVVUpKSqiqqjLcDjKXy0V+fj4ZGZG\\/x1lq0x+pTWrTm3hq0wPdBomqqhQVFeF2uykoKMDhcKS6SXFTVZWKigqKi4spLCxs0HapTZ+kNqlNb2LVphe6ndoqKSnB7Xbj8Xh0+8+LxuFw4PF4cLvdlJSUNPi91KZPUpvUpjexatML3QZJZWUlOTk5qW5GUrKzs6mqqmpwu9Smb1KbMVmxNr3QbZAEAgHS0439JcjB49bDSW36JrUZkxVr0wvdBokQQghjkCARQgiRFAkSIYQQSZEgEUIIkRQJEiGEEEmRIBFCHFWBXWtZ9PgdXD\\/0As4fej1\\/fHkt1cY5IW\\/jtErWvbeAf\\/1Yl+qWHFUSJEKIo6q+dCNl+cN54PlXmXdfP\\/778nP8o8wcSaJVr+C12cvZjrEPN06Ubk+RcqTV\\/riYR\\/44m9qRr\\/L4JW0jfsOXsdRT9tVC5r7yHis2e6nLyqNwwJXccutQCp0Gr07bzdq35vLKe1+ybnslmqsDvX55DbeNGUwn\\/Z5+SESR0XsEY3sf\\/MHZHY99HfX1GpG\\/Z89Yar9dyYa2v+D6jtbaRrdckASqf+TTRfOYu+j\\/KNlvo0+qG9Rc9n3Lgr99QE3\\/q\\/jDdXnw03LmzZ3JJHsH5t95Ksb+JoZ06uvS6HnZOIZ3yKS6+H3mz3uCh5ydeW50F+ypbp5oolqKFr7Fd8edyW\\/yzdDxqmxY+S2ZfSfSxWIvSosFSYCyf85i9socLn\\/gDr5\\/5Gl2p7pJzaXFqYyd8wJpaQdX6eknY9\\/8FQ9uWM+OwKl0NvL7VHHS99px9A3+fHJXald\\/yowftlJHF1qksm2iaQI\\/858XH+TRj9tzy7QRFJih4\\/VtYuVqjVPG9rBax2q1em10uHI6C4YrKL4VTEt1c5rZ\\/0IEQKti1656Mj35ZBt\\/xuCQwD52rHqbD4qdnHpLb7JS3R6RMG3vJt6aOpnX9w3iT7Nu5JS2Rt7KOcS\\/5WtW7T2ZG3tbb77VHGswEYpigpnYWHyULJvBS5u7M3LU2RxjkoKrP7yfiwYN4bp7X2Pnab9n3KA8C6xL49H2fsm04YO54W\\/rUQG0PXz2yFVcdOtLfF9VzGsTJ\\/Jem5uZOW20QUPER+WWFSyd9wQPzPo3uzWAAGWr\\/oO3Vz9OtuDWjcVGJFZQx09Lp3Dv7B2cMfEJrupsnlXsHDCWWc8Mp3zz5yya9xi3T0vnmQln0tbAaaLtWsafRs1iTX34bxRanvMAr919uuGO\\/1Fa9mPEFV34+NXX+fTqSZy06ilmfuVh1Mwr8S28jTcyRjLztv60Daio9TbS0tKwGWod1lP8wZus9PrY\\/NkrvHvRQG4o2MWqldvofs4puAxVS\\/MwTy8jODASeYjxs8sYeN8TjO3fzlRb7ErLXDp3z6Vz9970zirn6sfe5JPfDOTyXONWqRxzBrdMK2BvoMFvsLfON+gb1MZxF1\\/H2Yse5LVZf+HdrzfQa9wsrswv4ukPfmKP9yluuPApAJSsM5m48EHOdaa4yQnJ4rSbp3GaVs7bd\\/2aBe+sZvivd7Hy+870u9sMR4AmzpivUxHRvrVzuP+ZbfSb+BfGmSxEIvPh96W6DUlKa03HwtapbkWzU1ynM2JoR26e9yHHXvkYU87NxabkcvvC5dye6sY1FyWP8y4bwN8ff5fl3exs8JzGmDzzv+sikSAxC20nH85fzM+9R3N+7m5++P7g8WiKgzb5x9HOyPv\\/1I0sfWU9mYWdyWkRoGr7Kpb8\\/UvoeQv921vzjat7tZv4bEUpfjTSXa3IMuVqUnD1u4RznPcy5wUHbYdcgymOYm4CCRKz8P3Ixs11VFfPZtyKkNvtHbnumRe4qZtxj6\\/U9tXg3fwRH76zlZ17A2S2PZZeA37P46OHWvaNq2v+cj58bDIL\\/cO469rVPL1kEf+54m76mfE4bccJXDioA4tfrmXQaQWW\\/UyTdYMkrR\\/3LH4\\/1a1oPumnM2HJx0xIdTuOAKX1Lxj9yC8YneqGiNi0Gr6d8wBPbejBHTNv4rzMj\\/hq8Qze+ng0pw3JNuF0q53jRzzM7P4+crtZtzuV7TkhRDPxsX3pFB5cYuOKSfdwXnsbSuuBXHhGBmv++TE7GhxQYA5KCzddC4+llYV7U+tGqBCimaVx7CVTefOS0NtaMGDCW5ho7C8isHCGCiGEaA4SJEIIIZIiQSKEECIpEiRCCCGSIkEihBAiKboNErvdTn19gzPZGYqqqtjtDT+iJLXpm9RmTFasTS90GyROpxOv15vqZiTF6\\/Xicrka3C616ZvUZkxWrE0vdBskeXl5lJWVUVpaiqqqqW5OQlRVpbS0lPLycvLy8hr8XmrTJ6lNatObWLXpRaQzFihh10MXW8hiD1nSgPSDl46D10Mv+9TW1s5IpGGBQICamhq8Xi\\/V1dX4\\/f5E7p5Sdrsdp9NJTk4OLpcLm+3wvJba9Elqk9r0JlZtsWRlZd0OrAZUoD7s0nfwug\\/whyyBkEULW4JCr+v3k+02mw2Xy4XD4cDv96NpWuw76YSiKNjtdhwOR8QVL7Xpk9QmtelNrNr0QrdBAgf+iZmZmaluxhEhtRmT1GZMZq5ND\\/QbcUIIIQxBgkQIIURSdD21paoqJSUlVFVVGW4HmcvlIj8\\/n4yMyF9NKLXpj9VrK91Txn3vPswnmz6jpm7vUW6hiMSZ0ZJfdh3I\\/RfdQ+fsTqluTlS6PWpLVVWKiopwu91kZ2fjcDgSuXtKqapKRUUFZWVlFBYWNmi71KZPVq5tR2U5fR4\\/C6V9Okq7dBSH+b6Cyog0VUOrUNH+62P13Z\\/iadU+ofsfraO2dDu1VVJSgtvtxuPxGOoNC+BwOPB4PLjdbkpKShr8XmrTJyvXdt+Sh1Hy0rC5HRIiOqI4FGyeDJS8NO5\\/d0qqmxOVboOksrKSnJycVDcjKdnZ2VRVVTW4XWrTNyvW9vGmf2PLMVY4WomS7eBfmz5NdTOi0m2QBAIB0tPTU92MpASPWw8ntembFWvbW7cP0mUkoleKQ6F6f02qmxGVboNECCGEMUiQCCGESIoEiRBCiKRIkAghhEiKBIkQQoikSJAIIYRIigSJEEKIpFgvSAIVrJx7H7+54kLOv2g4Yx5cwNo9xvl+AmtR2fqPx7h1xBAuvmw0E1\\/+lqrgqvJvY+HYIYx6dj11KW2jEMJiQeJjy+uTmbxwB91G3sfDE67AU\\/wi901ZSplkie5oO\\/\\/JrL8W0\\/PO55k39Xz2L5zOa0U+QOPnj+fw2s6BjLm2J5FPQWg0Gvu2\\/B\\/vf11CfaqbIkSCrBUk9d+x+J1NtBt6F3dedga\\/OOtq7hl7Ho5vF7G02DhncrUKf+kWtrv6cFZfNzndz+b0jhVs2boXbe8q5s9dQ7frR9PfZZ5PY+\\/5+lVmvPkd+2SjRhiMpYIksGMDG3e3oPcp3Qie6KLFiX3paStjw8afkfevvthz3eRWFbNuWx3+XetZt8OFu30637\\/xHMuPGc7NF+RFPH21EOLo0vX3kTS3wJ5d7KE1bduE5KejHdmtYNvPewiQiz11zRNhFM9FjBnxFX\\/+3VD+rjnIHzyeW3I+ZPpb+xg84STWPXkHD63dg6vXJdw69nJ6OCVWrCw9516+GjSKggYvAz\\/r1l7BOd8V40tFwyzAUkGCjDmMRXHS+4YneeOafewLZNLSUcWnU25iS9+buapoBg+XDGTSn\\/tQ9MxkHnmpkLm39jLcC9q3\\/hluHPcGOwLBW9Zz6TnTADvHj3qOZ2\\/sLBs3carfPZdr\\/rE44j6z2v1bJUSOIKO975Jia92O1uxh1+4ABN+e6i4qqqBNu9bWmuczECW9BS2B\\/Wtf5YUV+Vz71xMomV5Ozwsv55TjW9Hjot68+sYaSgO96GiwlZjWZQSPPDeYek3D+8Fj\\/LnoTB4dewZORSGjbb6ESCJ8O9m0e2eqW2FJ1goST096tNnHN2s2U9+vJ+lA7Xer2OB3c36PdjLfrme+rbz97HukDXuCS\\/JhiQaK7UBq2Gw2CASMOd7MaEfH49sBGi2+ycTWIpeCLl1oJS\\/GhMnUVupYKkhI782wS7vywUt\\/YWaHmzinbQnL\\/rYc9aTfMaS7Sbb9\\/JuY85vbWNZrCm\\/cfZpJVrCG96PnWVhxFveO6I7D5qdnr3a8vPx9fujbl43L13FMz0vxGGw0IpqXTG2ljjn6mbilUTBiMpP2P8WzL0zi\\/f1OOp1+Iw\\/dfglus2wBavWoqkKrNq1NM8LSalYyf\\/56Ckc9Rz+XAqTR49rxXPnIdMbf+BKunkO5a9TJGPv7\\/RQ8V83ivatS3Q4Dk6mtlLFYkAC2HPqNnkK\\/0aluyJGh1e5gxx4nPXt3NM38uuLsx\\/jX3jn8NteJjJw6n5EpapMQ4hCZDDAZ9fsituacwwUnm+Pz3kII\\/bPeiMTkMvqMZf4LfuyyZoUQR4mMSEzInmaWSS0hhBFIkAghhEiKBIkQQoikSJAIIYRIypEIEi3sUgghROodsb5ZtyMSu91Ofb2xv+JHVVXs9oY7vqU2fbNibc6MllAv2356pakarkxnqpsRVXMGSWOvwoRfoU6nE6\\/Xm0RzUs\\/r9eJyuRrcLrXpmxVrO7vLGQS8agpaJOKhVaic3eWMJt21ib9LSDJBEm8Dm9TYvLw8ysrKKC0tRVWN9QJXVZXS0lLKy8vJy8tr8HupTZ+sXNuEQX9AK\\/cR2FGHpsrIRC80VTuwTsp9\\/HHQnU1+mCjXG\\/u7hEQ6HZMSdj10sYUtdg58qDG4pIcsjpDLPrW1tTMTaVggEKCmpgav10t1dTV+v3G+Ctdut+N0OsnJycHlch04O20IqU2frF7b1p3bePjDx\\/lk8+dU769JUUtFqGMyXZzZZQD3nns73d1dG6y3WLKyssYBqwEVqA+5DC6+kMUPBMIWLWwJOix0mhIkCgcCJFaQBEPEAZxcW1v7dEL\\/AUDTNOrq6vD7\\/WiacbaSFEXBbrfjcDiirnipTX+kNmPWZmbxrLfGZGVljQXWcCBAwkMkWpD4ORAUcQdJoifS0GgYPqFPEP6EkRoQN0VRyMzMbMpddU9qMyapTRhMrD45Wv+cUJ\\/d1H0k8TyxHAYshBCpF60vTjpAgpr78N\\/wYVCTRyNCCCGaxRHvl5M9aivS8ChSgwNJPI8QQoimibSfo7F+u0niCZJYTxBpB0xogMioRAghUiNaX5zIIcEx++9ERiTxPFm00YgEiRBCHH3Rjr6KZ4or7n67KVNbsaaxZD+JEELoQ6J9dJP660hBEu+DhA+Rwkcg4R9sEUIIcXRF+oBhtGmuRPv+\\/0l0RNLYIb6RprMkSIQQInUaC5Fo+0wi\\/dyoWEES7TjjeJZg4\\/1RHkcIIcSRpXH4qU+auiui0T68OT5HEik8whfjnJRICCHMI9L5syKFSlISPUVKULyjkWCIBLKyskZx4NxcoUv4SSCDwRY8p1fwdCzhl0IIYXaN7YeG6BvtoUuAhmHS7AdGReuYw0\\/cGLwMPwtw+AkcQ5e0GJfhgWIPeUxb2PNFa5MQQphNpM94RNsHHRoWoYsvxmWksAkdBDS2D6VB2CQ7IlHCigvt\\/P0hl3B45x\\/+T7Ed\\/LvQgJIgEUJYUawgibYbITwgYo1MIh291aQRSVODJPRJIxUYGibR7hMsJHxqKzxEJEiEEFYST5BECpNoo5PQMIk1vdUk8QRJcOQRWhQcPhoJD5HQMIn0eBoHQiN4GW1KK\\/wxJECEEFYRHiixPmYRPvJoLEQaOww4PFRiBky0IAkNj2i3NTbkIsL9g39r51CAhI5IYu0bkRARQlhNtB3ukYIk2ugkkR3ukZ471m1NmtqKNipp7EOHwb8JDZFI01nxHK0lgSKEMLto01vBy\\/BRRWNhEu3naPtIEp7iijdIQnesRxqVBEcWkQIlPPHCAyTadFa0kYgEiRDC7KKNDhrbNx0tUBr7DEl4mER6vpiS3dkeFAyZYKDECpPg30ULEiJcEuVnIYQwm1gde2NBEh4o0X5OeiQSlMzUVugO+GAwwOFhEr5jPXSHfCIjEQkPIYRVRZvmamxkEilUGvsbwh43IY0FSaRprEjTWpGO6AoNi2BDQ6fGwo\\/sktGIEEIcLtFRSWOhEunnWAESz853IPERSXggRNurHxoioSGhEd8oREYjQghxSDw73+NZok1pRXrMuCW7jyRamED0EUekU64Q4TL8uhBCWFm8YRL+c6Ql2n2aJJ6OOtLfROrsI4VE6PVkA0RCRQhhNdFmfcKvxxMoxLge73M20NQgCb89Wig0Fi6RLuN9PiGEsIJoHXisMAleNhYa8YZIY7cD8XfOiYRJ6PVEg0NCRAghDpdImIReTzQ4mhQikFgHHW8nH29YxHtEloSIEMLq4u3k4w2LeI\\/Iimu\\/SaKddGN\\/31gwNDbqSOQxhRDCqhrr1BsLhsZGHYk8ZlRN6agT7fhl5CGEEEdGoiOVeO4b63cNNLXzbq6d9Mk8vhBCWFE8nXwyU1UJHwacTIfdHPtXknlMIYSwsng7\\/ESCoUmfJWmujvtoBZIQQoiGmvxhwiTvCxyZTlyCQQgh9C3p8Ah1NDp9CRYhhEitZg2OcLbYfyKEEEIIIYQQQgghhBBCCCGEEEKIUP8Pw1zGDz1zyKQAAAAASUVORK5CYII=\\\" \\/>Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor<\\/p><p style=\\\"text-align: left;\\\">&nbsp;<\\/p><p style=\\\"text-align: left;\\\">Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor<\\/p><p style=\\\"text-align: left;\\\">&nbsp;<\\/p><p style=\\\"text-align: left;\\\">Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor<\\/p>\",\"hr\":\"<p>Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor orem ipsum dolor<\\/p><p>&nbsp;<\\/p><p>Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor<\\/p>\",\"pt-br\":\"<p>Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem<\\/p><p>&nbsp;<\\/p><p>&nbsp;<\\/p><p>asdfasdfasdfasdfas<\\/p>\"}',NULL,'en','2021-03-11 20:48:59','2021-07-09 09:22:31','1'),(14,79,'post','teste tinymce','teste-tinymce','{\"en\":\"\",\"hr\":\"\",\"pt-br\":\"\"}','{\"en\":\"\",\"hr\":\"\",\"pt-br\":\"\"}','{\"en\":\"\",\"hr\":\"\",\"pt-br\":\"\"}',NULL,'en','2021-07-06 18:37:11','2021-07-07 05:18:32','1'),(15,78,'post','teste tinymce2','teste-tinymce2','{\"en\":\"afafaf\",\"hr\":\"\",\"pt-br\":\"\"}','{\"en\":\"affaf\",\"hr\":\"\",\"pt-br\":\"\"}','{\"en\":\"<table style=\\\"border-collapse: collapse; width: 29.0947%; height: 257px; float: left;\\\"><tbody><tr style=\\\"height: 239px;\\\"><td style=\\\"width: 7.10031%; height: 239px;\\\">&nbsp;<\\/td><td style=\\\"width: 11.0097%; height: 239px;\\\">&nbsp;<\\/td><\\/tr><tr style=\\\"height: 18px;\\\"><td style=\\\"width: 7.10031%; height: 18px;\\\">&nbsp;<\\/td><td style=\\\"width: 11.0097%; height: 18px;\\\">&nbsp;<\\/td><\\/tr><\\/tbody><\\/table><div id=\\\"lipsum\\\" style=\\\"text-align: left;\\\"><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer euismod tempor magna pharetra tincidunt. In bibendum dui sed sagittis sodales. Aliquam ac mi nec nisi blandit sodales. Fusce faucibus a ipsum sit amet consectetur. Nulla facilisi. Donec varius porttitor purus vel euismod. Maecenas id venenatis dolor. Duis urna nunc, blandit sit amet eros nec, aliquam tincidunt tortor. Phasellus sagittis neque et risus viverra aliquet. Quisque quis tincidunt sem, id vehicula neque. Pellentesque id cursus nisl. Suspendisse eu euismod dui. Quisque cursus lorem quis quam vulputate congue. Suspendisse tempus laoreet urna, eu consequat ex ornare eget. Nullam sit amet lacus sagittis, varius dui ac, rutrum ex.<\\/p><p>&nbsp;<\\/p><p>&nbsp;<\\/p><p>&nbsp;<\\/p><p>Vivamus volutpat pharetra aliquam. Nunc porttitor fermentum tortor at efficitur. Quisque in hendrerit neque. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Suspendisse dignissim sit amet eros sed facilisis. Pellentesque feugiat neque consequat elit congue, non accumsan magna pharetra. Duis et nisl nisl. Aliquam aliquam nunc sem, eget ornare turpis faucibus ac. Mauris varius eros ante, faucibus ullamcorper dui fringilla et.<\\/p><p>Aenean facilisis feugiat velit, eu placerat mauris facilisis ut. Cras auctor eget augue quis posuere. Integer feugiat nisi eros, placerat sagittis dolor lobortis in. Praesent tristique lacus id egestas fermentum. Etiam eget ex vulputate, faucibus massa sit amet, feugiat nibh. Aenean non mattis lectus. Suspendisse dapibus sodales lorem, at faucibus tortor venenatis et. Donec vel magna ligula. Vestibulum commodo, sem quis dignissim mollis, nisi nunc consectetur ligula, vitae condimentum mi purus sed orci. Nullam malesuada semper urna a commodo. Quisque ullamcorper id dui sed molestie.<\\/p><p>Duis ut cursus nunc, vitae iaculis lacus. Etiam pulvinar metus purus, quis tincidunt risus mattis non. Aenean suscipit sem quis lacus vulputate, nec scelerisque turpis mollis. Donec luctus vel nibh nec tempus. Cras facilisis egestas sem, ac aliquet ipsum ullamcorper quis. Fusce quis elit aliquam, cursus neque eget, ullamcorper metus. Etiam erat nisi, sodales id dolor sed, laoreet porttitor libero. Aliquam et nisi vitae nisi porta tincidunt. Praesent cursus dignissim eros, ut molestie nisi semper vel. Nam venenatis tortor sit amet nisi volutpat mattis. Interdum et malesuada fames ac ante ipsum primis in faucibus. Phasellus aliquet nec quam lobortis aliquam. Donec interdum est eros, nec accumsan nisi placerat sed. Curabitur hendrerit, nulla a facilisis finibus, urna arcu sollicitudin magna, in porta magna ante mattis mi.<\\/p><p>Proin sit amet odio magna. Praesent vitae lacus nec turpis facilisis varius. Mauris a finibus urna. Vestibulum feugiat ornare sollicitudin. Aliquam ultricies vestibulum eros non eleifend. Etiam purus lorem, pretium eu commodo sed, sagittis vitae purus. Maecenas venenatis a turpis in mollis. Aenean pulvinar nisi vel ornare posuere. Integer sodales ligula quis nulla vehicula ornare. Cras metus augue, congue quis purus quis, iaculis malesuada ante. Praesent eget augue in dui euismod condimentum eget at enim.<\\/p><\\/div><div id=\\\"generated\\\" style=\\\"text-align: left;\\\">Foram gerados 5 par&aacute;grafos, 456 palavras e 3104 bytes de&nbsp;<a title=\\\"Lorem Ipsum\\\" href=\\\"https:\\/\\/br.lipsum.com\\/\\\">Lorem Ipsum<\\/a><\\/div>\",\"hr\":\"\",\"pt-br\":\"\"}',NULL,'en','2021-07-06 18:38:09','2021-07-09 09:38:24','1'),(16,78,'post','Embaixada 2','embaixada-2','{\"en\":\"\",\"hr\":\"\",\"pt-br\":\"\"}','{\"en\":\"\",\"hr\":\"\",\"pt-br\":\"\"}','{\"en\":\"<p><img src=\\\"data:image\\/png;base64,iVBORw0KGgoAAAANSUhEUgAAAZIAAAG+CAYAAAC57IK3AAAABHNCSVQICAgIfAhkiAAAABl0RVh0U29mdHdhcmUAZ25vbWUtc2NyZWVuc2hvdO8Dvz4AAAAmdEVYdENyZWF0aW9uIFRpbWUAcXVpIDAxIGp1bCAyMDIxIDE2OjQ5OjQzvirHhgAAIABJREFUeJzs3Xd8E\\/Ufx\\/HXJemelNJFGWXvvfdGQBGQoQIqslGGuAEVRQQVRXGvnwtRRERQBGQJMhUERBQQZAhllFG6myb5\\/v5oCqEkbdqjCz7Px+MehORy973vJd\\/33fd7l4IQQgghhBBCCCGEEEIIIcTNR7tJ1y2EEDciVRQrLYrGXAJECCEKVqEGSmE06hIcQghRtAo0WAqikde7TAkeIYTImd5guK7Bcr0a7bwsp6DmFUKIG1leGv+Cmtep69FQu7MMV\\/Poea8QQtws3GnsXc2j571u0dNI5\\/ZeZ69nf05PwAghxM3I3cBwNl9ugZGvQMlvg53T+3ILC83N1\\/KyTiGEuBHl1LDnFBy5hUpelpur\\/DTO7p5FOAsMVyEiZypCCHG1\\/Jx5OHucl4DJ7Xmn8towu9PA5xQgOQVKTsGS2\\/NCCHGjcaeRzyksXP2b02N31n+N63EFlbvB4c5rrpbnTjmEEOJGkdv4RvbHOYVHXoMlt3Jcw91GOa8h4u7j3M5Y5MxECHGzya1Rzy00XIVITuHiznpdMuU2Qw6yh0hugeEsPNwNlOyPhRDiZuBul5WrEHF8Lrd1aG7M61R+gySnrig9E04eO1uPEELcDFwFiavAcGfKvjzNxWO3uRMk7l6NldNkcPHYnVBxVgZXzwkhREmW09hIXsLDlu1xbuvMKUxyDZfr0bWVl\\/Bw9a87Zycg4SGEuHnkNKCeU3jYyGwrbU7e4ypUsodJnuQWJK7ORtwNEYOTx85ecxUqztbpqmxCCFHSubrPw1WIZD\\/zsJHZljqGiebkNVfr1nAeKjmGjN4zElch4iw8nE3OAiW3bi5c\\/F8IIUq6nIIkpzMRx5DICo+syeZkeTmFSZ7lJUhyG69w1p1lAIxcHR5GwBcIA4IAb4d5yLaMnNYtQSKEuNHkdJVW1mPHLiobYAXSgEvAWSDF\\/lz2g\\/Gs+bPa56xlZA8PV2clLuUUJDk11LkNrGcPkax\\/TUD5qKiozhXLl5\\/s4+3tbzQa0TTJBCGEyA+lFFarldS0tKSjR4++Gnv69FrgOGDBdTtuw\\/XJgavwcBksuYVF9v9nHxvJPmjuePbhGCJZU\\/WG9eu\\/VjokpEZaejpmsxmr1YpS+TqbEkKIm56maRiNRjw9PfH28uL8xYt\\/79q9+yHgAJlnJlmTzeHfrMfZB+ld3biIw3PXMOZUPiePczsDcQyR7FPFhvXrvxkUGFjjUkICGRkZ2Gy5XZUmhBAiNzabjYyMDNLS0wkMCChTqlSpRqfPnNkCJDiZPadLjLNzq7vIkPssOXI3WPwiIyO7BgYE1EhITJQzECGEKABKKRISEwkMDKwVGR7eGfDD9YVOzi5qype8BEn2MxR3QiTrbCS8fHT0g0nJyXrKKoQQwg1JSUmUL19+ApkXNWW1w+6ESb4uaHIVJK4W5ur+Dmf3jjiGSRAQIGciQghR8OxtbQAQjOsQyX6FbPY2nWzPZ398md7f2nI3TLxtNptcmiVuOEopLFZrkY33GQwGTHLlo3DC3uZ6c3VbnDWonvXYsQ3P993t+QmSnAbes98\\/kjV5yMC6uNEopbDabAQFBuLv54fRmNO1K9ef1WolKTmZhMREjAaDhIm4ir3N9SCzDXa8gdHxzvfsU77CxN0xEmdnIFn\\/Zg8Rp+Ml0q0lbjQWq5XAgACCAgMLPUQAjEYjQYGBBAYEYLFaC339onizt7muxkXc\\/Umq637VlrP7SrL+dXZGkvXY6G5hhChJbDYb\\/n5+RV0M\\/P385FJ64Yrj\\/X3Z22dXIYKL\\/7uUn8t\\/83v1lhA3nKI4EymOZRDFVoFerZUlv\\/eROFtxTmEiZyRCCFH4nLXFOQVIvtrq3IIkt1Od7KdFrvre9N74KIQQIu9ctcfO2m5Heermut5\\/s13OSIQQwgWTBq38Mmjln0FlTwuhpsyLkM5ZNA6lm9ia7MGWZA8s1+\\/apLyekeRLfi\\/\\/dZVkOV0aLIQQN602\\/hncXzqVSI9rL4yI9lREe5rpEGAmNsPAx+d92JTkcT1W66otdtWl5XgZsNucdTm5avRzCgNXgzeOp1FCCHHTMQAjQlOZGpHsNESyi\\/KwMTUimRGhqddjTMDVcIM7B\\/luZ4E75cxtYc6SLnvqSZDoZAiKoUnHW+l\\/a0NC8n2JhD\\/lGrWjxx19aBruxkJ8ajBg0r00DJbdJ0R+3R+ayh3B6Xl+3x3B6Qwrnap39c7a4pza7pyW4VJeb0jM7fm8Jp5wk2fTkbz8wlTGD2xIqfwuxNSA+16czbTJQ2gRlsuuN0bQbcpsxg+8n8l31cbLneX7NmT0hyv46bu59K+kZ\\/hNiBtDG\\/+MfIVIlv6l0mnpl6G3GO60y\\/kOEdA32J6bnK4IuGEE9JjDsqda45Gxj3fvHc38ow53GHvWZuwn7zI4RuO\\/z0Yy5J2\\/KRn3H2uU6jyRSZ18+PuLx5jy3p+481UwhNWlWfVg\\/IwNaV7Dj8X\\/XsrfH4C+gX2zZIlb8\\/Xv27eASyIKmkmD4c7OKDQDKBddXE5eGxmaym8p+R6Ad+eMQze9P9ro+DinQfcblIEykWEYNNA8azLwnlZ8N+MXkhSARuku99GnogkNRWhUBB6UlCBRXFzzMpPP+HN0z3HS3HyX7dgy5r7iR6fSh\\/h+fcGHSFBQEJ27dGHlihWkpKRc87qvry+39OjB2jVruHTpUgGXxj0SEAVv89atOb7eumXLQilHK78MIrKPiWgGgp\\/6jPRN35O6buFVL\\/l0GoRXm9uIn3HPVWES6WGjpV8Gv+R\\/8D2nQXZXz+VJXoPE3fGS7PPeoGFipHSZ0vb+QQMhne6m10ebWXjSBqYq9L2rBX4agIZHaBilDHDKBhhCaXjnGEb0bUPNcE9SYv9kw8L3eO+7fSTYW1\\/NvyZ9Jkzgrva1CPNM4MRZAyYyf2ntMjeW45QWQscnv6B7RCQ+6bH8seojXntnNcfSAXxoMnoOk3pUJiLED5M5nuN717HgjXdZ+W8qYCS89XAmjbqVxjGlMKXFc\\/boWt547HU2J9eh7wNDucU3FvXret7YawEtkJq9RzJiYAfqlwtGS45l36IXePR\\/e0jPb\\/ntbrnlFiZMmkS37t15+KGHSHb4ezd+fn68MncudevWxcNkYuHChTksSdxoXIVFbiFzPTntklI20jYtI3D0C2DyIPWn+QB4dxpIwOiZJH403enZio4gye0AP6c23e1jwYK+UfAGDZAsnpQK8UfDxoW489g869H3jjp4AH7NB9K7koHkc+dIVWAIDiFIAzQ\\/Go6fx9wHe9GgrB+2dEVA+ab0efQNXrm3Gh4AhjBueepVJt\\/WgCh\\/K0lJJiKjS129s9xZjiuaD2HlSqOSUzEElafZwGd4+cEm+AKQgdU\\/gjKeaVw8G0eSIYRKLQbw5Ix7qGECLbQHjzx3H+2qBmM5c4SjZ80ElvHEnOzsM+dDrRGv8cbj\\/WkRE4IhLZF0rwj8bYlk6Cm\\/3fLlyzlw4AB169bllblz8bP\\/7pVjiBw4cIDly5e7sTQhrq+q3hanz6et+5qE96YQMHw6Pt2G4N1pIIGjXyDxo+mXgyW7ai6WlQcF2hbr+Rn57I\\/zOk\\/JZwimVLCGhpWDi7+EoQ\\/QrEd\\/2nx2hqABnQlRJ1j05a+0eqA\\/UcHBBBnAEHoL9\\/WtiIc6w5rpo5mx+iKRd7zI+5NbUOOuIbT+5mk2hnSlX8sgDNb\\/+HbyCF79NQG\\/Hi\\/z\\/dNtLoeJISz35fyc5KLcttN8O3EQr\\/6uiOwzm48fbUXULX1o8e4O1iVb2DN3AD1e8ySgVBC+IR15\\/N0JNC3XgPplDPwTXI4oLw2V9jvvP\\/gw352xYjCZwALZW39DaDdG3FUDH3WRza8+wNPfHiHN4IufRyqE9ct\\/+e2SkpKYNGECr82bdzlMnp42jeeef\\/5yiEyaMIGkpFwWVIhkjOTmEWJ0fUCftu5rNDQCRs8EIPG9qdd0dbm7LDfkp83O0wqv153t13PekkMLIDjAACqNhCPL+Wn9nTTr1ZaB4yz4N\\/bG\\/OcSlvzqQ\\/2xoPkEEmACY9Xa1PDUsF3cxvKfz2AB\\/lv1E39MaE4b\\/xrUrmBkc0gVKpg0bOd3sGFXAgqwZFx9muzOcn7e52pExkpGhg2wcHrjRv6e3IpmPhWIiTLC4dK0GDONyf0bE+FjuLLjLL74+ID1yFa2\\/HcXFSo24+GvFtN9\\/TIWzf+a9f9e21gbq9ejlreGLX4T3y47QpoCrCkkW8GjiZ7yX5GQkHBVmCxZuhTgcogkJCS4tSsLiwSEKGSF0k7Lb2DpYfDH318DlURiUjK\\/Lf6BYzZv6t3Wg0qGRLYsXsmJxERSFGgGf\\/z9NDdzXmXOZvJwnfTXaSRb8\\/DIPJFQCptV4dd2HNMGNyU84y++ffVZpj+\\/gD0pDitL2807Y8cya\\/5G\\/k0LoW6PkTz34RsMq+mkM8pgyPyAKRvX9Ppex5H4rDA5cOAAUHxDRNxcLlhdt8uOYyIJ700hYPRMfLoNcTn\\/eUvxPha\\/nkFSvLe0QPgR4K+BSic11Ybl4FKW7ErL\\/FuWp1exeGM8Ki0t86onzY8APw3roT\\/Zb1YYglvQq0M4Jjwo170b9U0aKvkgfx+zYv33IP9aFIbAVtzevazT8QJ3lpMrzZ9afXpSywS2hAP8HQsh0WXxM4D1wI98+s1KVv\\/0K8fSHFp9UyCl1EGWv\\/UE9\\/a7n4\\/2WdB8qtC2RblrPkzWo4c4YlEYgltxW5eyeALggb+\\/N7brUX4HCQkJTBw\\/nlfnzGHi+PESIgVo89atOU4i08E054eB2cdEso+ZOPNPeoHcqXHd2uyCKN1NEyiatx++pswgSTMrsJ1h1fyvaK5qEr\\/6G\\/akg9LSSFeAwRc\\/Xw3b8Z\\/4fOkg6g8oT5dnv6HVo2Y8\\/H3xII0Di75gcxLYklfw2Y\\/9md27LO2mfMkPYy6Q7hWCB1y+fNh2NvfluC54JH1e\\/pZOKoDQIG8MJLPniy\\/ZkWbDeOAgF2x1KNP4Qd77qBP\\/JQYQE3Bll5pq3MPbb\\/fD92wscUkeRFQygkrm1MkLKKKuWo3txAoWrB3AjO7hdHrqa1pNiifV4I\\/3nhfp95iO8ruQmJjI4sWL8\\/7GQnQjjJEU1uWzehSHQNuW7EHHAPPVT2oGvFv3vmZMJGvMxKvNbaSuXnDNlVtbkq\\/L725dLsX1XBgUzg2JNyzN189+pVM66WYARdL293hsu8NM1nTSMxSYfPHzM4BKYse88Tx24UFG3N6SamU8SDm5m03fvMs7i\\/7OvPFPXWLrnAd4\\/PRY7u3VnGoRZfC2JHPu+CEO\\/3aIS+DecrKzneHPLbuoUjuGyLAQQknj3KHN\\/Pz1B3y0\\/F8sgGXnu0x9zYvxA9tQrVpjwskgJf4E+w\\/t4kgiGP0TOHE0gToVYqgakUHi6X2s\\/v593lwTj8r+95XUBTbMeoApJ8cw9JYmVAkPxj8tjn8vWvElH+W\\/ARTngLhRFJeg25LswakMw9W\\/r6VsxD9\\/j9NLfFPXLSR1\\/aJrXovNMLDt+gRJgbXJzhbs7FchHX+A0fGvHmZNJjKv2TEBnvbHjv82bNSgwesFswlCFI10s5mK5csXdTEAOHr8OF6enkVdDJFNa\\/8MpkUk5z5jDp495ZfvIPl99+6JwC7ADGRk+9dif2whs7Mja7I5TCrblOWqUU4ZbBdCiAKyOcmDxfFu\\/VKdU4suel2vs5ECJUEihBAF6H\\/nfPjmYt7DZNFFLz4571MAJbr+5CdahRCiANmAj8778FeaiRGhqUTl8jdJYjMMvH\\/Oh+0l4EwkiwSJEEIUgq3JHvyW4kFLvwxa+mVQxctKGVNmqMRZDBxKN7I12YOt1\\/dP7RYKCRIhhCgkFgW\\/JHno+SXfYknGSIQQQugiQSKEEEIXCRIhdLBai\\/5PlRWHMoibmwSJEPlkMBhIStZ3s9n1kJScjMEgX2VRdGSwXYh8MhoMJCQmAuDv54fRmP03YgqW1WolKTmZhMREjBIkoghJkAiRTwaDAWWzcSkhgYvx8UVWBoOmyRmJKFISJELoYDRk\\/vGvojwjkBARRU2CRAidpCEXNzv5BgghhNBFgkQIIYQuEiRCCCF0kSARQgihS6ENtl+4eLGwViWEEKIQFVqQ7P3zz8JalRBCCCAgIKBQ1iNdW0IIIXSRIBFCCKGLBIkQQghdJEiEEELoIkEihBBCFwkSIYQQukiQCCGE0EWCRAghhC4SJEIIIXSRIBFCCKGLBIkQQghdJEiEEELoIkEihBBCFwkSIYQQukiQCCGE0EWCRAghhC4SJEIIIXSRIBFCCKGLBIkQQghdJEiEEELoIkEihBBCFwkSIYQQukiQCCGE0EWCRAghhC4SJEIIIXSRIBFCCKGLBIkQQghdJEiEEELoIkEihBBCFwkSIYQQukiQCCGE0EWCRAghhC4SJEIIIXSRIBFCCKGLBIkQQghdJEiEEELoIkEihBBCFwkSIYQQukiQCCGE0EWCRAghhC4SJEIIIXSRIBFCCKGLBIkQQghdJEiEEELoIkEihBBCFwkSIYQQukiQCCGE0EWCRAghhC4SJEIIIXSRIBFCCKGLBIkQQghdJEiEEELoIkEihBBCFwkSIYQQukiQCCGE0EWCRAghhC4SJEIIIXSRIBFCCKGLBIkQQghdJEiEEELoIkEihBBCFwkSIYQQukiQCCGE0EWCRAghhC4SJEIIIXSRIBFCCKGLBIkQQghdJEiEEELoIkEihBBCFwkSIYQQukiQCCGE0EWCRAghhC4SJEIIIXSRIBFCCKGLBIkQQghdJEiEEELoIkEihBBCFwkSIYQQukiQCCGE0EWCRAghhC4SJEIIIXQxFdaKLBZLYa1KCCFEISq0IDGZCm1VQgghCpF0bQkhhNBFgkQIIYQuEiRCCCF0kSARQgihiwSJEEIIXSRIhBBC6CJBIoQQQhcJEiGEELqUwCCxcvyHN\\/hwWxzWoi6KEEKIkhcklkPvM3b0NJ5+7huOSJIIIUSRK1lBYjvFwqmz2GRpxuNzR1LFCGDlrxdbExIQQEC2KbjWo2zKcL4olXiQle9MYditralTKZLwdi\\/xVx6CKbf3px7fwEfT7qN746pEhZYmLLo6zW8by9zVx0l3srzUf39g5r0dqVMujNDwCtTtOJRnF+8nWeWhfnKTsod5t1UkKCCUfp+d45pFpx5m6XODaV8rmrCwKKq1vIMnvthLopMyWE7\\/wlvje9OsaiShpcOpULcjQ6d\\/w9\\/ZCpzXerhW3vavW\\/Vo+Z3pTUpds7wrUzD1p\\/2Ki4+OuCyV4xs\\/5pmRt9GqVgXCS2fu36Y97ufZr\\/7g0rUfMI6umsPIbvWpGB5CSHg5arbszbhXV3E01fVaLOf\\/4Pu3pjGybwcaVS9PeHg7XnTxZXVnXpWwlwXT7qRdrXKEhUYQ06A7I19exbG0a5eXcng5L43uSeMqkYSWKk1klSb0GvMKq446mfkmVqJ+ACt951u88lMC5Uc8zcjqWUVXpCSloExVuH3yUBr5XZnfENCQisbsS7Fx9udZDB\\/1ChtOGwmr24YOfToSU6UxgZo7pXDn\\/VZOr3iZ6Z+epE6HrtzV2Ye0U3+wftUXPDPwFw5\\/9QtvdC9F1uzWI59xb7cJrEyModvQSdwTHMe2rxfwyv0b2Rn3E4vHVMcj\\/9WWKf0gHw8bwNMbzmPD69rXrcdZMLwH4344T1iTW7mrmyf\\/rFnG2+N68cfFlXz3YC087bOqcyuZ1G0wn52KoO3A0QyIMXJyyzd8+epwft5xjrXfjaGaKe\\/14Jz7+9ftejRE0u7+hzGcs2VbVwZHVn3A4r0a0dFluOajI65iO7mQiYMmsibJITHMsezftIj9m1ew\\/uhyVjzRCB8A0vnr3bu49fF1xNmy5o\\/nxJ\\/r+XzfRlZufJEfvx5NDU+HFahL7PzgYcZNX8TfibYrBz7GQC7E28BxD7k5r0rYwrO33cGrvyddnif18Ba+mrGdDTvmsfKLe6hkb1pSd8+l723T2RJ\\/5XOSfuYAG7+YzqaVG3npp28YXU33N\\/OG4Ow7rGV77DgZHCajw2QCPOz\\/etofO\\/7bMDEx8XV9RU1ixZh63LmoHE9vWcfD1bM+RGbWTahF34Wt+PToZ\\/TxyWUp256lx+2v8nfYrTz97hzGtI7EM+e35O\\/9liQSzX4E+GZVp+LC8rG0GryA+N6fcvizvmS2iQn8MLIBgxd5c9eCX3inZ2k0QMV9z+h2Q\\/kqqRcf7p7PwNJupZxz6gJrHu7KnV\\/6M3JoKT58dxNt39zP4ntC7TtbEb98NE3uXgi3vcfPn95JtBHU+Z+Y2HEQn5zvzJu\\/fs09ZQ2AlQOvdKLlc\\/\\/S+a1tLBxSNvO0Vp1j6YiW3LPYxMjv\\/2BOW4881oMr7u5f\\/fWYvudFund7gUPNX2LDt6OpXKIOs4pCKr9O781Df9aiZ6cmVAk1EPf7Qt56\\/2dOZCgMIXfx5d\\/v09MXbCf+R78mk1ibrDAENGDwlPF0D41l+euz+erPZJTmT5fXd7B4WNbnKYGtM3rTb85OkhRoplJU73Q7vTs2o1alctRq0Z6aIfZ96fa8ZnZOb03XV\\/eTgYmojuMY3yuIPR\\/PZeGfSShDKXq+vZ0vB0disMXycb+GTFybAsYouj0xiwfb+HF44QymfrqHZGUgbOgi9r7dDd8i3AO5CQgImAjsAsxARrZ\\/LfbHFsDqMNkcJpVtynLV+WbJ+aqkbOS7lecx1h1P7yqOx4oWLl1MRAsOpVRuh5DpO3ll4uv84dGeF5d8wpgqeTyayMv7Tf4EXFW7GoHlognWIMnkUFDzb6xadx4tehz3dS19OcW1Mrcw6o4YFs1bz\\/KNyQzs6395e08dPIZf1cpXn0GlHuNgXDjVyntnK4iV\\/758kDGfpND7w+95yvgkH72bvbAJrFv4I2cNVXjoof5E24unle7C5FFN+GLKBhYuj2XIqGgMWDl66ChWY3maNIq40jeqhdC0RXVMi37l1BkzZJ1DuVsPLrm5f\\/Ncj9mr6R8+eGwuu7QWzHxluISIW3xoNn01mx2fuqMF1u1NmbYjA1tyHHHJCnwhfsOPbElRgAd1J77HvAdrYQJ61U1jX9uZ\\/JGRzC\\/fLOfUvaMoa1Akrn+GUa\\/+TpLSMJW9hRnz32VckxAnffF5mDf1Fz5dcJAMBYbQfrz86fP0DtawttM40GoGuzLiWfv5d5y4ayzlLX+xc08aCjDVuIdnHulHXRN0aJTE+q+HsTTFRvzRo1y0gW\\/JGiAoECWmCjL+3MzWeI2yLVte3V1li+fcBQtacBD+1uxdFVdLXv8Bn+63UfGeKQyrZCPh7CniEs3XjhVcx\\/enXzrN8X\\/3sf2Ht3hw7NscCOnIE5O6XjkKt8RzMVFhKBVC8FV7w4PqdapjIo1DB49fvkIt7bfn6dOmA\\/1e2EJ81opT9vLOkM607PEIq7J1TFv+\\/R\\/jn1hNqVHvM7dvlPPumoz97NydBP6NaVHbsQU1ULZZc6IN6ezduRczAEaq1KiCh+UA33+zm5SsWdU5fvl5LxafxrRpcu1pQ6714Iq7+zeP9Xg1xYXlL\\/LatnSqjpjB8KqSInmScpJ9O35j2y+r+GrOVD78wwIYCG7Xm46lNUCReDEBqwIwEBp+pdvQVLU5TUIMgCJj\\/172WwDbf3z16gKOWRWYKjF83hz6lLnEybPJXPNXjfIwr+WfbfwaZwM0vJp1oV1w5uGGsUon2lcwAgrzH9vZlQYYQgkvk\\/lBsh5eyaLf4lEoEn7dwt50BZgo36ghYSWmBS1YJeQbo0g8eIBYq4l2NatcXWjbGWLP2rDsn0OH8Ln4lq5I7RZdGThmIve3j3bodsrg9zUbuKA0PNZMpu5H+zidYgPNm4gmdzB59guMbhaSQ399ft5vZsszbenz0WlsgBbQiAnzP2RcPYeG1rMCMWWNWI7sYk+8ooZD14tnUCCeKFKTUy+HlXej0TwzeAXDXhpIP+tCvpnsz4Kh\\/Zi20Yc+b0ymY5BDCaxH+HjSs2yKGM0PT7clSMP5ALf1FCfO2DCWjSAs2yfCGBFFhFFxMjaWiwoiNSOV7pvOmK8HMO+VvtwS+zCT72mC+dspTF7hSdeX5nJ\\/xezfLjfqwRV3928e6\\/Hq7f+HT1\\/9jjj\\/zjzzQBPcKFXxYDvGshdeY22cq4DV8Gs2iucG1yrQL7rl8CcM7zqbfZdbbg3vmiP5+P37KG8AMFCmSiUCDVs5ZzOz7ZPX+anto3Ss6ENGXCJmT3sHa+IlEqyg4tfx4\\/bMfaWpU8wfUpf3U20ozYhf+VYMmvQcz9zfhBADqHPuz2s9eYz\\/rJnlK1W27JUuKUME5SINcAhU+gmOn7FBTD2GPXo7C0Z9y4m03bx2axM2dG2EdcsqjlgNBDR8kNcfaaJ\\/7PIGUUKCxEbcmThsmjdlwgKubqyN5ek\\/ez4NLsQTF3uYP7et4YfV7\\/HYiiWsnrOcL0dUz2xs1EUOH4rDqgUQUrUdA8ZOJKaUgfj9q\\/jwzS957PbDpK\\/7kYk1XXw08vV+D+qNfIdPm\\/\\/H8QNbWbZgMfMGdOD4vB\\/43+CYzMo3NWDQ3fV5b8aPPD1yNj5T+tMgzERS7F7WL95NOhq+\\/r5XttkYSc9XlvKZoQ\\/3vNKf1l95cOpMEHe8vYx3BsU4BKeN2IVP8vymUO5f+gQtcurINaeSalPg5X3NMLzm5YO3Bio1hTQFaKAFteXJeRPZ3GsWu75+lvsWZGBVGv6NJzCmZ2UnQ\\/lu1IMr7u7fvNajg7RtH\\/LRbguR94zljsgSdIhpqEDvaXPpXdTluIYibf8nTJrckGUfDaaSB\\/h2HM2oBkuY9XsKyTtfp38DJ0OmJi+8DGA59Df\\/ZGRGvrKmkJx1RZeyknzsF\\/43+Vb2XFjFqsfqY8jDvNaUZMwKQMPT2+vKZ0Hzwts7a7wljZRUBRiJvmMW05duZNTSOGzmM\\/y+fEXmPIZAqrVpS2V\\/HeOWN5gS8q1RmNPNKM0TD1O2naf2epFeAAAgAElEQVSVpnbnXtw+YDAjJj7Na19uYM\\/PL9I1JI7VzzzFojP2Y1CVTEKSAo+mjJs3i8nDBtG3zwCGPfEB3829jVIpv\\/HOB1vs3TfOipCf92uUrt2FPncNY8L091m14QP6h55k6ZNPseRc1rGxiToTP+XDcU2xbpjF4I6NqF27Hs27DWPGD4cx40H5imWv7pIyRNDtqWfpXzaVE\\/9dIrDLEzw\\/IObqQf+Ujcx5YRXm1sO5K+YSJ0+e5OTJk8ReSEWhSLt4mpOn40kD8PTBx6BBevo1ZywqPZU0BZqPL1nftfS\\/3uLOfi9xtMlTrDgYy5Gdy3jjwfYE753HwK5j+TY2+xGyO\\/Xggrv7Nz\\/1mFlRbFywhP+0ivQf0rZYD5wWV6a6U9l2MYELZ46xb917DK\\/vh6bSOfbd40z71n6ZuVdDHvtmCbMGt6Ccr8HeiGt4+Qdc\\/lwZo8sRZQSVlEiSvRssfNDH\\/BV7jovnT7Dnm4do5q+BSmbXO++wPiVv8xp9fMk8+VGY09KunJ2qNFLT7P\\/TvPH10YBkfpt9F5OWxWEzhNBy\\/MvMnnAbtUsZ0WwJ7HxzMH2e2URSYVVyMVdCgkTDx9cbTaWRmpbzOAho+NUZzsS+URgSt7Dxd3vTrvng56OBSrUfcVyZP7RNB+p5WIk7cADXvQQ63w8YI2\\/l3p7hcGkT6393uEvBswK9Z69m34GdrP9hCd\\/9uJ5f9\\/3Gi208wLMBbZpfPUCsEn5jzl2jmB9XgU7da5Gx8mEGTF3DWYd1Z+xewU8nLCT9PIV2NWtQo0bmVG\\/CCtKUmV+mtaR28yfZYAaMkUSHG7CeO83ZbB3L1jOxnLZq+EZFUUoD1Bm+eWYmG9Pa8dR7D9My1JtSVTty36wl\\/DirA97\\/LWbme7uu7ct2px7c4mL\\/5qMeAUj5hW9XnMVQ8Vb6NMzL9XviahoeviGUb3o3s6b1IXPYI5Hftv55+X4cY5lWPPDuav46cZJD+\\/awZ99BfpnexH5GaiC0eSuqm0DzD8DPHi4WzyDCA7wweQZRqfsjjGyXeSZhu3SAA6eseZrXGFWOskYAxcUTsaRkfY1tpzlxKvPLo3lFUy7MgO3kV8x4PXMAP6jHLObPHMMDMxewafN79Ik0gkrjwMfvsSqxUCq32CshXVtGwstG4sEfnD51ARtRuSSgAT9\\/HzTiybBkHWmEULlKCIaNh9l\\/KAOir3TA2FKTSbZpGP388XV1tqr3\\/QAoMjIyByINTjbAK7QqTdpXBRSJW6Zx77pUgrreQ7\\/yV2ZWl7Yxe8BAZu8uw+APv2PebT788vQdDH5jMH0sn7Hkxe6EG8BU8z7eWtiR1GwH\\/Bnb5jLs1d+oNeZdpnSvSWMTYKhB4wb+8P0Otu2z0KNx1sfCxsnt2zlh86JF47qZZzwZf\\/Hr7mQMZRtQP9xxI0xU6NqFmh7r+ePQEcw0zuHDlXM95M7J\\/s1jPWZJ\\/20VP1\\/QKNu\\/B\\/VKWoe39SjfPf8Kq8\\/mMEbSciwvDKldiF90G\\/Gnz9g\\/dxpePl7Xdid6+BNW3gdt02zGztxgv2S3Knfd2xYfQFWtTXVPjeOpNi7t2MKf5q408gSsp4k9Y80cDzEGERRgwBSYh3kjm9OktIG\\/z9hI\\/20NGy\\/dmXnV1qH1bDhmATQ86zWnkQ9Y\\/\\/iHf9Mzu7hCKlXOPIgCTNEd6FDTxJJTVpQ5notJCgI0MJ9m5+oNHPVtTPcOVXDs9Uo78Ss\\/bT5J6RbdaV3B8Zw3hWObV7HtfBStujWnXPYLLkuQEhIk4FuzLpWNyzmwdz8ZRF3uh7ekpGDz9b2qW8cSu4IPvv0Xq3crmtfPesWTZr1uIeLjT1n6wRIeaXcnZQ0AKez6bCF7LD607NKGIJdBkJf3K5LjE\\/AKDrqqgtP++Zx3fziHCuhFmwauWq0Ujq2cw9gH3uJAQEfmPD+ICIcymWP3sjM2ivs+XsyrvTK7ajrOWMJC0wDGbtnN8ZRuhPtraKVq0r57zWuWnp7+JQYMhNbpRPfOWfeRBNJpUE\\/Cli7ki9cWM+qTQZQ1grqwlrkf7CAjoDODetnD21iOmGgT1n2b+PlgOo1rZe0JKyc2bOSgxUjZmIr2\\/aGnHjK5v3\\/zVo9ZZT60dTtnbX70adMgh\\/uJUjm86nN+OFGFvkM7Ud5hxrSjq\\/l86TFi+gylSwWH0aH0o6z5fClHyt\\/G0G6VKJA2wliRPs+8QZ+CWLYbbLH\\/Y3DvRfh260zT6pEEmczE\\/b2azz9al3m0bwihTbu6lwekU45sYf3u45w9foAdG75n6bqDXLIq0HyoNfZVHm6cWX9aaHf6dwpkzfJLWPa\\/zZixgUzuXY4La+bxyq4MQMOneU86hWpomvvzYmjP0IGV+PLNQ1jOf8tj90byX68g9nzyKrszAEMwnYf2IdoAWqXa1PDWOJZs5dhnjzG5wiPcUcuXc9s\\/ZO4m+\\/WLUXWpW1oDdZEfHmzHkK9OYcWXxtPXs3ZyLYyAOrOQ4W1Gsey8DS2wI69s\\/o6RFQ2AjWMf3kmryetJUAZCer3N1gWDiSohfUTuyH4DouMNh16AD+AHBAKlgFAgAigHxADVgTpAI6A50BaYkJiYqHRN51epcRWMylT1IfXzxaznz6sfR1dUoVVbqVvvvl+NGj1SDe3bTlUJMipN81eNH1+rTjsu49Jf6oM+kcqo+agKnYarJ56bribf2UiVNmrKv\\/EU9fOZrHkvqk2P11ImvFTnNw6rhLy+\\/9I+9WLrABVRr4vqf+8oNWbMcDX41maqvK9BacYw1e3VHeq8Q7ku\\/fWdmvP042ri\\/Xeo9jVKK09NUz4xvdWLP5+8sm6H6cK5806eP6\\/Onc+9Hs\\/N76d8NC\\/V9a0jVy8jfp9699YIZdS8VNmWA9WoMUNUp0q+SjMEq7YvbHMob4L696shqoKHpowh9VW\\/8dPU888\\/rSYObKLCPTRlCOup3t13KR\\/14KzO87Z\\/81qPiYkn1Ac9fZXm0UTN2BXvss4SDr+luvlqCs1X9frg+JVlJRxWb3XzURqa8r3lXXU04UodHXm3u\\/LVUJpPZ\\/XGoQR9n\\/1iOp1ZMFAFa9fcsJY5aZ6qQv8P1b74rPkvqf2vtFOe2ebTvMurrk8uVf\\/EX73si7vfVD0ijEq7ZtmaMoR2VLO3xeVr3oTj36sHa\\/teO69mVBE931K7L7ctZ9XGZ1uqIIPz7dM8Kqi7Pj+gLiUmqsT47WpafY\\/L6\\/QfsEDFZZXt54dUVZP9fYYIdf+y85e\\/r98Pj1QG+\\/KMMePVmgvXfx8BE+xtcHN7m1zH3kbH2NvsCHsbXsrepvvZ23gvrtxkbrRngWM2XKXEnJHg2YQ7+lTkvTe\\/45vfptK4pRdgI7R5P7oe\\/pnta77mp\\/OpGPzDiak\\/iCmjHuLB3jWuvk\\/BUI47P1hFYK0ZvPrld8zblIgWUoWWI+bx1LR7aeRw1mm1WEEz4h\\/gd6XW3H6\\/BzV7DKTpj1vZtmwzpxMseAZHUb3dSCZMmMz9baOuumzQenItb7\\/0ERdDy1G1Ti8mj7+ToQPaUt7FdageXs6OnT1x+rS7jOUZ\\/L8V+L\\/0NK8sXMlnu2wEV27N2LefZdrdtR2O1jXK9HqdVd\\/WYvbc+az65CWWpmj4hcXQYMBTvPH4g\\/S43IWUx3q4ps7ztn\\/zWo9YT3D0RAZ4lKNClOu7HbWgurRuWIYtR+rQtq6\\/w9U+QdRr24SwLYeo2a4eAVdeILBuO5qGb2Z\\/lXbUC74Rr+5R2GJ6MG5YOpt27uHvw6e4kGLFMyiSyvVb0\\/PucYwb2JDSl6vVgH+APyZPX\\/xCo6hYrR7NOvSg\\/6A+tIi+9nzNVPlePl8bxTuz3+DLtTv5Ny4dU0hFGnW5m4lPjqNbBe98zauV6sDMH3+k2gsv8P732zh03oJ\\/dH06D36Yp8Z3p8LlFtGHhpO\\/Y0PNd5jz1kLW\\/v4vZ1PAp3Q5arXswdAJDzG0WRn7WXp1Bk24ix+e+IZ\\/\\/Vrx0Mj2l3tMTHUHM6nvTzy1\\/ASlOz7Efc0dekjum0TPjS+w7nxZejw0hFxOzou1EvQTKWA9\\/CY9Wk1lf+f32PHFnYQV2PcznVVjqjHw62imbNrI47XkV5cKntS5ENdbYf1ESonqkTNWHsa0eyqSuGImL6y75PYd6XlmPczuPxMxVOtJz2rSoBUKqXMhSqwSFSTgR9spLzEk+gRfPP8\\/DhbQ3yOxndrFnjMBtBsxlNolp\\/OvRJM6F6LkKlFdW1mS92\\/jn9CmNAgtwCNXazrpeOElB8eFR+pciOtKfv03B341WtCgoFdi9HL2VztEQZI6F6JEKmFdW0IIIYobCRIhhBC6SJAIIYTQRYJECCGELhIkQgghdCm0q7b27NlTWKsSQghRiAotSFq3bl1YqxJCCFGIpGtLCCGELhIkQgghdJEgEUIIoYsEiRBCCF0kSIQQQugiQSKEEEIXCRIhhBC6SJCIm067du2KughC3FAkSIQQQugiQSKEEEIXCRIhhBC6SJAIIYTQRYJECCGELiUgSBRJ\\/6zkrceG0KVBRcoEeOHhHUh4lWb0fmAuq46mOX1Xyj9LmTGkHdXD\\/PH09CU4sgZtBjzKR9vPYs1xfan8t+kLZk+8i25NqxNd2h+\\/ulPZYdE5v7rI7588Qt9mMYT6e+NXuiKNb5vI+9vPOS2PSvqbb58fRpe60QT7eOLpV4bKzfvx8AfbOJvzBjhZ2CV2zutDBU8DmrEMw1eanc5WsHWWytHVbzJ5QGuqR5XCx8MTv9AYGvccwyurjuJsL+apPNaDvNTCE03TnE7GiFH85HyzhRAFQHOYDICRzJ+b9wC8AB\\/ADwgESgGhQARQDogBqgN1gEZAc6AtMEHlk+3cl6p\\/iEEBTidDmW7qzb\\/Mju9QlzZPV61KOX+P5llJ3b3gqLI4WVfy31+pSe2jlJeWbR0Ro9XqdB3z206r5eNqKx\\/NSXm8qqphi08oq+PscT+ph+r7K83ZNmueqsKg+eqIsw1wIvXoSvV870pX1m0IVfevyL4xBVtntks71Jv9qzjd\\/qwydX3zL2XWU56MHWpKTZPrz0n4SLXKXp62bdu6V3lClHDABHsb3NzeJtext9Ex9jY7wt6Gl7K36X72Nt7L3uab7BlgyJYNJStIlEpRWx+rpbz8y6nG3Qep+8eOUyMHtleV\\/LMaGYMKu+8HlZQ1e9oW9WgNj8xGWDOooNq3qVETx6oBTcKUyd6QGUr3UZ\\/F2hzWYVPxW55TbS4HlqY0nwhVt9Mdatj4R9XUmYvV\\/qtarbzMb1PnvrtHlTXaG0GPCNXk9jvV7U0ilGdWeUL7qfmnssqTpn55qLIy2pfrXbGrGvv0TPX02C6qgpdmb3gj1P3Lk1ROUo6uVW9P7KZifLVrGu1rgqSg6yxxq5ra0EdpoDSPUFWrQx915509VcNwz8thaQi7T32fpKM86WvVuLKZZTGW7aBGTH5YPfzwlemR6YvUAXt5JEjEzUKCxIEt6aw6k3R1I3Z+fl8VYG9UPNu+po7YD+nT1z2gou2NtrHyOLX6kv196X+omc287Y2Tt2o\\/7+jlswDb2e\\/UveWMmQ2dMUy1feRL9ccF14f8eZrfely91dnHvl4f1erFfSpdKaXMf6s5bXztz3uqFi8dzDzCztilnq5rP7I21VZTfstq9NPVjqm1lQkUmFS9Z3arDNclVBe+HqRKG7LOYgzKYNBcBklh1Fn6n6+ru+54Rn1\\/OPnyc5aj81QHb3u5PBqpGX9a8l0elbpE3R2QuSyvbu+p0zblkgSJuFkUVpCUgDES0PzKEOZnL7s1jYtHt7Jw2S5SATQPKrVsTpQBQBF\\/6B\\/irAAaAa1voW2g\\/X2etRjQv0Hmn4RU6eze9ru9Xz6DXfOmseCEFaV5UuO+F3iivQd\\/rVnO2h1HuHRNZ3ze5lcX1vDjljQUoHm25p6hNfEE8KjO4KGt8dQAlcHutRs4pwAMaFm7SSVzMf5Kx74lI8NeIR5ERIVhdF1jlOo1nP5lfYlqfjfPffUdTzX3cDFvYdQZeNaewIJvpnNrJd\\/LzxlDwinjmVVkP\\/z9tHyWB9SlOM6ZFaDhGRJKoFvHTEKIglLszkiUUkqlLVNDg7J102i+qmr\\/t9Vuh16eSwv6KV8ts6vFs+1c9a\\/D4EPy1wPsr6G8Or+tTtqUUuat6tGqRhd965ryrdhdTfnh+JX++zzOb976qKqadXRdcZL6xWE4x7xhgqpw+cj7YbXZrJRSZvX7sw2Vt30bjOHt1KSP1qnNX09QjQM0BZryqjFBrbmYwyG3Ukopq4qPO59ZDuth9UprT5dnJAVeZ04lq50zWig\\/+3p9285V\\/1jyWR6llGXvDNXQw15ngZGqaq2GqvUtd6oHZ85X22Kv3l45IxE3CwrpjKTQ\\/mZ7wcgg\\/sRfHDhtpn7lzENb\\/xbtaeq9hA2pCvPm6fS5O477u1Qj0HqBwz\\/uIuv4XlksWBTYTv3Gr8dcXZOkSDm6ilkDbkNbv5Xnm\\/vkeX4Vf56LKvNVQ3AIwQ7ngFpQKYLsu0TFXyBeAXjQ8Imv+eBgD0YsOET6mY28NrwTr9nfYwjtyWvLXqZzcG6H3AaCQkNymSdTQdfZtZLZ+\\/Zd9H52O8kKNP+mPDF3NFWM+SsPGlhP\\/UesNXP91oRT\\/PPXKf75axebVy7k7TnzePir73mxW5h7nbtCCN2K5xmJ5V+18u3X1KsvzVBTJ9ypWkR52QdqNeVVd4ranpo1Y6La8lTTy+MnzidN+fSZry4ppTK2PaaqmbLOGO5TXx04qxLT09Wlo+vVSz0jlME+f\\/CAheqiLe\\/zp\\/94vwq1j1V4NHhO7XUYRsjY\\/YyqZ8oaPB6mlmdd5XR+g5rerowyaijN4KP8\\/YxXruDSTCqqx2vq95zH2q+WyxlJQdfZVWwX1ObnO6oy9jEbzbOyGrrwWLYrwvJWHqWUspz8Tf2wZLH66vMP1LxZT6ox\\/Vqqcg4XGhgiBqvF5zILI2ck4maBDLbnzHpqoboz0n7FkKGsGrfWoXG0XVJ\\/LnxGDelQW0UHeyujwUP5R9ZUVSPsVwJhUrWm7FAZSinz1kdUFXv3kqnaY2qbwwh2xs6pqlZWg1n5YbXFnI\\/5tzx8eX63urasx9UnvctkNsaGUNXttT9UUspJte3zx1SnKJN9oNlD1Z7yq3JyRbKLysotSAq2zq6U47RaObmxCrQHq+ZXV43+9pjziwbyUB5X0g5\\/qvpH2bvgtAA1YGFm7EiQiJtFYQVJiRhsd8YQ3oZ2tewDyLbzxJ5Ov\\/KiFkjtgdP5fP2f\\/HcxFYvVzKWdT9MAKwrAWI6ut9TFBBhKhxFqrwXr6aMcT3VYjH8g\\/llVlmHGnI\\/5TZWqU9kj80nbqX3sO2fv50Jxfv9+TtsANEyVq1PZBLZj3\\/DByjhsgKnqCJ5\\/oC5+PlE0H\\/Iiyz4bRQUjoDI4+ONKDub1xsScFGCdZUpk27O96T93Jwk20AKb8sjStbzdt7zz\\/tU8lMcVr0qDGNLRL\\/NTr9I5HXshv7UjhMhB8Q8SdYF\\/D8aR\\/aZk86ElLP3dfhWToTRRkV4uFmDhwq7PGHfraBaftgEa\\/q3GM65V5piKsUIzmkZmds6rpLUs+C4WGwAZ\\/LN0GXstABqeNetR3ZT3+bXQ9nSq74EGKPNm5n9xgAyAjH\\/48ovNZF5o5EGDzu0J1UAlJpBks2+6OZFEh3w0mEyFtMOub50BpG19nvtn\\/UaSAs23HhMWLefFzmXc3J6cywM2Ei8mXHO3uy1uLcu3JWcGj+ZFeKR7Y0ZCiLwp9oPt6vQixtQfz87yzWjVqCoRgSbS4\\/azec0WjiRmNl\\/G6Nvo08zz8nsy\\/pjP059s49yZ\\/zi4exu\\/\\/n2WtMzWBGPkrbz64YNUy7p21rMV991bm\\/ee\\/wOz7TxLx7an5y+9qWn+jUVfbiFVAYYy3D68D+FaPuY3VmHI2Ft48bdlXLClsHlqZ9psbk9U7AZ+\\/C2zkTOE9OSBoVUyL+et1oH25YzsOWLFevQ97uqcwP196hGc9Dc\\/fPw5R6wARsq2bUdVI2DZzdMNmzLjTwvgTe\\/PT7N0SFCe67lA64wEfnzjQw5kZI6M+1SqDD+9yKM\\/OZZAw7\\/5SJ4aUA1jXstj3cfcTi2Zl1KPpvUqExnsDYnH2bHuZ\\/7MvI4YQ5lbGdQlIM\\/1IoTIn2I1RpK8dKgKMbgedDUENlaPrI5TjmO6aT\\/cp0KyD9RqXqpsx0fUt4fSrl1J0nb1fOtS9kHi7O\\/zVtXuX6JirTrmtxxTC4dUunwnu+OkeVZWQ78+7jDYbFOnfxiravloLrZZU97VR6jvTtlXYNmrnmvgYX\\/NW\\/X+PP7a7XNjjKRA6yzjV\\/VEDdc\\/X5I5GVSZESsvj\\/vkpTy2s\\/9TPV3WF0rzr6ce+D728s2LMkYibhbI5b+ZDLUH8+zjHqzetIO9B45y6kISFlMg4TG1ad5tIGMmjaRrxasvMTX4BxDg6YMlsAzRlWpSv0UHevUfTL825XB2MSp+zZi6ajt1583ijS9Xs\\/PQWZINgUTXaUe\\/UU\\/wxH1NKW3QMb+xPAM\\/3kLZljOY+f5Sth48S7pXONVb3c6oqU8xqpXjzYUa4b3eYuuvHZj74jssWr+LQ2eSUF7BRFZpSIc+w3lo0iDqZ13+a7vAuYv2vjBjGBXK+ZIfBVpnKo3UNOVsKdenPKb63P3kWAJ+2cGevw\\/x35l40gz+hFWsQ4tu\\/Rk5cTQ9KuevXoQQuXN2GZeW7XH2M5SsyegwZZ2xmABP+2PHfxsqpV4vmE24ualzH3NrueH8mKbQggbw1bGvGZj3nq2bSrt27di4cWNRF0OIAqdp2kRgF2AGMrL9a7E\\/tgBWh8nmMGU\\/w89y1ZFh8R9sFzlK37WNXWYFGAi5ZQBdA4u6REKIm40ESYlm4eDOP0jWNDRTFe4dfxul5NZtIUQhK\\/ZjJCInJuo9sZVzow+z628zVVt6F3WBhBA3IQmSG4BHqco0a1XUpSg5ZHxEiOtLuraEEELoIkEihBBCFwkSIYQQukiQCCGE0EWCRAghhC4SJEIIIXSRIBFCCKGLBIkQQghdJEiEEELoIkEihBBCFwkSIYQQukiQCCGE0EWCRAghhC4SJEIIIXSRIBFCCKGLBIkQQghdJEiEEELoIkEihBBCFwkSIYQQukiQCCGE0EWCRAghhC4SJEIIIXSRIBFCCKGLBIkQQghdJEiEEELoIkEihBBCFwkSIYQQukiQCCGE0EWCRAghhC6mwlrR5s2bC2tVQgghClGhBUnjxo0La1VCCCEKkXRtCSGE0EWCRAghhC4SJEIIIXSRIBFCCKGLBIkQQghdCu2qrfwwm82cOHGChIQErFZrURfHbUajkYCAAKKjo\\/Hy8nI6j2xb8SPbJttW3LizbcVBsQ0Ss9nM\\/v37iYyMJCYmBk9Pz6IuktvMZjPnzp3jwIED1KhR45qyy7YVT7Jtsm3FTW7bVlwU266tEydOEBkZSVRUVLGtPFc8PT2JiooiMjKSEydOXPO6bFvxJNsm21bc5LZtxUWxDZJLly5RpkyZoi6GLqGhoSQkJFzzvGxb8SbbVjLdjNtWXBTbILHZbHh4eBR1MXTx9PR02h8r21a8ybaVTDfjthUXxTZIhBBClAwSJEIIIXSRIBFCCKGLBIkQQghdJEiEEELoIkEihBBCFwkSIYQQuhTbn0gpCLaTCxl\\/37v8Zcn+iiftnl7Gsx2L72\\/ZuEOlHGLF++\\/w5fo\\/OZPuTXjN9gwaN4ZeVX3RirpwOqn43Xz1xjss2XaES8ZQqrcZwNixfagZUNK3TJRkKvUYvyycz+L1v3Po1CUyPEoRXb0RHe8cyZBmoSX+e+eumypIDGW68OgbdUmxZT1j5dRPc3l5QxmaVi\\/ZNyyhEtny+hO8\\/lcDRk97gwb+Z9n0yWu8PtVKmU8epblvURdQB9sJljw7lc+TOjPhhUeolPEXi+a9zROzvfng+R6E3Szf1hImISGBZcuWsXnzZmJjYzGbzURHR9OyZUv69u1LqVKlirqIuqikPXz0yBS+PBFG69sGM6lWBD7mCxz763cS0m6qpvXmChI8S1OxRunL\\/1WnlvHxugs0GjubXlElvJfP+g+\\/7kyk+qDh9G0aiUY1Kow4yM8PbGDvf1aaVzcWdQnzzXZsHSv3+dD5hQe4pb4XUJWHRv\\/F4Gd\\/YN3J7twZXcL3HQBp\\/P7GSJ77oxOz3xlGjRL+zdy+fTuzZ8+mdevWPPjgg5QrVw5PT0+OHDnCmjVrGDZsGA899BDt27cv6qLmUzp7P53DV\\/\\/FcN\\/clxlazefyK20631qE5SoaJfzjqoNKZOtnn\\/NHWB\\/e7BpW8k9BDWGUjdBYv+NXTva9nWiTjXP79xMXWIta0SU3RABsKUkk4Ueg\\/5WPq0+lKkSzmSPHrXBDBIkR\\/7BylIsOxbeEb86mTZt4\\/fXXmTVrFjVq1LjqtZo1a1KzZk169OjB1KlTAUpmmKT\\/zo+rTxHcaQIDHULkZnXTBok6tYqF6y20eaIvVW6EWjBE03vSGP6Y9jZjR2yjfR0bv29Noc\\/T02jpV9SF08dYvg61fJfw85KfuWViJ8p5mzl36hxpyoLZooq6eNeJB9UGvcAbRV0MHdasWUPp0qV57bXXmDlzJtWrV3c5b5UqVZg5cyaPPPII9evXJzg4uBBLqp8t7hj\\/JRuIqV6FkvV7wgXjRmhC88HKoZXL+TukC3NaB5X8sxEAFMlnj3PGFkOHni2IiN2MIe0Iv6zaSa86HYkowSclWkBbxjxxBzPmvMi9t72ABnj7+WC2BVEvuGQfvlv2vc29ExYRa8v+ipHK973Pe\\/dWoqTsuu3bt7NmzRpq1qxJTExMrvNXqVKFTp06sWTJEoYNG1YIJby+FKBpN0brodfNGSTWf1j\\/80nC2z9GrRI+xp5FJW3i3Zd\\/ovTIT5ncszQat9Ov2weMnzSP\\/7VuzpTWJXm0XSO0xRheXzSM+LMXSPcMJO2nxxn5eWlqx5SUZks21GUAAB7bSURBVNY5U5VBvPB+NzKuObHS8AqJLjEhAnDx4kUADh06xIoVK7j99ttzfU+XLl2YO3duiQsSQ2hZorxt7D10hAwa3vRnJTdlkNiO\\/8qO06Vo0rzqDVMBKu4IR5MDaFDuyhmWT5V6VPNbxMnTCShK\\/iXAaF4Eh0diObWKGYsOEtplFi1K+uW\\/XqWpULl07vOVAGazmQ4dOjBixAjKli3r1ntiYmKIjY0t4JIVAK9GdGoTzM9rF7C8Xx36lrtBjkjz6UZpR\\/NAkbD\\/L44bqzOo6o2z+YaoBjQIm89PH3xI9RFdqOyTyP7lH7MxpTz965Up4SGiSD7zL8djT3Nk70a+X7KO2HJDmTmyESX5POtqJf+qralTpxIeHp6n9\\/j4+LB8+fICKlEB0vxoOfxBOu15gbcmTOKfO26lRdUy+FgTOHXoT05FDWBUl8gS\\/r1zXwn8uOplJfbYCWyhbYnyLuqyXEde9Rgx8wkM737Bu09+S3yGJyEVG9DnqQcYUrUkdZA4Y2H3Rw8xY5s3kZXq0HzYHJ7rWZ8yN9Snt+RftZXXECnptNAOPPFWKLXnf8mPy99h3bkUbB4BhFaoSYu+ZqzcPA3szbKdDkzUGjOfn8YUdTmuP68KnRg7qxNji7og150HracsY2VRF6NAlfyrtm5GhlJ1uH38TG4fX9QlKVol9NhHCCFEcSFBIoQQQhcJEiGEELpIkAghhNBFgkQIIYQuEiRCCCF0kSARQgihS7ENEqPRSEZGRlEXQxez2YzReO3NgLJtxZtsW8l0M25bcVFsg8Tf35+4uLiiLoYucXFxBAQEXPO8bFvxJttWMt2M21ZcFNsgCQ8P59SpU5w8eRKz2VzUxckTs9nMyZMnOX36tNOfjZBtK55k22Tbipvctq24cPabYlq2x46TwWEyOkwmwMP+r6f9seO\\/DVNTU1\\/PS8FsNhtJSUnExcWRmJiI1WrNy9uLlNFoxN\\/fnzJlyhAQEIDBcHVey7YVT7Jtsm3FTW7blhsfH5+JwC7A\\/P\\/27jy+iTr\\/4\\/hrkjZtIZGrBwlVKHIUEBVxRRB1VwUvBC\\/EAxV2XdR1QVdR2UWFVRFFcQVZWRUF1gsRDxDc9cB1PX4KLoLI0YIKQku7pAI9oHSaZH5\\/QJaQJk3SFDLH5\\/l4zCNp2iTfTyf5vuf7nckEqA+79B287gP8IUsgZNHClqDDvvhAt+fastlsuFwuHA4Hfr8fTTPON+EpioLdbsfhcERc8VKbPkltUpvexKpNL3QbJHDgn5iZaaZT9B4itRmT1GZMZq5ND\\/QbcUIIIQxBgkQIIURSdD21paoqJSUlVFVVGW4HmcvlIj8\\/n4yMjIh\\/I7Xpj9QmtelNPLXpgW6DRFVVioqKcLvdFBQU4HA4Ut2kuKmqSkVFBcXFxRQWFjZou9SmT1Kb1KY3sWrTC91ObZWUlOB2u\\/F4PLr950XjcDjweDy43W5KSkoa\\/F5q0yepTWrTm1i16YVug6SyspKcnJxUNyMp2dnZVFVVNbhdatM3qc2YrFibXug2SAKBAOnp6aluRlKCx62Hk9r0TWozJivWphe6DRIhhBDGIEEihBAiKRIkQgghkiJBIoQQIikSJEIIIZIiQSKEOEr2U7z4RRYXVWOc8+82po6fls\\/j9VVVJqmn6SRIhBBHhVr0CtNm\\/4uteyN9DZIRKdSXrmD+E8\\/zdY21o8TCQeJn5ydTuW7wYH6\\/cIcptii0Xe8yfvCv+NWvDi3njZpDsX4PP0+Qnz3FH\\/Di1PHcdPUwho5dwPZAqtsk4qJ5+XDeO+zq\\/2tuPMUZ8Rv1jMdBl6vGcIHyIXOXbMPKL0XdnmvryNLY8\\/VfmTBzNfXGOmNCo7R9e6m1deXqR+\\/m3HYH3qqKow359hQ3rFnU8cPbk5n4UgU9LxrCyPE34s7tQK6FN4WMJLDtfZasPoZB0wfS2hwpckDmSVw6pIBly5ax\\/qrf0duiPaoly\\/aXLOXRaWvoc+94Mmc\\/wLepblAz0fbWUKPk0PmErnRpmerWNK+6717koQV2bpg1m4s85nrZ+srWsoGenOg+WFfdNtZszqL3CTmYYhuAADu+\\/IKtbftzW6GxP2HekI38gQMpmP8Pvtg0ht49zfXajJf1tud8P7LwsXnUXPonbu7byiRD7AO0qj1Updmp+9lLtWqGybqDtD38e8Eyyu1elv3xaoZechnXj3uMResqTTAlWceGd55kwl2PsrzMB\\/XbWPrQeCb+9X22+FLdtuayn+INW7F17UEXE\\/azNk9PCl1eiop2meD12DQmXK2N8fHTor+wkOE8OaILDqU41Q1qVmqdQquWG3j2t1fzZMBJp9Mv5eaxN9Av1+Dbtb4iVq+rI+fUQVw99EQ8WVWse2Mmz\\/xpKllzpnJxrpE3BzI48bdT+UPFXUy\\/50HWHLuJj3f0Y+L0a83T6QYqKN8ZoE3vXEw0k3yILYf2ObCyfCd+cq3WqQIWG5FoFR\\/x3Os1XHjrZRSYcG23GHgX8xYs4t33FvPStF\\/TdfvrTJq0gB8NvrNd2\\/szP9faKBhwMWee1I3ju53KsNtHcbr\\/Gz76wmv8rcA0N4PG38l59V+wbGUml04Yx4B2JnpranXU1Wk4MjJMNQPwP4qDjEyo278\\/1S1JGRO9WmPRqFzxMV9XbmPRHZcwePBgBl84lgXbVTY+P4phU7+gPtVNbC52Jx36DOMPY84m44fP+LLE2MeTKGnppCkaNdU1h0IjM4e8VlC5p8r4R8v4\\/8snTz3FR\\/bTuaBvLe88\\/jdW7DZ8PB6iOMjIUFDr6owf+pFoKnV1kJGp328wPNJMuF0ejcIxvxzPC733H3oxB7bwxsRHKD5rCvdd2ct0\\/4xAwCRv26zjKGivsXTdRvZemoMT0Cq3smVXGp4OuQbfGqrjuzkTmLa2K3dMn8jg7BK6Tx7PQ\\/e1ZcaM6zjeDC9KWzbtc23s3ulFxYSdTsBLuRdy2uea5OCIxJlunTbG1jKXY0OPZvLX0ipdwdHGw7Htsow97A7s4NPXPqHmuG54jlHYu\\/0blrz0CWrX0ZyRb+yuFns3zh\\/Sg7eff56nFjsZ0cPHN\\/Nf4ts25\\/LQAJex1xsZFF48jilDTqCPJw3oxLBJ08kvzqKTad6dWXQr7ERgaRE\\/+s7hBNPUdUCgvIjiqmxO7N7O4K\\/FpjPZKrWwQC27t67grTdfZkeVD0crD937\\/ZapN11BJ8NvJtk47opJPLj\\/aZ57+X5uq1TI7nEud065lX5O47910\\/P70Cf0hoyO9D0xVa05Emx06D+AjvM\\/4ItNYzjBVIfIBtjx+edsadefW7uZqa7EWLdyAHt3bpr3z1S3onmkHc+wiTMYlup2HCm2dpx6\\/WROvT7VDRFNYet0PkNPep0X3\\/qCa3qczTHGz\\/8D6r7jnaU\\/0OniuznBbB+RSYDB5zyEEIag5DJo9DBaf\\/4C89fsM8lO93p+XPQs7\\/nOZfTQjpbuTK09IhFCHDUZPUZy9xiNjQ6DH4\\/+P35sOacw8q7hnOYyyxCraSRIhBBHSRY9Lh9Dj1Q3o9lk0mnwTXRKdTN0wMqjMSGEEM1AgkQIIURSJEiEEEIkRYJECCFEUnQbJHa7nfp6Y5\\/9SlVV7PaGnwaU2vRNajMmK9amF7oNEqfTidfrTXUzkuL1enG5XA1ul9r0TWozJivWphe6DZK8vDzKysooLS1FVdVUNychqqpSWlpKeXk5eXl5DX4vtemT1Ca16U2s2vQi0qdolLDroYstZLGHLGlA+sFLx8HroZd9amtrZyTSsEAgQE1NDV6vl+rqavx+43yIyW6343Q6ycnJweVyYbMdntdSmz5JbVKb3sSqLZasrKzbgdWACtSHXfoOXvcB\\/pAlELJoYUvQYScn0O0HEm02Gy6XC4fDgd\\/vR9OMc1IFRVGw2+04HI6IK15q0yepTWrTm1i16YVugwQO\\/BMzMzNT3YwjQmozJqnNmMxcmx7oN+KEEEIYggSJEEKIpOh6aktVVUpKSqiqqjLcDjKXy0V+fj4ZGZG\\/x1lq0x+pTWrTm3hq0wPdBomqqhQVFeF2uykoKMDhcKS6SXFTVZWKigqKi4spLCxs0HapTZ+kNqlNb2LVphe6ndoqKSnB7Xbj8Xh0+8+LxuFw4PF4cLvdlJSUNPi91KZPUpvUpjexatML3QZJZWUlOTk5qW5GUrKzs6mqqmpwu9Smb1KbMVmxNr3QbZAEAgHS0439JcjB49bDSW36JrUZkxVr0wvdBokQQghjkCARQgiRFAkSIYQQSZEgEUIIkRQJEiGEEEmRIBFCHFWBXWtZ9PgdXD\\/0As4fej1\\/fHkt1cY5IW\\/jtErWvbeAf\\/1Yl+qWHFUSJEKIo6q+dCNl+cN54PlXmXdfP\\/778nP8o8wcSaJVr+C12cvZjrEPN06Ubk+RcqTV\\/riYR\\/44m9qRr\\/L4JW0jfsOXsdRT9tVC5r7yHis2e6nLyqNwwJXccutQCp0Gr07bzdq35vLKe1+ybnslmqsDvX55DbeNGUwn\\/Z5+SESR0XsEY3sf\\/MHZHY99HfX1GpG\\/Z89Yar9dyYa2v+D6jtbaRrdckASqf+TTRfOYu+j\\/KNlvo0+qG9Rc9n3Lgr99QE3\\/q\\/jDdXnw03LmzZ3JJHsH5t95Ksb+JoZ06uvS6HnZOIZ3yKS6+H3mz3uCh5ydeW50F+ypbp5oolqKFr7Fd8edyW\\/yzdDxqmxY+S2ZfSfSxWIvSosFSYCyf85i9socLn\\/gDr5\\/5Gl2p7pJzaXFqYyd8wJpaQdX6eknY9\\/8FQ9uWM+OwKl0NvL7VHHS99px9A3+fHJXald\\/yowftlJHF1qksm2iaQI\\/858XH+TRj9tzy7QRFJih4\\/VtYuVqjVPG9rBax2q1em10uHI6C4YrKL4VTEt1c5rZ\\/0IEQKti1656Mj35ZBt\\/xuCQwD52rHqbD4qdnHpLb7JS3R6RMG3vJt6aOpnX9w3iT7Nu5JS2Rt7KOcS\\/5WtW7T2ZG3tbb77VHGswEYpigpnYWHyULJvBS5u7M3LU2RxjkoKrP7yfiwYN4bp7X2Pnab9n3KA8C6xL49H2fsm04YO54W\\/rUQG0PXz2yFVcdOtLfF9VzGsTJ\\/Jem5uZOW20QUPER+WWFSyd9wQPzPo3uzWAAGWr\\/oO3Vz9OtuDWjcVGJFZQx09Lp3Dv7B2cMfEJrupsnlXsHDCWWc8Mp3zz5yya9xi3T0vnmQln0tbAaaLtWsafRs1iTX34bxRanvMAr919uuGO\\/1Fa9mPEFV34+NXX+fTqSZy06ilmfuVh1Mwr8S28jTcyRjLztv60Daio9TbS0tKwGWod1lP8wZus9PrY\\/NkrvHvRQG4o2MWqldvofs4puAxVS\\/MwTy8jODASeYjxs8sYeN8TjO3fzlRb7ErLXDp3z6Vz9970zirn6sfe5JPfDOTyXONWqRxzBrdMK2BvoMFvsLfON+gb1MZxF1\\/H2Yse5LVZf+HdrzfQa9wsrswv4ukPfmKP9yluuPApAJSsM5m48EHOdaa4yQnJ4rSbp3GaVs7bd\\/2aBe+sZvivd7Hy+870u9sMR4AmzpivUxHRvrVzuP+ZbfSb+BfGmSxEIvPh96W6DUlKa03HwtapbkWzU1ynM2JoR26e9yHHXvkYU87NxabkcvvC5dye6sY1FyWP8y4bwN8ff5fl3exs8JzGmDzzv+sikSAxC20nH85fzM+9R3N+7m5++P7g8WiKgzb5x9HOyPv\\/1I0sfWU9mYWdyWkRoGr7Kpb8\\/UvoeQv921vzjat7tZv4bEUpfjTSXa3IMuVqUnD1u4RznPcy5wUHbYdcgymOYm4CCRKz8P3Ixs11VFfPZtyKkNvtHbnumRe4qZtxj6\\/U9tXg3fwRH76zlZ17A2S2PZZeA37P46OHWvaNq2v+cj58bDIL\\/cO469rVPL1kEf+54m76mfE4bccJXDioA4tfrmXQaQWW\\/UyTdYMkrR\\/3LH4\\/1a1oPumnM2HJx0xIdTuOAKX1Lxj9yC8YneqGiNi0Gr6d8wBPbejBHTNv4rzMj\\/hq8Qze+ng0pw3JNuF0q53jRzzM7P4+crtZtzuV7TkhRDPxsX3pFB5cYuOKSfdwXnsbSuuBXHhGBmv++TE7GhxQYA5KCzddC4+llYV7U+tGqBCimaVx7CVTefOS0NtaMGDCW5ho7C8isHCGCiGEaA4SJEIIIZIiQSKEECIpEiRCCCGSIkEihBAiKboNErvdTn19gzPZGYqqqtjtDT+iJLXpm9RmTFasTS90GyROpxOv15vqZiTF6\\/Xicrka3C616ZvUZkxWrE0vdBskeXl5lJWVUVpaiqqqqW5OQlRVpbS0lPLycvLy8hr8XmrTJ6lNatObWLXpRaQzFihh10MXW8hiD1nSgPSDl46D10Mv+9TW1s5IpGGBQICamhq8Xi\\/V1dX4\\/f5E7p5Sdrsdp9NJTk4OLpcLm+3wvJba9Elqk9r0JlZtsWRlZd0OrAZUoD7s0nfwug\\/whyyBkEULW4JCr+v3k+02mw2Xy4XD4cDv96NpWuw76YSiKNjtdhwOR8QVL7Xpk9QmtelNrNr0QrdBAgf+iZmZmaluxhEhtRmT1GZMZq5ND\\/QbcUIIIQxBgkQIIURSdD21paoqJSUlVFVVGW4HmcvlIj8\\/n4yMyF9NKLXpj9VrK91Txn3vPswnmz6jpm7vUW6hiMSZ0ZJfdh3I\\/RfdQ+fsTqluTlS6PWpLVVWKiopwu91kZ2fjcDgSuXtKqapKRUUFZWVlFBYWNmi71KZPVq5tR2U5fR4\\/C6V9Okq7dBSH+b6Cyog0VUOrUNH+62P13Z\\/iadU+ofsfraO2dDu1VVJSgtvtxuPxGOoNC+BwOPB4PLjdbkpKShr8XmrTJyvXdt+Sh1Hy0rC5HRIiOqI4FGyeDJS8NO5\\/d0qqmxOVboOksrKSnJycVDcjKdnZ2VRVVTW4XWrTNyvW9vGmf2PLMVY4WomS7eBfmz5NdTOi0m2QBAIB0tPTU92MpASPWw8ntembFWvbW7cP0mUkoleKQ6F6f02qmxGVboNECCGEMUiQCCGESIoEiRBCiKRIkAghhEiKBIkQQoikSJAIIYRIigSJEEKIpFgvSAIVrJx7H7+54kLOv2g4Yx5cwNo9xvl+AmtR2fqPx7h1xBAuvmw0E1\\/+lqrgqvJvY+HYIYx6dj11KW2jEMJiQeJjy+uTmbxwB91G3sfDE67AU\\/wi901ZSplkie5oO\\/\\/JrL8W0\\/PO55k39Xz2L5zOa0U+QOPnj+fw2s6BjLm2J5FPQWg0Gvu2\\/B\\/vf11CfaqbIkSCrBUk9d+x+J1NtBt6F3dedga\\/OOtq7hl7Ho5vF7G02DhncrUKf+kWtrv6cFZfNzndz+b0jhVs2boXbe8q5s9dQ7frR9PfZZ5PY+\\/5+lVmvPkd+2SjRhiMpYIksGMDG3e3oPcp3Qie6KLFiX3paStjw8afkfevvthz3eRWFbNuWx3+XetZt8OFu30637\\/xHMuPGc7NF+RFPH21EOLo0vX3kTS3wJ5d7KE1bduE5KejHdmtYNvPewiQiz11zRNhFM9FjBnxFX\\/+3VD+rjnIHzyeW3I+ZPpb+xg84STWPXkHD63dg6vXJdw69nJ6OCVWrCw9516+GjSKggYvAz\\/r1l7BOd8V40tFwyzAUkGCjDmMRXHS+4YneeOafewLZNLSUcWnU25iS9+buapoBg+XDGTSn\\/tQ9MxkHnmpkLm39jLcC9q3\\/hluHPcGOwLBW9Zz6TnTADvHj3qOZ2\\/sLBs3carfPZdr\\/rE44j6z2v1bJUSOIKO975Jia92O1uxh1+4ABN+e6i4qqqBNu9bWmuczECW9BS2B\\/Wtf5YUV+Vz71xMomV5Ozwsv55TjW9Hjot68+sYaSgO96GiwlZjWZQSPPDeYek3D+8Fj\\/LnoTB4dewZORSGjbb6ESCJ8O9m0e2eqW2FJ1goST096tNnHN2s2U9+vJ+lA7Xer2OB3c36PdjLfrme+rbz97HukDXuCS\\/JhiQaK7UBq2Gw2CASMOd7MaEfH49sBGi2+ycTWIpeCLl1oJS\\/GhMnUVupYKkhI782wS7vywUt\\/YWaHmzinbQnL\\/rYc9aTfMaS7Sbb9\\/JuY85vbWNZrCm\\/cfZpJVrCG96PnWVhxFveO6I7D5qdnr3a8vPx9fujbl43L13FMz0vxGGw0IpqXTG2ljjn6mbilUTBiMpP2P8WzL0zi\\/f1OOp1+Iw\\/dfglus2wBavWoqkKrNq1NM8LSalYyf\\/56Ckc9Rz+XAqTR49rxXPnIdMbf+BKunkO5a9TJGPv7\\/RQ8V83ivatS3Q4Dk6mtlLFYkAC2HPqNnkK\\/0aluyJGh1e5gxx4nPXt3NM38uuLsx\\/jX3jn8NteJjJw6n5EpapMQ4hCZDDAZ9fsituacwwUnm+Pz3kII\\/bPeiMTkMvqMZf4LfuyyZoUQR4mMSEzInmaWSS0hhBFIkAghhEiKBIkQQoikSJAIIYRIypEIEi3sUgghROodsb5ZtyMSu91Ofb2xv+JHVVXs9oY7vqU2fbNibc6MllAv2356pakarkxnqpsRVXMGSWOvwoRfoU6nE6\\/Xm0RzUs\\/r9eJyuRrcLrXpmxVrO7vLGQS8agpaJOKhVaic3eWMJt21ib9LSDJBEm8Dm9TYvLw8ysrKKC0tRVWN9QJXVZXS0lLKy8vJy8tr8HupTZ+sXNuEQX9AK\\/cR2FGHpsrIRC80VTuwTsp9\\/HHQnU1+mCjXG\\/u7hEQ6HZMSdj10sYUtdg58qDG4pIcsjpDLPrW1tTMTaVggEKCmpgav10t1dTV+v3G+Ctdut+N0OsnJycHlch04O20IqU2frF7b1p3bePjDx\\/lk8+dU769JUUtFqGMyXZzZZQD3nns73d1dG6y3WLKyssYBqwEVqA+5DC6+kMUPBMIWLWwJOix0mhIkCgcCJFaQBEPEAZxcW1v7dEL\\/AUDTNOrq6vD7\\/WiacbaSFEXBbrfjcDiirnipTX+kNmPWZmbxrLfGZGVljQXWcCBAwkMkWpD4ORAUcQdJoifS0GgYPqFPEP6EkRoQN0VRyMzMbMpddU9qMyapTRhMrD45Wv+cUJ\\/d1H0k8TyxHAYshBCpF60vTjpAgpr78N\\/wYVCTRyNCCCGaxRHvl5M9aivS8ChSgwNJPI8QQoimibSfo7F+u0niCZJYTxBpB0xogMioRAghUiNaX5zIIcEx++9ERiTxPFm00YgEiRBCHH3Rjr6KZ4or7n67KVNbsaaxZD+JEELoQ6J9dJP660hBEu+DhA+Rwkcg4R9sEUIIcXRF+oBhtGmuRPv+\\/0l0RNLYIb6RprMkSIQQInUaC5Fo+0wi\\/dyoWEES7TjjeJZg4\\/1RHkcIIcSRpXH4qU+auiui0T68OT5HEik8whfjnJRICCHMI9L5syKFSlISPUVKULyjkWCIBLKyskZx4NxcoUv4SSCDwRY8p1fwdCzhl0IIYXaN7YeG6BvtoUuAhmHS7AdGReuYw0\\/cGLwMPwtw+AkcQ5e0GJfhgWIPeUxb2PNFa5MQQphNpM94RNsHHRoWoYsvxmWksAkdBDS2D6VB2CQ7IlHCigvt\\/P0hl3B45x\\/+T7Ed\\/LvQgJIgEUJYUawgibYbITwgYo1MIh291aQRSVODJPRJIxUYGibR7hMsJHxqKzxEJEiEEFYST5BECpNoo5PQMIk1vdUk8QRJcOQRWhQcPhoJD5HQMIn0eBoHQiN4GW1KK\\/wxJECEEFYRHiixPmYRPvJoLEQaOww4PFRiBky0IAkNj2i3NTbkIsL9g39r51CAhI5IYu0bkRARQlhNtB3ukYIk2ugkkR3ukZ471m1NmtqKNipp7EOHwb8JDZFI01nxHK0lgSKEMLto01vBy\\/BRRWNhEu3naPtIEp7iijdIQnesRxqVBEcWkQIlPPHCAyTadFa0kYgEiRDC7KKNDhrbNx0tUBr7DEl4mER6vpiS3dkeFAyZYKDECpPg30ULEiJcEuVnIYQwm1gde2NBEh4o0X5OeiQSlMzUVugO+GAwwOFhEr5jPXSHfCIjEQkPIYRVRZvmamxkEilUGvsbwh43IY0FSaRprEjTWpGO6AoNi2BDQ6fGwo\\/sktGIEEIcLtFRSWOhEunnWAESz853IPERSXggRNurHxoioSGhEd8oREYjQghxSDw73+NZok1pRXrMuCW7jyRamED0EUekU64Q4TL8uhBCWFm8YRL+c6Ql2n2aJJ6OOtLfROrsI4VE6PVkA0RCRQhhNdFmfcKvxxMoxLge73M20NQgCb89Wig0Fi6RLuN9PiGEsIJoHXisMAleNhYa8YZIY7cD8XfOiYRJ6PVEg0NCRAghDpdImIReTzQ4mhQikFgHHW8nH29YxHtEloSIEMLq4u3k4w2LeI\\/Iimu\\/SaKddGN\\/31gwNDbqSOQxhRDCqhrr1BsLhsZGHYk8ZlRN6agT7fhl5CGEEEdGoiOVeO4b63cNNLXzbq6d9Mk8vhBCWFE8nXwyU1UJHwacTIfdHPtXknlMIYSwsng7\\/ESCoUmfJWmujvtoBZIQQoiGmvxhwiTvCxyZTlyCQQgh9C3p8Ah1NDp9CRYhhEitZg2OcLbYfyKEEEIIIYQQQgghhBBCCCGEEEKIUP8Pw1zGDz1zyKQAAAAASUVORK5CYII=\\\" \\/><\\/p>\",\"hr\":\"\",\"pt-br\":\"\"}',NULL,'en','2021-07-06 19:07:45','2021-07-06 22:56:24','1'),(17,81,'galeria','Fotos','fotos','{\"en\":\"Photos\",\"hr\":\"Fot\\u00f3k\",\"pt-br\":\"Fotos\"}','{\"en\":\"Photos\",\"hr\":\"Fot\\u00f3k\",\"pt-br\":\"Fotos\"}','{\"en\":\"\",\"hr\":\"\",\"pt-br\":\"\"}',NULL,'pt-br','2021-07-09 06:57:03','2021-07-09 12:34:14','1');
/*!40000 ALTER TABLE `tb_pagina` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_pagina_album`
--

DROP TABLE IF EXISTS `tb_pagina_album`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_pagina_album` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Numero sequencial',
  `id_album` int(11) unsigned NOT NULL,
  `id_pagina` int(11) unsigned DEFAULT NULL COMMENT 'Título principal do banner.',
  `created_at` timestamp NULL DEFAULT current_timestamp() COMMENT 'Data de criação do banner',
  `updated_at` timestamp NULL DEFAULT current_timestamp(),
  `status` enum('0','1') NOT NULL DEFAULT '1' COMMENT 'Situação de exibição do banner. 0 - Não exibir; 1 - Exibir.',
  PRIMARY KEY (`id`),
  KEY `fk_tb_album_foto_id_album` (`id_album`),
  CONSTRAINT `fk_tb_album_foto_id_album` FOREIGN KEY (`id_album`) REFERENCES `tb_album` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_pagina_album`
--

LOCK TABLES `tb_pagina_album` WRITE;
/*!40000 ALTER TABLE `tb_pagina_album` DISABLE KEYS */;
INSERT INTO `tb_pagina_album` VALUES (32,6,17,'2021-07-09 09:26:55','2021-07-09 09:26:55','1');
/*!40000 ALTER TABLE `tb_pagina_album` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_produto`
--

DROP TABLE IF EXISTS `tb_produto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_produto` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_distribuidor` int(11) unsigned NOT NULL,
  `id_categoria` int(11) unsigned NOT NULL,
  `nome` varchar(100) NOT NULL,
  `descricao` text NOT NULL,
  `modo_uso` text NOT NULL,
  `imagem` varchar(255) DEFAULT NULL,
  `valor` decimal(10,3) NOT NULL,
  `status` enum('0','1') NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `tb_produto_id_categoria` (`id_categoria`),
  CONSTRAINT `tb_produto_id_categoria` FOREIGN KEY (`id_categoria`) REFERENCES `tb_produto_categoria` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_produto`
--

LOCK TABLES `tb_produto` WRITE;
/*!40000 ALTER TABLE `tb_produto` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_produto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_produto_categoria`
--

DROP TABLE IF EXISTS `tb_produto_categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_produto_categoria` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_parent` int(11) unsigned NOT NULL,
  `categoria` varchar(100) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `imagem` varchar(255) DEFAULT NULL,
  `status` enum('0','1') NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_produto_categoria`
--

LOCK TABLES `tb_produto_categoria` WRITE;
/*!40000 ALTER TABLE `tb_produto_categoria` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_produto_categoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_sys_config`
--

DROP TABLE IF EXISTS `tb_sys_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_sys_config` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Número sequencial da tabela.',
  `config` varchar(255) NOT NULL,
  `value` longtext DEFAULT NULL COMMENT 'Endereço do website',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`,`config`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COMMENT='Tabela de configurações do site';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_sys_config`
--

LOCK TABLES `tb_sys_config` WRITE;
/*!40000 ALTER TABLE `tb_sys_config` DISABLE KEYS */;
INSERT INTO `tb_sys_config` VALUES (1,'site_logo','assets/embaixada/img/a4531b15b8bd4914c5ad32e841398325d422a518.png','2021-03-09 19:55:51','2021-07-07 05:34:23'),(2,'original_logo_name','insignia.png','2021-03-09 19:55:51','2021-07-07 05:34:23'),(3,'site_title','EMBAIXADA DA REPÚBLICA DE ANGOLA NA HUNGRIA','2021-03-09 19:55:51','2021-07-09 09:16:33'),(4,'site_url',NULL,'2021-03-09 19:55:51','2021-03-09 19:55:51'),(5,'language','hr','2021-03-09 19:55:51','2021-07-09 09:18:38'),(6,'contact_email',NULL,'2021-03-09 19:55:51','2021-03-09 19:55:51'),(7,'contact_phone',NULL,'2021-03-09 19:55:51','2021-03-09 19:55:51'),(8,'contact_cel',NULL,'2021-03-09 19:55:51','2021-03-09 19:55:51'),(9,'facebook',NULL,'2021-03-09 19:55:51','2021-03-09 19:55:51'),(10,'instagram',NULL,'2021-03-09 19:55:51','2021-03-09 19:55:51'),(11,'linkedin',NULL,'2021-03-09 19:55:51','2021-03-09 19:55:51'),(12,'address',NULL,'2021-03-09 19:55:51','2021-03-09 19:55:51'),(13,'address_nro',NULL,'2021-03-09 19:55:51','2021-03-09 19:55:51'),(14,'cep',NULL,'2021-03-09 19:55:51','2021-03-09 19:55:51'),(15,'complemento',NULL,'2021-03-09 19:55:51','2021-03-09 19:55:51'),(16,'bairro',NULL,'2021-03-09 19:55:51','2021-03-09 19:55:51'),(17,'cidade',NULL,'2021-03-09 19:55:51','2021-03-09 19:55:51'),(18,'uf',NULL,'2021-03-09 19:55:51','2021-03-09 19:55:51'),(19,'gmaps','<iframe src=\"https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d1664.5836546927305!2d-34.858389255410266!3d-7.117950406096949!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x7acdd56d3578e67%3A0x65c680df17fb4e42!2sHostDime%20Brasil!5e0!3m2!1spt-BR!2sbr!4v1615446431902!5m2!1spt-BR!2sbr\" width=\"600\" height=\"450\" style=\"border:0;\" allowfullscreen=\"\" loading=\"lazy\"></iframe>','2021-03-09 19:55:51','2021-03-11 10:07:25'),(20,'site_description','EMBAIXADA DA REPÚBLICA DE ANGOLA NA HUNGRIA','2021-03-09 20:00:20','2021-07-09 08:37:04'),(21,'site_tags',NULL,'2021-03-09 20:08:48','2021-07-06 21:15:52');
/*!40000 ALTER TABLE `tb_sys_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_sys_config_versao-1`
--

DROP TABLE IF EXISTS `tb_sys_config_versao-1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_sys_config_versao-1` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
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
  `force_https` enum('1','0') NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `url` (`url`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_sys_config_versao-1`
--

LOCK TABLES `tb_sys_config_versao-1` WRITE;
/*!40000 ALTER TABLE `tb_sys_config_versao-1` DISABLE KEYS */;
INSERT INTO `tb_sys_config_versao-1` VALUES (1,'localhost','/embaixada','Embaixada da República de Angola na Hungria','',NULL,NULL,'Guedes, Alisson',NULL,NULL,'general','',NULL,NULL,'pt-br',NULL,NULL,'0','0','0','0');
/*!40000 ALTER TABLE `tb_sys_config_versao-1` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_sys_dicionario`
--

DROP TABLE IF EXISTS `tb_sys_dicionario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_sys_dicionario` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `palavra` text NOT NULL,
  `definicao` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_sys_dicionario`
--

LOCK TABLES `tb_sys_dicionario` WRITE;
/*!40000 ALTER TABLE `tb_sys_dicionario` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_sys_dicionario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_sys_idioma`
--

DROP TABLE IF EXISTS `tb_sys_idioma`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_sys_idioma` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `descricao` varchar(100) NOT NULL,
  `sigla` varchar(7) NOT NULL,
  `bandeira` varchar(255) DEFAULT NULL,
  `updated_at` datetime DEFAULT current_timestamp(),
  `status` enum('0','1') NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sigla` (`sigla`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_sys_idioma`
--

LOCK TABLES `tb_sys_idioma` WRITE;
/*!40000 ALTER TABLE `tb_sys_idioma` DISABLE KEYS */;
INSERT INTO `tb_sys_idioma` VALUES (1,'Português Brasil','pt-br','img/localidades/1612531977_220a6c6c090a89d743e9.jpg','2021-07-09 05:14:51','1'),(2,'English','en','img/localidades/1612531878_bd7502753e5de17e7b45.jpg','2021-03-11 21:36:17','1'),(3,'Húngaro','hr','img/localidades/1612531970_988317c9bd4ee27b70dc.jpg','2021-03-07 22:06:18','1');
/*!40000 ALTER TABLE `tb_sys_idioma` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_sys_idioma_dicionario`
--

DROP TABLE IF EXISTS `tb_sys_idioma_dicionario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_sys_idioma_dicionario` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_idioma` int(11) unsigned NOT NULL,
  `id_palavra` int(11) unsigned NOT NULL,
  `traducao` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_tb_sys_idioma_id_palavra` (`id_palavra`),
  KEY `fk_tb_sys_idioma_id_idioma` (`id_idioma`),
  CONSTRAINT `fk_tb_sys_idioma_id_idioma` FOREIGN KEY (`id_idioma`) REFERENCES `tb_sys_idioma` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_tb_sys_idioma_id_palavra` FOREIGN KEY (`id_palavra`) REFERENCES `tb_sys_dicionario` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_sys_idioma_dicionario`
--

LOCK TABLES `tb_sys_idioma_dicionario` WRITE;
/*!40000 ALTER TABLE `tb_sys_idioma_dicionario` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_sys_idioma_dicionario` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-07-12 13:40:40
