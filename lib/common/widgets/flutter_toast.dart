import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void toastInfo({
  required BuildContext context,
  required String msg,
  Color? backgroundColor,
  Color? textColor,
}) {
  if (Platform.isWindows) {
    final theme = Theme.of(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          msg,
          style: TextStyle(
            color: textColor ?? theme.colorScheme.onPrimary,
            fontSize: 16,
          ),
        ),
        backgroundColor:
            backgroundColor ?? theme.colorScheme.primary.withOpacity(0.9),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  } else {
    final theme = Theme.of(context);

    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 2,
      backgroundColor:
          backgroundColor ?? theme.colorScheme.primary.withOpacity(0.9),
      textColor: textColor ?? theme.colorScheme.onPrimary,
      fontSize: 16,
      webShowClose: true,
      webBgColor:
          "linear-gradient(to right, ${theme.colorScheme.primary.withOpacity(0.9).toHex()}, ${theme.colorScheme.secondary.withOpacity(0.9).toHex()})",
      webPosition: "center",
    );
  }
}

// Estensione per convertire Color in formato esadecimale
extension ColorExtension on Color {
  String toHex() => '#${(value & 0xFFFFFF).toRadixString(16).padLeft(6, '0')}';
}
