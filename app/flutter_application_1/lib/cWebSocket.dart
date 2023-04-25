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
  late WebSocketChannel channel;

  late String value;

  String get data => data;

  void connect(Uri url) {
    channel = WebSocketChannel.connect(url);
    channel.stream.listen((message) {
      onReceive(message);
    });
  }

  void send(Message message) {
    if (channel != null) {
      final jsonString = jsonEncode(message.toJson());
      channel.sink.add(jsonString);
    }
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

  void onVideoReceive(data) {
    print("video: " + data);
  }

  void onMapReceive(data) {}

  void onMessageReceive(data) {
    print("message: " + data);
  }
}
