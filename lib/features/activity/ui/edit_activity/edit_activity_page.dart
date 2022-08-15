import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:my_trip_it/common/navigation/router/routes.dart';
import 'package:my_trip_it/features/activity/controller/activity_controller.dart';
import 'package:my_trip_it/models/ActivityCategory.dart';
import 'package:my_trip_it/common/utils/colors.dart' as constants;
import 'package:my_trip_it/models/ModelProvider.dart';

class EditActivityPage extends HookConsumerWidget {
  EditActivityPage({
    required this.activityId,
    super.key,
  });

  final String activityId;

  final formGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activityNameController = useTextEditingController();
    final activityDateController = useTextEditingController();
    final activityTimeController = useTextEditingController();
    var activityCategory = ActivityCategory.Flight;
    var activityTime = TimeOfDay.now();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Amplify TripIT',
        ),
        leading: IconButton(
          onPressed: () {
            context.goNamed(
              AppRoute.activity.name,
              params: {'id': activityId},
            );
          },
          icon: const Icon(Icons.arrow_back),
        ),
        backgroundColor: const Color(constants.primaryColorDark),
      ),
      body: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          final activityValue = ref.watch(activityFutureProvider(activityId));

          return activityValue.when(
            data: (activity) {
              activityNameController.text = activity.activityName;
              activityDateController.text = DateFormat('yyyy-MM-dd')
                  .format(activity.activityDate.getDateTime());
              activityTimeController.text = DateFormat('hh:mm a')
                  .format(activity.activityTime!.getDateTime());
              activityCategory = activity.category;
              return SingleChildScrollView(
                  child: Form(
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
                        decoration:
                            const InputDecoration(hintText: "Activity Name"),
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      DropdownButtonFormField<ActivityCategory>(
                        onChanged: (value) {
                          activityCategory = value!;
                        },
                        value: activityCategory,
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
                        height: 20,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.datetime,
                        controller: activityDateController,
                        autofocus: true,
                        autocorrect: false,
                        decoration:
                            const InputDecoration(hintText: "Activity Date"),
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
                        decoration:
                            const InputDecoration(hintText: "Activity Time"),
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
                              final localizations =
                                  MaterialLocalizations.of(context);
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
                              final time = DateTime(
                                  now.year,
                                  now.month,
                                  now.day,
                                  activityTime.hour,
                                  activityTime.minute);
                              final format = DateFormat("HH:mm:ss.sss");

                              final updatedActivity = activity.copyWith(
                                  category: activityCategory,
                                  activityName: activityNameController.text,
                                  activityDate: TemporalDate(DateTime.parse(
                                      activityDateController.text)),
                                  activityTime: TemporalTime.fromString(
                                      format.format(time)));

                              ref
                                  .read(activityControllerProvider)
                                  .edit(updatedActivity);

                              context.goNamed(
                                AppRoute.activity.name,
                                params: {'id': activityId},
                              );
                            }
                          } //,
                          ),
                    ],
                  ),
                ),
              ));
            },
            error: (e, st) => const Center(
              child: Text('Error'),
            ),
            loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          );
        },
      ),
    );
  }
}
