import 'package:apex_mobile_library/classes/weapon_class.dart';
import 'package:flutter/material.dart';

class WeaponDetailScreen extends StatelessWidget {
  const WeaponDetailScreen({Key? key, required this.weapon}) : super(key: key);

  final Weapon weapon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(weapon.name),
        backgroundColor: Color(weapon.ammoColor),
      ),
    );
  }
}
