import 'dart:io';

import 'package:args/command_runner.dart';

import '../account.dart';

class ListCommand extends Command {
  @override
  String get name => 'list';

  @override
  String get description => 'View added accounts.';

  ListCommand() {
    argParser.addOption("prefix", abbr: "p", help: "Specify the path to save the Account.");
  }

  @override
  void run() {
    if (_list(argResults!["prefix"]).isEmpty) {
      stderr.writeln('ERROR: No such account.');
      exit(1);
    } else {
      _list(argResults!["prefix"]).forEach((element) => print(element));
    }
  }

  List<String> _list([String? prefix]) {
    final accountList = Account(prefix).accountList;
    return accountList;
  }
}
