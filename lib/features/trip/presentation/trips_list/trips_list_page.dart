import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../common/navigation_drawer.dart';
import '../../../../common/storage_service.dart';
import '../../data/trips_repository.dart';
import 'add_trip.dart';
import 'trip_card.dart';
import '/common/app_constants.dart' as constants;

class TripsListPage extends HookConsumerWidget {
  const TripsListPage({Key? key}) : super(key: key);

  void showAddTripDialog(BuildContext context) async {
    await showModalBottomSheet<void>(
      isScrollControlled: true,
      elevation: 5,
      context: context,
      builder: (BuildContext context) {
        return AddTrip();
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    final tripsListValue = ref.watch(tripsListStreamProvider);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Amplify TripIT',
          ),
          backgroundColor: const Color(constants.tripIt_colorPrimaryDarkValue),
        ),
        drawer: const NavigationDrawer(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showAddTripDialog(context);
          },
          backgroundColor: const Color(constants.tripIt_colorPrimaryDarkValue),
          child: const Icon(Icons.add),
        ),
        body: tripsListValue.when(
            data: (trips) => trips.isEmpty
                ? const Center(
                    child: Text('No Trips'),
                  )
                : Column(
                    children: [
                      Flexible(
                        child: GridView.count(
                          crossAxisCount:
                              (orientation == Orientation.portrait) ? 2 : 3,
                          mainAxisSpacing: 4,
                          crossAxisSpacing: 4,
                          padding: const EdgeInsets.all(4),
                          childAspectRatio:
                              (orientation == Orientation.portrait) ? 0.9 : 1.4,
                          children: trips.map((tripData) {
                            if (tripData!.tripImageUrl != null) {
                              return Consumer(builder: (context, ref, _) {
                                final imageURL = ref.watch(
                                    imageUrlProvider(tripData.tripImageUrl!));
                                return imageURL.when(
                                  data: (String url) {
                                    return TripCard(
                                        trip: tripData, imageURL: url);
                                  },
                                  error: (e, st) => const Center(
                                    child: Text('Error'),
                                  ),
                                  loading: () => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              });
                            } else {
                              return TripCard(trip: tripData);
                            }
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
            error: (e, st) => const Center(
                  child: Text('Error'),
                ),
            loading: () => const Center(
                  child: CircularProgressIndicator(),
                )));
  }
}
