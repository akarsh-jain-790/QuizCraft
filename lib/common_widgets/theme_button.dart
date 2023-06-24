import 'package:flutter/material.dart';

class ThemeButton extends StatelessWidget {
  const ThemeButton({super.key, required this.name, this.onPressed});

  final String name;
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
        backgroundColor:
            MaterialStatePropertyAll<Color>(Theme.of(context).primaryColor),
      ),
      child: Text(
        name,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).canvasColor, fontWeight: FontWeight.bold),
      ),
    );
  }
}
