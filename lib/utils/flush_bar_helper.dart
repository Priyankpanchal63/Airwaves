import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FlushbarHelper {
  static void flushBarSuccessMessage(String message, BuildContext context) {
    Flushbar(
      forwardAnimationCurve: Curves.decelerate,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(15),
      message: message,
      duration: const Duration(seconds: 3),
      borderRadius: BorderRadius.circular(8),
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      backgroundColor: Colors.green,
      reverseAnimationCurve: Curves.elasticInOut,
      icon: const Icon(Icons.check_circle, size: 28, color: Colors.white),
      positionOffset: 20,
    ).show(context);
  }

  static void flushBarErrorMessage(String message, BuildContext context) {
    Flushbar(
      forwardAnimationCurve: Curves.decelerate,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(15),
      message: message,
      duration: const Duration(seconds: 3),
      borderRadius: BorderRadius.circular(8),
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      backgroundColor: Colors.red,
      reverseAnimationCurve: Curves.elasticInOut,
      icon: const Icon(Icons.error, size: 28, color: Colors.white),
      positionOffset: 20,
    ).show(context);
  }

  static void flushBarLoadingMessage(String message, BuildContext context) {
    Flushbar(
      forwardAnimationCurve: Curves.decelerate,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(15),
      message: message,
      duration: const Duration(seconds: 3),
      borderRadius: BorderRadius.circular(8),
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      backgroundColor: Colors.blue,
      reverseAnimationCurve: Curves.elasticInOut,
      icon: const CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      ),
      positionOffset: 20,
    ).show(context);
  }
}
