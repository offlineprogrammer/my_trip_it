import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';

import 'amplifyconfiguration.dart';
import 'features/router/routes.dart';
import 'features/trip/presentation/trip_page/trip_page.dart';
import 'features/trip/presentation/trips_list/trips_list_page.dart';
import 'models/ModelProvider.dart';

import 'common/app_constants.dart' as constants;

final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

void main() => runApp(const ProviderScope(child: MyApp()));

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _amplifyConfigured = false;

  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  void _configureAmplify() async {
    try {
      await Amplify.addPlugins([
        AmplifyAuthCognito(),
        AmplifyAPI(modelProvider: ModelProvider.instance),
        AmplifyStorageS3()
      ]);
      await Amplify.configure(amplifyconfig);
      setState(() {
        _amplifyConfigured = true;
      });
    } on AmplifyAlreadyConfiguredException {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          'Tried to reconfigure Amplify; '
          'this can occur when your app restarts on Android.',
        ),
      ));
    }
  }

  Widget buildApp(BuildContext context) {
    return _amplifyConfigured ? const TripsListPage() : _waitForAmplify();
  }

  @override
  Widget build(BuildContext context) {
    final _router = GoRouter(
      routes: [
        GoRoute(
            path: '/',
            name: AppRoute.home.name,
            builder: (context, state) =>
                _amplifyConfigured ? const TripsListPage() : _waitForAmplify(),
            routes: [
              GoRoute(
                path: 'trip/:id',
                name: AppRoute.trip.name,
                builder: (context, state) {
                  final tripId = state.params['id']!;
                  return TripPage(tripId: tripId);
                },
              ),
            ]),
      ],
    );

    return Authenticator(
      child: MaterialApp.router(
        routeInformationParser: _router.routeInformationParser,
        routeInformationProvider: _router.routeInformationProvider,
        routerDelegate: _router.routerDelegate,
        builder: Authenticator.builder(),
        theme: ThemeData(
          primarySwatch: constants.tripIt_colorPrimary,
          backgroundColor: const Color(0xff82CFEA),
        ),
        scaffoldMessengerKey: scaffoldMessengerKey,
      ),
    );
  }

  Scaffold _waitForAmplify() {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
