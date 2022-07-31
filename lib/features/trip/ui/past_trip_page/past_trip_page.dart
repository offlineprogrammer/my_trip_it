import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_trip_it/common/navigation/router/routes.dart';
import 'package:my_trip_it/common/ui/navigation_drawer.dart';
import 'package:my_trip_it/common/utils/colors.dart' as constants;
import 'package:my_trip_it/features/trip/data/trips_repository.dart';
import 'package:my_trip_it/features/trip/ui/past_trip_page/selected_past_trip_card.dart';

class PastTripPage extends ConsumerWidget {
  const PastTripPage({
    required this.tripId,
    super.key,
  });
  final String tripId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tripValue = ref.watch(tripProvider(tripId));
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Amplify TripIT',
          ),
          actions: [
            IconButton(
              onPressed: () {
                context.goNamed(
                  AppRoute.home.name,
                );
              },
              icon: const Icon(Icons.home),
            ),
          ],
          backgroundColor: const Color(constants.primaryColorDark),
        ),
        drawer: const NavigationDrawer(),
        body: ColorFiltered(
          colorFilter: const ColorFilter.matrix(<double>[
            0.2126,
            0.7152,
            0.0722,
            0,
            0,
            0.2126,
            0.7152,
            0.0722,
            0,
            0,
            0.2126,
            0.7152,
            0.0722,
            0,
            0,
            0,
            0,
            0,
            1,
            0,
          ]),
          child: tripValue.when(
            data: (trip) => trip == null
                ? const Center(
                    child: Text('Trip Not Found'),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(
                        height: 8,
                      ),
                      SelectedPastTripCard(trip: trip),
                      const SizedBox(
                        height: 20,
                      ),
                      const Divider(
                        height: 20,
                        thickness: 5,
                        indent: 20,
                        endIndent: 20,
                      ),
                      const Text(
                        "Your Activites",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      // Expanded(
                      //   child: ActivitiesList(
                      //     trip: trip,
                      //   ),
                      // )
                    ],
                  ),
            error: (e, st) => const Center(
              child: Text('Error'),
            ),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ));
  }
}
