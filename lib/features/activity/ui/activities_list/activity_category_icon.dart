import 'package:flutter/material.dart';
import 'package:my_trip_it/models/ModelProvider.dart';

class ActivityCategoryIcon extends StatelessWidget {
  const ActivityCategoryIcon({Key? key, required this.activityCategory})
      : super(key: key);
  final ActivityCategory activityCategory;

  @override
  Widget build(BuildContext context) {
    switch (activityCategory) {
      case ActivityCategory.Flight:
        return const Icon(
          Icons.flight,
          size: 50,
        );

      case ActivityCategory.Lodging:
        return const Icon(
          Icons.hotel,
          size: 50,
        );
      case ActivityCategory.Meeting:
        return const Icon(
          Icons.computer,
          size: 50,
        );
      case ActivityCategory.Restaurant:
        return const Icon(
          Icons.restaurant,
          size: 50,
        );
      default:
        ActivityCategory.Flight;
    }
    return const Icon(Icons.flight);
  }
}
