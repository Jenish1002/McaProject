import 'package:flutter/material.dart';
import 'package:loginuicolors/confirmpassword.dart';
import 'package:loginuicolors/login.dart';

class forgetpass extends StatefulWidget {
  const forgetpass({Key? key}) : super(key: key);

  @override
  State<forgetpass> createState() => _forgetpassState();
}

class _forgetpassState extends State<forgetpass> {
  get style => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Colors.grey,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black38,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MyLogin()),
            );
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 60, left: 40, right: 40),
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Reset Password',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: Column(
                    children: <Widget>[
                      TextField(
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            hintText: "Email",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                          height: 50, //height of button
                          width: 200, //width of button
                          child: ElevatedButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text('Email has been Send!'),
                              ));
                            },
                            child: const Text(
                              'Submit',
                              style: TextStyle(fontSize: 20),
                            ),
                          )),
                      SizedBox(
                        height: 30,
                      ),
                      TextField(
                        keyboardType: TextInputType.number,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            hintText: "OTP",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                          height: 50, //height of button
                          width: 200, //width of button
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const confirmpass()),
                              );
                            },
                            child: const Text(
                              'Submit',
                              style: TextStyle(fontSize: 20),
                            ),
                          )),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
