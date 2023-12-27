import 'package:flutter/material.dart';

import 'prayersTime.dart';
import 'selectLocationPage.dart';

class BotomNavBar extends StatefulWidget {
  final String division;
  final String district;
  const BotomNavBar({
    Key? key,
    required this.division,
    required this.district,
  }) : super(key: key);

  @override
  State<BotomNavBar> createState() => _BotomNavBarState();
}

class _BotomNavBarState extends State<BotomNavBar> {
  int selectedScreen = 0;
  List<Widget> _screens = [];

  @override
  void initState() {
    super.initState();
    _screens = [
      PrayerTimesPage(
        district: widget.district,
        division: widget.division,
      ),
      const LocationSelectionPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: _screens[selectedScreen]),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.black38,
        backgroundColor: Colors.white,
        showUnselectedLabels: true,
        onTap: (index) {
          setState(() {
            selectedScreen = index;
          });
        },
        currentIndex: selectedScreen,
        elevation: 4,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.location_on_outlined), label: "Select Location"),
        ],
      ),
    );
  }
}
