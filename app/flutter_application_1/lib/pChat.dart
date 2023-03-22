import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

import 'cHttp.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  ChatPageState createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  final TextEditingController _textController = TextEditingController();
  final List<Map<String, String>> _messages = [];
  //Future<Album>? _futureAlbum;

  bool _isHovered = false;
  bool _showAnswers = true;

  Widget _buildTextComposer() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: <Widget>[
          Flexible(
            child: TextField(
              controller: _textController,
              decoration: const InputDecoration(hintText: 'Entrez un message'),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            child: InkWell(
              onHover: (value) {
                setState(() {
                  _isHovered = value;
                });
              },
              onTap: () async {
                final message = _textController.text;
                final response = await sendMessage(message);
                setState(() {
                  _messages.add({'message': message, 'response': response});
                });
                _textController.clear();
              },
              child: Icon(
                Icons.send,
                color: _isHovered
                    ? Theme.of(context)
                        .bottomNavigationBarTheme
                        .selectedItemColor
                    : null,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            child: InkWell(
              onTap: () {
                setState(() {
                  _showAnswers = !_showAnswers;
                });
              },
              child: Icon(Icons.visibility,
                  color: _showAnswers
                      ? Theme.of(context)
                          .bottomNavigationBarTheme
                          .selectedItemColor
                      : null),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget messageList;
    if (_messages.isEmpty) {
      messageList = const Center(
        child: Text('Aucun message'),
      );
    } else {
      messageList = ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: _messages.length,
        itemBuilder: (BuildContext context, int index) {
          final message = _messages[index];
          return ChatMessage(
            message: message['message']!,
            response: message['response']!,
            showResponses: _showAnswers,
          );
        },
      );
    }
    return Scaffold(
        body: Column(
      children: <Widget>[
        Expanded(child: messageList),
        const Divider(height: 1.0),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
          ),
          child: Column(
            children: <Widget>[
              _buildTextComposer(),
              const Divider(height: 1.0),
            ],
          ),
        ),
      ],
    ));
  }

  Future<String> sendMessage(String message) async {
    // logique pour envoyer le message
    //_futureAlbum = createAlbum(message);

    //_futureAlbum = await createAlbum(message);
    //await createAlbum(message);

    await Future.delayed(const Duration(seconds: 1));
    return message;
  }
}

class ChatMessage extends StatefulWidget {
  final String message;
  final String response;
  final bool showResponses;

  const ChatMessage({
    Key? key,
    required this.message,
    required this.response,
    required this.showResponses,
  }) : super(key: key);

  @override
  ChatMessageState createState() => ChatMessageState();
}

class ChatMessageState extends State<ChatMessage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(5.0),
              topRight: Radius.circular(5.0),
              bottomLeft: Radius.zero,
              bottomRight: Radius.circular(5.0),
            ),
          ),
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(top: 10.0),
          child: Text(
            widget.message,
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
        ),
        if (widget
            .showResponses) // afficher le message de réponse si showResponses est true
          Container(
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                topLeft: Radius.zero,
                topRight: Radius.circular(5.0),
                bottomLeft: Radius.circular(5.0),
                bottomRight: Radius.circular(5.0),
              ),
            ),
            padding: const EdgeInsets.all(10),
            child: Text(
              widget.response,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
          ),
      ],
    );
  }
}
