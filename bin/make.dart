import 'dart:io';

void main() {
  if (Platform.isWindows) {
    if (build.isX64()) {
      build('1.0.0', 'windows', 'amd64', '.exe');
    }
  }
  else if (Platform.isLinux) {
    if (build.isX64()) {
      build('1.0.0', 'linux', 'amd64', '');
    }
  }
  else if (Platform.isMacOS) {
    if (build.isX64()) {
      build('1.0.0', 'darwin', 'amd64', '');
    }
  }
}

class build {
  build(String version, String platform, String architecture, String fileExtension) {
    Directory('./build').createSync();
    Process.runSync('dart', ['pub', 'get']);
    Process.runSync('dart', ['compile','exe','bin/deltazx_authenticator.dart','-o','build/dau-$version-$platform-$architecture'+'$fileExtension']);
  }

  static bool isX64() {
    print(Process.runSync('dart', ['--version']).stdout.toString());
    return Process.runSync('dart', ['--version']).stdout.toString().contains('x64');
  }
}