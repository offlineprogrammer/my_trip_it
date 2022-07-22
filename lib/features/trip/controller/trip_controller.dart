import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_trip_it/common/service/storage_service.dart';

import 'package:my_trip_it/models/Trip.dart';
import 'package:my_trip_it/features/trip/data/trips_repository.dart';

class TripController {
  TripController(this.ref);
  final Ref ref;

  Future<void> uploadFile(File file, Trip trip) async {
    final fileKey = await ref.read(storageServiceProvider).uploadFile(file);
    if (fileKey != null) {
      final imageUrl =
          await ref.read(storageServiceProvider).getImageUrl(fileKey);
      final updatedTrip =
          trip.copyWith(tripImageKey: fileKey, tripImageUrl: imageUrl);
      await ref.read(tripsRepositoryProvider).update(updatedTrip);
      ref.read(storageServiceProvider).resetUploadProgress();
    }
  }

  ValueNotifier<double> uploadProgress() {
    return ref.read(storageServiceProvider).getUploadProgress();
  }

  Future<void> edit(Trip updatedTrip) async {
    final tripsRepository = ref.read(tripsRepositoryProvider);
    await tripsRepository.update(updatedTrip);
  }

  Future<void> delete(Trip deletedTrip) async {
    final tripsRepository = ref.read(tripsRepositoryProvider);
    await tripsRepository.delete(deletedTrip);
  }
}

final tripControllerProvider = Provider<TripController>((ref) {
  return TripController(ref);
});
