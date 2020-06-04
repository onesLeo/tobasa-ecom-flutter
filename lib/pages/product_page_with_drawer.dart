
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/app_state.dart';
import 'package:flutter_app/pages/produk_items.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:badges/badges.dart';

class ProductPageWithDrawer extends StatefulWidget {
  final void Function() onInit;

  ProductPageWithDrawer({this.onInit});

  @override
  ProductPageWithDrawerState createState() => ProductPageWithDrawerState();
}

class ProductPageWithDrawerState extends State<ProductPageWithDrawer> {
  double xOffset = 0.0;
  double yOffset = 0.0;
  double scaleFactor = 1.0;

  void setValDrawerOpen(xOffsetPar, yOffsetPar, scaleFactorPar) {
    this.xOffset = xOffsetPar;
    this.yOffset = yOffsetPar;
    this.scaleFactor = scaleFactorPar;
  }

  bool isDrawerOpen = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.onInit();
  }

  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;

    return AnimatedContainer(
      decoration: BoxDecoration(
        gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Hexcolor('#eef4f8'), Hexcolor('#eef4f8')],
            ),
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(isDrawerOpen ? 40 : 10.0)),
      duration: Duration(milliseconds: 250),
      transform: Matrix4.translationValues(xOffset, yOffset, 0)
        ..scale(scaleFactor),
      child: StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (_, state) {
          return Column(
            children: <Widget>[
              Container(
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft:  Radius.circular(10)),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Hexcolor('#3C8CE7'), Hexcolor('#045DE9')],
                  )
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 25),
                      child: IconButton(
                        icon: (isDrawerOpen)
                            ? IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.grey[400],
                          ),
                          onPressed: () {
                            setState(() {
                              setValDrawerOpen(0.0, 0.0, 1.0);
                              isDrawerOpen = false;
                            });
                          },
                        )
                            : Icon(
                          Icons.menu,
                          color: Colors.white70,
                        ),
                        onPressed: () {
                          setState(() {
                            setValDrawerOpen(230.0, 150.0, 0.6);
                            isDrawerOpen = true;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 25),
                      child: Badge(
                        badgeContent: Text('${state.keranjangBelanja.length}',
                            style: TextStyle(fontSize: 13.0)),
                        animationType: BadgeAnimationType.fade,
                        position: BadgePosition.topRight(top: 5, right: -5),
                        badgeColor: Colors.deepPurple[500],
                        child: IconButton(
                            icon: Icon(Icons.store),
                            color: Colors.white70,
                            onPressed: () =>
                                Navigator.pushNamed(context, '/keranjangbelanja')),
                      ),
                    ),
                    SizedBox(width: 20,)
                  ],
                ),
              ),
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
    );
  }
}
