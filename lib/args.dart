import 'dart:io';

import 'package:args/command_runner.dart';

import 'package:deltazx_authenticator/command/_export.dart';

class Args extends CommandRunner {
  Args(super.executableName, super.description);

  @override
  Never usageException(String message) {
    stderr.writeln('ERROR: \'${_args.first}\' is not a dau command.');
    exit(1);
  }

  static var _args = [];

  static void parseArgs(List<String> args) {
    _args = args;

    final runner = Args('dau', 'A simple Two-factor Authenticator written in Dart.')
      ..addCommand(AddCommand())
      ..addCommand(ListCommand())
      ..addCommand(RmCommand())
      ..addCommand(VersionCommand());

    runner.run(args);
  }
}

// 参考:
// https://www.youtube.com/watch?v=kcF-cakpNo8
