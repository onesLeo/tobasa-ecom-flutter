import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/app_state.dart';
import 'package:flutter_app/redux/actions.dart';
import 'package:flutter_app/utilities/constant_utils.dart';
import 'package:flutter_app/utilities/menu_class.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:logging/logging.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  final Logger log = Logger('_DrawerScreenState');

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, state) {
        return Container(
            padding: EdgeInsets.all(30),
            decoration: BoxDecoration(
//          color: Colors.white,
                color: Hexcolor('#385e5f'),
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    CircleAvatar(),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          state.user.username,
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Active Status',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Roboto',
                              fontSize: 13,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ],
                ),
                Column(
                  children: profileSection
                      .map((e) => Padding(
                          padding: EdgeInsets.all(8.0),
                          child: FlatButton(
                            child: Row(
                              children: <Widget>[
                                Icon(e['icon']),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  e['title'],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                )
                              ],
                            ),
                            onPressed: () {
                              print("Url to Go ${e['url']}");
//                  Navigator-.pushNamed(context, e['url']);
                            },
                          )))
                      .toList(),
                ),
                Row(
                  children: <Widget>[
                    FlatButton(
                        child: StoreConnector<AppState, VoidCallback>(
                      converter: (store) {
                        return () => store.dispatch(logOutAction);
                      },
                      builder: (_, callback) {
                        return state.user != null
                            ? IconButton(
                                icon: Icon(FontAwesomeIcons.signOutAlt),
                                onPressed: () => {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context){
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(25.0))),
                                        backgroundColor: Colors.blueGrey,
                                        title: Text('Keluar!'),
                                        actions: <Widget>[
                                          FlatButton(child: Text('Ya', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),), onPressed: () => Navigator.pushReplacementNamed(context, '/login'),),
                                          FlatButton(child: Text('Tidak', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)), onPressed: ()=> Navigator.pop(context),)
                                        ],
                                        content: Text('Anda yakin akan keluar?'),
                                      );
                                    }
                                  )
                                },
                              )
                            : Text('');
                      },
                    )),
                  ],
                ),
              ],
            ));
      },
    );
  }
}
