import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_trip_it/models/Trip.dart';

final tripsDataStoreServiceProvider = Provider<TripsDataStoreService>((ref) {
  final service = TripsDataStoreService();
  return service;
});

class TripsDataStoreService {
  Stream<List<Trip>> listenToTrips() {
    return Amplify.DataStore.observeQuery(
      Trip.classType,
      sortBy: [Trip.STARTDATE.ascending()],
    ).map((event) => event.items.toList()).handleError(
      (error) {
        debugPrint('Error in subscription stream: $error');
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
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> deleteTrip(Trip trip) async {
    try {
      await Amplify.DataStore.delete(trip);
    } on Exception catch (e) {
      debugPrint(e.toString());
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
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }
}
