import 'package:flutter/foundation.dart';
import 'package:flutter_base_project/src/app_update/app_update_key_provider.dart';
import 'package:flutter_base_project/src/remote_config/remote_config_repository.dart';
import 'package:package_info/package_info.dart';

enum UpdateMode { NoUpdate, FlexibleUpdate, ImmediateUpdate }

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
