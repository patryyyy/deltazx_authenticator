import 'package:args/command_runner.dart';

class VersionCommand extends Command {
  @override
  String get name => 'version';

  @override
  String get description => 'View version';

  @override
  void run() {
    print('DeltaZX_Authenticator version 1.0.0');
  }

}