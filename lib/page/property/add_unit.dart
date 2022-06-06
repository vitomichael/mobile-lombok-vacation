import 'package:flutter/material.dart';
import 'package:tubes/page/home/home.dart';
import 'package:tubes/page/home/property.dart';
import 'package:tubes/page/property/add_property.dart';
import 'package:tubes/page/user/register.dart';

class AddUnit extends StatefulWidget {
  const AddUnit({Key? key}) : super(key: key);

  @override
  State<AddUnit> createState() => _AddUnitState();
}

class _AddUnitState extends State<AddUnit> {
  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    TextEditingController priceController = TextEditingController();
    TextEditingController totalController = TextEditingController();
    TextEditingController pictureController = TextEditingController();
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
            TopBarWithBackButton(context),
            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.fromLTRB(40, 0, 0, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Lombok Vacation",
                      style: TextStyle(color: Colors.grey, fontSize: 14)),
                  const SizedBox(height: 10),
                  const Text("Tambah Unit",
                      style: TextStyle(color: Colors.black87, fontSize: 36)),
                ],
              ),
            ),
            inputText(nameController, "Nama Unit"),
            inputText(descriptionController, "Description"),
            inputText(totalController, "Total Unit"),
            inputText(priceController, "Price"),
            Container(
              height: 25,
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
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
                      'Tambah Unit',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AddUnit()),
                  );
                },
              ),
            )
          ],
        ),
      ),
    ));
  }
}
