/*
SQLyog Ultimate v12.5.1 (64 bit)
MySQL - 10.4.24-MariaDB : Database - penjualan
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`penjualan` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;

USE `penjualan`;

/*Table structure for table `barang` */

DROP TABLE IF EXISTS `barang`;

CREATE TABLE `barang` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `kd_brg` varchar(5) NOT NULL,
  `nm_brg` varchar(255) NOT NULL,
  `satuan` varchar(25) NOT NULL,
  `stok_brg` int(11) DEFAULT NULL,
  `stok_min` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4;

/*Data for the table `barang` */

insert  into `barang`(`id`,`kd_brg`,`nm_brg`,`satuan`,`stok_brg`,`stok_min`) values 
(5,'P01','Camel','pack',100,9),
(8,'H009','Sabun','batang',14,2),
(14,'B004','Buku','pack',20,1),
(15,'B006','Tas','buah',130,1),
(21,'Y01','Roti','buah',85,10),
(22,'B01','Topi','pcs',10,100);

/*Table structure for table `id` */

DROP TABLE IF EXISTS `id`;

CREATE TABLE `id` (
  `kode` int(10) NOT NULL AUTO_INCREMENT,
  `nama_barang` varchar(20) DEFAULT NULL,
  `satuan` varchar(20) DEFAULT NULL,
  `harga` int(10) DEFAULT NULL,
  `stok` int(10) DEFAULT NULL,
  `stok_min` int(10) DEFAULT NULL,
  PRIMARY KEY (`kode`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

/*Data for the table `id` */

insert  into `id`(`kode`,`nama_barang`,`satuan`,`harga`,`stok`,`stok_min`) values 
(1,'Mie Goreng','buah',1500,10,50),
(2,'Mie Rebus','buah',4000,10,20),
(3,'Ayam','buah',10000,3,10);

/*Table structure for table `tb_user` */

DROP TABLE IF EXISTS `tb_user`;

CREATE TABLE `tb_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_user` varchar(255) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `jabatan` varchar(255) NOT NULL,
  `alamat` varchar(255) NOT NULL,
  `umur` int(11) NOT NULL,
  `jenis_kelamin` varchar(255) NOT NULL,
  PRIMARY KEY (`id_user`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

/*Data for the table `tb_user` */

insert  into `tb_user`(`id`,`id_user`,`nama`,`jabatan`,`alamat`,`umur`,`jenis_kelamin`) values 
(1,'P01','Tonoooo','SuperVisor','Semarang',20,'Laki-Laki');

/*Table structure for table `transaksi` */

DROP TABLE IF EXISTS `transaksi`;

CREATE TABLE `transaksi` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `kd_brg` varchar(255) NOT NULL,
  `nm_brg` varchar(255) NOT NULL,
  `waktu` varchar(255) NOT NULL,
  `jumlah` int(11) NOT NULL,
  PRIMARY KEY (`kd_brg`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;

/*Data for the table `transaksi` */

insert  into `transaksi`(`id`,`kd_brg`,`nm_brg`,`waktu`,`jumlah`) values 
(2,'B01','Topi','27-12-2023',52),
(6,'Y01','Udang','20-13-2023',5);

/*Table structure for table `transaksi_penerimaan` */

DROP TABLE IF EXISTS `transaksi_penerimaan`;

CREATE TABLE `transaksi_penerimaan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `kd_brg` varchar(255) NOT NULL,
  `nm_brg` varchar(255) NOT NULL,
  `waktu` varchar(255) NOT NULL,
  `jumlah` int(11) NOT NULL,
  PRIMARY KEY (`kd_brg`,`nm_brg`,`waktu`,`jumlah`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

/*Data for the table `transaksi_penerimaan` */

insert  into `transaksi_penerimaan`(`id`,`kd_brg`,`nm_brg`,`waktu`,`jumlah`) values 
(3,'B006','Tas','12-12-2021',30);

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `username` varchar(255) NOT NULL,
  `namalengkap` varchar(255) DEFAULT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `users` */

insert  into `users`(`username`,`namalengkap`,`password`) values 
('admin',NULL,'admin'),
('rio','Rio Lintang','rio');

/* Trigger structure for table `transaksi` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `pengeluaran` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `pengeluaran` AFTER INSERT ON `transaksi` FOR EACH ROW 
begin
	update barang set stok_brg = stok_brg - new.jumlah where kd_brg = new.kd_brg;
end */$$


DELIMITER ;

/* Trigger structure for table `transaksi` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `update_pengeluaran` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `update_pengeluaran` AFTER UPDATE ON `transaksi` FOR EACH ROW 
BEGIN
	UPDATE barang SET stok_brg = stok_brg + old.jumlah - new.jumlah WHERE kd_brg = old.kd_brg;
END */$$


DELIMITER ;

/* Trigger structure for table `transaksi` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `del_pengeluaran` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `del_pengeluaran` BEFORE DELETE ON `transaksi` FOR EACH ROW 
BEGIN
	UPDATE barang set stok_brg = stok_brg + old.jumlah WHERE kd_brg = old.kd_brg;
END */$$


DELIMITER ;

/* Trigger structure for table `transaksi_penerimaan` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `insert_penerimaan` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `insert_penerimaan` AFTER INSERT ON `transaksi_penerimaan` FOR EACH ROW 
BEGIN
	UPDATE barang SET stok_brg = stok_brg + new.jumlah WHERE kd_brg = new.kd_brg;
END */$$


DELIMITER ;

/* Trigger structure for table `transaksi_penerimaan` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `update_penerimaan` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `update_penerimaan` AFTER UPDATE ON `transaksi_penerimaan` FOR EACH ROW 
BEGIN
	UPDATE barang SET stok_brg = stok_brg + new.jumlah - old.jumlah WHERE kd_brg = new.kd_brg;
END */$$


DELIMITER ;

/* Trigger structure for table `transaksi_penerimaan` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `delete_penerimaan` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `delete_penerimaan` BEFORE DELETE ON `transaksi_penerimaan` FOR EACH ROW 
BEGIN
	UPDATE barang SET stok_brg = stok_brg - old.jumlah WHERE kd_brg = old.kd_brg;
END */$$


DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
