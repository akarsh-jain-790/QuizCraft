import 'package:flutter/material.dart';
import 'package:quiz_craft/helper/colors_sys.dart';

class ThemeRadioButton extends StatelessWidget {
  const ThemeRadioButton(
      {super.key,
      this.controllerName,
      required this.fieldName,
      required this.groupValue,
      required this.optionValue,
      this.textFieldEvent,
      required this.radioFieldEvent,
      required this.icon,
      this.fieldColor,
      this.border = false,
      this.enabled = true,
      this.passwordField = false});

  final TextEditingController? controllerName;
  final void Function(dynamic)? textFieldEvent;
  final void Function() radioFieldEvent;
  final String fieldName;
  final String groupValue;
  final String optionValue;
  final bool passwordField;
  final Color? fieldColor;
  final IconData icon;
  final bool? border;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55.0,
      decoration: BoxDecoration(
        border: Border.all(
            color: ColorSys.kgrey, width: border == true ? 0.8 : 0.0),
        borderRadius: BorderRadius.circular(20),
        color: fieldColor ?? ColorSys.kwhite,
      ),
      child: OutlinedButton(
        onPressed: radioFieldEvent,
        style: OutlinedButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(18),
            ),
          ),
          side: BorderSide(
              color: (groupValue == optionValue) ? Colors.green : Colors.black),
        ),
        child: Text(
          controllerName!.text,
          textAlign: TextAlign.left,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color:
                    (groupValue == optionValue) ? Colors.green : Colors.black,
              ),
        ),
      ),
    );
  }
}
