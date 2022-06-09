import 'package:flutter/material.dart';
import 'package:tubes/page/home/home.dart';
import 'package:tubes/page/home/property.dart';
import 'package:tubes/page/user/landingPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lombok Vacation',
      theme: ThemeData(primarySwatch: Colors.orange),
      home: const LandingPage(),
    );
  }
}
