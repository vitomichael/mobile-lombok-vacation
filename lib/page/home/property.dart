import 'package:flutter/material.dart';
import 'package:tubes/page/home/home.dart';

class Property extends StatelessWidget {
  const Property({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  children: [
                    const Text("Lombok Vacation",
                        style: TextStyle(color: Colors.grey, fontSize: 14)),
                    const SizedBox(height: 10),
                    const Text(
                      "Property",
                      style: TextStyle(color: Colors.black87, fontSize: 36),
                    ),
                    Container(
                      height: 25,
                      margin: const EdgeInsets.fromLTRB(0, 10, 40, 10),
                      child: ElevatedButton(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 16,
                            ),
                            const SizedBox(width: 7),
                            const Text(
                              'Tambah Property',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
