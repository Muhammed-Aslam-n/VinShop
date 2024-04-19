import 'package:flutter/material.dart';

/// Custom popup widget to use for appropriate scenarios

showSimpleAlertPopup(
    BuildContext context,
    message,
    ) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (builder) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        content: Text(message),
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Got it',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      );
    },
  );
}