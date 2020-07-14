import 'package:flutter/material.dart';
import 'package:groceryList/providers/list_provider.dart';
import 'package:provider/provider.dart';

class GroceryListScreen extends StatefulWidget {
  static const routeName = '/grocery-list';
  @override
  _GroceryListScreenState createState() => _GroceryListScreenState();
}

class _GroceryListScreenState extends State<GroceryListScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void removeItem(String id) {}

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ListProvider>(context);
    final product = productData.items;
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          elevation: 0,
          title: Text("Your Shopping List"),
        ),
        body: ListView.builder(
          itemBuilder: (ctx, i) => Container(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            height: 70,
            width: double.maxFinite,
            child: Dismissible(
              key: Key(productData.items.values.toList()[i].id),
              direction: DismissDirection.endToStart,
              confirmDismiss: (direction) {
                return showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text('Are You Sure?'),
                    content: Text('Do Yoy want to remove item from the List?'),
                    elevation: 6,
                    actions: <Widget>[
                      FlatButton(
                        child: Text(
                          'No',
                          style: TextStyle(color: Colors.green),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                      ),
                      FlatButton(
                        child: Text(
                          'Yes',
                          style: TextStyle(color: Colors.redAccent),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                      )
                    ],
                  ),
                );
              },
              onDismissed: (direction) {
                setState(() {
                  _scaffoldKey.currentState.showSnackBar(SnackBar(
                    content: Text(productData.items.values.toList()[i].title +
                        " Removed Form List"),
                  ));
                  Provider.of<ListProvider>(context, listen: false).removeItem(
                      productData.items.keys.toList()[i].toString());
                });
              },
              background: Padding(
                padding: const EdgeInsets.only(bottom: 22.0, top: 5),
                child: Container(
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 20),
                    color: Colors.red),
              ),
              child: Card(
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        productData.items.values.toList()[i].title,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor),
                      ),
                      Row(children: <Widget>[
                        Text(
                          "Quantity ",
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        productData.items.values.toList()[i].quantity == 1
                            ? Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                  right: BorderSide(
                                    width: 2,
                                    color: Colors.grey,
                                  ),
                                  top: BorderSide(
                                    width: 2,
                                    color: Colors.grey,
                                  ),
                                  bottom: BorderSide(
                                    width: 2,
                                    color: Colors.grey,
                                  ),
                                )),
                                child: Icon(
                                  Icons.remove,
                                  color: Colors.grey,
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  print("Item Removed");
                                  Provider.of<ListProvider>(context,
                                          listen: false)
                                      .decQuantity(productData.items.keys
                                          .toList()[i]
                                          .toString());
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border(
                                    right: BorderSide(
                                      width: 2,
                                    ),
                                    top: BorderSide(
                                      width: 2,
                                    ),
                                    bottom: BorderSide(
                                      width: 2,
                                    ),
                                  )),
                                  child: Icon(Icons.remove),
                                ),
                              ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          productData.items.values
                              .toList()[i]
                              .quantity
                              .toString(),
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            print(
                                productData.items.keys.toList()[i].toString());
                            Provider.of<ListProvider>(context, listen: false)
                                .incQuantity(productData.items.keys
                                    .toList()[i]
                                    .toString());
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border(
                              left: BorderSide(width: 2),
                              top: BorderSide(
                                width: 2,
                              ),
                              bottom: BorderSide(
                                width: 2,
                              ),
                            )),
                            child: Icon(Icons.add),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                      ]),
                    ],
                  ),
                ),
              ),
            ),
          ),
          itemCount: productData.items.length,
        ));
  }
}
