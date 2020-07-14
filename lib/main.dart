import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:groceryList/providers/category_provider.dart';
import 'package:groceryList/providers/list_provider.dart';
import 'package:groceryList/providers/product_provider.dart';
import 'package:groceryList/screens/add_item.dart';
import 'package:groceryList/screens/grocery_list_screen.dart';
import 'package:groceryList/screens/home_screen.dart';
import 'package:groceryList/screens/profile_screen.dart';
import 'package:groceryList/screens/product_view.dart';
import 'package:provider/provider.dart';
import './screens/auth_screen.dart';

import 'package:hexcolor/hexcolor.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: ProductProvider()),
        ChangeNotifierProvider.value(value: CategoryProvider()),
        ChangeNotifierProvider.value(value: ListProvider()),
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            fontFamily: "Montserrat",
//            primaryColor: Hexcolor("#FEDBD0"),
            primaryColor: Color.fromRGBO(58, 66, 86, 1.0),
            accentColor: Hexcolor("#442C2E"),
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: StreamBuilder(stream: FirebaseAuth.instance.onAuthStateChanged,builder: (ctx, userSnapshot) {
            if(userSnapshot.hasData){
              return HomeScreen();
            }
            return AuthScreen();
          }),
          routes: {
            ProfileScreen.routeName: (context) => ProfileScreen(),
            AddItem.routeName: (context) => AddItem(),
            ProductView.routeName : (context) => ProductView(),
            GroceryListScreen.routeName: (context) => GroceryListScreen(),
          }
      ),
    );
  }
}
