import 'package:flutter/material.dart';
import 'package:tubes/models/user_model.dart';
import 'package:tubes/page/home/home.dart';
import 'package:tubes/page/property/edit_property.dart';
import 'package:tubes/page/user/landingPage.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

Future<UserModel> edit(String name, String email, String phone) async {
  try {
    final prefs = await SharedPreferences.getInstance();

    final String? token = prefs.getString('token');
    final int? userId = prefs.getInt('userId');

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token ?? ''
    };
    var url = Uri.parse('http://localhost:8000/api/update-profile/$userId');
    var response = await http.put(url,
        body: jsonEncode(
            <String, dynamic>{'name': name, 'email': email, 'no_hp': phone}),
        headers: requestHeaders);

    if (response.statusCode == 200) {
      var body = UserModel.fromJson(jsonDecode(response.body));
      print(body.name);
      final prefs = await SharedPreferences.getInstance();

      await prefs.setString('name', body.name);
      await prefs.setString('email', body.email);
      await prefs.setString('phone', body.phone);

      return body;
    } else {
      throw Exception(response.statusCode);
    }
  } catch (e) {
    rethrow;
  }
}

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  UserModel? userData;
  bool isLoading = true;
  void getUserData() async {
    final prefs = await SharedPreferences.getInstance();

    var id = prefs.getInt('userId') ?? 0;
    var name = prefs.getString('name') ?? '';
    var email = prefs.getString('email') ?? '';
    var phone = prefs.getString('phone') ?? '';
    var role = prefs.getString('role') ?? '';

    setState(() {
      userData = UserModel(
          id: id,
          name: name,
          email: email,
          phone: phone,
          role: role,
          token: '');
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    // nameController.text = widget.property.name;
    var name = userData?.name ?? "";
    var email = userData?.email ?? "";
    var phone = userData?.phone ?? "";

    nameController.text = name;
    emailController.text = email;
    phoneController.text = phone;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/cover.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              TopBar(),
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.fromLTRB(40, 0, 0, 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Lombok Vacation",
                        style: TextStyle(color: Colors.grey, fontSize: 14)),
                    SizedBox(height: 10),
                    Text("Edit Profile",
                        style: TextStyle(color: Colors.black87, fontSize: 36)),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.orange),
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
                child: TextFormField(
                  autofocus: false,
                  controller: nameController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: "Name",
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.orange),
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
                child: TextFormField(
                  autofocus: false,
                  controller: emailController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: "Email",
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.orange),
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
                child: TextFormField(
                  autofocus: false,
                  controller: phoneController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: "Phone",
                  ),
                ),
              ),
              Container(
                height: 25,
                margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: ElevatedButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.edit_outlined,
                        color: Colors.white,
                        size: 16,
                      ),
                      SizedBox(width: 7),
                      Text(
                        'Edit Profile',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  onPressed: () async {
                    try {
                      await edit(nameController.text, emailController.text,
                          phoneController.text);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Home()),
                      );
                    } catch (e) {
                      print(e);
                    }
                  },
                ),
              ),
              Container(
                height: 25,
                margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.logout_outlined,
                        color: Colors.white,
                        size: 16,
                      ),
                      SizedBox(width: 7),
                      Text(
                        'Log out',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LandingPage()),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
