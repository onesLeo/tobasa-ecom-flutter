import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LoginExistingUser extends StatefulWidget{

  @override
  LoginExistingUserState createState() => LoginExistingUserState();
}

class LoginExistingUserState extends State<LoginExistingUser>{
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  bool _isSubmitting, _obsecureText = true;
  String _usernameVal, _passwordVal, _emailVal;

  Widget _showTitle(){
    return Text(
      'Login', style: Theme.of(context).textTheme.headline5,
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
        validator: (val) => val.length <= 0? 'Password Terlalu Pendek' : null,
        obscureText: _obsecureText,
        decoration: InputDecoration(
          suffixIcon: GestureDetector(
            child: Icon(_obsecureText ? Icons.visibility : Icons.visibility_off),
            onTap: () {
              setState(() {
                _obsecureText != _obsecureText;
              });
            },
          ),
            border: OutlineInputBorder(),
            labelText: 'Password',
            hintText: 'Masukkan Password Valid Anda!',
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
          _isSubmitting == true ? CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor)
          ) : RaisedButton(
            child: Text('Submit', style: Theme.of(context).textTheme.bodyText1,),
            elevation: 8.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))
            ),
            color: Theme.of(context).primaryColor,
            onPressed: _validateSubmit,
          ),
          FlatButton(
            child: Text(
                'New User? Register'
            ),
            onPressed: () => Navigator.pushReplacementNamed(context, '/registrasi'),
          )
        ],
      ),
    );
  }

  void _validateSubmit(){
    final _formState = _formKey.currentState;
    if(_formState.validate()){
      print('Form Valid and perform Save');
      _formState.save();
      _checkUserToStrapi();
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
  void _checkUserToStrapi() async{
    setState(() {
      _isSubmitting = true;
    });
    http.Response response =  await http.post('http://127.0.0.1:1337/auth/local', body: {
      "identifier": _emailVal,
      "password" : _passwordVal
    });

    var responseData = json.decode(response.body);

    if( response.statusCode == 200 ){
      print('Response Code is ${response.statusCode}');
      setState(() {
        _isSubmitting = false;
      });
      _storeUserData(responseData);
      _showSuccessFulStatus();
      _redirectUserToProductPage();
      print(responseData);
    }else{
      print('Response Code is ${response.statusCode}');
      final messageError = responseData['message'];
      setState(() {
        _isSubmitting = false;
      });

      _showErrorResponse(messageError);
    }
  }

  void _storeUserData(responseData) async{
    final sharedPref = await SharedPreferences.getInstance();
    Map<String, dynamic> userMap = responseData['user'];
    userMap.putIfAbsent('jwt', () => responseData['jwt']);
    sharedPref.setString('user', json.encode(userMap));
  }

  void _showErrorResponse(String messageError){
    final snackBar = SnackBar( content: Text(messageError, style: TextStyle(color: Colors.red),),);
    _scaffoldKey.currentState.showSnackBar(snackBar);
    throw Exception('Error Login  ${_emailVal}, with error message: ${messageError}');
  }

  void _redirectUserToProductPage(){
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/');
    });
  }

  void _showSuccessFulStatus(){
    final snackBar = SnackBar(
      content: Text('Success Login user email ${_emailVal} !', style: TextStyle(color: Colors.green)
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
        title: Text('Login'),
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
                    _showEmailInput()
                    ,
                    _showPassInput()
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