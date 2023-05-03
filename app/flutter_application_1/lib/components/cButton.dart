import 'package:flutter/material.dart';

class ButtonWidget extends StatefulWidget {
  final String? text;
  final Function? onPressed;
  final IconData? icon;

  const ButtonWidget(
      {Key? key, this.text = 'Default Switch', this.icon, this.onPressed})
      : super(key: key);

  @override
  ButtonWidgetState createState() => ButtonWidgetState();
}

class ButtonWidgetState extends State<ButtonWidget> {
  bool _switchValue = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          setState(() {
            _switchValue = !_switchValue;
            widget.onPressed!();
          });
        },
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 1, 0, 0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(24, 12, 24, 12),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.text ?? 'Default Switch'),
                      SizedBox(
                        width: 80,
                        height: 40,
                        child: Stack(
                          alignment: const AlignmentDirectional(0, 0),
                          children: [
                            Align(
                              alignment: const AlignmentDirectional(0.30, 0),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 0, 8, 0),
                                child: Icon(
                                  widget.icon ?? Icons.nights_stay,
                                  color: const Color(0xFF95A1AC),
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
