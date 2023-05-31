import 'dart:io';

import '../lib/src/info/version.dart';

void main() {
  switch (Platform.operatingSystem) {
    case "windows":
      if (Windows.isX64) {
        Builder(Windows()).buildApp(version, "x64");
      }
      else if (Windows.isARM64) {
        Builder(Windows()).buildApp(version, "arm64");
      }
      break;
    case "linux":
      if (Linux.isX64) {
        Builder(Linux()).buildApp(version, "x64");
      }
      else if (Linux.isARM64) {
        Builder(Linux()).buildApp(version, "arm64");
      }
      else if (Linux.isRISCV) {
        Builder(Linux()).buildApp(version, "riscv64");
      }
      break;
    case "macos":
      if (MacOS.isX64) {
        Builder(MacOS()).buildApp(version, "x64");
      }
      else if (MacOS.isARM64) {
        Builder(MacOS()).buildApp(version, "arm64");
      }
      break;
    case "android":
      if (Android.isARM64) {
        Builder(Android()).buildApp(version, "arm64");
      }
      break;
  }

}

class Builder {
  final BuildStrategy buildStrategy;

  Builder(this.buildStrategy);

  void buildApp(String version, String arch) {
    print(Platform.version);
    print(Process.runSync('dart', ['pub', 'get']).stdout.toString());
    this.buildStrategy.build(version, arch);
  }
}

abstract class BuildStrategy {
  void build(String version, String arch);
}

class Windows implements BuildStrategy {
  static bool get isX64 {
    return Platform.version.contains("x64");
  }

  static bool get isARM64 {
    return Platform.version.contains("arm64");
  }

  @override
  void build(String version, String arch) {
    Directory('build').createSync(recursive: true);
    Process.runSync('dart', ['compile','exe','bin/deltazx_authenticator.dart','-o','build/dau-$version-windows-$arch.exe']);
  }
}

class Linux implements BuildStrategy {
  static bool get isX64 {
    return Platform.version.contains("x64");
  }

  static bool get isARM64 {
    return Platform.version.contains("arm64");
  }

  static bool get isRISCV {
    return Platform.version.contains("riscv64");
  }

  @override
  void build(String version, String arch) {
    Directory('build').createSync(recursive: true);
    Process.runSync('dart', ['compile','exe','bin/deltazx_authenticator.dart','-o','build/dau-$version-linux-$arch']);
  }
}

class MacOS implements BuildStrategy {
  static bool get isX64 {
    return Platform.version.contains("x64");
  }

  static bool get isARM64 {
    return Platform.version.contains("arm64");
  }
  
  @override
  void build(String version, String arch) {
    Directory('build').createSync(recursive: true);
    Process.runSync('dart', ['compile','exe','bin/deltazx_authenticator.dart','-o','build/dau-$version-macos-$arch']);
  }

}

class Android implements BuildStrategy {
  static bool get isARM64 {
    return Platform.version.contains("arm64");
  }

  @override
  void build(String version, String arch) {
    Directory('build').createSync(recursive: true);
    Process.runSync('dart', ['compile','exe','bin/deltazx_authenticator.dart','-o','build/dau-$version-android-$arch']);
  }
}