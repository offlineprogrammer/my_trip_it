import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/ModelProvider.dart';
import '../services/api_service.dart';

class TripsProvider extends StateNotifier<List<Trip>> {
  final APIService _apiService = APIService();
  TripsProvider() : super(const <Trip>[]);

  Future<void> add(Trip trip) async {
    await _apiService.saveTrip(trip);

    state = [
      ...state,
      trip,
    ];
  }
}
