import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_trip_it/features/activity/data/activities_repository.dart';
import 'package:my_trip_it/features/activity/ui/activities_list/activity_category_icon.dart';
import 'package:my_trip_it/models/ModelProvider.dart';
import 'package:timelines/timelines.dart';

class ActivitiesList extends ConsumerWidget {
  const ActivitiesList({
    required this.trip,
    super.key,
  });
  final Trip trip;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activitiesListValue = ref.watch(activitiesListStreamProvider(trip));

    return activitiesListValue.when(
        data: (activities) => activities.isEmpty
            ? const Center(
                child: Text('No Activities'),
              )
            : Column(
                children: [
                  Flexible(
                    child: Timeline.tileBuilder(
                      builder: TimelineTileBuilder.fromStyle(
                        oppositeContentsBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: ActivityCategoryIcon(
                                activityCategory: activities[index]!.category),
                          );
                        },
                        contentsAlign: ContentsAlign.alternating,
                        contentsBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Text(activities[index]!.activityName),
                        ),
                        itemCount: activities.length,
                      ),
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
