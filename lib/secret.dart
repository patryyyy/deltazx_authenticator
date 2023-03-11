import 'dart:io';

import 'package:ini/ini.dart';

import 'package:deltazx_authenticator/file/config_ini.dart';
import 'package:deltazx_authenticator/encrypt.dart';
import 'package:deltazx_authenticator/args.dart';

class Secret {
  void addSecret() {
    if (Arguments.getArgumentsResult['secret'] == null) {
      return;
    }

    String secret = Arguments.getArgumentsResult['secret'];

    ConfigINI configINI = new ConfigINI();
    Config config = Config();
    stdout.write('What name would you like to take? ');
    String str = stdin.readLineSync()!;
    if (config.hasOption('secret', str)) {
      print('Account already exists');
      return;
    }
    
    configINI.add(name: 'secret', option: str, value: EncryptSecret.encodeData(secret));
  }

  List<String> searchSecret() {
    if (ConfigINI.exist() == false) return [];

    List<String> list = [];

    Config config = Config.fromStrings(ConfigINI.file.readAsLinesSync());
    if (config.items('secret')!.isEmpty) {
      print('No account added');
    } else {
      for (var i = 0;i < config.items('secret')!.length; i++) {
        list.add(config.items('secret')![i][0]!);
      }
    }
    return list;
  }

  void deleteSecret() {
    if (Arguments.getArgumentsResult['delete'] == null) {
      return;
    }

    String value = Arguments.getArgumentsResult['delete'];

    ConfigINI configINI = ConfigINI();
    configINI.delete(value);
  }
}