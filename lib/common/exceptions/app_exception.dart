// app_exception.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_exception.freezed.dart';

@freezed
class AppException with _$AppException {
  const factory AppException.profileNotFound() = ProfileNotFound;
  const factory AppException.unKnownError() = UnKnownError;
}

class AppExceptionData {
  AppExceptionData(this.code, this.message);
  final String code;
  final String message;

  @override
  String toString() => 'AppExceptionData(code: $code, message: $message)';
}

extension AppExceptionDetails on AppException {
  AppExceptionData get details {
    return when(
      profileNotFound: () => AppExceptionData(
        'profile-not-found',
        'Profile not found, Click the button below to create it',
      ),
      unKnownError: () => AppExceptionData(
        'unknown-error',
        'Something wrong, Please try again',
      ),
    );
  }
}
