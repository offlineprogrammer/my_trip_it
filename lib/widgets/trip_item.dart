import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_trip_it/models/Trip.dart';
import '/app_constants.dart' as constants;

class TripItem extends StatelessWidget {
  const TripItem({Key? key, required this.trip}) : super(key: key);

  final Trip trip;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        splashColor: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(15),
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
                        child: Image.asset(
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
                          trip.description!,
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

  Expanded fancy(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 4, 4, 12),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(trip.tripName,
                  style: Theme.of(context).textTheme.subtitle1),
            ),
          ),
          SizedBox(
            height: 298,
            child: Card(
              // This ensures that the Card's children are clipped correctly.
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: InkWell(
                onTap: () {},
                // Generally, material cards use onSurface with 12% opacity for the pressed state.
                splashColor:
                    Theme.of(context).colorScheme.onSurface.withOpacity(0.12),
                // Generally, material cards do not have a highlight overlay.
                highlightColor: Colors.transparent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 184,
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Image.asset(
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
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
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
                                trip.description!,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(color: Colors.black54),
                              ),
                            ),
                            Text(DateFormat('MMMM dd, yyyy')
                                .format(trip.startDate.getDateTimeInUtc())),
                            Text(DateFormat('MMMM dd, yyyy')
                                .format(trip.startDate.getDateTimeInUtc())),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget build(BuildContext context) {
  //   return InkWell(
  //       splashColor: Theme.of(context).primaryColor,
  //       borderRadius: BorderRadius.circular(15),
  //       child: Card(
  //         clipBehavior: Clip.antiAlias,
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(15.0),
  //         ),
  //         elevation: 5.0,
  //         child: Column(
  //           children: [
  //             Expanded(
  //               child: Container(
  //                 alignment: Alignment.center,
  //                 color: const Color(constants.tripIt_colorPrimaryDarkValue),
  //                 child: Image.asset(
  //                   'images/amplify.png',
  //                   fit: BoxFit.contain,
  //                 ),
  //               ),
  //             ),
  //             Padding(
  //                 padding: const EdgeInsets.all(7.0),
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     Padding(
  //                         padding: const EdgeInsets.all(2.0),
  //                         child: Text(
  //                           DateFormat('MMMM dd, yyyy')
  //                               .format(trip.startDate.getDateTimeInUtc()),
  //                           style: const TextStyle(
  //                               fontSize: 14.0, fontWeight: FontWeight.bold),
  //                         )),
  //                   ],
  //                 ))
  //           ],
  //         ),
  //       ));
  // }
}
