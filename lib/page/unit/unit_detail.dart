import 'package:flutter/material.dart';
import 'package:tubes/models/property_model.dart';
import 'package:tubes/models/unit_model.dart';
import 'package:tubes/page/home/home.dart';
import 'package:tubes/page/property/add_property.dart';
import 'package:tubes/page/property/property_detail.dart';
import 'package:tubes/page/unit/edit_unit.dart';

class UnitDetail extends StatefulWidget {
  const UnitDetail({Key? key, required this.unit, required this.property})
      : super(key: key);

  final UnitModel unit;
  final PropertyModel property;

  @override
  State<UnitDetail> createState() => _UnitDetailState(unit, property);
}

class _UnitDetailState extends State<UnitDetail> {
  UnitModel unit;
  PropertyModel property;
  _UnitDetailState(this.unit, this.property);

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
                  Text(widget.property.name + ", " + widget.property.type,
                      style: TextStyle(color: Colors.grey, fontSize: 18)),
                  Text(widget.property.area,
                      style: TextStyle(color: Colors.grey, fontSize: 18)),
                  const SizedBox(height: 10),
                  Text(
                    widget.unit.name,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 1, 43, 78), fontSize: 40),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(30, 15, 30, 15),
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/${widget.unit.picture}"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(left: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Text(widget.unit.description,
                      style: const TextStyle(color: Colors.grey, fontSize: 18)),
                  Text(
                    "Harga: ${widget.unit.price}",
                    style: const TextStyle(
                        color: Color.fromARGB(255, 1, 43, 78), fontSize: 18),
                  ),
                  Text(
                    "Total unit: ${widget.unit.totalUnit}",
                    style: const TextStyle(
                        color: Color.fromARGB(255, 1, 43, 78), fontSize: 18),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 70,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditUnit(unit: unit)),
                      );
                    },
                    child: const Icon(
                      Icons.edit_note_outlined,
                      size: 40,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                SizedBox(
                  width: 70,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      await deleteUnit(unit.id);
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const Home()),
                        (Route<dynamic> route) => false,
                      );
                    },
                    child: const Icon(
                      Icons.delete_outline_outlined,
                      size: 40,
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
