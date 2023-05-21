import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:session_storage/session_storage.dart';
import 'package:http/http.dart' as http;

class ProfileScreen extends StatefulWidget {
  static const routeName = './myaccount';
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<Map<String, dynamic>> _allData = [];

  bool _isLoading = true;

  void _refreshData() async {
    final session = SessionStorage();
    var id = session["userid"];
    var baseUrl = dotenv.env['API_URL'];
    var url = Uri.http(baseUrl.toString(), '/user/profile', {'q': '{http}'});
    var body = json.encode({'id': id});
    var response = await http.post(url, body: body);
    int code = response.statusCode;
    String status = '';
    if (response.statusCode == 200) {
      // print(code);
      var jsonResponse = json.decode(response.body);
      List<dynamic> originalData = jsonResponse['data'];
      List<Map<String, dynamic>> user = originalData.map((item) {
        return {
          'id': item['id'],
          'fullname': item['fullname'],
          'email': item['email'],
          'role': item['role'],
        };
      }).toList();

      setState(() {
        _allData = user;
        _isLoading = false;
      });
    } else {
      print('Request failed with status code: ${response.statusCode}');
    }
  }

  Future _updateUser(int id) async {
    var url = Uri.http('192.168.50.150:8080', '/user/edit', {'q': '{http}'});
    var body = json.encode({
      'id': id,
      'name': _fullnameController.text,
      'email': _emailController.text,
      'password': _passwordController.text,
    });
    var response = await http.post(url, body: body);
    // var data = json.decode(response.body);
    int code = response.statusCode;
    String status = '';
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      print('here');
      status = jsonResponse['status'];
      if (status == 'ok') {
        _refreshData();
      }
    }
  }

  void showBottomSheet(int? id) async {
    if (id != null) {
      final existingData =
          _allData.firstWhere((element) => element['id'] == id);
      _fullnameController.text = existingData['fullname'];
      _emailController.text = existingData['email'];
      _passwordController.text = existingData['password'];
    }

    showModalBottomSheet(
      elevation: 5,
      isScrollControlled: true,
      context: context,
      builder: (_) => Container(
        padding: EdgeInsets.only(
          top: 30,
          left: 15,
          right: 15,
          bottom: MediaQuery.of(context).viewInsets.bottom + 50,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              readOnly: true,
              controller: _fullnameController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'fullname'),
            ),
            SizedBox(height: 10),
            TextField(
              readOnly: true,
              controller: _emailController,
              maxLines: 4,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'email'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'password'),
            ),
            SizedBox(height: 10),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  if (id != null) {
                    await _updateUser(id);
                  }
                  _fullnameController.text = "";
                  _emailController.text = "";
                  _passwordController.text = "";
                  Navigator.of(context).pop();
                  print("data added");
                },
                child: Padding(
                  padding: EdgeInsets.all(18),
                  child: Text(
                    id == null ? "Add" : "Update Password",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Account'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 40),
            const CircleAvatar(
              radius: 70,
              backgroundImage: AssetImage('assets/images/user.jpg'),
            ),
            const SizedBox(height: 20),
            // itemProfile('Name', _allData[0]['fullname'], CupertinoIcons.person),
            itemProfile(
                'Name',
                _allData.isNotEmpty ? _allData[0]['fullname'] : '',
                CupertinoIcons.person),
            // const SizedBox(height: 10),
            // itemProfile('Phone', '03107085816', CupertinoIcons.phone),
            const SizedBox(height: 10),
            // itemProfile(
            //     'Address', 'abc address, xyz city', CupertinoIcons.location),
            itemProfile('Role', _allData.isNotEmpty ? _allData[0]['role'] : '',
                CupertinoIcons.arrow_up_arrow_down_square),
            const SizedBox(height: 10),
            itemProfile('Email', _allData.isNotEmpty ? _allData[0]['email'] : '', CupertinoIcons.mail),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    showBottomSheet(_allData[0]['id']);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(15),
                  ),
                  child: const Text('Edit Profile')),
            )
          ],
        ),
      ),
    );
    // TODO: implement build
    throw UnimplementedError();
  }

  itemProfile(String title, String subtitle, IconData iconData) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 5),
                color: Colors.deepOrange.withOpacity(.2),
                spreadRadius: 2,
                blurRadius: 10)
          ]),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: Icon(iconData),
        trailing: Icon(Icons.arrow_forward, color: Colors.grey.shade400),
        tileColor: Colors.white,
      ),
    );
  }
}
