import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../models/ModelProvider.dart';

class ActivitiesDataStoreService {
  Stream<List<Activity>> stream() {
    //more desprictive e.g. listentotrips
    return Amplify.DataStore.observeQuery(
      Activity.classType,
      sortBy: [Activity.ACTIVITYDATE.ascending()],
    ).map((event) => event.items.toList()).handleError(
      (dynamic error) {
        debugPrint('Error in subscription stream: $error');
      },
    );
  }

  Future<void> addActivity(Activity activity) async {
    try {
      await Amplify.DataStore.save(activity);
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> deleteActivity(Activity activity) async {
    try {
      await Amplify.DataStore.delete(activity);
    } on Exception catch (e) {
      debugPrint(e.toString());
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
      );

      await Amplify.DataStore.save(newActivity);
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }
}

final activitiesDataStoreServiceProvider =
    Provider<ActivitiesDataStoreService>((ref) {
  final service = ActivitiesDataStoreService();
  return service;
});
