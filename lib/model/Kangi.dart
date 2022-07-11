import 'package:hive/hive.dart';
import 'package:japan_front/constants/service_constants.dart';

// part 'kangi.g.dart';
part 'Kangi.g.dart';

@HiveType(typeId: kangiHiveType)
class Kangi {
  @HiveField(0)
  final String japan;
  @HiveField(1)
  final String korea;
  @HiveField(2)
  final String undoc;
  @HiveField(3)
  final String hundoc;
  @HiveField(4)
  final String id;

  @HiveField(5)
  final String level;

  const Kangi(
      {required this.japan,
      required this.korea,
      required this.undoc,
      required this.hundoc,
      required this.id,
      required this.level});

  factory Kangi.fromJson(Map<String, dynamic> json) {
    return Kangi(
        japan: json['kangi'],
        korea: json['mean'],
        undoc: json['undoc'],
        hundoc: json['hundoc'],
        id: json['id'],
        level: json['level']);
  }
  Map<String, dynamic> toMap() {
    return {
      'japan': japan,
      'level': level,
      'korea': korea,
      'undoc': undoc,
      'hundoc': hundoc,
      'id': id
    };
  }

  List<Object> get props {
    return [japan, korea, undoc, hundoc, level, id];
  }

  @override
  String toString() {
    return '''
Kangi(japan: $japan, level $level korea: $korea, undoc: $undoc, hundoc: $hundoc, id: $id)''';
  }
}

/*

import 'package:hive/hive.dart';
import 'package:japan_front/constants/service_constants.dart';

// part 'kangi.g.dart';
part 'Kangi.g.dart';

@HiveType(typeId: kangiHiveType)
class Kangi {
  @HiveField(0)
  final String japan;
  @HiveField(1)
  final String korea;
  @HiveField(2)
  final String undoc;
  @HiveField(3)
  final String hundoc;
  @HiveField(4)
  final String id;

  @HiveField(5)
  final int level;

  const Kangi(
      {required this.japan,
      required this.korea,
      required this.undoc,
      required this.hundoc,
      required this.id,
      required this.level});

  factory Kangi.fromJson(Map<String, dynamic> json) {
    return Kangi(
        japan: json['kangi'],
        korea: json['mean'],
        undoc: json['undoc'],
        hundoc: json['hundoc'],
        id: json['id'],
        level: json['level']);
  }
  Map<String, dynamic> toMap() {
    return {
      'japan': japan,
      'level': level,
      'korea': korea,
      'undoc': undoc,
      'hundoc': hundoc,
      'id': id
    };
  }

  List<Object> get props {
    return [japan, korea, undoc, hundoc, level, id];
  }

  @override
  String toString() {
    return '''
Kangi(japan: $japan, level $level korea: $korea, undoc: $undoc, hundoc: $hundoc, id: $id)''';
  }
}




*/