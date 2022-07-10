import 'package:hive/hive.dart';
import 'package:japan_front/constants/service_constants.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

part 'Progressing.g.dart';

@HiveType(typeId: progressHiveType)
class Progressing {
  @HiveField(0)
  int? level;
  @HiveField(1)
  List? step;

  @HiveField(2)
  int? step_range;

  @HiveField(3)
  bool is_level_complete = false;

  @HiveField(4)
  bool is_step_complete = false;

  Progressing({this.level, this.step, this.step_range});

  Map<String, dynamic> toMap() {
    return {
      'level': level,
      'step': step,
      'step_range': step_range,
      'is_level_complete': is_level_complete,
      'is_step_complete': is_step_complete
    };
  }
}


/*

*/