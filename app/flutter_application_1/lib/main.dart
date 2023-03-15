import 'package:flutter/material.dart';
import 'package:arrow_pad/arrow_pad.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'Projet Tronc Commun - Group A1';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        primaryColor: Colors.black, // Couleur de la barre supérieure
        appBarTheme: const AppBarTheme(
          backgroundColor:
              Colors.black, // Couleur de fond de la barre supérieure
        ),
        scaffoldBackgroundColor: Colors.grey[900], // Couleur de fond de la page
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Color.fromARGB(
              255, 185, 117, 197), // La couleur de l'élément sélectionné
          unselectedItemColor:
              Colors.white, // La couleur des éléments non sélectionnés
        ),
      ),
      home: const MyStatefulWidget(),
      routes: {
        '/home': (context) => const HomePage(),
        '/control': (context) => const ControlPage(),
        '/map': (context) => const MapPage(),
        '/settings': (context) => const SettingsPage(),
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
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
            backgroundColor:
                Colors.black, // La couleur de fond de la barre de navigation
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_remote_rounded),
            label: 'Control',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
            backgroundColor: Colors.black,
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: const Center(
        child: Text(
          'Accueil!',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}

class ControlPage extends StatelessWidget {
  const ControlPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Controle'),
      ),
      body: const ArrowPadExample(),
    );
  }
}

class ArrowPadExample extends StatefulWidget {
  const ArrowPadExample({Key? key}) : super(key: key);

  @override
  _ArrowPadExampleState createState() => _ArrowPadExampleState();
}

class _ArrowPadExampleState extends State<ArrowPadExample> {
  String ArrowPadValue = 'With Functions (tapUp)';

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ArrowPad(
                    padding: const EdgeInsets.all(8.0),
                    height: height / 5,
                    width: width / 4,
                    iconColor: Colors.white, // couleur des icones
                    innerColor: const Color.fromARGB(
                        255, 22, 21, 21), // couleur du cercle interieur
                    outerColor: const Color.fromARGB(
                        255, 0, 0, 0), // couleur du cercle exterieur
                    splashColor: const Color.fromARGB(
                        255, 185, 117, 197), // couleur du splash
                    hoverColor:
                        Color.fromARGB(255, 42, 42, 42), // couleur du hover
                    clickTrigger: ClickTrigger.onTapUp,
                    onPressedUp: () {
                      setState(() {
                        ArrowPadValue = 'Up Pressed (tapUp)';
                      });
                    },
                    onPressedDown: () {
                      setState(() {
                        ArrowPadValue = 'Down Pressed (tapUp)';
                      });
                    },
                    onPressedLeft: () {
                      setState(() {
                        ArrowPadValue = 'Left Pressed (tapUp)';
                      });
                    },
                    onPressedRight: () {
                      setState(() {
                        ArrowPadValue = 'Right Pressed (tapUp)';
                      });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    ArrowPadValue,
                    style: const TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carte'),
      ),
      body: const Center(
        child: Text(
          'Carte.',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paramètres'),
      ),
      body: const Center(
        child: Text(
          'Parametres.',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}
