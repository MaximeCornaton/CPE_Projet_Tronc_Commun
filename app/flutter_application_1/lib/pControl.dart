import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/cWebSocket.dart';
import 'package:transparent_image/transparent_image.dart';

class ControlPage extends StatefulWidget {
  final WebSocket webSocketVideo;
  final WebSocket webSocketControl;

  const ControlPage(
      {Key? key, required this.webSocketVideo, required this.webSocketControl})
      : super(key: key);

  @override
  ControlPageState createState() => ControlPageState();
}

class ControlPageState extends State<ControlPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: VideoWidget(webSocket: widget.webSocketVideo),
        ),
        Expanded(
          child: ControlButtons(webSocket: widget.webSocketControl),
        ),
      ],
    );
  }

  @override
  void dispose() {
    widget.webSocketVideo.close();
    widget.webSocketControl.close();
    super.dispose();
  }
}

class VideoWidget extends StatefulWidget {
  final WebSocket webSocket;

  const VideoWidget({Key? key, required this.webSocket}) : super(key: key);

  @override
  VideoWidgetState createState() => VideoWidgetState();
}

class VideoWidgetState extends State<VideoWidget> {
  late StreamController<String> _streamController;

  String imageBase64 = "";

  @override
  void initState() {
    super.initState();
    _streamController = StreamController<String>.broadcast();
    widget.webSocket.connect_funct(onDataREceived);
  }

  @override
  void dispose() {
    _streamController.close();
    widget.webSocket.close();
    super.dispose();
  }

  void onDataREceived(String imageBase64) {
    _streamController.add(imageBase64);
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
            child: StreamBuilder<String>(
              stream: _streamController.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: 'data:image/jpeg;base64,${snapshot.data}',
                    fit: BoxFit.cover,
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ControlButtons extends StatefulWidget {
  const ControlButtons({Key? key, required this.webSocket}) : super(key: key);
  final WebSocket webSocket;

  @override
  _ControlButtonsState createState() => _ControlButtonsState();
}

class _ControlButtonsState extends State<ControlButtons> {
  bool _isMovingForward = false;
  bool _isMovingBackward = false;
  bool _isTurningLeft = false;
  bool _isTurningRight = false;
  double _speed = 1;

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

  Future<void> _sendControlMessage() async {
    // logique pour envoyer le message
    final message = {
      'move_forward': _isMovingForward.toString(),
      'move_backward': _isMovingBackward.toString(),
      'turn_left': _isTurningLeft.toString(),
      'turn_right': _isTurningRight.toString(),
      'speed': _speed.toString(),
    };
    widget.webSocket.send(Message("control", jsonEncode(message)));
  }

  void _moveForward(bool value) {
    setState(() {
      _isMovingForward = value;
    });
    _sendControlMessage();
  }

  void _moveBackward(bool value) {
    setState(() {
      _isMovingBackward = value;
    });
    _sendControlMessage();
  }

  void _turnLeft(bool value) {
    setState(() {
      _isTurningLeft = value;
    });
    _sendControlMessage();
  }

  void _turnRight(bool value) {
    setState(() {
      _isTurningRight = value;
    });
    _sendControlMessage();
  }

  void _stop() {
    setState(() {
      _isMovingForward = false;
      _isMovingBackward = false;
      _isTurningLeft = false;
      _isTurningRight = false;
      _speed = 1;
    });
    _sendControlMessage();
  }

  Widget _buildJoystickButton(
      IconData icon, bool isPressed, Function(bool) onPressedFunction) {
    return IconButton(
      onPressed: () => onPressedFunction(!isPressed),
      icon: Icon(icon),
      color: isPressed
          ? Theme.of(context).bottomNavigationBarTheme.selectedItemColor
          : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 40, right: 40),
          child: SliderTheme(
            data: const SliderThemeData(
              valueIndicatorTextStyle: TextStyle(color: Colors.white),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Vitesse: $_speed",
                    style: const TextStyle(fontSize: 18.0)),
                Slider(
                  value: _speed,
                  min: 1.0,
                  max: 3.0,
                  divisions: 2,
                  // label: _speed.round().toString(),
                  onChanged: (double value) {
                    setState(() {
                      _speed = value;
                    });
                    _sendControlMessage();
                  },
                ),
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildJoystickButton(
              Icons.keyboard_arrow_up_rounded,
              _isMovingForward,
              _moveForward,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildJoystickButton(
              Icons.keyboard_arrow_left_rounded,
              _isTurningLeft,
              _turnLeft,
            ),
            const SizedBox(width: 50),
            _buildJoystickButton(
              Icons.keyboard_arrow_right_rounded,
              _isTurningRight,
              _turnRight,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildJoystickButton(
              Icons.keyboard_arrow_down_rounded,
              _isMovingBackward,
              _moveBackward,
            ),
          ],
        ),
        const SizedBox(height: 30),
        ElevatedButton(
          onPressed: _stop,
          child: const Text('Arrêter'),
        ),
      ],
    );
  }
}
