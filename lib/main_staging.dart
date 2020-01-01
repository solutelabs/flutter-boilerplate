import 'dart:async';

import 'package:flutter_base_project/src/app.dart';
import 'package:flutter_base_project/config.dart';

Future<void> main() async {
  Config.appFlavor = Staging();
  await initApp();
}
