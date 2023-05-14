import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'login.dart';
import 'main.dart';
import 'main_dashboard.dart';
import 'package:easy_dashboard/easy_dashboard.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  static const routeName = "./dashboard";

  signOut() async {
   Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        // automaticallyImplyLeading: false,
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            signOut();
          },
          child: Icon(Icons.logout_rounded),
          backgroundColor: Colors.green,
        ),
        // body: Center(
        //   child: ElevatedButton(
        //     // Within the `FirstScreen` widget
        //     onPressed: () {
        //       // Navigate to the second screen using a named route.
        //       Navigator.pushNamed(context, '/crud');
        //     },
        //     child: const Text('Launch screen'),
        //   ),
        // ),
      // body: const Center(child: Text('Dashboard')),
      // body: const Center(child: MainDashBoard()),
      body: const MainDashBoard(),
      drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text('Menu'),
              ),
              ListTile(
                title: const Text('User'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/user');
                },
              ),
              ListTile(
                title: const Text('Gói'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/package');
                },
              ),
              ListTile(
                title: const Text(
                  'LOG OUT',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                  signOut();
                },
              ),
            ],
          ),
        )
    );
  }
}
