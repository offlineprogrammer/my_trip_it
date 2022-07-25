import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_trip_it/common/service/storage_service.dart';
import 'package:my_trip_it/features/activity/data/activities_repository.dart';
import 'package:my_trip_it/features/activity/ui/activities_list/activity_card.dart';
import 'package:my_trip_it/models/ModelProvider.dart';

class ActivitiesList extends ConsumerWidget {
  const ActivitiesList({Key? key, required this.trip}) : super(key: key);
  final Trip trip;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    final activitiesListValue = ref.watch(activitiesListStreamProvider);

    return activitiesListValue.when(
        data: (activities) => activities.isEmpty
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
                      children: activities.map((activityData) {
                        if (activityData!.trip.tripImageUrl != null) {
                          return Consumer(builder: (context, ref, _) {
                            final imageURL = ref.watch(imageUrlProvider(
                                activityData.trip.tripImageUrl!));
                            return imageURL.when(
                              data: (String url) {
                                return ActivityCard(
                                    activity: activityData, imageURL: url);
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
                          return ActivityCard(activity: activityData);
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
            ));
  }
}
