import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/initsmodel/InitializationDummyData.dart';
import 'package:flutter_app/models/CheckoutProduk.dart';
import 'package:flutter_app/models/UserEcom.dart';
import 'package:flutter_app/models/app_state.dart';
import 'package:flutter_app/models/produk.dart';
import 'package:flutter_app/pages/produk_items.dart';
import 'package:flutter_app/pages/summary_purchasing.dart';
import 'package:flutter_counter/flutter_counter.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:logging/logging.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class KeranjangBelanja extends StatefulWidget {
  final void Function() onInit;

  KeranjangBelanja({this.onInit});

  @override
  KeranjangBelanjaState createState() => KeranjangBelanjaState();
}

class KeranjangBelanjaState extends State<KeranjangBelanja> {
  final Logger log = Logger('KeranjangBelanjaState');

  @override
  void initState() {
    super.initState();
    widget.onInit();
  }

  Widget _tabKeranjangBelanja() {
    final Orientation orientation = MediaQuery.of(context).orientation;
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

  Widget _tabAlamatUsers() {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (_, state) {
        return Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 10.0),
            ),
            RaisedButton(
              elevation: 8.0,
              child: Text('Tambah Alamat'),
              onPressed: () => Navigator.pushNamed(context, '/isi_alamat'),
            ),
            Expanded(
                child: Column(
              children: <Widget>[
//                Text(state.userInformation.username),
//                Text(state.userInformation.nomor_telepon),
                ListView(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    children: state.userInformation.address_user
                        .map<Widget>((alamat) => (ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.orange,
                                child: Icon(
                                  Icons.home,
                                  color: Colors.white,
                                ),
                              ),
                              title: Text(
                                " ${alamat.alamat} \n ${alamat.kabupaten} \n ${alamat.kecamatan} \n ${alamat.kota} \n ${alamat.kode_pos}",
                              ),
                              trailing: alamat.isPrimary
                                  ? Chip(
                                      avatar: CircleAvatar(
                                        backgroundColor: Colors.green,
                                        child: Icon(
                                          Icons.check_circle,
                                          color: Colors.white,
                                        ),
                                      ),
                                      label: Text('Alamat Utama'),
                                    )
                                  : FlatButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0))),
                                      child: Text(
                                        'Pilih',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.deepOrange[200]),
                                      ),
                                      onPressed: () => print("Pressed"),
                                    ),
                            )))
                        .toList()),
              ],
            ))
          ],
        );
      },
    );
  }

  Widget _tabHistoriBelanja(AppState state) {
    InitializationDummyData initData = InitializationDummyData();
    CheckoutProduk checkoutProduk = initData.checkOutItemDummyData();

    return Expanded(
      child: Row(
        children: <Widget>[],
      ),
    );
  }

  Widget _tabHistoryBelanja() {
    return Text('Test');
  }

  Widget _tabHistoriBelanjaNew(state) {
    InitializationDummyData initData = InitializationDummyData();
    CheckoutProduk checkoutProduk = initData.checkOutItemDummyData();

    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (_, state) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: ListView.separated(
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                  scrollDirection: Axis.vertical,
                  itemCount: checkoutProduk.produk_checkout.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Stack(
                        children: <Widget>[
                          Positioned(
                            child: Image.network(
                              '${checkoutProduk.produk_checkout[index].link_to_item}',
                              height: 50.0,
                            ),
                          )
                        ],
                      ),
                      title: Row(
                        children: <Widget>[
                          Expanded(
                              child: Column(
                            children: <Widget>[
                              Align(
                                child: Text(
                                  '${checkoutProduk.produk_checkout[index].nama_produk}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                alignment: Alignment.centerLeft,
                              ),
                              Align(
                                child: Text(
                                  '${checkoutProduk.produk_checkout[index].harga_produk}',
                                ),
                                alignment: Alignment.centerLeft,
                              ),
                            ],
                          ))
                        ],
                      ),
                    );
                  }),
            ),
          ],
        );
      },
    );
  }

  Widget _columnAlamat() {
    return Column(
      children: <Widget>[],
    );
  }

  String _hitungTotalHarga(List<Produk> produkInCart) {
    int totalBelanja = 0;

    produkInCart.forEach((element) {
      totalBelanja += element.hargaProduk;
    });

    return totalBelanja.toString();
  }

  _showDialogBottomSheetOfCheckout(BuildContext context, AppState state) {
    num _counter = 0;
    num _defaultValue = 0;

    showModalBottomSheet(
        context: context,
        builder: (BuildContext ctx) {
          return Container(
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                color: Hexcolor('#eef4f8').withOpacity(0.9),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(30)),
              ),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Text('Ringkasan Pembelian!'),
                    ),
                    Divider(),
                    Column(
                      children: state.keranjangBelanja
                          .map((e) => new SummaryPurchasing(item: e,))
                          .toList(),
                    ),
                  ],
                )
              ),
            ),
          );
        });
  }

  Future _checkOutDialog(AppState state) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          String summary = '';
          state.keranjangBelanja.forEach((element) {
            summary += '. ${element.namaProduk}, Rp. ${element.hargaProduk} \n';
          });

          return AlertDialog(
            title: Text('Checkout'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                    'Total items ${state.keranjangBelanja.length} \n',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text(
                    '${summary}',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text(
                    'Detail Kartu \n',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text(
                    'Nomor Kartu ',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text(
                    'Expiry ',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text(
                    '',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text(
                    'Total Belanja : ${_hitungTotalHarga(state.keranjangBelanja)}',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.pop(context, false),
                color: Colors.red,
                child: Text(
                  'Tutup',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              RaisedButton(
                onPressed: () => Navigator.pop(context, true),
                color: Colors.green,
                child: Text(
                  'Checkout',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          );
        }).then((value) {
      if (value == true) {
        _checkAddressUser(state);
        print('Checkout triggered');
      }
    });
  }

  _checkAddressUser(AppState state) {
    print('User who triggered checkout - ${state.user.username}');
    Stream<DocumentSnapshot> snapshot = Firestore.instance
        .collection('user_ecom')
        .document(state.user.id)
        .snapshots();
    snapshot.forEach((element) {
      print(element.data);
      UserEcom userEcom = UserEcom.fromJson(element.data);
      if (userEcom.address_user.isEmpty) {
        log.info('Address user is Empty');
        Alert(
            context: context,
            title: 'Alamat Kosong',
            type: AlertType.info,
            desc: 'Klik tombol berikut untuk isi alamat!',
            style: AlertStyle(
                backgroundColor: Colors.lightBlue[200],
                animationType: AnimationType.shrink,
                titleStyle: TextStyle(
                  backgroundColor: Colors.white12,
                  fontStyle: FontStyle.normal,
                  fontSize: 20.0,
                )),
            buttons: [
              DialogButton(
                child: Text(
                  'Isi Alamat',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                onPressed: () {
                  log.info('redirect to isi_alamat page!');
                  Navigator.pushNamed(context, '/isi_alamat');
                },
                color: Colors.cyan[200],
                radius: BorderRadius.circular(20.0),
              )
            ]).show();
      } else {
        print('Alamat is not Empty and proceed with check out');
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
                floatingActionButton: state.keranjangBelanja.length > 0
                    ? FloatingActionButton(
                        child: Icon(
                          Icons.local_atm,
                          size: 30.0,
                        ),
//                      onPressed: () => _checkOutDialog(state),
                        onPressed: () =>
                            _showDialogBottomSheetOfCheckout(context, state),
                      )
                    : Text(''),
                appBar: GradientAppBar(
                  elevation: 4,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Hexcolor('#3C8CE7'), Hexcolor('#045DE9')],
                  ),
                  title: Text(
                    'Summary: item ${state.keranjangBelanja.length}, Total : ${_hitungTotalHarga(state.keranjangBelanja)}',
                    style: TextStyle(fontSize: 15.0),
                  ),
                  bottom: TabBar(
                    labelColor: Colors.lightBlueAccent[500],
                    unselectedLabelColor: Colors.lightBlueAccent[900],
                    tabs: <Widget>[
                      Tab(icon: Icon(Icons.shopping_cart)),
                      Tab(icon: Icon(Icons.home)),
                      Tab(icon: Icon(Icons.receipt)),
                    ],
                  ),
                ),
                body: Stack(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [Colors.blue[50], Colors.grey[100]],
                      )),
                    ),
                    TabBarView(
                      children: <Widget>[
                        _tabKeranjangBelanja(),
                        _tabAlamatUsers(),
                        _tabHistoriBelanjaNew(state),
                      ],
                    ),
                  ],
                )),
          );
        });
  }
}
