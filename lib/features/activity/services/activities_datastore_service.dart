import 'package:amplify_flutter/amplify_flutter.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_trip_it/common/exceptions/error_logger.dart';

import 'package:my_trip_it/models/ModelProvider.dart';

final activitiesDataStoreServiceProvider =
    Provider<ActivitiesDataStoreService>((ref) {
  final service = ActivitiesDataStoreService(ref: ref);
  return service;
});

class ActivitiesDataStoreService {
  ActivitiesDataStoreService({
    required Ref ref,
  }) : errorLogger = ref.read(errorLoggerProvider);

  final ErrorLogger errorLogger;

  Stream<List<Activity>> listenToActivites(String tripId) {
    return Amplify.DataStore.observeQuery(
      Activity.classType,
      //where: Activity.TRIP.eq(trip.id), // DataStore bug??
      sortBy: [
        Activity.ACTIVITYDATE.ascending(),
        Activity.ACTIVITYTIME.ascending()
      ],
    )
        .map((event) =>
            event.items.where((element) => element.trip.id == tripId).toList())
        .handleError(
      (dynamic error) {
        errorLogger.logError(error);
        throw Exception('A Stream error happened');
      },
    );
  }

  Stream<Activity> listenToActivity(String id) {
    return Amplify.DataStore.observeQuery(
      Activity.classType,
      //where: Activity.TRIP.eq(trip.id), // DataStore bug??
      sortBy: [Activity.ACTIVITYDATE.ascending()],
    )
        .map((event) => event.items.where((element) => element.id == id).first)
        .handleError(
      (dynamic error) {
        errorLogger.logError(error);
      },
    );
  }

  Future<Activity> getActivity(String id) async {
    final activitiesWithId = await Amplify.DataStore.query(
      Activity.classType,
      where: Activity.ID.eq(id),
    );

    return activitiesWithId.first;
  }

  Future<void> addActivity(Activity activity) async {
    try {
      await Amplify.DataStore.save(activity);
    } on Exception catch (error) {
      errorLogger.logError(error);
    }
  }

  Future<void> deleteActivity(Activity activity) async {
    try {
      await Amplify.DataStore.delete(activity);
    } on Exception catch (error) {
      errorLogger.logError(error);
    }
  }

  Future<void> updateActivity(Activity updatedActivity) async {
    try {
      final activitiesWithId = await Amplify.DataStore.query(
        Activity.classType,
        where: Activity.ID.eq(updatedActivity.id),
      );

      final oldActivity = activitiesWithId.first;
      final newActivity = oldActivity.copyWith(
          id: oldActivity.id,
          activityName: updatedActivity.activityName,
          activityDate: updatedActivity.activityDate,
          category: updatedActivity.category,
          activityTime: updatedActivity.activityTime,
          activityImageKey: updatedActivity.activityImageKey,
          activityImageUrl: updatedActivity.activityImageUrl);

      await Amplify.DataStore.save(newActivity);
    } on Exception catch (error) {
      errorLogger.logError(error);
    }
  }
}
