// drawer.dart
import 'package:amazon/home.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    signOut() async {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    }

    return Drawer(
      elevation: 6,
      child: Column(children: [
        const SizedBox(height: 100),
        ListTile(
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/myaccount');
          },
          leading: const Icon(Icons.account_circle),
          title: const Text(
            'My Account',
            style: TextStyle(fontSize: 20),
          ),
        ),
        ListTile(
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/user');
          },
          leading: const Icon(Icons.supervised_user_circle),
          title: const Text(
            'User',
            style: TextStyle(fontSize: 20),
          ),
        ),
        ListTile(
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/package');
          },
          leading: const Icon(Icons.contact_mail),
          title: const Text(
            'Gói',
            style: TextStyle(fontSize: 20),
          ),
        ),
        ListTile(
          title: const Text(
            'LOG OUT',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          onTap: () {
            Navigator.pop(context);
            signOut();
          },
        ),
      ]),
    );
  }
}
