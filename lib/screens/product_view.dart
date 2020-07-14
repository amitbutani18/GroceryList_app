import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:groceryList/providers/list_provider.dart';
import 'package:groceryList/providers/product.dart';
import 'package:groceryList/providers/product_provider.dart';
import 'package:groceryList/screens/grocery_list_screen.dart';
import 'package:provider/provider.dart';

class ProductView extends StatefulWidget {
  static const routeName = '/product-view';
  @override
  _ProductViewState createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  String categoryTitle;
  var _loadedInitData = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (!_loadedInitData) {
      final routeData =
          ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
      categoryTitle = routeData['title'];
      // Provider.of<ListProvider>(context,listen: false).addInItem();
      _loadedInitData = true;
    }
    super.didChangeDependencies();
  }

  void addProduct(Product product) {
    Provider.of<ListProvider>(context, listen: false).addProductToList(product);
  }

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductProvider>(context);
    final products = productData.items;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text(categoryTitle + " Products"),
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          Text(
            "Tap On Product To Add Your List",
            style: TextStyle(
              color: Color.fromRGBO(240, 248, 255, 0.5),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: Provider.of<ProductProvider>(context, listen: false)
                  .getData(categoryTitle),
              builder: (ctx, itemSnapshot) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 3 / 3.2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: products.length,
                        itemBuilder: (ctx, i) => InkWell(
                          onTap: () {
                            addProduct(products[i]);
                            _scaffoldKey.currentState.hideCurrentSnackBar();
                            _scaffoldKey.currentState.showSnackBar(SnackBar(
                              backgroundColor: Colors.green[50],
                              content: Text(
                                  products[i].title + ' Added To Your List!',
                                  style: TextStyle(
                                    color: Colors.green,
                                  )),
                              duration: Duration(seconds: 3),
                            ));
                          },
                          borderRadius: BorderRadius.circular(10),
                          child: Card(
                            color: Color.fromRGBO(240, 248, 255, 1),
//              color: Theme.of(context).primaryColor,
                            elevation: 5.0,
                            child: Container(
                              padding: EdgeInsets.only(bottom: 5),
//                  decoration: BoxDecoration(
//                    image: DecorationImage(
//                      image: NetworkImage(products[i].imageUrl),
//                    ),
//                  ),
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    height: 70,
                                    width: 70,
                                    child: Image.network(
                                      products[i].imageUrl,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    products[i].title,
                                    style: TextStyle(
//                        backgroundColor: Colors.black26,
                                      fontWeight: FontWeight.bold,
//                        fontSize: 10,
                                      color: Theme.of(context).accentColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
//                child: GridTile(
//                  child: GestureDetector(
//                    onTap: () {},
//                    child: Padding(
//                      padding: const EdgeInsets.all(8.0),
////                      child: Text(displayedProduct[i].title),
//                      child: FadeInImage(
//                        placeholder: NetworkImage(products[i].imageUrl),
//                        image: NetworkImage(products[i].imageUrl),
//                        fit: BoxFit.cover,
//                      ),
//                    ),
//                  ),
//                ),
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(GroceryListScreen.routeName);
        },
//      label: Text('Approve'),
        child: Icon(Icons.list, color: Colors.white),
        backgroundColor: Colors.green,
        tooltip: "Your List",
      ),
    );
  }
}
