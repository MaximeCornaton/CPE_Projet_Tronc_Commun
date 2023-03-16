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
        brightness: Brightness.light,
        primarySwatch: Colors.purple,
        //hintColor: Colors.amber,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Colors.purple,
          unselectedItemColor: Colors.black,
          backgroundColor: Colors.white,
        ),
      ),
      dark: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.purple,
        //hintColor: Colors.amber,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Colors.purple,
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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          Navigator(
            initialRoute: '/',
            onGenerateRoute: (settings) {
              return MaterialPageRoute(
                builder: (context) => const HomePage(),
              );
            },
          ),
          Navigator(
            initialRoute: '/',
            onGenerateRoute: (settings) {
              return MaterialPageRoute(
                builder: (context) => const ControlPage(),
              );
            },
          ),
          Navigator(
            initialRoute: '/',
            onGenerateRoute: (settings) {
              return MaterialPageRoute(
                builder: (context) => const MapPage(),
              );
            },
          ),
          Navigator(
            initialRoute: '/',
            onGenerateRoute: (settings) {
              return MaterialPageRoute(
                builder: (context) => const SettingsPage(),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_filled),
            label: 'Home',
            backgroundColor:
                Theme.of(context).bottomNavigationBarTheme.backgroundColor,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings_remote_rounded),
            label: 'Contrôle',
            backgroundColor:
                Theme.of(context).bottomNavigationBarTheme.backgroundColor,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.map),
            label: 'Carte',
            backgroundColor:
                Theme.of(context).bottomNavigationBarTheme.backgroundColor,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            label: 'Paramètres',
            backgroundColor:
                Theme.of(context).bottomNavigationBarTheme.backgroundColor,
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

class ControlPage extends StatefulWidget {
  const ControlPage({Key? key}) : super(key: key);

  @override
  ControlPageState createState() => ControlPageState();
}

class ControlPageState extends State<ControlPage> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Expanded(child: ArrowPadExample()),
        Expanded(child: InputUserCreateAlbum()),
        Text('Controle'),
      ],
    );
  }
}

class InputUserCreateAlbum extends StatefulWidget {
  const InputUserCreateAlbum({super.key});

  @override
  InputUserCreateAlbumState createState() => InputUserCreateAlbumState();
}

class InputUserCreateAlbumState extends State<InputUserCreateAlbum> {
  final TextEditingController _controller = TextEditingController();
  Future<Album>? _futureAlbum;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: (_futureAlbum == null) ? buildColumn() : buildFutureBuilder(),
      ),
    );
  }

  Row buildColumn() {
    return Row(
      children: <Widget>[
        TextField(
          controller: _controller,
          decoration: const InputDecoration(hintText: 'Enter Title'),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _futureAlbum = createAlbum(_controller.text);
            });
          },
          child: const Text('Create Data'),
        ),
      ],
    );
  }

  FutureBuilder<Album> buildFutureBuilder() {
    return FutureBuilder<Album>(
      future: _futureAlbum,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data!.title);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
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
                splashColor: const Color.fromARGB(255, 216, 142, 230),
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
            child: const Text('Changer le thème'),
          ),
          ElevatedButton(
            onPressed: () {
              AdaptiveTheme.of(context).setSystem();
            },
            child: const Text("Utiliser le thème de l'appareil"),
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
