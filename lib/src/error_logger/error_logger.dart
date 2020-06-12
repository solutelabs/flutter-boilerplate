import 'package:flutter_base_project/src/error_logger/crashlytics_error_logger.dart';

abstract class ErrorLogger {
  Future<void> logEvent({
    dynamic exception,
    StackTrace stackTrace,
  });
}

ErrorLogger getErrorLogger() {
  return CrashlyticsErrorLogger();
}
