import 'package:flutter/material.dart';
import 'package:flutter_application_1/pPage.dart';

class ControlPage extends BasePage {
  ControlPage() : super(title: 'Contrôle');

  @override
  _ControlPageState createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () => _moveForward(true),
                  icon: const Icon(Icons.keyboard_arrow_up_rounded),
                  color: _isMovingForward
                      ? Theme.of(context)
                          .bottomNavigationBarTheme
                          .selectedItemColor
                      : null,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () => _turnLeft(true),
                  icon: const Icon(Icons.keyboard_arrow_left_rounded),
                  color: _isTurningLeft
                      ? Theme.of(context)
                          .bottomNavigationBarTheme
                          .selectedItemColor
                      : null,
                ),
                const SizedBox(width: 50),
                IconButton(
                  onPressed: () => _turnRight(true),
                  icon: const Icon(Icons.keyboard_arrow_right_rounded),
                  color: _isTurningRight
                      ? Theme.of(context)
                          .bottomNavigationBarTheme
                          .selectedItemColor
                      : null,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () => _moveBackward(true),
                  icon: const Icon(Icons.keyboard_arrow_down_rounded),
                  color: _isMovingBackward
                      ? Theme.of(context)
                          .bottomNavigationBarTheme
                          .selectedItemColor
                      : null,
                ),
              ],
            ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: _stop,
              child: Text('Arrêter'),
            ),
          ],
        ),
      ),
    );
  }
}
