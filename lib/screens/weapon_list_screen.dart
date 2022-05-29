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
            return ListTile(
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
