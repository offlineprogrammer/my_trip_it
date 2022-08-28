import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_trip_it/common/service/auth_service.dart';
import '../navigation/router/routes.dart';
import 'package:my_trip_it/common/utils/colors.dart' as constants;

class NavigationDrawer extends ConsumerWidget {
  const NavigationDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color(constants.primaryColorDark),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              children: const [
                SizedBox(height: 10),
                Text('Trip IT',
                    style: TextStyle(fontSize: 25, color: Colors.white)),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Trips'),
            onTap: () {
              context.goNamed(
                AppRoute.home.name,
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.category),
            title: const Text('Past Trips'),
            onTap: () {
              context.goNamed(
                AppRoute.pasttrips.name,
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              context.goNamed(
                AppRoute.profile.name,
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Logout'),
            onTap: () => ref.read(authServiceProvider).signOut(),
          ),
        ],
      ),
    );
  }
}
