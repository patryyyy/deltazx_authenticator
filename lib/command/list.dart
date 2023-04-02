import 'dart:io';

import 'package:args/command_runner.dart';

import 'package:deltazx_authenticator/account.dart';

class ListCommand extends Command {
  @override
  String get name => 'list';

  @override
  String get description => 'View added accounts';

  @override
  void run() {
    final accountList = Account.searchAccount;
    if (accountList.isEmpty) {
      stderr.writeln('ERROR: No such account.');
    } else {
      accountList.forEach((element) => print(element));
    }
  }
}
