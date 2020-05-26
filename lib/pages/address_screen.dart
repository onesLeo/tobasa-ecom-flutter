import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/utilities/constant_utils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:hexcolor/hexcolor.dart';

class AddressScreen extends StatefulWidget {
  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {

  Widget _buildPhoneNumInputText(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('No. Telepon', style: kLabelStyle,),
        SizedBox(height: 10,),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            keyboardType: TextInputType.phone,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(
                  FontAwesomeIcons.phoneAlt,
                  color: Colors.white,
                ),
                hintText: 'Masukkan Nomor HP anda',
                hintStyle: kHintTextStyle
            ),
          ),
        )

      ],
    );
  }

  Widget _buildKabupatenInputText(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Kabupaten', style: kLabelStyle,),
        SizedBox(height: 10,),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            keyboardType: TextInputType.text,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(
                  FontAwesomeIcons.home,
                  color: Colors.white,
                ),
                hintText: 'Masukkan Kabupaten',
                hintStyle: kHintTextStyle
            ),
          ),
        )

      ],
    );
  }

  Widget _buildKotaInputText(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Kota', style: kLabelStyle,),
        SizedBox(height: 10,),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            keyboardType: TextInputType.text,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(
                  FontAwesomeIcons.home,
                  color: Colors.white,
                ),
                hintText: 'Masukkan Kota',
                hintStyle: kHintTextStyle
            ),
          ),
        )

      ],
    );
  }

  Widget _buildKodePosInputText(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Kode Pos', style: kLabelStyle,),
        SizedBox(height: 10,),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            keyboardType: TextInputType.number,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(
                  FontAwesomeIcons.home,
                  color: Colors.white,
                ),
                hintText: 'Masukkan Kode Pos',
                hintStyle: kHintTextStyle
            ),
          ),
        )

      ],
    );
  }

  Widget _buildKecamatanInputText(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Kecamatan', style: kLabelStyle,),
        SizedBox(height: 10,),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            keyboardType: TextInputType.text,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(
                  FontAwesomeIcons.home,
                  color: Colors.white,
                ),
                hintText: 'Masukkan Kecamatan',
                hintStyle: kHintTextStyle
            ),
          ),
        )

      ],
    );
  }

  Widget _buildAlamatLengkapInputText(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Alamat Lengkap', style: kLabelStyle,),
        SizedBox(height: 10,),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            keyboardType: TextInputType.text,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(
                  FontAwesomeIcons.home,
                  color: Colors.white,
                ),
                hintText: 'Masukkan Alamat Lengkap',
                hintStyle: kHintTextStyle
            ),
          ),
        )

      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GradientAppBar(
          title: Text('Isi Alamat'),
          centerTitle: true,
        ),
        body: Container(
          height: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Hexcolor('#3C8CE7'), Hexcolor('#00EAFF')],
              )),

          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(
              horizontal: 40.0,
              vertical: 10.0
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
//                Text('Isi Alamat', style: TextStyle(color: Colors.white, fontFamily: 'OpenSans', fontSize: 30.0,fontWeight: FontWeight.bold),),
                SizedBox(height: 10,),
                _buildPhoneNumInputText(),
                SizedBox(height: 10,),
                _buildKotaInputText(),
                SizedBox(height: 10,),
                _buildKabupatenInputText(),
                SizedBox(height: 10,),
                _buildKecamatanInputText(),
                SizedBox(height: 10,),
                _buildKodePosInputText(),
                SizedBox(height: 10,),
                _buildAlamatLengkapInputText(),
                SizedBox(height: 10,),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 25.0),
                  width: double.infinity,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)
                    ),
                    elevation: 5.0,
                    color: Colors.white,
                    child: Text('Simpan', style: TextStyle(
                      color: Color(0xFF527DAA),
                      letterSpacing: 1.5,
                      fontSize: 15
                    ),),
                    onPressed: () => print('Button is trigerred'),
                  ),
                )
              ],
            ),
          )
        ),
        );
  }
}
