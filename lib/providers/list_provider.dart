import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:groceryList/providers/product.dart';

class ListItem {
  final String id;
  final String title;
  final String prodId;
  final int quantity;

  ListItem({
    @required this.id,
    @required this.title,
    @required this.prodId,
    @required this.quantity,
  });
}

class ListProvider with ChangeNotifier {
  Map<String, ListItem> _items = {};

  Map<String, ListItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  void incQuantity(String key) {
    if (_items.containsKey(key)) {
      print("Quantity plus");
      _items.update(
          key,
          (existingListItem) => ListItem(
              id: existingListItem.id,
              title: existingListItem.title,
              prodId: existingListItem.prodId,
              quantity: existingListItem.quantity + 1));
    }
    notifyListeners();
  }

  void decQuantity(String key) {
    if (_items.containsKey(key)) {
      print("Quantity minus");
      _items.update(
          key,
          (existingListItem) => ListItem(
              id: existingListItem.id,
              title: existingListItem.title,
              prodId: existingListItem.prodId,
              quantity: existingListItem.quantity - 1));
    }
    notifyListeners();
  }

  void removeItem(String id) {
    if (_items.containsKey(id)) {
      _items.remove(id);
    }
    notifyListeners();
  }

  void addProductToList(Product product) {
    const url = 'https://grocerylist-d7379.firebaseio.com/list.json';

    http
        .post(url,
            body: json.encode({
              'title': product.title,
              'prodId': product.id,
              'quantity': 1,
            }))
        .then((response) {
          print(json.decode(response.body));
      if (_items.containsKey(product.id)) {
        print("update");
        _items.update(
            product.id,
            (existingListItem) => ListItem(
                id: existingListItem.id,
                title: existingListItem.title,
                prodId: existingListItem.prodId,
                quantity: existingListItem.quantity + 1));
      } else {
        _items.putIfAbsent(
            product.id,
            () => ListItem(
                  id: json.decode(response.body)['name'],
                  title: product.title,
                  prodId: product.id,
                  quantity: 1,
                ));
      }
      notifyListeners();
    });
  }
}

//   void addInItem() {
//     Firestore.instance
//         .collection('list')
//         .getDocuments()
//         .then((QuerySnapshot snapshot) {
//       snapshot.documents.forEach((f) =>
// //          print(f['title']));
//           _items.putIfAbsent(
//               f['id'],
//               () => ListItem(
//                   id: f['id'],
//                   title: f['title'],
//                   prodId: f['prodId'],
//                   quantity: 1)));

// //    _items.add(product);
//     });
//   }

//   Future<void> addProductToList(Product product) async {
//     if (_items.containsKey(product.id)) {
//       print('already exist');
//     } else {
//       DocumentReference documentReference =
//           Firestore.instance.collection('list').document();
//       await documentReference.setData({
//         'id': documentReference.documentID,
//         'proId': product.id,
//         'title': product.title,
//         'imageUrl': product.imageUrl,
//         'quantity': 1,
//       });
//       addInItem();
//     }

// //    if (_items.containsKey(product.id)) {
// //      print('already there');
// //      _items.update(
// //          product.id,
// //              (existingCartItem) => ListItem(
// //                id: product.id,
// //                title: product.title,
// //                prodId: product.id,
// //                quantity: existingCartItem.quantity+1,
// //          ));
// //    } else {
// //      DocumentReference documentReference =
// //          Firestore.instance.collection('list').document();
// //      await documentReference.setData({
// //        'id': documentReference.documentID,
// //        'proId': product.id,
// //        'title': product.title,
// //        'imageUrl': product.imageUrl,
// //        'quantity': 1,
// //      });
// //      await Firestore.instance
// //          .collection('list')
// //          .getDocuments()
// //          .then((QuerySnapshot snapshot) {
// //        snapshot.documents.forEach((f) =>
// ////          print(f['title'])
// //            _items.putIfAbsent(
// //                product.id,
// //                () => ListItem(
// //                    id: product.id,
// //                    title: product.title,
// //                    prodId: product.id,
// //                    quantity: 1));
// //
// ////    _items.add(product);
// //
// //    }
// ////    _items = loadedProduct;
// //    notifyListeners();
// //    print(_items);
//   }
// }
