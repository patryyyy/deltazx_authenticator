import 'dart:io';

import 'package:path/path.dart';

class Path {
  String? name;
  String? value;

  static String get location {
    Map<String, String> env = Platform.environment;

    if (Platform.isWindows) {
      var userHome = env['USERPROFILE'];
      return join(userHome!,'.deltazxapp','deltazx_authenticator');
    } else if (Platform.isLinux) {
      var userHome = env['HOME'];
      return join(userHome!,'.deltazxapp','deltazx_authenticator');
    }

    return "";
  }
}