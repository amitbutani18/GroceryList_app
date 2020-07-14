import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/components/avatar/gf_avatar.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/profile';
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  static var _userEmail = '';
  static var _userName = '';
  static var _userPhone = '';
  static var _imageUrl = '';
  var _isLoading = false;
  TextEditingController _emailController;
  TextEditingController _nameController;
  TextEditingController _phoneController;
//  var _updatePhone = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser().then((userdata) {
      setState(() {
        _userEmail = userdata.documents[0]['email'];
        _userName = userdata.documents[0]['username'];
        _userPhone = userdata.documents[0]['phone_number'];
        _imageUrl = userdata.documents[0]['image_url'];
        _emailController = TextEditingController(text: _userEmail);
        _nameController = TextEditingController(text: _userName);
        _phoneController = TextEditingController(text: _userPhone);
      });
    });
  }

  void _update() async {
    final user = await _auth.currentUser();
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if(isValid){
      _formKey.currentState.save();
      try {
        setState(() {
          _isLoading = true;
        });
        await Firestore.instance.collection('users').document(user.uid).updateData({'username': _userName,
          'email': _userEmail,
          'phone_number' : _userPhone,});
        setState(() {
          _isLoading = false;
        });
      } catch (error) {
        setState(() {
          _isLoading = false;
        });
        print(error);
      }
    }
  }

  Future<QuerySnapshot> getUser() async {
    final user = await _auth.currentUser();
    return await Firestore.instance
        .collection('users')
        .where("userId", isEqualTo: user.uid)
        .getDocuments();
  }

  @override
  Widget build(BuildContext context) {
    print("emial" + _userEmail);
    print("phoen" + _userPhone);
    print("name" + _userName);
    print("image" + _imageUrl);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.green),
        title: Text('Your Profile',
            style: TextStyle(color: Colors.white),),
        elevation: 0,
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            GFAvatar(
              // backgroundColor: Colors.grey,
              backgroundImage: _imageUrl == '' ? NetworkImage('https://pluspng.com/img-png/user-png-icon-male-user-icon-512.png') : NetworkImage(_imageUrl),
              radius: 50,
            ),
//          FlatButton.icon(
//              icon: Icon(Icons.image),
//              textColor: Theme.of(context).accentColor,
//              label: Text('Pick Image'),
//              onPressed: () {
//                showDialog(
//                  context: context,
//                  builder: (context) => AlertDialog(
//                    title: Text('Pick Image'),
//                    content: Container(
//                      child: Column(
//                        mainAxisSize: MainAxisSize.min,
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: <Widget>[
//                          FlatButton.icon(
//                            onPressed: () {
//                              getImage('camera');
//                              Navigator.of(context).pop();
//                            },
//                            icon: Icon(Icons.camera_alt),
//                            label: Text('Take From Camera'),
//                          ),
//                          FlatButton.icon(
//                            onPressed: () {
//                              getImage('gallery');
//                              Navigator.of(context).pop();
//                            },
//                            icon: Icon(Icons.image),
//                            label: Text('Pick From Gallery'),
//                          ),
//                        ],
//                      ),
//                    ),
//                  ),
//                );
//              }),
            SizedBox(
              height: 35,
            ),
            Expanded(
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15))),
                color: Theme.of(context).primaryColor,
                margin: EdgeInsets.all(0),
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Your Email',
                          style: TextStyle(color: Colors.white54),
                        ),
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          controller: _emailController,
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
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 2.0),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                          ),
                          onSaved: (value) {
                            _userEmail = value;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Your Username',
                          style: TextStyle(color: Colors.white54),
                        ),
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          controller: _nameController,
                          key: ValueKey('username'),
                          validator: (value) {
                            if (value == null || value.length < 4) {
                              return 'Please Enter At Least 4 character';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: 'User Name',
                            labelStyle: TextStyle(color: Colors.black),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 2.0),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                          ),
                          onSaved: (value) {
                            _userName = value;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Your Phone Number',
                          style: TextStyle(color: Colors.white54),
                        ),
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          controller: _phoneController,
                          key: ValueKey('phoneNumber'),
                          validator: (value) {
                            if (value == null || value.length < 10) {
                              return 'Please Enter At Least 10 character';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: 'Phone Number',
                            labelStyle: TextStyle(color: Colors.black),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 2.0),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                          ),
                          onSaved: (value) {
                              _userPhone = value;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            if(_isLoading) CircularProgressIndicator(),
                            if (!_isLoading)
                            RaisedButton(
                              onPressed: _update,
                              child: Text(
                                "Update",
                                style: TextStyle(
                                    fontSize: 23,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w300),
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 27, vertical: 10),
                              textColor: Colors.white,
                              color: Colors.green,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
