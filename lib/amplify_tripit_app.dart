import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_trip_it/common/navigation/router/routes.dart';
import 'package:my_trip_it/features/activity/ui/activity_page/activity_page.dart';
import 'package:my_trip_it/features/activity/ui/add_activity/add_activity_page.dart';
import 'package:my_trip_it/features/activity/ui/edit_activity/edit_activity_page.dart';
import 'package:my_trip_it/features/profile/ui/profile_page/profile_page.dart';
import 'package:my_trip_it/features/trip/ui/edit_trip_page/edit_trip_page.dart';
import 'package:my_trip_it/features/trip/ui/past_trip_page/past_trip_page.dart';
import 'package:my_trip_it/features/trip/ui/past_trips/past_trips_list.dart';
import 'package:my_trip_it/features/trip/ui/trip_page/trip_page.dart';
import 'package:my_trip_it/features/trip/ui/trips_list/trips_list_page.dart';
import 'package:my_trip_it/models/ModelProvider.dart';
import 'common/utils/colors.dart' as constants;

class AmplifyTripITApp extends StatelessWidget {
  const AmplifyTripITApp({
    required this.isAmplifySuccessfullyConfigured,
    Key? key,
  }) : super(key: key);

  final bool isAmplifySuccessfullyConfigured;

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      routes: [
        GoRoute(
            path: '/',
            name: AppRoute.home.name,
            builder: (context, state) => isAmplifySuccessfullyConfigured
                ? const TripsListPage()
                : const Scaffold(
                    body: Center(
                      child: Text(
                        'Tried to reconfigure Amplify; '
                        'this can occur when your app restarts on Android.',
                      ),
                    ),
                  ),
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
          path: '/edittrip/:id',
          name: AppRoute.edittrip.name,
          builder: (context, state) {
            return EditTripPage(
              trip: state.extra! as Trip,
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
      ),
    );
  }
}
