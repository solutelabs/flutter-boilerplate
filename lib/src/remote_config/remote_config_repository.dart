import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/services.dart';

class RemoteConfigRepository {
  static final _instance = RemoteConfigRepository._();
  RemoteConfig? _config;

  factory RemoteConfigRepository() => _instance;

  RemoteConfigRepository._();

  Future<void> initConfig() async {
    if (_config == null) {
      _config = await RemoteConfig.instance;
    }
  }

  Future<void> syncConfig() async {
    try {
      await _config!.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 3),
        minimumFetchInterval: Duration.zero,
      ));

      await _config!.fetchAndActivate();
    } catch (err) {
      if (_config!.lastFetchStatus == RemoteConfigFetchStatus.noFetchYet) {
        throw PlatformException(
          code: 'REMOTE_CONFIG_ERROR',
          details: 'RemoteConfig could not be synced!',
        );
      }
    }
  }

  String getString(String key) {
    return _config!.getString(key);
  }

  int getInt(String key) {
    return _config!.getInt(key);
  }

  bool getBool(String key) {
    return _config!.getBool(key);
  }

  double getDouble(String key) {
    return _config!.getDouble(key);
  }
}
