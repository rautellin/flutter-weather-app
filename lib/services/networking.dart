import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  String url;

  NetworkHelper({@required this.url});

  Future getData() async {
    Uri uri = Uri.parse(url);
    http.Response response = await http.get(uri);

    if (response.statusCode == 200) {
      String json = response.body;
      return jsonDecode(json);
    } else {
      print(response.statusCode);
    }
  }
}
