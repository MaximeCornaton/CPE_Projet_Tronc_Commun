import 'package:flutter/material.dart';

import 'cHttp.dart';

class MapPage extends StatefulWidget {
  MapPage({super.key}) : super();

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum("MapPage");
  }

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator();
  }
}
