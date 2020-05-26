import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/AddressUser.dart';

List<AddressUser> addressListExample1 = [
  AddressUser(
      alamat: 'Desa Toba, rumah bapak tigor',
    kabupaten: 'Toba Samosir',
    kecamatan: 'Balige',
    kode_pos: '3124',
    kota: 'Toba Samosir',
    isPrimary: true
  ),
  AddressUser(
    alamat: 'Desa Toba, rumah bapak senjata',
    kabupaten: 'Toba Samosir',
    kecamatan: 'Balige',
    kode_pos: '12310',
    kota: 'Toba Samosir',
    isPrimary: false
  ),
  AddressUser(
    alamat: 'Desa Toba, rumah bapak tani',
    kabupaten: 'Toba Samosir',
    kecamatan: 'Balige',
    kode_pos: '551212',
    kota: 'Toba Samosir'
  )
];

List<Map> _buildAddressWithWidget(bool toogleValue, toogleButton){
    List<Map> listMapResult = List<Map>();
    listMapResult = [
      {
        "address": AddressUser(
            alamat: 'Desa Toba, rumah bapak tani',
            kabupaten: 'Toba Samosir',
            kecamatan: 'Balige',
            kode_pos: '551212',
            kota: 'Toba Samosir'
        ),
        "widgetcustom" : _buildToogleButton(toogleValue, toogleButton),
      }
    ];
    return listMapResult;
}


List<AddressUser> addressListWithWidgetExample = [
  AddressUser(
      alamat: 'Desa Toba, rumah bapak tigor',
    kabupaten: 'Toba Samosir',
    kecamatan: 'Balige',
    kode_pos: '3124',
    kota: 'Toba Samosir'
  ),
  AddressUser(
    alamat: 'Desa Toba, rumah bapak senjata',
    kabupaten: 'Toba Samosir',
    kecamatan: 'Balige',
    kode_pos: '12310',
    kota: 'Toba Samosir'
  ),
  AddressUser(
    alamat: 'Desa Toba, rumah bapak tani',
    kabupaten: 'Toba Samosir',
    kecamatan: 'Balige',
    kode_pos: '551212',
    kota: 'Toba Samosir'
  )
];


Widget _buildToogleButton(bool toogleValue, toogleButton){

  return Positioned(
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
  );


}