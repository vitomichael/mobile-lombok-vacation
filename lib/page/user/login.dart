import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tubes/page/home/home.dart';
import 'package:tubes/page/user/register.dart';

import 'package:tubes/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:async';

Future<UserModel> login(String email, String password) async {
  try {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var url = Uri.parse('http://localhost:8000/api/login');
    var response = await http.post(url,
        body:
            jsonEncode(<String, String>{'email': email, 'password': password}),
        headers: requestHeaders);

    if (response.statusCode == 200) {
      var body = UserModel.fromJson(jsonDecode(response.body));

      final token = body.token;

      final prefs = await SharedPreferences.getInstance();

      await prefs.setString('token', 'Bearer $token');
      await prefs.setInt('userId', body.id);
      await prefs.setString('name', body.name);
      await prefs.setString('email', body.email);
      await prefs.setString('phone', body.phone);
      await prefs.setString('role', body.role);

      return body;
    } else {
      throw Exception("Email / password salah");
    }
  } catch (e) {
    rethrow;
  }
}

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            logo(150),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'Log in',
                style: TextStyle(fontSize: 20),
              ),
            ),
            inputText(emailController, "Email"),
            inputText(passwordController, "Password"),
            const SizedBox(height: 10),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    try {
                      UserModel log = await login(
                          emailController.text, passwordController.text);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Home()),
                      );
                    } catch (e) {
                      print(e);
                    }
                  },
                )),
            Row(
              children: <Widget>[
                const Text('Does not have account?'),
                TextButton(
                  child: const Text(
                    'Sign in',
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Register()),
                    );
                  },
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ],
        ),
      ),
    );
  }
}
