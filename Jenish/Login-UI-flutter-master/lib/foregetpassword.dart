import 'package:flutter/material.dart';
import 'package:loginuicolors/confirmpassword.dart';
import 'package:loginuicolors/login.dart';
import 'package:http/http.dart' as http;
import 'package:loginuicolors/models/OtpModel.dart';
import 'package:loginuicolors/models/SendEmail.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class forgetpass extends StatefulWidget {

  const forgetpass({Key? key}) : super(key: key);

  @override
  State<forgetpass> createState() => _forgetpassState();
}

Future<SendEmail?> submitData(String email) async {
  try {
    final response = await http
        .post(Uri.parse('http://192.168.1.10:8000/user/sendEmail'), body: {
      "email": email,
    });

    var data = json.decode(response.body) as Map;
    print(data);

    if (response.statusCode == 200) {
      String responseString = response.body;
      sendEmailFromJson(responseString);
    } else
      return null;
  } catch (error) {
    print(error);
  }
}

Future<OtpModel?> submitOtpData(String user_id,String u_otp) async {
  try {
    final response = await http
        .post(Uri.parse('http://192.168.1.10:8000/user/matchOTP'), body: {
      "user_id": user_id,
      "u_otp":u_otp
    });

    var data = json.decode(response.body) as Map;
    print(data);

    if (response.statusCode == 200) {
      String responseString = response.body;
      sendEmailFromJson(responseString);
    } else
      return null;
  } catch (error) {
    print(error);
  }
}


class _forgetpassState extends State<forgetpass> {
  get style => null;
  bool _isShow = false;

  SendEmail? _sendEmailModel;
  TextEditingController emailCon = TextEditingController();
  OtpModel? _otpModel;
  TextEditingController otpCon = TextEditingController();

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
                        controller: emailCon,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                          height: 50, //height of button
                          width: 200, //width of button
                          child: ElevatedButton(

                            onPressed: () async {

                              String email = emailCon.text;

                              SendEmail? data = await submitData(email);

                              setState(() {
                                _sendEmailModel = data;
                                _isShow = !_isShow;
                              });
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
                      Visibility(
                        visible: _isShow,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              hintText: "OTP",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                          controller: otpCon,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Visibility(
                        visible: _isShow,
                        child: SizedBox(
                            height: 50, //height of button
                            width: 200, //width of button
                            child: ElevatedButton(
                              onPressed: () async{

                                String u_otp = otpCon.text;

                                var sharedPref = await SharedPreferences.getInstance();
                                String? user_id = sharedPref.getString('id');

                                OtpModel? data = await submitOtpData(user_id!, u_otp);

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                      const confirmpass()),
                                );
                                setState(() {
                                  _otpModel = data;
                                });


                              },
                              child: const Text(
                                'Submit',
                                style: TextStyle(fontSize: 20),
                              ),
                            )),
                      )
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
