import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_trip_it/common/service/storage_service.dart';
import 'package:my_trip_it/features/activity/data/activities_repository.dart';
import 'package:my_trip_it/models/ModelProvider.dart';

class ActivityController {
  ActivityController(this.ref);
  final Ref ref;

  Future<void> uploadFile(File file, Activity activity) async {
    final fileKey = await ref.read(storageServiceProvider).uploadFile(file);
    if (fileKey != null) {
      final imageUrl =
          await ref.read(storageServiceProvider).getImageUrl(fileKey);
      final updatedActivity = activity.copyWith(
          activityImageKey: fileKey, activityImageUrl: imageUrl);
      await ref.read(activitiesRepositoryProvider).update(updatedActivity);
      ref.read(storageServiceProvider).resetUploadProgress();
    }
  }

  Future<String> getFileUrl(Activity activity) async {
    final fileKey = activity.activityImageKey;

    return await ref.read(storageServiceProvider).getImageUrl(fileKey!);
  }

  Future<Activity> getActivity(String id) {
    return ref.read(activitiesRepositoryProvider).getActivity(id);
  }

  Stream<Activity> listenToActivity(String activityId) {
    return ref.read(activitiesRepositoryProvider).listenToActivity(activityId);
  }

  ValueNotifier<double> uploadProgress() {
    return ref.read(storageServiceProvider).getUploadProgress();
  }

  Future<void> edit(Activity updatedActivity) async {
    await ref.read(activitiesRepositoryProvider).update(updatedActivity);
  }

  Future<void> delete(Activity deletedActivity) async {
    await ref.read(activitiesRepositoryProvider).delete(deletedActivity);
  }
}

final activityControllerProvider = Provider<ActivityController>((ref) {
  return ActivityController(ref);
});

final activityProvider =
    StreamProvider.autoDispose.family<Activity, String>((ref, activityId) {
  final activityProvider = ref.watch(activityControllerProvider);
  return activityProvider.listenToActivity(activityId);
});
