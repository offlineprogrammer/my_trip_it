import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_trip_it/widgets/trip_item.dart';

import '../main.dart';
import '../models/ModelProvider.dart';
import 'add_trip.dart';

class TripsTab extends HookConsumerWidget {
  const TripsTab({Key? key}) : super(key: key);

  void _showAddTripDialog(BuildContext context) async {
    await showDialog<Trip>(
      context: context,
      builder: (BuildContext context) {
        return AddTrip();
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    final trips = ref.watch(tripsProvider);

    return trips.when(
      data: (data) => Column(
        children: [
          Flexible(
            child: GridView.count(
              crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3,
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
              padding: const EdgeInsets.all(4.0),
              childAspectRatio:
                  (orientation == Orientation.portrait) ? 1.3 : 1.3,
              children: data!
                  .map(
                    (tripData) => TripItem(
                      trip: tripData!,
                    ),
                  )
                  .toList(),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            // add your floating action button
            child: FloatingActionButton(
              onPressed: () {
                _showAddTripDialog(context);
              },
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
      error: (e, s) => const Center(
        child: Text('Uh oh. Something went wrong!'),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
