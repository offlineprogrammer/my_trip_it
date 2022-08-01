import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_trip_it/features/profile/services/profile_datastore_service.dart';
import 'package:my_trip_it/models/ModelProvider.dart';

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  ProfileDatastoreService profileDatastoreService =
      ref.read(profileDataStoreServiceProvider);
  return ProfileRepository(profileDatastoreService);
});

final profileStreamProvider = StreamProvider.autoDispose<Profile>((ref) {
  final profileRepository = ref.watch(profileRepositoryProvider);
  return profileRepository.listenToProfile();
});

class ProfileRepository {
  ProfileRepository(this.profileDatastoreService);
  final ProfileDatastoreService profileDatastoreService;

  Stream<Profile> listenToProfile() {
    return profileDatastoreService.listenToProfile();
  }

  Future<void> update(Profile updatedProfile) async {
    await profileDatastoreService.updateProfile(updatedProfile);
  }
}
