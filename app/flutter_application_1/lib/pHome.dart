import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';


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