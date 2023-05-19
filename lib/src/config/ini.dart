import 'dart:io';

typedef Section = Map<String, String>;

class Ini {
  Ini(String path) : this._path = path {
    load();
  }

  String _path;
  Map<String, Section> _sections = {};

  /// Load and parse the ini file.
  /// If parsing fails, it will throw an exception.
  void load() {
    File f = File(_path)..createSync(recursive: true);
    var line = f.readAsLinesSync();
    int lineCount = 0;
    String section = "";

    while (true) {
      if (lineCount == line.length) {
        break;
      }
      // 获取每一行，去除前后的空格
      var temp = line[lineCount].trim();

      // 匹配注释
      if (temp.startsWith(";") || line[lineCount].trim().isEmpty) {
        lineCount++;
      }
      // 匹配Section
      else if (temp.startsWith("[")) {
        int index = temp.indexOf("]");

        if (index != -1) {
          section = temp.substring(1, index);
          _sections[section] = Section();
          lineCount++;
        } else {
          throw IniException(
              "Failed to load ${_path} at line ${lineCount + 1}");
        }
      }
      // 匹配Key, Value
      else {
        int index = temp.indexOf("=");

        if (index != -1) {
          String key = temp.substring(0, index).trim();
          String value = temp.substring(index + 1).trim();
          if (section.isNotEmpty) {
            _sections[section]![key] = value;
            lineCount++;
          } else {
            throw IniException(
              "Failed to load ${_path} at line ${lineCount + 1}");
          }
        } else {
          throw IniException(
              "Failed to load ${_path} at line ${lineCount + 1}");
        }
      }
    }
  }

  /// Get the value corresponding to [key] in [section].
  /// If the [section] or [key] does not exist, it will throw an exception.
  String get(String section, String key) {
    if (!hasKey(section, key)) {
      throw IniException("The value does not exist");
    }
    return _sections[section]![key]!;
  }

  /// Set the [value] of [key] in the given [section].
  /// If the [section] does not exist, it will be created.
  void set(String section, String key, String value) {
    if (!hasSection(section)) {
      _sections[section] = Section();
    }
    _sections[section]![key] = value;
  }

  /// Get the Sections.
  Map<String, Section> items() {
    return _sections;
  }

  /// Get the items in the given [section].
  /// If the [section] does not exist, it will throw an exception.
  Section sectionItems(String section) {
    if (!hasSection(section)) {
      throw IniException("The section does not exist");
    }
    return _sections[section]!;
  }

  /// Remove the given [section].
  /// If the [section] does not exist, it will throw an exception.
  void removeSection(String section) {
    if (!hasSection(section)) {
      throw IniException("The section does not exist");
    }
    _sections.remove(section);
  }

  /// Remove the given [key] in the [section].
  /// If the [section] or [key] does not exist, it will throw an exception.
  void removeKey(String section, String key) {
    if (!hasKey(section, key)) {
      throw IniException("The key does not exist");
    }
    _sections[section]!.remove(key);
  }

  /// Given a [section], return whether it exists.
  bool hasSection(String section) {
    return _sections.containsKey(section);
  }

  /// Given a [section] and a [key], return whether it exists.
  bool hasKey(String section, String key) {
    return _sections[section] == null ? false : _sections[section]!.containsKey(key);
  }

  /// Clear the Sections.
  void clear() {
    _sections.clear();
  }

  /// Returns the Sections is empty.
  bool get isEmpty {
    return _sections.isEmpty;
  }

  /// Write the Sections to file, without comment.
  /// If the [path] is not null, the file will be saved to the [path].
  /// If [description] is specified, it will be written in the header of the file.
  void write([String? path, String description = ""]) {
    var f = File(path == null ? this._path : path)..createSync(recursive: true);
    f.writeAsStringSync(this.toString());
  }

  /// Convert the Sections to [String].
  /// If the Sections is empty, it will throw an exception.
  @override
  String toString() {
    if (this.isEmpty) {
      throw IniException("The sections is empty");
    }
    StringBuffer str = StringBuffer();
    
    _sections.forEach((key, value) {
      str.writeln("[$key]");
      value.forEach((key, value) {
        str.writeln("$key = $value");
      });
    });
    
    return str.toString();
  }
}

class IniException implements Exception {
  String message;

  IniException(this.message);

  @override
  String toString() {
    return "IniException: $message";
  }
}

// 参考 https://www.bilibili.com/video/BV1io4y1A7wn, 使用Dart实现解析
// 参考 package:ini, 设计API, 文档注释
