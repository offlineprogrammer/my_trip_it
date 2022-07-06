import 'package:flutter/material.dart';

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
            break;

          case 'selectedTrip':
            return MaterialPageRoute(
                builder: (context) => SelectedTripTab(), settings: settings);
            break;

          default:
            throw Exception("Invalid route");
        }
      },
    );
  }
}
