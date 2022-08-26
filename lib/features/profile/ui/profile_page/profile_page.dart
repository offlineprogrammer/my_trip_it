import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_trip_it/common/exceptions/app_exception.dart';
import 'package:my_trip_it/common/ui/navigation_drawer.dart';

import 'package:my_trip_it/common/utils/colors.dart' as constants;
import 'package:my_trip_it/features/profile/controller/profile_controller.dart';
import 'package:my_trip_it/features/profile/ui/profile_page/add_profile_bottomsheet.dart';
import 'package:my_trip_it/features/profile/ui/profile_page/edit_profile_bottomsheet.dart';
import 'package:my_trip_it/models/ModelProvider.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({
    super.key,
  });

  void editProfile(BuildContext context, Profile profile) async {
    await showModalBottomSheet<void>(
      isScrollControlled: true,
      elevation: 5,
      context: context,
      builder: (BuildContext context) {
        return EditProfileBottomSheet(
          profile: profile,
        );
      },
    );
  }

  void createProfile(BuildContext context) async {
    await showModalBottomSheet<void>(
      isScrollControlled: true,
      elevation: 5,
      context: context,
      builder: (BuildContext context) {
        return AddProfileBottomSheet();
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileValue = ref.watch(profileProvider);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Amplify TripIT',
          ),
          backgroundColor: const Color(constants.primaryColorDark),
        ),
        drawer: const NavigationDrawer(),
        body: profileValue.when(
          data: (profile) => ListView(
            children: [
              Card(
                child: ListTile(
                  leading: const Icon(
                    Icons.verified_user,
                    size: 50,
                    color: Color(constants.primaryColorDark),
                  ),
                  title: Text(
                    profile.firstName != null
                        ? profile.firstName!
                        : 'Add your name',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  subtitle: Text(profile.email),
                ),
              ),
              ListTile(
                dense: true,
                title: Text(
                  'Home',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: Colors.white),
                ),
                tileColor: Colors.grey,
              ),
              Card(
                child: ListTile(
                  title: Text(
                    profile.firstName != null
                        ? profile.homeCity!
                        : 'Add your city',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ),
              const ListTile(
                dense: true,
                tileColor: Colors.grey,
                visualDensity: VisualDensity(vertical: -4),
              ),
              Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        editProfile(context, profile);
                      },
                      child: const Text('Edit'),
                    ),
                  ],
                ),
              )
            ],
          ),
          error: (e, st) => Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    e is AppException ? e.details.message : 'Error',
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    createProfile(context);
                  },
                  child: const Text('Create'),
                ),
              ],
            ),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        ));
  }
}
