import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tubes/page/home/dashboard.dart';
import 'package:tubes/page/home/profile.dart';
import 'package:tubes/page/home/property.dart';
import 'package:tubes/page/user/register.dart';

Widget TopBar() {
  Future<String> _getName() async {
    final prefs = await SharedPreferences.getInstance();

    final String? name = prefs.getString('name');

    return name!;
  }

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      logo(80),
      Row(
        children: [
          FutureBuilder(
              future: _getName(),
              builder: (context, AsyncSnapshot<String> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Text(snapshot.data!);
                }
                return const Text("");
              }),
          Container(
              margin: const EdgeInsets.only(right: 10),
              child: const Icon(Icons.arrow_drop_down)),
        ],
      ),
    ],
  );
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 1;

  static const List<Widget> _widgetOptions = <Widget>[
    Dashboard(),
    Property(),
    Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Property',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
