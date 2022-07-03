import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:japan_front/model/Kaigi.dart';
import 'package:http/http.dart' as http;

class KangiNetwork {
  final String url;
  KangiNetwork(this.url);

  Future<List<Kangi>> getKangisByLevel(
      http.Client client, int n, int? step) async {
    String newUrl =
        this.url + "?n=" + n.toString() + "&step=" + step.toString();

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