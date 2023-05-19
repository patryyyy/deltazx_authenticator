import 'dart:io';

final RegExp _isRight = RegExp(r'^(?=.*[a-zA-Z])(?=.*\d).{10,}$');

class Input {

  static String get inputPassword {
    stdout.write('Please input a password: ');
    String _password = stdin.readLineSync()!;

    while (true) {
      if (_isRight.hasMatch(_password)) {
        break;
      } else {
        stdout.writeln('The password must contain at least letters and numbers and be greater than 10 digits, Please re-enter:');
        _password = stdin.readLineSync()!;
      }
    }
    return _password;
  }
}

// 参考：
// https://www.cnblogs.com/tinymad/p/15836480.html