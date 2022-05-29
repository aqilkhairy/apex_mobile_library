import 'package:flutter/material.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Apex Mobile Library'),
        ),
      ),
      body: (selectedIndex == 0) ? const _PageWeapon() : const _PageLegend(),
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
  const _PageWeapon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text('test'),
    );
  }
}

class _PageLegend extends StatelessWidget {
  const _PageLegend({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
