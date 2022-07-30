import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:my_trip_it/features/activity/data/activities_repository.dart';
import 'package:my_trip_it/models/ModelProvider.dart';

class ActivitiesListController {
  ActivitiesListController(
    this.ref,
    this.trip,
  );
  final Ref ref;
  final Trip trip;

  Future<void> add(String name, String activityDate, TimeOfDay activityTime,
      ActivityCategory category, Trip trip) async {
    final now = DateTime.now();
    final time = DateTime(
        now.year, now.month, now.day, activityTime.hour, activityTime.minute);
    final format = DateFormat("HH:mm:ss.sss");

    Activity activity = Activity(
      activityName: name,
      activityDate: TemporalDate(DateTime.parse(activityDate)),
      activityTime: TemporalTime.fromString(format.format(time)),
      trip: trip,
      category: category,
    );

    final activitesRepository = ref.read(activitiesRepositoryProvider);

    await activitesRepository.add(activity);
  }
}

final activitiesListController =
    Provider.family<ActivitiesListController, Trip>((ref, trip) {
  return ActivitiesListController(ref, trip);
});
