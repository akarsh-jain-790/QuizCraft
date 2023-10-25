import 'package:flutter/material.dart';
import 'package:quiz_craft/helper/colors_sys.dart';

class ThemeButton extends StatelessWidget {
  const ThemeButton(
      {super.key,
      required this.name,
      this.onPressed,
      this.buttonColor,
      this.textColor});

  final String name;
  final Color? buttonColor;
  final Color? textColor;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0))),
        minimumSize: const MaterialStatePropertyAll(Size.fromHeight(40)),
        padding: const MaterialStatePropertyAll(EdgeInsets.all(16.0)),
        overlayColor: const MaterialStatePropertyAll<Color>(
          Colors.blue,
        ),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return ColorSys.kgrey;
            } else {
              return buttonColor ?? Theme.of(context).primaryColor;
            }
          },
        ),
      ),
      child: Text(
        name,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: textColor ?? Theme.of(context).canvasColor,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
