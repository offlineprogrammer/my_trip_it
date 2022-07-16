import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../models/Trip.dart';
import '../services/trips_api_service.dart';

class TripsRepository {
  TripsRepository(this.tripsAPIService);

  final TripsAPIService tripsAPIService;

  Stream<List<Trip?>> getTrips() async* {
    try {
      final trips = await tripsAPIService.getTrips();
      yield trips;
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  Stream<Trip?> getTrip(String id) {
    return getTrips().map((trips) => _getTrip(trips, id));
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
  TripsAPIService tripsAPIService = ref.read(tripsAPIServiceProvider);
  return TripsRepository(tripsAPIService);
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
