import 'package:flutter/material.dart';

import 'components/cSwitch.dart';
import 'components/cButton.dart';
import 'main.dart';

class SettingsPage extends StatefulWidget {
  final String wbVideo;
  final String wbMessage;
  final String wbMap;

  final Function updateString;

  const SettingsPage(
      {super.key,
      required this.updateString,
      required this.wbVideo,
      required this.wbMessage,
      required this.wbMap})
      : super();

  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  late TextEditingController _wbVideoController;
  late TextEditingController _wbMessageController;
  late TextEditingController _wbMapController;

  @override
  void initState() {
    super.initState();
    _wbVideoController = TextEditingController(text: widget.wbVideo);
    _wbMessageController = TextEditingController(text: widget.wbMessage);
    _wbMapController = TextEditingController(text: widget.wbMap);
  }

  @override
  void dispose() {
    _wbVideoController.dispose();
    _wbMessageController.dispose();
    _wbMapController.dispose();
    super.dispose();
  }

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
            text: 'Utiliser le thème sombre',
            onPressed: () {
              MyApp.of(context).updateThemeMode();
            },
            icon: Icons.dark_mode_rounded,
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(24, 12, 24, 12),
            child: Column(
              children: [
                TextField(
                  decoration:
                      const InputDecoration(labelText: 'WebSocket Video'),
                  controller: _wbVideoController,
                  onChanged: (value) {
                    widget.updateString('video', value);
                  },
                ),
                TextField(
                  decoration: const InputDecoration(
                      labelText: 'WebSocket Controles/Messages'),
                  controller: _wbMessageController,
                  onChanged: (value) {
                    widget.updateString('message', value);
                  },
                ),
                TextField(
                  decoration:
                      const InputDecoration(labelText: 'WebSocket Carte'),
                  controller: _wbMapController,
                  onChanged: (value) {
                    widget.updateString('map', value);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
