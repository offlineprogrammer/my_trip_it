import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_trip_it/models/Trip.dart';
import '/app_constants.dart' as constants;

class SelectedTripTab extends HookConsumerWidget {
  const SelectedTripTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    final Trip selectedTrip = arguments['selectedTrip'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(
          height: 8,
        ),
        const SizedBox(
          height: 8,
        ),
        Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 5,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                selectedTrip.tripName,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                alignment: Alignment.center,
                color: const Color(constants
                    .tripIt_colorPrimaryDarkValue), //Color(0xffE1E5E4),
                height: 150,
                child: Image.asset(
                  'images/amplify.png',
                  fit: BoxFit.contain,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {}, // => controller.setKidTaskImage(),
                    icon: const Icon(Icons.camera_enhance_sharp),
                  ),
                ],
              )
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Divider(
          height: 20,
          thickness: 5,
          indent: 20,
          endIndent: 20,
        ),
        const Text(
          "Your Activites",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Align(
            alignment: Alignment.bottomRight,

            // add your floating action button
            child: FloatingActionButton(
              onPressed: () {
                //_showAddTripDialog(context);
              },
              backgroundColor:
                  const Color(constants.tripIt_colorPrimaryDarkValue),
              child: const Icon(Icons.add),
            ),
          ),
        ),
      ],
    );
  }
}
