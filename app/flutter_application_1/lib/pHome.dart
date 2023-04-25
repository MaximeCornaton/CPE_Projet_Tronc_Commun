import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

class HomePage extends StatefulWidget {
  HomePage() : super();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Page d\'accueil'),
      ),
    );
  }
}
