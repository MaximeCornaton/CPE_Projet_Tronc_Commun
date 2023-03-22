import 'package:flutter/material.dart';

class ButtonWidget extends StatefulWidget {
  final String? text;
  final Function? onPressed;
  final IconData? icon;

  const ButtonWidget(
      {Key? key, this.text = 'Default Switch', this.icon, this.onPressed})
      : super(key: key);

  @override
  _ButtonWidgetState createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
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
                      const SizedBox(
                        width: 80,
                        height: 40,
                        child: Stack(
                          alignment: AlignmentDirectional(0, 0),
                          children: [
                            Align(
                              alignment: AlignmentDirectional(0.30, 0),
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                                child: Icon(
                                  Icons.nights_stay,
                                  color: Color(0xFF95A1AC),
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
