import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_trip_it/models/Trip.dart';
import '../services/storage_service.dart';
import '/app_constants.dart' as constants;
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../main.dart';

class SelectedTripTab extends HookConsumerWidget {
  const SelectedTripTab({Key? key}) : super(key: key);

  Future<void> uploadImage(
      BuildContext context, WidgetRef ref, Trip selectedTrip) async {
    final StorageService storageService = StorageService();
    final picker = ImagePicker();
    // Select image from user's gallery
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) {
      print('No image selected');
      return;
    }

    final file = File(pickedFile.path);
    showDialog<String>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            // The background color
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: ValueListenableBuilder(
                valueListenable: storageService.uploadProgress,
                builder: (context, value, child) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircularProgressIndicator(),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                          '${(double.parse(value.toString()) * 100).toInt()} %'),
                      Container(
                          alignment: Alignment.topCenter,
                          margin: const EdgeInsets.all(20),
                          child: LinearProgressIndicator(
                            value: double.parse(value.toString()),
                            backgroundColor: Colors.grey,
                            color: Colors.purple,
                            minHeight: 10,
                          )),
                    ],
                  );
                },
              ),
            ),
          );
        });
    final imageUrl = await storageService.uploadFile(file);

    final updatedTrip = selectedTrip.copyWith(tripImageUrl: imageUrl);
    ref.read(tripsProvider.notifier).update(updatedTrip);
    Navigator.of(context, rootNavigator: true).pop();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trip = ref.watch(selectedTrip);

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
                trip.tripName,
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

                child: trip.tripImageUrl != null
                    ? Stack(children: [
                        const Center(child: CircularProgressIndicator()),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      uploadImage(context, ref, trip);
                    },
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
