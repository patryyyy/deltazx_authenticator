import 'dart:io';

import 'package:args/command_runner.dart';

import 'package:deltazx_authenticator/account.dart';

class AddCommand extends Command {
  @override
  String get name => 'add';

  @override
  String get description => 'Add account';

  @override
  void run() {
    final arguments = argResults!.arguments;

    if (arguments.isEmpty) {
      stderr.writeln('Error: No key passed in.');
    } else if (arguments.length > 1) {
      stdout.write('Warning: You have passed in multiple arguments, only the first argument will be used\n');
      Account.addAccount(arguments.first);
    } else {
      Account.addAccount(arguments.first);
    }
  }

}