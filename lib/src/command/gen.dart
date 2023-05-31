import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:dart_console/dart_console.dart';

import '../account.dart';
import '../info/info.dart';
import '../config/ini.dart';
import '../generate_verification_code.dart';
import '../encrypt.dart';

class GenCommand extends Command {
  @override
  String get name => "gen";

  @override
  String get description => "Generate verification code.";

  GenCommand() {
    argParser.addOption("prefix",
        abbr: "p", help: "Specify the path to save the Account.");
  }

  @override
  void run() {
    final arguments = argResults!.rest;

    _printVerificationCode(argResults!["prefix"]);
  }

  void _printVerificationCode([String? prefix]) {
    Account account = Account(prefix);
    Ini config = Ini(account.prefix);
    Console console = Console();

    final accountList = account.accountList;

    Timer.periodic(Duration(seconds: 1), (timer) {
      final now = DateTime.now().millisecondsSinceEpoch;
      const timeStep = 30;
      final remainingTime = ((timeStep * 1000) - (now % (timeStep * 1000))) ~/ 1000;

      console.clearScreen();
      console.writeLine("dau - A simple Two-factor Authentication.", TextAlignment.center);

      int maxNameLength = 0;
      accountList.forEach((element) {
        if (element.length > maxNameLength) {
          maxNameLength = element.length;
        }
      });

      accountList.forEach((element) {
        try {
          String name = element;
          String secret = config.get(sectionName, name);
          String code = GenerateVerificationCode.verificationCode(EncryptSecret.decodeData(secret));
          String str = "$name:${code.padLeft(maxNameLength - name.length + 4 + code.length)}  (${remainingTime}s)\n";

          console.write(str);
        } catch (e) {
          stderr.writeln("ERROR: Unknown error.");
          exit(1);
        }
      });
    });
  }
}
