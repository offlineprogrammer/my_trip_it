import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../models/Trip.dart';
import '../services/trips_api_service.dart';
import '../services/trips_datastore_service.dart';

class TripsRepository {
  TripsRepository(this.tripsDataStoreService);

  final TripsDataStoreService tripsDataStoreService;

  Stream<List<Trip>> getTrips() {
    print('stream');
    return tripsDataStoreService.stream();
  }

  Future<void> add(Trip trip) async {
    await tripsDataStoreService.addTrip(trip);
  }

  // Future<void> updateTripImage(
  //     String id, String imageKey, String imageUrl) async {
  //   final trips = await tripsDataStoreService.getTrips();

  //   final trip = _getTrip(trips, id);
  //   if (trip != null) {
  //     final updatedTrip =
  //         trip.copyWith(tripImageUrl: imageUrl, tripImageKey: imageKey);
  //     await tripsDataStoreService.updateTrip(updatedTrip);
  //   }
  // }

  Future<void> updateTrip(Trip updatedTrip) async {
    await tripsDataStoreService.updateTrip(updatedTrip);
  }

  Stream<Trip> getTrip(String id) {
    return tripsDataStoreService.getTripStream(id);
  }

  static Trip? _getTrip(List<Trip?> trips, String id) {
    try {
      return trips.firstWhere((trip) => trip!.id == id);
    } catch (e) {
      return null;
    }
  }
}

final tripsRepositoryProvider = Provider<TripsRepository>((ref) {
  TripsDataStoreService tripsDataStoreService =
      ref.read(tripsDataStoreServiceProvider);
  return TripsRepository(tripsDataStoreService);
});

final tripsListStreamProvider = StreamProvider.autoDispose<List<Trip?>>((ref) {
  final tripsRepository = ref.watch(tripsRepositoryProvider);
  return tripsRepository.getTrips();
});

final tripProvider =
    StreamProvider.autoDispose.family<Trip?, String>((ref, id) {
  final tripsRepository = ref.watch(tripsRepositoryProvider);
  return tripsRepository.getTrip(id);
});
