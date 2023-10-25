import 'package:flutter/material.dart';

class FilledRadio<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final ValueChanged<T> onChanged;
  final double radius;
  final Color color;

  const FilledRadio({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.radius,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          onChanged(this.value);
        },
        child: Container(
          height: this.radius * 2,
          width: this.radius * 2,
          decoration: ShapeDecoration(
            shape: const CircleBorder(),
            color: color,
          ),
          child: Center(
            child: Container(
              height: (this.radius * 2) - 4,
              width: (this.radius * 2) - 4,
              decoration: ShapeDecoration(
                shape: const CircleBorder(),
                color:
                    value == groupValue ? color : Theme.of(context).canvasColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
