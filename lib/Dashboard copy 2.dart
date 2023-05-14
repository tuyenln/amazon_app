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
        automaticallyImplyLeading: false,
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
      // body: const MainDashBoard(),
    );
  }
}
