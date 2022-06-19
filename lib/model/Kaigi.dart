import 'dart:convert';

class Kangi {
  final String japan;
  final String korea;
  final String undoc;
  final String hundoc;
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
}
