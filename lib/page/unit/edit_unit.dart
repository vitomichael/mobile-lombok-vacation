import 'package:flutter/material.dart';
import 'package:tubes/models/unit_model.dart';
import 'package:tubes/page/home/home.dart';
import 'package:tubes/page/property/add_property.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tubes/models/property_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<UnitModel> edit(int id, String name, String description, String picture,
    int totalUnit, double price) async {
  try {
    final prefs = await SharedPreferences.getInstance();

    final String? token = prefs.getString('token');

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token ?? ''
    };
    var url = Uri.parse('http://localhost:8000/api/unit/$id');
    var response = await http.put(url,
        body: jsonEncode(<String, dynamic>{
          "name": name,
          "unit_picture": picture,
          "desc": description,
          "total_unit": totalUnit,
          "price": price
        }),
        headers: requestHeaders);

    if (response.statusCode == 200) {
      print(response.statusCode);
      var body = UnitModel.fromJson(jsonDecode(response.body));
      print(body);

      return body;
    } else {
      throw Exception(response.statusCode);
    }
  } catch (e) {
    rethrow;
  }
}

class EditUnit extends StatefulWidget {
  const EditUnit({Key? key, required this.unit}) : super(key: key);
  final UnitModel unit;

  @override
  State<EditUnit> createState() => _EditUnitState();
}

class _EditUnitState extends State<EditUnit> {
  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    TextEditingController priceController = TextEditingController();
    TextEditingController totalController = TextEditingController();

    nameController.text = widget.unit.name;
    descriptionController.text = widget.unit.description;
    priceController.text = widget.unit.price.toString();
    totalController.text = widget.unit.totalUnit.toString();

    var picture = widget.unit.picture;
    var id = widget.unit.id;

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
                  Text("Edit Unit",
                      style: TextStyle(color: Colors.black87, fontSize: 36)),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: TextFormField(
                autofocus: false,
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Unit Name',
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: TextFormField(
                autofocus: false,
                controller: descriptionController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Description',
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: TextFormField(
                autofocus: false,
                controller: totalController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Total Unit',
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: TextFormField(
                autofocus: false,
                controller: priceController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Price',
                ),
              ),
            ),
            Container(
              height: 25,
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: ElevatedButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 16,
                    ),
                    SizedBox(width: 7),
                    Text(
                      'Edit Unit',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                onPressed: () async {
                  try {
                    UnitModel log = await edit(
                        id,
                        nameController.text,
                        descriptionController.text,
                        picture,
                        int.parse(totalController.text),
                        double.parse(priceController.text));
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Home()),
                    );
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
