import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import 'package:my_trip_it/features/trip/controller/trip_controller.dart';
import 'package:my_trip_it/common/navigation/router/routes.dart';
import 'package:my_trip_it/common/utils/colors.dart' as constants;

import 'package:my_trip_it/models/Trip.dart';
import 'package:my_trip_it/features/trip/ui/trip_page/delete_trip_dialog.dart';
import 'package:my_trip_it/common/ui/upload_progress_dialog.dart';

class SelectedTripCard extends ConsumerWidget {
  const SelectedTripCard({
    required this.trip,
    super.key,
  });

  final Trip trip;

  Future<void> uploadImage({
    required BuildContext context,
    required WidgetRef ref,
    required Trip trip,
  }) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
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
  }

  Future<bool> deleteTrip(
      BuildContext context, WidgetRef ref, Trip trip) async {
    var value = await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return const DeleteTripDialog();
        });
    value ??= false;

    if (value) {
      await ref.read(tripControllerProvider).delete(trip);
    }
    return value;
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
            color: const Color(constants.primaryColorDark), //Color(0xffE1E5E4),
            height: 150,

            child: trip.tripImageUrl != null
                ? Stack(children: [
                    const Center(child: CircularProgressIndicator()),
                    CachedNetworkImage(
                      cacheKey: trip.tripImageKey,
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
                onPressed: () {
                  context.goNamed(
                    AppRoute.edittrip.name,
                    params: {'id': trip.id},
                    extra: trip,
                  );
                },
                icon: const Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () {
                  uploadImage(
                    context: context,
                    trip: trip,
                    ref: ref,
                  ).then((value) =>
                      Navigator.of(context, rootNavigator: true).pop());
                },
                icon: const Icon(Icons.camera_enhance_sharp),
              ),
              IconButton(
                onPressed: () {
                  deleteTrip(context, ref, trip).then((value) {
                    if (value) {
                      context.goNamed(
                        AppRoute.home.name,
                      );
                    }
                  });
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
