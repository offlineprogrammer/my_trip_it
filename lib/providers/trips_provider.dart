import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/ModelProvider.dart';
import '../services/api_service.dart';

class TripsProvider extends StateNotifier<AsyncValue<List<Trip?>?>> {
  final APIService _apiService;
  TripsProvider(this._apiService) : super(const AsyncLoading()) {
    getAll();
  }

  Future<void> add(Trip trip) async {
    state = const AsyncValue.loading();

    await _apiService.saveTrip(trip);
    getAll();
  }

  void getAll() async {
    state = const AsyncLoading();
    final list = await _apiService.getTrips();

    state = list;
  }

  Future<AsyncValue<Trip?>> get(String id) async {
    state = const AsyncValue.loading();

    return await _apiService.getTrip(id);
  }

  Future<void> update(Trip updatedTrip) async {
    await _apiService.updateTrip(updatedTrip);
    getAll();
  }
}
