abstract class Flavor {
  String get name;
}

class Development implements Flavor {
  @override
  String get name => "development";
}

class Staging implements Flavor {
  @override
  String get name => "staging";
}

class Production implements Flavor {
  @override
  String get name => "production";
}

enum AppMode {
  DEBUG,
  RELEASE,
  PROFILE,
}

class Config {
  Config._();

  static Flavor appFlavor;
  static AppMode appMode = _getCurrentMode();

  static AppMode _getCurrentMode() {
    AppMode _mode;

    bool isDebug = false;
    assert(isDebug = true);

    if (isDebug) {
      _mode = AppMode.DEBUG;
    } else if (const bool.fromEnvironment("dart.vm.product")) {
      _mode = AppMode.RELEASE;
    } else {
      _mode = AppMode.PROFILE;
    }

    return _mode;
  }
}
