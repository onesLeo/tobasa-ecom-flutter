import 'package:flutter/cupertino.dart';

class Produk{
  String id;
  String namaProduk;
  String deskripsiProduk;
  String ukuran;
  num hargaProduk;
  Map<String, dynamic> gambarProduk;

  Produk({
    @required this.id,
    @required this.namaProduk,
    @required this.hargaProduk,
    @required this.ukuran,
    @required this.deskripsiProduk,
    @required this.gambarProduk,
  });


  factory Produk.fromJson(Map<String, dynamic> json){
    return Produk(
      id: json['id'],
      namaProduk: json['nama-produk'],
      hargaProduk: json['harga-produk'],
      deskripsiProduk: json['deskripsi-produk'],
      gambarProduk: json['gambar'],
      ukuran: json['ukuran'],
    );
  }

}