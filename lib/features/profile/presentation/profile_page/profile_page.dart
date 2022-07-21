import 'package:flutter/material.dart';

import '../../../../common/navigation/navigation_drawer.dart';
import '../../../../common/utils/app_constants.dart' as constants;

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Amplify TripIT',
          ),
          backgroundColor: const Color(constants.tripIt_colorPrimaryDarkValue),
        ),
        drawer: const NavigationDrawer(),
        body: const Center(
          child: Text('Profile Page'),
        ));
  }
}
