import 'package:hive/hive.dart';
import 'package:japan_front/api/api.dart';
import 'package:japan_front/api/kangiNetwork.dart';
import 'package:japan_front/constants/service_constants.dart';
import 'package:japan_front/model/Kangi.dart';
import 'package:japan_front/model/Level.dart';
import 'package:japan_front/model/Part.dart';
import 'package:japan_front/model/Progressing.dart';
import 'package:http/http.dart' as http;

class HiveDB {
  static Box<Map>? _box;
  static Box<Kangi>? _kangiBox;
  static Box<String>? _likedBox;
  static Box<Progressing>? _progressingBox;
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
    Hive.registerAdapter(ProgressingAdapter());
    Hive.registerAdapter(KangiAdapter());
    Hive.registerAdapter(PartAdapter());
    Hive.registerAdapter(LevelAdapter());

    _kangiBox = await Hive.openBox(kangiHiveDB);
    _progressingBox = await Hive.openBox(progressHiveDB);
    _levelBox = await Hive.openBox(levelHiveDB);
    _partBox = await Hive.openBox(partHiveDB);
  }

  void getLevelsData() {
    if (_levelBox!.isEmpty) {
      addLevelsData();
    }
    plz();
  }

  void deleteAll() {
    print('deleteALl !');
    _levelBox!.deleteFromDisk();
    _partBox!.deleteFromDisk();
  }

  void plz() async {
    List<Kangi> levelOne = List.empty(growable: true);
    List<Kangi> levelTwo = List.empty(growable: true);
    List<Kangi> levelThree = List.empty(growable: true);
    List<Kangi> levelFour = List.empty(growable: true);
    List<Kangi> levelFive = List.empty(growable: true);

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

    _partBox!.put(1, Part(levelOne));
    _partBox!.put(2, Part(levelTwo));
    _partBox!.put(3, Part(levelThree));
    _partBox!.put(4, Part(levelFour));
    _partBox!.put(5, Part(levelFive));

    print(_partBox!.values);

    levelOne.clear();
    levelTwo.clear();
    levelThree.clear();
    levelFour.clear();
    levelFive.clear();
  }

/*
*/
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

    List<int> totalCounts = List.filled(5, 0);
    await KangiNetwork(Api.getKangisAll)
        .getKangisAll(http.Client())
        .then((kangis) {
      for (Kangi kangi in kangis) {
        switch (kangi.level) {
          case "1":
            levelOne.add(kangi);
            totalCounts[0]++;
            if (totalCounts[0] % 15 == 0) {
              levelOnePart.add(Part(levelOne));
              levelOne.clear();
            }
            break;
          case "2":
            totalCounts[1]++;
            levelTwo.add(kangi);
            if (levelTwo.length == 15) {
              levelTwoPart.add(Part(levelTwo));
              levelTwo.clear();
            }
            break;
          case "3":
            levelThree.add(kangi);
            totalCounts[2]++;
            if (levelThree.length == 15) {
              levelThreePart.add(Part(levelThree));
              levelThree.clear();
            }
            break;
          case "4":
            levelFour.add(kangi);
            totalCounts[3]++;
            if (levelFour.length == 15) {
              levelFourPart.add(Part(levelFour));
              levelFour.clear();
            }
            break;
          case "5":
            levelFive.add(kangi);
            totalCounts[4]++;
            if (levelFive.length == 15) {
              levelFivePart.add(Part(levelFive));
              levelFive.clear();
            }
            break;
        }
      }
    });

    if (levelOne.isNotEmpty) {
      levelOnePart.add(Part(levelOne));
      // levelOne.clear();
    }
    if (levelTwo.isNotEmpty) {
      levelTwoPart.add(Part(levelTwo));
      // levelTwo.clear();
    }
    if (levelThree.isNotEmpty) {
      levelThreePart.add(Part(levelThree));
      // levelThree.clear();
    }
    if (levelFour.isNotEmpty) {
      levelFourPart.add(Part(levelFour));
      // levelFour.clear();
    }
    if (levelFive.isNotEmpty) {
      levelFivePart.add(Part(levelFive));
      // levelFive.clear();
    }
    _levelBox!.put(1, Level(levelOnePart, totalCounts[0]));
    _levelBox!.put(2, Level(levelTwoPart, totalCounts[1]));
    _levelBox!.put(3, Level(levelThreePart, totalCounts[2]));
    _levelBox!.put(4, Level(levelFivePart, totalCounts[3]));
    _levelBox!.put(5, Level(levelFivePart, totalCounts[4]));

    // levelOnePart.clear();
    // levelTwoPart.clear();
    // levelThreePart.clear();
    // levelFivePart.clear();
    // levelFivePart.clear();

    print(_levelBox!.values);
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
    Progressing progressing = _progressingBox!.get(level.toString())!;
    progressing.step[step] = currentStep;
    progressing.save();
  }

  void completePart(int level, int step) {
    Progressing progressing = _progressingBox!.get(level.toString())!;
    progressing.is_step_complete[step - 1] = true;
    progressing.save();
  }

  Map getProgressingAll() {
    if (_progressingBox!.isEmpty) {
      _init_processing();
    }

    return _progressingBox!.toMap();
  }

  void _init_processing() {
    for (int i = 1; i <= 5; i++) {
      _progressingBox!.put(i.toString(), Progressing());
    }
  }

  void deleteProgressingAll() {
    print("deleteProgressingAll");
    _progressingBox!.deleteFromDisk();
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
