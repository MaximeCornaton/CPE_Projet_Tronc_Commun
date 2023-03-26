import 'package:flutter/material.dart';

abstract class BasePage extends StatefulWidget {
  final String title;

  BasePage({Key? key, required this.title}) : super(key: key);

  String getTitle() {
    return title;
  }
}
