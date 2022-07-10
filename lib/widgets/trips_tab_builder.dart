import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../main.dart';
import 'selected_trip_tab.dart';
import 'trips_tab.dart';

class TripsTabBuilder extends StatelessWidget {
  const TripsTabBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: 'trips',
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case 'trips':
            return MaterialPageRoute(
                builder: (context) => TripsTab(), settings: settings);

          case 'selectedTrip':
            final arg = settings.arguments as Map;

            Widget? result;
            result = ProviderScope(
              overrides: [
                selectedTrip.overrideWithValue(arg['selectedTrip']),
              ],
              child: const SelectedTripTab(),
            );

            return MaterialPageRoute<void>(builder: (context) => result!);

          default:
            throw Exception("Invalid route");
        }
      },
    );
  }
}
