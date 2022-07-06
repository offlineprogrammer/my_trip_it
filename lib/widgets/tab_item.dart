import 'package:flutter/material.dart';

import 'profile_tab.dart';
import 'trips_tab.dart';
import 'trips_tab_builder.dart';
import 'uploads_tab.dart';

enum TabItem { trips, past_trips, profile }

const Map<TabItem, String> tabName = {
  TabItem.trips: 'Trips',
  TabItem.past_trips: 'Past Trips',
  TabItem.profile: 'Profile',
};

const Map<TabItem, Widget> tabIcon = {
  TabItem.trips: Icon(
    Icons.trip_origin_sharp,
  ),
  TabItem.past_trips: Icon(
    Icons.book_sharp,
  ),
  TabItem.profile: Icon(
    Icons.verified_user_sharp,
  ),
};

const Map<TabItem, Widget> tabPage = {
  TabItem.trips: TripsTabBuilder(),
  TabItem.past_trips: UploadsTab(),
  TabItem.profile: ProfileTab(),
};
