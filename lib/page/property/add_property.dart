import 'package:flutter/material.dart';
import 'package:tubes/page/home/home.dart';
import 'package:tubes/page/home/property.dart';
import 'package:tubes/page/user/register.dart';

Widget TopBarWithBackButton(context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      IconButton(
        icon: Icon(Icons.arrow_back),
        highlightColor: Colors.pink,
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      logo(80),
    ],
  );
}

class AddProperty extends StatefulWidget {
  const AddProperty({Key? key}) : super(key: key);

  @override
  State<AddProperty> createState() => _AddPropertyState();
}

class _AddPropertyState extends State<AddProperty> {
  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController areaController = TextEditingController();
    TextEditingController typeController = TextEditingController();
    String area = 'Lombok Barat';
    String type = 'Villa';
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
                  const Text("Tambah Property",
                      style: TextStyle(color: Colors.black87, fontSize: 36)),
                ],
              ),
            ),
            inputText(nameController, "Nama Property"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Area:     ", style: TextStyle(fontSize: 16)),
                DropdownButton<String>(
                  value: area,
                  elevation: 20,
                  style: const TextStyle(color: Colors.black),
                  underline: Container(
                    height: 1,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      area = newValue!;
                    });
                  },
                  items: <String>[
                    'Lombok Barat',
                    'Lombok Utara',
                    'Lombok Timur',
                    'Lombok Tengah',
                    'Kota Mataram',
                    'Gili'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Tipe:     ", style: TextStyle(fontSize: 16)),
                DropdownButton<String>(
                  value: type,
                  elevation: 20,
                  style: const TextStyle(color: Colors.black),
                  underline: Container(
                    height: 1,
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      type = value!;
                    });
                  },
                  items: <String>[
                    'Villa',
                    'Hotel',
                    'Guest House',
                    'Cottage',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
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
                      'Tambah Property',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddProperty()),
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
