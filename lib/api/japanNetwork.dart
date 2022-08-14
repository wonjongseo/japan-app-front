import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:japan_front/model/Japan.dart';
import 'package:http/http.dart' as http;

class JapanNetwork {
  final String url;
  JapanNetwork(this.url);

  Future<List<Japan>> getJapansByKangiId(http.Client client, String id) async {
    String newUrl = this.url + "/" + id;

    var url = Uri.parse(newUrl);
    var response = await client.get(url);

    if (response.statusCode == 200) {
      return compute(japanJsonToList, response.body);
    } else {
      throw Exception("Failed to load Kangi");
    }
  }

  List<Japan> japanJsonToList(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Japan>((json) => Japan.fromJson(json)).toList();
  }
}
