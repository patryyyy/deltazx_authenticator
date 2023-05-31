import 'dart:io';

import 'package:args/args.dart';
import 'package:args/command_runner.dart';

import 'command/export.dart';

class Args {
  static var _runner = CommandRunner(
      'dau', 'A simple Two-factor Authenticator written in Dart.');
  static List<String> _args = [];

  static void parseArgs(List<String> args) {
    _args = args;

    _runner
      ..addCommand(AddCommand())
      ..addCommand(ListCommand())
      ..addCommand(RmCommand())
      ..addCommand(VersionCommand())
      ..addCommand(GenCommand());

    _runner.run(args).catchError((error) {
      if (error is! UsageException) throw error;
      print(error);
      exit(64);
    });
  }

  static ArgResults get results {
    return _runner.parse(_args);
  }
}

// 参考:
// https://www.youtube.com/watch?v=kcF-cakpNo8
