import 'package:apex_mobile_library/classes/ammo_class.dart';
import 'package:apex_mobile_library/classes/class_class.dart';
import 'package:apex_mobile_library/classes/class_perk_class.dart';
import 'package:apex_mobile_library/classes/weapon_class.dart';
import 'package:apex_mobile_library/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  getJSONFromSheet();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('lib/assets/images/bg.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(0, 0, 0, 0),
          textTheme: TextTheme(
            titleLarge: const TextStyle().apply(color: Colors.white),
            titleMedium: const TextStyle().apply(color: Colors.white),
            bodyLarge: const TextStyle().apply(color: Colors.white),
            bodyMedium: const TextStyle().apply(color: Colors.white),
          ),
        ),
        color: Colors.black,
        title: 'Apex Mobile Library',
        home: HomeScreen(
          ammoList: ammoList,
          classList: classList,
          classPerkList: classPerkList,
          weaponList: weaponList,
        ),
      ),
    );
  }
}

//JSON data fetching
final List<Weapon> weaponList = <Weapon>[];
final List<Ammo> ammoList = <Ammo>[];
final List<Class> classList = <Class>[];
final List<ClassPerk> classPerkList = <ClassPerk>[];

getJSONFromSheet() async {
  var raw = await http.get(
    Uri.parse(
        "https://script.google.com/macros/s/AKfycbycJ7jkwGcSEO3z9bfssGiaYaMHwEfdvlXWz4sn4DFh5k4vMUio9qbxdIwtQoAwFpo3/exec"),
  );
  var feedback = jsonDecode(raw.body);
  getWeapon(feedback["weapon"]);
  getAmmo(feedback["ammo"]);
  getClass(feedback["class"]);
  getClassPerk(feedback["classPerk"]);
}

getWeapon(jsonFeedback) async {
  jsonFeedback.forEach((element) {
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
    weapon.tacReload =
        (element["tacReload"] == null || element["tacReload"] == 0)
            ? weapon.tacReload
            : double.parse(element["tacReload"].toString());
    weapon.fullReload =
        (element["fullReload"] == null || element["fullReload"] == 0)
            ? weapon.fullReload
            : double.parse(element["fullReload"].toString());
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
}

getAmmo(jsonFeedback) async {
  jsonFeedback.forEach((element) {
    Ammo ammo = Ammo();
    ammo.name = (element["name"] == null) ? ammo.name : element["name"];
    ammo.imageUrl =
        (element["imageUrl"] == null) ? ammo.imageUrl : element["imageUrl"];
    ammo.mythicUrl =
        (element["mythicUrl"] == null) ? ammo.mythicUrl : element["mythicUrl"];
    ammoList.add(ammo);
  });
}

getClass(jsonFeedback) async {
  jsonFeedback.forEach((element) {
    Class classObj = Class();
    classObj.name = (element["name"] == null) ? classObj.name : element["name"];
    classObj.imageUrl =
        (element["imageUrl"] == null) ? classObj.imageUrl : element["imageUrl"];
    classObj.description = (element["description"] == null)
        ? classObj.description
        : element["description"];
    classList.add(classObj);
  });
}

getClassPerk(jsonFeedback) async {
  jsonFeedback.forEach((element) {
    ClassPerk classPerkObj = ClassPerk();
    classPerkObj.name =
        (element["name"] == null) ? classPerkObj.name : element["name"];
    classPerkObj.imageUrl = (element["imageUrl"] == null)
        ? classPerkObj.imageUrl
        : element["imageUrl"];
    classPerkObj.description = (element["description"] == null)
        ? classPerkObj.description
        : element["description"];
    classPerkList.add(classPerkObj);
  });
}
