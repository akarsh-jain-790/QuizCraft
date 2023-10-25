import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quiz_craft/firebase/quiz/controller/quiz_controller.dart';
import 'package:quiz_craft/helper/colors_sys.dart';
import 'package:quiz_craft/helper/strings.dart';

class BannerImagePicker extends ConsumerStatefulWidget {
  const BannerImagePicker({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BannerImagePickerState();
}

class _BannerImagePickerState extends ConsumerState<BannerImagePicker> {
  @override
  Widget build(BuildContext context) {
    ImagePicker picker = ImagePicker();
    XFile? image = ref.read(quizDataProvider)["banner"] != null
        ? XFile(ref.read(quizDataProvider)["banner"].path)
        : null;

    return GestureDetector(
      onTap: () async {
        image = await picker.pickImage(source: ImageSource.gallery);
        setState(() {});
        ref.read(quizDataProvider.notifier).state = {
          "banner": File(image!.path),
        };
      },
      child: Center(
        child: Container(
          height: 200.0,
          width: MediaQuery.sizeOf(context).width,
          decoration: BoxDecoration(
            color: ColorSys.ksecondary,
            borderRadius: const BorderRadius.all(Radius.circular(48)),
          ),
          child: image == null
              ? Center(
                  child: Text(
                    Strings.bannerText,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold, color: ColorSys.kprimary),
                    textAlign: TextAlign.left,
                  ),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: SizedBox.fromSize(
                    child: Image.file(File(image.path), fit: BoxFit.cover),
                  ),
                ),
        ),
      ),
    );
  }
}
