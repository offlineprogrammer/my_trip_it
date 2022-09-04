import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_trip_it/common/exceptions/app_exception.dart';
import 'package:my_trip_it/common/exceptions/error_logger.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService(ref: ref);
});

class AuthService {
  AuthService({
    required Ref ref,
  }) : errorLogger = ref.read(errorLoggerProvider);

  final ErrorLogger errorLogger;

  Future<String?> getUserEmail() async {
    try {
      final result = await Amplify.Auth.fetchUserAttributes();
      for (final element in result) {
        if (element.userAttributeKey.toString() == 'email') {
          return element.value;
        }
      }
    } on Exception catch (e) {
      errorLogger.logError(e);
      throw const AppException.userfetchError();
    }
    return null;
  }

  Future<void> signOut() async {
    try {
      await Amplify.Auth.signOut();
      await Amplify.DataStore.clear();
    } on Exception catch (e) {
      errorLogger.logError(e);
    }
  }
}
