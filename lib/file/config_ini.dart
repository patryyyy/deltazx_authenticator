import 'dart:io';

import 'package:ini/ini.dart';

import 'package:deltazx_authenticator/file/path.dart';

class ConfigINI {
  factory ConfigINI() {
    if (_configINI == null) {
      ConfigINI._configINI = ConfigINI._newSelf();
    }
    return ConfigINI._configINI!;
  }

  static ConfigINI? _configINI;

  ConfigINI._newSelf();

  static File file = new File("${Path.location}/config.ini");
  
  void add({required String name, required String option, required String value}) {
    if (file.existsSync() == false) {
      file.createSync(recursive: true);
      Config config = new Config();
      config.addSection(name);
      config.set(name, option, value);
      file.writeAsStringSync(config.toString());
    } else {
      Config config = new Config.fromStrings(file.readAsLinesSync());
      if (config.hasSection(name) == false) {
        config.addSection(name);
        config.set(name, option, value);
        file.writeAsStringSync(config.toString());
      } else {
        config.set(name, option, value);
        file.writeAsStringSync(config.toString());
      }
    }
  }

  void delete(String option) {
    if (file.existsSync() == false) {
      stderr.writeln('No such account');
    } else {
      Config config = new Config.fromStrings(file.readAsLinesSync());
      if (exist() == false) {
        stderr.writeln('No such account');
      } else if (config.hasOption('secret', option) == false) {
        stderr.writeln('No such account');
      }
      else {
        config.removeOption('secret', option);
        file.writeAsStringSync(config.toString());
      }
    }
  }

  static bool exist() {
    if (file.existsSync() == false) {
      return false;
    } else {
      Config config = new Config.fromStrings(file.readAsLinesSync());
      var temp = config.items('secret');
      return temp!.isNotEmpty;
    }
  }
}