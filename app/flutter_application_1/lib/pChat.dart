import 'package:flutter/material.dart';
import 'package:flutter_application_1/cWebSocket.dart';

class ChatPage extends StatefulWidget {
  final bool showAnswers;
  final WebSocket webSocket;

  const ChatPage({this.showAnswers = true, super.key, required this.webSocket})
      : super();

  @override
  ChatPageState createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  final TextEditingController _textController = TextEditingController();
  final List<String> _messages = [];
  final List<String> _reponses = [];

  bool _isHovered = false;
  late bool _showAnswers;

  @override
  void initState() {
    super.initState();
    _showAnswers = widget.showAnswers;
    widget.webSocket.connect_funct(onDataREceived);
  }

  void onDataREceived(String message) {
    setState(() {
      _reponses.add(message);
    });
  }

  @override
  void dispose() {
    widget.webSocket.close();
    super.dispose();
  }

  Widget _buildTextComposer() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        children: <Widget>[
          Flexible(
            child: TextField(
              controller: _textController,
              decoration: const InputDecoration(
                  hintText: 'Entrez un message', border: InputBorder.none),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            child: InkWell(
              onHover: (value) {
                setState(() {
                  _isHovered = value;
                });
              },
              onTap: () {
                final message = _textController.text;
                _sendChatMessage(message);
                setState(() {
                  _messages.add(message);
                });
                _textController.clear();
              },
              child: Icon(
                Icons.send,
                size: 20,
                color: _isHovered
                    ? Theme.of(context)
                        .bottomNavigationBarTheme
                        .selectedItemColor
                    : Theme.of(context)
                        .bottomNavigationBarTheme
                        .unselectedItemColor,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            child: InkWell(
              onTap: () {
                setState(() {
                  _showAnswers = !_showAnswers;
                });
              },
              child: Icon(
                  size: 20,
                  _showAnswers
                      ? Icons.visibility_rounded
                      : Icons.visibility_off_rounded,
                  color: _showAnswers
                      ? Theme.of(context)
                          .bottomNavigationBarTheme
                          .selectedItemColor
                      : Theme.of(context)
                          .bottomNavigationBarTheme
                          .unselectedItemColor),
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
          final response = index < _reponses.length ? _reponses[index] : "";
          return ChatMessage(
            message: message,
            answer: response,
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

  void _sendChatMessage(String message) {
    // logique pour envoyer le message
    widget.webSocket.send(Message("message", message));
  }
}

class ChatMessage extends StatefulWidget {
  final String message;
  final String answer;
  final bool showResponses;

  const ChatMessage({
    Key? key,
    required this.message,
    required this.answer,
    required this.showResponses,
  }) : super(key: key);

  @override
  ChatMessageState createState() => ChatMessageState();
}

class ChatMessageState extends State<ChatMessage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.end, // Aligner les éléments à droite
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(5.0),
              topRight: Radius.circular(5.0),
              bottomLeft: Radius.circular(5.0),
              bottomRight: Radius.zero, // Changer le coin arrondi
            ),
          ),
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(top: 10.0),
          child: Text(
            widget.message,
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
        ),
        if (widget.answer != "" && widget.showResponses)
          Container(
            decoration: const BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5.0),
                topRight: Radius.zero, // Changer le coin arrondi
                bottomLeft: Radius.circular(5.0),
                bottomRight: Radius.circular(5.0),
              ),
            ),
            padding: const EdgeInsets.all(10),
            child: Text(
              widget.answer,
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
