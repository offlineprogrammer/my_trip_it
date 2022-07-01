import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/ModelProvider.dart';
import 'add_trip.dart';

class TripsTab extends HookConsumerWidget {
  const TripsTab({Key? key}) : super(key: key);

  void _showAddTripDialog(BuildContext context) async {
    var value = await showDialog<Trip>(
      context: context,
      builder: (BuildContext context) {
        return AddTrip();
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        const Center(
          child: Text('Home Page'),
        ),
        Align(
          alignment: Alignment.bottomRight,
          // add your floating action button
          child: FloatingActionButton(
            onPressed: () {
              _showAddTripDialog(context);
            },
            child: Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
