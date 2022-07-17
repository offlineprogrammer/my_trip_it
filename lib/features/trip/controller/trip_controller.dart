import 'dart:io';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_trip_it/common/storage_service.dart';

import '../../../models/ModelProvider.dart';
import '../data/trips_repository.dart';

class TripController {
  TripController(this.ref);
  final Ref ref;

  Future<String?> uploadFile(File file, String tripId) async {
    final fileKey = await ref.read(storageServiceProvider).uploadFile(file);
    if (fileKey != null) {
      final imageUrl =
          await ref.read(storageServiceProvider).getImageUrl(fileKey);
      final tripsRepository = ref.read(tripsRepositoryProvider);

      await tripsRepository.updateTripImage(tripId, fileKey, imageUrl);
      print('Uploaded');
    }
  }
}

final tripControllerProvider = Provider<TripController>((ref) {
  return TripController(ref);
});
