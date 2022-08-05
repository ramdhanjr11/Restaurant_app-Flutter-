import 'package:flutter/material.dart';

Future<dynamic> buildComingSoonDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Information'),
      content: const Text('Coming soon feature'),
      actions: [
        OutlinedButton(
          child: const Text('Ok'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    ),
  );
}
