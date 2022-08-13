import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:japan_front/api/api.dart';
import 'package:japan_front/model/Kangi.dart';

class WordNetworkTest {
  Future<dynamic> getWords(http.Client client, String firstName) async {
    String newUrl = Api.getWords + "?firstWord=" + firstName;

    var url = Uri.parse(newUrl);

    print(url);

    var response = await client.get(url);

    if (response.statusCode == 200) {
      // print(response.body);

      return compute(getWordsList, response.body);
    }
  }

  List<Kangi> getWordsList(String body) {
    final parsed = json.decode(body).cast<Map<String, dynamic>>();
    return parsed.map<Kangi>((json) => Kangi.fromJson(json)).toList();
  }
}

// words?firstWord=ga