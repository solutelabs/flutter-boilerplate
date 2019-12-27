import 'dart:async';

import 'package:flutter_base_project/config.dart';
import 'package:flutter_base_project/app.dart';

Future<void> main() async {
  Config.appFlavor = Development();
  await initApp();
}
