import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SocialButton extends StatelessWidget {
  const SocialButton(
      {super.key,
      required this.name,
      this.onPressed,
      required this.color,
      required this.logo,
      this.logoColor = false});

  final String name;
  final Color color;
  final bool? logoColor;
  final String logo;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ButtonStyle(
        shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0))),
        minimumSize: const MaterialStatePropertyAll(Size.fromHeight(40)),
        padding: const MaterialStatePropertyAll(EdgeInsets.all(16.0)),
        backgroundColor: MaterialStatePropertyAll<Color>(color),
      ),
      label: Text(
        name,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: logoColor == true
                ? Theme.of(context).canvasColor
                : Theme.of(context).textTheme.bodyMedium?.color,
            fontWeight: FontWeight.bold),
      ),
      icon: Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: SvgPicture.asset(
          logo,
          colorFilter: logoColor == true
              ? const ColorFilter.mode(Colors.white, BlendMode.srcIn)
              : null,
          height: 30,
        ),
      ),
    );
  }
}
