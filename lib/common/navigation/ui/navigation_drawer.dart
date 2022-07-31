import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../router/routes.dart';
import 'package:my_trip_it/common/utils/colors.dart' as constants;

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            onTap: () {},
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
          const ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
          ),
        ],
      ),
    );
  }
}
