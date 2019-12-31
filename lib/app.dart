import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_project/analytics/analytics.dart';
import 'package:flutter_base_project/config.dart';
import 'package:flutter_base_project/error_logger/error_logger.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> initApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  Crashlytics.instance.enableInDevMode = false;
  FlutterError.onError = Crashlytics.instance.recordFlutterError;

  await runZoned<Future<Null>>(
    () async {
      runApp(EasyLocalization(child: App()));
    },
    onError: (error, stackTrace) async {
      if (Config.appMode == AppMode.RELEASE) {
        await Crashlytics.instance.recordError(error, stackTrace);
        await getErrorLogger().logEvent(
          exception: error,
          stackTrace: stackTrace,
        );
      }
    },
  );
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    final data = EasyLocalizationProvider.of(context).data;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //TODO Change App Title
      title: 'Flutter Demo',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        EasylocaLizationDelegate(
          locale: data.locale ?? Locale('en', 'US'),
          path: 'lib/assets/strings',
        ),
      ],
      supportedLocales: [
        Locale('en', 'US'),
      ],
      navigatorObservers: [
        navigationObserverAnalytics(),
      ],
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Center(
          child: Builder(
            builder: (context) => Text(
              AppLocalizations.of(context).tr('welcome_message'),
            ),
          ),
        ),
      ),
    );
  }
}
