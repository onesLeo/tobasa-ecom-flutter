import 'package:flutter/cupertino.dart';

class Produk{
  String id;
  String namaProduk;
  String deskripsiProduk;
  String ukuran;
  num hargaProduk;
  Map<String, dynamic> gambarProduk;
  String gambarProdukFirebaseDB;

  Produk({
    @required this.id,
    @required this.namaProduk,
    @required this.hargaProduk,
    @required this.ukuran,
    @required this.deskripsiProduk,
//    @required this.gambarProduk,
    @required this.gambarProdukFirebaseDB,
  });


  factory Produk.fromJson(Map<String, dynamic> json){
    return Produk(
      id: json['id'],
      namaProduk: json['nama-produk'],
      hargaProduk: json['harga-produk'],
      deskripsiProduk: json['deskripsi-produk'],
      gambarProdukFirebaseDB: json['gambar-produk'],
      ukuran: json['ukuran-produk'],
    );
  }

  factory Produk.fromJsonFirebase(Map<dynamic, dynamic> json){
    return Produk(
      id: json['id'],
      namaProduk: json['nama-produk'],
      hargaProduk: json['harga-produk'],
      deskripsiProduk: json['deskripsi-produk'],
      gambarProdukFirebaseDB: json['gambar-produk'],
      ukuran: json['ukuran-produk'],
    );
  }

}