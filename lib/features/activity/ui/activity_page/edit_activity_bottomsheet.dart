import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:my_trip_it/features/activity/controller/activity_controller.dart';
import 'package:my_trip_it/features/activity/ui/activity_categories_dialog.dart';
import 'package:my_trip_it/models/ModelProvider.dart';

class EditActivityBottomSheet extends HookConsumerWidget {
  EditActivityBottomSheet({
    required this.activity,
    super.key,
  });

  final Activity activity;

  final formGlobalKey = GlobalKey<FormState>();

  Future<ActivityCategory> selectCategory(
      BuildContext context, WidgetRef ref, Activity activity) async {
    var value = await showDialog<ActivityCategory>(
        context: context,
        builder: (BuildContext context) {
          return const ActivityCategoriesDialog();
        });

    return value!;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activityNameController =
        useTextEditingController(text: activity.activityName);
    final activityDateController = useTextEditingController(
        text: DateFormat('yyyy-MM-dd')
            .format(activity.activityDate.getDateTime()));

    var activityTime =
        TimeOfDay.fromDateTime(activity.activityTime!.getDateTime());
    final activityTimeController =
        useTextEditingController(text: activity.category.name);

    final activityCategoryController = useTextEditingController(
        text:
            DateFormat('hh:mm a').format(activity.activityTime!.getDateTime()));

    return Form(
      key: formGlobalKey,
      child: Container(
        padding: EdgeInsets.only(
            top: 15,
            left: 15,
            right: 15,
            bottom: MediaQuery.of(context).viewInsets.bottom + 15),
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: activityNameController,
              keyboardType: TextInputType.name,
              validator: (value) {
                const validationError = 'Enter a valid activity name';
                if (value == null || value.isEmpty) {
                  return validationError;
                }

                return null;
              },
              autofocus: true,
              autocorrect: false,
              decoration: const InputDecoration(hintText: "Activity Name"),
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              keyboardType: TextInputType.name,
              controller: activityCategoryController,
              autofocus: true,
              autocorrect: false,
              decoration: const InputDecoration(hintText: "Activity Category"),
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value != null && value.isNotEmpty) {
                  return null;
                } else {
                  return 'Enter a valid category';
                }
              },
              onTap: () async {
                selectCategory(context, ref, activity).then(
                  (value) {
                    activityCategoryController.text = value.name;
                  },
                );
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: () {},
              child: const Text('Select'),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              keyboardType: TextInputType.datetime,
              controller: activityDateController,
              autofocus: true,
              autocorrect: false,
              decoration: const InputDecoration(hintText: "Activity Date"),
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value != null && value.isNotEmpty) {
                  return null;
                } else {
                  return 'Enter a valid date';
                }
              },
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101));

                if (pickedDate != null) {
                  String formattedDate =
                      DateFormat('yyyy-MM-dd').format(pickedDate);
                  activityDateController.text = formattedDate;
                } else {}
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: activityTimeController,
              decoration: const InputDecoration(hintText: "Activity Time"),
              validator: (value) {
                if (value != null && value.isNotEmpty) {
                  return null;
                } else {
                  return 'Enter a valid date';
                }
              },
              onTap: () async {
                await showTimePicker(
                  context: context,
                  initialTime: activityTime,
                  initialEntryMode: TimePickerEntryMode.dial,
                ).then((timeOfDay) {
                  if (timeOfDay != null) {
                    final localizations = MaterialLocalizations.of(context);
                    final formattedTimeOfDay =
                        localizations.formatTimeOfDay(timeOfDay);

                    activityTimeController.text = formattedTimeOfDay;
                    activityTime = timeOfDay;
                  }
                });
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
                child: const Text('OK'),
                onPressed: () async {
                  final currentState = formGlobalKey.currentState;
                  if (currentState == null) {
                    return;
                  }
                  if (currentState.validate()) {
                    final now = DateTime.now();
                    final time = DateTime(now.year, now.month, now.day,
                        activityTime.hour, activityTime.minute);
                    final format = DateFormat("HH:mm:ss.sss");

                    final updatedActivity = activity.copyWith(
                        category: ActivityCategory.values
                            .byName(activityCategoryController.text),
                        activityName: activityNameController.text,
                        activityDate: TemporalDate(
                            DateTime.parse(activityDateController.text)),
                        activityTime:
                            TemporalTime.fromString(format.format(time)));

                    ref.read(activityControllerProvider).edit(updatedActivity);

                    Navigator.of(context).pop();
                  }
                } //,
                ),
          ],
        ),
      ),
    );
  }
}
