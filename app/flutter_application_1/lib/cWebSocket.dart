import 'dart:convert';

import 'package:web_socket_channel/web_socket_channel.dart';

class Message {
  final String type;
  final dynamic value;

  Message(this.type, this.value);

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'value': value,
    };
  }

  static Message fromJson(Map<String, dynamic> json) {
    return Message(
      json['type'],
      json['value'],
    );
  }
}

class WebSocket {
  Uri url = Uri.parse('ws://');
  bool isConnected = false;

  late WebSocketChannel channel;
  late Function(String) onDataREceived;

  String value = "";

  void connect_funct(Function(String) onDataREceived) {
    this.onDataREceived = onDataREceived;
    connect();
  }

  void connect() {
    try {
      if (url != null && url != Uri.parse('ws://')) {
        channel = WebSocketChannel.connect(url);
        channel.stream.listen((message) {
          onReceive(message);
        });
        isConnected = true;
      }
    } catch (e) {
      print('WebSocket connection failed: $e');
      isConnected = false;
    }
  }

  void saveUrl(Uri url) {
    this.url = url;
  }

  void set_funct(Function(String) onDataREceived) {
    this.onDataREceived = onDataREceived;
  }

  void send(Message message) {
    if (!isConnected) {
      print('WebSocket is not connected');
      return;
    }
    final jsonString = jsonEncode(message.toJson());
    channel.sink.add(jsonString);
  }

  void close() {
    if (channel != null) {
      channel.sink.close();
    }
  }

  void onReceive(String message) {
    final json = jsonDecode(message);
    final messageObject = Message.fromJson(json);
    switch (messageObject.type) {
      case 'video':
        onVideoReceive(messageObject.value);
        break;
      case 'map':
        onMapReceive(messageObject.value);
        break;
      case 'message':
        onMessageReceive(messageObject.value);
        break;
      default:
        break;
    }

    value = messageObject.value;
  }

  void onVideoReceive(String imageBase64) {
    onDataREceived(imageBase64);
  }

  void onMapReceive(String imageBase64) {
    onDataREceived(imageBase64);
  }

  void onMessageReceive(data) {
    value = data;
  }

  String getValue() {
    return value;
  }

  bool isConnected_funct() {
    return isConnected;
  }
}
