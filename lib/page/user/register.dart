import 'package:flutter/material.dart';
import 'package:tubes/page/user/login.dart';

import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';

Future<String> register(
    String name, String email, String password, String phone) async {
  try {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    var url = Uri.parse('http://localhost:8000/api/register');
    var response = await http.post(url,
        body: jsonEncode(<String, String>{
          'name': name,
          'email': email,
          'password': password,
          'no_hp': phone
        }),
        headers: requestHeaders);

    if (response.statusCode == 200) {
      return "Success";
    } else {
      throw Exception("Gagal mendaftar, coba lagi");
    }
  } catch (e) {
    rethrow;
  }
}

Widget inputText(TextEditingController controller, String label) {
  return Container(
    padding: const EdgeInsets.all(10),
    child: TextField(
      obscureText: label == "Password" ? true : false,
      controller: controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: label,
      ),
    ),
  );
}

Widget logo(double height) {
  return Container(
    height: height,
    alignment: Alignment.center,
    padding: const EdgeInsets.all(10),
    child: Image.asset('assets/images/logo.png'),
  );
}

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
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
                'Register',
                style: TextStyle(fontSize: 20),
              ),
            ),
            inputText(nameController, "Name"),
            inputText(emailController, "Email"),
            inputText(passwordController, "Password"),
            inputText(phoneController, "Phone"),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: ElevatedButton(
                  child: const Text('Register'),
                  onPressed: () async {
                    String log = await register(
                        nameController.text,
                        emailController.text,
                        passwordController.text,
                        phoneController.text);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Login()),
                    );
                  },
                )),
            Row(
              children: <Widget>[
                const Text('Have an account?'),
                TextButton(
                  child: const Text(
                    'Log in',
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Login()),
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
