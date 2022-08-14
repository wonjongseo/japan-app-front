import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:japan_front/api/api.dart';
import 'package:japan_front/model/Kangi.dart';

class WordNetwork {
  Future<List<Kangi>> getWords(http.Client client, String firstName) async {
    String newUrl = Api.getWords + "?firstWord=" + firstName;
    print(newUrl);
    var url = Uri.parse(newUrl);

    var response = await client.get(url);

    if (response.statusCode == 200) {
      return compute(getWordsList, response.body);
    } else {
      throw Exception("Failed to load Kangi");
    }
  }

  Future<List<Kangi>> getKangisByLevel(http.Client client, String n) async {
    String newUrl = Api.getWordsByJlptLevel + "?n=" + n;
    print(newUrl);
    var url = Uri.parse(newUrl);
    var response = await client.get(url);

    if (response.statusCode == 200) {
      return compute(getWordsList, response.body);
    } else {
      throw Exception("Failed to load Kangi");
    }
  }

  List<Kangi> getWordsList(String body) {
    final parsed = json.decode(body).cast<Map<String, dynamic>>();
    return parsed.map<Kangi>((json) => Kangi.fromJson(json)).toList();
  }
}

// words?firstWord=ga