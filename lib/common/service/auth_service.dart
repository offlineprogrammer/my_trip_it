import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_trip_it/common/exceptions/app_exception.dart';
import 'package:my_trip_it/common/utils/logger.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

class AuthService {
  Future<String?> getUserEmail() async {
    try {
      final result = await Amplify.Auth.fetchUserAttributes();
      for (final element in result) {
        if (element.userAttributeKey.toString() == 'email') {
          return element.value;
        }
      }
    } on Exception catch (e) {
      logger.e(e.toString());
      throw const AppException.userfetchError();
    }
    return null;
  }

  Future<void> signOut() async {
    try {
      await Amplify.Auth.signOut();
    } on Exception catch (e) {
      logger.e(e.toString());
    }
  }
}
