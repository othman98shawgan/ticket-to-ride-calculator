import 'package:flutter/material.dart';
import 'package:ticket_to_ride_calculator/ui/bonuses_page.dart';
import 'package:ticket_to_ride_calculator/ui/routes_page.dart';
import 'package:ticket_to_ride_calculator/ui/score_page.dart';
import 'package:ticket_to_ride_calculator/ui/tickets_page.dart';

import 'package:wakelock/wakelock.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    ScorePage(),
    RoutesPage(),
    TicketsPage(),
    BonusesPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  var bottomNavigationBarItems = const <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.scoreboard),
      label: 'Score',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.route),
      label: 'Routes',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.airplane_ticket),
      label: 'Tickets',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.plus_one),
      label: 'Bonuses',
    ),
  ];
  
  @override
  void initState() {
    Wakelock.enable();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        items: bottomNavigationBarItems,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey.shade600,
        onTap: _onItemTapped,
      ),
    );
  }
}
