import 'package:flutter/material.dart';
import 'package:tubes/page/home/home.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

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
                margin: const EdgeInsets.only(left: 60),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Lombok Vacation",
                        style: TextStyle(color: Colors.grey, fontSize: 18)),
                    const SizedBox(height: 10),
                    const Text(
                      "Welcome",
                      style: TextStyle(color: Colors.black87, fontSize: 45),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 150,
                      child: Image.asset(
                        'assets/images/hotel.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 20),
                    SizedBox(
                      height: 150,
                      child: Image.asset(
                        'assets/images/villa.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 150,
                      child: Image.asset(
                        'assets/images/cottage.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 20),
                    SizedBox(
                      height: 150,
                      child: Image.asset(
                        'assets/images/guesthouse.png',
                        fit: BoxFit.cover,
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
