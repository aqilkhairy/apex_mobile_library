import 'package:apex_mobile_library/classes/weapon_class.dart';
import 'package:flutter/material.dart';

class WeaponDetailScreen extends StatelessWidget {
  const WeaponDetailScreen({Key? key, required this.weapon}) : super(key: key);

  final Weapon weapon;

  @override
  Widget build(BuildContext context) {
    TextStyle weaponTextStyle = TextStyle(
      color: (Color(weapon.ammoColor).computeLuminance() > 0.5
          ? Colors.black
          : Colors.white),
    );
    return Scaffold(
      backgroundColor: const Color.fromARGB(119, 0, 0, 0),
      appBar: AppBar(
        title: Text(
          weapon.name,
          style: weaponTextStyle,
        ),
        backgroundColor: Color(weapon.ammoColor),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Column(
            children: [
              Image.asset(
                  'lib/assets/images/weapons/${weapon.name.toLowerCase().replaceAll('-', '').replaceAll(' ', '')}.webp'),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Center(
                  child: Text(weapon.description),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Table(children: [
                  //row start
                  _newRow('Type', Text(weapon.type), weapon),
                  _newRow('Ammo', Text(weapon.ammo), weapon),
                  _newRow(
                      'Supply Drop Weapon',
                      Text(weapon.isSupplyDrop.toString().toUpperCase()),
                      weapon),
                  _newRow('Base Capacity', Text(weapon.baseCapacity.toString()),
                      weapon),
                  _newRow('Rate per minute (RPM)', Text(weapon.rpm.toString()),
                      weapon),
                  _newRow('Rate per second (RPM)', Text(weapon.rps.toString()),
                      weapon),
                  _newRow('Headshot Damage', Text(weapon.headDamage.toString()),
                      weapon),
                  _newRow('Bodyshot Damage', Text(weapon.baseDamage.toString()),
                      weapon),
                  _newRow('Legshot Damage', Text(weapon.legDamage.toString()),
                      weapon),
                  _newRow('Tac Reload', Text('${weapon.tacReload}s'), weapon),
                  _newRow('Full Reload', Text('${weapon.fullReload}s'), weapon),
                  //row ends
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

TableRow _newRow(String firstCell, Widget secondCell, Weapon weapon) {
  TextStyle weaponTextStyle = TextStyle(
    color: (Color(weapon.ammoColor).computeLuminance() > 0.5
        ? Colors.black
        : Colors.white),
  );
  return TableRow(children: [
    TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Container(
        color: Color(weapon.ammoColor).withOpacity(0.6),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            firstCell,
            style: weaponTextStyle,
            textAlign: TextAlign.right,
          ),
        ),
      ),
    ),
    TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Container(
        color: const Color.fromARGB(183, 23, 23, 23),
        child: Padding(padding: const EdgeInsets.all(10), child: secondCell),
      ),
    ),
  ]);
}
