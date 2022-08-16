import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:my_trip_it/features/activity/ui/activity_page/activity_page.dart';
import 'package:my_trip_it/features/activity/ui/add_activity/add_activity_page.dart';
import 'package:my_trip_it/features/activity/ui/edit_activity/edit_activity_page.dart';
import 'package:my_trip_it/features/trip/ui/past_trip_page/past_trip_page.dart';
import 'package:my_trip_it/features/trip/ui/past_trips/past_trips_list.dart';

import 'amplifyconfiguration.dart';
import '/common/navigation/router/routes.dart';
import 'features/profile/ui/profile_page/profile_page.dart';
import 'features/trip/ui/trip_page/trip_page.dart';
import 'features/trip/ui/trips_list/trips_list_page.dart';
import 'models/ModelProvider.dart';

import 'common/utils/colors.dart' as constants;

final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

void main() => runApp(const ProviderScope(child: MyApp()));

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _amplifyConfigured = false;

  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  void _configureAmplify() async {
    try {
      AmplifyDataStore datastorePlugin =
          AmplifyDataStore(modelProvider: ModelProvider.instance);

      Amplify.addPlugins([
        AmplifyAuthCognito(),
        datastorePlugin,
        AmplifyAPI(),
        AmplifyStorageS3()
      ]);
      await Amplify.configure(amplifyconfig);
      setState(() {
        _amplifyConfigured = true;
      });
    } on AmplifyAlreadyConfiguredException {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          'Tried to reconfigure Amplify; '
          'this can occur when your app restarts on Android.',
        ),
      ));
    }
  }

  Widget buildApp(BuildContext context) {
    return _amplifyConfigured ? const TripsListPage() : _waitForAmplify();
  }

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      routes: [
        GoRoute(
            path: '/',
            name: AppRoute.home.name,
            builder: (context, state) =>
                _amplifyConfigured ? const TripsListPage() : _waitForAmplify(),
            routes: []),
        GoRoute(
            path: '/trip/:id',
            name: AppRoute.trip.name,
            builder: (context, state) {
              final tripId = state.params['id']!;
              return TripPage(tripId: tripId);
            },
            routes: []),
        GoRoute(
          path: '/activity/:id',
          name: AppRoute.activity.name,
          builder: (context, state) {
            final activityId = state.params['id']!;
            return ActivityPage(activityId: activityId);
          },
        ),
        GoRoute(
          path: '/editactivity/:id',
          name: AppRoute.editactivity.name,
          builder: (context, state) {
            return EditActivityPage(
              activity: state.extra! as Activity,
            );
          },
        ),
        GoRoute(
          path: '/pasttrips',
          name: AppRoute.pasttrips.name,
          builder: (context, state) => const PastTripsList(),
        ),
        GoRoute(
          path: '/pasttrip/:id',
          name: AppRoute.pasttrip.name,
          builder: (context, state) {
            final tripId = state.params['id']!;
            return PastTripPage(tripId: tripId);
          },
        ),
        GoRoute(
          path: '/addActivity/:id',
          name: AppRoute.addactivity.name,
          builder: (context, state) {
            final tripId = state.params['id']!;
            return AddActivityPage(tripId: tripId);
          },
        ),
        GoRoute(
          path: '/profile',
          name: AppRoute.profile.name,
          builder: (context, state) => const ProfilePage(),
        ),
      ],
      errorBuilder: (context, state) => Scaffold(
        body: Center(
          child: Text(state.error.toString()),
        ),
      ),
    );

    return Authenticator(
      child: MaterialApp.router(
        routeInformationParser: router.routeInformationParser,
        routeInformationProvider: router.routeInformationProvider,
        routerDelegate: router.routerDelegate,
        builder: Authenticator.builder(),
        theme: ThemeData(
          primarySwatch: constants.primaryColor,
          backgroundColor: const Color(0xff82CFEA),
        ),
        scaffoldMessengerKey: scaffoldMessengerKey,
      ),
    );
  }

  Scaffold _waitForAmplify() {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
