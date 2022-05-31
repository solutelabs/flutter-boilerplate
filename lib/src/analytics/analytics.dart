import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_base_project/src/analytics/firebase_analytics_logger.dart';

abstract class AnalyticsLogger {
  void loginUser({Map<String, dynamic>? userData});

  void logoutUser();

  void logEvent(String? eventName, Map<String, dynamic>? params);

  void setCurrentScreen(String? screenName);
}

AnalyticsLogger getAnalysisLogger() {
  return FirebaseAnalyticsLogger();
}

FirebaseAnalyticsObserver navigationObserverAnalytics() {
  return FirebaseAnalyticsObserver(
    analytics: FirebaseAnalytics.instance,
  );
}
