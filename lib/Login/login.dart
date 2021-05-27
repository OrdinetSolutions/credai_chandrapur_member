import 'dart:convert';
import 'package:credai_chandrapur_member/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

import '../urls.dart';

class login extends StatefulWidget {
  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  SharedPreferences prefLoginData;

  showCheckLogin(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Image.asset(
            ("assets/loader.gif"),
            width: 50,
            height: 50,
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Member Login"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: Container(
                    width: 200,
                    height: 150,
                    /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    child: Image.asset('assets/credai_logo.jpg')),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                controller: usernameController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                    hintText: 'Enter valid Username'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter secure password'),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(20)),
              child: FlatButton(
                onPressed: () async {

                  final String username = usernameController.text;
                  final String password = passwordController.text;

                  prefLoginData = await SharedPreferences.getInstance();

                  if(username == ""){
                    Toast.show("Please enter Username", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.CENTER);
                  }else if(password == ""){
                    Toast.show("Please enter Password", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.CENTER);
                  } else{
                    showCheckLogin(context);

                    List data;
                    var response = await http.post(Uri.parse(Urls.checkLogin),
                        body: {
                          "username": username,
                          "password": password
                        },
                        headers: {"Accept": "application/json"});

                    print(response.body);
                    setState(() {
                      var convertDataTojson = jsonDecode(response.body.toString());
                      if(convertDataTojson == 0)
                      {
                        print("Invalid Username/Password");
                        Toast.show("Invalid Username/Password", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.CENTER);
                        Navigator.pop(context, true);
                      }else{
                        data = convertDataTojson['members'];
                        prefLoginData.setString("id", data[0]["id"]);
                        print(prefLoginData.getString("id"));
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => home()), (_) => false);
                      }

                    });
                  }
                },
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
