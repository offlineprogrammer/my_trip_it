import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_trip_it/common/navigation/navigation_drawer.dart';
import 'package:my_trip_it/common/navigation/router/routes.dart';
import 'package:my_trip_it/features/activity/ui/activities_list/activities_list.dart';
import 'package:my_trip_it/features/activity/ui/activities_list/add_activity.dart';
import 'package:my_trip_it/features/trip/data/trips_repository.dart';
import 'package:my_trip_it/common/utils/app_constants.dart' as constants;
import 'package:my_trip_it/features/trip/ui/trip_page/edit_trip.dart';
import 'package:my_trip_it/features/trip/ui/trip_page/selected_trip_card.dart';
import 'package:my_trip_it/models/Trip.dart';

class TripPage extends ConsumerWidget {
  const TripPage({Key? key, required this.tripId}) : super(key: key);
  final String tripId;

  void showAddActivityDialog(BuildContext context, Trip trip) async {
    await showModalBottomSheet<void>(
      isScrollControlled: true,
      elevation: 5,
      context: context,
      builder: (BuildContext context) {
        return AddActivity(trip);
      },
    );
  }

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
          backgroundColor: const Color(constants.tripIt_colorPrimaryDarkValue),
        ),
        drawer: const NavigationDrawer(),
        floatingActionButton: Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            final tripValue = ref.watch(tripProvider(tripId));
            return tripValue.when(
              data: (trip) => FloatingActionButton(
                onPressed: () {
                  showAddActivityDialog(context, trip!);
                },
                backgroundColor:
                    const Color(constants.tripIt_colorPrimaryDarkValue),
                child: const Icon(Icons.add),
              ),
              error: (e, st) => const Placeholder(),
              loading: () => const Placeholder(),
            );
          },
        ),
        body: tripValue.when(
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
                    SelectedTripCard(trip: trip),
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
                    Expanded(
                      child: ActivitiesList(
                        trip: trip,
                      ),
                    )
                  ],
                ),
          error: (e, st) => const Center(
            child: Text('Error'),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        ));
  }
}
