import 'package:hive/hive.dart';
import 'package:japan_front/constants/service_constants.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

part 'Progressing.g.dart';

@HiveType(typeId: progressHiveType)
class Progressing extends HiveObject {
  @HiveField(1)
  List<int> step = List.filled(10, 0);

  @HiveField(2)
  bool is_level_complete = false;

  @HiveField(4)
  List<bool> is_step_complete = List.filled(10, false);

  Map<String, dynamic> toMap() {
    return {
      'step': step,
      'is_level_complete': is_level_complete,
      'is_step_complete': is_step_complete
    };
  }

  @override
  String toString() {
    return '''
Progressing( step $step is_step_complete $is_step_complete )''';
  }
}


/*

*/