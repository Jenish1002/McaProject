import 'package:flutter/material.dart';
import 'package:loginuicolors/foregetpassword.dart';
import 'package:loginuicolors/models/LoginModel.dart';
import 'package:http/http.dart' as http;
import 'package:loginuicolors/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  _MyLoginState createState() => _MyLoginState();
}

Future<LoginModel?> submitData(String email, String password) async {
  try {
    final response = await http.post(
        Uri.parse('http://192.168.1.10:8000/user/Login'),
        body: {"email": email, "password": password});

    var data = response.body;
    print(data);

    if (response.statusCode == 200) {
      String responseString = response.body;
      loginModelFromJson(responseString);
    } else
      return null;
  } catch (error) {
    print(error);
  }
}

class _MyLoginState extends State<MyLogin> {
  LoginModel? _loginModel;
  TextEditingController emailCon = TextEditingController();
  TextEditingController passCon = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/login.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(),
            Container(
              padding: EdgeInsets.only(left: 60, top: 130),
              child: Text(
                'App Name',
                style: TextStyle(color: Colors.white, fontSize: 33),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 35, right: 35),
                      child: Column(
                        children: [
                          Text(
                            'Sign In',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 40,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 60,
                          ),
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
                          TextField(
                            style: TextStyle(),
                            obscureText: true,
                            decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "Password",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                            controller: passCon,
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Color(0xff4c505b),
                                child: IconButton(
                                    color: Colors.white,
                                    onPressed: () async {
                                      var sharedPref =
                                          await SharedPreferences.getInstance();
                                      sharedPref.setBool(
                                          splash_screenState.KEYLOGIN, true);

                                      String email = emailCon.text;
                                      String password = passCon.text;

                                      LoginModel? data =
                                          await submitData(email, password);
                                      Navigator.pushNamed(context, 'home');
                                      setState(() {
                                        _loginModel = data;
                                      });
                                    },
                                    icon: Icon(
                                      Icons.arrow_forward,
                                    )),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, 'home');
                                },
                                child: Text(
                                  'Sign Up',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Color(0xff4c505b),
                                      fontSize: 22),
                                ),
                                style: ButtonStyle(),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const forgetpass()),
                                    );
                                  },
                                  child: Text(
                                    'Forgot Password',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Color(0xff4c505b),
                                      fontSize: 18,
                                    ),
                                  )),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
