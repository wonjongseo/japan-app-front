import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:japan_front/model/Kaigi.dart';

class Network {
  String url;
  Network(this.url);

  Future<List<Kangi>> fetchData(http.Client client, int page) async {
    String newUrl = this.url + "?n=" + page.toString();
    print(newUrl);
    var url = Uri.parse(newUrl);
    var response = await client.get(url);

    print(response.body);
    if (response.statusCode == 200) {
      return compute(parseKangis, response.body);
    } else {
      throw Exception("Failed to load Kangi");
    }
  }

  List<Kangi> parseKangis(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Kangi>((json) => Kangi.fromJson(json)).toList();
  }
}
