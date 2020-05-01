import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/UserEcom.dart';
import 'package:flutter_app/models/app_state.dart';
import 'package:flutter_app/models/produk.dart';
import 'package:flutter_app/pages/produk_items.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:logging/logging.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class KeranjangBelanja extends StatefulWidget {
  @override
  KeranjangBelanjaState createState() => KeranjangBelanjaState();
}

class KeranjangBelanjaState extends State<KeranjangBelanja> {
  final Logger log = Logger('KeranjangBelanjaState');

  Widget _tabKeranjangBelanja() {
    final Orientation orientation = MediaQuery
        .of(context)
        .orientation;
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (_, state) {
        return Column(
          children: <Widget>[
            Expanded(
              child: SafeArea(
                top: false,
                bottom: false,
                child: GridView.builder(
                  itemCount: state.keranjangBelanja.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:
                      orientation == Orientation.portrait ? 2 : 3,
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 4.0,
                      childAspectRatio:
                      orientation == Orientation.portrait ? 1.0 : 1.3),
                  itemBuilder: (context, i) =>
                      ProdukItems(item: state.keranjangBelanja[i]),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  Widget _tabKartuKredit() {
    return Text('Tab Kartu Kredit');
  }

  Widget _tabBelanja(state) {
//    return ListView(
//      children: <Widget>[
//        state.orders.length > 0 ? state.orders.map<widget>((orders))
//      ],
//    );
  return Text('Tab Belaja');
  }

  Widget _columnAlamat(){
    return Column(
      children: <Widget>[

      ],
    );
}

  String _hitungTotalHarga(List<Produk> produkInCart){
    int totalBelanja = 0;

    produkInCart.forEach((element) {
      totalBelanja += element.hargaProduk;
    });

    return totalBelanja.toString();
  }

  Future _checkOutDialog(AppState state){


    return showDialog(context: context,
    builder: (BuildContext context){
//      if(state.cards.length == 0){
//        return AlertDialog(
//          title: Row(
//            children: <Widget>[
//              Padding(
//                padding: EdgeInsets.only(right: 10.0),
//                child: Text('Tambah Kartu'),
//              ),
//              Icon(Icons.credit_card, size: 60.0,)
//            ],
//          ),
//          content: SingleChildScrollView(
//            child: ListBody(
//              children: <Widget>[
//                Text('Input Kartu Kredit terlebih dahulu!', style: Theme.of(context).textTheme.bodyText1,)
//              ],
//            ),
//          ),
//        );
//      }
      String summary = '';
      state.keranjangBelanja.forEach((element) {
        summary += '. ${element.namaProduk}, Rp. ${element.hargaProduk} \n';
      });

      return AlertDialog(
        title: Text('Checkout'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Total items ${state.keranjangBelanja.length} \n', style: Theme.of(context).textTheme.bodyText1,),
              Text('${summary}', style: Theme.of(context).textTheme.bodyText1,),
              Text('Detail Kartu \n', style: Theme.of(context).textTheme.bodyText1,),
              Text('Nomor Kartu ', style: Theme.of(context).textTheme.bodyText1,),
              Text('Expiry ', style: Theme.of(context).textTheme.bodyText1,),
              Text('', style: Theme.of(context).textTheme.bodyText1,),
              Text('Total Belanja : ${_hitungTotalHarga(state.keranjangBelanja)}', style: Theme.of(context).textTheme.bodyText1,),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.pop(context,false) ,
            color: Colors.red,
            child: Text('Tutup', style: TextStyle(color: Colors.white),),
          ),
          RaisedButton(onPressed: ()=> Navigator.pop(context,true), color: Colors.green,
          child: Text('Checkout', style: TextStyle(color: Colors.white ),),)
        ],
      );
    }).then((value) {
      if(value == true){
        _checkAddressUser(state);
        print('Checkout triggered');
      }
    });
  }

  _checkAddressUser(AppState state){
    print('User who triggered checkout - ${state.user.username}');
    Stream<DocumentSnapshot> snapshot = Firestore.instance.collection('user_ecom').document(state.user.id).snapshots();
    snapshot.forEach((element) {
      print(element.data);
      UserEcom userEcom = UserEcom.fromJson(element.data);
      if(userEcom.address_user.isEmpty){
        log.info('Address user is Empty');
        Alert(
          context: context,
          title: 'Alamat Kosong',

        ).show();
      }
    });
  }

  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (_, state) {
          return DefaultTabController(
            length: 3,
            initialIndex: 0,
            child: Scaffold(
              floatingActionButton: state.keranjangBelanja.length > 0 ?
              FloatingActionButton(
                child: Icon(Icons.local_atm, size: 30.0,) ,
                onPressed: () => _checkOutDialog(state),
              ) : Text(''),
              appBar: AppBar(
                title: Text('Summary: item ${state.keranjangBelanja.length}, Total : ${_hitungTotalHarga(state.keranjangBelanja)}',
                  style: TextStyle(fontSize: 15.0) ,),
                bottom: TabBar(
                  labelColor: Colors.lightBlueAccent[500],
                  unselectedLabelColor: Colors.lightBlueAccent[900],
                  tabs: <Widget>[
                    Tab(icon: Icon(Icons.shopping_cart)),
                    Tab(icon: Icon(Icons.credit_card)),
                    Tab(icon: Icon(Icons.receipt)),
                  ],
                ),
              ),
              body: TabBarView(
                children: <Widget>[
                  _tabKeranjangBelanja(),
                  _tabKartuKredit(),
                  _tabBelanja(state),
                ],
              ),
            ),
          );
        });
  }
}