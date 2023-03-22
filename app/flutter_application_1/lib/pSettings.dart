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
            color_on: Theme.of(context).primaryColor,
            color_switch: Theme.of(context).primaryColor,
            onPressed: () {
              AdaptiveTheme.of(context).toggleThemeMode();
            },
            icon1: Icons.dark_mode_rounded,
            icon2: Icons.light_mode_rounded,
          ),
          ButtonWidget(
            text: 'Utiliser le thème système',
            onPressed: () {
              AdaptiveTheme.of(context).setSystem();
            },
            icon: Icons.dark_mode_rounded,
          ),
        ],
      ),
    );
  }
}
