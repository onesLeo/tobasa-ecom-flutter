import 'package:flutter/cupertino.dart';

import 'AddressUser.dart';

class UserEcom {
    List<AddressUser> address_user;
    String email;
    String nomor_telepon;
//    String uid;
    String username;

    UserEcom({
        this.address_user,
        this.nomor_telepon,
        @required this.email,
//        @required this.uid,
        @required this.username
    });

    factory UserEcom.fromJson(Map<String, dynamic> json) {
        return UserEcom(
            address_user: json['address_user'] != null ? (json['address_user'] as List).map((i) => AddressUser.fromJson(i)).toList() : null, 
            email: json['email'], 
            nomor_telepon: json['nomor_telepon'], 
//            uid: json['uid'],
            username: json['username'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['email'] = this.email;
        data['nomor_telepon'] = this.nomor_telepon;
//        data['uid'] = this.uid;
        data['username'] = this.username;
        if (this.address_user != null) {
            data['address_user'] = this.address_user.map((v) => v.toJson()).toList();
        }
        return data;
    }
}