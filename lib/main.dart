import 'package:flutter/material.dart';
import 'package:flutter_app/models/app_state.dart';
import 'package:flutter_app/pages/alamat_form.dart';
import 'package:flutter_app/pages/keranjang_belanja.dart';
import 'package:flutter_app/pages/login_existing_user.dart';
import 'package:flutter_app/pages/product_page.dart';
import 'package:flutter_app/pages/registrasi.dart';
import 'package:flutter_app/redux/actions.dart';
import 'package:flutter_app/redux/reducers.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';

void main() {
  final store = Store<AppState>(appReducer, initialState: AppState.initial(),
      middleware: [thunkMiddleware, LoggingMiddleware.printer()]);
  runApp(MyApp(store: store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;

  MyApp({this.store});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StoreProvider(
        store: store,
        child: MaterialApp(
      routes: {
        '/login' : (BuildContext context) => LoginExistingUser(),
        '/' : (BuildContext context) => ProductPage(
          onInit: () {
            StoreProvider.of<AppState>(context).dispatch(getUserAction);
            StoreProvider.of<AppState>(context).dispatch(getProdukActionFireStoreDB);
            StoreProvider.of<AppState>(context).dispatch(getKeranjangAction);
          },
        ),
        '/registrasi' : (BuildContext context) => Registrasi(),
        '/keranjangbelanja' : (BuildContext context) => KeranjangBelanja(
          onInit: () {
            StoreProvider.of<AppState>(context).dispatch(getUserInformation);
          },
        ),
        '/isi_alamat' : (BuildContext context) => AlamatForm(),
      },
      title: 'Tobasa E-Com Mantap!',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        brightness: Brightness.dark,
        primaryColor: Colors.cyan[400],
        accentColor: Colors.lightBlue[100],
        textTheme: TextTheme(
          headline5:  TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 18.0)

        ),
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
//      home: Registrasi(),
    ));

  }
}

