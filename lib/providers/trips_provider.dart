import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/ModelProvider.dart';
import '../services/api_service.dart';

class TripsProvider extends StateNotifier<AsyncValue<List<Trip?>?>> {
  final APIService _apiService;
  TripsProvider(this._apiService) : super(AsyncLoading()) {
    getAll();
  }

  Future<void> add(Trip trip) async {
    print(state.value.toString());
    state = const AsyncValue.loading();
    print(state.value.toString());
    await _apiService.saveTrip(trip);
    getAll();
    print(state.value.toString());
    state = const AsyncValue.loading();
    print(state.value.toString());
  }

  void getAll() async {
    state = const AsyncLoading();
    final _list = await _apiService.getTrips();

    state = _list;
  }
}
