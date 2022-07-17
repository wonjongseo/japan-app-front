import 'package:hive_flutter/hive_flutter.dart';
import 'package:japan_front/constants/service_constants.dart';
import 'package:japan_front/model/Kangi.dart';
import 'package:japan_front/model/Part.dart';

part 'Level.g.dart';

@HiveType(typeId: levelHiveType)
class Level extends HiveObject {
  @HiveField(0)
  List<Part>? parts;

  @HiveField(1)
  int? totalCnt;

  @HiveField(2)
  bool complete = false;

  @HiveField(3)
  int lastIndex = 0;

  Level(this.parts, this.totalCnt);

  @override
  String toString() {
    return '''
Level(parts: ${parts},lastIndex $lastIndex, totalCnt $totalCnt complete: $complete)''';
  }
}
