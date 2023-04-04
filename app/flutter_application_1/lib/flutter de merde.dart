import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:web_socket_channel/io.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WebRTCExample(),
    );
  }
}

class WebRTCExample extends StatefulWidget {
  @override
  _WebRTCExampleState createState() => _WebRTCExampleState();
}

class _WebRTCExampleState extends State<WebRTCExample> {
  final _channel = IOWebSocketChannel.connect('ws://your_server_ip:8080');
  final _sdpConstraints = {
    'mandatory': {
      'OfferToReceiveAudio': true,
      'OfferToReceiveVideo': true,
    },
    'optional': [],
  };
  RTCPeerConnection _peerConnection;
  RTCVideoRenderer _videoRenderer = RTCVideoRenderer();

  @override
  void initState() {
    super.initState();
    initRenderer();
    initWebRTC();
  }

  @override
  void dispose() {
    _videoRenderer.dispose();
    _peerConnection.dispose();
    _channel.sink.close();
    super.dispose();
  }

  Future<void> initRenderer() async {
    await _videoRenderer.initialize();
  }

  Future<void> initWebRTC() async {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WebRTC Example'),
      ),
      body: Center(
        child: RTCVideoView(_videoRenderer),
      ),
    );
  }
}
