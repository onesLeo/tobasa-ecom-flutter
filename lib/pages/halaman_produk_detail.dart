import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/app_state.dart';
import 'package:flutter_app/models/produk.dart';
import 'package:flutter_app/redux/actions.dart';
import 'package:flutter_redux/flutter_redux.dart';

class HalamanProdukDetail extends StatelessWidget {
  final Produk item;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final gradientBackground = BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          stops: [
            0.1,
            0.3,
            0.5,
            0.7,
            0.9
          ],
          colors: [
            Colors.grey[300],
            Colors.grey[400],
            Colors.grey[500],
            Colors.grey[600],
            Colors.grey[700],
          ]
      )
  );

  bool _isInCart(AppState state, String id) {
    final List<Produk> listProduk = state.keranjangBelanja;
    return listProduk.indexWhere((produk) => produk.id == id) > -1;
  }

  HalamanProdukDetail({this.item});

  @override
  Widget build(BuildContext context) {
    final String pictureUrl = 'http://127.0.0.1:1337${item
        .gambarProduk['url']}';
    final Orientation orientation = MediaQuery
        .of(context)
        .orientation;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(item.namaProduk),
      ),
      body: Container(
        decoration: gradientBackground,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Hero(
                  tag: item,
                  child: Image.network(pictureUrl,
                    fit: BoxFit.cover,
                    width: orientation == Orientation.portrait ? 600 : 250,
                    height: orientation == Orientation.portrait ? 400 : 200,
                  )),
            ),
            Text(item.namaProduk, style: Theme
                .of(context)
                .textTheme
                .headline6,),
            Text('Rp. ${item.hargaProduk}', style: Theme
                .of(context)
                .textTheme
                .bodyText1,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.0),
              child: StoreConnector<AppState, AppState>(
                converter: (store) => store.state,
                builder: (_, state) {
                  return state.user != null ?
                  IconButton(
                      icon: Icon(Icons.shopping_cart),
                      color: _isInCart(state, item.id) == true ? Colors
                          .blue[400] : Colors.white,
                      onPressed: (){
                      StoreProvider.of<AppState>(context).dispatch(pencetKeranjangProdukAction(item));
                      final snackBar = SnackBar(
                        duration: Duration(seconds: 2),
                        content: Text('Keranjang Belanja Diupdate',style: TextStyle(color: Colors.greenAccent[700] ),),
                      );

                      _scaffoldKey.currentState.showSnackBar(snackBar);
                  }
                  ) : Text('');
                },
              ),
            ),
            Flexible(
                child: SingleChildScrollView(
                    child: Padding(
                      child: Text(item.deskripsiProduk),
                      padding: EdgeInsets.only(
                          left: 32.0, right: 32.0, bottom: 32.0),
                    )))
          ],
        ),
      ),
    );
  }
}