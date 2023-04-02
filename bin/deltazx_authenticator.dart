import 'dart:io';

import 'package:ini/ini.dart';

import 'package:deltazx_authenticator/args.dart';
import 'package:deltazx_authenticator/file/config_ini.dart';
import 'package:deltazx_authenticator/generate_verification_code.dart';
import 'package:deltazx_authenticator/account.dart';
import 'package:deltazx_authenticator/encrypt.dart';

void main(List<String> args) {
  if (args.isNotEmpty) {
    Args.parseArgs(args);
  } else {
    printVerificationCode();
  }
}

void printVerificationCode() {
  if (ConfigINI.exist()) {
    Config config = Config.fromStrings(ConfigINI.file.readAsLinesSync());
    stdout.write('\x1b[H\x1b[2J');

    List<String> accountList = Account.searchAccount;


    while (true) {
      for (var i = accountList.length; i > 0; i--) {
        String key = config.get('account', accountList[accountList.length - i])!;

        stdout.write('${accountList[accountList.length - i]}:\t${GenerateVerificationCode.verificationCode(EncryptSecret.decodeData(key))}\n');
      }
      sleep(Duration(seconds: 2));
      stdout.write('\x1b[H\x1b[2J');
    }
  }
}