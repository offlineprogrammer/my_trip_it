import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../controller/trips_list_controller.dart';

class AddTrip extends HookConsumerWidget {
  AddTrip({Key? key}) : super(key: key);

  final formGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tripNameController = useTextEditingController();
    final destinationController = useTextEditingController();
    final startDateController = useTextEditingController();
    final endDateController = useTextEditingController();
    final descriptionController = useTextEditingController();

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
              controller: tripNameController,
              keyboardType: TextInputType.name,
              validator: (value) {
                const validationError = 'Enter a valid trip name';
                if (value == null || value.isEmpty) {
                  return validationError;
                }

                return null;
              },
              autofocus: true,
              autocorrect: false,
              decoration: const InputDecoration(hintText: "Trip Name"),
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(
              height: 20.0,
            ),
            TextFormField(
              keyboardType: TextInputType.name,
              controller: destinationController,
              autofocus: true,
              autocorrect: false,
              decoration: const InputDecoration(hintText: "Trip Destination"),
              textInputAction: TextInputAction.next,
              validator: (name) {
                if (name != null && name.isNotEmpty) {
                  return null;
                } else {
                  return 'Enter a valid expense name';
                }
              },
            ),
            TextFormField(
              keyboardType: TextInputType.datetime,
              controller: startDateController,
              autofocus: true,
              autocorrect: false,
              decoration: const InputDecoration(hintText: "Start Date"),
              textInputAction: TextInputAction.next,
              validator: (name) {
                if (name != null && name.isNotEmpty) {
                  return null;
                } else {
                  return 'Enter a valid expense name';
                }
              },
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(
                        2000), //DateTime.now() - not to allow to choose before today.
                    lastDate: DateTime(2101));

                if (pickedDate != null) {
                  String formattedDate =
                      DateFormat('yyyy-MM-dd').format(pickedDate);
                  startDateController.text = formattedDate;
                } else {
                  print("Date is not selected");
                }
              },
            ),
            TextFormField(
              keyboardType: TextInputType.datetime,
              controller: endDateController,
              autofocus: true,
              autocorrect: false,
              decoration: const InputDecoration(hintText: "End Date"),
              textInputAction: TextInputAction.next,
              validator: (name) {
                if (name != null && name.isNotEmpty) {
                  return null;
                } else {
                  return 'Enter a valid expense name';
                }
              },
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(
                        2000), //DateTime.now() - not to allow to choose before today.
                    lastDate: DateTime(2101));

                if (pickedDate != null) {
                  print(
                      pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                  String formattedDate = //pickedDate.toIso8601String();
                      DateFormat('yyyy-MM-dd').format(pickedDate);

                  endDateController.text = formattedDate;

                  print(
                      formattedDate); //formatted date output using intl package =>  2021-03-16
                  //you can implement different kind of Date Format here according to your requirement

                } else {
                  print("Date is not selected");
                }
              },
            ),
            TextFormField(
              controller: descriptionController,
              autofocus: true,
              autocorrect: false,
              decoration: const InputDecoration(hintText: "Description"),
              textInputAction: TextInputAction.done,
              validator: (name) {
                if (name != null && name.isNotEmpty) {
                  return null;
                } else {
                  return 'Enter a valid expense name';
                }
              },
            ),
            const SizedBox(
              height: 20.0,
            ),
            TextButton(
                child: const Text('OK'),
                onPressed: () async {
                  final currentState = formGlobalKey.currentState;
                  if (currentState == null) {
                    return;
                  }
                  if (currentState.validate()) {
                    ref.read(tripsListControllerProvider).add(
                        tripNameController.text,
                        destinationController.text,
                        startDateController.text,
                        endDateController.text);
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
