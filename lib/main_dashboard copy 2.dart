import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'crud.dart';
import 'main.dart';

class MainDashBoard extends StatefulWidget {
  const MainDashBoard({Key? key}) : super(key: key);

  @override
  _MainDashBoardState createState() => _MainDashBoardState();
}

class _MainDashBoardState extends State<MainDashBoard> {
  final Color accentColor = const Color(0XFFFA2B0F);

  List<ItemModel> items = [
    ItemModel("Manager", 12, 1830),
    ItemModel("Thống Kê", 12, 1830),
    ItemModel("Tài khoản", 2, 326),
  ];

  signOut() async {
    // Navigator.pushReplacement(
    //     context, MaterialPageRoute(builder: (context) => Crud()));
    Navigator.pushNamed(context, '/crud');
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  Widget _buildTitle() {
    return const Text(
      "Home",
      style: TextStyle(
          fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
    );
  }

  Text _buildText(String title) {
    return Text(
      title,
      style: const TextStyle(
          fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
    );
  }

  IconButton _buildButton(IconData icon) {
    return IconButton(
      onPressed: () {},
      icon: Icon(
        icon,
        color: Colors.white,
      ),
    );
  }

  Widget _buildBottomCardChildren() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        // Row(
        //   children: <Widget>[
        //     _buildText("All"),
        //     const Spacer(),
        //     _buildText("Done")
        //   ],
        // ),
        Container(
          height: 24,
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: <Widget>[
        //     _buildButton(Icons.radio_button_checked),
        //     _buildButton(Icons.home),
        //     _buildButton(Icons.settings),
        //   ],
        // )
      ],
    );
  }

  Widget _buildBottomCard(double width, double height) {
    return Container(
      width: width,
      height: height / 3,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      decoration: const BoxDecoration(
          color: Colors.indigo,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(16), topLeft: Radius.circular(16))),
      child: _buildBottomCardChildren(),
    );
  }

  Widget _buildItemCardChild(ItemModel item) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              item.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              item.numOne.toString(),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            )
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.pie_chart,
              color: accentColor,
            )
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              onPressed: () {
                // signOut();
              },
              icon: const Icon(
                Icons.menu,
                color: Colors.grey,
              ),
            ),
            Text(
              item.numTwo.toString(),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildItemCard(ItemModel item) {
    return Container(
      width: 120,
      height: 145,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      margin: const EdgeInsets.only(left: 32, right: 32, top: 2, bottom: 2),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(16)),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 1)]),
      child: _buildItemCardChild(item),
    );
  }

  Widget _buildCardsList() {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        var item = items.elementAt(index);
        return _buildItemCard(item);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey[300],
        title: _buildTitle(),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications,
              color: Colors.blueGrey,
            ),
          )
        ],
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 16),
        child: Stack(
          children: <Widget>[
            Align(
                alignment: Alignment.bottomCenter,
                child: _buildBottomCard(width, height)
                ),
            _buildCardsList(),
          ],
        ),
      ),
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
                title: const Text('Item 1'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Item 2'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
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

class ItemModel {
  final String title;
  final int numOne;
  final int numTwo;

  ItemModel(this.title, this.numOne, this.numTwo);
}
