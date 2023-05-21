import 'package:flutter/material.dart';
import 'package:amazon/crud.dart';
import 'package:amazon/my_account.dart';
import 'package:amazon/signup.dart';
import 'package:amazon/signup_option.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:google_fonts/google_fonts.dart';

import 'AddUserPage.dart';
import 'User.dart';
import 'home.dart';
import 'login.dart';
import 'login_option.dart';
import 'Dashboard.dart';
import 'package.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amazon System',
      initialRoute: '/',
      routes: {
        '/dashboard': (context) => const DashBoard(),
        '/authen': (context) => const Login(),
        '/home': (context) => const HomePage(),
        '/user': (context) => const UserPage(),
        '/package': (context) => const PackagePage(),
        '/myaccount': (context) => const ProfileScreen(),
        '/addUser': (context) => AddUserPage(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.muktaVaaniTextTheme(),
      ),
      debugShowCheckedModeBanner: false,
      // routes: {
      //   Login.routeName: (context) => Login(),
      //   DashBoard.routeName: (context) => DashBoard(),
      // },
      home: const HomePage(),
    );
  }
}
