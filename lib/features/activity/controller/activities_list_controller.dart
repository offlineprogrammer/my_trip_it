import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_trip_it/features/activity/data/activities_repository.dart';
import 'package:my_trip_it/models/ModelProvider.dart';

class ActivitiesListController {
  ActivitiesListController(this.ref);
  final Ref ref;

  Future<void> add(String name, String activityDate, Trip trip) async {
    Activity activity = Activity(
      activityName: name,
      activityDate: TemporalDateTime(DateTime.parse(activityDate)),
      trip: trip,
    );

    final activitesRepository = ref.read(activitiesRepositoryProvider);

    await activitesRepository.add(activity);
  }
}

final activitiesListController = Provider<ActivitiesListController>((ref) {
  return ActivitiesListController(ref);
});
