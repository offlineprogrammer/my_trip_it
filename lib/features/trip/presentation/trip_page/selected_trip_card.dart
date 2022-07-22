import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../controller/trip_controller.dart';
import '/common/navigation/router/routes.dart';
import '../../../../common/utils/app_constants.dart' as constants;
import '../../../../models/Trip.dart';
import 'delete_trip.dart';
import 'upload_progress_dialog.dart';

class SelectedTripCard extends ConsumerWidget {
  const SelectedTripCard({Key? key, required this.trip}) : super(key: key);

  final Trip trip;

  Future<void> uploadImage(
      BuildContext context, WidgetRef ref, Trip trip) async {
    final picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) {
      return;
    }

    final file = File(pickedFile.path);
    showDialog<String>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const UploadProgressDialog();
        });
    await ref.read(tripControllerProvider).uploadFile(file, trip);
    Navigator.of(context, rootNavigator: true).pop();
  }

  Future<void> deleteTrip(
      BuildContext context, WidgetRef ref, Trip trip) async {
    var value = await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return const DeleteTrip();
        });
    value ??= false;

    if (value) {
      await ref.read(tripControllerProvider).delete(trip);
      context.goNamed(
        AppRoute.home.name,
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
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
          const SizedBox(
            height: 8,
          ),
          Container(
            alignment: Alignment.center,
            color: const Color(
                constants.tripIt_colorPrimaryDarkValue), //Color(0xffE1E5E4),
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () {
                  uploadImage(context, ref, trip);
                },
                icon: const Icon(Icons.camera_enhance_sharp),
              ),
              IconButton(
                onPressed: () {
                  deleteTrip(context, ref, trip);
                },
                icon: const Icon(Icons.delete),
              ),
            ],
          )
        ],
      ),
    );
  }
}
