import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_application_1/cWebSocket.dart';

class MapPage extends StatefulWidget {
  final WebSocket webSocket;
  const MapPage({super.key, required this.webSocket}) : super();

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  List<double> _xCoordinates = [];
  List<double> _yCoordinates = [];

  @override
  void initState() {
    super.initState();
    widget.webSocket.connect_funct(onDataReceived);
  }

  @override
  void dispose() {
    widget.webSocket.close();
    super.dispose();
  }

  void onDataReceived(String data) {
    Map<String, dynamic> decodedData = json.decode(data);
    setState(() {
      _xCoordinates = List<double>.from(decodedData['xCoordinates']);
      _yCoordinates = List<double>.from(decodedData['yCoordinates']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 40),
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
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: CustomPaint(
              painter: MapPainter(_xCoordinates, _yCoordinates),
            ),
          ),
        ],
      ),
    );
  }
}

class MapPainter extends CustomPainter {
  final List<double> xCoordinates;
  final List<double> yCoordinates;

  MapPainter(this.xCoordinates, this.yCoordinates);

  @override
  void paint(Canvas canvas, Size size) {
    print("Canvas size: $size");
    final paint = Paint()
      ..color = Colors.orange
      ..strokeWidth = 5;

    canvas.translate(size.width / 2, size.height * 0.75);
    canvas.rotate(math.pi);

    for (int i = 0; i < xCoordinates.length; i++) {
      canvas.drawCircle(
        Offset(xCoordinates[i] / 7500 * size.width,
            yCoordinates[i] / 7500 * size.height),
        3,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(MapPainter oldDelegate) =>
      oldDelegate.xCoordinates != xCoordinates ||
      oldDelegate.yCoordinates != yCoordinates;
}
