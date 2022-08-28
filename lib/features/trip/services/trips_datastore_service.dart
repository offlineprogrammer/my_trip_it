import 'package:amplify_flutter/amplify_flutter.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_trip_it/common/exceptions/error_logger.dart';

import 'package:my_trip_it/models/Trip.dart';

final tripsDataStoreServiceProvider = Provider<TripsDataStoreService>((ref) {
  final service = TripsDataStoreService(ref: ref);
  return service;
});

class TripsDataStoreService {
  TripsDataStoreService({
    required Ref ref,
  }) : errorLogger = ref.read(errorLoggerProvider);

  final ErrorLogger errorLogger;

  Stream<List<Trip>> listenToTrips() {
    return Amplify.DataStore.observeQuery(
      Trip.classType,
      sortBy: [Trip.STARTDATE.ascending()],
    )
        .map((event) => event.items
            .where((element) =>
                element.endDate.getDateTime().isAfter(DateTime.now()))
            .toList())
        .handleError(
      (error) {
        errorLogger.logError(error);
        throw Exception('A Stream error happened');
      },
    );
  }

  Stream<List<Trip>> listenToPastTrips() {
    return Amplify.DataStore.observeQuery(
      Trip.classType,
      sortBy: [Trip.STARTDATE.ascending()],
    )
        .map((event) => event.items
            .where((element) =>
                element.endDate.getDateTime().isBefore(DateTime.now()))
            .toList())
        .handleError(
      (error) {
        errorLogger.logError(error);
      },
    );
  }

  Stream<Trip> getTripStream(String id) {
    final tripStream =
        Amplify.DataStore.observeQuery(Trip.classType, where: Trip.ID.eq(id))
            .map((event) => event.items.toList().single);

    return tripStream;
  }

  Future<void> addTrip(Trip trip) async {
    try {
      await Amplify.DataStore.save(trip);
    } on Exception catch (error) {
      errorLogger.logError(error);
    }
  }

  Future<void> deleteTrip(Trip trip) async {
    try {
      await Amplify.DataStore.delete(trip);
    } on Exception catch (error) {
      errorLogger.logError(error);
    }
  }

  Future<void> updateTrip(Trip updatedTrip) async {
    try {
      final tripsWithId = await Amplify.DataStore.query(
        Trip.classType,
        where: Trip.ID.eq(updatedTrip.id),
      );

      final oldTrip = tripsWithId.first;
      final newTrip = oldTrip.copyWith(
          id: oldTrip.id,
          tripName: updatedTrip.tripName,
          destination: updatedTrip.destination,
          startDate: updatedTrip.startDate,
          endDate: updatedTrip.endDate,
          tripImageKey: updatedTrip.tripImageKey,
          tripImageUrl: updatedTrip.tripImageUrl,
          Activities: updatedTrip.Activities);

      await Amplify.DataStore.save(newTrip);
    } on Exception catch (error) {
      errorLogger.logError(error);
    }
  }
}
