import 'package:flutter/material.dart';
import 'package:quiz_craft/helper/colors_sys.dart';

class HorizontalOrLine extends StatelessWidget {
  const HorizontalOrLine({
    super.key,
    required this.label,
    required this.height,
  });

  final String label;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Expanded(
        child: Container(
            margin: const EdgeInsets.only(left: 10.0, right: 15.0),
            child: Divider(
              color: ColorSys.kgrey,
              height: height,
              thickness: 2.0,
            )),
      ),
      Text(
        label,
        style: TextStyle(
          color: ColorSys.kblack,
        ),
      ),
      Expanded(
        child: Container(
            margin: const EdgeInsets.only(left: 15.0, right: 10.0),
            child: Divider(
              color: ColorSys.kgrey,
              height: height,
              thickness: 2.0,
            )),
      ),
    ]);
  }
}
