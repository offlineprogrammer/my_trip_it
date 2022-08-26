import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_trip_it/common/exceptions/app_exception.dart';
import 'package:my_trip_it/common/utils/logger.dart';
import 'package:my_trip_it/models/ModelProvider.dart';

final profileDataStoreServiceProvider =
    Provider<ProfileDatastoreService>((ref) {
  final service = ProfileDatastoreService();
  return service;
});

class ProfileDatastoreService {
  ProfileDatastoreService();

  Stream<Profile> listenToProfile() {
    return Amplify.DataStore.observeQuery(
      Profile.classType,
    ).map((event) => event.items.first).handleError(
      (dynamic error) {
        logger.e('Error in subscription stream: $error');
        if (error.toString().contains('No element')) {
          throw const AppException.profileNotFound();
        }
        throw const AppException.unKnownError();
      },
    );
  }

  Future<void> updateProfile(Profile updatedProfile) async {
    try {
      final profileWithId = await Amplify.DataStore.query(
        Profile.classType,
        where: Profile.ID.eq(updatedProfile.id),
      );

      final oldProfile = profileWithId.first;
      final newProfile = oldProfile.copyWith(
          id: oldProfile.id,
          firstName: updatedProfile.firstName,
          lastName: updatedProfile.lastName,
          homeCity: updatedProfile.homeCity);

      await Amplify.DataStore.save(newProfile);
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> addProfile(Profile profile) async {
    try {
      await Amplify.DataStore.save(profile);
    } on Exception catch (e) {
      logger.e(e.toString());
    }
  }
}
