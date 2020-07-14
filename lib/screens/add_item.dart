import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';

class AddItem extends StatefulWidget {
  static const routeName = '/add-item';
  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  final _formKey = GlobalKey<FormState>();
  var _title = '';
  var _description = '';
  var _type = '';
  var _imageUrl = '';
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _typeController = TextEditingController();
  final _imageUrlController = TextEditingController();

  void _addItem() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState.save();
//      print(_type);
//      print(_description);
//      print(_imageUrl);
//      print(_title);
      DocumentReference documentReference =
          Firestore.instance.collection('items').document();
      documentReference.setData({
        'id': documentReference.documentID,
        'title': _title,
        'description': _description,
        'type': _type,
        'imageUrl': _imageUrl
      });
    }
    _typeController.clear();
    _titleController.clear();
    _imageUrlController.clear();
    _descriptionController.clear();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Item"),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  controller: _titleController,
                  decoration: InputDecoration(
                    hintText: 'Title',
                    labelStyle: TextStyle(color: Colors.black),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.black, width: 2.0),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                  onSaved: (value) {
                    _title = value;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    hintText: 'Description',
                    labelStyle: TextStyle(color: Colors.black),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.black, width: 2.0),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                  onSaved: (value) {
                    _description = value;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                DropDownFormField(
                  titleText: 'Type',
                  
                  hintText: 'Select Category',
                  value: _type,
                  onSaved: (value) {
                    setState(() {
                      _type = value;
                    });
                  },
                  onChanged: (value) {
                    setState(() {
                      _type = value;
                    });
                  },
                  dataSource: [
                    {
                      "display": "Dairy",
                      "value": "Dairy",
                    },
                    {
                      "display": "Vegetable",
                      "value": "Vegetable",
                    },
                    {
                      "display": "Fruit",
                      "value": "Fruit",
                    },
                    {
                      "display": "Bread & Pastries",
                      "value": "Bread & Pastries",
                    },
                    {
                      "display": "Milk & Cheese",
                      "value": "Milk & Cheese",
                    },
                    {
                      "display": "Care & Health",
                      "value": "Care & Health",
                    },

                  ],
                  textField: 'display',
                  valueField: 'value',
                ),
                // TextFormField(
                //   validator: (value) {
                //     if (value.isEmpty) {
                //       return 'Please enter some text';
                //     }
                //     return null;
                //   },
                //   controller: _typeController,
                //   decoration: InputDecoration(
                //     hintText: 'Type',
                //     labelStyle: TextStyle(color: Colors.black),
                //     focusedBorder: OutlineInputBorder(
                //       borderSide:
                //           const BorderSide(color: Colors.black, width: 2.0),
                //       borderRadius: BorderRadius.circular(25.0),
                //     ),
                //   ),
                //   onSaved: (value) {
                //     _type = value;
                //   },
                // ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  controller: _imageUrlController,
                  decoration: InputDecoration(
                    hintText: 'Image Url',
                    labelStyle: TextStyle(color: Colors.black),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.black, width: 2.0),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                  onSaved: (value) {
                    _imageUrl = value;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  onPressed: _addItem,
                  child: Text(
                    "Add Item",
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
