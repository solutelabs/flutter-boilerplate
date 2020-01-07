# Flutter base Scaffold Project

This is a base flutter scaffold project that has all configuration & setup created. So we can reduce the efforts of basic project setup & project level boilerplate code.

## Features 

### Flavors (Flutter + Native)
Production, Staging, Development (with abstract properties)
Modes: Debug, Release, Profile.

### Localization
Localization support based on [Easy Localization](https://pub.dev/packages/easy_localization)

### Custom Logger (Default Sentry)
Abstract layer for a custom logger. It has default implementation of [Sentry](https://sentry.io/welcome/).
It can again be replaced with any other services.

### Firebase Crashalytics
Crashalytics setup that works in Release and Profile Mode.

### Analytics (Default Firebase)
Abstract layer for a Custom event logging. It has a default implementation of Firebase Analytics. It can again be replaced with any other services.

### Firebase Performance Monitor
Firebase performance integration to check App freezing, network latency monitoring. (Integrated firebase_performance_interceptor)

### Remote Config
Integration of firebase remote config.

### Pedantic
Analysis_options setup for strict lint checks.

### Flavor-wise installable build
Flavor-wise application-id overridden. So that the same application with different flavors can be installed simultaneously.

### App Update Prompts (Flexible + Immediate)
Force upgrade setup based on Firebase Remote config.

Currently, it has two configuration
1. Latest App Version (Build Number)
2. Latest Stable App Version (Build Number)

If the latest app version is higher then the current version, it will trigger Flexible Update (Snackbar Prompt).

If the current app version is below the latest stable version, then it will trigger an Immediate (Force) update.

### Other Useful dependencies
- [Connectivity](https://pub.dev/packages/connectivity)
- [Shared Preferences](https://pub.dev/packages/shared_preferences)
- [Path Provider](https://pub.dev/packages/path_provider)
- [Provider](https://pub.dev/packages/provider)
- [Permission Handler](https://pub.dev/packages/permission_handler)
- [Cached Network Image](https://pub.dev/packages/cached_network_image)