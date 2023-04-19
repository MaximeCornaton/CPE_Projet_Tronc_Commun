import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

import 'pPage.dart';
import 'pSettings.dart';

import 'pHome.dart';
import 'pControl.dart';
import 'pChat.dart';
import 'pMap.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  static const String _title = 'Projet Tronc Commun - Group A1';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        fontFamily: 'Ubuntu',
        brightness: Brightness.light,
        primarySwatch: Colors.orange,
        primaryColor: Colors.grey[200],
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Colors.orange,
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.white,
        ),
      ),
      darkTheme: ThemeData(
        fontFamily: 'Ubuntu',
        brightness: Brightness.dark,
        primarySwatch: Colors.orange,
        primaryColor: Colors.grey[900],
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Colors.orange,
          unselectedItemColor: Colors.white,
          backgroundColor: Colors.black,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MyStatefulWidget(),
        '/home': (context) => HomePage(),
        '/control': (context) => ControlPage(),
        '/map': (context) => MapPage(),
        '/settings': (context) => SettingsPage(),
      },
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = <Widget>[
    HomePage(),
    ControlPage(),
    MapPage(),
    ChatPage(),
    SettingsPage(),
  ];

  final List<String> _pageTitles =
      _pages.map((page) => (page as BasePage).title).toList();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pageTitles[_selectedIndex]),
      ),
      body: Navigator(
        onGenerateRoute: (RouteSettings settings) {
          return MaterialPageRoute(
            builder: (_) => _pages[_selectedIndex],
            settings: settings,
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: '•',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.control_camera),
            label: '•',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.route),
            label: '•',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.question_answer),
            label: '•',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: '•',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
