import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/app_state.dart';
import 'package:flutter_app/pages/produk_items.dart';
import 'package:flutter_redux/flutter_redux.dart';

class KeranjangBelanja extends StatefulWidget{
  @override
  KeranjangBelanjaState createState() => KeranjangBelanjaState();
}

class KeranjangBelanjaState extends State<KeranjangBelanja>{

  Widget _tabKeranjangBelanja(){
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

  Widget _tabKartuKredit(){
    return Text('Tab Kartu Kredit');
  }

  Widget _tabBelanja(){
    return Text('Tab Belanja');
  }

  Widget build(BuildContext context){
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Keranjang Belanja'),
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
            _tabBelanja(),
          ],
        ),
      ),
    );
  }
}