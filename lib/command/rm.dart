import 'dart:io';

import 'package:args/command_runner.dart';

import 'package:deltazx_authenticator/account.dart';

class RmCommand extends Command {
  @override
  String get name => 'rm';

  @override
  String get description => 'Remove account';

  @override
  void run() {
    final arguments = argResults!.arguments;

    if (arguments.isEmpty) {
      stderr.writeln('ERROR: No account name passed in.');
    } else if (arguments.length > 1) {
      stdout.writeln('WARNING: You have passed in multiple arguments, only the first argument will be used.');
      Account.deleteAccount(arguments.first);
    } else {
      Account.deleteAccount(arguments.first);
    }
  }

}