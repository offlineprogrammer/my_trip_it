import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../models/ModelProvider.dart';
import '../data/trips_repository.dart';

class TripsListController {
  TripsListController(this.ref);
  final Ref ref;

  Future<void> add(
      String name, String destination, String startDate, String endDate) async {
    Trip trip = Trip(
      tripName: name,
      destination: destination,
      startDate: TemporalDateTime(DateTime.parse(startDate)),
      endDate: TemporalDateTime(DateTime.parse(startDate)),
    );

    final tripsRepository = ref.read(tripsRepositoryProvider);

    await tripsRepository.add(trip);
  }
}

final tripsListControllerProvider = Provider<TripsListController>((ref) {
  return TripsListController(ref);
});
