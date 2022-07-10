import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:my_trip_it/models/Trip.dart';
import '../main.dart';
import '/app_constants.dart' as constants;
import 'selected_trip_tab.dart';

class TripItem extends StatelessWidget {
  const TripItem({Key? key, required this.trip}) : super(key: key);

  final Trip trip;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        splashColor: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          Navigator.of(context).pushNamed(
            "selectedTrip",
            arguments: {'selectedTrip': trip},
          );
        },
        child: Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 5.0,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  height: 500,
                  alignment: Alignment.center,
                  color: const Color(constants.tripIt_colorPrimaryDarkValue),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: trip.tripImageUrl != null
                            ? Stack(children: [
                                const Center(
                                    child: CircularProgressIndicator()),
                                CachedNetworkImage(
                                  imageUrl: trip.tripImageUrl!,
                                  width: double.maxFinite,
                                  height: 500,
                                  alignment: Alignment.topCenter,
                                  fit: BoxFit.fill,
                                ),
                              ])
                            : Image.asset(
                                'images/amplify.png',
                                fit: BoxFit.contain,
                              ),
                      ),
                      Positioned(
                        bottom: 16,
                        left: 16,
                        right: 16,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            trip.destination,
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(2, 8, 8, 4),
                child: DefaultTextStyle(
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.subtitle1!,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // This array contains the three line description on each card
                      // demo.
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          trip.tripName,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(color: Colors.black54),
                        ),
                      ),
                      Text(
                        DateFormat('MMMM dd, yyyy')
                            .format(trip.startDate.getDateTimeInUtc()),
                        style: const TextStyle(fontSize: 12),
                      ),
                      Text(
                          DateFormat('MMMM dd, yyyy')
                              .format(trip.startDate.getDateTimeInUtc()),
                          style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
