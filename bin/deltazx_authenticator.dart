import 'dart:io';

import 'package:deltazx_authenticator/deltazx_authenticator.dart';

void main(List<String> args) {
  if (args.isNotEmpty) {
    Args.parseArgs(args);
  } else {
    printVerificationCode();
  }
}

void printVerificationCode() {
  Account account = Account();
  if (account.exist()) {
    Ini config = Ini(account.prefix);

    stdout.write('\x1b[H\x1b[2J');

    List<String> accountList = account.accountList;

    while (true) {
      for (var i = accountList.length; i > 0; i--) {
        String key = config.get('account', accountList[accountList.length - i]);

        stdout.write('${accountList[accountList.length - i]}:\t${GenerateVerificationCode.verificationCode(EncryptSecret.decodeData(key))}\n');
      }
      sleep(Duration(seconds: 2));
      stdout.write('\x1b[H\x1b[2J');
    }
  }
}