import 'dart:io';

import 'package:ini/ini.dart';

import 'package:deltazx_authenticator/file/config_ini.dart';
import 'package:deltazx_authenticator/encrypt.dart';

class Account {
  static void addAccount(String secret) {
    ConfigINI configINI = new ConfigINI();
    Config config = Config();
    stdout.write('What name would you like to take? ');
    String str = stdin.readLineSync()!;
    if (config.hasOption('account', str)) {
      stderr.writeln('Account already exists');
      return;
    }

    configINI.add(name: 'account', option: str, value: EncryptSecret.encodeData(secret));
  }

  static List<String> get searchAccount {
    if (ConfigINI.exist() == false) return [];

    List<String> list = [];

    Config config = Config.fromStrings(ConfigINI.file.readAsLinesSync());
    if (config.items('account')!.isEmpty) {
      stderr.writeln('No such account');
    } else {
      for (var i = 0;i < config.items('account')!.length; i++) {
        list.add(config.items('account')![i][0]!);
      }
    }
    return list;
  }

  static void deleteAccount(String name) {
    ConfigINI configINI = ConfigINI();
    configINI.delete(name);
  }
}