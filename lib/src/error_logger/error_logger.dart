import 'package:device_info/device_info.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_base_project/src/error_logger/sentry_error_logger.dart';
import 'package:package_info/package_info.dart';

abstract class ErrorLogger {
  Future<void> logEvent({
    dynamic exception,
    StackTrace stackTrace,
  });
}

Future<Map<String, dynamic>> tags() async {
  final info = await PackageInfo.fromPlatform();
  return {
    "platform": defaultTargetPlatform.toString(),
    "package_name": info.packageName,
    "build_number": info.buildNumber,
    "version": info.version,
  };
}

Future<Map<String, dynamic>> extras() async {
  final deviceInfo = DeviceInfoPlugin();
  final extras = {};
  if (defaultTargetPlatform == TargetPlatform.android) {
    final info = await deviceInfo.androidInfo;
    extras['device_info'] = {
      "model": info.model,
      "brand": info.brand,
      "manufacturer": info.manufacturer,
      "version": info.version.release,
    };
  } else if (defaultTargetPlatform == TargetPlatform.iOS) {
    final info = await deviceInfo.iosInfo;
    extras['device_info'] = {
      "model": info.model,
      "version": info.systemVersion,
    };
  }
  return extras;
}

ErrorLogger getErrorLogger() {
  return SentryErrorLogger();
}
