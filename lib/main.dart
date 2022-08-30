import 'dart:async';

import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:my_trip_it/amplify_tripit_app.dart';

import 'amplifyconfiguration.dart';
import 'models/ModelProvider.dart';

Future<void> main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    bool isAmplifySuccessfullyConfigured = false;
    // try {
    await _configureAmplify();
    isAmplifySuccessfullyConfigured = true;
    // } on AmplifyAlreadyConfiguredException {
    //   //TODO Log the error ;
    // }
    runApp(
      ProviderScope(
        child: AmplifyTripITApp(
          isAmplifySuccessfullyConfigured: isAmplifySuccessfullyConfigured,
        ),
      ),
    );
  }, (error, stack) {
    // myBackend.sendError(error, stack);
  });
}

Future<void> _configureAmplify() async {
  await Amplify.addPlugins([
    AmplifyAuthCognito(),
    AmplifyDataStore(modelProvider: ModelProvider.instance),
    AmplifyAPI(),
    AmplifyStorageS3()
  ]);
  await Amplify.configure(amplifyconfig);
}
