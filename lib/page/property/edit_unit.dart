import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tubes/models/unit_model.dart';
import 'package:tubes/page/home/home.dart';
import 'package:tubes/page/property/property_detail.dart';
import 'package:tubes/page/user/register.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tubes/page/property/add_property.dart';

Future<UnitModel> edit(
    int id, String name, int totalUnit, double price, String desc) async {
  try {
    final prefs = await SharedPreferences.getInstance();

    final String? token = prefs.getString('token');
    final int? unitId = prefs.getInt('unitId');

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token ?? ''
    };
    var url = Uri.parse('http://localhost:8000/api/unit/$id');
    var response = await http.put(url,
        body: jsonEncode(<String, dynamic>{
          'unitId': unitId,
          'name': name,
          'description': desc,
          'totalUnit': totalUnit,
          'price': price,
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
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController totalController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    nameController.text = widget.unit.name;
    descriptionController.text = widget.unit.description;
    totalController.text = widget.unit.totalUnit.toString();
    priceController.text = widget.unit.price.toString();
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
                const Text("Edit Unit",
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
                    'Edit Unit',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              onPressed: () async {
                try {
                  UnitModel log = await edit(
                      widget.unit.id,
                      nameController.text,
                      int.parse(totalController.text),
                      double.parse(priceController.text),
                      descriptionController.text);
                  Navigator.pop(context);
                } catch (e) {
                  print(e);
                }
              },
            ),
          )
        ],
      ),
    )));
  }
}
