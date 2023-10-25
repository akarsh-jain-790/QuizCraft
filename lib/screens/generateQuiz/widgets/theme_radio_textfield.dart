import 'package:flutter/material.dart';
import 'package:quiz_craft/helper/colors_sys.dart';
import 'package:quiz_craft/screens/generateQuiz/widgets/filled_radio.dart';

class ThemeRadioTextField extends StatelessWidget {
  const ThemeRadioTextField(
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
      this.passwordField = false});

  final TextEditingController? controllerName;
  final void Function(dynamic)? textFieldEvent;
  final void Function(String) radioFieldEvent;
  final String fieldName;
  final String groupValue;
  final String optionValue;
  final bool passwordField;
  final Color? fieldColor;
  final IconData icon;
  final bool? border;

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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 12,
          ),
          FilledRadio(
            color: Theme.of(context).primaryColor,
            groupValue: groupValue,
            onChanged: radioFieldEvent,
            radius: 10,
            value: optionValue,
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: TextField(
              controller: controllerName,
              onChanged: textFieldEvent,
              keyboardType: TextInputType.text,
              obscureText: passwordField,
              enableSuggestions: !passwordField,
              autocorrect: !passwordField,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: fieldName,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
