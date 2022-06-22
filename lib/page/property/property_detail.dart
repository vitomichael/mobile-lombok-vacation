import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tubes/models/property_model.dart';
import 'package:tubes/models/unit_model.dart';
import 'package:tubes/page/home/home.dart';
import 'package:tubes/page/property/add_property.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tubes/page/unit/add_unit.dart';
import 'package:tubes/page/unit/edit_unit.dart';
import 'package:tubes/page/unit/unit_detail.dart';

Future<void> deleteUnit(int id) async {
  final prefs = await SharedPreferences.getInstance();

  final String? token = prefs.getString('token');

  Map<String, String> requestHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': token ?? ''
  };
  var url = Uri.parse('http://localhost:8000/api/unit/$id');
  final response = await http.delete(url, headers: requestHeaders);

  if (response.statusCode == 200) {
    print(response.statusCode);
  } else {
    throw Exception("Failed");
  }
}

Future<List<UnitModel>> fetchUnits(int propertyId) async {
  try {
    final prefs = await SharedPreferences.getInstance();

    final String? token = prefs.getString('token');

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token ?? ''
    };
    var url = Uri.parse('http://localhost:8000/api/unit/$propertyId');
    final response = await http.get(url, headers: requestHeaders);

    var body = jsonDecode(response.body);

    if (response.statusCode == 200) {
      List<UnitModel> property = [];
      for (Map<String, dynamic> i in body) {
        property.add(UnitModel.fromJson(i));
      }
      return property;
    } else {
      throw Exception("Failed");
    }
  } catch (e) {
    rethrow;
  }
}

class PropertyDetail extends StatefulWidget {
  const PropertyDetail({Key? key, required this.property}) : super(key: key);

  final PropertyModel property;

  @override
  State<PropertyDetail> createState() => _PropertyDetailState(property);
}

class _PropertyDetailState extends State<PropertyDetail> {
  late Future<List<UnitModel>> futureUnit;
  PropertyModel property;
  _PropertyDetailState(this.property);
  @override
  void initState() {
    super.initState();
    futureUnit = (fetchUnits(property.id));
  }

  Widget listUnit() {
    Widget _gestureCard(snapshot, position) {
      var pictureUrl = snapshot.data![position].picture;
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UnitDetail(
                unit: snapshot.data![position],
                property: property,
              ),
            ),
          );
        },
        child: Container(
          height: 120,
          margin: const EdgeInsets.all(5),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                          height: 80.0,
                          width: 80,
                          child: Image(
                              image: AssetImage("assets/images/$pictureUrl"))),
                      const SizedBox(width: 10),
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              snapshot.data![position].name,
                              style: const TextStyle(
                                  fontSize: 16.0, color: Colors.orange),
                            ),
                            Container(
                              width: 160,
                              child: Text(
                                snapshot.data![position].description,
                                style: const TextStyle(
                                    fontSize: 10.0, color: Colors.blueGrey),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    EditUnit(unit: snapshot.data![position])),
                          );
                        },
                        child: Icon(Icons.edit_note_outlined),
                      ),
                      const SizedBox(height: 5),
                      ElevatedButton(
                        onPressed: () async {
                          await deleteUnit(snapshot.data![position].id);
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => Home()),
                            (Route<dynamic> route) => false,
                          );
                        },
                        child: Icon(Icons.delete_outline_outlined),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }

    return FutureBuilder<List<UnitModel>>(
      future: futureUnit,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, position) {
              return _gestureCard(snapshot, position);
            },
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        // By default, show a loading spinner.
        return const CircularProgressIndicator();
      },
    );
  }

  Widget _addButton(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      margin: const EdgeInsets.fromLTRB(40, 0, 0, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 25,
            margin: const EdgeInsets.fromLTRB(0, 10, 40, 10),
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
                    'Tambah Unit',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddUnit(property: property)),
                );
              },
            ),
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
              TopBarWithBackButton(context),
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(left: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.property.area + ", " + widget.property.type,
                        style: TextStyle(color: Colors.grey, fontSize: 18)),
                    const SizedBox(height: 10),
                    Text(
                      widget.property.name,
                      style: TextStyle(
                          color: Color.fromARGB(255, 1, 43, 78), fontSize: 40),
                    ),
                  ],
                ),
              ),
              _addButton(context),
              listUnit()
            ],
          ),
        ),
      ),
    );
  }
}
