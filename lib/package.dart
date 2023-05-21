import 'dart:convert';
import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'User.dart';
import 'login.dart';
import 'main.dart';
import 'main_dashboard.dart';
import 'package:http/http.dart' as http;

class PackagePage extends StatefulWidget {
  const PackagePage({Key? key}) : super(key: key);

  @override
  State<PackagePage> createState() => _PackagePageState();
}

class _PackagePageState extends State<PackagePage> {
  List<Map<String, dynamic>> _allData = [];

  bool _isLoading = true;

  void _refreshData() async {
    var url = Uri.http('192.168.50.150:8080', '/package/list', {'q': '{http}'});
    var body = json.encode({});
    var response = await http.get(url);
    // var data = json.decode(response.body);
    // print(body);
    int code = response.statusCode;
    String status = '';
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      // print(jsonResponse['data']);
      // status = jsonResponse['status'];
      // int code = jsonResponse['code'];
      // String message = jsonResponse['message'];
      // // print(message);
      // // Map<String, dynamic> data = jsonResponse['data'];
      // List<Map<String, dynamic>> packages = jsonResponse['data'];
      // var packages = json.decode(jsonResponse['data']);
      // var packages = jsonResponse['data'];
      // print(packages);
      // String id = packages['id'];
      // String name = packages['name'];
      // String description = packages['description'];
      // String price = data['price'];

      // var packages = [
      //   {
      //     'name': 'John',
      //     'age': 25,
      //     'isStudent': true,
      //   },
      //   {
      //     'name': 'Alice',
      //     'age': 30,
      //     'isStudent': false,
      //   },
      //   {
      //     'name': 'Bob',
      //     'age': 35,
      //     'isStudent': true,
      //   },
      // ];

      List<dynamic> originalData = jsonResponse['data'];

      List<Map<String, dynamic>> packages = originalData.map((item) {
        return {
          'id': item['id'],
          'name': item['name'],
          'description': item['description'],
          'price': item['price'],
        };
      }).toList();
      print(packages);

      setState(() {
        _allData = packages;
        _isLoading = false;
      });
    } else {
      print('Request failed with status code: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  Future<void> _addPackage() async {
    var url = Uri.http('192.168.50.150:8080', '/package/add', {'q': '{http}'});
    var body = json.encode({
      'name': _titleController.text,
      'description': _descriptionController.text,
      'price': _priceController.text,
    });
    var response = await http.post(url, body: body);
    // var data = json.decode(response.body);
    int code = response.statusCode;
    String status = '';
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      status = jsonResponse['status'];
      if (status == 'ok') {
        _refreshData();
      }
    }
  }

  @override
  Future _updatePackage(int id) async {
    var url = Uri.http('192.168.50.150:8080', '/package/edit', {'q': '{http}'});
    var body = json.encode({
      'id': id,
      'name': _titleController.text,
      'description': _descriptionController.text,
      'price': _priceController.text,
    });
    var response = await http.post(url, body: body);
    // var data = json.decode(response.body);
    int code = response.statusCode;
    String status = '';
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      status = jsonResponse['status'];
      if (status == 'ok') {
        _refreshData();
      }
    }
  }

  void _deletePackage(int id) async {
    var url =
        Uri.http('192.168.50.150:8080', '/package/delete', {'q': '{http}'});
    var body = json.encode({"id": id});
    var response = await http.post(url, body: body);
    // var data = json.decode(response.body);
    int code = response.statusCode;
    print(code);
    String status = '';
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      status = jsonResponse['status'];
      if (status == 'ok') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              backgroundColor: Colors.redAccent, content: Text("Data deleted")),
        );
        _refreshData();
      }
    }
  }

  void showBottomSheet(int? id) async {
    if (id != null) {
      final existingData =
          _allData.firstWhere((element) => element['id'] == id);
      _titleController.text = existingData['name'];
      _descriptionController.text = existingData['description'];
      _priceController.text = existingData['price'];
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
              controller: _titleController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Name'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _descriptionController,
              maxLines: 4,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Description'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Price'),
            ),
            SizedBox(height: 10),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  if (id == null) {
                    await _addPackage();
                  }
                  if (id != null) {
                    await _updatePackage(id);
                  }
                  _titleController.text = "";
                  _descriptionController.text = "";
                  _priceController.text = "";

// Hide bottom sheet
                  Navigator.of(context).pop();
                  print("data added");
                },
                child: Padding(
                  padding: EdgeInsets.all(18),
                  child: Text(
                    id == null ? "Add" : "Update",
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crud package'),
        // title: const Text('Dashboard'),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _allData.length,
              itemBuilder: (context, index) => Card(
                    margin: EdgeInsets.all(15),
                    child: ListTile(
                      title: Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          _allData[index]['name'],
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      subtitle: Text(_allData[index]['description']),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () {
                                showBottomSheet(
                                    _allData[index]['id']);
                              },
                              icon: Icon(
                                Icons.edit,
                                color: Colors.indigo,
                              )),
                          IconButton(
                              onPressed: () {
                                _deletePackage(
                                    _allData[index]['id']);
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Colors.redAccent,
                              )),
                        ],
                      ),
                    ),
                  )),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showBottomSheet(null),
        child: Icon(Icons.add),
      ),
    );
  }
}
