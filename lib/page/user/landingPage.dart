import 'package:flutter/material.dart';
import 'package:tubes/page/user/login.dart';
import 'package:tubes/page/user/register.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  Widget _space(double height) {
    return SizedBox(height: height);
  }

  Widget _buttonLoginAndRegister(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        logo(80),
        Row(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Login()),
                );
              },
              child: const Text(
                "Login",
                style: TextStyle(color: Colors.black),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    const Color.fromRGBO(255, 241, 218, 1)),
              ),
            ),
            const SizedBox(width: 10),
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Register()),
                  );
                },
                child: const Text(
                  "Register",
                  style: TextStyle(color: Colors.black),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Color.fromRGBO(255, 241, 218, 1)),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _textColumn(context) {
    return Container(
      margin: const EdgeInsets.only(top: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "PROPERTY TERBAIK DI LOMBOK",
            style: TextStyle(color: Colors.red),
          ),
          const SizedBox(height: 20),
          const SizedBox(
            width: 200,
            child: Text(
              "Lombok Vacation Property",
              style: TextStyle(fontSize: 24),
            ),
          ),
          _space(20),
          const SizedBox(
            width: 250,
            child: Text(
              "Lombok merupakan pulau yang indah terletak di Nusa Tenggara Barat Indonesia",
              style: TextStyle(color: Colors.grey),
            ),
          ),
          _space(20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Register()),
              );
            },
            child: const Text("Find Out More",
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

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
              _buttonLoginAndRegister(context),
              Container(
                child: _textColumn(context),
              ),
              Container(
                height: 300,
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.all(10),
                child: Image.asset('assets/images/orang.png'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
