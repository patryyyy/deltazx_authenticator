import 'dart:io';
import 'dart:convert';

import 'package:encrypt/encrypt.dart';
import 'package:sm_crypto/sm_crypto.dart';

import 'input.dart';

final _String_key = SM4.createHexKey(key: _temp_key);
final _String_iv  = _temp_iv;
final _temp1 = utf8.encode('85F9#&&9947CB24821EC%^&*512A617AF4EB5641${_temp2}236DEB09474*p&^^045F7FF3AFA?|{43E90E19E');
final _temp2 = utf8.encode('iuhesy8f${Input.inputPassword}0x6724Y');
final _temp_key = SM3.encryptBytes(_temp2);
final _temp_iv = _cut(SM3.encryptBytes(_temp1));

String _cut(String iv) {
  String temp = iv.substring(iv.length - 9, iv.length) + iv.substring(iv.length - 37,iv.length -30);
  return temp;
}

class EncryptSecret {
  static String encodeData(String data) {
    final key = Key.fromUtf8(_String_key);
    final iv = IV.fromUtf8(_String_iv);
    final encryptor = Encrypter(AES(
      key,
      mode: AESMode.cbc,
    ));

    final encrypted = encryptor.encrypt(data, iv: iv);
    return encrypted.base64;
  }

  static String decodeData(String data) {
    final key = Key.fromUtf8(_String_key);
    final iv = IV.fromUtf8(_String_iv);

    final encryptor = Encrypter(AES(
      key,
      mode: AESMode.cbc,
    ));

    try {
      final decrypted = encryptor.decrypt(Encrypted.fromBase64(data), iv: iv);
      return decrypted;
    } catch (err) {
      stderr.writeln('ERROR: Authentication failure.');
      exit(1);
    }

  }
}

// 参考：
// https://blog.csdn.net/Wbl752134268/article/details/117460608
// https://juejin.cn/post/7182079389624959013