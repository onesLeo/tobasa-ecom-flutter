
import 'dart:convert';
import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_app/models/app_state.dart';
import 'package:flutter_app/models/produk.dart';
import 'package:flutter_app/users/user.dart';
import 'package:http/http.dart' as http;
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

ThunkAction<AppState> getUserAction = (Store<AppState> store) async{
    final sharedPref = await SharedPreferences.getInstance();
    final String userStored = sharedPref.getString('user');
    final user = userStored != null ? User.fromJson(json.decode(userStored)): null;
    store.dispatch(GetUserAction(user));
};

ThunkAction<AppState> getProdukAction = (Store<AppState> store) async{
  http.Response response = await http.get('http://127.0.0.1:1337/produks');
  final List<dynamic> responseData = json.decode(response.body);
  List<Produk> listProduk = [];
  print('responseData length - ${responseData.length}');
  responseData.forEach((productIt) {
    final Produk produk = Produk.fromJson(productIt);
    listProduk.add(produk);
  });
  store.dispatch(GetProdukAction(listProduk));
};

ThunkAction<AppState> logOutAction = (Store<AppState> store) async{
  final sharedPref = await SharedPreferences.getInstance();
  await sharedPref.remove('user');
  User user;
  store.dispatch(LogOutUserAction(user));
};


ThunkAction<AppState> pencetKeranjangProdukAction(Produk produk){
//  print('produk name picked up ${produk.namaProduk}');
  return (Store<AppState> store) async {
    print('Produk size ${store.state.produk.length}');
    final User user = store.state.user;
    final List<Produk> keranjangProdukDipilih = store.state.keranjangBelanja;
    final int idx = keranjangProdukDipilih.indexWhere((produkIdx) => produkIdx.id == produk.id);
    bool isInCart = idx > -1 == true;
    List<Produk> updateKeranjang = List.from(keranjangProdukDipilih);
    if(isInCart){
      updateKeranjang.removeAt(idx);
    }else{
      updateKeranjang.add(produk);
    }

    final List<String> keranjangProdukId = updateKeranjang.map((e) => e.id).toList();
    await http.put('http://127.0.0.1:1337/keranjangusers/${user.keranjangId}', body: {
      "produk": json.encode(keranjangProdukId)
    }, headers: {
      'Authorization' : 'Bearer ${user.jwt}'
    });

    print('Update Keranjang Length - ${updateKeranjang.length}');
    store.dispatch(KeranjangBelanjaAction(updateKeranjang));
  };
}



ThunkAction<AppState> getKeranjangAction = (Store<AppState> store) async{
  final sharedPref = await SharedPreferences.getInstance();
  final String userStored = sharedPref.getString('user');
  if(userStored == null){
    return;
  }

  final User user = User.fromJson(json.decode(userStored));
  print('USER JWT > ${user.jwt} and USER ID > ${user.keranjangId}');

  http.Response response = await http.get('http://127.0.0.1:1337/keranjangusers/${user.keranjangId}', headers: {
    'Authorization' : 'Bearer ${user.jwt}'
  });

  final responseData = json.decode(response.body)['produk'];
  print('Keranjang User -> ${responseData}');
  List<Produk> keranjangBelanjaUser = [];
  responseData.forEach((dataProduk){
    final Produk produk = Produk.fromJson(dataProduk);
    keranjangBelanjaUser.add(produk);
  });
  
  store.dispatch(GetKeranjangBelanjaAction(keranjangBelanjaUser));

};



ThunkAction<AppState> getProdukActionFireBaseDB = (Store<AppState> store) async{
    final FirebaseDatabase _firebaseDatabase = FirebaseDatabase.instance;
    final DatabaseReference _databaseReference = _firebaseDatabase.reference();
    Future<DataSnapshot> _result = _databaseReference.child('produk').once();
    List<Produk> listOfResults = [];
    _result.then((value) {
      List<dynamic> listValue = value.value;
      listValue.forEach((element) {
        Produk produk = Produk.fromJsonFirebase(element);
        print('Produk nama ${produk.namaProduk}');
        listOfResults.add(produk);
      });
    } );
    store.dispatch(GetProdukAction(listOfResults));
};

class GetUserAction{
  final User _user;

  User get user => this._user;

  GetUserAction(this._user);
}

class LogOutUserAction{
  final User _user;

  User get user => this._user;

  LogOutUserAction(this._user);
}

class GetProdukAction{
  final List<Produk> _produk;
  List<Produk> get produk => this._produk;

  GetProdukAction(this._produk);
}

class KeranjangBelanjaAction{
  final List<Produk> _listKeranjangBelanja;
  List<Produk> get keranjangBelanja => this._listKeranjangBelanja;

  KeranjangBelanjaAction(this._listKeranjangBelanja);
}

class GetKeranjangBelanjaAction{
  final List<Produk> _listKeranjangBelanja;
  List<Produk> get keranjangBelanja => this._listKeranjangBelanja;

  GetKeranjangBelanjaAction(this._listKeranjangBelanja);
}