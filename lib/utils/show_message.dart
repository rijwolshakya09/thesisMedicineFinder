import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';

void displaySuccessMessage(BuildContext context, String message) {
  MotionToast.success(
    enableAnimation: true,
    description: Text(message),
  ).show(context);
}

void displayErrorMessage(BuildContext context, String message) {
  MotionToast.error(
    enableAnimation: true,
    description: Text(message),
  ).show(context);
}
