import 'package:flutter/material.dart';
import 'package:amazon/drawer.dart';
import 'User.dart';
import 'home.dart';

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
        drawer: const MyDrawer(),
        );
  }
}
