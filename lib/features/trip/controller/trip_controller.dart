import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_trip_it/common/storage_service.dart';

import '../../../models/Trip.dart';
import '../data/trips_repository.dart';

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
      await ref.read(tripsRepositoryProvider).updateTrip(updatedTrip);
    }
  }

  Future<void> edit(Trip updatedTrip) async {
    final tripsRepository = ref.read(tripsRepositoryProvider);
    await tripsRepository.updateTrip(updatedTrip);
  }
}

final tripControllerProvider = Provider<TripController>((ref) {
  return TripController(ref);
});
