import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_project/src/app_update/app_update_key_provider.dart';
import 'package:flutter_base_project/src/remote_config/remote_config_repository.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

enum UpdateMode { NoUpdate, FlexibleUpdate, ImmediateUpdate }

class AppUpdateWidget extends StatefulWidget {
  @override
  _AppUpdateWidgetState createState() => _AppUpdateWidgetState();
}

class _AppUpdateWidgetState extends State<AppUpdateWidget> {
  @override
  void initState() {
    super.initState();
    promptAppUpdate(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

Future<void> promptAppUpdate(BuildContext context) async {
  final update = await checkAppUpdate(
    remoteConfigRepository: RemoteConfigRepository(),
  );

  if (update == UpdateMode.NoUpdate) {
    return null;
  }

  if (update == UpdateMode.FlexibleUpdate) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text('New App Update Available'),
        action: SnackBarAction(
          label: 'Update',
          onPressed: () => openStore(),
        ),
      ),
    );
  }

  if (update == UpdateMode.ImmediateUpdate) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text('New Update available'),
          content: Text('Update App to keep using features.'),
          actions: <Widget>[
            FlatButton(
              child: Text('UPDATE'),
              onPressed: () => openStore(),
            )
          ],
        );
      },
    );
  }
}

Future<UpdateMode> checkAppUpdate({
  @required RemoteConfigRepository remoteConfigRepository,
}) async {
  final keyProvider = platformKeyProvider();

  final currentVersion = int.parse(await getCurrentAppVersion());
  final latestStableVersion = int.parse(
    await remoteConfigRepository.getString(
      keyProvider.keyLatestStableVersion,
    ),
  );
  final latestVersion = int.parse(
    await remoteConfigRepository.getString(
      keyProvider.keyLatestVersion,
    ),
  );

  if (currentVersion >= latestVersion) {
    return UpdateMode.NoUpdate;
  }

  if (currentVersion < latestStableVersion) {
    return UpdateMode.ImmediateUpdate;
  }

  return UpdateMode.FlexibleUpdate;
}

Future<String> getCurrentAppVersion() async {
  final packageInfo = await PackageInfo.fromPlatform();
  return packageInfo.buildNumber;
}

Future<void> openStore() async {
  String url;
  if (Platform.isAndroid) {
    url =
        "https://play.app.goo.gl/?link=https://play.google.com/store/apps/details?id=com.eonian.reelo&ddl=1&pcampaignid=web_ddl_1";
  } else if (Platform.isIOS) {
    url = "https://apps.apple.com/in/app/reelo-get-rewarded/id1195820317";
  }
  if (await canLaunch(url)) {
    await launch(url);
  }
}
