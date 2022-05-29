import 'dart:convert';

import 'package:apex_mobile_library/classes/weapon_class.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  void changePage(int value) {
    setState(() {
      selectedIndex = value;
    });
  }

  final List<Weapon> weaponList = <Weapon>[];

  getWeaponFromSheet() async {
    var raw = await http.get(
      Uri.parse(
          "https://script.google.com/macros/s/AKfycbycJ7jkwGcSEO3z9bfssGiaYaMHwEfdvlXWz4sn4DFh5k4vMUio9qbxdIwtQoAwFpo3/exec"),
    );
    var jsonFeedback = jsonDecode(raw.body);
    jsonFeedback.forEach((element) {
      Weapon weapon = Weapon();
      weapon.name = (element["name"]);
      weapon.ammo = (element["ammo"]);
      weapon.type = (element["type"]);
      weapon.isSupplyDrop = (element["isSupplyDrop"] == 'yes') ? true : false;
      weapon.refresh();
      weaponList.add(weapon);
    });
    setState(() {});
  }

  @override
  void initState() {
    getWeaponFromSheet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Apex Mobile Library'),
        ),
      ),
      body: (selectedIndex == 0)
          ? _PageWeapon(
              weaponList: weaponList,
            )
          : const _PageLegend(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) => changePage(value),
        currentIndex: selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.album_outlined),
            label: 'Weapons',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Legends',
          ),
        ],
      ),
    );
  }
}

class _PageWeapon extends StatelessWidget {
  const _PageWeapon({Key? key, required this.weaponList}) : super(key: key);

  final List<Weapon> weaponList;

  @override
  Widget build(BuildContext context) {
    if (weaponList.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: const [
            Text("Fetching data...please wait."),
          ],
        ),
      );
    } else {
      return ListView.builder(
          itemCount: weaponList.length,
          itemBuilder: (BuildContext context, int index) {
            TextStyle weaponTextStyle = TextStyle(
              color:
                  (Color(weaponList[index].ammoColor).computeLuminance() > 0.5
                      ? Colors.black
                      : Colors.white),
            );
            return ListTile(
              onTap: () => showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  contentTextStyle: weaponTextStyle,
                  backgroundColor: Color(weaponList[index].ammoColor),
                  title: Text(weaponList[index].name, style: weaponTextStyle),
                  content: SizedBox(
                    width: 300,
                    child: SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          Table(
                            children: [
                              TableRow(
                                children: [
                                  TableCell(
                                    child: Container(
                                      margin: const EdgeInsets.all(5),
                                      alignment: Alignment.centerRight,
                                      child: const Text('Weapon Type :'),
                                    ),
                                  ),
                                  TableCell(
                                    child: Container(
                                      margin: const EdgeInsets.all(5),
                                      alignment: Alignment.centerLeft,
                                      child: Text(weaponList[index].type),
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  TableCell(
                                    child: Container(
                                      margin: const EdgeInsets.all(5),
                                      alignment: Alignment.centerRight,
                                      child: const Text('Ammo :'),
                                    ),
                                  ),
                                  TableCell(
                                    child: Container(
                                      margin: const EdgeInsets.all(5),
                                      alignment: Alignment.centerLeft,
                                      child: Text(weaponList[index].ammo),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              title: Text(weaponList[index].name),
              trailing: ElevatedButton(
                onPressed: null,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Color(weaponList[index].ammoColor),
                  ),
                  padding: MaterialStateProperty.all<EdgeInsets>(
                    const EdgeInsets.all(10),
                  ),
                ),
                child: Text(
                  weaponList[index].ammo.toUpperCase(),
                  style: weaponTextStyle,
                ),
              ),
              subtitle: Text(weaponList[index].type),
            );
          });
    }
  }
}

class _PageLegend extends StatelessWidget {
  const _PageLegend({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
