// please delete this if it is not use full
//import 'package:flutter/material.dart';
//import 'package:groceryList/providers/product_provider.dart';
//import 'package:provider/provider.dart';
//
//class ProductItem extends StatelessWidget {
////  final String id;
////  final String title;
////  final String imageUrl;
//
////  const ProductItem({Key key, this.id, this.title, this.imageUrl}) : super(key: key);
//  @override
//  Widget build(BuildContext context) {
//    final productData = Provider.of<ProductProvider>(context);
//    final products = productData.items;
//    return FutureBuilder(
//      future: Provider.of<ProductProvider>(context,listen: false).getData(),
//      builder: (ctx, itemSnapshot) => GridView.builder(
//          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//            crossAxisCount: 4,
//            childAspectRatio: 2 / 2,
//            crossAxisSpacing: 10,
//            mainAxisSpacing: 10,
//          ),
//          itemCount: products.length,
//          itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
//            value: products[i],
//            child: ClipRRect(
//              borderRadius: BorderRadius.circular(10),
//              child: GridTile(
//                child: GestureDetector(
//                  onTap: () {},
//                  child: Padding(
//                    padding: const EdgeInsets.all(8.0),
//                    child: FadeInImage(
//                      placeholder: NetworkImage(products[i].imageUrl),
//                      image: NetworkImage(products[i].imageUrl),
//                      fit: BoxFit.cover,
//                    ),
//                  ),
//                ),
//              ),
//            ),
//          )),
//    );
//
//  }
//}
