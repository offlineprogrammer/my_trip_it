import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_trip_it/features/profile/data/profile_repository.dart';
import 'package:my_trip_it/models/ModelProvider.dart';

final profileControllerProvider = Provider<ProfileController>((ref) {
  return ProfileController(ref);
});

final profileProvider = StreamProvider.autoDispose<Profile>((ref) {
  final profcontrollerProvider = ref.watch(profileControllerProvider);
  return profcontrollerProvider.listenToProfile();
});

class ProfileController {
  ProfileController(this.ref);
  final Ref ref;

  Stream<Profile> listenToProfile() {
    return ref.read(profileRepositoryProvider).listenToProfile();
  }

  Future<void> edit(Profile updatedProfile) async {
    await ref.read(profileRepositoryProvider).update(updatedProfile);
  }

  Future<void> add(
      {required String firstName,
      required String lastName,
      required String homeCity}) async {
    Profile profile = Profile(
      firstName: firstName,
      lastName: lastName,
      homeCity: homeCity,
      email: '',
    );

    await ref.read(profileRepositoryProvider).add(profile);
  }
}
