import 'dart:io';

class DevUtils {
  DevUtils._();

  static Directory get executableDir =>
      File(Platform.resolvedExecutable).parent;

  static String env = "${DevUtils.executableDir.path}/env.json";
  static String settings = "assets/settings/settings.json";

  static String readJson(String s) {
    return File(s).readAsStringSync();
  }
}
