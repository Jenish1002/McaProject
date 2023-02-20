import 'dart:async';
import 'package:flutter/material.dart';
import 'package:loginuicolors/home.dart';
import 'package:loginuicolors/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class splash_screen extends StatefulWidget {
  const splash_screen({Key? key}) : super(key: key);

  @override
  State<splash_screen> createState() => splash_screenState();
}

class splash_screenState extends State<splash_screen> {
  static const String KEYLOGIN = "login";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    whereToGo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,
        child: Center(
          child: Icon(
            Icons.account_circle,
            color: Colors.white,
            size: 90,
          ),
        ),
      ),
    );
  }

  void whereToGo() async {
    var sharedPref = await SharedPreferences.getInstance();

    var isLogedIn = sharedPref.getBool(KEYLOGIN);

    Timer(
      Duration(seconds: 3),
      () {
        if (isLogedIn != null) {
          if (isLogedIn) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => home_page()));
          } else {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => MyLogin()));
          }
        } else {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MyLogin()));
        }
      },
    );
  }
}
