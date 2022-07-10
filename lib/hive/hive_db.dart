import 'package:hive/hive.dart';
import 'package:japan_front/constants/service_constants.dart';
import 'package:japan_front/model/Progressing.dart';

class HiveDB {
  static Box<Map>? _box;
  static Box<String>? _likedBox;
  static Box<Progressing>? _jlptProgressing;
  static HiveDB? _instance;

  static HiveDB get instance {
    if (_instance == null) {
      _instance = HiveDB();
    }
    return _instance!;
  }

  static Future<void> init() async {
    Hive.registerAdapter(ProgressingAdapter());
    _jlptProgressing = await Hive.openBox(progressHiveDB);
  }

  void addProgressing(Progressing progressing) {
    print('addProgreesing');
    _jlptProgressing!.put(progressing.level, progressing);
  }

  Map getProgressingAll() {
    return _jlptProgressing!.toMap();
  }

  void deleteProgressingAll() {
    print("delete");
    _jlptProgressing!.deleteFromDisk();
  }

  Map getLiked() {
    return _likedBox!.toMap();
  }

  void addtoLiked(String key, String value) {
    _likedBox!.put(key, value);
  }

  void removefromLiked(String key) {
    _likedBox!.delete(key);
  }

  void put(String key, Map value) {
    _box!.put(key, value);
  }

  void remove(String key) {
    _box!.delete(key);
  }

  dynamic get(String key) {
    return _box!.get(key);
  }

  dynamic containsKey(String key) {
    return _box!.containsKey(key);
  }

  Map getAll() {
    return _box!.toMap();
  }
}
