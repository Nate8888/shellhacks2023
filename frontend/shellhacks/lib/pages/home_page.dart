import 'package:flutter/material.dart';
import 'package:shellhacks/pages/news_page.dart';
import 'package:shellhacks/pages/rankings_page.dart';
import 'package:shellhacks/pages/voice_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List<Widget> _pages = <Widget>[
    NewsPage(),
    VoicePage(),
    RankingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'news',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.price_change),
            label: 'rankings',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
