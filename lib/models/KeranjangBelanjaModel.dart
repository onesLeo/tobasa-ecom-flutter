import 'package:flutter/cupertino.dart';
import 'package:flutter_app/models/ItemIncart.dart';

import 'UserInf.dart';

class KeranjangBelanjaModel {
    String keranjangId;
    List<ItemIncart> item_incart;
    UserInf user_inf;

    KeranjangBelanjaModel({
        @required this.keranjangId,
        @required this.item_incart,
        @required this.user_inf
    });

    factory KeranjangBelanjaModel.fromJson(Map<String, dynamic> json) {
        return KeranjangBelanjaModel(
            item_incart: json['item_incart'] != null ? (json['item_incart'] as List).map((i) => ItemIncart.fromJson(i)).toList() : null,
            user_inf: json['user_inf'] != null ? UserInf.fromJson(json['user_inf']) : null, 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        if (this.item_incart != null) {
            data['item_incart'] = this.item_incart.map((v) => v.toJson()).toList();
        }
        if (this.user_inf != null) {
            data['user_inf'] = this.user_inf.toJson();
        }
        return data;
    }
}