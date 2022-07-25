import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_trip_it/features/activity/data/activities_repository.dart';
import 'package:my_trip_it/models/ModelProvider.dart';

class ActivitiesListController {
  ActivitiesListController(this.ref, this.trip);
  final Ref ref;
  final Trip trip;

  Future<void> add(String name, String activityDate, Trip trip) async {
    Activity activity = Activity(
      activityName: name,
      activityDate: TemporalDateTime(DateTime.parse(activityDate)),
      trip: trip,
    );

    final activitesRepository = ref.read(activitiesRepositoryProvider(trip));

    await activitesRepository.add(activity);
  }
}

final activitiesListController =
    Provider.family<ActivitiesListController, Trip>((ref, trip) {
  return ActivitiesListController(ref, trip);
});
