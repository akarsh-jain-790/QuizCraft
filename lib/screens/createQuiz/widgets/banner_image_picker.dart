import 'package:flutter/material.dart';
import 'package:quiz_craft/helper/colors_sys.dart';
import 'package:quiz_craft/helper/strings.dart';

class BannerImagePicker extends StatelessWidget {
  const BannerImagePicker({super.key});
  final String image = "";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 200.0,
        width: MediaQuery.sizeOf(context).width,
        padding: const EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          color: ColorSys.ksecondary,
          borderRadius: const BorderRadius.all(Radius.circular(48)),
        ),
        child: image == ""
            ? Center(
                child: Text(
                  Strings.bannerText,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold, color: ColorSys.kprimary),
                  textAlign: TextAlign.left,
                ),
              )
            : Image.asset("assets/images/profile.png"),
      ),
    );
  }
}
