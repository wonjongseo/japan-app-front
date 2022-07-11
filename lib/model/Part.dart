import 'package:hive_flutter/hive_flutter.dart';
import 'package:japan_front/constants/service_constants.dart';
import 'package:japan_front/model/Kangi.dart';

part 'Part.g.dart';

@HiveType(typeId: partHiveType)
class Part {
  @HiveField(0)
  List<Kangi>? kangis;

  @HiveField(1)
  bool complete = false;

  @HiveField(2)
  int last_index = 0;

  @HiveField(3)
  List<Kangi> restKangis = List.empty(growable: true);

  Part(this.kangis);

  @override
  String toString() {
    return '''
Part(kangis: ${kangis!.length}, last_index $last_index restKangis: $restKangis)''';
  }
}
