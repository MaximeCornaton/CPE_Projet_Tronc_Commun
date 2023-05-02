import 'package:flutter/material.dart';

import 'cWebSocket.dart';
import 'pSettings.dart';

import 'pHome.dart';
import 'pControl.dart';
import 'pChat.dart';
import 'pMap.dart';

void main() => runApp(MyApp());

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

  @override
  void initState() {
    super.initState();
    // Mettre à jour le thème en fonction de la luminosité actuelle au démarrage de l'application
    //updateThemeMode();
  }

  void updateThemeMode() {
    setState(() {
      final Brightness brightnessValue =
          MediaQuery.of(context).platformBrightness;
      _themeMode =
          brightnessValue == Brightness.dark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: MyApp._title,
      theme: ThemeData(
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
      darkTheme: ThemeData(
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

  late WebSocket webSocketVideo;
  late WebSocket webSocketMessage;
  late WebSocket webSocketMap;

  String wbVideo = "ws://192.168.137.107:8889";
  String wbMessage = "ws://192.168.137.107:8888";
  String wbMap = "ws://192.168.243.212:8887";

  void updateString(String type, String value) {
    setState(() {
      if (type == "video") {
        wbVideo = value;
        webSocketVideo.saveUrl(Uri.parse(value));
      } else if (type == "message") {
        wbMessage = value;
        webSocketMessage.saveUrl(Uri.parse(value));
      } else if (type == "map") {
        wbMap = value;
        webSocketMap.saveUrl(Uri.parse(value));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    webSocketVideo = WebSocket();
    webSocketMessage = WebSocket();
    webSocketMap = WebSocket();
    webSocketVideo.saveUrl(Uri.parse(wbVideo));
    webSocketMessage.saveUrl(Uri.parse(wbMessage));
    webSocketMap.saveUrl(Uri.parse(wbMap));
  }

  @override
  void dispose() {
    webSocketVideo.close();
    webSocketMessage.close();
    webSocketMap.close();
    super.dispose();
  }

  List<Widget> _pages() {
    return [
      HomePage(
          webSocketVideo: webSocketVideo,
          webSocketControl: webSocketMessage,
          webSocketMap: webSocketMap),
      ControlPage(
          webSocketVideo: webSocketVideo, webSocketControl: webSocketMessage),
      MapPage(webSocket: webSocketMap),
      ChatPage(webSocket: webSocketMessage),
      SettingsPage(
          updateString: this.updateString,
          wbVideo: wbVideo,
          wbMessage: wbMessage,
          wbMap: wbMap),
    ];
  }

  final List<String> _pageTitles = [
    "Home",
    "Controles et vidéo",
    "Cartographie",
    "Envoi de message",
    "Paramètres"
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
