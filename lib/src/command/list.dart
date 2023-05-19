import 'dart:io';

import 'package:args/command_runner.dart';

import '../account.dart';

class ListCommand extends Command {
  @override
  String get name => 'list';

  @override
  String get description => 'View added accounts';

  @override
  void run() {
    final accountList = Account().accountList;;
    if (accountList.isEmpty) {
      stderr.writeln('ERROR: No such account.');
      exit(1);
    } else {
      accountList.forEach((element) => print(element));
    }
  }
}
