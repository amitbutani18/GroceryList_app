import 'dart:io';
import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:image_picker/image_picker.dart';

class UserImage extends StatefulWidget {

  UserImage(this.pickedImageFn);

  final void Function(File pickedImage) pickedImageFn;

  @override
  _UserImageState createState() => _UserImageState();
}

class _UserImageState extends State<UserImage> {
  File _image;
  Future getImage(String text) async {
    if (text == 'camera') {
      var image = await ImagePicker.pickImage(source: ImageSource.camera);
      setState(() {
        _image = image;
      });
    }
    if (text == 'gallery') {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        _image = image;
      });
    }
    widget.pickedImageFn(_image);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GFAvatar(
          backgroundColor: Colors.grey,
          radius: 50,
          backgroundImage: _image == null ? NetworkImage('https://pluspng.com/img-png/user-png-icon-male-user-icon-512.png') : FileImage(_image),
        ),
        FlatButton.icon(
            icon: Icon(Icons.image),
            textColor: Theme.of(context).accentColor,
            label: Text('Pick Image'),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Pick Image'),
                  content: Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        FlatButton.icon(
                          onPressed: () {
                            getImage('camera');
                            Navigator.of(context).pop();
                          },
                          icon: Icon(Icons.camera_alt),
                          label: Text('Take From Camera'),
                        ),
                        FlatButton.icon(
                          onPressed: () {
                            getImage('gallery');
                            Navigator.of(context).pop();
                          },
                          icon: Icon(Icons.image),
                          label: Text('Pick From Gallery'),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ],
    );
  }
}
