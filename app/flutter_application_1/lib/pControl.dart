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
                  icon: Icon(Icons.arrow_upward),
                  color: _isMovingForward ? Colors.blue : null,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () => _turnLeft(true),
                  icon: Icon(Icons.arrow_left),
                  color: _isTurningLeft ? Colors.blue : null,
                ),
                SizedBox(width: 50),
                IconButton(
                  onPressed: () => _turnRight(true),
                  icon: Icon(Icons.arrow_right),
                  color: _isTurningRight ? Colors.blue : null,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () => _moveBackward(true),
                  icon: Icon(Icons.arrow_downward),
                  color: _isMovingBackward ? Colors.blue : null,
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
