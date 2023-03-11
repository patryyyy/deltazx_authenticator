import 'dart:io';

import 'package:ini/ini.dart';

import 'package:deltazx_authenticator/args.dart';
import 'package:deltazx_authenticator/file/config_ini.dart';
import 'package:deltazx_authenticator/generate_verification_code.dart';
import 'package:deltazx_authenticator/secret.dart';
import 'package:deltazx_authenticator/encrypt.dart';

void main(List<String> arguments) {
  if (Arguments.setArguments(arguments)) {
    Arguments.args();
  } else {
    if (ConfigINI.exist()) {
      Config config = Config.fromStrings(ConfigINI.file.readAsLinesSync());
      Secret secret = Secret();
      stdout.write("\x1b[H\x1b[2J");
      List<String> list = secret.searchSecret();


      while (true) {
        for (var i = list.length; i > 0; i--) {
          String key = config.get('secret', list[list.length - i])!;

          stdout.write(
              "${list[list.length - i]}:\t${GenerateVerificationCode.verificationCode(EncryptSecret.decodeData(key))}\n");
        }
        sleep(Duration(seconds: 2));
        stdout.write("\x1b[H\x1b[2J");
      }
    }
  }
}
