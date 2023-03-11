import 'package:args/args.dart';

import 'package:deltazx_authenticator/secret.dart';

class Arguments {
  static var _parser = ArgParser();

  // 参数
  static List<String>? _arguments;

  static bool setArguments(List<String> arguments) {
    if (arguments.length != 0) {
      _arguments = arguments;
      return true;
    } else {
      return false;
    }
  }

  static ArgResults get getArgumentsResult {
    return _parser.parse(_arguments!);
  }

  static void args() {
    Secret secret = Secret();

    _parser.addFlag('version', abbr: 'v', help: "View Version", negatable: false);
    _parser.addFlag('help', abbr: 'h', help: "View Help", negatable: false);
    _parser.addOption('secret', abbr: 's', help: 'Add account');
    _parser.addFlag('list', abbr: 'l', help: "View added accounts", negatable: false);
    _parser.addOption('delete', abbr: 'd', help: 'Delete account');

    var result = getArgumentsResult;

    // 打印Help
    if (result['help']) {
      print('''
Help:
${_parser.usage}
    ''');
    }
    // 打印version
    else if (result['version']) {
      print('DeltaZX_Authenticator version 1.0.0');
    } else if (result['list']) {
      Secret secret = Secret();
      if (secret.searchSecret().isEmpty) {
        print('No such account');
      } else {
        secret.searchSecret().forEach((element) => print(element));
      }
    }
    secret.addSecret();
    secret.deleteSecret();
  }
}

// 参考:
// https://www.jianshu.com/p/8a7f2cbac7a1
// https://juejin.cn/post/6917899863489265672
