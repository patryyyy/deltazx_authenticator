import 'dart:io';

import 'package:deltazx_authenticator/file/config_ini.dart';


class Input {
  static RegExp _isRight = RegExp(r'^(?=.*[a-zA-Z])(?=.*\d).{10,}$');

  static String? _password;

  static String inputPassword() {
    // stdin.echoMode = false;

    // 如果不存在就设置密码
    if (ConfigINI.exist() == false) {
      stdout.write("Please input a password: ");
      _password = stdin.readLineSync();
      // stdout.write('\n');

      while (true) {
        if (_isRight.hasMatch(_password!)) {
          break;
        } else {
          stdout.write('The password must contain at least letters and numbers and be greater than 10 digits, Please re-enter: \n');
          _password = stdin.readLineSync();
        }
      }
    } else {
      stdout.write("Please input a password: ");
      _password = stdin.readLineSync();
    }
    return _password!;
  }
}

// 参考：
// https://www.cnblogs.com/tinymad/p/15836480.html