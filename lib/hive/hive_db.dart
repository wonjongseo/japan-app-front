import 'package:hive/hive.dart';
import 'package:japan_front/api/api.dart';
import 'package:japan_front/api/kangiNetwork.dart';
import 'package:japan_front/constants/service_constants.dart';
import 'package:japan_front/model/Kangi.dart';
import 'package:japan_front/model/Level.dart';
import 'package:japan_front/model/Part.dart';
import 'package:http/http.dart' as http;

class HiveDB {
  static Box<Map>? _box;
  static Box<List<Kangi>>? _kangiBox;
  static Box<String>? _likedBox;
  static Box<Level>? _levelBox;
  static Box<Part>? _partBox;
  static HiveDB? _instance;

  static HiveDB get instance {
    if (_instance == null) {
      _instance = HiveDB();
    }
    return _instance!;
  }

  static Future<void> init() async {
    Hive.registerAdapter(KangiAdapter());
    Hive.registerAdapter(PartAdapter());
    Hive.registerAdapter(LevelAdapter());

    _kangiBox = await Hive.openBox(kangiHiveDB);
    _levelBox = await Hive.openBox(levelHiveDB);
    _partBox = await Hive.openBox(partHiveDB);
  }

// Kangis

  void saveKangis(String key, List<Kangi> kangis) {
    if (_kangiBox!.get(key) == null) {
      _kangiBox!.put(key, []);
    }
    _kangiBox!.get(key)!.addAll(kangis);
  }

  List<Kangi>? getKangis(String key) {
    return _kangiBox!.get(key);
  }

  Map getLevelsData() {
    if (_levelBox!.isEmpty) {
      addLevelsData();
    }
    return _levelBox!.toMap();
  }

  void deleteAll() {
    print('deleteALl !');
    _levelBox!.deleteFromDisk();
    _partBox!.deleteFromDisk();
  }

  void updateLastIndet(int level, int step) {
    Level changedLevel = _levelBox!.get(level)!;
    List<bool> ok = List.filled(2, false);

    if (changedLevel.parts![step].last_index <
        changedLevel.parts![step].kangis!.length) {
      changedLevel.parts?[step].last_index++;
      ok[0] = true;
    }
    // changedLevel.lastIndex++;
    if (changedLevel.lastIndex < changedLevel.totalCnt!) {
      changedLevel.lastIndex++;
      ok[1] = true;
    }
    // changedLevel.save();
    if (ok[0] == true || ok[1] == true) changedLevel.save();
  }

  void addLevelsData() async {
    List<Kangi> levelOne = List.empty(growable: true);
    List<Kangi> levelTwo = List.empty(growable: true);
    List<Kangi> levelThree = List.empty(growable: true);
    List<Kangi> levelFour = List.empty(growable: true);
    List<Kangi> levelFive = List.empty(growable: true);

    List<Part> levelOnePart = List.empty(growable: true);
    List<Part> levelTwoPart = List.empty(growable: true);
    List<Part> levelThreePart = List.empty(growable: true);
    List<Part> levelFourPart = List.empty(growable: true);
    List<Part> levelFivePart = List.empty(growable: true);

    await KangiNetwork(Api.getKangisByJlptLevel)
        .getKangisByLevel(http.Client(), 1)
        .then((value) => levelOne.addAll(value));

    await KangiNetwork(Api.getKangisByJlptLevel)
        .getKangisByLevel(http.Client(), 2)
        .then((value) => levelTwo.addAll(value));
    await KangiNetwork(Api.getKangisByJlptLevel)
        .getKangisByLevel(http.Client(), 3)
        .then((value) => levelThree.addAll(value));
    await KangiNetwork(Api.getKangisByJlptLevel)
        .getKangisByLevel(http.Client(), 4)
        .then((value) => levelFour.addAll(value));

    await KangiNetwork(Api.getKangisByJlptLevel)
        .getKangisByLevel(http.Client(), 5)
        .then((value) => levelFive.addAll(value));

    List<int> temp = List.filled(5, 0);
    print(levelOne.sublist(1 * 15, 1 * 15 + 15).length);
    for (int i = 0; i < levelOne.length; i += 15) {
      if (i + 15 < levelOne.length) {
        temp[0]++;
        levelOnePart.add(Part(levelOne.sublist(i, i + 15)));
      }
    }
    if (temp[0] != 0) {
      levelOnePart.add(Part(levelOne.sublist(temp[0] * 15)));
    }

    for (int i = 0; i < levelTwo.length; i += 15) {
      if (i + 15 < levelTwo.length) {
        temp[1]++;
        levelTwoPart.add(Part(levelTwo.sublist(i, i + 15)));
      }
    }

    if (temp[1] != 0) {
      levelTwoPart.add(Part(levelTwo.sublist(temp[1] * 15)));
    }
    for (int i = 0; i < levelThree.length; i += 15) {
      if (i + 15 < levelThree.length) {
        temp[2]++;
        levelThreePart.add(Part(levelThree.sublist(i, i + 15)));
      }
    }
    if (temp[2] != 0) {
      levelThreePart.add(Part(levelThree.sublist(temp[2] * 15)));
    }

    for (int i = 0; i < levelFour.length; i += 15) {
      if (i + 15 < levelFour.length) {
        temp[3]++;
        levelFourPart.add(Part(levelFour.sublist(i, i + 15)));
      }
    }

    if (temp[3] != 0) {
      levelFourPart.add(Part(levelFour.sublist(temp[3] * 15)));
    }
    for (int i = 0; i < levelFive.length; i += 15) {
      if (i + 15 < levelFive.length) {
        temp[4]++;
        levelFivePart.add(Part(levelFive.sublist(i, i + 15)));
      }
    }

    if (temp[4] != 0) {
      levelFivePart.add(Part(levelFive.sublist(temp[4] * 15)));
    }

    _levelBox!.put(1, Level(levelOnePart, levelOne.length));
    _levelBox!.put(2, Level(levelTwoPart, levelTwo.length));
    _levelBox!.put(3, Level(levelThreePart, levelThree.length));
    _levelBox!.put(4, Level(levelFourPart, levelFour.length));
    _levelBox!.put(5, Level(levelFivePart, levelFive.length));

    print(_levelBox!.values);
  }

/*
*/
// Kangis
  Map getKangiAll() {
    if (_kangiBox!.isEmpty) {
      print("kangiBox is empty");
    }
    print(_kangiBox!.toMap());

    return _kangiBox!.toMap();
  }

  void deleteKangisAll() {
    print('_kangiBox!.deleteFromDisk()');
    _kangiBox!.deleteFromDisk();
  }

  List<Kangi>? getKangiByLevel(String level) {
    // return _kangiBox!.values.where((kangi) => kangi.level == level).toList();
    return null;
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
