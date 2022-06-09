import 'package:flutter/material.dart';
import 'package:tubes/models/property_model.dart';
import 'package:tubes/page/home/home.dart';
import 'package:tubes/page/property/add_property.dart';
import 'package:tubes/page/property/edit_property.dart';
import 'package:tubes/page/property/property_detail.dart';
import 'package:tubes/page/user/register.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> deleteProperty(int id) async {
  final prefs = await SharedPreferences.getInstance();

  final String? token = prefs.getString('token');

  Map<String, String> requestHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': token ?? ''
  };
  var url = Uri.parse('http://localhost:8000/api/property/$id');
  final response = await http.delete(url, headers: requestHeaders);

  if (response.statusCode == 200) {
    print(response.statusCode);
  } else {
    throw Exception("Failed");
  }
}

Future<List<PropertyModel>> fetchProperty() async {
  try {
    final prefs = await SharedPreferences.getInstance();

    final String? token = prefs.getString('token');

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token ?? ''
    };
    var url = Uri.parse('http://localhost:8000/api/property');
    final response = await http.get(url, headers: requestHeaders);

    var body = jsonDecode(response.body);

    if (response.statusCode == 200) {
      List<PropertyModel> property = [];
      for (Map<String, dynamic> i in body) {
        property.add(PropertyModel.fromJson(i));
      }
      return property;
    } else {
      throw Exception("Failed");
    }
  } catch (e) {
    rethrow;
  }
}

class Property extends StatefulWidget {
  const Property({Key? key}) : super(key: key);

  @override
  State<Property> createState() => _PropertyState();
}

class _PropertyState extends State<Property> {
  late Future<List<PropertyModel>> futureProperty;
  @override
  void initState() {
    super.initState();
    futureProperty = (fetchProperty());
  }

  Widget _addButton(BuildContext context) {
    return Container(
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
                children: const [
                  Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 16,
                  ),
                  SizedBox(width: 7),
                  Text(
                    'Tambah Property',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddProperty()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget listProperty() {
    Widget _gestureCard(snapshot, position) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  PropertyDetail(property: snapshot.data![position]),
            ),
          );
        },
        child: Container(
          margin: const EdgeInsets.all(5),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        snapshot.data![position].name,
                        style: const TextStyle(
                            fontSize: 16.0, color: Colors.orange),
                      ),
                      Text(
                        snapshot.data![position].type +
                            ", " +
                            snapshot.data![position].area,
                        style: const TextStyle(
                            fontSize: 10.0, color: Colors.blueGrey),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditProperty(
                                  property: snapshot.data![position]),
                            ),
                          );
                        },
                        child: Icon(Icons.edit_note_outlined),
                      ),
                      const SizedBox(height: 5),
                      ElevatedButton(
                        onPressed: () async {
                          await deleteProperty(snapshot.data![position].id);
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

    return FutureBuilder<List<PropertyModel>>(
      future: futureProperty,
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

  @override
  Widget build(BuildContext context) {
    // var property = fetchProperty();
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
            children: [TopBar(), _addButton(context), listProperty()],
          ),
        ),
      ),
    );
  }
}
