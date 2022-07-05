import 'package:flutter/material.dart';
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
                  alignment: Alignment.center,
                  color: const Color(constants.tripIt_colorPrimaryDarkValue),
                  child: Image.asset(
                    'images/amplify.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(
                            trip.tripName,
                            style: TextStyle(
                                fontSize: 14.0, fontWeight: FontWeight.bold),
                          )),
                    ],
                  ))
            ],
          ),
        ));
  }
}
