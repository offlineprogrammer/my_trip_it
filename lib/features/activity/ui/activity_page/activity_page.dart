import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:my_trip_it/common/navigation/router/routes.dart';
import 'package:my_trip_it/features/activity/controller/activity_controller.dart';
import 'package:my_trip_it/common/utils/app_constants.dart' as constants;
import 'package:my_trip_it/features/activity/ui/activity_category_icon.dart';
import 'package:my_trip_it/features/activity/ui/activity_page/delete_activity.dart';
import 'package:my_trip_it/models/ModelProvider.dart';

class ActivityPage extends ConsumerWidget {
  const ActivityPage({
    required this.activityId,
    super.key,
  });

  final String activityId;

  Future<void> deleteActivity(
      BuildContext context, WidgetRef ref, Activity activity) async {
    var value = await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return const DeleteActivity();
        });
    value ??= false;

    if (value) {
      await ref.read(activityControllerProvider).delete(activity);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activityValue = ref.watch(activityProvider(activityId));

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Amplify TripIT',
          ),
          leading: Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              final activityValue = ref.watch(activityProvider(activityId));
              return activityValue.when(
                data: (activity) => IconButton(
                  onPressed: () {
                    context.goNamed(
                      AppRoute.trip.name,
                      params: {'id': activity.trip.id},
                    );
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
                error: (e, st) => const Placeholder(),
                loading: () => const Placeholder(),
              );
            },
          ),
          backgroundColor: const Color(constants.tripIt_colorPrimaryDarkValue),
        ),
        body: activityValue.when(
          data: (activity) => ListView(
            children: [
              Card(
                child: ListTile(
                  leading:
                      ActivityCategoryIcon(activityCategory: activity.category),
                  title: Text(
                    activity.activityName,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  subtitle: Text(activity.category.name),
                ),
              ),
              ListTile(
                dense: true,
                title: Text(
                  'Activity Date',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: Colors.white),
                ),
                tileColor: Colors.grey,
              ),
              Card(
                child: ListTile(
                  title: Text(
                    DateFormat('EE MMMM dd')
                        .format(activity.activityDate.getDateTimeInUtc()),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ),
              ListTile(
                dense: true,
                title: Text(
                  'Documents',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: Colors.white),
                ),
                tileColor: Colors.grey,
              ),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.add,
                      size: 50,
                      color: Color(constants.tripIt_colorPrimaryDarkValue)),
                  title: Text(
                    'Attach a PDF or photo',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),
              const ListTile(
                dense: true,
                tileColor: Colors.grey,
                visualDensity: VisualDensity(vertical: -4),
              ),
              Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () {
                        deleteActivity(context, ref, activity).then(
                          (value) => context.goNamed(
                            AppRoute.trip.name,
                            params: {'id': activity.trip.id},
                          ),
                        );
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  ],
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
