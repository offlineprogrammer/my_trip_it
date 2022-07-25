import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_trip_it/features/activity/services/activities_datastore_service.dart';
import 'package:my_trip_it/models/Activity.dart';

class ActivitiesRepository {
  ActivitiesRepository(this.activitiesDataStoreService);

  final ActivitiesDataStoreService activitiesDataStoreService;

  Stream<List<Activity>> getActivities() {
    return activitiesDataStoreService.stream();
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

final activitiesRepositoryProvider = Provider<ActivitiesRepository>((ref) {
  ActivitiesDataStoreService activitiesDataStoreService =
      ref.read(activitiesDataStoreServiceProvider);
  return ActivitiesRepository(activitiesDataStoreService);
});

final activitiesListStreamProvider =
    StreamProvider.autoDispose<List<Activity?>>((ref) {
  final activitiesRepository = ref.watch(activitiesRepositoryProvider);
  return activitiesRepository.getActivities();
});
