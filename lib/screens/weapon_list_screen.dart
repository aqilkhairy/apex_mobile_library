import 'package:apex_mobile_library/classes/weapon_class.dart';
import 'package:apex_mobile_library/screens/weapon_detail_screen.dart';
import 'package:flutter/material.dart';

class WeaponListScreen extends StatelessWidget {
  const WeaponListScreen({Key? key, required this.weaponList})
      : super(key: key);

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
            return Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.fitHeight,
                alignment: Alignment.centerLeft,
                opacity: 0.45,
                image: AssetImage(weaponList[index].isSupplyDrop
                    ? 'lib/assets/images/ammo/${weaponList[index].ammo.toLowerCase()}_mythic.png'
                    : 'lib/assets/images/ammo/${weaponList[index].ammo.toLowerCase()}.png'),
              )),
              child: ListTile(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => WeaponDetailScreen(
                      weapon: weaponList[index],
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
                    (weaponList[index].isSupplyDrop
                        ? 'SUPPLY DROP'
                        : weaponList[index].ammo.toUpperCase()),
                    style: weaponTextStyle,
                  ),
                ),
                subtitle: Text(weaponList[index].type),
                leading: Image.asset(
                    'lib/assets/images/weapons/icons/${weaponList[index].name.toLowerCase().replaceAll('-', '').replaceAll(' ', '')}.png',
                    width: 80,
                    height: 80),
              ),
            );
          });
    }
  }
}
