import 'package:flutter/material.dart';
import 'package:my_trip_it/widgets/profile_tab.dart';
import 'package:my_trip_it/widgets/uploads_tab.dart';

import 'trips_tab.dart';

enum TabItem { trips, uploads, profile }

const Map<TabItem, String> tabName = {
  TabItem.trips: 'Trips',
  TabItem.uploads: 'Uploads',
  TabItem.profile: 'Profile',
};

const Map<TabItem, Widget> tabIcon = {
  TabItem.trips: Icon(
    Icons.trip_origin_sharp,
  ),
  TabItem.uploads: Icon(
    Icons.book_sharp,
  ),
  TabItem.profile: Icon(
    Icons.verified_user_sharp,
  ),
};

const Map<TabItem, Widget> tabPage = {
  TabItem.trips: TripsTab(),
  TabItem.uploads: UploadsTab(),
  TabItem.profile: ProfileTab(),
};
