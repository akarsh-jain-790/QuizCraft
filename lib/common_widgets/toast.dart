import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';

void showToast(
    BuildContext context, String message, String description, String type) {
  if (type == "success") {
    return MotionToast.success(
      title: Text(message),
      description: Text(description),
    ).show(context);
  } else if (type == "error") {
    return MotionToast.error(
      title: Text(message),
      description: Text(description),
    ).show(context);
  } else if (type == "warning") {
    return MotionToast.warning(
      title: Text(message),
      description: Text(description),
    ).show(context);
  } else if (type == "info") {
    return MotionToast.info(
      title: Text(message),
      description: Text(description),
    ).show(context);
  } else if (type == "delete") {
    return MotionToast.delete(
      title: Text(message),
      description: Text(description),
    ).show(context);
  }
}
