import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

import 'pSettings.dart';
import 'pHome.dart';
import 'pControl.dart';
import 'pChat.dart';
import 'pMap.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'Projet Tronc Commun - Group A1';

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData(
        fontFamily: 'Ubuntu',
        brightness: Brightness.light,
        primarySwatch: Colors.orange,
        //hintColor: Colors.amber,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Colors.orange,
          unselectedItemColor: Colors.black,
          backgroundColor: Colors.white,
        ),
      ),
      dark: ThemeData(
        fontFamily: 'Ubuntu',
        brightness: Brightness.dark,
        primarySwatch: Colors.orange,
        //hintColor: Colors.amber,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Colors.orange,
          unselectedItemColor: Colors.white,
          backgroundColor: Colors.black,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor:
              Colors.black, // Couleur de fond de la barre supérieure
        ),
      ),
      initial: MediaQuery.of(context).platformBrightness == Brightness.light
          ? AdaptiveThemeMode.light
          : AdaptiveThemeMode.dark,
      builder: (theme, darkTheme) => MaterialApp(
        title: _title,
        theme: theme,
        darkTheme: darkTheme,
        home: const MyStatefulWidget(),
        routes: {
          '/home': (context) => const HomePage(),
          '/control': (context) => const ControlPage(),
          '/map': (context) => const MapPage(),
          '/settings': (context) => const SettingsPage(),
        },
      ),
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

  static const List<Widget> _pages = <Widget>[
    HomePage(),
    ControlPage(),
    MapPage(),
    ChatPage(),
    SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            icon: Icon(Icons.threed_rotation),
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
