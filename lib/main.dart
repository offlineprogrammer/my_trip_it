import 'dart:async';

import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:my_trip_it/amplify_tripit_app.dart';
import 'package:my_trip_it/common/exceptions/error_logger.dart';

import 'amplifyconfiguration.dart';
import 'models/ModelProvider.dart';

Future<void> main() async {
  late ErrorLogger errorLogger;

  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    bool isAmplifySuccessfullyConfigured = false;

    await _configureAmplify();
    isAmplifySuccessfullyConfigured = true;
    final container = ProviderContainer();

    errorLogger = container.read(errorLoggerProvider);

    runApp(UncontrolledProviderScope(
      container: container,
      child: AmplifyTripITApp(
        isAmplifySuccessfullyConfigured: isAmplifySuccessfullyConfigured,
      ),
    ));

    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details);
    };

    ErrorWidget.builder = (FlutterErrorDetails details) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text('An error occurred'),
        ),
        body: Center(child: Text(details.toString())),
      );
    };
  }, (error, stack) {
    errorLogger.logError(error);
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
