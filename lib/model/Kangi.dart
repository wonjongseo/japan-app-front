import 'package:hive/hive.dart';

// part 'kangi.g.dart';
part 'Kangi.g.dart';

@HiveType(typeId: 0)
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

  const Kangi({
    required this.japan,
    required this.korea,
    required this.undoc,
    required this.hundoc,
    required this.id,
  });

  factory Kangi.fromJson(Map<String, dynamic> json) {
    return Kangi(
        japan: json['kangi'],
        korea: json['mean'],
        undoc: json['undoc'],
        hundoc: json['hundoc'],
        id: json['id']);
  }
  Map<String, dynamic> toMap() {
    return {
      'japan': japan,
      'korea': korea,
      'undoc': undoc,
      'hundoc': hundoc,
      'id': id
    };
  }
}
