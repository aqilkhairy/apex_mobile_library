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
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Fetching data...try refresh the page."),
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(119, 0, 0, 0),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: ListView.builder(
              itemCount: weaponList.length,
              itemBuilder: (BuildContext context, int index) {
                TextStyle weaponTextStyle = TextStyle(
                  color:
                      (Color(weaponList[index].ammoColor).computeLuminance() >
                              0.5
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
                  title: Text(
                    weaponList[index].name,
                    style: const TextStyle(color: Colors.white),
                  ),
                  trailing: ElevatedButton(
                    onPressed: null,
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                        Color(weaponList[index].ammoColor),
                      ),
                      padding: WidgetStateProperty.all<EdgeInsets>(
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
                  subtitle: Text(
                    weaponList[index].type,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  leading: ColorFiltered(
                    colorFilter: const ColorFilter.matrix(<double>[
                      -1,
                      0,
                      0,
                      0,
                      255,
                      0,
                      -1,
                      0,
                      0,
                      255,
                      0,
                      0,
                      -1,
                      0,
                      255,
                      0,
                      0,
                      0,
                      1,
                      0
                    ]),
                    child: ColorFiltered(
                      colorFilter: const ColorFilter.srgbToLinearGamma(),
                      child: Image.asset(
                        'lib/assets/images/weapons/icons/${weaponList[index].name.toLowerCase().replaceAll('-', '').replaceAll(' ', '')}.png',
                        width: 80,
                        height: 80,
                      ),
                    ),
                  ),
                );
              }),
        ),
      );
    }
  }
}
