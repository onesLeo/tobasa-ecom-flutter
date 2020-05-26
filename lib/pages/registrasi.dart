import 'dart:developer';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/UserEcom.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:logging/logging.dart';

class Registrasi extends StatefulWidget{
  @override
  RegistrasiState createState() => RegistrasiState();
}

class RegistrasiState extends State<Registrasi>{
  final Logger log = Logger('RegistrasiState');
  bool _isSubmitting, _obsecureText = true;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String _usernameVal, _passwordVal, _emailVal;

  Widget _showTitle(){
    return Text(
      'Daftar', style: Theme.of(context).textTheme.headline5,
    );
  }

  Widget _showUsernameInput(){
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: TextFormField(
        validator: (val) => val.length < 3? 'Username Terlalu Pendek' : null,
        onSaved: (val) => _usernameVal = val,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Username',
            hintText: 'Panjang minimal 3',
            icon: Icon(Icons.face,color: Colors.grey,)
        ),
      ),
    );
  }

  Widget _showEmailInput(){
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: TextFormField(
        onSaved: (val) => _emailVal = val,
        validator: (val) => !val.contains('@') ? 'Email tidak valid' : null,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Email',
            hintText: 'Masukkan Email valid',
            icon: Icon(Icons.mail,color: Colors.grey,)
        ),
      ),
    );
  }

  Widget _showPassInput(){
    return  Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: TextFormField(
        onSaved: (val) => _passwordVal = val,
        validator: (val) => val.length < 6? 'Password Terlalu Pendek' : null,
        obscureText: _obsecureText,
        decoration: InputDecoration(
            suffixIcon: GestureDetector(
              child: Icon(_obsecureText ? Icons.visibility : Icons.visibility_off),
              onTap: () {
                setState(() {
                  _obsecureText ? _obsecureText=false : _obsecureText=true;
                });
              },
            ),
            border: OutlineInputBorder(),
            labelText: 'Password',
            hintText: 'Masukkan Password Min Panjang 6',
            icon: Icon(Icons.lock,color: Colors.grey,)
        ),
      ),
    );
  }

  Widget _showRegisterSubmitButton(){
    return  Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: Column(
        children: <Widget>[
          _isSubmitting == true ?
          CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor)) : RaisedButton(
            child: Text('Submit', style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.black),),
            elevation: 8.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))
            ),
            color: Theme.of(context).accentColor,
            onPressed: _validateSubmit,
          ),
          FlatButton(
            child: Text(
                'Sudah Terdaftar? Login'
            ),
            onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
          )
        ],
      ),
    );
  }

  void _validateSubmit(){
    final _formState = _formKey.currentState;
      if(_formState.validate()){
        print('Form Valid and perform Save');
//        print('UR DATA - '+ _usernameVal +" - "+_passwordVal+" - "+_emailVal);
        _formState.save();
//        _registerUserToStrapi();
        _registerUserEmailAndPasswordFirebaseAuth();
      }else{
        print('Form Input Tidak Valid');
      }
  }

  /**
   * IP 10.0.2.2 is as endpoint for localhost in android to avoid error
   * https://github.com/hillelcoren/flutter-redux-starter/issues/16
   * https://github.com/flutter/flutter/issues/51198
   * to check ip endpoint for android using this command
   * open command prompt = type : adb shell
   * and then ifconfig eth0 -> if you don't find check the 'lo' and then use the ip
   * on 'lo' then provide in here
   */
  void _registerUserToStrapi() async{
    setState(() {
      _isSubmitting = true;
    });
    http.Response response =  await http.post('http://127.0.0.1:1337/auth/local/register', body: {
      "username": _usernameVal,
      "password" : _passwordVal,
      "email" : _emailVal
    });

    var responseData = json.decode(response.body);
    if( response.statusCode == 200 ){
      print('Response Code Regist ${response.statusCode}');
      setState(() {
        _isSubmitting = false;
      });
      _storeUserData(responseData);
      _showSuccessFulStatus();
      _redirectUserToProductPage();
      print(responseData);
    }else{
      final messageError = responseData['message'];
      setState(() {
        _isSubmitting = false;
      });

      _showErrorResponse(messageError);
    }
  }

  void _registerUserEmailAndPasswordFirebaseAuth() async{
    setState(() {
      _isSubmitting = true;
    });
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    UserUpdateInfo userUpdateInfo = new UserUpdateInfo();
    userUpdateInfo.displayName = _usernameVal;
    Future<AuthResult> authResult = firebaseAuth.createUserWithEmailAndPassword(email: _emailVal, password: _passwordVal);
    authResult.then((value) async {
      await value.user.updateProfile(userUpdateInfo);
      await value.user.reload();
      FirebaseUser currentUser = await firebaseAuth.currentUser();
      print('Display Name is Present? ${currentUser.displayName}');
      _saveUserInformationToDB(currentUser);
      _storeUserData(currentUser);
      _showSuccessFulStatus();
      _redirectUserToProductPage();
      setState(() {
        _isSubmitting = false;
      });
      log.info('User ${_usernameVal} is successfully created');
    } ).catchError((onError){
        setState(() {
          _isSubmitting=false;
        });
        _showErrorResponse('System mengalami gangguan ketika registrasi, coba beberapa saat lagi!');
        log.info('Error Happened while trying to update profile -  ${onError} ');
    });
  }

  void _saveUserInformationToDB(FirebaseUser user){
    Firestore firestore = Firestore.instance;
    UserEcom ecomUser = UserEcom(
      username: user.displayName,
      email: user.email,
      nomor_telepon: "",
      address_user: []
//      uid: user.uid
    );

    firestore.collection('user_ecom').document(user.uid).setData(ecomUser.toJson());
    log.info('User information has been saved to firestore');
  }

  void _storeUserData(FirebaseUser responseData) async{
    final sharedPref = await SharedPreferences.getInstance();
    Map<String, dynamic> userMap = new Map<String, dynamic>();
    userMap.putIfAbsent('username', () => responseData.displayName);
    userMap.putIfAbsent('email', () => responseData.email);
    userMap.putIfAbsent('_id', () => responseData.uid);
    sharedPref.setString('user', json.encode(userMap));
  }


  void _showErrorResponse(String messageError){
    final snackBar = SnackBar( content: Text(messageError, style: TextStyle(color: Colors.red),),);
    _scaffoldKey.currentState.showSnackBar(snackBar);
    throw Exception('Error Registering user ${_usernameVal}, with error message: ${messageError}');
  }

  void _redirectUserToProductPage(){
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/homepage');
    });
  }

  void _showSuccessFulStatus(){
    final snackBar = SnackBar(
      content: Text('Success tambah user ${_usernameVal} ke dalam system!', style: TextStyle(color: Colors.green)
      ),
    );

    _scaffoldKey.currentState.showSnackBar(snackBar);
    _formKey.currentState.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('TOBASA ECOMMERCE', style:
        TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto', letterSpacing: 1.5, color: Colors.grey[200],),
        ),
        backgroundColor: Colors.blueGrey,
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
                      _showUsernameInput()
                    ,
                      _showPassInput()
                    ,
                    _showEmailInput()
                   ,
                    _showRegisterSubmitButton()
                  ]
              ),
            ),
          ),
        ),
      ),
    );
  }
    
}