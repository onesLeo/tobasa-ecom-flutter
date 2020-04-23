import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/app_state.dart';
import 'package:flutter_app/pages/produk_items.dart';
import 'package:flutter_app/redux/actions.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:badges/badges.dart';

class ProductPage extends StatefulWidget {
  final void Function() onInit;

  ProductPage({this.onInit});

  @override
  ProductPageState createState() => ProductPageState();
}

class ProductPageState extends State<ProductPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.onInit();
  }

  final _appBar = PreferredSize(
    preferredSize: Size.fromHeight(60.0),
    child: StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, state) {
        return AppBar(
          centerTitle: true,
          title: SizedBox(
            child: state.user != null
                ? Text(state.user.username)
                : FlatButton(
                    child: Text(
                      'Daftar',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    onPressed: () =>
                        Navigator.pushNamed(context, '/registrasi'),
                  ),
          ),
          leading: state.user != null ? Badge(
            badgeContent: Text('${state.keranjangBelanja.length}', style: TextStyle(fontSize: 13.0)),
            animationType: BadgeAnimationType.fade,
            position: BadgePosition.topRight(top:5, right: -5),
            badgeColor: Colors.deepPurple[500],
            child: IconButton(icon: Icon(Icons.store), onPressed: () => Navigator.pushNamed(context, '/keranjangbelanja')),)
              : Text(''),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 12.0),
                child: StoreConnector<AppState, VoidCallback>(
                  converter: (store) {
                    return () => store.dispatch(logOutAction);
                  },
                  builder: (_, callback) {
                    return state.user != null
                        ? IconButton(
                            icon: Icon(Icons.exit_to_app),
                            onPressed: callback,
                          )
                        : Text('');
                  },
                )),
          ],
        );
      },
    ),
  );

  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      appBar: _appBar,
      body: Container(
        child: StoreConnector<AppState, AppState>(
          converter: (store) => store.state,
          builder: (_, state) {
            return Column(
              children: <Widget>[
                Expanded(
                  child: SafeArea(
                    top: false,
                    bottom: false,
                    child: GridView.builder(
                      itemCount: state.produk.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              orientation == Orientation.portrait ? 2 : 3,
                          crossAxisSpacing: 4.0,
                          mainAxisSpacing: 4.0,
                          childAspectRatio:
                              orientation == Orientation.portrait ? 1.0 : 1.3),
                      itemBuilder: (context, i) =>
                          ProdukItems(item: state.produk[i]),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
