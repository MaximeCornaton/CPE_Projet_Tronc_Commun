import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/cWebSocket.dart';

class MapPage extends StatefulWidget {
  final WebSocket webSocket;
  const MapPage({super.key, required this.webSocket}) : super();

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  String imageBase64 = "";

  @override
  void initState() {
    super.initState();
    widget.webSocket.connect();
  }

  @override
  void dispose() {
    widget.webSocket.close();
    super.dispose();
  }

  void onDataREceived(String imageBase64) {
    setState(() {
      this.imageBase64 = imageBase64;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 40, left: 20, right: 20),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context)
                        .bottomNavigationBarTheme
                        .selectedItemColor ??
                    Colors.black,
                width: 2,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            width: 640,
            height: 480,
            child: imageBase64.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : Image.memory(
                    base64.decode(imageBase64),
                    fit: BoxFit.cover,
                  ),
          ),
        ],
      ),
    );
  }
}
