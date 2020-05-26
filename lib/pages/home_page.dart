import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/app_state.dart';
import 'package:flutter_app/pages/drawer_screen.dart';
import 'package:flutter_app/pages/product_page_with_drawer.dart';
import 'package:flutter_app/redux/actions.dart';
import 'package:flutter_redux/flutter_redux.dart';

class HomePage extends StatefulWidget {
  final void Function() onInit;

  HomePage({this.onInit});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.onInit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Stack(
       children: <Widget>[
         DrawerScreen(),
         ProductPageWithDrawer(
             onInit: () {
               StoreProvider.of<AppState>(context).dispatch(getUserAction);
               StoreProvider.of<AppState>(context).dispatch(getProdukActionFireStoreDB);
               StoreProvider.of<AppState>(context).dispatch(getKeranjangAction);
             }
         )
       ],
     ),
    );
  }
}
