import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:we_hire/src/common_widget/from_home_widget/form_category_widget.dart';
import 'package:we_hire/src/constants/values.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
  static const String routeName = "/loginP";
}

class _LoginState extends State<LoginPage> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              Text(
                "Login",
                style: TextStyle(fontSize: 35),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.email)),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.email)),
              ),
              SizedBox(
                height: 20,
              ),
              OutlinedButton.icon(
                onPressed: () {
                  login(emailController.text.toString(),
                      passwordController.text.toString());
                },
                icon: Icon(Icons.login),
                label: Text("Login"),
              ),
            ],
          ),
        ),
      )),
    );
  }

  void login(String email, String password) async {
    if (passwordController.text.isNotEmpty && emailController.text.isNotEmpty) {
      final response = await http.post(
        Uri.parse('$apiServer/Account/Login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        // print("Logn Token" + body["token"]);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Token : ${body['token']}")));
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => CategoriesWidget()));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Inivalid Creadentials")));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Blank value found")));
    }
  }

  void pageRoute(String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString("login", token);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CategoriesWidget()));
  }
}
