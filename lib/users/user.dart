import 'package:meta/meta.dart';

class User{
  String id;
  String username;
  String email;
  String jwt;
  String keranjangId;

  User({@required this.id,
    @required this.username,
    @required this.email,
    @required this.keranjangId,
    @required this.jwt
  });

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      id: json['_id'],
      username: json['username'],
      email: json['email'],
//      keranjangId: json['keranjang_id'],
//      jwt: json['jwt']
    );
  }
}