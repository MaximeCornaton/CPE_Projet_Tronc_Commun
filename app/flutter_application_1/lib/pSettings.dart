import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

import 'components/cSwitch.dart';
import 'components/cButton.dart';

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
          SwitchWidget(
            text: 'Changer le thème',
            onPressed: () {
              AdaptiveTheme.of(context).toggleThemeMode();
            },
          ),
          ButtonWidget(
            text: 'Utiliser le thème système',
            onPressed: () {
              AdaptiveTheme.of(context).setSystem();
            },
          ),
        ],
      ),
    );
  }
}
