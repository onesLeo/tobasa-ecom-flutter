
import 'package:flutter_app/models/produk.dart';
import 'package:flutter_app/users/user.dart';
import 'package:meta/meta.dart';

@immutable
class AppState {
  final User user;
  final List<Produk> produk;
  final List<Produk> keranjangBelanja;

  AppState({@required this.user, @required this.produk, @required this.keranjangBelanja });

  factory AppState.initial(){
    return AppState(
      user: null,
      produk: [],
      keranjangBelanja: []
    );
  }

}