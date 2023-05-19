import 'dart:io';

import 'config/ini.dart';
import 'info/info.dart';
import 'info/path.dart';
import 'encrypt.dart';

class Account {
  Account([this._prefix]) {
    if (_prefix == null) {
      _prefix = "${Path.location}/config.ini";
    }
  }

  String? _prefix;

  void add(String name, String secret) {
    Ini config = Ini(_prefix!);
    if (config.hasKey(sectionName, name)) {
      stderr.writeln('ERROR: Account already exists.');
      exit(1);
    }

    config.set(sectionName, name, EncryptSecret.encodeData(secret));
    config.write();
  }

  List<String> get accountList {
    Ini config = Ini(_prefix!);
    if (!config.hasSection(sectionName)) {
      stderr.writeln('ERROR: No such account.');
      exit(1);
    }
    return config.sectionItems(sectionName).keys.toList();
  }

  void delete(String name) {
    Ini config = Ini(_prefix!);
    if (!config.hasKey(sectionName, name)) {
      stderr.writeln('ERROR: No such account.');
      exit(1);
    }
    config.removeKey(sectionName, name);
    config.write();
  }

  bool exist() {
    Ini config = Ini(_prefix!);
    return config.sectionItems(sectionName).isNotEmpty;
  }

  String get prefix {
    return _prefix!;
  }
}