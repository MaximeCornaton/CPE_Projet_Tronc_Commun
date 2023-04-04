import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/pPage.dart';

import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:web_socket_channel/io.dart';

class ControlPage extends BasePage {
  ControlPage({super.key}) : super(title: 'Contrôle');

  @override
  ControlPageState createState() => ControlPageState();
}

class ControlPageState extends State<ControlPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(50.0),
            child: WebRTCWidget(),
          ),
          Padding(
            padding: EdgeInsets.all(30.0),
            child: ControlButtons(),
          ),
        ],
      ),
    );
  }
}

class WebRTCWidget extends StatefulWidget {
  const WebRTCWidget({super.key});

  @override
  WebRTCWidgetState createState() => WebRTCWidgetState();
}

class WebRTCWidgetState extends State<WebRTCWidget> {
  late IOWebSocketChannel _channel;
  final _sdpConstraints = {
    'mandatory': {
      'OfferToReceiveAudio': true,
      'OfferToReceiveVideo': true,
    },
    'optional': [],
  };
  late RTCPeerConnection _peerConnection;
  RTCVideoRenderer _videoRenderer = RTCVideoRenderer();
  bool _isConnected = false;
  bool _isWebSocketConnected = false;

  Future<void> initRenderer() async {
    await _videoRenderer.initialize();
  }

  @override
  void initState() {
    super.initState();
    initRenderer();
    initWebRTC();
  }

  Future<void> initWebRTC() async {
    try {
      _channel = IOWebSocketChannel.connect('ws://localhost:8080');
      _peerConnection = await createPeerConnection(_sdpConstraints);
      _peerConnection.onTrack = (RTCTrackEvent event) {
        if (event.track.kind == 'video') {
          _videoRenderer.srcObject = event.streams[0];
        }
      };

      _channel.stream.listen((message) {
        final parsedMessage = jsonDecode(message);
        if (parsedMessage['id'] == 'startResponse') {
          _peerConnection.setRemoteDescription(
              RTCSessionDescription(parsedMessage['sdpAnswer'], 'answer'));
        }
      });

      final offer = await _peerConnection.createOffer(_sdpConstraints);
      await _peerConnection.setLocalDescription(offer);
      _channel.sink.add(jsonEncode({'id': 'start', 'sdpOffer': offer.sdp}));
      setState(() {
        _isConnected = true;
      });
    } catch (e) {
      print('WebSocket Connection Error: $e');
      setState(() {
        _isWebSocketConnected = false;
      });
    }
  }

  @override
  void dispose() {
    _videoRenderer.dispose();
    _peerConnection.dispose();
    _channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var borderRadius_ = BorderRadius.circular(10);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
            color:
                Theme.of(context).bottomNavigationBarTheme.selectedItemColor ??
                    Colors.grey),
        borderRadius: borderRadius_,
      ),
      child: _isWebSocketConnected
          ? (_isConnected
              ? RTCVideoView(_videoRenderer)
              : const Center(
                  child: CircularProgressIndicator(),
                ))
          : const Center(
              child: Text("Connexion WebSocket échouée"),
            ),
    );
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

  void _moveForward(bool value) {
    setState(() {
      _isMovingForward = value;
    });
  }

  void _moveBackward(bool value) {
    setState(() {
      _isMovingBackward = value;
    });
  }

  void _turnLeft(bool value) {
    setState(() {
      _isTurningLeft = value;
    });
  }

  void _turnRight(bool value) {
    setState(() {
      _isTurningRight = value;
    });
  }

  void _stop() {
    setState(() {
      _isMovingForward = false;
      _isMovingBackward = false;
      _isTurningLeft = false;
      _isTurningRight = false;
    });
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
