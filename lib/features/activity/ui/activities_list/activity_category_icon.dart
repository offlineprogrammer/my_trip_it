import 'package:flutter/material.dart';
import 'package:my_trip_it/models/ModelProvider.dart';
import 'package:my_trip_it/common/utils/app_constants.dart' as constants;

class ActivityCategoryIcon extends StatelessWidget {
  const ActivityCategoryIcon({
    required this.activityCategory,
    super.key,
  });
  final ActivityCategory activityCategory;

  @override
  Widget build(BuildContext context) {
    switch (activityCategory) {
      case ActivityCategory.Flight:
        return const Icon(
          Icons.flight,
          size: 50,
          color: Color(constants.tripIt_colorPrimaryDarkValue),
        );

      case ActivityCategory.Lodging:
        return const Icon(
          Icons.hotel,
          size: 50,
          color: Color(constants.tripIt_colorPrimaryDarkValue),
        );
      case ActivityCategory.Meeting:
        return const Icon(
          Icons.computer,
          size: 50,
          color: Color(constants.tripIt_colorPrimaryDarkValue),
        );
      case ActivityCategory.Restaurant:
        return const Icon(
          Icons.restaurant,
          size: 50,
          color: Color(constants.tripIt_colorPrimaryDarkValue),
        );
      default:
        ActivityCategory.Flight;
    }
    return const Icon(
      Icons.flight,
      size: 50,
      color: Color(constants.tripIt_colorPrimaryDarkValue),
    );
  }
}
