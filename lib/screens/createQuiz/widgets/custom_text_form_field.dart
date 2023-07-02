import 'package:flutter/material.dart';
import 'package:quiz_craft/helper/colors_sys.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      this.controllerName,
      required this.fieldName,
      this.textFieldEvent});

  final TextEditingController? controllerName;
  final void Function(dynamic)? textFieldEvent;
  final String fieldName;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250.0,
      decoration: BoxDecoration(
        border: Border.all(color: ColorSys.kgrey, width: 0.8),
        borderRadius: BorderRadius.circular(20),
        color: ColorSys.kwhite,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: TextField(
                controller: controllerName,
                onChanged: textFieldEvent,
                keyboardType: TextInputType.text,
                maxLines: null,
                expands: true,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: fieldName,
                )),
          ),
        ],
      ),
    );
  }
}
