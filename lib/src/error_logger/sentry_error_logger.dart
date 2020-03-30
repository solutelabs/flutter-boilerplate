import 'package:flutter/foundation.dart';
import 'package:flutter_base_project/src/error_logger/error_logger.dart';
import 'package:sentry/sentry.dart';

class SentryErrorLogger implements ErrorLogger {
  SentryClient _client;

  static final _instance = SentryErrorLogger._();

  factory SentryErrorLogger() {
    return _instance;
  }

  SentryErrorLogger._() {
    _getSentryClientDSN()
        .then((dsn) => _client = SentryClient(dsn: dsn))
        .catchError((err) => debugPrint(err.toString()));
  }

  Future<String> _getSentryClientDSN() async {
    //TODO Add Sentry DSN
    return "DSN";
  }

  @override
  Future<void> logEvent({dynamic exception, StackTrace stackTrace}) async {
    final extraData = await extras();
    final tagsData = await tags();
    return _client.capture(
      event: Event(
        exception: exception,
        stackTrace: stackTrace,
        extra: extraData,
        tags: tagsData,
      ),
    );
  }
}
