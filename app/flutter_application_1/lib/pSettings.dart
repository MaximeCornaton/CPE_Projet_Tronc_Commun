import 'package:flutter/material.dart';

import 'components/cSwitch.dart';
import 'components/cButton.dart';
import 'pPage.dart';
import 'main.dart';

class SettingsPage extends BasePage {
  SettingsPage({super.key}) : super(title: 'Paramètres');

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
              MyApp.of(context).toggleThemeMode();
            },
            icon1: Icons.dark_mode_rounded,
            icon2: Icons.light_mode_rounded,
          ),
          ButtonWidget(
            text: 'Utiliser le thème système',
            onPressed: () {
              MyApp.of(context).updateThemeMode();
            },
            icon: Icons.settings_brightness_rounded,
          ),
        ],
      ),
    );
  }
}
