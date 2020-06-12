import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_base_project/src/error_logger/error_logger.dart';

class CrashlyticsErrorLogger implements ErrorLogger {
  @override
  Future<void> logEvent({dynamic exception, StackTrace stackTrace}) async {
    Crashlytics.instance.recordError(exception, stackTrace);
  }
}
