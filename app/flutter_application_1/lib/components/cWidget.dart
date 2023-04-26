import 'package:flutter/material.dart';

class RoundedBox extends StatelessWidget {
  final double width;
  final double height;
  final Color? color;
  final Widget? child;
  final Color? borderColor;

  const RoundedBox({
    super.key,
    required this.width,
    required this.height,
    this.borderColor,
    this.color,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: borderColor ?? Colors.black,
              width: 2,
            ),
            color: color,
          ),
          child: child,
        ));
  }
}
