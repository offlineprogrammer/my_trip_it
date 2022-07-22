import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:my_trip_it/models/Trip.dart';
import 'package:my_trip_it/features/trip/services/trips_datastore_service.dart';

class TripsRepository {
  TripsRepository(this.tripsDataStoreService);

  final TripsDataStoreService tripsDataStoreService;

  Stream<List<Trip>> getTrips() {
    return tripsDataStoreService.stream();
  }

  Future<void> add(Trip trip) async {
    await tripsDataStoreService.addTrip(trip);
  }

  Future<void> update(Trip updatedTrip) async {
    await tripsDataStoreService.updateTrip(updatedTrip);
  }

  Future<void> delete(Trip deletedTrip) async {
    await tripsDataStoreService.deleteTrip(deletedTrip);
  }

  Stream<Trip> get(String id) {
    return tripsDataStoreService.getTripStream(id);
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
  return tripsRepository.get(id);
});
