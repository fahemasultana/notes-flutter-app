import 'dart:ui';

import 'package:flutter/material.dart';

showConfirmationDialog({
  required BuildContext context,
  required VoidCallback onYesPressed,
  VoidCallback? onNoPressed,
  String title = "",
  required String description,
}) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: title.isNotEmpty ? Text(title) : null,
          content: Text(description),
          actions: [
            TextButton(
                child: const Text("No"),
                onPressed: () {
                  Navigator.of(context).pop();
                  onNoPressed?.call();
                }),
            TextButton(
                child: const Text(
                  "Yes",
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () {
                  onYesPressed();
                }),
          ],
        );
      });
}
