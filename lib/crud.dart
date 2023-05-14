import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'User.dart';
import 'login.dart';
import 'main.dart';
import 'main_dashboard.dart';

class Crud extends StatefulWidget {
  const Crud({Key? key}) : super(key: key);
  @override
  _CrudState createState() => _CrudState();
}

class _CrudState extends State<Crud> {
  static const routeName = "./crud";

  signOut() async {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            signOut();
          },
          child: Icon(Icons.logout_rounded),
          backgroundColor: Colors.green,
        ),
        // body: const Center(child: Text('Crud')),
        body: const UserPage(),
        // drawer: Drawer(
        //   // Add a ListView to the drawer. This ensures the user can scroll
        //   // through the options in the drawer if there isn't enough vertical
        //   // space to fit everything.
        //   child: ListView(
        //     // Important: Remove any padding from the ListView.
        //     padding: EdgeInsets.zero,
        //     children: [
        //       const DrawerHeader(
        //         decoration: BoxDecoration(
        //           color: Colors.blue,
        //         ),
        //         child: Text('Menu'),
        //       ),
        //       ListTile(
        //         title: const Text('User'),
        //         onTap: () {
        //           // Update the state of the app
        //           // ...
        //           // Then close the drawer
        //           Navigator.pop(context);
        //           Navigator.pushNamed(context, '/crud');
        //         },
        //       ),
        //       ListTile(
        //         title: const Text('Gói'),
        //         onTap: () {
        //           // Update the state of the app
        //           // ...
        //           // Then close the drawer
        //           Navigator.pop(context);
        //           Navigator.pushNamed(context, '/package');
        //         },
        //       ),
        //       ListTile(
        //         title: const Text(
        //           'LOG OUT',
        //           style: TextStyle(
        //             fontSize: 20,
        //           ),
        //         ),
        //         onTap: () {
        //           // Update the state of the app
        //           // ...
        //           // Then close the drawer
        //           Navigator.pop(context);
        //           signOut();
        //         },
        //       ),
        //     ],
        //   ),
        // )
        );
  }
}
