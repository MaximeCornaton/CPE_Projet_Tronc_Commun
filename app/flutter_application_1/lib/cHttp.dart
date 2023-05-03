import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

/* HTTP REQUESTS */

class Album {
  final int id;
  final String title;
  final String body;

  const Album({
    required this.id,
    required this.title,
    required this.body,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}

Future<Album> fetchAlbum(String param) async {
  try {
    final response =
        await http.get(Uri.parse('http://172.20.10.2:3000/data/$param'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON and return an Album object.
      return Album.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load data');
    }
  } catch (e) {
    // Handle the exception here, e.g. log it or display an error message to the user.
    print('An error occurred while fetching the data: $e');
    return const Album(id: 0, title: 'error', body: 'error');
  }
}

void createAlbum(String title, String body_) async {
  try {
    final response = await http.post(
      Uri.parse('http://172.20.10.2:3000/data'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'title': title,
        'body': body_,
      }),
    );

    if (response.statusCode != 201) {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  } catch (e) {
    if (kDebugMode) {
      print('An error occurred while creating the album: $e');
    }
    // You can display an error message to the user here
  }
}
