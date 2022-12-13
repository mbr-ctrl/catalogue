import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Data {
  static getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var saveData = prefs.getString("catalogue");
    saveData ??= '[]';

    return json.decode(saveData);
  }

  static saveData(data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('catalogue', json.encode(data));
  }
}