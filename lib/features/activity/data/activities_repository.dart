import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_trip_it/features/activity/services/activities_datastore_service.dart';
import 'package:my_trip_it/models/ModelProvider.dart';

final activitiesRepositoryProvider = Provider<ActivitiesRepository>((ref) {
  ActivitiesDataStoreService activitiesDataStoreService =
      ref.read(activitiesDataStoreServiceProvider);
  return ActivitiesRepository(activitiesDataStoreService);
});

final activitiesListStreamProvider =
    StreamProvider.autoDispose.family<List<Activity?>, Trip>((ref, trip) {
  final activitiesRepository = ref.watch(activitiesRepositoryProvider);
  return activitiesRepository.getActivities(trip.id);
});

class ActivitiesRepository {
  ActivitiesRepository(
    this.activitiesDataStoreService,
  );

  final ActivitiesDataStoreService activitiesDataStoreService;

  Stream<List<Activity>> getActivities(String tripId) {
    return activitiesDataStoreService.listenToActivites(tripId);
  }

  Stream<Activity> listenToActivity(String id) {
    return activitiesDataStoreService.listenToActivity(id);
  }

  Future<Activity> getActivity(String id) {
    return activitiesDataStoreService.getActivity(id);
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
