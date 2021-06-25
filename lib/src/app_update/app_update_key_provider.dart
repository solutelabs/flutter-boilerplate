import 'dart:io' show Platform;

abstract class AppUpdateKeyProvider {
  String? keyLatestStableVersion;
  String? keyLatestVersion;
}

class AndroidAppUpdateKey implements AppUpdateKeyProvider {
  @override
  String? keyLatestStableVersion = 'android_latest_stable_version';

  @override
  String? keyLatestVersion = 'android_latest_version';
}

class IOSAppUpdateKey implements AppUpdateKeyProvider {
  @override
  String? keyLatestStableVersion = 'iOS_latest_stable_version';

  @override
  String? keyLatestVersion = 'iOS_latest_version';
}

AppUpdateKeyProvider? platformKeyProvider() {
  if (Platform.isAndroid) {
    return AndroidAppUpdateKey();
  } else if (Platform.isIOS) {
    return IOSAppUpdateKey();
  }
  return null;
}
