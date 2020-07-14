import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:groceryList/screens/category_screen.dart';
import 'package:groceryList/screens/grocery_list_screen.dart';
import 'package:provider/provider.dart';
import 'package:groceryList/providers/product_provider.dart';
import 'package:groceryList/screens/profile_screen.dart';
import 'package:groceryList/widgets/product_item.dart';
import 'add_item.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  var _isInit = true;

  void signOut() async {
    await _auth.signOut();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.green[50]),
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        elevation: 0,
        title: Text('Before Grocery'),
        
      ),
      drawer: FutureBuilder(
        future: FirebaseAuth.instance.currentUser(),
        builder: (ctx, futureSnapshot) {
          if (futureSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return StreamBuilder(
            stream: Firestore.instance
                .collection('users')
                .where("userId", isEqualTo: futureSnapshot.data.uid)
                .snapshots(),
            builder: (context, streamSnapshot) {
              if (streamSnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final userData = streamSnapshot.data.documents;
              print(userData[0]['image_url']);
              return Drawer(
                child: Container(
                  color: Colors.white,
                  child: ListView(
                    children: <Widget>[
                      UserAccountsDrawerHeader(
                        decoration: BoxDecoration(color: Theme.of(context).primaryColor),
                        accountEmail: Text(userData[0]['email']),
                        accountName: Text(userData[0]['username'],
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        currentAccountPicture: CircleAvatar(
                          backgroundColor: Colors.black,
                          backgroundImage: userData[0]['image_url'] == null
                              ? NetworkImage(
                                  'https://pluspng.com/img-png/user-png-icon-male-user-icon-512.png')
                              : NetworkImage(userData[0]['image_url']),
                        ),
                      ),
                      Card(
                        elevation: 0,
                        color: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: ListTile(
                          leading: Container(
                              padding: EdgeInsets.only(top: 0),
                              child: Icon(Icons.account_box,
                                  size: 30,
                                  color: Colors.green[50])),
                          title: Text(
                            'Profile',
                            style: TextStyle(fontSize: 20, color: Colors.green[50]),
                          ),
                          trailing: Icon(Icons.arrow_forward,
                              color: Colors.green),
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.of(context)
                                .pushNamed(ProfileScreen.routeName);
                          },
                        ),
                      ),
                      Card(
                        elevation: 0,
                        color: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: ListTile(
                          leading: Container(
                              padding: EdgeInsets.only(top: 0),
                              child: Icon(Icons.add_circle,
                                  size: 30,
                                  color: Colors.green[50])),
                          title: Text(
                            'Add Item',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.green[50]),
                          ),
                          trailing: Icon(Icons.arrow_forward,
                              color: Colors.green),
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pushNamed(AddItem.routeName);
                          },
                        ),
                      ),
                      Card(
                        elevation: 0,
                        color: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: ListTile(
                          leading: Container(
                              padding: EdgeInsets.only(top: 0),
                              child: Icon(Icons.exit_to_app,
                                  size: 30,
                                  color: Colors.green[50])),
                          title: Text(
                            'Log Out',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.green[50]),
                          ),
                          trailing: Icon(Icons.arrow_forward,
                              color: Colors.green),
                          onTap: () {
                            signOut();
                          },
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      body: CategoryScreen(),
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
