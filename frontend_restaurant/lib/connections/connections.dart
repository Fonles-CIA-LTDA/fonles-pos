import 'dart:convert';

import 'package:frontend/config/exports.dart';
import 'package:frontend/main.dart';
import 'package:http/http.dart' as http;

class Connections {
  String server = "${config.server}${config.port}";
  Future<bool> login({identifier, password}) async {
    try {
      var request = await http.post(Uri.parse("$server/api/auth/local"), body: {
        "identifier": identifier,
        "password": password,
      });
      var response = await request.body;
      var decodeData = json.decode(response);
      if (request.statusCode != 200) {
        return false;
      } else {
        sharedPreferencesGeneral!
            .setString("username", decodeData['user']['username']);
        sharedPreferencesGeneral!
            .setString("id", decodeData['user']['id'].toString());
        sharedPreferencesGeneral!
            .setString("jwt", decodeData['jwt'].toString());

        return true;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
}
