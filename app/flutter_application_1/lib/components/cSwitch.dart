import 'package:flutter/material.dart';

class SwitchWidget extends StatefulWidget {
  final String? text;
  final Function? onPressed;
  final IconData? icon1;
  final IconData? icon2;
  final Color? color_on;
  final Color? color_switch;

  const SwitchWidget(
      {Key? key,
      this.text = 'Default Switch',
      this.icon1,
      this.icon2,
      this.onPressed,
      this.color_switch,
      this.color_on})
      : super(key: key);

  @override
  _SwitchWidgetState createState() => _SwitchWidgetState();
}

class _SwitchWidgetState extends State<SwitchWidget> {
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
                      Container(
                        width: 80,
                        height: 40,
                        decoration: BoxDecoration(
                          color: widget.color_on,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Stack(
                          alignment: const AlignmentDirectional(0, 0),
                          children: [
                            Align(
                              alignment: const AlignmentDirectional(0.95, 0),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 0, 8, 0),
                                child: Icon(
                                  widget.icon1,
                                  color: const Color(0xFF95A1AC),
                                  size: 20,
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(-0.55, 0),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 0, 8, 0),
                                child: Icon(
                                  widget.icon2,
                                  color: const Color(0xFF95A1AC),
                                  size: 20,
                                ),
                              ),
                            ),
                            Align(
                              alignment: _switchValue
                                  ? const AlignmentDirectional(0.85, 0)
                                  : const AlignmentDirectional(-0.85, 0),
                              child: Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  color: widget.color_switch,
                                  boxShadow: const [
                                    BoxShadow(
                                      blurRadius: 4,
                                      color: Color(0x430B0D0F),
                                      offset: Offset(0, 2),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(30),
                                  shape: BoxShape.rectangle,
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
