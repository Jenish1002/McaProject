import 'package:flutter/material.dart';

class home_page extends StatefulWidget {
  const home_page({Key? key}) : super(key: key);

  @override
  _home_pageState createState() => _home_pageState();
}

class _home_pageState extends State {
  int _selectedTab = 0;

  List _pages = [
    Center(
      child: Container(),
    ),
    Center(
      child: Text("About"),
    ),
    Center(
      child: Text("Products"),
    ),
    Center(
      child: Text("Contact"),
    ),
  ];

  _changeTab(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "App Name",
        ),
      ),
      body: _pages[_selectedTab],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        onTap: (index) => _changeTab(index),
        iconSize: 30,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            backgroundColor: Colors.black,
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_3x3_outlined),
            backgroundColor: Colors.black,
            label: "Product",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.contact_mail),
              backgroundColor: Colors.black,
              label: "Contact"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              backgroundColor: Colors.black,
              label: "About"),
        ],
      ),
    );
  }
}
