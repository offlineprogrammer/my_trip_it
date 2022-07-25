import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_trip_it/features/activity/services/activities_datastore_service.dart';
import 'package:my_trip_it/models/ModelProvider.dart';

class ActivitiesRepository {
  ActivitiesRepository(this.activitiesDataStoreService, this.trip);

  final Trip trip;

  final ActivitiesDataStoreService activitiesDataStoreService;

  Stream<List<Activity>> getActivities() {
    return activitiesDataStoreService.listenToActivites();
  }

  Future<void> add(Activity activity) async {
    await activitiesDataStoreService.addActivity(activity);
  }

  Future<void> update(Activity updatedActivity) async {
    await activitiesDataStoreService.updateActivity(updatedActivity);
  }

  Future<void> delete(Activity activity) async {
    await activitiesDataStoreService.deleteActivity(activity);
  }
}

final activitiesRepositoryProvider =
    Provider.family<ActivitiesRepository, Trip>((ref, trip) {
  ActivitiesDataStoreService activitiesDataStoreService =
      ref.read(activitiesDataStoreServiceProvider(trip));
  return ActivitiesRepository(activitiesDataStoreService, trip);
});

final activitiesListStreamProvider =
    StreamProvider.autoDispose.family<List<Activity?>, Trip>((ref, trip) {
  final activitiesRepository = ref.watch(activitiesRepositoryProvider(trip));
  return activitiesRepository.getActivities();
});
