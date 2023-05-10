import 'package:flutter/material.dart';
import 'package:flutter_application_1/cWebSocket.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage(
      {Key? key,
      required this.webSocketVideo,
      required this.webSocketMap,
      required this.webSocketControl})
      : super(key: key);

  final WebSocket webSocketVideo;
  final WebSocket webSocketMap;
  final WebSocket webSocketControl;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Text("home");
  }
}
