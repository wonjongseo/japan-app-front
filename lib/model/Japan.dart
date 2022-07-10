import 'dart:convert';

import 'package:hive/hive.dart';

class Japan {
  final String japan;
  final String korea;
  final String yomikata;
  const Japan({
    required this.japan,
    required this.korea,
    required this.yomikata,
  });

  factory Japan.fromJson(Map<String, dynamic> json) {
    return Japan(
        japan: json['kangi'], korea: json['mean'], yomikata: json['yomikata']);
  }
}
