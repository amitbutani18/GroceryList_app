import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:groceryList/providers/product.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _items = [
//    Product(
//        id: DateTime.now().toString(),
//        title: 'Milk',
//        imageUrl:
//            'https://image.shutterstock.com/image-photo/bright-spring-view-cameo-island-260nw-1048185397.jpg'),
//    Product(
//        id: DateTime.now().toString(),
//        title: 'Milk',
//        imageUrl:
//            'https://www.talkwalker.com/images/2020/blog-headers/image-analysis.png'),
//    Product(
//        id: DateTime.now().toString(),
//        title: 'Milk',
//        imageUrl:
//            'https://image.shutterstock.com/image-photo/bright-spring-view-cameo-island-260nw-1048185397.jpg'),
  ];

  List<Product> get items {
    return [..._items];
  }

  Future<void> getData(categoryTitle) async {
    try{
      final databaseReference = Firestore.instance;
      final List<Product> loadedItem = [];
      await databaseReference
          .collection('items').where('type', isEqualTo: categoryTitle)
          .getDocuments()
          .then((QuerySnapshot snapshot) {
        snapshot.documents.forEach((f) =>
//          print(f['title'])
        loadedItem.add(
            Product(id: f['id'], title: f['title'], imageUrl: f['imageUrl']))
        );
      });
      _items = loadedItem;
      notifyListeners();
    } catch (error) {
      print(error);
    }

  }
}
