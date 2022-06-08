import 'dart:convert';

class Kangi {
  final String japan;
  final String korea;
  final String undoc;
  final String hundoc;

  const Kangi({
    required this.japan,
    required this.korea,
    required this.undoc,
    required this.hundoc,
  });

  factory Kangi.fromJson(Map<String, dynamic> json) {
    return Kangi(
        japan: json['japan'],
        korea: json['korea'],
        undoc: json['undoc'],
        hundoc: json['hundoc']);
  }
}
