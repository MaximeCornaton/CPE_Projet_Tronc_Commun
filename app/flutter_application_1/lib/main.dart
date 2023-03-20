import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:arrow_pad/arrow_pad.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

import 'package:http/http.dart' as http;

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

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      //appBar: AppBar(
      //  title: const Text('Home'),
      //),
      body: Center(
        child: Text(
          'Accueil!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _textController = TextEditingController();
  final List<Map<String, String>> _messages = [];

  bool _isHovered = false;

  Widget _buildTextComposer() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: <Widget>[
          Flexible(
            child: TextField(
              controller: _textController,
              decoration: const InputDecoration(hintText: 'Entrez un message'),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            child: InkWell(
              onHover: (value) {
                setState(() {
                  _isHovered = value;
                });
              },
              onTap: () async {
                final message = _textController.text;
                final response = await sendMessage(message);
                setState(() {
                  _messages.add({'message': message, 'response': response});
                });
                _textController.clear();
              },
              child: Icon(
                Icons.send,
                color: _isHovered
                    ? Theme.of(context)
                        .bottomNavigationBarTheme
                        .selectedItemColor
                    : null,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: _messages.length,
            itemBuilder: (BuildContext context, int index) {
              final message = _messages[index];
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        message['message']!,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        message['response']!,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const Divider(height: 1.0),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
          ),
          child: Column(
            children: <Widget>[
              _buildTextComposer(),
              const Divider(height: 1.0),
            ],
          ),
        ),
      ],
    ));
  }

  Future<String> sendMessage(String message) async {
// logique pour envoyer le message
    await Future.delayed(const Duration(seconds: 2));
    return "Réponse au message : $message";
  }
}

class ControlPage extends StatefulWidget {
  const ControlPage({Key? key}) : super(key: key);

  @override
  ControlPageState createState() => ControlPageState();
}

class ControlPageState extends State<ControlPage> {
  @override
  Widget build(BuildContext context) {
    return const ArrowPadExample();
  }
}

class ArrowPadExample extends StatefulWidget {
  const ArrowPadExample({Key? key}) : super(key: key);

  @override
  ArrowPadExampleState createState() => ArrowPadExampleState();
}

class ArrowPadExampleState extends State<ArrowPadExample> {
  String arrowPadValue = 'With Functions (tapUp)';

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ArrowPad(
                padding: const EdgeInsets.all(8.0),
                height: height / 5,
                width: width / 4,
                iconColor: Colors.white,
                innerColor: const Color.fromARGB(255, 22, 21, 21),
                outerColor: const Color.fromARGB(255, 0, 0, 0),
                splashColor: Theme.of(context)
                    .bottomNavigationBarTheme
                    .selectedItemColor,
                hoverColor: const Color.fromARGB(255, 42, 42, 42),
                clickTrigger: ClickTrigger.onTapUp,
                onPressedUp: () {
                  setState(() {
                    arrowPadValue = 'Up Pressed (tapUp)';
                  });
                },
                onPressedDown: () {
                  setState(() {
                    arrowPadValue = 'Down Pressed (tapUp)';
                  });
                },
                onPressedLeft: () {
                  setState(() {
                    arrowPadValue = 'Left Pressed (tapUp)';
                  });
                },
                onPressedRight: () {
                  setState(() {
                    arrowPadValue = 'Right Pressed (tapUp)';
                  });
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                arrowPadValue,
                style: const TextStyle(fontSize: 24),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Album>(
      future: futureAlbum,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data!.title);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        // By default, show a loading spinner.
        return const CircularProgressIndicator();
      },
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(
      //  title: const Text('Paramètres'),
      //),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              AdaptiveTheme.of(context).toggleThemeMode();
            },
            child: const Text(
              'Changer le thème',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              AdaptiveTheme.of(context).setSystem();
            },
            child: const Text(
              "Utiliser le thème de l'appareil",
            ),
          ),
        ],
      ),
    );
  }
}

/* HTTP REQUESTS */

class Album {
  final int id;
  final String title;

  const Album({
    required this.id,
    required this.title,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'],
      title: json['title'],
    );
  }
}

Future<Album> fetchAlbum() async {
  final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/2'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Future<Album> createAlbum(String title) async {
  final response = await http.post(
    Uri.parse('https://jsonplaceholder.typicode.com/albums'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'title': title,
    }),
  );

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}
