import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../models/Trip.dart';

class TripsAPIService {
  Future<List<Trip?>> getTrips() async {
    try {
      final request = ModelQueries.list(Trip.classType);
      final response = await Amplify.API.query(request: request).response;
      final trips = response.data?.items;
      if (trips == null) {
        debugPrint('errors: ${response.errors}');
        return <Trip>[];
      }
      return trips;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return <Trip>[];
    }
  }
}

final tripsAPIServiceProvider =
    Provider<TripsAPIService>((ref) => TripsAPIService());
