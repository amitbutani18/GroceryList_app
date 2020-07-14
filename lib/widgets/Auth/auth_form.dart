import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../user_image.dart';

class AuthForm extends StatefulWidget {
  AuthForm(this.submitAuthScreen, this.isLoading);

  final bool isLoading;
  final void Function(
      String email,
      String username,
      File image,
      String password,
      bool isLogin,
      BuildContext context,
      ) submitAuthScreen;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {

  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _userEmail = '';
  var _userName = '';
  var _userPassword = '';

  File _userPickImage;

  void _pickedImage(File pickImage) {
    _userPickImage = pickImage;
  }

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (_userPickImage == null && !_isLogin) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Please Pick Image'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      return;
    }

    if (isValid) {
      _formKey.currentState.save();
      widget.submitAuthScreen(
        _userEmail.trim(),
        _userName.trim().toLowerCase(),
        _userPickImage,
        _userPassword.trim(),
        _isLogin,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/images/logo.png'),
            SizedBox(height: 25,),
            Card(
              margin: EdgeInsets.all(15),
              child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Form(
                      key: _formKey,
//            autovalidate: _autoValidate,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          _isLogin ? Container() : UserImage(_pickedImage),
                          TextFormField(
                            key: ValueKey('email'),
                            validator: (value) {
                              if (value == null || !value.contains('@')) {
                                return 'Please Enter Valid Email';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: 'Email',
                              labelStyle: TextStyle(color: Colors.black),
                              focusedBorder:OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.black, width: 2.0),
                                borderRadius: BorderRadius.circular(25.0),
                              ),),
                            onSaved: (value) {
                              _userEmail = value;
                            },
                          ),
                          SizedBox(height: 10,),
                          if (!_isLogin)
                            TextFormField(
                              key: ValueKey('username'),
                              validator: (value) {
                                if (value == null || value.length < 4) {
                                  return 'Please Enter At Least 4 character';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: 'Username',
                                labelStyle: TextStyle(color: Colors.black),
                                focusedBorder:OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.black, width: 2.0),
                                  borderRadius: BorderRadius.circular(25.0),
                                ),),
                              onSaved: (value) {
                                _userName = value;
                              },
                            ),
                          SizedBox(height: 10,),
                          TextFormField(
                            key: ValueKey('password'),
                            controller: _passwordController,
                            validator: (value) {
                              if (value == null || value.length < 5) {
                                return 'Please Enter Valid Password';
                              }
                              return null;
                            },
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'Password',
                              labelStyle: TextStyle(color: Colors.black),
                              focusedBorder:OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.black, width: 2.0),
                                borderRadius: BorderRadius.circular(25.0),
                              ),),
                            onSaved: (value) {
                              _userPassword = value;
                            },
                          ),
                          SizedBox(height: 10,),
                          _isLogin
                              ? Container()
                              : TextFormField(
                            key: ValueKey('cpassword'),
                            obscureText: true,
                            validator: (value) {
                              if (value == null ||
                                  value != _passwordController.text) {
                                return 'Password Not match';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'Re-enter Password',
                              labelStyle: TextStyle(color: Colors.black),
                              focusedBorder:OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.black, width: 2.0),
                                borderRadius: BorderRadius.circular(25.0),
                              ),),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          if (widget.isLoading) CircularProgressIndicator(),
                          if (!widget.isLoading)
                            RaisedButton(
                              onPressed: _trySubmit,
                              child: Text(
                                _isLogin ? "Log In" :"Sign Up",
                                style: TextStyle(
                                    fontSize: 23,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w300),
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              padding: EdgeInsets.symmetric(horizontal: 27, vertical: 10),
                              textColor: Colors.white,
                              color: Colors.green,
                            ),
                          if (!widget.isLoading)
                            FlatButton(
                              textColor: Theme.of(context).accentColor,
                              child: Text(_isLogin
                                  ? 'Create new account'
                                  : 'I have already an account'),
                              onPressed: () {
                                setState(() {
                                  _isLogin = !_isLogin;
                                });
                              },
                            ),
                        ],
                      ),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
