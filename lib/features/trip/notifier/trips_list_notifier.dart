import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/Trip.dart';

class TripsListNotifier extends StateNotifier<List<Trip>> {
  TripsListNotifier([List<Trip>? TripsList]) : super(TripsList ?? []);

  void add(Trip trip) {
    state = [
      ...state,
      trip,
    ];
  }

  void delete(Trip tripToDelete) {
    state = state.where((trip) => trip.id != tripToDelete.id).toList();
  }
}
