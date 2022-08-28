import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

final errorLoggerProvider = Provider<ErrorLogger>((ref) {
  return ErrorLogger();
});

class ErrorLogger {
  final logger = Logger();

  void logError(Object error) {
    logger.e(error);
  }
}
