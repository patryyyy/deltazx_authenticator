import 'dart:io';

import 'package:path/path.dart';

class Path {
  static String get userHome {
    Map<String, String> env = Platform.environment;

    try {
      if (Platform.isWindows) {
        return env['USERPROFILE']!;
      } else if (Platform.isLinux || Platform.isMacOS || Platform.isAndroid) {
        return env['HOME']!;
      }
    } catch (e) {}

    return "~";
  }

  static String get location {
    return join(userHome, '.dau');
  }
}
