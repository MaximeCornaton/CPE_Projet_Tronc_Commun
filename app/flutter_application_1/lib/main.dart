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
          backgroundColor: Colors.black, // Couleur de fond de la barre supérieure
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
            backgroundColor:
              Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
            backgroundColor:
              Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
            backgroundColor:
              Colors.black,
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
  String _secondArrowPadValue = 'With Functions (tapDown)';
  String _thirdArrowPadValue = 'With Functions (tapUp)';

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Arrow Pad Example'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  ArrowPad(),
                  Text('Default Arrow Pad'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ArrowPad(
                    padding: const EdgeInsets.all(8.0),
                    height: height / 5,
                    width: width / 4,
                    iconColor: Colors.white,
                    innerColor: Colors.red,
                    outerColor: const Color(0xFFCC0000),
                    splashColor: const Color(0xFFCC0000),
                    hoverColor: const Color(0xFFFF4D4D),
                    onPressedUp: () {
                      setState(() {
                        _secondArrowPadValue = 'Up Pressed (tapDown)';
                      });
                    },
                    onPressedDown: () {
                      setState(() {
                        _secondArrowPadValue = 'Down Pressed (tapDown)';
                      });
                    },
                    onPressedLeft: () {
                      setState(() {
                        _secondArrowPadValue = 'Left Pressed (tapDown)';
                      });
                    },
                    onPressedRight: () {
                      setState(() {
                        _secondArrowPadValue = 'Right Pressed (tapDown)';
                      });
                    },
                  ),
                  Text(_secondArrowPadValue),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ArrowPad(
                    padding: const EdgeInsets.all(8.0),
                    height: height / 5,
                    width: width / 4,
                    iconColor: Colors.white,
                    innerColor: Colors.red,
                    outerColor: const Color(0xFFCC0000),
                    splashColor: const Color(0xFFCC0000),
                    hoverColor: const Color(0xFFFF4D4D),
                    clickTrigger: ClickTrigger.onTapUp,
                    onPressedUp: () {
                      setState(() {
                        _thirdArrowPadValue = 'Up Pressed (tapUp)';
                      });
                    },
                    onPressedDown: () {
                      setState(() {
                        _thirdArrowPadValue = 'Down Pressed (tapUp)';
                      });
                    },
                    onPressedLeft: () {
                      setState(() {
                        _thirdArrowPadValue = 'Left Pressed (tapUp)';
                      });
                    },
                    onPressedRight: () {
                      setState(() {
                        _thirdArrowPadValue = 'Right Pressed (tapUp)';
                      });
                    },
                  ),
                  Text(_thirdArrowPadValue),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ArrowPad(
                    padding: const EdgeInsets.all(8.0),
                    height: height / 5,
                    width: width / 4,
                    arrowPadIconStyle: ArrowPadIconStyle.arrow,
                    hoverColor: Colors.green,
                    iconColor: const Color(0xFF631739),
                    outerColor: const Color(0xFF86FC8A),
                  ),
                  const Text('Without Functions'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ArrowPad(
                    height: height / 7,
                    width: width / 6,
                    innerColor: Colors.blue,
                    arrowPadIconStyle: ArrowPadIconStyle.arrow,
                  ),
                  const Text('Small Size'),
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
