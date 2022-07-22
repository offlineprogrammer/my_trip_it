import 'package:flutter/material.dart';

class DeleteTrip extends StatelessWidget {
  const DeleteTrip({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Please Confirm'),
      content: const Text('Delete this trip?'),
      actions: [
        TextButton(
            onPressed: () async {
              Navigator.of(context).pop(true);
            },
            child: const Text('Yes')),
        TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text('No'))
      ],
    );
  }
}
