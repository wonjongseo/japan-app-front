import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:japan_front/model/Japan.dart';
import 'package:japan_front/model/Kangi.dart';

class Network {
  String url;
  Network(this.url);

  // Future<List<Kangi>> fetchKangiLevelByStep(
  //     http.Client client, int page, int? step) async {
  //   String newUrl =
  //       this.url + "?n=" + page.toString() + "&step=" + step.toString();

  //   var url = Uri.parse(newUrl);
  //   var response = await client.get(url);

  //   if (response.statusCode == 200) {
  //     return compute(parseKangis, response.body);
  //   } else {
  //     throw Exception("Failed to load Kangi");
  //   }
  // }

  List<Kangi> parseKangis(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Kangi>((json) => Kangi.fromJson(json)).toList();
  }

  Future<List<Japan>> getJapansByKangiId(http.Client client, String id) async {
    String newUrl = this.url + "/" + id;

    var url = Uri.parse(newUrl);
    var response = await client.get(url);

    if (response.statusCode == 200) {
      return compute(parseJapans, response.body);
    } else {
      throw Exception("Failed to load Kangi");
    }
  }

  List<Japan> parseJapans(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Japan>((json) => Japan.fromJson(json)).toList();
  }
}
