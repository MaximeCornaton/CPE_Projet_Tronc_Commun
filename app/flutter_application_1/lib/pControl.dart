import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/cWebSocket.dart';
import 'package:flutter_application_1/pPage.dart';

import 'cHttp.dart';

class ControlPage extends BasePage {
  final WebSocket webSocket;

  ControlPage({Key? key, required this.webSocket})
      : super(key: key, title: 'Contrôle');

  @override
  ControlPageState createState() => ControlPageState();
}

class ControlPageState extends State<ControlPage> {
  @override
  Widget build(BuildContext context) {
    return VideoWidget(webSocket: widget.webSocket);
  }
}

class VideoWidget extends StatefulWidget {
  final WebSocket webSocket;

  const VideoWidget({Key? key, required this.webSocket}) : super(key: key);

  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late String imageBase64;

  @override
  void initState() {
    super.initState();
    widget.webSocket.connect(Uri.parse("ws://192.168.243.212:8889"));
    setState(() {
      imageBase64 = widget.webSocket.data;
    });
  }

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   child: imageBase64 == null
    //       ? const CircularProgressIndicator()
    //       : Image.memory(
    //           base64.decode(imageBase64),
    //           fit: BoxFit.cover,
    //         ),
    // );
    return Text(imageBase64);
  }
}

class ControlButtons extends StatefulWidget {
  const ControlButtons({Key? key}) : super(key: key);

  @override
  ControlButtonsState createState() => ControlButtonsState();
}

class ControlButtonsState extends State<ControlButtons> {
  bool _isMovingForward = false;
  bool _isMovingBackward = false;
  bool _isTurningLeft = false;
  bool _isTurningRight = false;

  void _sendControlMessage() async {
    // logique pour envoyer le message
    final message = {
      'move_forward': _isMovingForward.toString(),
      'move_backward': _isMovingBackward.toString(),
      'turn_left': _isTurningLeft.toString(),
      'turn_right': _isTurningRight.toString(),
    };
    createAlbum('control', message.toString());
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
        const SizedBox(height: 50),
        ElevatedButton(
          onPressed: _stop,
          child: const Text('Arrêter'),
        ),
      ],
    );
  }
}
