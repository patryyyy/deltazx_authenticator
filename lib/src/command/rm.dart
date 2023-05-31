import 'dart:io';

import 'package:args/command_runner.dart';

import '../account.dart';

class RmCommand extends Command {
  @override
  String get name => 'rm';

  @override
  String get description => 'Remove account.';

  RmCommand() {
    argParser.addOption("prefix", abbr: "p", help: "Specify the path to save the Account.");
  }

  @override
  void run() {
    final arguments = argResults!.rest;

    if (arguments.isEmpty) {
      stderr.writeln('ERROR: No account name passed in.');
      exit(1);
    } else if (arguments.length > 1) {
      stdout.writeln(
          'WARNING: You have passed in multiple arguments, only the first argument will be used.');
      _delete(arguments.first, argResults!["prefix"]);
    } else {
      _delete(arguments.first, argResults!["prefix"]);
    }
  }

  void _delete(String name, [String? prefix]) {
    Account account = Account(prefix);
    account.delete(name);
  }
}
