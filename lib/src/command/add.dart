import 'dart:io';

import 'package:args/command_runner.dart';

import '../account.dart';

class AddCommand extends Command {
  @override
  String get name => 'add';

  @override
  String get description => 'Add account';

  @override
  void run() {
    final arguments = argResults!.arguments;
    
    if (arguments.isEmpty) {
      stderr.writeln('ERROR: No key passed in.');
    } else if (arguments.length > 1) {
      stdout.writeln('WARNING: You have passed in multiple arguments, only the first argument will be used.');
      add(arguments.first);
    } else {
      add(arguments.first);
    }
  }

  void add(String secret) {
    Account account = Account();
    stdout.write('What name would you like to take? ');
    String name = stdin.readLineSync()!;
    account.add(name.trim(), secret);
  }
}