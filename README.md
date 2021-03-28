# Flutter base Scaffold Project

This is a base flutter scaffold project that has all configuration & setup created. So we can reduce the efforts of basic project setup & project level boilerplate code.

## Features 

### Flavors (Flutter + Native)
Production, Staging, Development (with abstract properties)
Modes: Debug, Release, Profile.

### Localization
Localization support based on [Easy Localization](https://pub.dev/packages/easy_localization)

### Custom Logger (Default Crashlytics)
Abstract layer for a custom logger. It has default implementation of [Crashlytics](https://firebase.google.com/products/crashlytics/).
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

### CI / CD

#### Codemagic

Codemagic.yaml file has been added at the root of source code. It contains sample pipeline for Development build.

###### How to build?

1. Connect the project repository to codemagic using [this guide](https://docs.codemagic.io/getting-started/adding-apps-from-custom-sources/). Codemagic will auto-detect the yaml file which has sample workflow added.
2. Select workflow and the branch from which buid to be generated. Start Build and it should generate the builds for Android & iOS.

###### What to be configured?

1. **Android**
- Except `production-store` workflow, all the workflows are configured to use Debug keystore generated on the fly from Codemagic's build machine.
- For `production-store` workflow, the keystore related environment variables must be replaced with the project specific keystore info.

2. **iOS**
- Code Signing assets like Certificates, Profiles, etc. needs to be changed based on project's bundle ids and environments. [More info](https://docs.codemagic.io/code-signing-yaml/signing-ios/#manual-code-signing)
- For code signing profiles, following is recommended:
- Local distribution (QA, Client Releases, etc) - `adhoc` profiles
- Store / TestFlight distribution - `appstore` profiles.

###### How to distribute?
Once codemagic generates the artifacts, we can distribute the apps in various ways.

1. Using Firebase App Distribution. [More info](https://firebase.google.com/docs/app-distribution).
One can automate the firebase distribution as mentioned [here](https://docs.codemagic.io/publishing-yaml/distribution/#publishing-an-app-to-firebase-app-distribution).
2. Using platforms like [Diawi](https://www.diawi.com/)
3. Sharing raw apk and ipa to user.
