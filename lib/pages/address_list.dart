import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/initsmodel/address_example.dart';
import 'package:flutter_app/models/AddressUser.dart';
import 'package:flutter_app/models/app_state.dart';
import 'package:flutter_app/utilities/constant_utils.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:hexcolor/hexcolor.dart';

class AddressListScreen extends StatefulWidget {
  @override
  _AddressListScreenState createState() => _AddressListScreenState();
}

class _AddressListScreenState extends State<AddressListScreen> {

  bool toogleValue = false;

  Widget _fetchingAddressList(){

    return StoreConnector<AppState,AppState>(
      converter: (store) => store.state,
      builder: (_, state){
        return Column(
          children: <Widget>[
            SizedBox(height: 10,),
            ListView.separated(
              separatorBuilder: (BuildContext context, int index) => SizedBox(height: 10,),
              padding: EdgeInsets.all(10),
              scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: addressListExample1.length ,
                itemBuilder: (context, index){
                  return  Stack(
                    children: <Widget>[
                      Container(
                        height: 150,
                        width: double.infinity,
                        decoration: kBoxDecorationStyle,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Wrap(
                              children: [
                                Text('${addressListExample1[index].alamat},  '),
                                Text('${addressListExample1[index].kode_pos}, '),
                                Text('${addressListExample1[index].kecamatan}, '),
                                Text('${addressListExample1[index].kabupaten}, '),
                                Text('${addressListExample1[index].kota}')
                              ]
                          ),
                        ),
                      ),
                      Positioned(
                        child: AnimatedContainer(
                            duration: Duration(milliseconds: 1000),
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: toogleValue ? Colors.greenAccent[100].withOpacity(0.5): Colors.redAccent[100].withOpacity(0.5)
                            ),
                            child: Stack(
                              children: <Widget>[
                                AnimatedPositioned(
                                  duration: Duration(milliseconds: 1000),
                                  curve: Curves.easeIn,
                                  top: 3.0,
                                  left : toogleValue? 60.0 :0.0,
                                  right : toogleValue? 0.0 : 60.0 ,
                                  child: InkWell(
                                    onTap: toogleButton,
                                    child: AnimatedSwitcher(
                                      duration: Duration(milliseconds: 1000),
                                      child: toogleValue? Icon(Icons.check_circle, color: Colors.green, size: 35, key: UniqueKey(),) :
                                      Icon(Icons.remove_circle_outline, color: Colors.red, size: 35, key: UniqueKey(),),
                                      transitionBuilder: (Widget child, Animation<double> animation){

                                        return ScaleTransition(
                                          child: child, scale: animation,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            )
                        ) ,
                        top: 100,
                        left: 280,
                      )
                    ],
                  );
                }
            ),

          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: GradientAppBar(
//          title: Text('Isi Alamat'),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(FontAwesomeIcons.plus),
              onPressed: ()=> Navigator.pushNamed(context, '/add_address'),
            )
          ],
        ),
        body: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Hexcolor('#3C8CE7'), Colors.blue],
                  )),
            ),
            _fetchingAddressList(),

          ],
        )
        );
  }

  toogleButton(){
    setState(() {
      toogleValue = !toogleValue;
    });
  }

}
