import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:japan_front/api/api.dart';
import 'package:japan_front/model/Kangi.dart';
import 'package:http/http.dart' as http;

class WordNetwork {
  final String url;
  WordNetwork(this.url);

  Future<List<Kangi>> getKangisAll(http.Client client) async {
    String newUrl = this.url;

    var url = Uri.parse(newUrl);
    print(url);
    var response = await client.get(url);

    if (response.statusCode == 200) {
      return compute(kangiJsonToList, response.body);
    } else {
      throw Exception("Failed to load Kangi");
    }
  }

  Future<List<Kangi>> getKangisByLevel(http.Client client, String n) async {
    String newUrl = this.url + "?n=" + n;

    var url = Uri.parse(newUrl);
    var response = await client.get(url);

    if (response.statusCode == 200) {
      return compute(kangiJsonToList, response.body);
    } else {
      throw Exception("Failed to load Kangi");
    }
  }

  Future<List<Kangi>> getKangiByLevel(
      http.Client client, String n, int? step) async {
    String newUrl = this.url + "?n=" + n + "&step=" + step.toString();

    var url = Uri.parse(newUrl);
    var response = await client.get(url);

    if (response.statusCode == 200) {
      return compute(kangiJsonToList, response.body);
    } else {
      throw Exception("Failed to load Kangi");
    }
  }

  List<Kangi> kangiJsonToList(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Kangi>((json) => Kangi.fromJson(json)).toList();
  }
}
