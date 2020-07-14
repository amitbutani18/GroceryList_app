import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

import '../widgets/Auth/auth_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _submitAuthScreen(
      String email,
      String username,
      File image,
      String password,
      bool isLogin,
      BuildContext ctx,
      ) async {
    AuthResult _authResult;
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        _authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        _authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        final ref = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child(_authResult.user.uid + '.jpg');
        await ref.putFile(image).onComplete;
        final url = await ref.getDownloadURL();

        Firestore.instance
            .collection('users')
            .document(_authResult.user.uid)
            .setData({
          'username': username,
          'email': email,
          'image_url': url,
          'phone_number' : '',
          'userId': _authResult.user.uid
        });
      }
    } on PlatformException catch (err) {
      var msg = 'Error Occured';
      if (err.message != null) {
        msg = err.message;
      }
      Scaffold.of(ctx).showSnackBar(SnackBar(
        content: Text(msg),
        backgroundColor: Theme.of(ctx).errorColor,
      ));
      print(msg);
      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      print(err);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_submitAuthScreen, _isLoading),
    );
  }
}
