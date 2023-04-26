import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/cWebSocket.dart';

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
}

class VideoWidget extends StatefulWidget {
  final WebSocket webSocket;

  const VideoWidget({Key? key, required this.webSocket}) : super(key: key);

  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  String imageBase64 = "";

  @override
  void initState() {
    super.initState();
    widget.webSocket
        .connect_funct(Uri.parse("ws://192.168.137.107:8889"), onDataREceived);
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

  @override
  void initState() {
    super.initState();
    widget.webSocket.connect(Uri.parse("ws://192.168.137.107:8888"));
  }

  Future<void> _sendControlMessage() async {
    // logique pour envoyer le message
    final message = {
      'move_forward': _isMovingForward.toString(),
      'move_backward': _isMovingBackward.toString(),
      'turn_left': _isTurningLeft.toString(),
      'turn_right': _isTurningRight.toString(),
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
