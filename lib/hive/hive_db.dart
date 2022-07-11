import 'package:hive/hive.dart';
import 'package:japan_front/api/api.dart';
import 'package:japan_front/api/kangiNetwork.dart';
import 'package:japan_front/constants/service_constants.dart';
import 'package:japan_front/model/Kangi.dart';
import 'package:japan_front/model/Progressing.dart';
import 'package:http/http.dart' as http;

class HiveDB {
  static Box<Map>? _box;
  static Box<Kangi>? _kangiBox;
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
    Hive.registerAdapter(KangiAdapter());
    _kangiBox = await Hive.openBox(kangiHiveDB);
    _jlptProgressing = await Hive.openBox(progressHiveDB);
  }

// Kangis
  Map getKangiAll() {
    if (_kangiBox!.isEmpty) {
      print("kangiBox is empty");
      addKangiAll();
    }
    print(_kangiBox!.toMap());

    return _kangiBox!.toMap();
  }

  void addKangiAll() async {
    KangiNetwork(Api.getKangisAll).getKangisAll(http.Client()).then((value) {
      for (var kangi in value) {
        _kangiBox!.put(kangi.id, kangi);
      }
    });
  }

  void deleteKangisAll() {
    print('_kangiBox!.deleteFromDisk()');
    _kangiBox!.deleteFromDisk();
  }

  List<Kangi> getKangiByLevel(String level) {
    return _kangiBox!.values.where((kangi) => kangi.level == level).toList();
  }

// Progreesing

  void changeStepByLevel(int level, int step, int currentStep) {
    Progressing progressing = _jlptProgressing!.get(level.toString())!;
    progressing.step[step] = currentStep;
    progressing.save();
  }

  void completePart(int level, int step) {
    Progressing progressing = _jlptProgressing!.get(level.toString())!;
    progressing.is_step_complete[step - 1] = true;
    progressing.save();
  }

  Map getProgressingAll() {
    if (_jlptProgressing!.isEmpty) {
      print("_init_processing()");
      _init_processing();
    }

    print('_jlptProgressing!.toMap() : ${_jlptProgressing!.toMap()}');

    return _jlptProgressing!.toMap();
  }

  void _init_processing() {
    for (int i = 1; i <= 5; i++) {
      _jlptProgressing!.put(i.toString(), Progressing());
    }
  }

  void deleteProgressingAll() {
    print("deleteProgressingAll");
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
