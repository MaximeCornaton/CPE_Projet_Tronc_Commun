
import 'package:flutter/material.dart';
import 'package:arrow_pad/arrow_pad.dart';



class ControlPage extends StatefulWidget {
  const ControlPage({Key? key}) : super(key: key);

  @override
  ControlPageState createState() => ControlPageState();
}

class ControlPageState extends State<ControlPage> {
  @override
  Widget build(BuildContext context) {
    return const ArrowPadExample();
  }
}

class ArrowPadExample extends StatefulWidget {
  const ArrowPadExample({Key? key}) : super(key: key);

  @override
  ArrowPadExampleState createState() => ArrowPadExampleState();
}

class ArrowPadExampleState extends State<ArrowPadExample> {
  String arrowPadValue = 'With Functions (tapUp)';

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ArrowPad(
                padding: const EdgeInsets.all(8.0),
                height: height / 5,
                width: width / 4,
                iconColor: Colors.white,
                innerColor: const Color.fromARGB(255, 22, 21, 21),
                outerColor: const Color.fromARGB(255, 0, 0, 0),
                splashColor: Theme.of(context)
                    .bottomNavigationBarTheme
                    .selectedItemColor,
                hoverColor: const Color.fromARGB(255, 42, 42, 42),
                clickTrigger: ClickTrigger.onTapUp,
                onPressedUp: () {
                  setState(() {
                    arrowPadValue = 'Up Pressed (tapUp)';
                  });
                },
                onPressedDown: () {
                  setState(() {
                    arrowPadValue = 'Down Pressed (tapUp)';
                  });
                },
                onPressedLeft: () {
                  setState(() {
                    arrowPadValue = 'Left Pressed (tapUp)';
                  });
                },
                onPressedRight: () {
                  setState(() {
                    arrowPadValue = 'Right Pressed (tapUp)';
                  });
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                arrowPadValue,
                style: const TextStyle(fontSize: 24),
              ),
            ],
          ),
        ],
      ),
    );
  }
}