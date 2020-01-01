import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_base_project/src/analytics/analytics.dart';

class FirebaseAnalyticsLogger implements AnalyticsLogger {
  FirebaseAnalytics _client;

  static final _instance = FirebaseAnalyticsLogger._();

  factory FirebaseAnalyticsLogger() {
    return _instance;
  }

  FirebaseAnalyticsLogger._() {
    _client = FirebaseAnalytics();
  }

  @override
  void logEvent(String eventName, Map<String, dynamic> params) {
    _client.logEvent(
      name: eventName,
      parameters: params,
    );
  }

  @override
  void loginUser({Map<String, dynamic> userData}) {
    _client.logLogin();
    _client.setUserId(userData['id']);
    _client.setUserProperty(name: 'email', value: userData['email']);
    _client.setUserProperty(
      name: 'name',
      value: userData['name'],
    );
  }

  @override
  void logoutUser() {
    _client.logEvent(name: "SignOut");
    _client.setUserId(null);
    _client.setUserProperty(name: 'email', value: null);
    _client.setUserProperty(name: 'name', value: null);
  }

  @override
  void setCurrentScreen(String screenName) {
    _client.setCurrentScreen(screenName: screenName);
  }
}
