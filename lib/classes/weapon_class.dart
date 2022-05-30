class Weapon {
  String name = 'undefined';
  String ammo = 'undefined';
  String type = 'undefined';
  bool isSupplyDrop = false;
  int baseDamage = 0;
  int headDamage = 0;
  int legDamage = 0;
  int rpm = 0;
  int baseCapacity = 0;
  double tacReload = 0.0;
  double fullReload = 0.0;
  String description = 'undefined';

  double rps = 0;
  int ammoColor = 0x000000;

  refresh() {
    if (isSupplyDrop) {
      ammoColor = 0xFFFF225D;
    } else if (ammo.toLowerCase() == 'energy') {
      ammoColor = 0xFFA4E400;
    } else if (ammo.toLowerCase() == 'heavy') {
      ammoColor = 0xFF61D5AC;
    } else if (ammo.toLowerCase() == 'light') {
      ammoColor = 0xFFF75700;
    } else if (ammo.toLowerCase() == 'shotgun') {
      ammoColor = 0xFFBF0101;
    } else if (ammo.toLowerCase() == 'sniper') {
      ammoColor = 0xFF204F91;
    }

    rps = (rpm / 60);
  }
}
