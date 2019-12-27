import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_project/config.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> initApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (FlutterErrorDetails details) async {
    Zone.current.handleUncaughtError(details.exception, details.stack);
    //TODO Log to Crashlytics
  };

  await runZoned<Future<Null>>(
    () async {
      runApp(EasyLocalization(child: App()));
    },
    onError: (error, stackTrace) async {
      if (Config.appMode == AppMode.RELEASE) {
        //TODO Log Error event
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
    var data = EasyLocalizationProvider.of(context).data;
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
