import 'package:flutter/material.dart';

import 'cHttp.dart';
import 'pPage.dart';

class MapPage extends BasePage {
  MapPage({super.key}) : super(title: 'Carte');

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
