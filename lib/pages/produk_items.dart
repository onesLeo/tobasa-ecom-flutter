import 'package:flutter/material.dart';
import 'package:flutter_app/models/app_state.dart';
import 'package:flutter_app/models/produk.dart';
import 'package:flutter_app/pages/halaman_produk_detail.dart';
import 'package:flutter_app/redux/actions.dart';
import 'package:flutter_redux/flutter_redux.dart';

class ProdukItems extends StatelessWidget{
  final dynamic item;

  ProdukItems({this.item});

  bool _isInCart(AppState state, String id){
      final List<Produk> listProduk =  state.keranjangBelanja;
      return listProduk.indexWhere((produk) => produk.id == id) > -1;
  }

  @override
  Widget build(BuildContext context) {
    final String pictureUrl = 'http://127.0.0.1:1337${item.gambarProduk['url']}';
    return InkWell(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context){
            return HalamanProdukDetail(item: item);
          }
        )
      ),
      child:
      GridTile(
      child: Hero(
        tag: item,
        child: Image.network(pictureUrl, fit: BoxFit.cover)),
      footer: GridTileBar(
        title: FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Text(item.namaProduk, style: TextStyle(fontSize: 20.0),),
        ),
        subtitle: Text("Rp. ${item.hargaProduk}",style: TextStyle(fontSize: 16.0),),
        backgroundColor: Colors.black38,
        trailing: StoreConnector<AppState, AppState>(
          converter: (store) => store.state,
          builder: (_, state){
            return state.user != null ?
            IconButton(
              icon: Icon(Icons.shopping_cart), color: _isInCart(state, item.id) == true ? Colors.blue[400] : Colors.white ,
            onPressed: ()=> {
              StoreProvider.of<AppState>(context).dispatch(pencetKeranjangProdukAction(item))
            },) : Text('');
          },
        ),
      ),
    ),);
  }
}