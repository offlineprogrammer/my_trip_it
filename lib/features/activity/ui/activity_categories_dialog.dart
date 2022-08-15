import 'package:flutter/material.dart';
import 'package:my_trip_it/models/ModelProvider.dart';

class ActivityCategoriesDialog extends StatefulWidget {
  const ActivityCategoriesDialog({
    super.key,
  });

  @override
  State<ActivityCategoriesDialog> createState() =>
      _ActivityCategoriesDialogState();
}

class _ActivityCategoriesDialogState extends State<ActivityCategoriesDialog> {
  ActivityCategory activityCategory = ActivityCategory.Flight;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Please select a category'),
      content: Column(
        //padding: const EdgeInsets.all(10),
        children: ActivityCategory.values
            .map((category) => RadioListTile<ActivityCategory>(
                  groupValue: activityCategory,
                  title: Text(category.name),
                  value: category,
                  onChanged: (value) {
                    setState(() {
                      activityCategory = value!;
                    });
                  },
                ))
            .toList(),
      ),
      actions: [
        TextButton(
            onPressed: () async {
              Navigator.of(context).pop(activityCategory);
            },
            child: const Text('Yes')),
      ],
    );
  }
}
