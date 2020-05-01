import 'package:flutter/cupertino.dart';

class UserInf {
    String uid;
    String email;
    String name;

    UserInf({
        @required this.uid,
        @required this.email,
        @required this.name
    });

    factory UserInf.fromJson(Map<String, dynamic> json) {
        return UserInf(
            uid: json['uid'],
            email: json['email'],
            name: json['name'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['uid'] = this.uid;
        data['email'] = this.email;
        data['name'] = this.name;
        return data;
    }
}