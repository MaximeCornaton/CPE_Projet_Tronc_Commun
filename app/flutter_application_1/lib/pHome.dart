import 'package:flutter/material.dart';
import 'package:flutter_application_1/cWebSocket.dart';
import 'package:flutter_application_1/components/cWidget.dart';

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
  List<Widget> boxes = [
    const RoundedBox(
      width: double.infinity,
      height: 200.0,
      borderColor: Colors.orange,
    ),
    const RoundedBox(
      width: double.infinity,
      height: 100.0,
      borderColor: Colors.orange,
    ),
    const RoundedBox(
      width: double.infinity,
      height: 200.0,
      borderColor: Colors.orange,
    ),
    const RoundedBox(
      width: double.infinity,
      height: 200.0,
      borderColor: Colors.orange,
    ),
    const RoundedBox(
      width: double.infinity,
      height: 200.0,
      borderColor: Colors.orange,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        margin: const EdgeInsets.fromLTRB(20, 30, 20, 20),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: boxes[0],
                  ),
                  Expanded(
                    child: boxes[1],
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: boxes[2],
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: boxes[3],
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: boxes[4],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
