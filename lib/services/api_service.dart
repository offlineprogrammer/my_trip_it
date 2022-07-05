import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../main.dart';
import '../models/ModelProvider.dart';

class APIService {
  Future<AsyncValue<List<Trip?>?>> getTrips() async {
    try {
      final request = ModelQueries.list(Trip.classType);
      final response = await Amplify.API.query(request: request).response;
      List<Trip?>? trips = response.data?.items;

      return AsyncData(trips);
    } on Exception catch (e) {
      _showError(e);
      return const AsyncError("Something went wrong");
    }
  }

  Future<void> updateTrip(Trip updatedTrip) async {
    try {
      final request = ModelMutations.update(updatedTrip);
      await Amplify.API.mutate(request: request).response;
    } on Exception catch (e) {
      _showError(e);
    }
  }

  Future<void> saveTrip(Trip expenseItem) async {
    try {
      final request = ModelMutations.create(expenseItem);
      final response = await Amplify.API.mutate(request: request).response;

      Trip? createdTrip = response.data;
      if (createdTrip == null) {
        print('errors: ' + response.errors.toString());
        return;
      }
      print('Mutation result: ' + createdTrip.tripName);
    } on Exception catch (e) {
      _showError(e);
    }
  }

  Future<void> deleteTrip(Trip trip) async {
    try {
      final request = ModelMutations.delete(trip);
      await Amplify.API.mutate(request: request).response;
    } on Exception catch (e) {
      _showError(e);
    }
  }

  void _showError(Exception e) {
    scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
      backgroundColor: Colors.red,
      content: Text(e.toString()),
    ));
  }
}
