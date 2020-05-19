import 'dart:developer';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/AddressUser.dart';
import 'package:flutter_app/models/UserEcom.dart';
import 'package:flutter_app/models/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:logging/logging.dart';

class AlamatForm extends StatefulWidget{
  @override
  AlamatFormState createState() => AlamatFormState();
}

class AlamatFormState extends State<AlamatForm>{
  final Logger log = Logger('AlamatFormState');
  bool _isSubmitting, _obsecureText = true;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  UserEcom userEcom = new UserEcom();
  List<AddressUser> listDummy = [];
  String _noTelpVal, _kecamatanVal,_alamatLengkapVal, _kabupatenVal,_kotaVal, _kodePosVal;

  Widget _showTitle(){
    return Text(
      'Alamat Pengiriman', style: Theme.of(context).textTheme.subtitle1,
    );
  }

  Widget _showNomorTelpInput(){
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: TextFormField(
        keyboardType: TextInputType.number,
        validator: (val) => val.length < 8? 'Nomor Telp tidak valid!' : null,
        onSaved: (val) => _noTelpVal = val,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'No Telp.',
            icon: Icon(Icons.phone,color: Colors.grey,)
        ),
      ),
    );
  }

  Widget _showKabupatenInput(){
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: TextFormField(
        validator: (val) => val.isEmpty? 'Kabupaten harus diisi!' : null,
        onSaved: (val) => _kabupatenVal = val,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Kabupaten',
            icon: Icon(Icons.location_city,color: Colors.grey,)
        ),
      ),
    );
  }

  Widget _showKotaInput(){
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: TextFormField(
        validator: (val) => val.isEmpty? 'Kota harus diisi!' : null,
        onSaved: (val) => _kotaVal = val,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Kota',
            icon: Icon(Icons.location_city,color: Colors.grey,)
        ),
      ),
    );
  }

  Widget _showKodePosInput(){
    return  Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: TextFormField(
        keyboardType: TextInputType.number,
        validator: (val) => val.isEmpty ? 'Kode Pos harus diisi!' : null,
        onSaved: (val) => _kodePosVal = val,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Kode Post',
            icon: Icon(Icons.local_post_office,color: Colors.grey,)
        ),
      ),
    );
  }
  
  Widget _showKecamatanInput(){
    return  Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: TextFormField(
        validator: (val) => val.isEmpty ? 'Kecamatan harus diisi!' : null,
        onSaved: (val) => _kecamatanVal = val,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Kecamatan',
            icon: Icon(Icons.location_city,color: Colors.grey,)
        ),
      ),
    );
  }
  
  Widget _showAlamatLengkapInput(){
    return  Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: TextFormField(
        validator: (val) => val.isEmpty ? 'Alamat lengkap harus diisi!' : null,
        onSaved: (val) => _alamatLengkapVal = val,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Alamat Lengkap',
            icon: Icon(Icons.location_city,color: Colors.grey,)
        ),
      ),
    );
  }
  
  _updateUserInformationOnFireStore(AppState state){
    print('Trying to update Information on FireSTore');

    AddressUser addressUser = new AddressUser(alamat: _alamatLengkapVal,
        kabupaten: _kabupatenVal,
      isPrimary: false,
      kecamatan: _kecamatanVal,
      kode_pos: _kodePosVal,
      kota: _kotaVal
    );
//
    listDummy.add(addressUser);
    print('length of Address List ${listDummy.length}');
    userEcom = UserEcom(email: state.user.email, username: state.user.username, address_user: listDummy,nomor_telepon: _noTelpVal);
    Firestore.instance.collection('user_ecom').document(state.user.id).setData(userEcom.toJson(), merge: true).then((value) => print('Saving to firestore'),
        onError: (e) => _showErrorResponse(e) );
    listDummy.clear();
    log.info('update user information data successfully');
  }

  Widget _showRegisterSubmitButton(AppState state){
    return  Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: Column(
        children: <Widget>[
          if (_isSubmitting == true) CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor), backgroundColor: Colors.grey,) else RaisedButton(
            child: Text('Submit', style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.black),),
            elevation: 8.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))
            ),
            color: Theme.of(context).accentColor,
            onPressed: ()=> _validateSubmit(state),
          ),
//          FlatButton(
//            child: Text(
//                'Sudah Terdaftar? Login'
//            ),
//            onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
//          )
        ],
      ),
    );
  }

   _validateSubmit(state){
    final _formState = _formKey.currentState;
      if(_formState.validate()){
        print('Form Valid and perform Save');
        _formState.save();
        _updateUserInformationOnFireStore(state);
        _showSuccessFulStatus();
        _redirectUserToCartPage();
        setState(() {
          _isSubmitting = false;
        });
//        _registerUserEmailAndPasswordFirebaseAuth();
      }else{
        print('Form Input Tidak Valid');

      }
  }

  void _showErrorResponse(String messageError){
    final snackBar = SnackBar( content: Text(messageError, style: TextStyle(color: Colors.red),),);
    _scaffoldKey.currentState.showSnackBar(snackBar);
    throw Exception('Error Registering user ${_noTelpVal}, with error message: ${messageError}');
  }

  void _redirectUserToCartPage(){
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/keranjangbelanja');
    });
  }

  void _showSuccessFulStatus(){
    final snackBar = SnackBar(
      content: Text('Success update alamat user ke dalam system!', style: TextStyle(color: Colors.green)
      ),
    );

    _scaffoldKey.currentState.showSnackBar(snackBar);
    _formKey.currentState.reset();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store)=> store.state,
      builder: (_, state){
        return Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text('Isi Alamat'),
          ),
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey ,
                  child: Column(
                      children: [
                        _showTitle()
                        ,
                        _showNomorTelpInput(),

                        _showKotaInput(),

                        _showKabupatenInput()
                        ,
                        _showKecamatanInput()
                        ,
                        _showKodePosInput(),

                        _showAlamatLengkapInput()
                        ,
                        _showRegisterSubmitButton(state)
                      ]
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
    
}