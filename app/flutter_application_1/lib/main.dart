import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'cWebSocket.dart';
import 'pPage.dart';
import 'pSettings.dart';

import 'pHome.dart';
import 'pControl.dart';
import 'pChat.dart';
import 'pMap.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key});

  static const String _title = 'Projet Tronc Commun - Group A1';

  @override
  State<MyApp> createState() => MyAppState();

  static MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<MyAppState>()!;
}

class MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void toggleThemeMode() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  void updateThemeMode() {
    final Brightness platformBrightness =
        SchedulerBinding.instance.window.platformBrightness;
    setState(() {
      _themeMode = platformBrightness == Brightness.dark
          ? ThemeMode.dark
          : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: MyApp._title,
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
      themeMode: _themeMode,
      home: const MyStatefulWidget(),
      builder: (BuildContext context, Widget? child) {
        return GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: child,
        );
      },
      debugShowCheckedModeBanner: false,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;

  late WebSocket webSocket_video;
  late WebSocket webSocket_message;
  late WebSocket webSocket_map;

  @override
  void initState() {
    super.initState();
    webSocket_video = WebSocket();
    webSocket_message = WebSocket();
    //webSocket_message.connect(Uri.parse("ws://192.168.121.212:8888"));
    //webSocket_video.connect(Uri.parse("ws://192.168.121.212:8889"));
  }

  @override
  void dispose() {
    webSocket_video.close();
    webSocket_message.close();
    super.dispose();
  }

  List<Widget> _pages() {
    return [
      HomePage(),
      ControlPage(webSocket: webSocket_video),
      MapPage(),
      ChatPage(),
      SettingsPage(),
    ];
  }

  final List<String> _pageTitles = [
    "Home",
    "Control",
    "Map",
    "Chat",
    "Settings"
  ];

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
      body: _pages()[_selectedIndex],
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
