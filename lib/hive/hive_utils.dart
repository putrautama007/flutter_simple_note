import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class HiveUtils {
  static initializeHive() async {
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    _setupHiveAdapter();
  }

  static closeHive() async {
    Hive.close();
  }

  static _setupHiveAdapter() {}
}
