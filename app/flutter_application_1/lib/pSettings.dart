import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:arrow_pad/arrow_pad.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

import 'package:http/http.dart' as http;


class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {

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