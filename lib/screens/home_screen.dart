import 'package:apex_mobile_library/screens/weapon_list_screen.dart';
import 'package:flutter/material.dart';

import 'package:apex_mobile_library/classes/ammo_class.dart';
import 'package:apex_mobile_library/classes/class_class.dart';
import 'package:apex_mobile_library/classes/class_perk_class.dart';
import 'package:apex_mobile_library/classes/weapon_class.dart';
import 'package:apex_mobile_library/screens/legend_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen(
      {Key? key,
      required this.weaponList,
      required this.ammoList,
      required this.classList,
      required this.classPerkList})
      : super(key: key);

  final List<Weapon> weaponList;
  final List<Ammo> ammoList;
  final List<Class> classList;
  final List<ClassPerk> classPerkList;

  @override
  State<HomeScreen> createState() =>
      // ignore: no_logic_in_create_state
      _HomeScreenState(weaponList, ammoList, classList, classPerkList);
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final List<Weapon> weaponList;
  final List<Ammo> ammoList;
  final List<Class> classList;
  final List<ClassPerk> classPerkList;

  int selectedIndex = 0;

  _HomeScreenState(
      this.weaponList, this.ammoList, this.classList, this.classPerkList);
  void changePage(int value) {
    setState(() {
      selectedIndex = value;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (selectedIndex == 0)
          ? const Home()
          : (selectedIndex == 1)
              ? WeaponListScreen(
                  weaponList: weaponList,
                )
              : const LegendListScreen(),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(119, 0, 0, 0),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: BottomNavigationBar(
          selectedItemColor: Colors.yellow,
          unselectedItemColor: Colors.white,
          onTap: (value) => changePage(value),
          backgroundColor: const Color.fromARGB(0, 0, 0, 0),
          currentIndex: selectedIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.short_text),
              label: 'Weapons',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Legends',
            ),
          ],
        ),
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('HOME!'));
  }
}
