import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../common/navigation_drawer.dart';
import '../../data/trips_repository.dart';
import '/common/app_constants.dart' as constants;

class TripPage extends StatelessWidget {
  const TripPage({Key? key, required this.tripId}) : super(key: key);
  final String tripId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Amplify TripIT',
        ),
        backgroundColor: const Color(constants.tripIt_colorPrimaryDarkValue),
      ),
      drawer: const NavigationDrawer(),
      body: Consumer(
        builder: (context, ref, _) {
          final tripValue = ref.watch(tripProvider(tripId));
          return tripValue.when(
            data: (trip) => trip == null
                ? Center(
                    child: Text('Trip Not Found'),
                  )
                : Column(
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () {},
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
                            backgroundColor: const Color(
                                constants.tripIt_colorPrimaryDarkValue),
                            child: const Icon(Icons.add),
                          ),
                        ),
                      ),
                    ],
                  ),
            error: (e, st) => const Center(
              child: Text('Error'),
            ),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
