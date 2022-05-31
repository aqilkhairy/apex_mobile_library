import 'dart:convert';

import 'package:apex_mobile_library/classes/weapon_class.dart';
import 'package:apex_mobile_library/screens/legend_list_screen.dart';
import 'package:apex_mobile_library/screens/weapon_list_screen.dart';
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
          ? WeaponListScreen(
              weaponList: weaponList,
            )
          : const LegendListScreen(),
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

  //JSON data fetching
  final List<Weapon> weaponList = <Weapon>[];
  getWeaponFromSheet() async {
    var raw = await http.get(
      Uri.parse(
          "https://script.google.com/macros/s/AKfycbycJ7jkwGcSEO3z9bfssGiaYaMHwEfdvlXWz4sn4DFh5k4vMUio9qbxdIwtQoAwFpo3/exec"),
    );
    var jsonFeedback = jsonDecode(raw.body);
    jsonFeedback["weapon"].forEach((element) {
      Weapon weapon = Weapon();
      weapon.name = (element["name"] == null) ? weapon.name : element["name"];
      weapon.ammo = (element["ammo"] == null) ? weapon.ammo : element["ammo"];
      weapon.type = (element["type"] == null) ? weapon.type : element["type"];
      weapon.isSupplyDrop = (element["isSupplyDrop"] == 'yes') ? true : false;
      weapon.baseDamage = (element["baseDamage"] == null)
          ? weapon.baseDamage
          : element["baseDamage"];
      weapon.headDamage = (element["headDamage"] == null)
          ? weapon.headDamage
          : element["headDamage"];
      weapon.legDamage = (element["legDamage"] == null)
          ? weapon.legDamage
          : element["legDamage"];
      weapon.rpm = (element["rpm"] == null) ? weapon.rpm : element["rpm"];
      weapon.baseCapacity = (element["baseCapacity"] == null)
          ? weapon.baseCapacity
          : element["baseCapacity"];
      weapon.tacReload = (element["tacReload"] == null)
          ? weapon.tacReload
          : element["tacReload"];
      weapon.fullReload = (element["fullReload"] == null)
          ? weapon.fullReload
          : element["fullReload"];
      weapon.description = (element["description"] == null)
          ? weapon.description
          : element["description"];
      weapon.imageUrl =
          (element["imageUrl"] == null) ? weapon.imageUrl : element["imageUrl"];
      weapon.iconUrl =
          (element["iconUrl"] == null) ? weapon.iconUrl : element["iconUrl"];
      weapon.refresh();
      weaponList.add(weapon);
    });
    setState(() {});
  }
}
