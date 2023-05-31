import 'dart:io';

import 'package:args/command_runner.dart';

import '../account.dart';

class AddCommand extends Command {
  @override
  String get name => 'add';

  @override
  String get description => 'Add account.';

  AddCommand() {
    argParser.addOption("prefix", abbr: "p", help: "Specify the path to save the Account.");
  }
  
  @override
  void run() {
    final arguments = argResults!.rest;
    
    if (arguments.isEmpty) {
      stderr.writeln('ERROR: No secret passed in.');
      exit(1);
    } else if (arguments.length > 1) {
      stdout.writeln('WARNING: You have passed in multiple arguments, only the first argument will be used.');
      _add(arguments.first, argResults!["prefix"]);
    } else {
      _add(arguments.first, argResults!["prefix"]);
    }
  }

  void _add(String secret, [String? prefix]) {
    Account account = Account(prefix);
    stdout.write('What name would you like to take? ');
    String name = stdin.readLineSync()!;
    account.add(name.trim(), secret);
    print("The secret saved in \x1B[32m${account.prefix}\x1B[0m");
  }
}