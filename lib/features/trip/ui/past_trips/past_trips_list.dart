import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_trip_it/common/service/storage_service.dart';
import 'package:my_trip_it/common/ui/navigation_drawer.dart';
import 'package:my_trip_it/common/utils/colors.dart' as constants;
import 'package:my_trip_it/features/trip/data/trips_repository.dart';
import 'package:my_trip_it/features/trip/ui/past_trips/past_trip_card.dart';

class PastTripsList extends ConsumerWidget {
  const PastTripsList({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    final tripsListValue = ref.watch(pastTripsListStreamProvider);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Amplify TripIT',
          ),
          backgroundColor: const Color(constants.primaryColorDark),
        ),
        drawer: const NavigationDrawer(),
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
                            if (tripData!.tripImageKey != null) {
                              return Consumer(builder: (context, ref, _) {
                                final imageURL = ref.watch(
                                    imageUrlProvider(tripData.tripImageKey!));
                                return imageURL.when(
                                  data: (String url) {
                                    return PastTripCard(
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
                              return PastTripCard(trip: tripData);
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
