import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:my_trip_it/features/activity/controller/activities_list_controller.dart';
import 'package:my_trip_it/models/ModelProvider.dart';

class AddActivity extends ConsumerWidget {
  AddActivity(this.trip, {Key? key}) : super(key: key);

  final Trip trip;

  final formGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activityNameController = TextEditingController();
    final activityDateController = TextEditingController();
    var activityCategory = ActivityCategory.Flight;

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
              height: 20.0,
            ),
            DropdownButtonFormField<ActivityCategory>(
              onChanged: (value) {
                activityCategory = value!;
              },

              value: activityCategory,

              // autovalidateMode: AutovalidateMode.onUserInteraction,
              // validator: createGenericValidator<Category>('Category'),
              decoration: const InputDecoration(
                labelText: 'Category',
              ),
              items: [
                for (var category in ActivityCategory.values)
                  DropdownMenuItem(
                    value: category,
                    child: Text(category.name),
                  ),
              ],
            ),
            const SizedBox(
              height: 20.0,
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
            TextButton(
                child: const Text('OK'),
                onPressed: () async {
                  final currentState = formGlobalKey.currentState;
                  if (currentState == null) {
                    return;
                  }
                  if (currentState.validate()) {
                    ref.read(activitiesListController(trip)).add(
                        activityNameController.text,
                        activityDateController.text,
                        activityCategory,
                        trip);
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
