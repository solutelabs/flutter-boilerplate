import 'dart:io' show Platform;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_project/app_constants.dart';
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
        content: Text(AppLocalizations.of(context).tr('flexible_update_msg')),
        action: SnackBarAction(
          label: AppLocalizations.of(context).tr('btn_update'),
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
          title:
              Text(AppLocalizations.of(context).tr('title_immediate_update')),
          content:
              Text(AppLocalizations.of(context).tr('content_immediate_update')),
          actions: <Widget>[
            FlatButton(
              child: Text(AppLocalizations.of(context).tr('btn_update')),
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
    url = androidPlayStoreUrl;
  } else if (Platform.isIOS) {
    url = iosAppStoreUrl;
  }
  if (await canLaunch(url)) {
    await launch(url);
  }
}
