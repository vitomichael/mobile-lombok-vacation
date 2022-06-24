import 'package:flutter/material.dart';
import 'package:tubes/models/property_model.dart';
import 'package:tubes/page/home/home.dart';
import 'package:tubes/page/property/add_property.dart';
import 'package:tubes/page/user/register.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tubes/models/unit_model.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

Future<UnitModel> add(int propertyId, String name, String description,
    int totalUnit, double price) async {
  try {
    final prefs = await SharedPreferences.getInstance();

    final String? token = prefs.getString('token');

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token ?? ''
    };
    var url = Uri.parse('http://localhost:8000/api/unit');
    var response = await http.post(url,
        body: jsonEncode(<String, dynamic>{
          "property_id": propertyId,
          "name": name,
          "unit_picture": "unit3living.jpg",
          "desc": description,
          "total_unit": totalUnit,
          "price": price
        }),
        headers: requestHeaders);

    if (response.statusCode == 200) {
      var body = UnitModel.fromJson(jsonDecode(response.body));

      return body;
    } else {
      throw Exception(response.statusCode);
    }
  } catch (e) {
    rethrow;
  }
}

class AddUnit extends StatefulWidget {
  const AddUnit({Key? key, required this.property}) : super(key: key);

  final PropertyModel property;
  @override
  State<AddUnit> createState() => _AddUnitState(property);
}

class _AddUnitState extends State<AddUnit> {
  PropertyModel property;
  _AddUnitState(this.property);
  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    TextEditingController priceController = TextEditingController();
    TextEditingController totalController = TextEditingController();
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
                children: const [
                  Text("Lombok Vacation",
                      style: TextStyle(color: Colors.grey, fontSize: 14)),
                  SizedBox(height: 10),
                  Text("Tambah Unit",
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
                onPressed: () async {
                  try {
                    UnitModel log = await add(
                      property.id,
                      nameController.text,
                      descriptionController.text,
                      int.parse(priceController.text),
                      double.parse(totalController.text),
                    );
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Home()));
                  } catch (e) {
                    print(e);
                  }
                },
              ),
            )
          ],
        ),
      ),
    ));
  }
}
